-- SpawnSystem.lua (versão Fase 3 — atualização)
-- Gerencia spawn e respawn de mobs usando o AtlasConfig como fonte de dados.
-- Destino: ServerScriptService/Modules/SpawnSystem
--
-- SUBSTITUIR o SpawnSystem existente (Fase 1 usava posições hardcoded).
--
-- Dependências:
--   AtlasConfig → ReplicatedStorage.Modules.Config.AtlasConfig
--   AISystem    → script.Parent.AISystem
--   MobsConfig  → ReplicatedStorage.Modules.Config.MobsConfig
--
-- Última atualização: 2026-06-09 (Fase 3 MVP)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AtlasConfig = require(ReplicatedStorage.Modules.Config.AtlasConfig)
local AISystem = require(script.Parent.AISystem)
local MobsConfig = require(ReplicatedStorage.Modules.Config.MobsConfig)

local SpawnSystem = {}

-------------------------------------------------------------------------------
-- ESTADO
-------------------------------------------------------------------------------

local mobsAtivos = {}     -- Array de todos os mobs vivos ou mortos (marcados)
local RESPAWN_CHECK_INTERVAL = 5 -- segundos entre verificações de respawn

-------------------------------------------------------------------------------
-- INICIALIZAÇÃO — LÊ DO ATLASCONFIG
-------------------------------------------------------------------------------

--- Inicializa todos os mobs de todos os mapas lendo do AtlasConfig.
--- Cada mob criado recebe campos extras: mob.mapa, mob.zonaSpawn, mob.posicaoOriginal.
function SpawnSystem.Init()
	mobsAtivos = {} -- Limpar estado anterior (caso re-init)

	for mapaId, mapaConfig in pairs(AtlasConfig.Mapas) do
		for _, zona in ipairs(mapaConfig.zonasDeSpawn) do
			for _, mobSpawn in ipairs(zona.mobs) do
				for i = 1, mobSpawn.quantidade do
					-- Posição aleatória dentro do raio da zona de spawn
					local offsetX = math.random(-zona.raio, zona.raio)
					local offsetZ = math.random(-zona.raio, zona.raio)
					local pos = zona.posicao + Vector3.new(offsetX, 0, offsetZ)

					-- Criar mob via AISystem
					local mob = AISystem.CreateMob(mobSpawn.id, pos)
					if mob then
						-- Metadata de mapa (usada pelo ServerMain para IA por região)
						mob.mapa = mapaId
						mob.zonaSpawn = zona.nome
						mob.posicaoOriginal = pos

						-- Herdar respawnTime do MobsConfig se disponível
						local mobConfig = MobsConfig.GetMob(mobSpawn.id)
						if mobConfig and mobConfig.respawnSegundos then
							mob.respawnTime = mobConfig.respawnSegundos
						else
							mob.respawnTime = 30 -- padrão
						end

						table.insert(mobsAtivos, mob)
					else
						warn("[SpawnSystem] Falha ao criar mob " .. mobSpawn.id .. " em " .. mapaId)
					end
				end
			end
		end
	end

	-- Contagem segura de mapas (# não funciona com dicionários Lua)
	local numMapas = AtlasConfig.GetNumMapas()
	print("[SpawnSystem] " .. #mobsAtivos .. " mobs spawned em " .. numMapas .. " mapas.")
end

-------------------------------------------------------------------------------
-- CONSULTAS
-------------------------------------------------------------------------------

--- Retorna todos os mobs ativos (vivos e mortos).
--- @return table — array de mobs
function SpawnSystem.GetMobsAtivos()
	return mobsAtivos
end

--- Retorna apenas os mobs de um mapa específico.
--- @param mapaId string — ex: "Mapa1_YbiráPuera"
--- @return table — array filtrado
function SpawnSystem.GetMobsPorMapa(mapaId)
	local mobs = {}
	for _, mob in ipairs(mobsAtivos) do
		if mob.mapa == mapaId then
			table.insert(mobs, mob)
		end
	end
	return mobs
end

--- Retorna apenas mobs vivos de um mapa.
--- @param mapaId string
--- @return table
function SpawnSystem.GetMobsVivosPorMapa(mapaId)
	local mobs = {}
	for _, mob in ipairs(mobsAtivos) do
		if mob.mapa == mapaId and mob.estado ~= "dead" then
			table.insert(mobs, mob)
		end
	end
	return mobs
end

-------------------------------------------------------------------------------
-- MORTE E RESPAWN
-------------------------------------------------------------------------------

--- Marca um mob como morto. Não remove da tabela — será respawnado pelo timer.
--- @param mob table — referência ao mob
--- @param playerKiller Player|nil — jogador que matou (para drops futuros)
function SpawnSystem.MarcarMorto(mob, playerKiller)
	mob.estado = "dead"
	mob.mortoEm = tick()

	-- Log para debug
	print("[SpawnSystem] " .. (mob.nome or mob.id or "?") .. " morreu em " .. (mob.mapa or "?"))

	-- TODO (Fase 4 — Economia): Gerar e distribuir drops aqui
	-- local drops = DropSystem.GerarDrops(mob)
	-- if playerKiller then
	--     DropSystem.DistribuirDrops(playerKiller, drops)
	-- end

	-- Esconder modelo físico do mob (se existir)
	if mob.model and mob.model.Parent then
		mob.model.Parent = nil -- Remove do Workspace temporariamente
	end
end

--- Tenta respawnar um mob morto se o cooldown já passou.
--- @param mob table — referência ao mob
--- @return boolean — true se respawnou
function SpawnSystem.TentarRespawn(mob)
	if mob.estado ~= "dead" then return false end

	local tempoPassado = tick() - (mob.mortoEm or 0)
	local cooldown = mob.respawnTime or 30

	if tempoPassado >= cooldown then
		-- Restaurar estado
		mob.hp = mob.hpMax
		mob.estado = "idle"
		mob.alvo = nil
		mob.mortoEm = nil

		-- Reposicionar na zona de spawn original (com novo offset aleatório)
		if mob.posicaoOriginal then
			local offsetX = math.random(-5, 5)
			local offsetZ = math.random(-5, 5)
			mob.posicao = mob.posicaoOriginal + Vector3.new(offsetX, 0, offsetZ)
		end

		-- Re-inserir modelo no Workspace (se existir)
		if mob.model then
			-- Reposicionar modelo
			if mob.model:FindFirstChild("HumanoidRootPart") then
				mob.model:PivotTo(CFrame.new(mob.posicao))
			end
			mob.model.Parent = workspace.Mapas[mob.mapa] or workspace
		end

		print("[SpawnSystem] " .. (mob.nome or mob.id or "?") .. " respawnou em " .. (mob.mapa or "?"))
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- LOOP DE RESPAWN AUTOMÁTICO
-------------------------------------------------------------------------------

-- Verificar respawns pendentes periodicamente
task.spawn(function()
	while true do
		task.wait(RESPAWN_CHECK_INTERVAL)
		for _, mob in ipairs(mobsAtivos) do
			if mob.estado == "dead" then
				SpawnSystem.TentarRespawn(mob)
			end
		end
	end
end)

return SpawnSystem
