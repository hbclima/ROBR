-- MinimapaController.lua
-- Gerencia o minimapa circular no client e transições locais de ambiente (iluminação, neblina, BGM).
-- Destino: StarterPlayerScripts/MinimapaController
--
-- CLIENT-SIDE — apenas exibe dados recebidos do servidor e ajusta efeitos locais.
--
-- Dependências:
--   ReplicatedStorage/Remotes/Mapa/ChangeMap        (RemoteEvent)
--   ReplicatedStorage/Remotes/Mapa/UpdateMinimapa   (RemoteEvent)
--   AtlasConfig → ReplicatedStorage/Modules/Config/AtlasConfig
--
-- Última atualização: 2026-06-09 (Fase 3 MVP)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local AtlasConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Config"):WaitForChild("AtlasConfig"))

local MinimapaController = {}

-------------------------------------------------------------------------------
-- REMOTES
-------------------------------------------------------------------------------

local Remotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Mapa")
local ChangeMapEvent = Remotes:WaitForChild("ChangeMap")
local UpdateMinimapaEvent = Remotes:WaitForChild("UpdateMinimapa")

-------------------------------------------------------------------------------
-- ESTADO
-------------------------------------------------------------------------------

local mapaAtual = nil      -- ID do mapa atual (string)
local mapaConfig = nil     -- Config do mapa atual (tabela do AtlasConfig)

-- Referências de UI (criadas em Init)
local minimapaGui = nil
local minimapaFrame = nil
local jogadorDot = nil
local mobDotsFolder = nil

-- Cores de fundo por bioma (para diferenciar visualmente)
local CORES_BIOMA = {
	mata_atlantica  = Color3.fromRGB(20, 55, 20),
	amazonia        = Color3.fromRGB(12, 35, 12),
	cerrado_queimado = Color3.fromRGB(45, 35, 25),
	floresta_fechada = Color3.fromRGB(20, 15, 30),
	montanha        = Color3.fromRGB(50, 55, 65),
	caverna          = Color3.fromRGB(8, 10, 18),
}

-- Tamanho do minimapa em pixels
local MINIMAPA_SIZE = 140
local MINIMAPA_PADDING = 20 -- margem do canto da tela

-------------------------------------------------------------------------------
-- CRIAÇÃO DA UI
-------------------------------------------------------------------------------

function MinimapaController.Init()
	-- ScreenGui
	minimapaGui = playerGui:FindFirstChild("MinimapaGui")
	if not minimapaGui then
		minimapaGui = Instance.new("ScreenGui")
		minimapaGui.Name = "MinimapaGui"
		minimapaGui.ResetOnSpawn = false
		minimapaGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		minimapaGui.Parent = playerGui
	end

	-- Frame principal (circular)
	minimapaFrame = minimapaGui:FindFirstChild("MinimapaFrame")
	if not minimapaFrame then
		minimapaFrame = Instance.new("Frame")
		minimapaFrame.Name = "MinimapaFrame"
		minimapaFrame.Size = UDim2.new(0, MINIMAPA_SIZE, 0, MINIMAPA_SIZE)
		minimapaFrame.Position = UDim2.new(1, -(MINIMAPA_SIZE + MINIMAPA_PADDING), 0, MINIMAPA_PADDING)
		minimapaFrame.BackgroundColor3 = Color3.fromRGB(20, 50, 20)
		minimapaFrame.BorderSizePixel = 0
		minimapaFrame.ClipsDescendants = true -- esconde dots fora do círculo
		minimapaFrame.Parent = minimapaGui

		-- Tornar circular
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0.5, 0)
		corner.Parent = minimapaFrame

		-- Borda sutil
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Color = Color3.fromRGB(80, 120, 80)
		stroke.Transparency = 0.3
		stroke.Parent = minimapaFrame
	end

	-- Indicador do jogador (ponto azul, centro fixo)
	jogadorDot = minimapaFrame:FindFirstChild("JogadorDot")
	if not jogadorDot then
		jogadorDot = Instance.new("Frame")
		jogadorDot.Name = "JogadorDot"
		jogadorDot.Size = UDim2.new(0, 8, 0, 8)
		jogadorDot.Position = UDim2.new(0.5, -4, 0.5, -4)
		jogadorDot.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
		jogadorDot.BorderSizePixel = 0
		jogadorDot.ZIndex = 10
		jogadorDot.Parent = minimapaFrame

		local dotCorner = Instance.new("UICorner")
		dotCorner.CornerRadius = UDim.new(0.5, 0)
		dotCorner.Parent = jogadorDot
	end

	-- Label "N" (norte)
	local nLabel = minimapaFrame:FindFirstChild("NorteLabel")
	if not nLabel then
		nLabel = Instance.new("TextLabel")
		nLabel.Name = "NorteLabel"
		nLabel.Size = UDim2.new(1, 0, 0, 14)
		nLabel.Position = UDim2.new(0, 0, 0, 4)
		nLabel.BackgroundTransparency = 1
		nLabel.Text = "N"
		nLabel.TextColor3 = Color3.fromRGB(212, 163, 115)
		nLabel.TextSize = 10
		nLabel.Font = Enum.Font.GothamBold
		nLabel.ZIndex = 10
		nLabel.Parent = minimapaFrame
	end

	-- Nome do mapa (abaixo do minimapa)
	local nomeLabel = minimapaGui:FindFirstChild("MapaNomeLabel")
	if not nomeLabel then
		nomeLabel = Instance.new("TextLabel")
		nomeLabel.Name = "MapaNomeLabel"
		nomeLabel.Size = UDim2.new(0, MINIMAPA_SIZE, 0, 16)
		nomeLabel.Position = UDim2.new(1, -(MINIMAPA_SIZE + MINIMAPA_PADDING), 0, MINIMAPA_PADDING + MINIMAPA_SIZE + 4)
		nomeLabel.BackgroundTransparency = 1
		nomeLabel.Text = ""
		nomeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		nomeLabel.TextSize = 11
		nomeLabel.Font = Enum.Font.Gotham
		nomeLabel.TextXAlignment = Enum.TextXAlignment.Center
		nomeLabel.Parent = minimapaGui
	end

	-- Pasta para dots de mobs
	mobDotsFolder = minimapaFrame:FindFirstChild("MobDots")
	if not mobDotsFolder then
		mobDotsFolder = Instance.new("Folder")
		mobDotsFolder.Name = "MobDots"
		mobDotsFolder.Parent = minimapaFrame
	end

	print("[MinimapaController] UI inicializada.")
