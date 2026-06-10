-- TradeManager.lua
-- Gerencia trades entre dois jogadores.
-- Server-only: roda em ServerScriptService.
-- Dependências: DataController, InventoryManager

local DataController = require(game.ReplicatedStorage.Modules.Server.DataController)
local InventoryManager = require(game.ReplicatedStorage.Modules.Server.InventoryManager)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local EconomyRemotes = Remotes:WaitForChild("Economy")

local TradeRequestEvent = EconomyRemotes:WaitForChild("TradeRequest")
local TradeAcceptEvent = EconomyRemotes:WaitForChild("TradeAccept")
local TradeUpdateEvent = EconomyRemotes:WaitForChild("TradeUpdate")
local TradeConfirmEvent = EconomyRemotes:WaitForChild("TradeConfirm")
local TradeCancelEvent = EconomyRemotes:WaitForChild("TradeCancel")
local TradeResultEvent = EconomyRemotes:WaitForChild("TradeResult")

local TradeManager = {}

-- Tabela de sessões ativas: [player] = session
TradeManager.ActiveSessions = {}

-- Constantes
local MAX_ITEMS_PER_TRADE = 10
local MAX_WIRAI_PER_TRADE = 999999
local MAX_DISTANCE_STUDS = 10

--[[
    Cria uma nova sessão de trade.
]]
local function CreateSession(playerA, playerB)
    return {
        playerA = playerA,
        playerB = playerB,
        itemsA = {},       -- { { itemId, quantity }, ... }
        itemsB = {},
        wiraiA = 0,
        wiraiB = 0,
        confirmedA = false,
        confirmedB = false,
        active = true,
    }
end

--[[
    Envia o estado atual do trade para ambos os jogadores.
]]
local function BroadcastUpdate(session)
    if not session or not session.active then return end

    local data = {
        itemsA = session.itemsA,
        itemsB = session.itemsB,
        wiraiA = session.wiraiA,
        wiraiB = session.wiraiB,
        confirmedA = session.confirmedA,
        confirmedB = session.confirmedB,
    }

    pcall(function()
        TradeUpdateEvent:FireClient(session.playerA, data)
        TradeUpdateEvent:FireClient(session.playerB, data)
    end)
end

--[[
    Destrói uma sessão e limpa referências.
]]
local function DestroySession(session)
    if not session then return end
    session.active = false
    TradeManager.ActiveSessions[session.playerA] = nil
    TradeManager.ActiveSessions[session.playerB] = nil
end

--[[
    Verifica se dois jogadores estão no mesmo mapa e próximos.
]]
local function ValidateProximity(playerA, playerB)
    local charA = playerA.Character
    local charB = playerB.Character
    if not charA or not charB then return false end

    local rootA = charA:FindFirstChild("HumanoidRootPart")
    local rootB = charB:FindFirstChild("HumanoidRootPart")
    if not rootA or not rootB then return false end

    local distance = (rootA.Position - rootB.Position).Magnitude
    return distance <= MAX_DISTANCE_STUDS
end

--[[
    Conta o número total de itens em uma oferta.
]]
local function CountItems(itemsList)
    local count = 0
    for _, entry in ipairs(itemsList) do
        count = count + (entry.quantity or 0)
    end
    return count
end

-- === FUNÇÕES PÚBLICAS ===

-- Jogador A solicita trade com Jogador B
function TradeManager.RequestTrade(from, to)
    if not from or not to then return end
    if from == to then return end

    -- Verifica se já está em trade
    if TradeManager.ActiveSessions[from] then
        return
    end
    if TradeManager.ActiveSessions[to] then
        return
    end

    -- Envia solicitação ao jogador alvo
    pcall(function()
        TradeRequestEvent:FireClient(to, { fromPlayer = from, fromName = from.Name })
    end)
end

-- Jogador B aceita o trade
function TradeManager.AcceptTrade(player)
    -- O jogador que aceita é o "to" — precisa encontrar quem mandou
    -- No handler do RemoteEvent, o server recebe o player e o fromPlayer
    -- Esta função é chamada com ambos os jogadores
end

-- Cria a sessão (chamada pelo handler do TradeAccept)
function TradeManager.CreateTradeSession(playerA, playerB)
    if TradeManager.ActiveSessions[playerA] or TradeManager.ActiveSessions[playerB] then
        return nil
    end

    local session = CreateSession(playerA, playerB)
    TradeManager.ActiveSessions[playerA] = session
    TradeManager.ActiveSessions[playerB] = session

    BroadcastUpdate(session)
    return session
end

-- Adiciona item à oferta de um jogador
function TradeManager.AddItem(player, itemId, quantity)
    local session = TradeManager.ActiveSessions[player]
    if not session or not session.active then return end

    local isPlayerA = (player == session.playerA)
    local itemsList = isPlayerA and session.itemsA or session.itemsB

    -- Verifica limite de itens
    local currentCount = CountItems(itemsList)
    if currentCount + quantity > MAX_ITEMS_PER_TRADE then
        return
    end

    -- Verifica se o jogador tem o item
    local itemCount = InventoryManager.GetItemCount(player, itemId) or 0
    if itemCount < quantity then
        return
    end

    -- Adiciona ou atualiza a entrada
    local found = false
    for _, entry in ipairs(itemsList) do
        if entry.itemId == itemId then
            entry.quantity = entry.quantity + quantity
            found = true
            break
        end
    end
    if not found then
        table.insert(itemsList, { itemId = itemId, quantity = quantity })
    end

    -- Reseta confirmações (mudança invalida confirmação)
    session.confirmedA = false
    session.confirmedB = false

    BroadcastUpdate(session)
