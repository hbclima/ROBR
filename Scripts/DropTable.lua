-- DropTable.lua
-- Tabela de configuração de drops para todos os mobs MVP do ROBR.
-- Read-only: server e client podem ler, ninguém escreve em runtime.
-- Referência: GDD_Fase04_Economia.md (Fase 4)

local DropTable = {}

--[[
    Estrutura de cada drop:
    {
        id = "ITEM_XXX",
        nome = "Nome do Item",
        tipo = "comum" | "consumivel" | "equipamento" | "especial",
        chance = 0.0-100.0,  -- porcentagem de drop
        valorNpc = number,   -- valor em Wira'i quando vendido ao NPC
    }
]]

DropTable.Items = {
    -- MOB_001: Sapo Cururu (5 drops)
    ["MOB_001"] = {
        { id = "ITEM_001", nome = "Carta — Sapo Cururu", tipo = "especial", chance = 0.5, valorNpc = 200 },
        { id = "ITEM_002", nome = "Bolsa de Lodo Cururu", tipo = "equipamento", chance = 3.0, valorNpc = 40 },
        { id = "ITEM_003", nome = "Glande de Sapo", tipo = "consumivel", chance = 15.0, valorNpc = 5 },
        { id = "ITEM_004", nome = "Pedaço de Casca de Árvore", tipo = "comum", chance = 60.0, valorNpc = 2 },
        { id = "ITEM_005", nome = "Pedaço de Lama Seca", tipo = "comum", chance = 55.0, valorNpc = 1 },
    },

    -- MOB_002: Cobra-d'Água (5 drops)
    ["MOB_002"] = {
        { id = "ITEM_006", nome = "Carta — Cobra-d'Água", tipo = "especial", chance = 0.5, valorNpc = 220 },
        { id = "ITEM_007", nome = "Escama Serpentina", tipo = "equipamento", chance = 3.5, valorNpc = 50 },
        { id = "ITEM_008", nome = "Veneno de Cobra", tipo = "consumivel", chance = 18.0, valorNpc = 7 },
        { id = "ITEM_009", nome = "Pele de Réptil", tipo = "comum", chance = 50.0, valorNpc = 5 },
        { id = "ITEM_010", nome = "Dente de Cobra", tipo = "comum", chance = 45.0, valorNpc = 2 },
    },

    -- MOB_003: Mãe-da-Mata (5 drops)
    ["MOB_003"] = {
        { id = "ITEM_011", nome = "Carta — Mãe-da-Mata", tipo = "especial", chance = 0.5, valorNpc = 260 },
        { id = "ITEM_012", nome = "Máscara de Cipó", tipo = "equipamento", chance = 4.0, valorNpc = 60 },
        { id = "ITEM_013", nome = "Pólen Alucinógeno", tipo = "consumivel", chance = 20.0, valorNpc = 9 },
        { id = "ITEM_014", nome = "Pétala Seca", tipo = "comum", chance = 55.0, valorNpc = 5 },
        { id = "ITEM_015", nome = "Cipó Retorcido", tipo = "comum", chance = 50.0, valorNpc = 1 },
    },

    -- MOB_004: Boitatá (5 drops)
    ["MOB_004"] = {
        { id = "ITEM_016", nome = "Carta — Boitatá", tipo = "especial", chance = 0.5, valorNpc = 300 },
        { id = "ITEM_017", nome = "Escama de Fogo Serpente", tipo = "equipamento", chance = 4.5, valorNpc = 75 },
        { id = "ITEM_018", nome = "Chama Azulada", tipo = "consumivel", chance = 22.0, valorNpc = 12 },
        { id = "ITEM_019", nome = "Cinza de Cobra", tipo = "comum", chance = 60.0, valorNpc = 2 },
        { id = "ITEM_020", nome = "Ovo de Serpente", tipo = "comum", chance = 35.0, valorNpc = 8 },
    },

    -- MOB_008: Anhangá (5 drops)
    ["MOB_008"] = {
        { id = "ITEM_021", nome = "Carta — Anhangá", tipo = "especial", chance = 0.5, valorNpc = 380 },
        { id = "ITEM_022", nome = "Manto do Submundo", tipo = "equipamento", chance = 5.0, valorNpc = 90 },
        { id = "ITEM_023", nome = "Essência de Espírito", tipo = "consumivel", chance = 25.0, valorNpc = 15 },
        { id = "ITEM_024", nome = "Fumaça Fantasma", tipo = "comum", chance = 50.0, valorNpc = 3 },
        { id = "ITEM_025", nome = "Osso de Anhangá", tipo = "comum", chance = 30.0, valorNpc = 10 },
    },

    -- MOB_009: Jurupari (5 drops)
    ["MOB_009"] = {
        { id = "ITEM_026", nome = "Carta — Jurupari", tipo = "especial", chance = 0.5, valorNpc = 450 },
        { id = "ITEM_027", nome = "Bastão do Trovão", tipo = "equipamento", chance = 5.5, valorNpc = 120 },
        { id = "ITEM_028", nome = "Runa de Silêncio", tipo = "consumivel", chance = 28.0, valorNpc = 18 },
        { id = "ITEM_029", nome = "Pena de Jurupari", tipo = "comum", chance = 55.0, valorNpc = 10 },
        { id = "ITEM_030", nome = "Fragmento de Máscara", tipo = "comum", chance = 40.0, valorNpc = 4 },
    },

    -- MOB_005: Curupira (5 drops)
    ["MOB_005"] = {
        { id = "ITEM_036", nome = "Carta — Curupira", tipo = "especial", chance = 0.5, valorNpc = 350 },
        { id = "ITEM_037", nome = "Pegada Invertida", tipo = "equipamento", chance = 4.0, valorNpc = 70 },
        { id = "ITEM_038", nome = "Erva de Guardião", tipo = "consumivel", chance = 20.0, valorNpc = 10 },
        { id = "ITEM_039", nome = "Cabelo Vermelho", tipo = "comum", chance = 40.0, valorNpc = 3 },
        { id = "ITEM_040", nome = "Folha de Ipê", tipo = "comum", chance = 35.0, valorNpc = 2 },
    },

    -- MOB_006: Saci Sombrio (5 drops) — drop rate de carta 0.8% (especial)
    ["MOB_006"] = {
        { id = "ITEM_041", nome = "Carta — Saci Sombrio", tipo = "especial", chance = 0.8, valorNpc = 500 },
        { id = "ITEM_042", nome = "Gorro Sombrio do Saci", tipo = "equipamento", chance = 6.5, valorNpc = 120 },
        { id = "ITEM_043", nome = "Fumo Corrompido", tipo = "consumivel", chance = 25.0, valorNpc = 18 },
        { id = "ITEM_044", nome = "Folha de Tabaco", tipo = "comum", chance = 50.0, valorNpc = 2 },
        { id = "ITEM_045", nome = "Pó de Cinza Negra", tipo = "comum", chance = 35.0, valorNpc = 5 },
    },

    -- MOB_007: Boiúna (5 drops) — boss
    ["MOB_007"] = {
        { id = "ITEM_046", nome = "Carta — Boiúna", tipo = "especial", chance = 0.5, valorNpc = 1800 },
        { id = "ITEM_047", nome = "Escama de Boiúna", tipo = "equipamento", chance = 1.2, valorNpc = 900 },
        { id = "ITEM_048", nome = "Muco Aquático", tipo = "consumivel", chance = 6.0, valorNpc = 70 },
        { id = "ITEM_049", nome = "Dente de Serpente Gigante", tipo = "comum", chance = 25.0, valorNpc = 15 },
        { id = "ITEM_050", nome = "Alga Sagrada", tipo = "comum", chance = 30.0, valorNpc = 8 },
    },

    -- MOB_011: Boto Cor-de-Rosa (5 drops)
    ["MOB_011"] = {
        { id = "ITEM_051", nome = "Carta — Boto Cor-de-Rosa", tipo = "especial", chance = 0.5, valorNpc = 350 },
        { id = "ITEM_052", nome = "Pele do Boto", tipo = "equipamento", chance = 4.0, valorNpc = 80 },
        { id = "ITEM_053", nome = "Óleo de Boto", tipo = "consumivel", chance = 20.0, valorNpc = 12 },
        { id = "ITEM_054", nome = "Dente de Boto", tipo = "comum", chance = 45.0, valorNpc = 4 },
        { id = "ITEM_055", nome = "Escama Rosada", tipo = "comum", chance = 50.0, valorNpc = 3 },
    },

    -- MOB_012: Mula Sem Cabeça (5 drops)
    ["MOB_012"] = {
        { id = "ITEM_056", nome = "Carta — Mula Sem Cabeça", tipo = "especial", chance = 0.5, valorNpc = 400 },
        { id = "ITEM_057", nome = "Ferradura de Aço", tipo = "equipamento", chance = 3.5, valorNpc = 85 },
        { id = "ITEM_058", nome = "Tocha Eterna", tipo = "consumivel", chance = 18.0, valorNpc = 15 },
        { id = "ITEM_059", nome = "Pele de Mula", tipo = "comum", chance = 40.0, valorNpc = 5 },
        { id = "ITEM_060", nome = "Casco Queimado", tipo = "comum", chance = 35.0, valorNpc = 3 },
    },

    -- MOB_013: Corpo Seco (5 drops)
    ["MOB_013"] = {
        { id = "ITEM_061", nome = "Carta — Corpo Seco", tipo = "especial", chance = 0.5, valorNpc = 320 },
        { id = "ITEM_062", nome = "Ossos Amaldiçoados", tipo = "equipamento", chance = 4.5, valorNpc = 70 },
        { id = "ITEM_063", nome = "Promessa Quebrada", tipo = "consumivel", chance = 22.0, valorNpc = 10 },
        { id = "ITEM_064", nome = "Pele Seca", tipo = "comum", chance = 48.0, valorNpc = 4 },
        { id = "ITEM_065", nome = "Terra de Cemitério", tipo = "comum", chance = 52.0, valorNpc = 2 },
    },

    -- MOB_014: Onça-Pintada (5 drops)
    ["MOB_014"] = {
        { id = "ITEM_066", nome = "Pele de Onça", tipo = "especial", chance = 0.5, valorNpc = 350 },
        { id = "ITEM_067", nome = "Garra de Arranhadura", tipo = "equipamento", chance = 4.0, valorNpc = 80 },
        { id = "ITEM_068", nome = "Presa de Onça", tipo = "consumivel", chance = 20.0, valorNpc = 12 },
        { id = "ITEM_069", nome = "Carne de Onça", tipo = "comum", chance = 45.0, valorNpc = 6 },
        { id = "ITEM_070", nome = "Pelo Dourado", tipo = "comum", chance = 50.0, valorNpc = 3 },
    },

    -- MOB_015: Capivara (5 drops)
    ["MOB_015"] = {
        { id = "ITEM_071", nome = "Pele de Capivara", tipo = "especial", chance = 0.5, valorNpc = 150 },
        { id = "ITEM_072", nome = "Carne de Capivara", tipo = "consumivel", chance = 30.0, valorNpc = 8 },
        { id = "ITEM_073", nome = "Pelo Macio", tipo = "comum", chance = 55.0, valorNpc = 2 },
        { id = "ITEM_074", nome = "Dente de Roedor", tipo = "comum", chance = 40.0, valorNpc = 1 },
        { id = "ITEM_075", nome = "Pata de Capivara", tipo = "equipamento", chance = 5.0, valorNpc = 15 },
    },

    -- MOB_016: Jacaré-Açu (5 drops)
    ["MOB_016"] = {
        { id = "ITEM_076", nome = "Pele de Jacaré", tipo = "especial", chance = 0.5, valorNpc = 380 },
        { id = "ITEM_077", nome = "Dente de Jacaré", tipo = "equipamento", chance = 4.5, valorNpc = 85 },
        { id = "ITEM_078", nome = "Músculo de Jacaré", tipo = "consumivel", chance = 18.0, valorNpc = 14 },
        { id = "ITEM_079", nome = "Escama Negra", tipo = "comum", chance = 42.0, valorNpc = 5 },
        { id = "ITEM_080", nome = "Gordura de Jacaré", tipo = "comum", chance = 35.0, valorNpc = 3 },
    },
}

-- Retorna a tabela de drops de um mob (ou tabela vazia se não existir)
function DropTable.GetDrops(mobId)
    return DropTable.Items[mobId] or {}
end

-- Retorna os dados de um item específico (busca em todos os mobs)
function DropTable.GetItem(itemId)
    for _, drops in pairs(DropTable.Items) do
        for _, drop in ipairs(drops) do
            if drop.id == itemId then
                return drop
            end
        end
    end
    return nil
end

-- Retorna o valor NPC de um item (Wira'i)
function DropTable.GetValue(itemId)
    local item = DropTable.GetItem(itemId)
    if item then
        return item.valorNpc
    end
    return 0
end

return DropTable
