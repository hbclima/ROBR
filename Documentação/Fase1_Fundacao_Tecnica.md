# Fase 1 — Fundação Técnica

> Documentação arquitetural e scripts para implementação no Roblox Studio.
> Define a estrutura Server/Client, ModuleScripts e sistemas core.
> Critério de saída: estrutura de módulos definida e scripts base prontos para implementação.

---

## 1. Arquitetura Server/Client

### Princípio: Server-Authoritative

```
┌─────────────────────────────────────────────────────────┐
│                      CLIENT                              │
│  - Input do jogador                                     │
│  - UI / HUD                                             │
│  - Animações locais                                     │
│  - Efeitos visuais                                      │
│  → Envia requests ao Server                             │
└─────────────┬───────────────────────────────────────────┘
              │ Remotes (Client → Server)
              ▼
┌─────────────────────────────────────────────────────────┐
│                      SERVER                              │
│  - Valida todas as ações                                │
│  - Calcula dano, HP, drops                              │
│  - Gerencia spawns de mobs                              │
│  - Persiste dados (DataStore)                           │
│  - Controla economia                                    │
│  → Envia resultados ao Client                           │
└─────────────────────────────────────────────────────────┘
```

**Regra de ouro:** O Client nunca decide o resultado de uma ação — apenas solicita ao Server e exibe o resultado.

### Comunicação Client ↔ Server

```
Cliente → Server:  RemoteEvent:FireServer(...)      (ação solicitada)
Server → Cliente:  RemoteEvent:FireClient(player, ...) (resultado)
```

---

## 2. Estrutura de Pastas (Roblox Studio)

```
game
├── ReplicatedStorage
│   ├── Modules/
│   │   ├── Config/
│   │   │   ├── MobsConfig          -- Dados dos 16 mobs
│   │   │   ├── ClassesConfig       -- Dados das 3 classes
│   │   │   ├── SkillsConfig        -- Dados das skills
│   │   │   ├── DropsConfig         -- Tabela de drops
│   │   │   ├── AtlasConfig         -- Dados dos mapas
│   │   │   └── ItensConfig         -- Dados de itens/equipamentos
│   │   ├── Shared/
│   │   │   ├── Formulas            -- Fórmulas de combate
│   │   │   ├── DamageCalculator    -- Cálculo de dano (shared para previsão client)
│   │   │   ├── Utils               -- Funções utilitárias
│   │   │   └── Constants           -- Constantes do jogo
│   └── Remotes/                    -- Instâncias (Folders + RemoteEvents/RemoteFunctions)
│       ├── Combat/
│       │   ├── Attack              -- RemoteEvent: Client → Server
│       │   ├── UseSkill            -- RemoteEvent: Client → Server
│       │   └── DamageResult        -- RemoteEvent: Server → Client
│       ├── Trade/
│       │   ├── RequestTrade        -- RemoteEvent: Client → Server
│       │   ├── AcceptTrade         -- RemoteEvent: Client → Server
│       │   └── CancelTrade         -- RemoteEvent: Client → Server
│       ├── Shop/
│       │   ├── OpenShop            -- RemoteEvent: Client → Server
│       │   ├── BuyItem             -- RemoteEvent: Client → Server
│       │   └── SellItem            -- RemoteEvent: Client → Server
│       └── Data/
│           ├── RequestData         -- RemoteFunction: Client → Server
│           ├── UpdateStats         -- RemoteEvent: Client → Server
│           └── LevelUp             -- RemoteEvent: Server → Client
│
├── ServerScriptService
│   ├── ServerMain                 -- Entry point do server
│   ├── DataController             -- Save/load via DataStore
│   ├── MobManager                 -- Gerencia mobs ativos
│   ├── CombatManager              -- Processa ações de combate
│   ├── InventoryManager           -- Gerencia inventário e equipamentos
│   ├── ShopManager                -- Gerencia NPC shop
│   ├── TradeManager               -- Gerencia trade entre jogadores
│   ├── PartyManager               -- Gerencia parties
│   ├── Modules/
│   │   ├── AISystem               -- IA dos mobs (server-only)
│   │   ├── SpawnSystem            -- Spawn/respawn de mobs (server-only)
│   │   └── CombatSystem           -- Luta corpo-a-corpo (server-only)
│
├── StarterPlayerScripts
│   ├── ClientMain                 -- Entry point do client
│   ├── InputHandler               -- Captura input do jogador
│   ├── CombatClient               -- UI e animações de combate
│   ├── UIController               -- Gerencia HUD/interface
│   ├── ShopClient                 -- Interface da loja
│   └── TradeClient                -- Interface de trade
│
├── StarterGui
│   ├── HUD                        -- Interface principal
│   ├── ShopWindow                 -- Janela da loja
│   ├── TradeWindow                -- Janela de trade
│   ├── InventoryWindow            -- Janela de inventário
│   └── SkillBar                   -- Barra de skills
│
└── Workspace
    ├── Mapas/
    │   ├── Mapa1_RioIbirapuera
    │   ├── Mapa2_FlorestaMaeDaMata
    │   ├── Mapa3_ClareiraQueimada
    │   ├── Mapa4_CemiterioIndigena
    │   ├── Mapa5_TemploNasNuvens
    │   └── Mapa6_LagoSubterraneo
    └── Shared/
        ├── SpawnPoints
        └── NPCShops
```

---

## 3. ModuleScripts