end

-- Adiciona Wira'i à oferta de um jogador
function TradeManager.AddWirai(player, amount)
    local session = TradeManager.ActiveSessions[player]
    if not session or not session.active then return end

    if amount <= 0 or amount > MAX_WIRAI_PER_TRADE then return end

    -- Verifica saldo
    local playerMoney = DataController.GetData(player, "wirai") or 0
    if amount > playerMoney then return end

    local isPlayerA = (player == session.playerA)
    if isPlayerA then
        session.wiraiA = amount
    else
        session.wiraiB = amount
    end

    -- Reseta confirmações
    session.confirmedA = false
    session.confirmedB = false

    BroadcastUpdate(session)
end

-- Jogador confirma o trade
function TradeManager.ConfirmTrade(player)
    local session = TradeManager.ActiveSessions[player]
    if not session or not session.active then return end

    local isPlayerA = (player == session.playerA)
    if isPlayerA then
        session.confirmedA = true
    else
        session.confirmedB = true
    end

    BroadcastUpdate(session)

    -- Se ambos confirmaram, executa
    if session.confirmedA and session.confirmedB then
        TradeManager.ExecuteTrade(session)
    end
end

-- Executa a troca (atômica)
function TradeManager.ExecuteTrade(session)
    if not session or not session.active then return end

    local playerA = session.playerA
    local playerB = session.playerB

    -- Validação final: proximidade
    if not ValidateProximity(playerA, playerB) then
        pcall(function()
            TradeResultEvent:FireClient(playerA, { success = false, message = "Jogadores muito distantes." })
            TradeResultEvent:FireClient(playerB, { success = false, message = "Jogadores muito distantes." })
        end)
        DestroySession(session)
        return
    end

    -- Validação final: itens ainda existem no inventário
    for _, entry in ipairs(session.itemsA) do
        local count = InventoryManager.GetItemCount(playerA, entry.itemId) or 0
        if count < entry.quantity then
            pcall(function()
                TradeResultEvent:FireClient(playerA, { success = false, message = "Itens insuficientes." })
                TradeResultEvent:FireClient(playerB, { success = false, message = "Itens insuficientes." })
            end)
            DestroySession(session)
            return
        end
    end

    for _, entry in ipairs(session.itemsB) do
        local count = InventoryManager.GetItemCount(playerB, entry.itemId) or 0
        if count < entry.quantity then
            pcall(function()
                TradeResultEvent:FireClient(playerA, { success = false, message = "Itens insuficientes." })
                TradeResultEvent:FireClient(playerB, { success = false, message = "Itens insuficientes." })
            end)
            DestroySession(session)
            return
        end
    end

    -- Validação final: Wira'i
    local moneyA = DataController.GetData(playerA, "wirai") or 0
    local moneyB = DataController.GetData(playerB, "wirai") or 0
    if moneyA < session.wiraiA or moneyB < session.wiraiB then
        pcall(function()
            TradeResultEvent:FireClient(playerA, { success = false, message = "Wira'i insuficiente." })
            TradeResultEvent:FireClient(playerB, { success = false, message = "Wira'i insuficiente." })
        end)
        DestroySession(session)
        return
    end

    -- Executa a troca (com pcall para segurança)
    local success, err = pcall(function()
        -- Remove itens de A → dá para B
        for _, entry in ipairs(session.itemsA) do
            InventoryManager.RemoveItem(playerA, entry.itemId, entry.quantity)
            InventoryManager.AddItem(playerB, entry.itemId, entry.quantity)
        end

        -- Remove itens de B → dá para A
        for _, entry in ipairs(session.itemsB) do
            InventoryManager.RemoveItem(playerB, entry.itemId, entry.quantity)
            InventoryManager.AddItem(playerA, entry.itemId, entry.quantity)
        end

        -- Troca Wira'i
        DataController.UpdateData(playerA, "wirai", moneyA - session.wiraiA + session.wiraiB)
        DataController.UpdateData(playerB, "wirai", moneyB - session.wiraiB + session.wiraiA)
    end)

    if not success then
        warn("[TradeManager] Erro ao executar trade:", err)
        pcall(function()
            TradeResultEvent:FireClient(playerA, { success = false, message = "Erro interno no trade." })
            TradeResultEvent:FireClient(playerB, { success = false, message = "Erro interno no trade." })
        end)
        DestroySession(session)
        return
    end

    -- Sucesso
    pcall(function()
        TradeResultEvent:FireClient(playerA, { success = true, message = "Trade realizado com sucesso!" })
        TradeResultEvent:FireClient(playerB, { success = true, message = "Trade realizado com sucesso!" })
    end)

    DestroySession(session)
end

-- Cancela o trade
function TradeManager.CancelTrade(player)
    local session = TradeManager.ActiveSessions[player]
    if not session then return end

    local otherPlayer = (player == session.playerA) and session.playerB or session.playerA

    pcall(function()
        TradeResultEvent:FireClient(session.playerA, { success = false, message = "Trade cancelado." })
        TradeResultEvent:FireClient(session.playerB, { success = false, message = "Trade cancelado." })
    end)

    DestroySession(session)
end

return TradeManager
