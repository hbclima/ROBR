-- PortalHandler.lua
-- Script genérico para Parts de portal no Workspace.
-- Destino: Dentro de cada Part de portal (como Script filho do Part)
--
-- ALTERNATIVA: usar PortalSetup.lua (abaixo) para gerar todos os portais
-- automaticamente a partir do AtlasConfig. Nesse caso, este script é
-- atribuído programaticamente a cada Part criado.
--
-- Leitura de configuração via Attributes do Part:
--   - "Destino" (string): ID do mapa de destino
--   - "DestinoPosicaoX" (number), "DestinoPosicaoY" (number), "DestinoPosicaoZ" (number)
--   - "NivelMinimo" (number): nível mínimo para passar
--   - "NomePortal" (string): nome de exibição do portal
--
-- Dependências:
--   MapaManager → ServerScriptService.Modules.MapaManager
--
-- Última atualização: 2026-06-09 (Fase 3 MVP)

local ServerScriptService = game:GetService("ServerScriptService")
local MapaManager = require(ServerScriptService.Modules.MapaManager)

local portal = script.Parent -- Part ao qual este script está anexado

-- Ler configuração dos Attributes do Part
local portalConfig = {
	nome = portal:GetAttribute("NomePortal") or "Portal",
	destino = portal:GetAttribute("Destino") or "",
	destinoPosicao = Vector3.new(
		portal:GetAttribute("DestinoPosicaoX") or 0,
		portal:GetAttribute("DestinoPosicaoY") or 5,
		portal:GetAttribute("DestinoPosicaoZ") or 0
	),
	nivelMinimo = portal:GetAttribute("NivelMinimo") or 1,
}

-- Validar configuração
if portalConfig.destino == "" then
	warn("[PortalHandler] Portal '" .. portalConfig.nome .. "' não tem destino configurado!")
	return
end

-- Listener de colisão
portal.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if not player then return end

	-- Delegar toda a lógica ao MapaManager (que inclui debounce e validação)
	MapaManager.OnPortalTouched(portalConfig, player)
end)

print("[PortalHandler] Portal '" .. portalConfig.nome .. "' → " .. portalConfig.destino .. " (nível " .. portalConfig.nivelMinimo .. "+) ativado.")