### 3.1 — Config/MobsConfig

```lua
-- MobsConfig.lua
-- Dados de todos os mobs do jogo
-- Gerado a partir das fichas de mob

local MobsConfig = {}

MobsConfig.Mobs = {
    ["MOB_001"] = {
        id = "MOB_001",
        nome = "Sapo Cururu",
        nivelMin = 1,
        nivelMax = 6,
        hpMax = 120,
        ataqueBase = 8,
        tipoDano = "fisico",
        defesaBase = 6,
        xpRecompensa = 120, -- Alinhado com GDD Fase06 (era 35, corrigido para 120)
        respawnSegundos = 30,
        comportamento = "passivo",
        aggroRange = 12,
        elemento = "agua",
        raridade = "comum",
        mapa = "Mapa1_RioIbirapuera",
        zonaTipo = "inicial",
        habilidades = {
            {
                nome = "Salto Pegajoso",
                tipo = "debuff",
                custosp = 0,
                cooldown = 18,
                efeito = {tipo = "debuff_agi", valor = 0.3, duracao = 4}, -- Padronizado como tabela
                chance = 100,
            }
        },
        drops = {
            {itemId = "ITEM_001", nome = "Carta - Sapo Cururu", tipo = "especial", chance = 0.5, valorNpc = 200},
            {itemId = "ITEM_002", nome = "Bolsa de Lodo", tipo = "equipamento", chance = 3.0, valorNpc = 40},
            {itemId = "ITEM_003", nome = "Glande de Sapo", tipo = "consumivel", chance = 15.0, valorNpc = 5},
            {itemId = "ITEM_004", nome = "Casca de Arvore", tipo = "comum", chance = 60.0, valorNpc = 2},
            {itemId = "ITEM_005", nome = "Lama Seca", tipo = "comum", chance = 55.0, valorNpc = 1},
        },
    },
    -- [...] Demais mobs (MOB_002 a MOB_016)
}

-- Função auxiliar para obter config de um mob
function MobsConfig.GetMob(mobId)
    return MobsConfig.Mobs[mobId]
end

-- Função para obter mobs de um mapa
function MobsConfig.GetMobsByMapa(mapaId)
    local mobs = {}
    for id, mob in pairs(MobsConfig.Mobs) do
        if mob.mapa == mapaId then
            mobs[id] = mob
        end
    end
    return mobs;
end

return MobsConfig
```

### 3.2 — Config/ClassesConfig

```lua
-- ClassesConfig.lua
-- Dados das 3 classes do MVP

local ClassesConfig = {}

ClassesConfig.Classes = {
    ["Tembira"] = {
        nome = "Tembira",
        nomeExibido = "Guerreiro",
        descricao = "Guerreiro corpo-a-corpo, protetor da tribo",
        papel = "Tank",
        atributosBase = {
            STR = 5,
            AGI = 2,
            VIT = 9,
            INT = 1,
            DEX = 2,
            LUK = 1,
        },
        atributoPrincipal = "VIT",
        atributoSecundario = "STR",
        ganhoHP = 35,
        ganhoSP = 10,
        skills = {
            {
                id = "Tembira_S1",
                nome = "Tacape Ancestral",
                tipo = "ataque",
                custosp = 0,
                cooldown = 1.5,
                formulaDano = "ATK * 1.6 + STR",
                descricao = "Golpe basico; 15% chance de atordoar 1s",
                nivelRequerido = 1,
            },
            {
                id = "Tembira_S2",
                nome = "Taunt da Floresta",
                tipo = "controle",
                custosp = 10,
                cooldown = 12,
                efeito = "Atrai aggro em 5m por 4s",
                nivelRequerido = 1,
            },
            -- [...] Demais skills
        },
    },
    ["Karaí"] = {
        nome = "Karaí",
        nomeExibido = "Mago",
        descricao = "Feiticeiro espiritual, manipulador de espíritos",
        papel = "DPS",
        atributosBase = {
            STR = 1,
            AGI = 2,
            VIT = 3,
            INT = 11,
            DEX = 2,
            LUK = 1,
        },
        atributoPrincipal = "INT",
        atributoSecundario = "DEX",
        ganhoHP = 15,
        ganhoSP = 18,
        skills = {
            -- [...]
        },
    },
    ["Payé"] = {
        nome = "Payé",
        nomeExibido = "Pajé",
        descricao = "Curandeiro espiritual, sacerdote",
        papel = "Support",
        atributosBase = {
            STR = 1,
            AGI = 2,
            VIT = 7,
            INT = 8,
            DEX = 1,
            LUK = 1,
        },
        atributoPrincipal = "INT",
        atributoSecundario = "VIT",
        ganhoHP = 22,
        ganhoSP = 15,
        skills = {
            -- [...]
        },
    },
}

function ClassesConfig.GetClass(classId)
    return ClassesConfig.Classes[classId]
end

return ClassesConfig
```

### 3.3 — Shared/Formulas

