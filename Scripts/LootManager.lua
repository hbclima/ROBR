-- LootManager.lua
-- Gera drops quando um mob morre e entrega ao jogador.
-- Server-only: roda em ServerScriptService.
-- Dependências: DropTable, InventoryManager, RemoteEvent Loot

local DropTable = require(game.ReplicatedStorage.Modules.Config.DropTable)
local InventoryManager = require(game.ReplicatedStorage.Modules.Server.InventoryManager)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local LootEvent = Remotes:WaitForChild("Economy"):WaitForChild("Loot")

local LootManager = {}

--[[
    Gera drops para um jogador ao matar um mob.
    @param mobId string — ID do mob morto (ex: "MOB_001")
    @param player Player — jogador que recebeu o loot
    @return table — array de drops gerados
]]
function LootManager.GenerateLoot(mobId, player)
    if not mobId or not player then
        warn("[LootManager] Parâmetros inválidos:", mobId, player)
        return {}
    end

    local drops = DropTable.GetDrops(mobId)
    local loot = {}

    for _, drop in ipairs(drops) do
        -- Rola chance de drop (math.random() * 100 retorna 0-99.999...)
        local roll = math.random() * 100
        if roll < drop.chance then
            table.insert(loot, drop)

            -- Adiciona item ao inventário do jogador
            local success, err = pcall(function()
                InventoryManager.AddItem(player, drop.id, 1)
            end)

            if not success then
                warn("[LootManager] Erro ao adicionar item", drop.id, "ao jogador", player.Name, ":", err)
            end
        end
    end

    -- Notifica o cliente sobre o loot
    local success, err = pcall(function()
        LootEvent:FireClient(player, mobId, loot)
    end)

    if not success then
        warn("[LootManager] Erro ao notificar loot para", player.Name, ":", err)
    end

    return loot
end

return LootManager
