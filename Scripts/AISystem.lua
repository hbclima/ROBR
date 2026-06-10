-- AISystem.lua
-- Inteligência artificial dos mobs
-- NOTA: Este módulo roda APENAS no servidor (ServerScriptService)

local MobsConfig = require(game.ReplicatedStorage.Modules.Config.MobsConfig)
local DamageCalculator = require(game.ReplicatedStorage.Modules.Shared.DamageCalculator)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AISystem = {}

-- Estados de IA
local ESTADOS = {
    IDLE = "idle",
    PATROL = "patrol",
    AGGRO = "aggro",
    ATTACK = "attack",
    FLEE = "flee",
    RETORNO = "retorno",
    DEAD = "dead",
}

function AISystem.CreateMob(mobId, spawnPosition)
    local mobConfig = MobsConfig.GetMob(mobId)
    if not mobConfig then return nil end

    local uniqueId = mobId .. "_" .. tostring(math.random(10000, 99999))
    local mob = {
        id = uniqueId, -- ID único para esta instância
        configId = mobId, -- ID do config
        nome = mobConfig.nome,
        hp = mobConfig.hpMax,
        hpMax = mobConfig.hpMax,
        nivel = mobConfig.nivelMin + math.random(0, math.max(0, mobConfig.nivelMax - mobConfig.nivelMin)),
        ATK_base = mobConfig.ataqueBase,
        DEF_base = mobConfig.defesaBase,
        tipoDano = mobConfig.tipoDano or "fisico",
        comportamento = mobConfig.comportamento,
        aggroRange = mobConfig.aggroRange or 12,
        xpRecompensa = mobConfig.xpRecompensa,
        respawnTime = mobConfig.respawnSegundos,
        habilidades = mobConfig.habilidades or {},
        drops = mobConfig.drops or {},
        elemento = mobConfig.elemento or "neutro",
        estado = ESTADOS.IDLE,
        alvo = nil,
        posicao = spawnPosition,
        spawnPosition = spawnPosition,
        tempoUltimaAcao = 0,
        cooldowns = {},
        immune = false,
        frenesiVFXActive = false,
    }

    -- Gerar atributos baseados no nível (simplificado para MVP)
    mob.STR = math.floor(mobConfig.ataqueBase * 0.5)
    mob.VIT = math.floor(mobConfig.hpMax / 15)
    mob.INT = mobConfig.tipoDano == "magico" and math.floor(mobConfig.ataqueBase * 0.8) or 1
    mob.DEX = math.floor(mob.aggroRange / 2)
    mob.LUK = 1
    mob.AGI = 2

    -- Campos derivados para DamageCalculator (evita nil em cálculos)
    mob.MATK_base = mobConfig.tipoDano == "magico" and mobConfig.ataqueBase or 0
    mob.MDEF_base = math.floor(mobConfig.defesaBase * 0.5)

    -- Spawnar o modelo físico
    AISystem.SpawnPhysicalModel(mob)

    return mob
end

