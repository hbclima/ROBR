--[[
    AISystem.lua (versão compatível com MobPlaceholderFactory)
    Sistema de IA dos monstros — patrulha, aggro, fuga, leashing.
    
    Destino: ServerScriptService/Modules/AISystem
    
    Compatível com:
    - MobPlaceholderFactory (modelos em ReplicatedStorage/Mobs/)
    - SpawnSystem (Fase 3)
    - MobsConfig (ReplicatedStorage.Modules.Config.MobsConfig)
    
    Se MobsConfig não existir, usa dados internos.
    
    Última atualização: 2026-06-12
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")

local AISystem = {}

-------------------------------------------------------------------------------
--- ESTADO INTERNO
-------------------------------------------------------------------------------

local mobsAtivos = {}     -- [mobModel] = mobTable
local jogadoresPorMapa = {} -- [mapaId] = {player1, player2, ...}

-------------------------------------------------------------------------------
--- CONFIGURAÇÃO DE AGGRO POR RARIDADE
-------------------------------------------------------------------------------

local AGGRO_RANGE = {
    ["comum"]   = 12,
    ["incomum"] = 14,
    ["raro"]    = 16,
    ["elite"]   = 20,
    ["chefe"]   = 30,
}

local FLEE_HP_THRESHOLD = 0.2  -- 20% HP para mobs passivos fugirem
local LEASH_RANGE = 40          -- studs máximo antes de retornar à base
local PATROL_RADIUS = 10        -- raio de patrulha em torno do spawn

-------------------------------------------------------------------------------
--- TENTAR CARREGAR MOBSCONFIG
-------------------------------------------------------------------------------

local MobsConfig = nil
local ok, result = pcall(function()
    return require(ReplicatedStorage.Modules.Config.MobsConfig)
end)
if ok then
    MobsConfig = result
end

-------------------------------------------------------------------------------
--- CRIAR MOB (chamado pelo SpawnSystem)
-------------------------------------------------------------------------------

--- Cria um mob no mundo a partir do placeholder em ReplicatedStorage/Mobs/.
--- @param mobId string — ID do mob (ex: "MOB_001")
--- @param pos Vector3 — posição inicial
--- @return table|nil — tabela do mob ou nil se falhar
function AISystem.CreateMob(mobId, pos)
    -- Buscar placeholder em ReplicatedStorage/Mobs/
    local mobsFolder = ReplicatedStorage:FindFirstChild("Mobs")
    if not mobsFolder then
        warn("[AISystem] Pasta ReplicatedStorage/Mobs/ não encontrada. Execute MobPlaceholderFactory.CreateAll() primeiro.")
        return nil
    end

    local template = mobsFolder:FindFirstChild(mobId)
    if not template then
        warn("[AISystem] Mob template não encontrado: " .. mobId)
        return nil
    end

    -- Clonar o modelo
    local model = template:Clone()
    model.Name = mobId .. "_" .. tostring(math.random(1000, 9999))

    -- Posicionar
    local hrp = model:FindFirstChild("HumanoidRootPart")
    if hrp then
        model:PivotTo(CFrame.new(pos))
    end

    -- Buscar dados do mob
    local nome = model:GetAttribute("Nome") or mobId
    local nivel = model:GetAttribute("Nivel") or 1
    local elemento = model:GetAttribute("Elemento") or "neutro"
    local raridade = model:GetAttribute("Raridade") or "comum"

    -- Buscar HP do MobsConfig ou usar fallback
    local hpMax = 100 + (nivel * 50)
    if MobsConfig and MobsConfig.GetMob then
        local config = MobsConfig.GetMob(mobId)
        if config and config.hp then
            hpMax = config.hp
        end
    end

    -- Configurar Humanoid
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.MaxHealth = hpMax
        humanoid.Health = hpMax
        humanoid.WalkSpeed = 8 + (nivel * 0.5)
    end

    -- Criar tabela do mob (compatível com SpawnSystem)
    local mobTable = {
        id = mobId,
        nome = nome,
        nivel = nivel,
        elemento = elemento,
        raridade = raridade,
        model = model,
        hp = hpMax,
        hpMax = hpMax,
        estado = "idle",       -- idle, patrol, aggro, flee, dead
        alvo = nil,
        posicao = pos,
        posicaoOriginal = pos,
        aggroRange = AGGRO_RANGE[raridade] or 12,
        respawnTime = 30,
        mapa = nil,            -- preenchido pelo SpawnSystem
        zonaSpawn = nil,       -- preenchido pelo SpawnSystem
    }

    -- Conectar evento de morte
    if humanoid then
        humanoid.Died:Connect(function()
            AISystem.OnMobDeath(mobTable)
        end)
    end

    -- Inserir no Workspace
    local mapasFolder = workspace:FindFirstChild("Mapas")
    if mapasFolder then
        -- Tentar colocar na pasta do mapa corrente
        local mapaFolder = mapasFolder:FindFirstChild(mobTable.mapa or "")
        if mapaFolder then
            model.Parent = mapaFolder
        else
            model.Parent = mapasFolder
        end
    else
        model.Parent = workspace
    end

    -- Registrar
    mobsAtivos[model] = mobTable

    print("[AISystem] Mob criado: " .. nome .. " (" .. mobId .. ") em " .. tostring(pos))
    return mobTable
end

-------------------------------------------------------------------------------
--- EVENTO DE MORTE
-------------------------------------------------------------------------------

function AISystem.OnMobDeath(mobTable)
    mobTable.estado = "dead"
    mobTable.alvo = nil

    -- Esconder modelo
    if mobTable.model and mobTable.model.Parent then
        mobTable.model.Parent = nil
    end

    -- Notificar SpawnSystem (se disponível)
    local spawnSystem = script.Parent:FindFirstChild("SpawnSystem")
    if spawnSystem then
        -- SpawnSystem vai detectar via MarcarMorto
    end

    print("[AISystem] " .. (mobTable.nome or mobTable.id) .. " morreu.")
end

-------------------------------------------------------------------------------
--- LOOP DE IA (chamado pelo ServerMain via Heartbeat)
-------------------------------------------------------------------------------

--- Atualiza a IA de todos os mobs de um mapa específico.
--- @param mapaId string — ID do mapa
--- @param jogadores {Player} — jogadores presentes no mapa
function AISystem.UpdateMapa(mapaId, jogadores)
    for model, mob in pairs(mobsAtivos) do
        if mob.mapa == mapaId and mob.estado ~= "dead" then
            AISystem.UpdateMob(mob, jogadores)
        end
    end
end

--- Atualiza a IA de um mob individual.
--- @param mob table — tabela do mob
--- @param jogadores {Player} — jogadores próximos
function AISystem.UpdateMob(mob, jogadores)
    if not mob.model or not mob.model.Parent then return end
    if mob.estado == "dead" then return end

    local hrp = mob.model:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local posAtual = hrp.Position

    -- Verificar leashing (muito longe do spawn)
    if mob.posicaoOriginal then
        local distSpawn = (posAtual - mob.posicaoOriginal).Magnitude
        if distSpawn > LEASH_RANGE then
            mob.estado = "return"
            AISystem.LeashReturn(mob)
            return
        end
    end

    -- Buscar jogador mais próximo no aggro range
    local alvoMaisProximo = nil
    local distMinima = mob.aggroRange

    for _, player in ipairs(jogadores) do
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local dist = (char.HumanoidRootPart.Position - posAtual).Magnitude
            if dist < distMinima then
                distMinima = dist
                alvoMaisProximo = player
            end
        end
    end

    if alvoMaisProximo then
        -- Aggro!
        mob.estado = "aggro"
        mob.alvo = alvoMaisProximo
        AISystem.AggroBehavior(mob, alvoMaisProximo)
    else
        -- Sem alvo — patrulha
        if mob.estado ~= "patrol" then
            mob.estado = "patrol"
            mob.alvo = nil
        end
        AISystem.PatrolBehavior(mob)
    end
end

-------------------------------------------------------------------------------
--- COMPORTAMENTOS
-------------------------------------------------------------------------------

--- Comportamento de aggro: perseguir e atacar o alvo.
function AISystem.AggroBehavior(mob, alvo)
    local humanoid = mob.model:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local char = alvo.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local alvoPos = char.HumanoidRootPart.Position
    humanoid:MoveTo(alvoPos)

    -- Atacar se perto o suficiente (3 studs)
    local hrp = mob.model:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (hrp.Position - alvoPos).Magnitude
        if dist < 3 then
            -- Aplicar dano (simplificado — CombatManager valida)
            local charHumanoid = char:FindFirstChildOfClass("Humanoid")
            if charHumanoid then
                local dano = 5 + (mob.nivel * 2)
                charHumanoid:TakeDamage(dano)
            end
        end
    end
end

--- Comportamento de patrulha: andar aleatoriamente em torno do spawn.
function AISystem.PatrolBehavior(mob)
    local humanoid = mob.model:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    -- Mover para posição aleatória perto do spawn
    if mob.posicaoOriginal then
        local offsetX = math.random(-PATROL_RADIUS, PATROL_RADIUS)
        local offsetZ = math.random(-PATROL_RADIUS, PATROL_RADIUS)
        local targetPos = mob.posicaoOriginal + Vector3.new(offsetX, 0, offsetZ)
        humanoid:MoveTo(targetPos)
    end
end

--- Comportamento de leashing: retornar ao ponto de spawn.
function AISystem.LeashReturn(mob)
    local humanoid = mob.model:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if mob.posicaoOriginal then
        humanoid:MoveTo(mob.posicaoOriginal)
    end

    -- Regenerar HP durante retorno
    local charHumanoid = mob.model:FindFirstChildOfClass("Humanoid")
    if charHumanoid and charHumanoid.Health < charHumanoid.MaxHealth then
        charHumanoid.Health = math.min(charHumanoid.MaxHealth, charHumanoid.Health + 5)
    end
end

-------------------------------------------------------------------------------
--- CONSULTAS
-------------------------------------------------------------------------------

--- Retorna todos os mobs ativos (vivos).
function AISystem.GetMobsAtivos()
    local vivos = {}
    for model, mob in pairs(mobsAtivos) do
        if mob.estado ~= "dead" then
            table.insert(vivos, mob)
        end
    end
    return vivos
end

--- Retorna todos os mobs (incluindo mortos).
function AISystem.GetAllMobs()
    local todos = {}
    for model, mob in pairs(mobsAtivos) do
        table.insert(todos, mob)
    end
    return todos
end

--- Retorna mobs de um mapa específico.
function AISystem.GetMobsPorMapa(mapaId)
    local mobs = {}
    for model, mob in pairs(mobsAtivos) do
        if mob.mapa == mapaId then
            table.insert(mobs, mob)
        end
    end
    return mobs
end

return AISystem