```lua
-- Formulas.lua
-- Todas as fórmulas de combate do jogo

local Formulas = {}

-- Atributos do jogador (recebidos como parâmetros)
-- STR, AGI, VIT, INT, DEX, LUK, nivel

function Formulas.CalcATK(STR, DEX, LUK, ATK_base)
    return ATK_base + (STR * 2) + (DEX * 0.5) + (LUK * 0.2)
end

function Formulas.CalcMATK(INT, DEX, MATK_base)
    return MATK_base + (INT * 2.5) + (DEX * 0.3)
end

function Formulas.CalcDEF(VIT, STR, DEF_base)
    return DEF_base + (VIT * 1.5) + (STR * 0.3)
end

function Formulas.CalcMDEF(INT, VIT, MDEF_base)
    return MDEF_base + (INT * 1.0) + (VIT * 0.5)
end

function Formulas.CalcHitRate(DEX, nivel)
    return math.min(95, 75 + (DEX * 1.5) + (nivel * 0.5))
end

function Formulas.CalcFleeRate(AGI, nivel)
    return math.min(95, 10 + (AGI * 1.5) + (nivel * 0.3))
end

function Formulas.CalcCritRate(LUK)
    return math.min(25, (LUK * 0.5) + 1)
end

function Formulas.CalcDano(ATK_final, DEF_alvo)
    local dano = math.max(1, ATK_final - DEF_alvo)
    return dano
end

function Formulas.CalcDanoCritico(dano_normal)
    return dano_normal * 1.5
end

function Formulas.CalcHPMax(hpBase, nivel, ganhoHP, VIT)
    return hpBase + (nivel - 1) * ganhoHP + (VIT * 8)
end

function Formulas.CalcSPMax(nivel, INT)
    local spBase = 50 + (nivel - 1) * 6
    return spBase + (INT * 3)
end

function Formulas.CalcASPD(AGI, DEX)
    return math.max(150, 200 - (AGI * 0.8) - (DEX * 0.2))
end

function Formulas.CalcXPProximoNivel(nivel)
    return math.floor(200 * (nivel ^ 1.8))
end

function Formulas.CalcDanoSkill(atacante, skill)
    -- Calcula dano de skill baseado no atributo primário
    local atributo = skill.atributoPrimario or "INT"
    local multiplicador = skill.multiplicador or 1.0
    local valorAtributo = atacante[atributo] or atacante.INT or 0
    return math.floor(valorAtributo * multiplicador + atacante.nivel * 3)
end

function Formulas.CalcCastReduction(DEX, INT)
    -- Redução percentual do cast time (da Fase 0.3)
    return (DEX * 0.4) + (INT * 0.2)
end

return Formulas
```

### 3.4 — Combat/DamageCalculator

```lua
-- DamageCalculator.lua
-- Calcula dano de uma entidade para outra

local Formulas = require(game.ReplicatedStorage.Modules.Shared.Formulas)

local DamageCalculator = {}

function DamageCalculator.CalcularDano(atacante, alvo, skill)
    local dano = 0
    local critou = false
    local miss = false
    local tipoDano = skill.tipoDano or "fisico" -- fisico ou magico

    -- Verificar hit/miss antes de calcular dano
    if not DamageCalculator.HitMiss(atacante, alvo) then
        return 0, false, true -- dano=0, crit=false, miss=true
    end

    if tipoDano == "fisico" then
        local atk = Formulas.CalcATK(atacante.STR, atacante.DEX, atacante.LUK, atacante.ATK_base or 0)
        local def = Formulas.CalcDEF(alvo.VIT, alvo.STR, alvo.DEF_base or 0)
        dano = Formulas.CalcDano(atk, def)
    else -- magico
        local matk = Formulas.CalcMATK(atacante.INT, atacante.DEX, atacante.MATK_base or 0)
        local mdef = Formulas.CalcMDEF(alvo.INT, alvo.VIT, alvo.MDEF_base or 0)
        dano = Formulas.CalcDano(matk, mdef)
    end

    -- Multiplicador da skill
    if skill.multiplicador then
        dano = math.floor(dano * skill.multiplicador)
    end

    -- Verificar crítico
    local critRate = Formulas.CalcCritRate(atacante.LUK)
    if math.random(1, 100) <= critRate then
        dano = Formulas.CalcDanoCritico(dano)
        critou = true
    end

    return math.floor(dano), critou, false -- miss=false
end

function DamageCalculator.HitMiss(atacante, alvo)
    local hitRate = Formulas.CalcHitRate(atacante.DEX or 1, atacante.nivel or 1)
    local fleeRate = Formulas.CalcFleeRate(alvo.AGI or 1, alvo.nivel or 1)
    local hitFinal = math.max(5, math.min(95, hitRate - fleeRate))
    return math.random(1, 100) <= hitFinal
end

return DamageCalculator
```

### 3.5 — Combat/AISystem