function AISystem.SpawnPhysicalModel(mob)
    if mob.model and mob.model.Parent then return mob.model end

    local model
    local mobsFolder = ReplicatedStorage:FindFirstChild("Mobs")
    local template = mobsFolder and mobsFolder:FindFirstChild(mob.configId)

    if template then
        -- 1. Clonar o placeholder do ReplicatedStorage
        model = template:Clone()
        model.Name = mob.nome
        model:SetAttribute("MobId", mob.id)

        -- Posicionar no spawn correto com elevação segura
        if model.PrimaryPart then
            model:PivotTo(CFrame.new(mob.posicao + Vector3.new(0, 1.5, 0)))
        end

        -- Configurar propriedades de vida do Humanoid
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = mob.hpMax
            humanoid.Health = mob.hp
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
        end
    else
        -- 2. Fallback procedimental legado (se o template não foi gerado)
        model = Instance.new("Model")
        model.Name = mob.nome
        model:SetAttribute("MobId", mob.id)

        -- Criar HumanoidRootPart
        local hrp = Instance.new("Part")
        hrp.Name = "HumanoidRootPart"
        hrp.Size = Vector3.new(2, 2, 2)
        hrp.Transparency = 1
        hrp.Anchored = false
        hrp.CanCollide = true
        hrp.CFrame = CFrame.new(mob.posicao + Vector3.new(0, 2, 0))
        hrp.Parent = model
        model.PrimaryPart = hrp

        -- Criar Humanoid
        local humanoid = Instance.new("Humanoid")
        humanoid.MaxHealth = mob.hpMax
        humanoid.Health = mob.hp
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
        humanoid.Parent = model

        -- Determinar cor por elemento/tipo
        local bodyColor = Color3.fromRGB(120, 120, 120)
        local element = mob.elemento or "neutro"
        if element == "agua" then
            bodyColor = Color3.fromRGB(0, 120, 255)
        elseif element == "fogo" then
            bodyColor = Color3.fromRGB(255, 60, 0)
        elseif element == "terra" then
            bodyColor = Color3.fromRGB(90, 180, 90)
        elseif element == "vento" or element == "vento corrompido" then
            bodyColor = Color3.fromRGB(200, 200, 250)
        elseif element == "sombra" then
            bodyColor = Color3.fromRGB(40, 20, 60)
        end

        -- Customizações visuais procedimentais simples
        if mob.configId == "MOB_006" then -- Saci Sombrio
            -- Torso roxo escuro
            local torso = Instance.new("Part")
            torso.Name = "Torso"
            torso.Size = Vector3.new(1.8, 1.8, 0.9)
            torso.Color = Color3.fromRGB(50, 20, 70)
            torso.Parent = model
            
            local weldTorso = Instance.new("WeldConstraint")
            weldTorso.Part0 = hrp
            weldTorso.Part1 = torso
            weldTorso.Parent = hrp
            torso.Position = hrp.Position

            -- Cabeça
            local head = Instance.new("Part")
            head.Name = "Head"
            head.Size = Vector3.new(1.2, 1.2, 1.2)
            head.Color = Color3.fromRGB(120, 80, 50)
            head.Parent = model
            
            local weldHead = Instance.new("WeldConstraint")
            weldHead.Part0 = torso
            weldHead.Part1 = head
            weldHead.Parent = torso
            head.Position = torso.Position + Vector3.new(0, 1.5, 0)

            -- Gorro
            local hat = Instance.new("Part")
            hat.Name = "Gorro"
            hat.Size = Vector3.new(1.2, 0.8, 1.2)
            hat.Color = Color3.fromRGB(150, 0, 50)
            hat.Parent = model
            
            local weldHat = Instance.new("WeldConstraint")
            weldHat.Part0 = head
            weldHat.Part1 = hat
            weldHat.Parent = head
            hat.Position = head.Position + Vector3.new(0, 1.0, 0)

            -- Perna única
            local leg = Instance.new("Part")
            leg.Name = "Perna"
            leg.Size = Vector3.new(0.6, 1.8, 0.6)
            leg.Color = Color3.fromRGB(120, 80, 50)
            leg.Parent = model

            local weldLeg = Instance.new("WeldConstraint")
            weldLeg.Part0 = torso
            weldLeg.Part1 = leg
            weldLeg.Parent = torso
            leg.Position = torso.Position - Vector3.new(0, 1.8, 0)
        elseif mob.configId == "MOB_001" then -- Sapo Cururu
            local torso = Instance.new("Part")
            torso.Name = "Torso"
            torso.Size = Vector3.new(2.2, 1.2, 2.2)
            torso.Color = Color3.fromRGB(34, 139, 34)
            torso.Parent = model
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hrp
            weld.Part1 = torso
            weld.Parent = hrp
            torso.Position = hrp.Position

            local eye1 = Instance.new("Part")
            eye1.Size = Vector3.new(0.4, 0.4, 0.4)
            eye1.Color = Color3.fromRGB(255, 255, 255)
            eye1.Parent = model
            local w1 = Instance.new("WeldConstraint")
            w1.Part0 = torso
            w1.Part1 = eye1
            w1.Parent = torso
            eye1.Position = torso.Position + Vector3.new(0.6, 0.6, 0.8)

            local eye2 = Instance.new("Part")
            eye2.Size = Vector3.new(0.4, 0.4, 0.4)
            eye2.Color = Color3.fromRGB(255, 255, 255)
            eye2.Parent = model
            local w2 = Instance.new("WeldConstraint")
            w2.Part0 = torso
            w2.Part1 = eye2
            w2.Parent = torso
            eye2.Position = torso.Position + Vector3.new(-0.6, 0.6, 0.8)
        elseif mob.configId == "MOB_015" then -- Capivara
            local torso = Instance.new("Part")
            torso.Name = "Torso"
            torso.Size = Vector3.new(1.8, 1.6, 2.8)
            torso.Color = Color3.fromRGB(139, 69, 19)
            torso.Parent = model
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hrp
            weld.Part1 = torso
            weld.Parent = hrp
            torso.Position = hrp.Position

            local head = Instance.new("Part")
            head.Name = "Head"
            head.Size = Vector3.new(1.2, 1.2, 1.4)
            head.Color = Color3.fromRGB(100, 50, 10)
            head.Parent = model
            local wHead = Instance.new("WeldConstraint")
            wHead.Part0 = torso
            wHead.Part1 = head
            wHead.Parent = torso
            head.Position = torso.Position + Vector3.new(0, 0.8, 1.2)
        else
            local torso = Instance.new("Part")
            torso.Name = "Torso"
            torso.Size = Vector3.new(2, 3, 2)
            torso.Color = bodyColor
            torso.Parent = model
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hrp
            weld.Part1 = torso
            weld.Parent = hrp
            torso.Position = hrp.Position
        end

        for _, part in ipairs(model:GetChildren()) do
            if part:IsA("BasePart") and part ~= hrp then
                part.CanCollide = false
                part.Massless = true
            end
        end
    end

    local mapName = mob.mapa or "Mapa1_YbiráPuera"
    local mapFolder = workspace:FindFirstChild("Mapas") and workspace.Mapas:FindFirstChild(mapName)
    if mapFolder then
        model.Parent = mapFolder
    else
        model.Parent = workspace
    end

    mob.model = model
    return model