end

-------------------------------------------------------------------------------
-- CONVERSÃO DE COORDENADAS
-------------------------------------------------------------------------------

--- Converte posição do mundo para coordenadas 0-1 do minimapa.
--- @param worldPos Vector3 — posição no mundo
--- @param config table — configuração do mapa (do AtlasConfig)
--- @return number, number — relX (0-1), relZ (0-1)
function MinimapaController.MundoParaMinimapa(worldPos, config)
	if not config then return 0.5, 0.5 end

	local centro = config.centro
	local tam = config.tamanho

	local relX = (worldPos.X - centro.X + tam.largura / 2) / tam.largura
	local relZ = (worldPos.Z - centro.Z + tam.profundidade / 2) / tam.profundidade

	return math.clamp(relX, 0, 1), math.clamp(relZ, 0, 1)
end

-------------------------------------------------------------------------------
-- ATUALIZAÇÃO DOS DOTS DE MOBS
-------------------------------------------------------------------------------

--- Atualiza (ou cria/destrói) os pontos vermelhos representando mobs no minimapa.
--- @param mobData table — array de { id = string, posicao = Vector3 }
local function atualizarMobDots(mobData)
	if not mobDotsFolder or not mapaConfig then return end

	-- Remover dots existentes
	for _, child in ipairs(mobDotsFolder:GetChildren()) do
		child:Destroy()
	end

	-- Criar novos dots
	for i, mob in ipairs(mobData) do
		local relX, relZ = MinimapaController.MundoParaMinimapa(mob.posicao, mapaConfig)

		local dot = Instance.new("Frame")
		dot.Name = "MobDot_" .. i
		dot.Size = UDim2.new(0, 5, 0, 5)
		dot.Position = UDim2.new(relX, -2, relZ, -2)
		dot.BackgroundColor3 = Color3.fromRGB(255, 60, 60) -- vermelho
		dot.BorderSizePixel = 0
		dot.ZIndex = 5
		dot.Parent = mobDotsFolder

		local dotCorner = Instance.new("UICorner")
		dotCorner.CornerRadius = UDim.new(0.5, 0)
		dotCorner.Parent = dot
	end
end

-------------------------------------------------------------------------------
-- TRANSICÕES LOCAIS DE AMBIENTE (ILUMINAÇÃO, NEBLINA, BGM)
-------------------------------------------------------------------------------