```lua
-- AISystem.lua
-- Inteligência artificial dos mobs
-- NOTA: Este módulo roda APENAS no servidor (ServerScriptService)

local MobsConfig = require(game.ReplicatedStorage.Modules.Config.MobsConfig)
local DamageCalculator = require(game.ReplicatedStorage.Modules.Shared.DamageCalculator)

local AISystem = {}

-- Estados de IA
local ESTADOS = {
    IDLE = "idle",
    PATROL = "patrol",
    AGGRO = "aggro",
    ATTACK = "attack",
    FLEE = "flee",
    DEAD = "dead",
}

function AISystem.CreateMob(mobId, spawnPosition)
    local mobConfig = MobsConfig.GetMob(mobId)
    if not mobConfig then return nil end

    local mob = {
        id = mobId,
        nome = mobConfig.nome,
        hp = mobConfig.hpMax,
        hpMax = mobConfig.hpMax,
        nivel = mobConfig.nivelMin + math.random(0, math.max(0, mobConfig.nivelMax - mobConfig.nivelMin)),
        ATK_base = mobConfig.ataqueBase,
        DEF_base = mobConfig.defesaBase,
        tipoDano = mobConfig.tipoDano or "fisico", -- Herdado do config
        comportamento = mobConfig.comportamento,
        aggroRange = mobConfig.aggroRange,
        xpRecompensa = mobConfig.xpRecompensa,
        respawnTime = mobConfig.respawnSegundos,
        habilidades = mobConfig.habilidades,
        drops = mobConfig.drops,
        estado = ESTADOS.IDLE,
        alvo = nil,
        posicao = spawnPosition,
        tempoUltimaAcao = 0,
        cooldowns = {},
    }

    -- Gerar atributos baseados no nível (simplificado para MVP)
    mob.STR = math.floor(mobConfig.ataqueBase * 0.5)
    mob.VIT = math.floor(mobConfig.hpMax / 15)
    mob.INT = mobConfig.tipoDano == "magico" and math.floor(mobConfig.ataqueBase * 0.8) or 1
    mob.DEX = math.floor(mobConfig.aggroRange / 2)
    mob.LUK = 1
    mob.AGI = 2

    -- Campos derivados para DamageCalculator (evita nil em cálculos)
    mob.MATK_base = mobConfig.tipoDano == "magico" and mobConfig.ataqueBase or 0
    mob.MDEF_base = math.floor(mobConfig.defesaBase * 0.5)

    return mob
end

function AISystem.UpdateMob(mob, deltaTime, jogadoresProximos)
    if mob.estado == ESTADOS.DEAD then return end

    -- Verificar se há jogadores no range de aggro
    if mob.comportamento == "agressivo" then
        for _, jogador in ipairs(jogadoresProximos) do
            local dist = AISystem.CalcularDistancia(mob.posicao, jogador.posicao)
            if dist <= mob.aggroRange then
                mob.estado = ESTADOS.AGGRO
                mob.alvo = jogador
                break
            end
        end
    end

    -- Se passivo, só ataca se foi atacado
    if mob.comportamento == "passivo" and mob.alvo ~= nil then
        mob.estado = ESTADOS.AGGRO
    end

    -- Ataque
    if mob.estado == ESTADOS.AGGRO and mob.alvo then
        local dist = AISystem.CalcularDistancia(mob.posicao, mob.alvo.posicao)
        if dist <= 5 then -- Range de ataque corpo-a-corpo
            AISystem.Atacar(mob, mob.alvo)
        else
            AISystem.MoverEmDirecao(mob, mob.alvo.posicao, deltaTime)
        end

        -- Verificar se alvo fugiu muito longe
        if dist > mob.aggroRange * 2 then
            mob.estado = ESTADOS.IDLE
            mob.alvo = nil
        end
    end

    -- Patrulha (quando idle)
    if mob.estado == ESTADOS.IDLE then
        AISystem.Patrulhar(mob, deltaTime)
    end
end

function AISystem.Atacar(mob, alvo)
    local tempoAtual = os.clock() -- Substituído tick() (depreciado)
    if tempoAtual - mob.tempoUltimaAcao < 1.5 then return end -- Cooldown global

    mob.tempoUltimaAcao = tempoAtual

    -- Usar skill aleatória disponível
    if #mob.habilidades > 0 then
        local skill = mob.habilidades[math.random(1, #mob.habilidades)]
        local cooldownKey = skill.nome
        if mob.cooldowns[cooldownKey] and tempoAtual < mob.cooldowns[cooldownKey] then
            -- Skill em cooldown, ataque básico
            skill = nil
        end

        if skill then
            mob.cooldowns[cooldownKey] = os.clock() + skill.cooldown
            AISystem.AplicarSkill(mob, alvo, skill)
        else
            -- Ataque básico
            local dano, critou = DamageCalculator.CalcularDano(mob, alvo, {
                tipoDano = mob.tipoDano or "fisico",
                multiplicador = 1.0,
            })
            alvo.hp = alvo.hp - dano
        end
    end
end

function AISystem.AplicarSkill(mob, alvo, skill)
    local dano, critou = DamageCalculator.CalcularDano(mob, alvo, {
        tipoDano = mob.tipoDano or "fisico",
        multiplicador = 1.2,
    })
    alvo.hp = alvo.hp - dano

    -- Aplicar efeito extra da skill (campo efeito é tabela com tipo/valor/duracao)
    local efeito = skill.efeito
    if type(efeito) == "table" then
        if efeito.tipo == "stun" then
            alvo.stunned = true
            alvo.stunEndTime = os.clock() + (efeito.duracao or 1)
        elseif efeito.tipo == "poison" then
            alvo.poisoned = true
            alvo.poisonEndTime = os.clock() + (efeito.duracao or 9)
            alvo.poisonDamage = math.floor(alvo.hpMax * (efeito.valor or 0.05))
        elseif efeito.tipo == "debuff_agi" then
            alvo.debuffAGI = true
            alvo.debuffAGIEndTime = os.clock() + (efeito.duracao or 4)
            alvo.debuffAGIValor = efeito.valor or 0.3
        end
    end
end

function AISystem.CalcularDistancia(pos1, pos2)
    local dx = pos1.X - pos2.X
    local dz = pos1.Z - pos2.Z
    return math.sqrt(dx * dx + dz * dz)
end

function AISystem.MoverEmDirecao(mob, posAlvo, deltaTime)
    -- Implementação simplificada: move em direção ao alvo
    local speed = 8 -- studs por segundo
    local direction = (posAlvo - mob.posicao).Unit
    mob.posicao = mob.posicao + direction * speed * deltaTime
end

function AISystem.Patrulhar(mob, deltaTime)
    -- Movimento aleatório dentro de um raio (simplificado)
end

function AISystem.OnMobDeath(mob, jogador)
    -- Dropar itens
    local drops = AISystem.GerarDrops(mob)
    -- Dar XP
    jogador.xp = jogador.xp + mob.xpRecompensa
    -- Marcar como morto
    mob.estado = ESTADOS.DEAD
    -- Agendar respawn
    task.delay(mob.respawnTime, function()
        AISystem.RespawnMob(mob)
    end)
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
    -- Notificar jogadores próximos sobre respawn
end

return AISystem
```