end

function AISystem.UpdateMob(mob, deltaTime, jogadoresProximos)
    if mob.estado == ESTADOS.DEAD then return end

    -- Garantir que o modelo físico exista
    if not mob.model or not mob.model.Parent then
        AISystem.SpawnPhysicalModel(mob)
    end

    -- Sincronizar posição e HP lógico com o físico
    if mob.model and mob.model.PrimaryPart then
        mob.posicao = mob.model.PrimaryPart.Position
        local humanoid = mob.model:FindFirstChild("Humanoid")
        if humanoid then
            mob.hp = humanoid.Health
            if humanoid.Health <= 0 then
                mob.estado = ESTADOS.DEAD
                return
            end
        end
    end

    -- Regra de Leashing / Tethering (Retorno)
    local distFromSpawn = AISystem.CalcularDistancia(mob.posicao, mob.spawnPosition)
    if distFromSpawn > 60 and mob.estado ~= ESTADOS.RETORNO then
        mob.estado = ESTADOS.RETORNO
        mob.alvo = nil
        mob.immune = true
        print("[AISystem] " .. mob.nome .. " fugiu muito longe! Retornando ao ponto de spawn.")
    end

    -- Frenesi do Saci Sombrio (<30% HP)
    if mob.configId == "MOB_006" and (mob.hp / mob.hpMax) < 0.3 then
        if mob.model and mob.model:FindFirstChild("Humanoid") then
            mob.model.Humanoid.WalkSpeed = 12 -- +50% speed (default is 8)
        end
        AISystem.AplicarEfeitoFrenesi(mob)
    end

    -- Comportamento de acordo com o Estado
    if mob.estado == ESTADOS.RETORNO then
        if mob.model and mob.model:FindFirstChild("Humanoid") then
            mob.model.Humanoid.WalkSpeed = 14
            mob.model.Humanoid:MoveTo(mob.spawnPosition)
            mob.model.Humanoid.Health = math.min(mob.hpMax, mob.model.Humanoid.Health + mob.hpMax * 0.1)
        end

        if AISystem.CalcularDistancia(mob.posicao, mob.spawnPosition) <= 4 then
            mob.estado = ESTADOS.IDLE
            mob.immune = false
            if mob.model and mob.model:FindFirstChild("Humanoid") then
                mob.model.Humanoid.WalkSpeed = 8
                mob.model.Humanoid.Health = mob.hpMax
            end
            mob.hp = mob.hpMax
            print("[AISystem] " .. mob.nome .. " retornou ao spawn e está totalmente regenerado.")
        end
        return
    end

    -- Fuga (Flee) para passivos/evasivos quando com pouco HP e atacados
    if mob.estado == ESTADOS.FLEE and mob.alvo then
        if mob.model and mob.model:FindFirstChild("Humanoid") then
            local direction = (mob.posicao - mob.alvo.posicao)
            if direction.Magnitude > 0 then
                local fleePos = mob.posicao + direction.Unit * 18
                mob.model.Humanoid.WalkSpeed = 12
                mob.model.Humanoid:MoveTo(fleePos)
            end
        end

        local dist = AISystem.CalcularDistancia(mob.posicao, mob.alvo.posicao)
        if dist > mob.aggroRange * 1.5 then
            mob.estado = ESTADOS.IDLE
            mob.alvo = nil
            if mob.model and mob.model:FindFirstChild("Humanoid") then
                mob.model.Humanoid.WalkSpeed = 8
            end
        end
        return
    end

    -- Transição de agressivos para AGGRO se houver jogadores no range
    if mob.comportamento == "agressivo" and (mob.estado == ESTADOS.IDLE or mob.estado == ESTADOS.PATROL) then
        for _, jogador in ipairs(jogadoresProximos) do
            local dist = AISystem.CalcularDistancia(mob.posicao, jogador.posicao)
            if dist <= mob.aggroRange then
                mob.estado = ESTADOS.AGGRO
                mob.alvo = jogador
                print("[AISystem] " .. mob.nome .. " detectou " .. jogador.player.Name .. " e entrou em aggro!")
                break
            end
        end
    end

    -- Se passivo e foi atacado
    if mob.comportamento == "passivo" and mob.alvo ~= nil and mob.estado ~= ESTADOS.FLEE then
        if mob.configId == "MOB_015" or mob.configId == "MOB_001" then
            mob.estado = ESTADOS.FLEE
        else
            mob.estado = ESTADOS.AGGRO
        end
    end

    -- Perseguição e Combate
    if mob.estado == ESTADOS.AGGRO and mob.alvo then
        if mob.alvo.hp <= 0 then
            mob.estado = ESTADOS.RETORNO
            mob.alvo = nil
            mob.immune = true
            return
        end

        local dist = AISystem.CalcularDistancia(mob.posicao, mob.alvo.posicao)
        if dist <= 8 then
            AISystem.Atacar(mob, mob.alvo)
            if mob.model and mob.model:FindFirstChild("Humanoid") then
                mob.model.Humanoid:MoveTo(mob.posicao)
            end
        else
            if mob.model and mob.model:FindFirstChild("Humanoid") then
                mob.model.Humanoid:MoveTo(mob.alvo.posicao)
            end
        end

        if dist > mob.aggroRange * 2.5 then
            mob.estado = ESTADOS.RETORNO
            mob.alvo = nil
            mob.immune = true
        end
    end

    -- Patrulha
    if mob.estado == ESTADOS.IDLE or mob.estado == ESTADOS.PATROL then
        AISystem.Patrulhar(mob, deltaTime)
    end
