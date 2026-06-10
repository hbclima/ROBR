-- MapaManager.lua
-- Gerencia transições entre mapas, detecção de mapa atual e validação de nível.
-- Destino: ServerScriptService/Modules/MapaManager
--
-- SERVER-SIDE ONLY — toda lógica de transição roda no servidor.
-- O client nunca decide se pode passar por um portal.
--
-- Dependências:
--   DataController  → script.Parent.DataController
--   AtlasConfig     → ReplicatedStorage.Modules.Config.AtlasConfig
--   Remotes/Mapa/   → ChangeMap, LevelTooLow (RemoteEvents)
--
-- Última atualização: 2026-06-09 (Fase 3 MVP)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataController = require(script.Parent.DataController)
local AtlasConfig = require(ReplicatedStorage.Modules.Config.AtlasConfig)

local MapaManager = {}

-------------------------------------------------------------------------------
-- REMOTES
-------------------------------------------------------------------------------

-- Estes RemoteEvents devem ser criados manualmente no Studio:
--   ReplicatedStorage/Remotes/Mapa/ChangeMap      (RemoteEvent)
--   ReplicatedStorage/Remotes/Mapa/LevelTooLow    (RemoteEvent)
local ChangeMapEvent = ReplicatedStorage.Remotes.Mapa.ChangeMap
local LevelTooLowEvent = ReplicatedStorage.Remotes.Mapa.LevelTooLow

-------------------------------------------------------------------------------
-- COOLDOWN DE PORTAL (debounce server-side)
-------------------------------------------------------------------------------

local portalCooldowns = {} -- { [userId] = tick() }
local PORTAL_COOLDOWN_SECONDS = 3

--- Verifica se o jogador pode usar um portal (debounce).
--- @param player Player
--- @return boolean
local function isPortalOnCooldown(player)
	local lastUse = portalCooldowns[player.UserId]
	if lastUse and (tick() - lastUse) < PORTAL_COOLDOWN_SECONDS then
		return true
	end
	return false
end

--- Marca o uso do portal (inicia cooldown).
--- @param player Player
local function markPortalUsed(player)
	portalCooldowns[player.UserId] = tick()
end

-- Limpar cooldowns quando jogador sai
Players.PlayerRemoving:Connect(function(player)
	portalCooldowns[player.UserId] = nil
end)

-------------------------------------------------------------------------------
-- DETECÇÃO DE MAPA
-------------------------------------------------------------------------------

--- Calcula distância 2D (ignora eixo Y) entre dois Vector3.
--- @param a Vector3
--- @param b Vector3
--- @return number
local function Distancia2D(a, b)
	return math.sqrt((a.X - b.X) ^ 2 + (a.Z - b.Z) ^ 2)
end

--- Detecta em qual mapa o jogador está baseado na posição do HumanoidRootPart.
--- Ordena mapas por proximidade ao centro para evitar falsos positivos em bordas.
--- @param player Player
--- @return string|nil — ID do mapa (ex: "Mapa1_YbiráPuera") ou nil se fora de todos
function MapaManager.DetectarMapa(player)
	if not player.Character then return nil end
	local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return nil end

	local pos = rootPart.Position

	-- Calcular distância de cada mapa e ordenar por proximidade
	local mapasOrdenados = {}
	for mapaId, config in pairs(AtlasConfig.Mapas) do
		local dist = Distancia2D(pos, config.centro)
		table.insert(mapasOrdenados, { mapaId = mapaId, config = config, dist = dist })
	end
	table.sort(mapasOrdenados, function(a, b) return a.dist < b.dist end)

	-- Testar do mais próximo ao mais distante
	for _, entry in ipairs(mapasOrdenados) do
		local config = entry.config
		if math.abs(pos.X - config.centro.X) <= config.tamanho.largura / 2
			and math.abs(pos.Z - config.centro.Z) <= config.tamanho.profundidade / 2 then
			return entry.mapaId
		end
	end

	return nil -- jogador está fora de todos os mapas
end