### 3.6 — Combat/SpawnSystem

```lua
-- SpawnSystem.lua
-- Gerencia spawn de mobs nos mapas
-- NOTA: Este módulo roda APENAS no servidor (ServerScriptService)

local MobsConfig = require(game.ReplicatedStorage.Modules.Config.MobsConfig)
local AISystem = require(script.Parent.AISystem) -- Server-side module

local SpawnSystem = {}

local mobsAtivosCache = {} -- Renomeado para evitar conflito com a função SpawnSystem.GetMobsAtivos()
local SpawnPoints = {}

-- Configurar pontos de spawn por mapa
function SpawnSystem.Init()
    -- Mapa 1 - Rio Ibirapuera
    SpawnSystem.RegistrarSpawn("Mapa1_RioIbirapuera", "MOB_001", 5) -- Sapo Cururu
    SpawnSystem.RegistrarSpawn("Mapa1_RioIbirapuera", "MOB_015", 3) -- Capivara
    SpawnSystem.RegistrarSpawn("Mapa1_RioIbirapuera", "MOB_002", 4) -- Cobra d'Agua

    -- Mapa 2 - Floresta Mae da Mata
    SpawnSystem.RegistrarSpawn("Mapa2_FlorestaMaeDaMata", "MOB_003", 3) -- Mae da Mata
    SpawnSystem.RegistrarSpawn("Mapa2_FlorestaMaeDaMata", "MOB_011", 2) -- Boto
    SpawnSystem.RegistrarSpawn("Mapa2_FlorestaMaeDaMata", "MOB_013", 2) -- Corpo Seco

    -- Mapa 3 - Clareira Queimada
    SpawnSystem.RegistrarSpawn("Mapa3_ClareiraQueimada", "MOB_004", 3) -- Boitata
    SpawnSystem.RegistrarSpawn("Mapa3_ClareiraQueimada", "MOB_012", 2) -- Mula
    SpawnSystem.RegistrarSpawn("Mapa3_ClareiraQueimada", "MOB_016", 2) -- Jacare

    -- Mapa 4 - Cemiterio Indigena
    SpawnSystem.RegistrarSpawn("Mapa4_CemiterioIndigena", "MOB_005", 2) -- Curupira
    SpawnSystem.RegistrarSpawn("Mapa4_CemiterioIndigena", "MOB_008", 2) -- Anhanga
    SpawnSystem.RegistrarSpawn("Mapa4_CemiterioIndigena", "MOB_014", 2) -- Onca

    -- Mapa 5 - Templo nas Nuvens
    SpawnSystem.RegistrarSpawn("Mapa5_TemploNasNuvens", "MOB_006", 2) -- Saci
    SpawnSystem.RegistrarSpawn("Mapa5_TemploNasNuvens", "MOB_009", 2) -- Jurupari

    -- Mapa 6 - Lago Subterraneo (Boss)
    SpawnSystem.RegistrarSpawn("Mapa6_LagoSubterraneo", "MOB_007", 1) -- Boiuna
end

function SpawnSystem.RegistrarSpawn(mapa, mobId, quantidade)
    if not SpawnPoints[mapa] then
        SpawnPoints[mapa] = {}
    end
    table.insert(SpawnPoints[mapa], {mobId = mobId, quantidade = quantidade})
end

function SpawnSystem.SpawnAll()
    for mapa, spawns in pairs(SpawnPoints) do
        for _, spawn in ipairs(spawns) do
            for i = 1, spawn.quantidade do
                local pos = SpawnSystem.GetSpawnPosition(mapa)
                local mob = AISystem.CreateMob(spawn.mobId, pos)
                if mob then
                    table.insert(mobsAtivosCache, mob)
                end
            end
        end
    end
    print("[SpawnSystem] " .. #mobsAtivosCache .. " mobs spawned.")
end

function SpawnSystem.GetSpawnPosition(mapa)
    -- Retorna posição aleatória dentro dos limites do mapa
    -- No MVP: posição fixa + offset aleatório
    local basePositions = {
        Mapa1_RioIbirapuera = Vector3.new(0, 5, 0),
        Mapa2_FlorestaMaeDaMata = Vector3.new(200, 5, 0),
        Mapa3_ClareiraQueimada = Vector3.new(400, 5, 0),
        Mapa4_CemiterioIndigena = Vector3.new(600, 5, 0),
        Mapa5_TemploNasNuvens = Vector3.new(800, 5, 0),
        Mapa6_LagoSubterraneo = Vector3.new(1000, 5, 0),
    }
    local base = basePositions[mapa] or Vector3.new(0, 5, 0)
    return base + Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
end

function SpawnSystem.GetMobsAtivos()
    return mobsAtivosCache
end

return SpawnSystem
```

