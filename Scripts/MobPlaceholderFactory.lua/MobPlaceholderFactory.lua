--[[
    MobPlaceholderFactory.lua
    Gera modelos 3D placeholder para todos os 15 mobs MVP.
    
    Destino: ReplicatedStorage/Mobs/ (cada mob como Model)
    
    Cada placeholder:
    - Parts coloridos por raridade (comum=verde, incomum=azul, raro=roxo, elite=laranja, chefe=vermelho)
    - Humanoid funcional (para IA, dano, morte)
    - HumanoidRootPart como PrimaryPart
    - BillboardGui com nome do mob
    - Atributos: MobId, Nome, Nivel, Elemento, Raridade
    
    Uso: Rodar uma vez no Command Bar do Studio:
        require(script.MobPlaceholderFactory).CreateAll()
    
    Ou executar como Script em ServerScriptService (uma única vez).
    
    Dependências:
    - MobsConfig (ReplicatedStorage.Modules.Config.MobsConfig) para atributos
    - Se MobsConfig não existir, usa dados hardcoded abaixo
    
    Última atualização: 2026-06-12
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MobPlaceholderFactory = {}

-------------------------------------------------------------------------------
--- CORES POR RARIDADE
-------------------------------------------------------------------------------

MobPlaceholderFactory.CoresRaridade = {
    ["comum"]   = Color3.fromRGB(76, 175, 80),   -- verde
    ["incomum"] = Color3.fromRGB(33, 150, 243),  -- azul
    ["raro"]    = Color3.fromRGB(156, 39, 176),  -- roxo
    ["elite"]   = Color3.fromRGB(255, 152, 0),   -- laranja
    ["chefe"]   = Color3.fromRGB(244, 67, 54),   -- vermelho
}

-------------------------------------------------------------------------------
--- DADOS DOS MOBS (fallback se MobsConfig não existir)
-------------------------------------------------------------------------------

MobPlaceholderFactory.MobsData = {
    -- Mapa 1: Ybirá-Puera (nível 1-10)
    { id = "MOB_001", nome = "Sapo Cururu",       nivel = 1,  elemento = "agua",            raridade = "comum" },
    { id = "MOB_015", nome = "Capivara",           nivel = 1,  elemento = "neutro",         raridade = "comum" },
    { id = "MOB_002", nome = "Cobra-d'Agua",       nivel = 5,  elemento = "agua",           raridade = "comum" },

    -- Mapa 2: Floresta Mãe-da-Mata (nível 10-15)
    { id = "MOB_003", nome = "Mae-da-Mata",        nivel = 10, elemento = "terra",          raridade = "incomum" },
    { id = "MOB_011", nome = "Boto Cor-de-Rosa",   nivel = 12, elemento = "agua",           raridade = "raro" },
    { id = "MOB_013", nome = "Corpo Seco",         nivel = 10, elemento = "sombra",         raridade = "raro" },

    -- Mapa 3: Tavy-Katu (nível 15-22)
    { id = "MOB_004", nome = "Boitata",            nivel = 15, elemento = "fogo",           raridade = "incomum" },
    { id = "MOB_012", nome = "Mula Sem Cabeca",    nivel = 18, elemento = "fogo",           raridade = "elite" },
    { id = "MOB_016", nome = "Jacare-Acu",         nivel = 16, elemento = "neutro",         raridade = "raro" },

    -- Mapa 4: Tupã-Mbara (nível 20-30)
    { id = "MOB_005", nome = "Curupira",           nivel = 20, elemento = "terra",          raridade = "raro" },
    { id = "MOB_008", nome = "Anhanga",            nivel = 25, elemento = "sombra",         raridade = "raro" },
    { id = "MOB_014", nome = "Onca-Pintada",       nivel = 20, elemento = "neutro",         raridade = "raro" },
    { id = "MOB_006", nome = "Saci Sombrio",       nivel = 25, elemento = "vento corrompido", raridade = "elite" },
    { id = "MOB_009", nome = "Jurupari",           nivel = 25, elemento = "vento",          raridade = "elite" },

    -- Mapa 6: Ygara-Mbya (Boss)
    { id = "MOB_007", nome = "Boiuna",             nivel = 30, elemento = "agua",           raridade = "chefe" },
}

-------------------------------------------------------------------------------
--- GEOMETRIA POR TIPO DE MOB
-------------------------------------------------------------------------------

--- Retorna a configuração de Parts para criar o modelo visual do mob.
--- @param mobData table — dados do mob
--- @return table — lista de { tipo, tamanho, posição, cor, material }
local function GetGeometria(mobData)
    local cor = MobPlaceholderFactory.CoresRaridade[mobData.raridade] or Color3.fromRGB(128, 128, 128)
    local partes = {}

    -- Escala base por raridade
    local escala = 1.0
    if mobData.raridade == "incomum" then escala = 1.1
    elseif mobData.raridade == "raro" then escala = 1.2
    elseif mobData.raridade == "elite" then escala = 1.4
    elseif mobData.raridade == "chefe" then escala = 2.5
    end

    -- Corpo base (todo mob tem)
    local corpoTamanho = Vector3.new(2, 2, 2) * escala
    table.insert(partes, {
        nome = "Corpo",
        tipo = "Part",
        tamanho = corpoTamanho,
        posicao = Vector3.new(0, 1 * escala, 0),
        cor = cor,
        material = Enum.Material.Plastic,
        forma = Enum.PartType.Ball,
    })

    -- Cabeça (todo mob tem)
    local cabecaTamanho = Vector3.new(1.2, 1.2, 1.2) * escala
    table.insert(partes, {
        nome = "Cabeca",
        tipo = "Part",
        tamanho = cabecaTamanho,
        posicao = Vector3.new(0, 2.5 * escala, 0),
        cor = cor,
        material = Enum.Material.Plastic,
        forma = Enum.PartType.Ball,
    })

    -- Olhos (2 esferas pretas)
    table.insert(partes, {
        nome = "OlhoEsq",
        tipo = "Part",
        tamanho = Vector3.new(0.25, 0.25, 0.25) * escala,
        posicao = Vector3.new(-0.3 * escala, 2.7 * escala, 0.5 * escala),
        cor = Color3.fromRGB(20, 20, 20),
        material = Enum.Material.Neon,
        forma = Enum.PartType.Ball,
    })
    table.insert(partes, {
        nome = "OlhoDir",
        tipo = "Part",
        tamanho = Vector3.new(0.25, 0.25, 0.25) * escala,
        posicao = Vector3.new(0.3 * escala, 2.7 * escala, 0.5 * escala),
        cor = Color3.fromRGB(20, 20, 20),
        material = Enum.Material.Neon,
        forma = Enum.PartType.Ball,
    })

    -- Detalhes específicos por tipo de mob
    if mobData.id == "MOB_001" then
        -- Sapo Cururu: corpo achatado, pernas curtas
        partes[1].tamanho = Vector3.new(2.5, 1.2, 2.5) * escala
        partes[1].posicao = Vector3.new(0, 0.6 * escala, 0)
        partes[2].posicao = Vector3.new(0, 1.5 * escala, 0.5 * escala)
        -- Pernas
        for _, offset in ipairs({{-1, -1}, {1, -1}, {-1, 1}, {1, 1}}) do
            table.insert(partes, {
                nome = "Perna",
                tipo = "Part",
                tamanho = Vector3.new(0.5, 0.8, 0.5) * escala,
                posicao = Vector3.new(offset[1] * escala, 0.4 * escala, offset[2] * escala),
                cor = cor,
                material = Enum.Material.Plastic,
                forma = Enum.PartType.Block,
            })
        end

    elseif mobData.id == "MOB_015" then
        -- Capivara: corpo cilíndrico, cabeça arredondada
        partes[1].tamanho = Vector3.new(2.5, 1.5, 1.8) * escala
        partes[1].forma = Enum.PartType.Block
        partes[2].tamanho = Vector3.new(1.4, 1.2, 1.4) * escala
        partes[2].posicao = Vector3.new(0, 2.2 * escala, 0.8 * escala)
        -- Focinho
        table.insert(partes, {
            nome = "Focinho",
            tipo = "Part",
            tamanho = Vector3.new(0.6, 0.5, 0.8) * escala,
            posicao = Vector3.new(0, 2.0 * escala, 1.8 * escala),
            cor = Color3.fromRGB(100, 80, 60),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Ball,
        })

    elseif mobData.id == "MOB_002" then
        -- Cobra-d'Água: corpo segmentado (série de esferas)
        partes[1].tamanho = Vector3.new(0.8, 0.8, 0.8) * escala
        partes[1].posicao = Vector3.new(0, 0.5 * escala, 0)
        partes[2].posicao = Vector3.new(0, 0.5 * escala, 1.0 * escala)
        -- Segmentos do corpo
        for i = 1, 5 do
            table.insert(partes, {
                nome = "Segmento" .. i,
                tipo = "Part",
                tamanho = Vector3.new(0.7 - i * 0.05, 0.7 - i * 0.05, 0.7 - i * 0.05) * escala,
                posicao = Vector3.new(0, 0.5 * escala, -i * 0.8 * escala),
                cor = cor,
                material = Enum.Material.Plastic,
                forma = Enum.PartType.Ball,
            })
        end

    elseif mobData.id == "MOB_003" then
        -- Mãe-da-Mata: humanoide com vestido
        partes[1].tamanho = Vector3.new(1.8, 2.5, 1.5) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].posicao = Vector3.new(0, 1.25 * escala, 0)
        partes[2].tamanho = Vector3.new(1.0, 1.0, 1.0) * escala
        partes[2].posicao = Vector3.new(0, 3.0 * escala, 0)
        -- Vestido (cone invertido)
        table.insert(partes, {
            nome = "Vestido",
            tipo = "Part",
            tamanho = Vector3.new(2.5, 2.0, 2.5) * escala,
            posicao = Vector3.new(0, 1.0 * escala, 0),
            cor = Color3.fromRGB(34, 120, 15),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })
        -- Cabelo longo
        table.insert(partes, {
            nome = "Cabelo",
            tipo = "Part",
            tamanho = Vector3.new(1.3, 2.0, 1.3) * escala,
            posicao = Vector3.new(0, 3.5 * escala, -0.3 * escala),
            cor = Color3.fromRGB(60, 40, 20),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })

    elseif mobData.id == "MOB_011" then
        -- Boto Cor-de-Rosa: corpo de golfinho
        partes[1].tamanho = Vector3.new(1.5, 1.2, 3.0) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].posicao = Vector3.new(0, 0.6 * escala, 0)
        partes[1].cor = Color3.fromRGB(255, 182, 193) -- rosa
        partes[2].tamanho = Vector3.new(1.0, 0.8, 1.2) * escala
        partes[2].posicao = Vector3.new(0, 1.0 * escala, 1.5 * escala)
        partes[2].cor = Color3.fromRGB(255, 182, 193)
        -- Barbatana dorsal
        table.insert(partes, {
            nome = "Barbatana",
            tipo = "Part",
            tamanho = Vector3.new(0.2, 0.8, 0.6) * escala,
            posicao = Vector3.new(0, 1.5 * escala, -0.3 * escala),
            cor = Color3.fromRGB(255, 150, 170),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })
        -- Rabo
        table.insert(partes, {
            nome = "Rabo",
            tipo = "Part",
            tamanho = Vector3.new(1.2, 0.3, 0.8) * escala,
            posicao = Vector3.new(0, 0.6 * escala, -1.8 * escala),
            cor = Color3.fromRGB(255, 182, 193),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })

    elseif mobData.id == "MOB_013" then
        -- Corpo Seco: humanoide esquelético escuro
        partes[1].tamanho = Vector3.new(1.5, 2.5, 1.2) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].cor = Color3.fromRGB(80, 60, 40)
        partes[2].tamanho = Vector3.new(0.9, 0.9, 0.9) * escala
        partes[2].posicao = Vector3.new(0, 3.0 * escala, 0)
        partes[2].cor = Color3.fromRGB(200, 180, 150)
        -- Olhos brilhantes (sombra)
        partes[3].cor = Color3.fromRGB(255, 50, 50)
        partes[4].cor = Color3.fromRGB(255, 50, 50)
        -- Roupas rasgadas
        table.insert(partes, {
            nome = "Manto",
            tipo = "Part",
            tamanho = Vector3.new(2.0, 2.0, 1.5) * escala,
            posicao = Vector3.new(0, 1.5 * escala, -0.2 * escala),
            cor = Color3.fromRGB(50, 40, 30),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })

    elseif mobData.id == "MOB_004" then
        -- Boitatá: serpente de fogo
        partes[1].tamanho = Vector3.new(1.0, 1.0, 1.0) * escala
        partes[1].cor = Color3.fromRGB(255, 100, 0)
        partes[1].material = Enum.Material.Neon
        partes[2].tamanho = Vector3.new(0.8, 0.8, 0.8) * escala
        partes[2].posicao = Vector3.new(0, 0.5 * escala, 1.0 * escala)
        partes[2].cor = Color3.fromRGB(255, 200, 0)
        partes[2].material = Enum.Material.Neon
        -- Segmentos de fogo
        for i = 1, 6 do
            table.insert(partes, {
                nome = "Fogo" .. i,
                tipo = "Part",
                tamanho = Vector3.new(0.9 - i * 0.08, 0.9 - i * 0.08, 0.9 - i * 0.08) * escala,
                posicao = Vector3.new(0, 0.5 * escala, -i * 0.9 * escala),
                cor = Color3.fromRGB(255, 80 + i * 20, 0),
                material = Enum.Material.Neon,
                forma = Enum.PartType.Ball,
            })
        end
        -- Chamas (partículas visuais via PointLight)
        table.insert(partes, {
            nome = "LuzFogo",
            tipo = "PointLight",
            tamanho = Vector3.new(0, 0, 0),
            posicao = Vector3.new(0, 1 * escala, 0),
            cor = Color3.fromRGB(255, 150, 0),
            material = Enum.Material.Neon,
        })

    elseif mobData.id == "MOB_012" then
        -- Mula Sem Cabeça: cavalo sem cabeça, fogo no pescoço
        partes[1].tamanho = Vector3.new(2.0, 2.0, 3.5) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].cor = Color3.fromRGB(80, 50, 30)
        -- Sem cabeça — só pescoço com fogo
        table.insert(partes, {
            nome = "Pescoco",
            tipo = "Part",
            tamanho = Vector3.new(0.8, 1.0, 0.8) * escala,
            posicao = Vector3.new(0, 2.5 * escala, 1.5 * escala),
            cor = Color3.fromRGB(80, 50, 30),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })
        -- Fogo no pescoço (substitui cabeça)
        table.insert(partes, {
            nome = "FogoPescoco",
            tipo = "Part",
            tamanho = Vector3.new(1.2, 1.5, 1.2) * escala,
            posicao = Vector3.new(0, 3.2 * escala, 1.5 * escala),
            cor = Color3.fromRGB(255, 100, 0),
            material = Enum.Material.Neon,
            forma = Enum.PartType.Ball,
        })
        -- Pernas
        for _, offset in ipairs({{-0.8, -1.2}, {0.8, -1.2}, {-0.8, 1.2}, {0.8, 1.2}}) do
            table.insert(partes, {
                nome = "Perna",
                tipo = "Part",
                tamanho = Vector3.new(0.5, 1.5, 0.5) * escala,
                posicao = Vector3.new(offset[1] * escala, -0.5 * escala, offset[2] * escala),
                cor = Color3.fromRGB(60, 40, 20),
                material = Enum.Material.Plastic,
                forma = Enum.PartType.Block,
            })
        end

    elseif mobData.id == "MOB_016" then
        -- Jacaré-Açu: corpo alongado, mandíbula forte
        partes[1].tamanho = Vector3.new(2.0, 1.2, 4.0) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].cor = Color3.fromRGB(50, 80, 40)
        partes[2].tamanho = Vector3.new(1.0, 0.8, 1.5) * escala
        partes[2].posicao = Vector3.new(0, 0.8 * escala, 2.2 * escala)
        partes[2].cor = Color3.fromRGB(50, 80, 40)
        -- Mandíbula superior
        table.insert(partes, {
            nome = "Mandibula",
            tipo = "Part",
            tamanho = Vector3.new(1.8, 0.4, 1.5) * escala,
            posicao = Vector3.new(0, 1.0 * escala, 2.5 * escala),
            cor = Color3.fromRGB(40, 65, 30),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })
        -- Cauda
        table.insert(partes, {
            nome = "Cauda",
            tipo = "Part",
            tamanho = Vector3.new(1.5, 0.8, 2.0) * escala,
            posicao = Vector3.new(0, 0.6 * escala, -2.5 * escala),
            cor = Color3.fromRGB(50, 80, 40),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })

    elseif mobData.id == "MOB_005" then
        -- Curupira: pequeno humanoide, cabelo vermelho, pés virados
        partes[1].tamanho = Vector3.new(1.2, 1.8, 1.0) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].cor = Color3.fromRGB(180, 140, 100)
        partes[2].tamanho = Vector3.new(0.8, 0.8, 0.8) * escala
        partes[2].posicao = Vector3.new(0, 2.5 * escala, 0)
        partes[2].cor = Color3.fromRGB(180, 140, 100)
        -- Cabelo vermelho (espetado)
        table.insert(partes, {
            nome = "CabeloVermelho",
            tipo = "Part",
            tamanho = Vector3.new(1.2, 1.0, 1.2) * escala,
            posicao = Vector3.new(0, 3.2 * escala, 0),
            cor = Color3.fromRGB(200, 30, 30),
            material = Enum.Material.Neon,
            forma = Enum.PartType.Ball,
        })
        -- Pés virados (visual: pés apontando para trás)
        table.insert(partes, {
            nome = "PeViradoEsq",
            tipo = "Part",
            tamanho = Vector3.new(0.4, 0.6, 0.8) * escala,
            posicao = Vector3.new(-0.3 * escala, -0.8 * escala, 0.3 * escala),
            cor = Color3.fromRGB(100, 60, 40),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })
        table.insert(partes, {
            nome = "PeViradoDir",
            tipo = "Part",
            tamanho = Vector3.new(0.4, 0.6, 0.8) * escala,
            posicao = Vector3.new(0.3 * escala, -0.8 * escala, 0.3 * escala),
            cor = Color3.fromRGB(100, 60, 40),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })

    elseif mobData.id == "MOB_008" then
        -- Anhangá: figura sombria com asas
        partes[1].tamanho = Vector3.new(1.8, 2.5, 1.5) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].cor = Color3.fromRGB(30, 20, 40)
        partes[2].tamanho = Vector3.new(1.0, 1.0, 1.0) * escala
        partes[2].posicao = Vector3.new(0, 3.0 * escala, 0)
        partes[2].cor = Color3.fromRGB(50, 30, 60)
        -- Asas
        table.insert(partes, {
            nome = "AsaEsq",
            tipo = "Part",
            tamanho = Vector3.new(0.1, 2.0, 2.5) * escala,
            posicao = Vector3.new(-1.5 * escala, 2.0 * escala, -0.3 * escala),
            cor = Color3.fromRGB(20, 10, 30),
            material = Enum.Material.ForceField,
            forma = Enum.PartType.Block,
        })
        table.insert(partes, {
            nome = "AsaDir",
            tipo = "Part",
            tamanho = Vector3.new(0.1, 2.0, 2.5) * escala,
            posicao = Vector3.new(1.5 * escala, 2.0 * escala, -0.3 * escala),
            cor = Color3.fromRGB(20, 10, 30),
            material = Enum.Material.ForceField,
            forma = Enum.PartType.Block,
        })
        -- Olhos brilhantes
        partes[3].cor = Color3.fromRGB(200, 50, 255)
        partes[4].cor = Color3.fromRGB(200, 50, 255)

    elseif mobData.id == "MOB_014" then
        -- Onça-Pintada: felino com manchas
        partes[1].tamanho = Vector3.new(1.8, 1.5, 3.0) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].cor = Color3.fromRGB(210, 180, 50)
        partes[2].tamanho = Vector3.new(1.2, 1.0, 1.2) * escala
        partes[2].posicao = Vector3.new(0, 1.2 * escala, 1.8 * escala)
        partes[2].cor = Color3.fromRGB(210, 180, 50)
        -- Manchas (esferas pretas no corpo)
        for i = 1, 4 do
            table.insert(partes, {
                nome = "Mancha" .. i,
                tipo = "Part",
                tamanho = Vector3.new(0.3, 0.15, 0.3) * escala,
                posicao = Vector3.new(
                    (math.random() - 0.5) * 1.2 * escala,
                    1.5 * escala,
                    (math.random() - 0.5) * 2.0 * escala
                ),
                cor = Color3.fromRGB(30, 20, 10),
                material = Enum.Material.Plastic,
                forma = Enum.PartType.Ball,
            })
        end
        -- Cauda
        table.insert(partes, {
            nome = "Cauda",
            tipo = "Part",
            tamanho = Vector3.new(0.3, 0.3, 1.5) * escala,
            posicao = Vector3.new(0, 1.0 * escala, -2.0 * escala),
            cor = Color3.fromRGB(210, 180, 50),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })

    elseif mobData.id == "MOB_006" then
        -- Saci Sombrio: já tem modelo procedimental — criar placeholder simples
        partes[1].tamanho = Vector3.new(1.0, 1.5, 1.0) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].cor = Color3.fromRGB(60, 40, 80)
        partes[2].tamanho = Vector3.new(0.7, 0.7, 0.7) * escala
        partes[2].posicao = Vector3.new(0, 2.2 * escala, 0)
        partes[2].cor = Color3.fromRGB(100, 80, 120)
        -- Gorro vermelho
        table.insert(partes, {
            nome = "Gorro",
            tipo = "Part",
            tamanho = Vector3.new(0.9, 0.6, 0.9) * escala,
            posicao = Vector3.new(0, 2.8 * escala, 0),
            cor = Color3.fromRGB(200, 30, 30),
            material = Enum.Material.Neon,
            forma = Enum.PartType.Ball,
        })
        -- Uma perna só
        table.insert(partes, {
            nome = "PernaUnica",
            tipo = "Part",
            tamanho = Vector3.new(0.4, 1.2, 0.4) * escala,
            posicao = Vector3.new(0, -0.5 * escala, 0),
            cor = Color3.fromRGB(60, 40, 80),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })

    elseif mobData.id == "MOB_009" then
        -- Jurupari: humanoide demoníaco com chifres
        partes[1].tamanho = Vector3.new(2.0, 2.8, 1.5) * escala
        partes[1].forma = Enum.PartType.Block
        partes[1].cor = Color3.fromRGB(120, 30, 30)
        partes[2].tamanho = Vector3.new(1.1, 1.1, 1.1) * escala
        partes[2].posicao = Vector3.new(0, 3.2 * escala, 0)
        partes[2].cor = Color3.fromRGB(150, 50, 50)
        -- Chifres
        table.insert(partes, {
            nome = "ChifreEsq",
            tipo = "Part",
            tamanho = Vector3.new(0.2, 1.0, 0.2) * escala,
            posicao = Vector3.new(-0.5 * escala, 4.0 * escala, 0),
            cor = Color3.fromRGB(60, 20, 20),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })
        table.insert(partes, {
            nome = "ChifreDir",
            tipo = "Part",
            tamanho = Vector3.new(0.2, 1.0, 0.2) * escala,
            posicao = Vector3.new(0.5 * escala, 4.0 * escala, 0),
            cor = Color3.fromRGB(60, 20, 20),
            material = Enum.Material.Plastic,
            forma = Enum.PartType.Block,
        })
        -- Olhos demoníacos
        partes[3].cor = Color3.fromRGB(255, 255, 0)
        partes[4].cor = Color3.fromRGB(255, 255, 0)

    elseif mobData.id == "MOB_007" then
        -- Boiúna: cobra gigante aquática
        partes[1].tamanho = Vector3.new(2.5, 2.5, 2.5) * escala
        partes[1].cor = Color3.fromRGB(20, 80, 120)
        partes[1].material = Enum.Material.SmoothPlastic
        partes[2].tamanho = Vector3.new(2.0, 2.0, 2.0) * escala
        partes[2].posicao = Vector3.new(0, 2.0 * escala, 2.0 * escala)
        partes[2].cor = Color3.fromRGB(30, 100, 140)
        -- Segmentos do corpo (cobra longa)
        for i = 1, 8 do
            table.insert(partes, {
                nome = "Segmento" .. i,
                tipo = "Part",
                tamanho = Vector3.new(2.3 - i * 0.15, 2.3 - i * 0.15, 2.3 - i * 0.15) * escala,
                posicao = Vector3.new(0, 1.5 * escala, -i * 2.0 * escala),
                cor = Color3.fromRGB(20 + i * 5, 80 + i * 8, 120 + i * 5),
                material = Enum.Material.SmoothPlastic,
                forma = Enum.PartType.Ball,
            })
        end
        -- Olhos luminosos
        partes[3].cor = Color3.fromRGB(0, 255, 200)
        partes[3].material = Enum.Material.Neon
        partes[4].cor = Color3.fromRGB(0, 255, 200)
        partes[4].material = Enum.Material.Neon
    end

    return partes, escala
