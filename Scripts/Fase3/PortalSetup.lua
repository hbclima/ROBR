-- PortalSetup.lua
-- Script de inicialização que cria TODOS os portais automaticamente a partir do AtlasConfig.
-- Destino: ServerScriptService/PortalSetup (Script normal, não ModuleScript)
--
-- Este script roda UMA VEZ no início do servidor e:
--   1. Itera todos os mapas do AtlasConfig
--   2. Para cada portal definido, cria um Part no Workspace
--   3. Configura visual (cor, transparência, ParticleEmitter)
--   4. Clona o PortalHandler script para dentro do Part
--
-- Dependências:
--   AtlasConfig → ReplicatedStorage.Modules.Config.AtlasConfig
--   PortalHandlerTemplate → ServerScriptService.PortalHandlerTemplate (Script)
--
-- NOTA: Se preferir criar portais manualmente no Studio, ignore este script
-- e use o PortalHandler.lua diretamente em cada Part.
--
-- Última atualização: 2026-06-09 (Fase 3 MVP)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local AtlasConfig = require(ReplicatedStorage.Modules.Config.AtlasConfig)

-- Template do script de portal (deve existir como Script desabilitado)
local portalHandlerTemplate = ServerScriptService:FindFirstChild("PortalHandlerTemplate")

-------------------------------------------------------------------------------
-- CRIAÇÃO DE PORTAIS
-------------------------------------------------------------------------------

local function criarParticulas(parent, cor)
	local emitter = Instance.new("ParticleEmitter")
	emitter.Name = "PortalParticles"
	emitter.Rate = 20
	emitter.Lifetime = NumberRange.new(1, 2)
	emitter.Speed = NumberRange.new(1, 3)
	emitter.Color = ColorSequence.new(cor)
	emitter.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(1, 0),
	})
	emitter.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.3),
		NumberSequenceKeypoint.new(1, 1),
	})
	emitter.LightEmission = 0.5
	emitter.Parent = parent
	return emitter
end

local function criarPortal(portalConfig, mapaId)
	-- Criar Part
	local part = Instance.new("Part")
	part.Name = "Portal_" .. (portalConfig.destino or "unknown")
	part.Anchored = true
	part.CanCollide = false -- jogador atravessa (Touched ainda dispara)
	part.Size = portalConfig.tamanho or Vector3.new(10, 15, 20)
	part.Position = portalConfig.posicao
	part.Material = Enum.Material.Neon

	-- Visual
	if portalConfig.visivel then
		part.Transparency = portalConfig.transparencia or 0.7
		part.Color = portalConfig.cor or Color3.fromRGB(100, 255, 180)

		-- Partículas
		criarParticulas(part, portalConfig.cor or Color3.fromRGB(100, 255, 180))
	else
		part.Transparency = 1
	end

	-- Attributes para o PortalHandler ler
	part:SetAttribute("NomePortal", portalConfig.nome or "Portal")
	part:SetAttribute("Destino", portalConfig.destino or "")
	part:SetAttribute("DestinoPosicaoX", portalConfig.destinoPosicao.X)
	part:SetAttribute("DestinoPosicaoY", portalConfig.destinoPosicao.Y)
	part:SetAttribute("DestinoPosicaoZ", portalConfig.destinoPosicao.Z)
	part:SetAttribute("NivelMinimo", portalConfig.nivelMinimo or 1)

	-- Clonar o script de handler
	if portalHandlerTemplate then
		local handlerClone = portalHandlerTemplate:Clone()
		handlerClone.Name = "PortalHandler"
		handlerClone.Disabled = false
		handlerClone.Parent = part
	else
		warn("[PortalSetup] PortalHandlerTemplate não encontrado! Portal '" .. part.Name .. "' ficará sem script.")
	end

	-- Colocar no Workspace (dentro da pasta do mapa de origem)
	local mapaFolder = workspace:FindFirstChild("Mapas")
	if mapaFolder then
		local subFolder = mapaFolder:FindFirstChild(mapaId)
		if subFolder then
			part.Parent = subFolder
		else
			part.Parent = mapaFolder
		end
	else
		part.Parent = workspace
	end

	return part
end

-------------------------------------------------------------------------------
-- INICIALIZAÇÃO
-------------------------------------------------------------------------------

local totalPortais = 0

for mapaId, mapaConfig in pairs(AtlasConfig.Mapas) do
	if mapaConfig.portais then
		for _, portalConfig in ipairs(mapaConfig.portais) do
			criarPortal(portalConfig, mapaId)
			totalPortais = totalPortais + 1
		end
	end
end

print("[PortalSetup] " .. totalPortais .. " portais criados a partir do AtlasConfig.")