### 3.7 — Server/DataController

```lua
-- DataController.lua
-- Save/load de dados do jogador via DataStore
-- Usa cache em memória para preservar tabelas (inventory, stats, skills)

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local DataController = {}

local PlayerDataStore = DataStoreService:GetDataStore("PlayerData_v1")

-- Cache em memória: { [userId] = data }
local PlayerDataCache = {}

local MAX_RETRIES = 3

local DEFAULT_DATA = {
    -- Progresso
    nivel = 1,
    xp = 0,
    statPoints = 0,
    statPointsUsed = {STR = 0, AGI = 0, VIT = 0, INT = 0, DEX = 0, LUK = 0},

    -- Classe
    classe = nil, -- "Tembira", "Karaí", "Payé"

    -- Inventário
    gold = 0,
    inventory = {},

    -- Equipamento
    equipment = {
        arma_principal = nil,
        capacete = nil,
        armadura = nil,
        botas = nil,
        colar = nil,
    },

    -- Skills
    skillPoints = 0,
    skillLevels = {},

    -- Config
    settings = {
        musicVolume = 0.5,
        sfxVolume = 0.7,
    },
}

-- Deep copy para evitar referências compartilhadas entre jogadores
local function deepCopy(original)
    if type(original) ~= "table" then return original end
    local copy = {}
    for k, v in pairs(original) do
        copy[k] = deepCopy(v)
    end
    return copy
end

function DataController.LoadData(player)
    local key = "Player_" .. player.UserId
    local data = nil

    for attempt = 1, MAX_RETRIES do
        local success, result = pcall(function()
            return PlayerDataStore:GetAsync(key)
        end)
        if success then
            data = result
            break
        else
            warn("[DataController] Tentativa " .. attempt .. " falhou ao carregar dados de " .. player.Name .. ": " .. tostring(result))
            if attempt < MAX_RETRIES then task.wait(1) end
        end
    end

    if data then
        -- Mesclar com defaults (para campos novos adicionados após save anterior)
        for k, v in pairs(DEFAULT_DATA) do
            if data[k] == nil then
                data[k] = deepCopy(v)
            end
        end
        return data
    else
        -- Novo jogador: retornar cópia profunda dos defaults
        return deepCopy(DEFAULT_DATA)
    end
end

function DataController.SaveData(player, data)
    local key = "Player_" .. player.UserId
    for attempt = 1, MAX_RETRIES do
        local success, err = pcall(function()
            PlayerDataStore:UpdateAsync(key, function(oldData)
                return data -- Usa UpdateAsync em vez de SetAsync para evitar race conditions
            end)
        end)
        if success then
            return true
        else
            warn("[DataController] Tentativa " .. attempt .. " falhou ao salvar dados de " .. player.Name .. ": " .. tostring(err))
            if attempt < MAX_RETRIES then task.wait(1) end
        end
    end
    return false
end

-- Acessar dados do jogador em memória (sem acessar DataStore)
function DataController.GetData(player)
    return PlayerDataCache[player.UserId]
end

-- Atualizar campo específico dos dados em memória
function DataController.UpdateField(player, field, value)
    local data = PlayerDataCache[player.UserId]
    if data then
        data[field] = value
    end
end

function DataController.OnPlayerAdded(player)
    local data = DataController.LoadData(player)
    PlayerDataCache[player.UserId] = data

    -- Criar leaderstats para exibição (apenas valores visuais)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"

    local nivel = Instance.new("IntValue")
    nivel.Name = "Nivel"
    nivel.Value = data.nivel
    nivel.Parent = leaderstats

    local gold = Instance.new("IntValue")
    gold.Name = "Guarani"
    gold.Value = data.gold
    gold.Parent = leaderstats

    leaderstats.Parent = player

    print("[DataController] Dados carregados para " .. player.Name .. " (Nível " .. data.nivel .. ")")
end

function DataController.OnPlayerRemoving(player)
    local data = PlayerDataCache[player.UserId]
    if data then
        DataController.SaveData(player, data)
        PlayerDataCache[player.UserId] = nil
    end
end

-- NOTA: Conexão de eventos movida para ServerMain.lua
-- Isso evita o anti-pattern de auto-conexão no require()

return DataController
```

### 3.8 — Server/ServerMain