end

-------------------------------------------------------------------------------
--- CRIAR UM MOB PLACEHOLDER
-------------------------------------------------------------------------------

--- Cria o modelo 3D placeholder de um mob.
--- @param mobData table — dados do mob (id, nome, nivel, elemento, raridade)
--- @return Model|nil — modelo criado ou nil se falhar
function MobPlaceholderFactory.CreateMob(mobData)
    local model = Instance.new("Model")
    model.Name = mobData.id

    local partes, escala = GetGeometria(mobData)

    -- Criar cada parte visual
    for _, p in ipairs(partes) do
        if p.tipo == "PointLight" then
            local light = Instance.new("PointLight")
            light.Color = p.cor
            light.Brightness = 2
            light.Range = 15 * escala
            light.Parent = model
            -- Ancorar ao HumanoidRootPart depois
        else
            local part = Instance.new("Part")
            part.Name = p.nome
            part.Size = p.tamanho
            part.Position = p.posicao
            part.Color = p.cor
            part.Material = p.material or Enum.Material.Plastic
            part.Anchored = false
            part.CanCollide = false
            if p.forma then
                part.Shape = p.forma
            end
            part.Parent = model
        end
    end

    -- HumanoidRootPart (necessário para IA e movimento)
    local hrp = Instance.new("Part")
    hrp.Name = "HumanoidRootPart"
    hrp.Size = Vector3.new(2, 2, 1) * escala
    hrp.Position = Vector3.new(0, 1 * escala, 0)
    hrp.Anchored = false
    hrp.CanCollide = true
    hrp.Transparency = 1 -- invisível
    hrp.Parent = model
    model.PrimaryPart = hrp

    -- Humanoid (necessário para HP, dano, morte)
    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = 100 + (mobData.nivel * 50)
    humanoid.Health = humanoid.MaxHealth
    humanoid.WalkSpeed = 8 + (mobData.nivel * 0.5)
    humanoid.Parent = model

    -- BillboardGui com nome do mob
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "MobNameTag"
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 3 * escala, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = hrp

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = mobData.nome
    nameLabel.TextColor3 = MobPlaceholderFactory.CoresRaridade[mobData.raridade] or Color3.new(1, 1, 1)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboard

    -- Atributos do mob (usados pelo SpawnSystem/AISystem)
    model:SetAttribute("MobId", mobData.id)
    model:SetAttribute("Nome", mobData.nome)
    model:SetAttribute("Nivel", mobData.nivel)
    model:SetAttribute("Elemento", mobData.elemento)
    model:SetAttribute("Raridade", mobData.raridade)

    -- Weldar todas as partes ao HumanoidRootPart (para mover junto)
    for _, part in ipairs(model:GetChildren()) do
        if part:IsA("BasePart") and part ~= hrp then
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hrp
            weld.Part1 = part
            weld.Parent = hrp
        end
    end

    return model