end

function AISystem.Atacar(mob, alvo)
    local tempoAtual = os.clock()
    if tempoAtual - mob.tempoUltimaAcao < 1.8 then return end

    mob.tempoUltimaAcao = tempoAtual

    -- Escolher e usar skill se disponível
    if #mob.habilidades > 0 and math.random(1, 100) <= 40 then
        local skill = mob.habilidades[math.random(1, #mob.habilidades)]
        local cooldownKey = skill.nome
        if not mob.cooldowns[cooldownKey] or tempoAtual >= mob.cooldowns[cooldownKey] then
            mob.cooldowns[cooldownKey] = tempoAtual + skill.cooldown
            AISystem.AplicarSkill(mob, alvo, skill)
            return
        end
    end

    -- Ataque básico
    local dano, critou, miss = DamageCalculator.CalcularDano(mob, alvo, {
        tipoDano = mob.tipoDano or "fisico",
        multiplicador = 1.0,
    })

    if miss then
        ReplicatedStorage.Remotes.Combat.DamageResult:FireAllClients(alvo.player.Character.Name, 0, false, true)
        return
    end

    if alvo.player and alvo.player.Character and alvo.player.Character:FindFirstChild("Humanoid") then
        alvo.player.Character.Humanoid:TakeDamage(dano)
        ReplicatedStorage.Remotes.Combat.DamageResult:FireAllClients(alvo.player.Character.Name, dano, critou, false)
    end
end

function AISystem.AplicarSkill(mob, alvo, skill)
    local tempoAtual = os.clock()
    
    if skill.nome == "Sumiço Mágico" or skill.nome == "Sumiço Corrompido" then
        mob.immune = true
        if mob.model then
            for _, part in ipairs(mob.model:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0.95
                end
            end
        end
        print("[AISystem] " .. mob.nome .. " usou Sumiço Corrompido!")
        
        task.delay(4, function()
            mob.immune = false
            if mob.model and mob.model.Parent then
                for _, part in ipairs(mob.model:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 0
                    end
                end
                
                if alvo and alvo.player and alvo.player.Character and alvo.player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = alvo.player.Character.HumanoidRootPart
                    local backPos = hrp.Position - hrp.CFrame.LookVector * 3
                    mob.model.HumanoidRootPart.CFrame = CFrame.new(backPos, hrp.Position)
                    
                    local humanoid = alvo.player.Character.Humanoid
                    local damageAmount = math.floor(humanoid.MaxHealth * 0.10)
                    humanoid:TakeDamage(damageAmount)
                    
                    ReplicatedStorage.Remotes.Combat.DamageResult:FireAllClients(alvo.player.Character.Name, damageAmount, true, false)
                    print("[AISystem] " .. mob.nome .. " causou " .. damageAmount .. " de dano verdadeiro em " .. alvo.player.Name)
                end
            end
        end)
        
    elseif skill.nome == "Redemoinho Travesso" or skill.nome == "Redemoinho Sombrio" then
        print("[AISystem] " .. mob.nome .. " usou Redemoinho Sombrio!")
        
        local attachment = mob.model and mob.model:FindFirstChild("HumanoidRootPart")
        local emitter = nil
        if attachment then
            emitter = Instance.new("ParticleEmitter")
            emitter.Texture = "rbxassetid://243572793"
            emitter.Color = ColorSequence.new(Color3.fromRGB(80, 20, 100))
            emitter.Rate = 60
            emitter.Speed = NumberRange.new(5, 12)
            emitter.Size = NumberSequence.new(1, 3.5)
            emitter.Parent = attachment
        end

        task.spawn(function()
            for tickCount = 1, 3 do
                task.wait(1)
                if mob.estado == ESTADOS.DEAD then break end
                
                if alvo and alvo.player and alvo.player.Character and alvo.player.Character:FindFirstChild("HumanoidRootPart") then
                    local playerHrp = alvo.player.Character.HumanoidRootPart
                    local direction = (mob.posicao - playerHrp.Position)
                    if direction.Magnitude > 2 then
                        playerHrp.Position = playerHrp.Position + direction.Unit * 3.5
                    end
                    
                    local humanoid = alvo.player.Character.Humanoid
                    local damageAmount = math.floor(humanoid.MaxHealth * 0.05)
                    humanoid:TakeDamage(damageAmount)
                    
                    ReplicatedStorage.Remotes.Combat.DamageResult:FireAllClients(alvo.player.Character.Name, damageAmount, false, false)
                end
            end
            if emitter then emitter:Destroy() end
        end)
    else
        local dano, critou = DamageCalculator.CalcularDano(mob, alvo, {
            tipoDano = mob.tipoDano or "fisico",
            multiplicador = 1.25,
        })
        
        if alvo.player and alvo.player.Character and alvo.player.Character:FindFirstChild("Humanoid") then
            alvo.player.Character.Humanoid:TakeDamage(dano)
            ReplicatedStorage.Remotes.Combat.DamageResult:FireAllClients(alvo.player.Character.Name, dano, critou, false)
        end
    end
end

function AISystem.CalcularDistancia(pos1, pos2)
    local dx = pos1.X - pos2.X
    local dz = pos1.Z - pos2.Z
    return math.sqrt(dx * dx + dz * dz)
end

function AISystem.MoverEmDirecao(mob, posAlvo, deltaTime)
    if mob.model and mob.model:FindFirstChild("Humanoid") then
        mob.model.Humanoid:MoveTo(posAlvo)
    end
end

function AISystem.Patrulhar(mob, deltaTime)
    if not mob.model or not mob.model:FindFirstChild("Humanoid") then return end

    local tempoAtual = os.clock()
    if mob.patrolWaitTime and tempoAtual < mob.patrolWaitTime then
        return
    end

    if not mob.patrolDestination or AISystem.CalcularDistancia(mob.posicao, mob.patrolDestination) < 3 then
        if mob.patrolDestination then
            mob.patrolWaitTime = tempoAtual + math.random(2, 5)
            mob.patrolDestination = nil
            return
        end

        local range = 15
        local angle = math.random() * math.pi * 2
        local offset = Vector3.new(math.cos(angle) * range, 0, math.sin(angle) * range)
        mob.patrolDestination = mob.spawnPosition + offset
    end

    mob.model.Humanoid:MoveTo(mob.patrolDestination)
end

function AISystem.OnMobDeath(mob, jogador)
    local drops = AISystem.GerarDrops(mob)
    
    mob.estado = ESTADOS.DEAD
    
    -- Dissolver modelo físico
    if mob.model then
        local model = mob.model
        task.spawn(function()
            for i = 0, 10 do
                if not model or not model.Parent then break end
                for _, part in ipairs(model:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Transparency = i / 10
                    end
                end
                task.wait(0.1)
            end
            if model and model.Parent then
                model:Destroy()
            end
        end)
        mob.model = nil
    end

    mob.frenesiVFXActive = false

    -- O SpawnSystem lida com o respawn, mas o AI tem esse delay nativo para segurança se avulso
    return drops
end

function AISystem.GerarDrops(mob)
    local drops = {}
    for _, drop in ipairs(mob.drops) do
        if math.random() * 100 <= drop.chance then
            table.insert(drops, {
                itemId = drop.itemId,
                nome = drop.nome,
                tipo = drop.tipo,
                valorNpc = drop.valorNpc,
            })
        end
    end
    return drops
end

function AISystem.RespawnMob(mob)
    mob.hp = mob.hpMax
    mob.estado = ESTADOS.IDLE
    mob.alvo = nil
    mob.posicao = mob.spawnPosition
    mob.frenesiVFXActive = false
    AISystem.SpawnPhysicalModel(mob)
end

function AISystem.AplicarEfeitoFrenesi(mob)
    if not mob.model or mob.frenesiVFXActive then return end
    mob.frenesiVFXActive = true
    
    local torso = mob.model:FindFirstChild("Torso")
    if torso then
        local emitter = Instance.new("ParticleEmitter")
        emitter.Name = "FrenesiSmoke"
        emitter.Texture = "rbxassetid://243572793"
        emitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 150))
        })
        emitter.Rate = 25
        emitter.Speed = NumberRange.new(2, 5)
        emitter.Size = NumberSequence.new(1, 2.2)
        emitter.Lifetime = NumberRange.new(0.5, 1)
        emitter.Parent = torso
    end
end

return AISystem