```lua
-- ServerMain.lua
-- Entry point do servidor

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Inicializar módulos
local SpawnSystem = require(script.Parent.Modules.SpawnSystem)
local AISystem = require(script.Parent.Modules.AISystem)
local DataController = require(script.Parent.DataController)
local CombatManager = require(script.Parent.CombatManager)
local ShopManager = require(script.Parent.ShopManager)
local TradeManager = require(script.Parent.TradeManager)
local PartyManager = require(script.Parent.PartyManager)

-- Carregar configurações
local MobsConfig = require(ReplicatedStorage.Modules.Config.MobsConfig)
local ClassesConfig = require(ReplicatedStorage.Modules.Config.ClassesConfig)
local Formulas = require(ReplicatedStorage.Modules.Shared.Formulas)

-- Função auxiliar para contar entradas em dicionários (chaves string)
local function countTable(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

print("=========================================")
print("  ROBR - servidor iniciando...")
print("  Mobs carregados: " .. countTable(MobsConfig.Mobs))
print("  Classes carregadas: " .. countTable(ClassesConfig.Classes))
print("=========================================")

-- Conectar eventos de DataController (evita auto-conexão no require)
for _, player in ipairs(Players:GetPlayers()) do
    DataController.OnPlayerAdded(player)
end
Players.PlayerAdded:Connect(DataController.OnPlayerAdded)
Players.PlayerRemoving:Connect(DataController.OnPlayerRemoving)

-- Spawnar todos os mobs ao iniciar
SpawnSystem.Init()
SpawnSystem.SpawnAll()

-- Função para detectar mapa pela posição X do jogador
local function detectarMapa(posX)
    if posX < 100 then
        return "Mapa1_RioIbirapuera"
    elseif posX < 300 then
        return "Mapa2_FlorestaMaeDaMata"
    elseif posX < 500 then
        return "Mapa3_ClareiraQueimada"
    elseif posX < 700 then
        return "Mapa4_CemiterioIndigena"
    elseif posX < 900 then
        return "Mapa5_TemploNasNuvens"
    else
        return "Mapa6_LagoSubterraneo"
    end
end

-- Loop principal de atualização de mobs
local mobsAtivos = SpawnSystem.GetMobsAtivos()
local mobUpdateCounter = 0

RunService.Heartbeat:Connect(function(deltaTime)
    mobUpdateCounter = mobUpdateCounter + deltaTime
    if mobUpdateCounter >= 0.5 then -- Atualizar mobs a cada 0.5s
        mobUpdateCounter = 0

        -- Encontrar jogadores por mapa para aggro
        local jogadoresPorMapa = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local pos = player.Character.HumanoidRootPart.Position
                local mapa = detectarMapa(pos.X)
                if not jogadoresPorMapa[mapa] then
                    jogadoresPorMapa[mapa] = {}
                end
                local playerData = DataController.GetData(player)
                table.insert(jogadoresPorMapa[mapa], {
                    player = player,
                    posicao = pos,
                    hp = player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or 100,
                    hpMax = 100,
                    nivel = playerData and playerData.nivel or 1,
                    STR = 5, AGI = 2, VIT = 5, INT = 1, DEX = 2, LUK = 1, -- Simplificado: usar stats base
                    ATK_base = 0, DEF_base = 0, MATK_base = 0, MDEF_base = 0,
                })
            end
        end

        -- Atualizar IA de cada mob ativo
        for _, mob in ipairs(mobsAtivos) do
            local mapa = mob.mapa or "Mapa1_RioIbirapuera"
            local jogadores = jogadoresPorMapa[mapa] or {}
            AISystem.UpdateMob(mob, 0.5, jogadores)
        end
    end
end)

print("[ServerMain] Servidor iniciado com sucesso!")
```

### 3.9 — Client/ClientMain

```lua
-- ClientMain.lua
-- Entry point do client

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

print("[Client] Inicializando para " .. player.Name)

-- Aguardar personagem
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

print("[Client] Personagem carregado: " .. character.Name)

-- Controles básicos de movimento (já nativo no Roblox)
-- Aqui adicionamos ações de combate e interação

local COMBAT_RANGE = 10 -- studs
local INTERACT_RANGE = 15 -- studs (corrigido: era "local.INTERACT_RANGE")

-- Função para encontrar mob mais próximo (client-side para targeting visual)
local function GetNearestMob() -- Corrigido: era função global
    local nearest = nil
    local nearestDist = COMBAT_RANGE

    -- Buscar mobs no workspace (implementação simplificada)
    -- Na versão real, receber lista do servidor
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:GetAttribute("MobId") then
            if obj.PrimaryPart then
                local dist = (obj.PrimaryPart.Position - rootPart.Position).Magnitude
                if dist < nearestDist then
                    nearest = obj
                    nearestDist = dist
                end
            end
        end
    end

    return nearest
end

-- Input de ataque
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.F then
        -- Ataque básico
        local target = GetNearestMob()
        if target and (target.PrimaryPart.Position - rootPart.Position).Magnitude <= COMBAT_RANGE then
            -- Enviar request de ataque ao servidor
            print("[Client] Atacando " .. target.Name)
            ReplicatedStorage.Remotes.Combat.Attack:FireServer(target:GetAttribute("MobId"))
        end
    elseif input.KeyCode == Enum.KeyCode.E then
        -- Interagir (NPC shop, trade)
        print("[Client] Interagindo...")
        ReplicatedStorage.Remotes.Shop.OpenShop:FireServer()
    elseif input.KeyCode == Enum.KeyCode.Tab then
        -- Abrir inventário
        print("[Client] Abrindo inventário...")
    end
end)

print("[Client] Inicializado com sucesso!")
```

---

## 4. Remotes (Comunicação Client ↔ Server)

### 4.1 — Estrutura de Remotes

```
ReplicatedStorage/
    Remotes/
        Combat/
            Attack (RemoteEvent: Client → Server)
            UseSkill (RemoteEvent: Client → Server)
            DamageResult (RemoteEvent: Server → Client)
        Shop/
            OpenShop (RemoteEvent: Client → Server)
            BuyItem (RemoteEvent: Client → Server)
            SellItem (RemoteEvent: Client → Server)
        Trade/
            RequestTrade (RemoteEvent: Client → Server)
            AcceptTrade (RemoteEvent: Client → Server)
            CancelTrade (RemoteEvent: Client → Server)
        Data/
            RequestData (RemoteFunction: Client → Server)
            UpdateStats (RemoteEvent: Client → Server)
            LevelUp (RemoteEvent: Server → Client)
```

