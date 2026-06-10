-- NPCShop.lua
-- Gerencia a loja do NPC: vende itens ao jogador e compra drops do jogador.
-- Server-only: roda em ServerScriptService.
-- Dependências: DropTable, DataController, InventoryManager

local DropTable = require(game.ReplicatedStorage.Modules.Config.DropTable)
local DataController = require(game.ReplicatedStorage.Modules.Server.DataController)
local InventoryManager = require(game.ReplicatedStorage.Modules.Server.InventoryManager)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local EconomyRemotes = Remotes:WaitForChild("Economy")

local NPCShop = {}

--[[
    Itens vendidos pelo NPC (jogador compra).
    id: identificador único do item na loja
    preco: custo em Wira'i
    nivelMin: nível mínimo do jogador para comprar
    slot: slot de equipamento (se aplicável)
    stats: bônus de atributo (se aplicável)
]]
NPCShop.SHOP_ITEMS = {
    -- Consumíveis (7 itens)
    { id = "SHOP_001", nome = "Poção de Cura Pequena", preco = 10, nivelMin = 1, tipo = "consumivel", efeito = "Restaura 15% HP" },
    { id = "SHOP_002", nome = "Poção de Cura Média", preco = 25, nivelMin = 10, tipo = "consumivel", efeito = "Restaura 35% HP" },
    { id = "SHOP_003", nome = "Poção de Cura Grande", preco = 60, nivelMin = 20, tipo = "consumivel", efeito = "Restaura 60% HP" },
    { id = "SHOP_004", nome = "Poção de SP Pequena", preco = 15, nivelMin = 1, tipo = "consumivel", efeito = "Restaura 20% SP" },
    { id = "SHOP_005", nome = "Poção de SP Média", preco = 35, nivelMin = 10, tipo = "consumivel", efeito = "Restaura 40% SP" },
    { id = "SHOP_006", nome = "Antídoto", preco = 20, nivelMin = 1, tipo = "consumivel", efeito = "Remove veneno" },
    { id = "SHOP_007", nome = "Erva Revigorante", preco = 30, nivelMin = 10, tipo = "consumivel", efeito = "Remove medo, confusão, sono" },

    -- Equipamentos (12 itens)
    { id = "SHOP_008", nome = "Tacape Simples", preco = 50, nivelMin = 1, tipo = "equipamento", slot = "Arma", stats = "ATK +5" },
    { id = "SHOP_009", nome = "Tacape de Madeira", preco = 120, nivelMin = 10, tipo = "equipamento", slot = "Arma", stats = "ATK +12" },
    { id = "SHOP_010", nome = "Tacape de Pedra", preco = 300, nivelMin = 20, tipo = "equipamento", slot = "Arma", stats = "ATK +25" },
    { id = "SHOP_011", nome = "Cajado Simples", preco = 45, nivelMin = 1, tipo = "equipamento", slot = "Arma", stats = "MATK +6" },
    { id = "SHOP_012", nome = "Cajado de Osso", preco = 110, nivelMin = 10, tipo = "equipamento", slot = "Arma", stats = "MATK +14" },
    { id = "SHOP_013", nome = "Cajado de Pena", preco = 280, nivelMin = 20, tipo = "equipamento", slot = "Arma", stats = "MATK +28" },
    { id = "SHOP_014", nome = "Roupa de Fibra", preco = 30, nivelMin = 1, tipo = "equipamento", slot = "Armadura", stats = "DEF +3" },
    { id = "SHOP_015", nome = "Couro Leve", preco = 80, nivelMin = 10, tipo = "equipamento", slot = "Armadura", stats = "DEF +8" },
    { id = "SHOP_016", nome = "Couro Tratado", preco = 200, nivelMin = 20, tipo = "equipamento", slot = "Armadura", stats = "DEF +18" },
    { id = "SHOP_017", nome = "Máscara de Palha", preco = 25, nivelMin = 1, tipo = "equipamento", slot = "Capacete", stats = "DEF +2" },
    { id = "SHOP_018", nome = "Máscara de Madeira", preco = 60, nivelMin = 10, tipo = "equipamento", slot = "Capacete", stats = "DEF +5" },
    { id = "SHOP_019", nome = "Cocar Simples", preco = 40, nivelMin = 1, tipo = "equipamento", slot = "Capacete", stats = "DEF +3, INT +1" },
    { id = "SHOP_020", nome = "Cipó Trançado", preco = 100, nivelMin = 10, tipo = "equipamento", slot = "Acessório", stats = "VIT +2" },
    { id = "SHOP_021", nome = "Amuleto de Osso", preco = 150, nivelMin = 15, tipo = "equipamento", slot = "Acessório", stats = "INT +3" },
}

