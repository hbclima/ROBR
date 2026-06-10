-- AtlasConfig.lua
-- Configuração central de todos os mapas, zonas de spawn, NPCs, portais e ambientação.
-- Destino: ReplicatedStorage/Modules/Config/AtlasConfig
--
-- Este é o "atlas" do jogo — a fonte da verdade para posições, biomas e conexões.
-- Todos os sistemas (SpawnSystem, MapaManager, MinimapaController) leem daqui.
--
-- Última atualização: 2026-06-09 (Fase 3 MVP)

local AtlasConfig = {}

-------------------------------------------------------------------------------
-- MAPAS
-------------------------------------------------------------------------------

AtlasConfig.Mapas = {

	---------------------------------------------------------------------------
	-- MAPA 1 — Ybirá-Puera (Zona Inicial)
	---------------------------------------------------------------------------
	["Mapa1_YbiráPuera"] = {
		nome = "Ybirá-Puera",
		nomeExibido = "Rio das Árvores Antigas",
		descricao = "Zona inicial. Vegetação densa às margens de um rio caudaloso.",
		nivelRecomendado = { min = 1, max = 10 },
		bioma = "mata_atlantica",

		-- Posição no Workspace (centro do mapa)
		centro = Vector3.new(0, 0, 0),
		tamanho = { largura = 200, profundidade = 200 },

		-- Chão
		chao = {
			tamanhoTotal = { largura = 250, profundidade = 250 },
			cor = Color3.fromRGB(45, 90, 39), -- verde grama
			material = Enum.Material.Grass,
		},

		-- Áreas de spawn de mobs
		zonasDeSpawn = {
			{
				nome = "Margem do Rio",
				posicao = Vector3.new(0, 3, 20),
				raio = 40,
				mobs = {
					{ id = "MOB_001", quantidade = 5 }, -- Sapo Cururu
					{ id = "MOB_015", quantidade = 3 }, -- Capivara
					{ id = "MOB_002", quantidade = 4 }, -- Cobra-d'Água
				},
			},
		},

		-- Pontos de spawn para jogadores (primeira vez / novo personagem)
		spawnDosJogadores = {
			Vector3.new(-20, 5, -20),
			Vector3.new(-15, 5, -25),
			Vector3.new(-25, 5, -15),
		},

		-- Ponto de respawn após morte (zona segura, perto de NPC)
		spawnDeRespawn = Vector3.new(-25, 5, -25),

		-- NPCs
		npcs = {
			{
				id = "NPC_001",
				nome = "Curandeiro Ancião",
				posicao = Vector3.new(10, 4, -10),
				tipo = "loja",
				conteudo = { "CONS_001", "CONS_002", "CONS_003" },
			},
			{
				id = "NPC_002",
				nome = "Pajé do Rio",
				posicao = Vector3.new(-30, 4, 10),
				tipo = "quest",
			},
		},

		-- Portais para outros mapas
		portais = {
			{
				nome = "Caminho para Floresta",
				posicao = Vector3.new(90, 5, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa2_FlorestaMaeDaMata",
				destinoPosicao = Vector3.new(120, 5, 0),
				nivelMinimo = 8,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(100, 255, 180), -- verde-dourado
				efeitoParticula = "nevoa_luz",
			},
		},

		-- Ambientação
		ambiente = {
			musica = { assetId = "rbxassetid://1837849285", volume = 0.4, loop = true },
			corFundo = Color3.fromRGB(135, 180, 220),
			atmosfera = {
				densidade = 0.3,
				cor = Color3.fromRGB(180, 200, 220),
				deslocamento = 0,
			},
			iluminacao = {
				luzAmbiente = Color3.fromRGB(200, 200, 200),
				brilho = 2,
				sombras = true,
			},
			neblina = {
				habilitada = true,
				cor = Color3.fromRGB(160, 190, 200),
				distanciaInicio = 80,
				distanciaFim = 250,
			},
		},
	},

	---------------------------------------------------------------------------
	-- MAPA 2 — Floresta de Mãe-da-Mata
	---------------------------------------------------------------------------
	["Mapa2_FlorestaMaeDaMata"] = {
		nome = "Floresta de Mãe-da-Mata",
		nomeExibido = "Floresta da Mãe-da-Mata",
		descricao = "Floresta extremamente densa, com cipós e cogumelos bioluminescentes.",
		nivelRecomendado = { min = 10, max = 15 },
		bioma = "amazonia",

		centro = Vector3.new(250, 0, 0),
		tamanho = { largura = 300, profundidade = 300 },

		chao = {
			tamanhoTotal = { largura = 300, profundidade = 300 },
			cor = Color3.fromRGB(24, 61, 21), -- verde escuro
			material = Enum.Material.Grass,
		},

		zonasDeSpawn = {
			{
				nome = "Corpo da Floresta",
				posicao = Vector3.new(250, 3, 0),
				raio = 60,
				mobs = {
					{ id = "MOB_003", quantidade = 3 }, -- Mãe-da-Mata
					{ id = "MOB_011", quantidade = 2 }, -- Boto Cor-de-Rosa
					{ id = "MOB_013", quantidade = 2 }, -- Corpo Seco
				},
			},
		},

		spawnDosJogadores = {
			Vector3.new(120, 5, 0),
		},

		spawnDeRespawn = Vector3.new(125, 5, 5),

		npcs = {
			{
				id = "NPC_003",
				nome = "Comerciante da Floresta",
				posicao = Vector3.new(130, 4, -10),
				tipo = "loja",
				conteudo = { "CONS_001", "CONS_002", "CONS_003" },
			},
			{
				id = "NPC_004",
				nome = "Karaí (Xamã)",
				posicao = Vector3.new(135, 4, 15),
				tipo = "quest",
			},
		},

		portais = {
			{
				nome = "Caminho para Ybirá-Puera",
				posicao = Vector3.new(105, 5, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa1_YbiráPuera",
				destinoPosicao = Vector3.new(80, 5, 0),
				nivelMinimo = 1,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(45, 90, 39), -- verde grama
				efeitoParticula = "nevoa_luz",
			},
			{
				nome = "Caminho para Tavy-Katu",
				posicao = Vector3.new(390, 5, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa3_TavyKatu",
				destinoPosicao = Vector3.new(420, 5, 0),
				nivelMinimo = 13,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(150, 75, 0), -- marrom
				efeitoParticula = "nevoa_luz",
			},
		},

		ambiente = {
			musica = { assetId = "rbxassetid://1839888756", volume = 0.4, loop = true },
			corFundo = Color3.fromRGB(30, 45, 30),
			atmosfera = {
				densidade = 0.45,
				cor = Color3.fromRGB(40, 50, 40),
				deslocamento = 0,
			},
			iluminacao = {
				luzAmbiente = Color3.fromRGB(100, 120, 100),
				brilho = 1.2,
				sombras = true,
			},
			neblina = {
				habilitada = true,
				cor = Color3.fromRGB(30, 40, 30),
				distanciaInicio = 50,
				distanciaFim = 180,
			},
		},
	},

	---------------------------------------------------------------------------
	-- MAPA 3 — Tavy-Katu (Clareira Amaldiçoada)
	---------------------------------------------------------------------------
	["Mapa3_TavyKatu"] = {
		nome = "Tavy-Katu",
		nomeExibido = "Clareira Amaldiçoada",
		descricao = "Área queimada em recuperação, com cinzas, troncos carbonizados e fogueiras.",
		nivelRecomendado = { min = 15, max = 20 },
		bioma = "cerrado_queimado",

		centro = Vector3.new(525, 0, 0),
		tamanho = { largura = 250, profundidade = 250 },

		chao = {
			tamanhoTotal = { largura = 250, profundidade = 250 },
			cor = Color3.fromRGB(80, 75, 70), -- cinza terra
			material = Enum.Material.Rock,
		},

		zonasDeSpawn = {
			{
				nome = "Clareira Principal",
				posicao = Vector3.new(525, 3, 0),
				raio = 50,
				mobs = {
					{ id = "MOB_004", quantidade = 3 }, -- Boitatá
					{ id = "MOB_012", quantidade = 2 }, -- Mula Sem Cabeça
					{ id = "MOB_016", quantidade = 2 }, -- Jacaré-Açu
				},
			},
		},

		spawnDosJogadores = {
			Vector3.new(420, 5, 0),
		},

		spawnDeRespawn = Vector3.new(430, 5, -10),

		npcs = {
			{
				id = "NPC_005",
				nome = "Comerciante das Cinzas",
				posicao = Vector3.new(435, 4, -15),
				tipo = "loja",
				conteudo = { "CONS_001", "CONS_002", "CONS_003" },
			},
			{
				id = "NPC_006",
				nome = "Ferreiro Sobrevivente",
				posicao = Vector3.new(440, 4, 10),
				tipo = "ferreiro",
			},
		},

		portais = {
			{
				nome = "Voltar para Floresta",
				posicao = Vector3.new(405, 5, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa2_FlorestaMaeDaMata",
				destinoPosicao = Vector3.new(370, 5, 0),
				nivelMinimo = 1,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(24, 61, 21), -- verde escuro
				efeitoParticula = "nevoa_luz",
			},
			{
				nome = "Caminho para Tupã-Mbara",
				posicao = Vector3.new(640, 5, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa4_TupaMbara",
				destinoPosicao = Vector3.new(670, 5, 0),
				nivelMinimo = 18,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(85, 0, 120), -- roxo
				efeitoParticula = "nevoa_luz",
			},
		},

		ambiente = {
			musica = { assetId = "rbxassetid://1846368036", volume = 0.4, loop = true },
			corFundo = Color3.fromRGB(50, 40, 35),
			atmosfera = {
				densidade = 0.5,
				cor = Color3.fromRGB(70, 55, 45),
				deslocamento = 0,
			},
			iluminacao = {
				luzAmbiente = Color3.fromRGB(120, 100, 90),
				brilho = 1.0,
				sombras = true,
			},
			neblina = {
				habilitada = true,
				cor = Color3.fromRGB(60, 50, 40),
				distanciaInicio = 40,
				distanciaFim = 150,
			},
		},
	},

	---------------------------------------------------------------------------
	-- MAPA 4 — Tupã-Mbara (Campo dos Ancestrais)
	---------------------------------------------------------------------------
	["Mapa4_TupaMbara"] = {
		nome = "Tupã-Mbara",
		nomeExibido = "Campo dos Ancestrais",
		descricao = "Cemitério indígena em mata fechada com totens, ossos e névoa espessa.",
		nivelRecomendado = { min = 20, max = 25 },
		bioma = "floresta_fechada",

		centro = Vector3.new(775, 0, 0),
		tamanho = { largura = 250, profundidade = 250 },

		chao = {
			tamanhoTotal = { largura = 250, profundidade = 250 },
			cor = Color3.fromRGB(35, 30, 45), -- roxo escuro
			material = Enum.Material.Mud,
		},

		zonasDeSpawn = {
			{
				nome = "Cemitério Ancestral",
				posicao = Vector3.new(775, 3, 0),
				raio = 50,
				mobs = {
					{ id = "MOB_005", quantidade = 2 }, -- Curupira
					{ id = "MOB_008", quantidade = 2 }, -- Anhangá
					{ id = "MOB_014", quantidade = 2 }, -- Onça-Pintada
				},
			},
		},

		spawnDosJogadores = {
			Vector3.new(670, 5, 0),
		},

		spawnDeRespawn = Vector3.new(680, 5, -10),

		npcs = {
			{
				id = "NPC_007",
				nome = "Comerciante das Almas",
				posicao = Vector3.new(685, 4, -15),
				tipo = "loja",
				conteudo = { "CONS_001", "CONS_002", "CONS_003" },
			},
			{
				id = "NPC_008",
				nome = "Pajé Ancestral",
				posicao = Vector3.new(690, 4, 15),
				tipo = "quest",
			},
		},

		portais = {
			{
				nome = "Voltar para Tavy-Katu",
				posicao = Vector3.new(655, 5, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa3_TavyKatu",
				destinoPosicao = Vector3.new(630, 5, 0),
				nivelMinimo = 1,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(80, 75, 70), -- cinza
				efeitoParticula = "nevoa_luz",
			},
			{
				nome = "Caminho para Templo",
				posicao = Vector3.new(890, 5, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa5_TemploNasNuvens",
				destinoPosicao = Vector3.new(920, 55, 0),
				nivelMinimo = 22,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(255, 215, 0), -- dourado
				efeitoParticula = "nevoa_luz",
			},
		},

		ambiente = {
			musica = { assetId = "rbxassetid://1847055678", volume = 0.4, loop = true },
			corFundo = Color3.fromRGB(20, 15, 30),
			atmosfera = {
				densidade = 0.6,
				cor = Color3.fromRGB(35, 25, 45),
				deslocamento = 0,
			},
			iluminacao = {
				luzAmbiente = Color3.fromRGB(80, 60, 100),
				brilho = 0.8,
				sombras = true,
			},
			neblina = {
				habilitada = true,
				cor = Color3.fromRGB(25, 15, 35),
				distanciaInicio = 30,
				distanciaFim = 120,
			},
		},
	},

	---------------------------------------------------------------------------
	-- MAPA 5 — Templo nas Nuvens
	---------------------------------------------------------------------------
	["Mapa5_TemploNasNuvens"] = {
		nome = "Templo nas Nuvens",
		nomeExibido = "Templo nas Nuvens",
		descricao = "Templo em montanha alta cercado de nuvens sólidas e plataformas aéreas.",
		nivelRecomendado = { min = 25, max = 30 },
		bioma = "montanha",

		centro = Vector3.new(1000, 50, 0), -- Elevação +50 studs
		tamanho = { largura = 200, profundidade = 200 },

		chao = {
			tamanhoTotal = { largura = 200, profundidade = 200 },
			cor = Color3.fromRGB(240, 240, 245), -- mármore
			material = Enum.Material.Marble,
		},

		zonasDeSpawn = {
			{
				nome = "Plataforma do Templo",
				posicao = Vector3.new(1000, 53, 0),
				raio = 40,
				mobs = {
					{ id = "MOB_006", quantidade = 2 }, -- Saci Sombrio
					{ id = "MOB_009", quantidade = 2 }, -- Jurupari
				},
			},
		},

		spawnDosJogadores = {
			Vector3.new(920, 55, 0),
		},

		spawnDeRespawn = Vector3.new(930, 55, -10),

		npcs = {
			{
				id = "NPC_009",
				nome = "Mercador Celestial",
				posicao = Vector3.new(935, 54, -15),
				tipo = "loja_premium",
				conteudo = { "CONS_001", "CONS_002", "CONS_003" },
			},
			{
				id = "NPC_010",
				nome = "Mestre de Classe",
				posicao = Vector3.new(940, 54, 15),
				tipo = "classe",
			},
		},

		portais = {
			{
				nome = "Voltar para Tupã-Mbara",
				posicao = Vector3.new(905, 55, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa4_TupaMbara",
				destinoPosicao = Vector3.new(880, 5, 0),
				nivelMinimo = 1,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(85, 0, 120), -- roxo
				efeitoParticula = "nevoa_luz",
			},
			{
				nome = "Caminho para Ygara-Mbya",
				posicao = Vector3.new(1090, 55, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa6_YgaraMbya",
				destinoPosicao = Vector3.new(1120, 5, 0),
				nivelMinimo = 25,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(0, 128, 255), -- azul
				efeitoParticula = "nevoa_luz",
			},
		},

		ambiente = {
			musica = { assetId = "rbxassetid://1848183929", volume = 0.4, loop = true },
			corFundo = Color3.fromRGB(200, 220, 255),
			atmosfera = {
				densidade = 0.2,
				cor = Color3.fromRGB(220, 230, 255),
				deslocamento = 0.1,
			},
			iluminacao = {
				luzAmbiente = Color3.fromRGB(220, 220, 240),
				brilho = 2.5,
				sombras = true,
			},
			neblina = {
				habilitada = true,
				cor = Color3.fromRGB(210, 225, 250),
				distanciaInicio = 100,
				distanciaFim = 300,
			},
		},
	},

	---------------------------------------------------------------------------
	-- MAPA 6 — Ygara-Mbya (Boss Arena)
	---------------------------------------------------------------------------
	["Mapa6_YgaraMbya"] = {
		nome = "Ygara-Mbya",
		nomeExibido = "Caminho das Águas Escuras",
		descricao = "Caverna inundada e escura com estalactites e luzes subaquáticas.",
		nivelRecomendado = { min = 27, max = 30 },
		bioma = "caverna",

		centro = Vector3.new(1175, 0, 0),
		tamanho = { largura = 150, profundidade = 150 },

		chao = {
			tamanhoTotal = { largura = 150, profundidade = 150 },
			cor = Color3.fromRGB(15, 20, 30), -- rocha molhada
			material = Enum.Material.Rock,
		},

		zonasDeSpawn = {
			{
				nome = "Covil da Boiúna",
				posicao = Vector3.new(1175, 3, 0),
				raio = 30,
				mobs = {
					{ id = "MOB_007", quantidade = 1 }, -- Boiúna (Boss)
				},
			},
		},

		spawnDosJogadores = {
			Vector3.new(1120, 5, 0),
		},

		spawnDeRespawn = Vector3.new(1120, 5, -10),

		npcs = {
			{
				id = "NPC_011",
				nome = "Espírito Curandeiro",
				posicao = Vector3.new(1125, 4, 15),
				tipo = "loja",
				conteudo = { "CONS_001", "CONS_002", "CONS_003" },
			},
		},

		portais = {
			{
				nome = "Voltar para Templo",
				posicao = Vector3.new(1105, 5, 0),
				tamanho = Vector3.new(10, 15, 20),
				destino = "Mapa5_TemploNasNuvens",
				destinoPosicao = Vector3.new(1080, 55, 0),
				nivelMinimo = 1,
				visivel = true,
				transparencia = 0.7,
				cor = Color3.fromRGB(255, 215, 0), -- dourado
				efeitoParticula = "nevoa_luz",
			},
		},

		ambiente = {
			musica = { assetId = "rbxassetid://1843998495", volume = 0.4, loop = true },
			corFundo = Color3.fromRGB(10, 10, 15),
			atmosfera = {
				densidade = 0.75,
				cor = Color3.fromRGB(15, 15, 20),
				deslocamento = 0,
			},
			iluminacao = {
				luzAmbiente = Color3.fromRGB(40, 50, 60),
				brilho = 0.5,
				sombras = true,
			},
			neblina = {
				habilitada = true,
				cor = Color3.fromRGB(10, 10, 15),
				distanciaInicio = 10,
				distanciaFim = 70,
			},
		},
	},
}

-------------------------------------------------------------------------------
-- FUNÇÕES DE ACESSO
-------------------------------------------------------------------------------

--- Retorna a configuração completa de um mapa pelo ID.
--- @param mapaId string — ex: "Mapa1_YbiráPuera"
--- @return table|nil — tabela de configuração ou nil se não existir
function AtlasConfig.GetMapa(mapaId)
	return AtlasConfig.Mapas[mapaId]
end

--- Retorna a lista de portais de um mapa.
--- @param mapaId string
--- @return table — array de portais (pode ser vazio)
function AtlasConfig.GetPortais(mapaId)
	local mapa = AtlasConfig.Mapas[mapaId]
	return mapa and mapa.portais or {}
end

--- Retorna as zonas de spawn de mobs de um mapa.
--- @param mapaId string
--- @return table — array de zonas (pode ser vazio)
function AtlasConfig.GetZonasDeSpawn(mapaId)
	local mapa = AtlasConfig.Mapas[mapaId]
	return mapa and mapa.zonasDeSpawn or {}
end

--- Retorna a lista de NPCs de um mapa.
--- @param mapaId string
--- @return table — array de NPCs (pode ser vazio)
function AtlasConfig.GetNPCs(mapaId)
	local mapa = AtlasConfig.Mapas[mapaId]
	return mapa and mapa.npcs or {}
end

--- Retorna o ponto de respawn seguro de um mapa.
--- @param mapaId string
--- @return Vector3|nil — posição de respawn ou nil
function AtlasConfig.GetSpawnDeRespawn(mapaId)
	local mapa = AtlasConfig.Mapas[mapaId]
	return mapa and mapa.spawnDeRespawn or nil
end

--- Retorna todos os IDs de mapa como array.
--- @return table — array de strings com IDs dos mapas
function AtlasConfig.GetTodosMapaIds()
	local ids = {}
	for mapaId, _ in pairs(AtlasConfig.Mapas) do
		table.insert(ids, mapaId)
	end
	return ids
end

--- Conta quantos mapas existem no atlas (seguro para dicionários Lua).
--- @return number
function AtlasConfig.GetNumMapas()
	local count = 0
	for _ in pairs(AtlasConfig.Mapas) do
		count = count + 1
	end
	return count
end

return AtlasConfig