local function aplicarTransicaoAmbiente(config)
	local amb = config.ambiente
	if not amb then return end

	local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	-- 1. Transição de Neblina
	if amb.neblina then
		TweenService:Create(Lighting, tweenInfo, {
			FogColor = amb.neblina.cor,
			FogStart = amb.neblina.distanciaInicio,
			FogEnd = amb.neblina.distanciaFim
		}):Play()
	end

	-- 2. Transição de Iluminação Global
	if amb.iluminacao then
		TweenService:Create(Lighting, tweenInfo, {
			Ambient = amb.iluminacao.luzAmbiente,
			Brightness = amb.iluminacao.brilho
		}):Play()
	end

	-- 3. Transição de Atmosfera 3D
	local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
	if not atmosphere then
		atmosphere = Instance.new("Atmosphere")
		atmosphere.Parent = Lighting
	end
	if amb.atmosfera then
		TweenService:Create(atmosphere, tweenInfo, {
			Density = amb.atmosfera.densidade,
			Color = amb.atmosfera.cor,
			Offset = amb.atmosfera.deslocamento
		}):Play()
	end

	-- 4. Transição de Música (BGM)
	if amb.musica then
		local bgm = SoundService:FindFirstChild("BGM")
		if not bgm then
			bgm = Instance.new("Sound")
			bgm.Name = "BGM"
			bgm.Parent = SoundService
		end

		if bgm.SoundId ~= amb.musica.assetId then
			-- Fade out
			local fadeOut = TweenService:Create(bgm, TweenInfo.new(1.5), { Volume = 0 })
			local connection
			connection = fadeOut.Completed:Connect(function()
				connection:Disconnect()
				bgm.SoundId = amb.musica.assetId
				bgm.Looped = amb.musica.loop
				bgm.Volume = 0
				bgm:Play()
				-- Fade in
				TweenService:Create(bgm, TweenInfo.new(1.5), { Volume = amb.musica.volume }):Play()
			end)
			fadeOut:Play()
		else
			-- Apenas garante volume correto
			TweenService:Create(bgm, tweenInfo, { Volume = amb.musica.volume }):Play()
		end
	end
end

-------------------------------------------------------------------------------
-- TROCA DE MAPA
-------------------------------------------------------------------------------

--- Atualiza o display do minimapa quando o jogador muda de mapa.
--- @param mapaId string — ID do novo mapa
local function onChangeMap(mapaId)
	mapaAtual = mapaId
	mapaConfig = AtlasConfig.GetMapa(mapaId)

	if not mapaConfig or not minimapaFrame then return end

	-- Atualizar cor de fundo baseada no bioma
	local corBioma = CORES_BIOMA[mapaConfig.bioma]
	if corBioma then
		minimapaFrame.BackgroundColor3 = corBioma
	end

	-- Atualizar nome do mapa
	local nomeLabel = minimapaGui:FindFirstChild("MapaNomeLabel")
	if nomeLabel then
		nomeLabel.Text = mapaConfig.nomeExibido or mapaConfig.nome or mapaId
	end

	-- Limpar mob dots do mapa anterior
	if mobDotsFolder then
		for _, child in ipairs(mobDotsFolder:GetChildren()) do
			child:Destroy()
		end
	end

	-- Aplicar transições de BGM, neblina e atmosfera local
	aplicarTransicaoAmbiente(mapaConfig)

	print("[MinimapaController] Mapa alterado para: " .. mapaId)
end

-------------------------------------------------------------------------------
-- ATUALIZAÇÃO DO MINIMAPA (posição do jogador + mobs)
-------------------------------------------------------------------------------

--- Recebe atualização de posição do servidor (via UpdateMinimapa).
--- @param playerPos Vector3 — posição do jogador no mundo
--- @param mobData table — array de mobs vivos com posição
local function onUpdateMinimapa(playerPos, mobData)
	if not mapaConfig or not minimapaFrame then return end

	-- Mobs se movem relativamente ao jogador
	if mobData then
		atualizarMobDots(mobData)
	end
end

-------------------------------------------------------------------------------
-- ATUALIZAÇÃO LOCAL (posição do jogador por RenderStep)
-------------------------------------------------------------------------------

-- Atualiza a posição do dot do jogador localmente (sem depender do servidor)
local function onRenderStep()
	if not jogadorDot or not player.Character then return end
	local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end

	-- No modo "jogador-no-centro", o dot fica fixo.
end

-------------------------------------------------------------------------------
-- CONEXÕES
-------------------------------------------------------------------------------

-- Ouvir mudança de mapa
ChangeMapEvent.OnClientEvent:Connect(onChangeMap)

-- Ouvir atualização de posições do minimapa
UpdateMinimapaEvent.OnClientEvent:Connect(onUpdateMinimapa)

-- Atualização local por frame (leve, só para orientação do dot)
RunService.RenderStepped:Connect(onRenderStep)

-- Inicializar UI
MinimapaController.Init()

return MinimapaController