### 4.2 — Exemplo de Remote: Attack

```lua
-- Server: CombatManager.lua (trecho)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DamageCalculator = require(ReplicatedStorage.Modules.Shared.DamageCalculator)
local DataController = require(script.Parent.DataController)

local AttackRemote = ReplicatedStorage.Remotes.Combat.Attack  -- RemoteEvent específico
local DamageResultRemote = ReplicatedStorage.Remotes.Combat.DamageResult

AttackRemote.OnServerEvent:Connect(function(player, targetMobId)
    -- Validar jogador
    local data = DataController.GetData(player)
    if not data then return end

    -- Encontrar mob
    local mob = GetMobById(targetMobId)
    if not mob or mob.estado == "dead" then return end

    -- Montar tabela de stats do jogador para o DamageCalculator
    local playerStats = {
        STR = data.atributosBase and data.atributosBase.STR or 5,
        DEX = data.atributosBase and data.atributosBase.DEX or 2,
        LUK = data.atributosBase and data.atributosBase.LUK or 1,
        INT = data.atributosBase and data.atributosBase.INT or 1,
        AGI = data.atributosBase and data.atributosBase.AGI or 2,
        VIT = data.atributosBase and data.atributosBase.VIT or 5,
        nivel = data.nivel or 1,
        ATK_base = 0, DEF_base = 0, MATK_base = 0, MDEF_base = 0,
    }

    -- Calcular dano usando DamageCalculator (não Formulas.CalcDano diretamente)
    local dano, crit, miss = DamageCalculator.CalcularDano(playerStats, mob, {
        tipoDano = "fisico",
        multiplicador = 1.0,
    })

    if miss then
        -- Notificar miss
        DamageResultRemote:FireAllClients(mob.id, 0, false, true) -- miss=true
        return
    end

    -- Aplicar dano
    mob.hp = mob.hp - dano

    -- Verificar morte
    if mob.hp <= 0 then
        HandleMobDeath(mob, player)
    end

    -- Notificar clients (enviar apenas ID do mob, não o objeto inteiro)
    DamageResultRemote:FireAllClients(mob.id, dano, crit, false)
end)
```

---

## 5. Sistema de Party

### 5.1 — Estrutura

```lua
-- Party.lua (trecho)
local DataController = require(script.Parent.DataController) -- Referência para GiveXP

local Party = {}
Party.__index = Party

function Party.New(leader)
    local self = setmetatable({}, Party)
    self.leader = leader
    self.members = {leader}
    self.maxSize = 4 -- MVP: party de até 4 jogadores
    self.xpBonus = 1.25 -- 25% bônus de XP
    self.dissolved = false
    return self
end

function Party:AddMember(player)
    if self.dissolved then return false, "Party dissolvida" end
    if #self.members >= self.maxSize then
        return false, "Party cheia"
    end
    table.insert(self.members, player)
    return true
end

function Party:RemoveMember(player)
    for i, member in ipairs(self.members) do
        if member == player then
            table.remove(self.members, i)
            break
        end
    end

    -- Se a party ficou vazia, dissolver
    if #self.members == 0 then
        self.dissolved = true
        self.leader = nil
        return
    end

    -- Se o líder saiu, transferir liderança
    if player == self.leader then
        self.leader = self.members[1]
    end
end

function Party:DistributeXP(mob)
    if self.dissolved then return end
    local xpPerMember = math.floor(mob.xpRecompensa * self.xpBonus / #self.members)
    for _, member in ipairs(self.members) do
        -- Dar XP via DataController
        local data = DataController.GetData(member)
        if data then
            data.xp = data.xp + xpPerMember
        end
    end
end

function Party:IsActive()
    return not self.dissolved and #self.members > 0
end

return Party
```

---

## 6. Checklists de Implementação

### Fase 1.1 — Estrutura Base
- [x] Criar estrutura de pastas no Roblox Studio
- [x] Config ModuleScripts (Config de mobs, classes, itens)
- [x] Formulas ModuleScript
- [ ] DataController (save/load com DataStore)
- [ ] ServerMain.lua

### Fase 1.2 — Sistema de Combate
- [x] DamageCalculator.lua
- [x] AISystem.lua
- [x] SpawnSystem.lua
- [ ] CombatManager.lua (integração)
- [ ] Remotes de combate

### Fase 1.3 — Economia
- [ ] ShopManager.lua
- [ ] ShopClient.lua
- [ ] TradeManager.lua
- [ ] TradeClient.lua

### Fase 1.4 — Interface
- [ ] ClientMain.lua
- [ ] HUD (HUD, vida, SP, nível, Guarani)
- [ ] SkillBar (barra de skills)
- [ ] InventoryWindow (inventário)
- [ ] ShopWindow (loja)
- [ ] TradeWindow (trade)

### Fase 1.5 — Progressão
- [ ] Sistema de XP e level up
- [ ] Distribuição de stat points
- [ ] Sistema de skill points
- [ ] Level up notification

---

*Última atualização: 2026-06-08*