end

-------------------------------------------------------------------------------
--- CRIAR TODOS OS MOBS
-------------------------------------------------------------------------------

--- Cria todos os 15 mobs placeholder e salva em ReplicatedStorage/Mobs/
--- @return table — lista de modelos criados
function MobPlaceholderFactory.CreateAll()
    -- Criar pasta Mobs em ReplicatedStorage
    local mobsFolder = ReplicatedStorage:FindFirstChild("Mobs")
    if not mobsFolder then
        mobsFolder = Instance.new("Folder")
        mobsFolder.Name = "Mobs"
        mobsFolder.Parent = ReplicatedStorage
    end

    local criados = {}

    for _, mobData in ipairs(MobPlaceholderFactory.MobsData) do
        -- Remover versão anterior se existir
        local existente = mobsFolder:FindFirstChild(mobData.id)
        if existente then
            existente:Destroy()
        end

        local model = MobPlaceholderFactory.CreateMob(mobData)
        if model then
            model.Parent = mobsFolder
            table.insert(criados, model)
            print("[MobPlaceholderFactory] Criado: " .. mobData.id .. " (" .. mobData.nome .. ")")
        else
            warn("[MobPlaceholderFactory] Falha ao criar: " .. mobData.id)
        end
    end

    print("[MobPlaceholderFactory] " .. #criados .. "/15 mobs placeholder criados em ReplicatedStorage/Mobs/")
    return criados
end

-------------------------------------------------------------------------------
--- COMMAND BAR (executar no Studio)
-------------------------------------------------------------------------------

--[[
    Para usar no Roblox Studio:
    
    1. Coloque este ModuleScript em ServerScriptService
    2. No Command Bar, execute:
       require(game.ServerScriptService.MobPlaceholderFactory).CreateAll()
    
    Ou coloque em ReplicatedStorage e execute:
       require(game.ReplicatedStorage.MobPlaceholderFactory).CreateAll()
    
    Resultado: 15 modelos em ReplicatedStorage/Mobs/, cada um com:
    - Parts coloridos por raridade
    - Humanoid funcional
    - HumanoidRootPart
    - BillboardGui com nome
    - Atributos (MobId, Nome, Nivel, Elemento, Raridade)
--]]

return MobPlaceholderFactory