-------------------------------------------------------------------------------
-- ATRIBUTO DE MAPA
-------------------------------------------------------------------------------

--- Atualiza o atributo "MapaAtual" do jogador e notifica o client.
--- @param player Player
--- @param mapaId string
function MapaManager.SetMapaAtual(player, mapaId)
	player:SetAttribute("MapaAtual", mapaId)
	ChangeMapEvent:FireClient(player, mapaId)
	print("[MapaManager] " .. player.Name .. " agora está em " .. mapaId)
end

-------------------------------------------------------------------------------
-- VALIDAÇÃO DE PASSAGEM
-------------------------------------------------------------------------------

--- Verifica se o jogador tem nível suficiente para passar por um portal.
--- @param player Player
--- @param portalConfig table — entrada de portal do AtlasConfig
--- @return boolean, string — (pode passar?, mensagem)
function MapaManager.ValidarPassagem(player, portalConfig)
	local data = DataController.GetData(player)
	if not data then
		return false, "Dados do jogador não carregados."
	end

	local nivelMinimo = portalConfig.nivelMinimo or 1
	if data.nivel < nivelMinimo then
		return false, "Nível " .. nivelMinimo .. " necessário (você tem " .. data.nivel .. ")."
	end

	return true, "OK"
end

-------------------------------------------------------------------------------
-- TELEPORTE
-------------------------------------------------------------------------------

--- Teleporta o jogador para a posição de destino de um portal.
--- Usa PivotTo para mover o modelo inteiro (não SetPrimaryPartCFrame).
--- @param player Player
--- @param destinoMapa string — ID do mapa de destino
--- @param destinoPosicao Vector3 — posição de destino no mundo
function MapaManager.TeleportarParaPortal(player, destinoMapa, destinoPosicao)
	if not player.Character then return end
	local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return end

	-- Usar PivotTo para mover o modelo completo do personagem
	player.Character:PivotTo(CFrame.new(destinoPosicao))

	-- Atualizar mapa e notificar client
	MapaManager.SetMapaAtual(player, destinoMapa)
end

-------------------------------------------------------------------------------
-- HANDLER DE PORTAL
-------------------------------------------------------------------------------

--- Handler principal chamado quando um jogador toca um portal.
--- Inclui debounce, validação de nível e teleporte.
--- @param portalConfig table — dados do portal (do AtlasConfig ou Attributes do Part)
--- @param player Player
function MapaManager.OnPortalTouched(portalConfig, player)
	-- Debounce: ignorar se portal foi usado recentemente
	if isPortalOnCooldown(player) then return end

	-- Validar nível
	local valido, mensagem = MapaManager.ValidarPassagem(player, portalConfig)

	if valido then
		-- Marcar cooldown ANTES de teleportar (evita duplicação)
		markPortalUsed(player)

		-- Teleportar
		MapaManager.TeleportarParaPortal(
			player,
			portalConfig.destino,
			portalConfig.destinoPosicao
		)

		print("[MapaManager] " .. player.Name .. " passou pelo portal '" .. (portalConfig.nome or "?") .. "'")
	else
		-- Notificar jogador que não pode passar
		LevelTooLowEvent:FireClient(player, portalConfig.nivelMinimo or 1, mensagem)
		print("[MapaManager] " .. player.Name .. " bloqueado: " .. mensagem)
	end
end

-------------------------------------------------------------------------------
-- RESPAWN DO JOGADOR
-------------------------------------------------------------------------------

--- Retorna a posição de respawn segura do mapa onde o jogador morreu.
--- Se não encontrar o mapa, retorna o spawn padrão (Mapa1).
--- @param player Player
--- @return Vector3
function MapaManager.GetPosicaoRespawn(player)
	local mapaAtual = player:GetAttribute("MapaAtual") or "Mapa1_YbiráPuera"
	local respawnPos = AtlasConfig.GetSpawnDeRespawn(mapaAtual)
	if respawnPos then
		return respawnPos
	end
	-- Fallback: Mapa1 spawn padrão
	return Vector3.new(-25, 5, -25)
end

return MapaManager