--[[
    Jogador compra um item do NPC.
    @param player Player
    @param itemId string — ID do item na loja (ex: "SHOP_001")
    @param quantity number
    @return table — { success: bool, message: string, newBalance: number }
]]
function NPCShop.BuyItem(player, itemId, quantity)
    quantity = quantity or 1

    -- Busca o item na loja
    local shopItem = nil
    for _, item in ipairs(NPCShop.SHOP_ITEMS) do
        if item.id == itemId then
            shopItem = item
            break
        end
    end

    if not shopItem then
        return { success = false, message = "Item não encontrado na loja.", newBalance = 0 }
    end

    -- Verifica nível mínimo
    local playerLevel = DataController.GetData(player, "level") or 1
    if playerLevel < shopItem.nivelMin then
        return { success = false, message = "Nível mínimo: " .. shopItem.nivelMin, newBalance = 0 }
    end

    -- Verifica Wira'i suficiente
    local totalCost = shopItem.preco * quantity
    local playerMoney = DataController.GetData(player, "wirai") or 0
    if playerMoney < totalCost then
        return { success = false, message = "Wira'i insuficiente.", newBalance = playerMoney }
    end

    -- Debita Wira'i
    DataController.UpdateData(player, "wirai", playerMoney - totalCost)

    -- Adiciona item ao inventário
    local success, err = pcall(function()
        for i = 1, quantity do
            InventoryManager.AddItem(player, itemId, 1)
        end
    end)

    if not success then
        -- Rollback: devolve Wira'i
        DataController.UpdateData(player, "wirai", playerMoney)
        warn("[NPCShop] Erro ao adicionar item:", err)
        return { success = false, message = "Erro ao adicionar item ao inventário.", newBalance = playerMoney }
    end

    local newBalance = DataController.GetData(player, "wirai") or 0
    return { success = true, message = "Compra realizada!", newBalance = newBalance }
end

--[[
    Jogador vende um item ao NPC.
    O NPC compra qualquer drop de mob pelo valor da DropTable.
    @param player Player
    @param itemId string — ID do item (ex: "ITEM_001")
    @param quantity number
    @return table — { success: bool, message: string, newBalance: number, soldValue: number }
]]
function NPCShop.SellItem(player, itemId, quantity)
    quantity = quantity or 1

    -- Verifica se o item existe na DropTable (é um drop de mob)
    local itemData = DropTable.GetItem(itemId)
    if not itemData then
        return { success = false, message = "Este item não pode ser vendido.", newBalance = 0, soldValue = 0 }
    end

    -- Verifica se o jogador tem o item no inventário
    local itemCount = InventoryManager.GetItemCount(player, itemId) or 0
    if itemCount < quantity then
        return { success = false, message = "Você não tem esse item.", newBalance = 0, soldValue = 0 }
    end

    -- Calcula valor total
    local totalValue = itemData.valorNpc * quantity

    -- Remove item do inventário
    local success, err = pcall(function()
        InventoryManager.RemoveItem(player, itemId, quantity)
    end)

    if not success then
        warn("[NPCShop] Erro ao remover item:", err)
        return { success = false, message = "Erro ao remover item do inventário.", newBalance = 0, soldValue = 0 }
    end

    -- Credita Wira'i
    local playerMoney = DataController.GetData(player, "wirai") or 0
    DataController.UpdateData(player, "wirai", playerMoney + totalValue)

    local newBalance = DataController.GetData(player, "wirai") or 0
    return { success = true, message = "Venda realizada!", newBalance = newBalance, soldValue = totalValue }
end

-- Retorna a lista de itens à venda na loja
function NPCShop.GetShopItems()
    return NPCShop.SHOP_ITEMS
end

return NPCShop
