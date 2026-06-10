# GDD — Fase 3: Mundo (Mapas, Navegação, Transições)

> Define a estrutura de mapas, spawn zones, navegação e transições do MVP.
> A Fase 3 transforma o servidor standalone num mundo conectado com identidade visual por região.
> Critério de saída: 6 mapas funcionando com spawn correto, transições suaves e minimapa operacional.

---

## 3.1 — CONCEITOS-CHAVE (para o desenvolvedor)

### O que é um "mapa" no Roblox
No Roblox, um mapa é simplesmente uma região 3D dentro do `Workspace`. Não existe conceito nativo de "mapa" como em engines Unity/Unreal — tudo é um espaço contínuo (ou não, dependendo da abordagem).

**Duas abordagens possíveis:**

| Abordagem | Como funciona | Prós | Contras |
|---|---|---|---|
| A) Espaço contínuo | Mapas são regiões adjacentes num único Workspace. Jogador anda de um para o outro. | Simples, nativo, sem loading. | Distância entre mapas pode causar lag se tudo estiver carregado. |
| B) Teleport + Loading | Cada mapa é isolado. Ao chegar na borda, teleporta para outro lugar com tela de transição. | Permite mapas mais detalhados, controla loading. | Mais complexo de implementar e testar. |

**Recomendação MVP: Abordagem A (espaço contínuo).** Mais simples, funciona bem com 6 mapas pequenos a médios. Se precisar otimizar depois, migra-se para B.

### O que é "zona de spawn" (SpawnZone)
Uma SpawnZone é uma região invisível (ou visível para debug) que define:
- Quais mobs nascem ali
- Quantos mobs de cada tipo
- Onde exatamente (posição base + dispersão aleatória)
- Raio de patrulha (área onde o mob anda quando em idle)

### O que é "transição de mapa" (MapTransition)
No MVP, a transição entre mapas é feita por **portais físicos** — partes invisíveis (ou visíveis como arcos/portas) que, ao serem tocadas, movem o jogador para a região correta. Também servem como "cercas" para evitar que jogadores de nível 1 entrem em áreas de nível 30.

### O que é "minimapa"
Um UI 2D que mostra a posição do jogador e dos mobs num mapa estilizado. Implementado como Frame + ImageLabels no `StarterGui`. Não precisa ter arte detalhada no MVP — formas geométricas coloridas bastam.

---

## 3.2 — ESPECIFICAÇÃO DOS 6 MAPAS

### Mapa1_YbiráPuera — Ybirá-Puera (Zona Inicial)
- **Palavra tupi:** "Ybirá" = árvore(s) (no plural contextual), "Puera" = antigas/ancestrais → **"Rio das Árvores Antigas"**
  > [!NOTE]
  > Embora "Ybirá" literalmente signifique "árvore", no contexto local o termo se refere ao bosque secular que margeia o rio. "Puera" intensifica o caráter ancestral. Assim, a zona inteira — o rio cercado por árvores milenares — é o Ybirá-Puera.
- **Bioma visual:** Mata Atlântica — vegetação densa, rios, troncos caídos
- **Dimensões:** 200x200 studs centrados em (0, 0, 0) no Workspace
- **Tonalidade:** Verdes vibrantes, luz filtrada pelas copas, névoa leve
- **Tipos de chão:** Grama (verde), terra (marrom), água de rio (azul, parte central)
- **Mobs:** MOB_001 Sapo Cururu (5 spawns), MOB_015 Capivara (3), MOB_002 Cobra-d'Água (4)
- **NPCs:** 1 NPC de loja (curandeiro/comerciante), 1 NPC de quest/tutorial
- **Nível recomendado:** 1–10
- **Ponto de spawn dos jogadores:** Centro-oeste do mapa, próximo ao rio
- **Transições:** Leste → Mapa2_FlorestaMaeDaMata

---

### Mapa2_FlorestaMaeDaMata — Floresta de Mãe-da-Mata
- **Bioma visual:** Amazônia — floresta extremamente densa, cipós, cogumelos bioluminescentes
- **Dimensões:** 300x300 studs, posicionado a leste do Mapa1_YbiráPuera (centro em `Vector3.new(250, 0, 0)`)
- **Tonalidade:** Verdes escuro, sombras profundas, luz difusa
- **Tipos de chão:** Terra, vegetação rasteira, pequenos lagos
- **Mobs:** MOB_003 Mãe-da-Mata (3), MOB_011 Boto Cor-de-Rosa (2), MOB_013 Corpo Seco (2)
- **NPCs:** 1 NPC de loja, 1 NPC xamã (Karaí)
- **Nível recomendado:** 10–15
- **Transições:** Oeste → Mapa1_YbiráPuera, Leste → Mapa3_TavyKatu

---

### Mapa3_TavyKatu — Tavy-Katu
- **Significado:** "Clareira Amaldiçoada" (Tavy = clareira, Katu = bom/ambição irônica)
- **Bioma visual:** Área queimada em recuperação — troncos carbonizados, vegetação rasteira, poeira no ar, fogueiras
- **Dimensões:** 250x250 studs, posicionado a leste do Mapa2_FlorestaMaeDaMata (centro em `Vector3.new(525, 0, 0)`)
- **Tonalidade:** Marrom, laranja, cinza, fumaça
- **Tipos de chão:** Terra cinza, cinzas, clareiras
- **Mobs:** MOB_004 Boitatá (3), MOB_012 Mula Sem Cabeça (2), MOB_016 Jacaré-Açu (2)
- **NPCs:** 1 NPC de loja, 1 NPC ferreiro
- **Nível recomendado:** 15–20
- **Transições:** Oeste → Mapa2_FlorestaMaeDaMata, Leste → Mapa4_TupaMbara

---

### Mapa4_TupaMbara — Tupã-Mbara
- **Significado:** "Campo dos Ancestrais" (Tupã = deus, Mbara = campo/terra)
- **Bioma visual:** Cemitério indígena em mata fechada — totens, ossos, oferendas, névoa espessa
- **Dimensões:** 250x250 studs, posicionado a leste do Mapa3_TavyKatu (centro em `Vector3.new(775, 0, 0)`)
- **Tonalidade:** Roxo-escuro, cinza, névoa, postes de luz fraca
- **Tipos de chão:** Terra escura, musgo, pedras
- **Mobs:** MOB_005 Curupira (2), MOB_008 Anhangá (2), MOB_014 Onça-Pintada (2)
- **NPCs:** 1 NPC de loja, 1 NPC ancestral (fantasma/pajé)
- **Nível recomendado:** 20–25
- **Transições:** Oeste → Mapa3_TavyKatu, Leste → Mapa5_TemploNasNuvens

---

### Mapa5_TemploNasNuvens — Templo nas Nuvens
- **Bioma visual:** Templo em montanha — escadarias, pilares, nuvens ao redor, vento
- **Dimensões:** 200x200 studs, posicionado a leste do Mapa4_TupaMbara (centro em `Vector3.new(1000, 50, 0)`)
- **Elevation:** +50 studs de altura em relação ao Mapa1_YbiráPuera
- **Tonalidade:** Branco, dourado, azul-céu, nuvens (efeitos de partículas)
- **Tipos de chão:** Pedra branca, mármore, nuvens sólidas (plataformas invisíveis)
- **Mobs:** MOB_006 Saci Sombrio (2), MOB_009 Jurupari (2)
- **NPCs:** 1 NPC de loja premium, 1 NPC de evolução de classe
- **Nível recomendado:** 25–30
- **Transições:** Oeste → Mapa4_TupaMbara, Leste → Mapa6_YgaraMbya (Boss Arena)

---

### Mapa6_YgaraMbya — Ygara-Mbya (Boss Arena)
- **Significado:** "Caminho das Águas Escuras" (Ygara = canoa, Mbya = escuro)
- **Bioma visual:** Caverna inundada — estalactites, água escura, luz subaquática
- **Dimensões:** 150x150 studs (arena compacta), posicionado a leste do Mapa5_TemploNasNuvens (centro em `Vector3.new(1175, 0, 0)`)
- **Tonalidade:** Azul-escuro, preto, verde-água bioluminescente
- **Tipos de chão:** Pedra molhada, água rasa
- **Mobs:** MOB_007 Boiúna (1, spawn único do boss)
- **NPCs:** 1 NPC curandeiro (recuperação antes do boss)
- **Nível recomendado:** 30 (boss) / 27–30 (preparação)
- **Transições:** Oeste → Mapa5_TemploNasNuvens
- **Mecânica especial:** Portal que exige nível mínimo 25 para entrar

---

## 3.3 — SISTEMA DE TRANSIÇÕES

### Lógica de Transição — Abordagem A (Espaço Contínuo)

Cada mapa ocupa uma faixa do eixo X do Workspace:

```
[Mapa1: X -100 a +100] [Mapa1→2: Portão] [Mapa2: +100 a +400] [Mapa2→3: Portão] [Mapa3: +400 a +650] [Mapa3→4: Portão] [Mapa4: +650 a +900] [Mapa4→5: Portão] [Mapa5: +900 a +1100] [Mapa5→6: Portão] [Mapa6: +1100 a +1250]
```

> [!NOTE]
> **Nota sobre posições e layout de espaço contínuo (INC-04 & INC-07):**
> Os mapas são adjacentes no eixo X. Os portais ficam posicionados em uma **faixa de sobreposição** de ~10 studs da borda de cada mapa para garantir transições suaves sem buracos ou quedas do mapa. Por exemplo, o portal do Mapa1 está em X=90 e o destino no Mapa2 está em X=120. Estas coordenadas de centro e limites especificadas na Fase 3 substituem qualquer coordenada provisória definida nas fases anteriores.

### Portais de Transição

No MVP, cada transição é um `Part` invisível que ao ser tocado (`Touched`) executa a lógica:

```lua
-- Exemplo: Portal entre Mapa1_YbiráPuera e Mapa2_FlorestaMaeDaMata
-- Part invisível de 1x10x10 studs na borda entre os mapas
-- Script anexado ao Part:

local portal = script.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local cooldowns = {} -- SUG-01: Debounce nos portais para evitar múltiplos teletransportes seguidos

portal.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if not player then return end

    -- SUG-01: Throttling de 3 segundos no portal por jogador
    if cooldowns[player.UserId] and tick() - cooldowns[player.UserId] < 3 then return end
    cooldowns[player.UserId] = tick()

    local currentState = player:GetAttribute("MapaAtual") or "Mapa1"

    if currentState == "Mapa1" then
        -- Mover jogador para entrada do Mapa2_FlorestaMaeDaMata
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- BUG-02: PivotTo substituindo o obsoleto SetPrimaryPartCFrame
            character:PivotTo(CFrame.new(120, 10, 0))
            player:SetAttribute("MapaAtual", "Mapa2")
            -- Notificar cliente
            ReplicatedStorage.Remotes.Mapa.ChangeMap:FireClient(player, "Mapa2")
        end
    elseif currentState == "Mapa2" then
        -- Mover jogador para entrada do Mapa1_YbiráPuera
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- BUG-02: PivotTo substituindo o obsoleto SetPrimaryPartCFrame
            character:PivotTo(CFrame.new(80, 10, 0))
            player:SetAttribute("MapaAtual", "Mapa1")
            ReplicatedStorage.Remotes.Mapa.ChangeMap:FireClient(player, "Mapa1")
        end
    end
end)
```

### Validação de Nível (Portão do Boss)

O portal para o Mapa6_YgaraMbya tem validação extra:

```lua
-- Portal Mapa5 → Mapa6 (Ygara-Mbya) exige nível mínimo 25
local NIVEL_MINIMO_BOSS = 25
local cooldowns = {}

portal.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if not player then return end

    if cooldowns[player.UserId] and tick() - cooldowns[player.UserId] < 3 then return end
    cooldowns[player.UserId] = tick()

    local data = DataController.GetData(player)
    if not data or data.nivel < NIVEL_MINIMO_BOSS then
        ReplicatedStorage.Remotes.Mapa.LevelTooLow:FireClient(player, NIVEL_MINIMO_BOSS)
        return
    end

    -- Permitir passagem
    TrocarMapa(player, "Mapa6")
end)
```

---

## 3.4 — MINIMAPA

### Especificação do Minimapa

O minimapa é um `Frame` no `StarterGui`:
- Tamanho: 140x140 pixels (diâmetro) no canto superior direito — compatível com mockup de UI
- Forma: CÍRCULO (não quadrado) — usar UICorner com CornerRadius = UDim.new(0.5, 0)
  para criar o círculo. O mockup usa border-radius: 50% no CSS, que equivale a UICorner no Roblox.
  O fundo é radial-gradient (radial no mockup = ImageLabel com gradiente ou cor sólida esverdeada).
- Fundo: imagem estilizada do mapa (no MVP: retângulo colorido com cantos arredondados)
- Indicador do jogador: triângulo azul que indica posição e orientação
- Indicadores de mobs: pontos vermelhos
- Indicadores de NPCs: pontos verdes/amarelos
- Zoom: fixo por mapa (cada mapa tem seu próprio minimapa)

### Estrutura de UI

```
StarterGui
    Minimapa
        MapaAtual (Frame) — fundo do minimapa
            JogadorDot (ImageLabel) — posição do jogador
            MobDots (Folder) — indicadores de mob
                MobDot_1, MobDot_2, ...
            NPCDots (Folder) — indicadores de NPC
                NPCDot_1, ...
        MapaCorner (Frame) — canto superior direito do minimapa
        Legenda (Frame) — legenda dos ícones
```

### Lógica de Atualização — com Throttling

O Client ouve o `ChangeMap` RemoteEvent para trocar a imagem do minimapa.

⚠️ REVISÃO 6 — PERFORMANCE:
- Throttling inteligente: o server só envia atualização se a posição do jogador
  mudou >5 studs desde o último envio (evita spam de RemoteEvents).
- Usar `RemoteEvent:FireClientUnreliable(player, ...)` em vez de `FireClient()`
  para atualizações do minimapa. Perda de alguns frames é imperceptível
  e reduz significativamente a carga de rede, especialmente com 20+ jogadores.
- taxa máxima: mesmo com throttling, limitar a 1 update/segundo por jogador no máximo.

---

## 3.5 — ESTRUTURA DE SCRIPTS (o que será gerado)

### Novos ModuleScripts em ReplicatedStorage/Modules/Config/

#### 3.5.1 AtlasConfig.lua
Configuração central de todos os mapas.

```lua
-- AtlasConfig.lua
-- Configuração de todos os mapas, zonas e transições do jogo

local AtlasConfig = {}

-- Mapas configurados
AtlasConfig.Mapas = {
    ["Mapa1_YbiráPuera"] = {
        nome = "Ybirá-Puera",
        nomeExibido = "Rio das Árvores Antigas", -- INC-06: Nome corrigido conforme Lore
        descricao = "Zona inicial. Vegetação densa às margens de um rio caudaloso.",
        nivelRecomendado = {min = 1, max = 10},
        bioma = "mata_atlantica", -- SUG-07: Campo de bioma adicionado

        -- Posição no Workspace (centro do mapa)
        centro = Vector3.new(0, 0, 0),
        tamanho = {largura = 200, profundidade = 200},

        -- Chão
        chao = {
            tamanhoTotal = {largura = 250, profundidade = 250},
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
                    {id = "MOB_001", quantidade = 5}, -- Sapo Cururu
                    {id = "MOB_015", quantidade = 3}, -- Capivara
                    {id = "MOB_002", quantidade = 4}, -- Cobra-d'Água
                },
            },
        },

        -- Pontos de spawn para jogadores (quando entram no jogo pela primeira vez)
        spawnDosJogadores = {
            Vector3.new(-20, 5, -20),
            Vector3.new(-15, 5, -25),
            Vector3.new(-25, 5, -15),
        },

        -- Ponto de respawn após morte (zona segura, preferencialmente perto de NPC curandeiro/loja)
        -- Pode ser o mesmo que spawnDosJogadores[1] ou diferente.
        -- Dica: posicione atrás de uma barreira natural (muro, rocha, cerca) para evitar
        -- que o jogador respawne em zona de aggro de mobs agressivos.
        spawnDeRespawn = Vector3.new(-25, 5, -25),

        -- NPCs
        npcs = {
            {
                id = "NPC_001",
                nome = "Curandeiro Ancião",
                posicao = Vector3.new(10, 4, -10),
                tipo = "loja",
                conteudo = {"CONS_001", "CONS_002", "CONS_003"}, -- INC-05: Corrigido para IDs de consumíveis reais
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
                posicao = Vector3.new(90, 5, 0), -- zona de transição (10 studs antes da borda)
                tamanho = Vector3.new(10, 15, 20), -- portal cobre toda a largura da zona de transição
                destino = "Mapa2_FlorestaMaeDaMata",
                destinoPosicao = Vector3.new(120, 5, 0), -- dentro do Mapa2, 20 studs da borda
                nivelMinimo = 8, -- requisito para passar
                -- ⚠️ REVISÃO 8: Portal VISÍVEL com feedback visual para o jogador
                -- No MVP: Part semi-transparente com ParticleEmitter anexado
                -- Efeito sugerido: névoa verde-dourada ou luz pulsante
                visivel = true,
                transparencia = 0.7, -- 0 = opaco, 1 = invisível
                cor = Color3.fromRGB(100, 255, 180), -- verde-dourado
                efeitoParticula = "nevoa_luz", -- ParticleEmitter anexado ao Part
                -- O ParticleEmitter deve ter:
                --   Rate = 20, Lifetime = NumberRange(1, 2),
                --   Speed = NumberRange(1, 3), Color = cor do portal,
                --   Size = NumberSequence(0.5, 0), Transparency = NumberSequence(0.5, 1)
                
            },
        },

        -- Ambientacao
        ambiente = {
            musica = { assetId = "rbxassetid://9013233455", volume = 0.5, loop = true }, -- FALT-03: Campo de música obrigatório
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

    ["Mapa2_FlorestaMaeDaMata"] = { -- FALT-01, SUG-08: Template expandido para Mapa 2
        nome = "Floresta de Mãe-da-Mata",
        nomeExibido = "Floresta da Mãe-da-Mata",
        descricao = "Floresta extremamente densa, com cipós e cogumelos bioluminescentes.",
        nivelRecomendado = {min = 10, max = 15},
        bioma = "amazonia", -- SUG-07: Bioma

        centro = Vector3.new(250, 0, 0), -- FALT-04: Centro Vector3 exato
        tamanho = {largura = 300, profundidade = 300},

        chao = { -- FALT-05: Chão do mapa
            tamanhoTotal = {largura = 300, profundidade = 300},
            cor = Color3.fromRGB(24, 61, 21), -- verde escuro
            material = Enum.Material.Grass,
        },

        zonasDeSpawn = {
            {
                nome = "Corpo da Floresta",
                posicao = Vector3.new(250, 3, 0),
                raio = 60,
                mobs = {
                    {id = "MOB_003", quantidade = 3}, -- Mãe-da-Mata
                    {id = "MOB_011", quantidade = 2}, -- Boto Cor-de-Rosa
                    {id = "MOB_013", quantidade = 2}, -- Corpo Seco
                },
            },
        },

        spawnDosJogadores = {
            Vector3.new(120, 5, 0),
        },

        spawnDeRespawn = Vector3.new(125, 5, 5), -- FALT-02: Ponto de respawn seguro

        npcs = {
            {
                id = "NPC_003",
                nome = "Comerciante da Floresta",
                posicao = Vector3.new(130, 4, -10),
                tipo = "loja",
                conteudo = {"CONS_001", "CONS_002", "CONS_003"},
            },
            {
                id = "NPC_004",
                nome = "Karaí (Xamã)",
                posicao = Vector3.new(135, 4, 15),
                tipo = "quest",
            },
        },

        portais = { -- FALT-06: Portais bidirecionais
            {
                nome = "Caminho para Ybirá-Puera",
                posicao = Vector3.new(105, 5, 0),
                tamanho = Vector3.new(10, 15, 20),
                destino = "Mapa1_YbiráPuera",
                destinoPosicao = Vector3.new(80, 5, 0),
                nivelMinimo = 1,
                visivel = true,
                transparencia = 0.7,
                cor = Color3.fromRGB(45, 90, 39),
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
                cor = Color3.fromRGB(150, 75, 0),
                efeitoParticula = "nevoa_luz",
            },
        },

        ambiente = {
            musica = { assetId = "rbxassetid://9013233456", volume = 0.5, loop = true }, -- FALT-03
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

    ["Mapa3_TavyKatu"] = { -- FALT-01, SUG-08: Template expandido para Mapa 3
        nome = "Tavy-Katu",
        nomeExibido = "Clareira Amaldiçoada",
        descricao = "Área queimada em recuperação, com cinzas, troncos carbonizados e fogueiras.",
        nivelRecomendado = {min = 15, max = 20}, -- INC-01: Mantendo 15-20 conforme GDD Mundo (supera erro em mechanics.md)
        bioma = "cerrado_queimado", -- SUG-07: Bioma

        centro = Vector3.new(525, 0, 0),
        tamanho = {largura = 250, profundidade = 250},

        chao = { -- FALT-05: Chão do mapa
            tamanhoTotal = {largura = 250, profundidade = 250},
            cor = Color3.fromRGB(80, 75, 70), -- cinza terra
            material = Enum.Material.Rock,
        },

        zonasDeSpawn = {
            {
                nome = "Clareira Principal",
                posicao = Vector3.new(525, 3, 0),
                raio = 50,
                mobs = {
                    {id = "MOB_004", quantidade = 3}, -- Boitatá
                    {id = "MOB_012", quantidade = 2}, -- Mula Sem Cabeça
                    {id = "MOB_016", quantidade = 2}, -- Jacaré-Açu
                },
            },
        },

        spawnDosJogadores = {
            Vector3.new(420, 5, 0),
        },

        spawnDeRespawn = Vector3.new(430, 5, -10), -- FALT-02: Ponto de respawn seguro

        npcs = {
            {
                id = "NPC_005",
                nome = "Comerciante das Cinzas",
                posicao = Vector3.new(435, 4, -15),
                tipo = "loja",
                conteudo = {"CONS_001", "CONS_002", "CONS_003"},
            },
            {
                id = "NPC_006",
                nome = "Ferreiro Sobrevivente",
                posicao = Vector3.new(440, 4, 10),
                tipo = "ferreiro",
            },
        },

        portais = { -- FALT-06: Portais bidirecionais
            {
                nome = "Voltar para Floresta",
                posicao = Vector3.new(405, 5, 0),
                tamanho = Vector3.new(10, 15, 20),
                destino = "Mapa2_FlorestaMaeDaMata",
                destinoPosicao = Vector3.new(370, 5, 0),
                nivelMinimo = 1,
                visivel = true,
                transparencia = 0.7,
                cor = Color3.fromRGB(24, 61, 21),
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
                cor = Color3.fromRGB(85, 0, 120),
                efeitoParticula = "nevoa_luz",
            },
        },

        ambiente = {
            musica = { assetId = "rbxassetid://9013233457", volume = 0.5, loop = true }, -- FALT-03
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

    ["Mapa4_TupaMbara"] = { -- FALT-01, SUG-08: Template expandido para Mapa 4
        nome = "Tupã-Mbara",
        nomeExibido = "Campo dos Ancestrais",
        descricao = "Cemitério indígena em mata fechada com totens, ossos e névoa espessa.",
        nivelRecomendado = {min = 20, max = 25},
        bioma = "floresta_fechada", -- SUG-07: Bioma

        centro = Vector3.new(775, 0, 0),
        tamanho = {largura = 250, profundidade = 250},

        chao = { -- FALT-05: Chão do mapa
            tamanhoTotal = {largura = 250, profundidade = 250},
            cor = Color3.fromRGB(35, 30, 45), -- roxo escuro terra
            material = Enum.Material.Mud,
        },

        zonasDeSpawn = {
            {
                nome = "Cemitério Ancestral",
                posicao = Vector3.new(775, 3, 0),
                raio = 50,
                mobs = {
                    {id = "MOB_005", quantidade = 2}, -- Curupira
                    {id = "MOB_008", quantidade = 2}, -- Anhangá
                    {id = "MOB_014", quantidade = 2}, -- Onça-Pintada
                },
            },
        },

        spawnDosJogadores = {
            Vector3.new(670, 5, 0),
        },

        spawnDeRespawn = Vector3.new(680, 5, -10), -- FALT-02: Ponto de respawn seguro

        npcs = {
            {
                id = "NPC_007",
                nome = "Comerciante das Almas",
                posicao = Vector3.new(685, 4, -15),
                tipo = "loja",
                conteudo = {"CONS_001", "CONS_002", "CONS_003"},
            },
            {
                id = "NPC_008",
                nome = "Pajé Ancestral",
                posicao = Vector3.new(690, 4, 15),
                tipo = "quest",
            },
        },

        portais = { -- FALT-06: Portais bidirecionais
            {
                nome = "Voltar para Tavy-Katu",
                posicao = Vector3.new(655, 5, 0),
                tamanho = Vector3.new(10, 15, 20),
                destino = "Mapa3_TavyKatu",
                destinoPosicao = Vector3.new(630, 5, 0),
                nivelMinimo = 1,
                visivel = true,
                transparencia = 0.7,
                cor = Color3.fromRGB(80, 75, 70),
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
                cor = Color3.fromRGB(255, 215, 0),
                efeitoParticula = "nevoa_luz",
            },
        },

        ambiente = {
            musica = { assetId = "rbxassetid://9013233458", volume = 0.5, loop = true }, -- FALT-03
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

    ["Mapa5_TemploNasNuvens"] = { -- FALT-01, SUG-08: Template expandido para Mapa 5
        nome = "Templo nas Nuvens",
        nomeExibido = "Templo nas Nuvens",
        descricao = "Templo em montanha alta cercado de nuvens sólidas e plataformas aéreas.",
        nivelRecomendado = {min = 25, max = 30},
        bioma = "montanha", -- SUG-07: Bioma

        centro = Vector3.new(1000, 50, 0), -- SUG-04: Elevação de 50 studs refletida no centro Vector3
        tamanho = {largura = 200, profundidade = 200},

        chao = { -- FALT-05: Chão do mapa
            tamanhoTotal = {largura = 200, profundidade = 200},
            cor = Color3.fromRGB(240, 240, 245), -- pedra mármore
            material = Enum.Material.Marble,
        },

        zonasDeSpawn = {
            {
                nome = "Plataforma do Templo",
                posicao = Vector3.new(1000, 53, 0),
                raio = 40,
                mobs = {
                    {id = "MOB_006", quantidade = 2}, -- Saci Sombrio
                    {id = "MOB_009", quantidade = 2}, -- Jurupari
                },
            },
        },

        spawnDosJogadores = {
            Vector3.new(920, 55, 0),
        },

        spawnDeRespawn = Vector3.new(930, 55, -10), -- FALT-02: Ponto de respawn seguro

        npcs = {
            {
                id = "NPC_009",
                nome = "Mercador Celestial",
                posicao = Vector3.new(935, 54, -15),
                tipo = "loja_premium",
                conteudo = {"CONS_001", "CONS_002", "CONS_003"},
            },
            {
                id = "NPC_010",
                nome = "Mestre de Classe",
                posicao = Vector3.new(940, 54, 15),
                tipo = "classe",
            },
        },

        portais = { -- FALT-06: Portais bidirecionais
            {
                nome = "Voltar para Tupã-Mbara",
                posicao = Vector3.new(905, 55, 0),
                tamanho = Vector3.new(10, 15, 20),
                destino = "Mapa4_TupaMbara",
                destinoPosicao = Vector3.new(880, 5, 0),
                nivelMinimo = 1,
                visivel = true,
                transparencia = 0.7,
                cor = Color3.fromRGB(85, 0, 120),
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
                cor = Color3.fromRGB(0, 128, 255),
                efeitoParticula = "nevoa_luz",
            },
        },

        ambiente = {
            musica = { assetId = "rbxassetid://9013233459", volume = 0.5, loop = true }, -- FALT-03
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

    ["Mapa6_YgaraMbya"] = { -- FALT-01, SUG-08: Template expandido para Mapa 6
        nome = "Ygara-Mbya",
        nomeExibido = "Caminho das Águas Escuras",
        descricao = "Caverna inundada e escura com estalactites e luzes subaquáticas.",
        nivelRecomendado = {min = 27, max = 30},
        bioma = "caverna", -- SUG-07: Bioma

        centro = Vector3.new(1175, 0, 0),
        tamanho = {largura = 150, profundidade = 150},

        chao = { -- FALT-05: Chão do mapa
            tamanhoTotal = {largura = 150, profundidade = 150},
            cor = Color3.fromRGB(15, 20, 30), -- rocha molhada
            material = Enum.Material.Rock,
        },

        zonasDeSpawn = {
            {
                nome = "Covil da Boiúna",
                posicao = Vector3.new(1175, 3, 0),
                raio = 30,
                mobs = {
                    {id = "MOB_007", quantidade = 1}, -- Boiúna (Boss)
                },
            },
        },

        spawnDosJogadores = {
            Vector3.new(1120, 5, 0),
        },

        spawnDeRespawn = Vector3.new(1120, 5, -10), -- FALT-02: Ponto de respawn seguro

        npcs = {
            {
                id = "NPC_011",
                nome = "Espírito Curandeiro",
                posicao = Vector3.new(1125, 4, 15),
                tipo = "loja",
                conteudo = {"CONS_001", "CONS_002", "CONS_003"},
            },
        },

        portais = { -- FALT-06: Portais bidirecionais
            {
                nome = "Voltar para Templo",
                posicao = Vector3.new(1105, 5, 0),
                tamanho = Vector3.new(10, 15, 20),
                destino = "Mapa5_TemploNasNuvens",
                destinoPosicao = Vector3.new(1080, 55, 0),
                nivelMinimo = 1,
                visivel = true,
                transparencia = 0.7,
                cor = Color3.fromRGB(255, 215, 0),
                efeitoParticula = "nevoa_luz",
            },
        },

        ambiente = {
            musica = { assetId = "rbxassetid://9013233460", volume = 0.5, loop = true }, -- FALT-03
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

function AtlasConfig.GetMapa(mapaId)
    return AtlasConfig.Mapas[mapaId]
end

function AtlasConfig.GetPortais(mapaId)
    local mapa = AtlasConfig.Mapas[mapaId]
    return mapa and mapa.portais or {}
end

function AtlasConfig.GetZonasDeSpawn(mapaId)
    local mapa = AtlasConfig.Mapas[mapaId]
    return mapa and mapa.zonasDeSpawn or {}
end

function AtlasConfig.GetNPCs(mapaId)
    local mapa = AtlasConfig.Mapas[mapaId]
    return mapa and mapa.npcs or {}
end

return AtlasConfig
```

---

### Novos Scripts em ServerScriptService/

#### 3.5.2 MapaManager.lua
Gerencia transições, detecção de mapa atual e validações.

```lua
-- MapaManager.lua
-- Gerencia transições entre mapas, detecção de mapa atual, validação de nível
-- ServerScriptService/Modules/MapaManager.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataController = require(script.Parent.DataController)
local AtlasConfig = require(ReplicatedStorage.Modules.Config.AtlasConfig)

local MapaManager = {}

-- RemoteEvents necessários (criar em ReplicatedStorage/Remotes/Mapa/)
local ChangeMapEvent = ReplicatedStorage.Remotes.Mapa.ChangeMap
local LevelTooLowEvent = ReplicatedStorage.Remotes.Mapa.LevelTooLow

-- Atualizar atributo "MapaAtual" do jogador
function MapaManager.SetMapaAtual(player, mapaId)
    player:SetAttribute("MapaAtual", mapaId)
    ChangeMapEvent:FireClient(player, mapaId)
    print("[MapaManager] " .. player.Name .. " agora está em " .. mapaId)
end

-- Detectar mapa atual pela posição
-- ⚠️ REVISÃO 3: Ordenar mapas por proximidade antes de testar.
-- Isso evita falsos positivos em bordas onde mapas se tocam.
function MapaManager.DetectarMapa(player)
    if not player.Character then return nil end
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end

    local pos = rootPart.Position

    -- Calcular distância do jogador ao centro de cada mapa
    local function Distancia2D(a, b)
        return math.sqrt((a.X - b.X)^2 + (a.Z - b.Z)^2)
    end

    local mapasOrdenados = {}
    for mapaId, config in pairs(AtlasConfig.Mapas) do
        local dist = Distancia2D(pos, config.centro)
        table.insert(mapasOrdenados, {mapaId = mapaId, config = config, dist = dist})
    end
    table.sort(mapasOrdenados, function(a, b) return a.dist < b.dist end)

    -- Testar primeiro o mais próximo
    for _, entry in ipairs(mapasOrdenados) do
        local config = entry.config
        if math.abs(pos.X - config.centro.X) <= config.tamanho.largura / 2 and
           math.abs(pos.Z - config.centro.Z) <= config.tamanho.profundidade / 2 then
            return entry.mapaId
        end
    end

    return nil
end

-- Validar passagem pelo portal
function MapaManager.ValidarPassagem(player, portalConfig)
    local data = DataController.GetData(player)
    if not data then return false, "Dados não carregados" end

    if data.nivel < (portalConfig.nivelMinimo or 1) then
        return false, "Nível " .. portalConfig.nivelMinimo .. " necessário"
    end

    return true, "OK"
end

-- Teleportar jogador para destino do portal
function MapaManager.TeleportarParaPortal(player, destinoMapa, destinoPosicao)
    if not player.Character then return end
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    rootPart.CFrame = CFrame.new(destinoPosicao)
    MapaManager.SetMapaAtual(player, destinoMapa)
end

-- Handler de colisão com portais
function MapaManager.OnPortalTouched(portal, player)
    local data = DataController.GetData(player)
    if not data then return end

    local portalConfig = portal.ConfigData -- ConfigData anexada ao Part

    local valido, mensagem = MapaManager.ValidarPassagem(player, portalConfig)
    if valido then
        MapaManager.TeleportarParaPortal(player, portalConfig.destino, portalConfig.destinoPosicao)
    else
        LevelTooLowEvent:FireClient(player, portalConfig.nivelMinimo, mensagem)
    end
end

return MapaManager
```

---

### Novos Scripts em StarterPlayerScripts/

#### 3.5.3 MinimapaController.lua
Gerencia display do minimapa no client.

```lua
-- MinimapaController.lua
-- Atualiza o minimapa com posição do jogador e mobs
-- StarterPlayerScripts/MinimapaController.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local MinimapaController = {}

-- RemoteEvents
local ChangeMapEvent = ReplicatedStorage.Remotes.Mapa.ChangeMap
local UpdateMinimapaEvent = ReplicatedStorage.Remotes.Mapa.UpdateMinimapa

-- Referências de UI (serão criadas dinamicamente ou no StarterGui)
local minimapaFrame = nil
local jogadorDot = nil
local mobDotsFolder = nil

function MinimapaController.Init()
    -- Obter ou criar frame do minimapa
    local gui = playerGui:FindFirstChild("MinimapaGui")
    if not gui then
        gui = Instance.new("ScreenGui")
        gui.Name = "MinimapaGui"
        gui.ResetOnSpawn = false
        gui.Parent = playerGui
    end

    minimapaFrame = gui:FindFirstChild("MinimapaFrame")
    if not minimapaFrame then
        minimapaFrame = Instance.new("Frame")
        minimapaFrame.Name = "MinimapaFrame"
        minimapaFrame.Size = UDim2.new(0, 140, 0, 140)  -- 140x140, compatível com mockup
        minimapaFrame.Position = UDim2.new(1, -160, 0, 10)
        minimapaFrame.BorderSizePixel = 0
        minimapaFrame.Parent = gui

        -- Minimapa CIRCULAR (140x140) (BUG-04 corrigido: apenas um UICorner)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.5, 0) -- faz o círculo
        corner.Parent = minimapaFrame

        -- Fundo esverdeado (BUG-05 corrigido: atribuído apenas uma vez)
        minimapaFrame.BackgroundColor3 = Color3.fromRGB(20, 50, 20)

        -- Indicador do jogador (triângulo azul)
        jogadorDot = Instance.new("Frame")
        jogadorDot.Name = "JogadorDot"
        jogadorDot.Size = UDim2.new(0, 8, 0, 8)
        jogadorDot.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        jogadorDot.Position = UDim2.new(0.5, -4, 0.5, -4)
        jogadorDot.BorderSizePixel = 0
        jogadorDot.Parent = minimapaFrame

        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(0.5, 0)
        dotCorner.Parent = jogadorDot

        -- Label "N" (norte) no topo do círculo
        local nLabel = Instance.new("TextLabel")
        nLabel.Name = "NorteLabel"
        nLabel.Size = UDim2.new(1, 0, 0, 14)
        nLabel.Position = UDim2.new(0, 0, 0, 4)
        nLabel.BackgroundTransparency = 1
        nLabel.Text = "N"
        nLabel.TextColor3 = Color3.fromRGB(212, 163, 115) -- var(--accent)
        nLabel.TextSize = 10
        nLabel.Font = Enum.Font.GothamBold
        nLabel.Parent = minimapaFrame
    end
end

-- Convertar posição do mundo para coordenadas do minimapa (0-1)
function MinimapaController.MundoParaMinimapa(worldPos, mapaConfig)
    local centro = mapaConfig.centro
    local tam = mapaConfig.tamanho

    local relX = (worldPos.X - centro.X + tam.largura/2) / tam.largura
    local relZ = (worldPos.Z - centro.Z + tam.profundidade/2) / tam.profundidade

    return math.clamp(relX, 0, 1), math.clamp(relZ, 0, 1)
end

-- Quando o mapa mudar, atualizar display
ChangeMapEvent.OnClientEvent:Connect(function(mapaId)
    print("[Minimapa] Mapa alterado para: " .. mapaId)
    -- No MVP: apenas atualizar a cor de fundo para indicar novo mapa
    -- Versão futura: trocar a imagem do fundo
end)

return MinimapaController
```

---

## 3.6 — ATUALIZAÇÃO DO SPAWNSYSTEM

O SpawnSystem existente usa nomes fixos de mapas para distribuir spawns. A Fase 3 precisa atualizá-lo para usar o `AtlasConfig`:

```lua
-- SpawnSystem.lua (versão Fase 3 — atualização)
-- Agora lê zonas de spawn do AtlasConfig em vez de hardcode

local AtlasConfig = require(ReplicatedStorage.Modules.Config.AtlasConfig)
local AISystem = require(script.Parent.AISystem)

local SpawnSystem = {}
local mobsAtivos = {}

function SpawnSystem.Init()
    -- Iterar todos os mapas e suas zonas de spawn
    for mapaId, mapaConfig in pairs(AtlasConfig.Mapas) do
        for _, zona in ipairs(mapaConfig.zonasDeSpawn) do
            for _, mobSpawn in ipairs(zona.mobs) do
                for i = 1, mobSpawn.quantidade do
                    -- Posição aleatória dentro do raio da zona
                    local offset = Vector3.new(
                        math.random(-zona.raio, zona.raio),
                        0,
                        math.random(-zona.raio, zona.raio)
                    )
                    local pos = zona.posicao + offset

                    local mob = AISystem.CreateMob(mobSpawn.id, pos)
                    if mob then
                        mob.mapa = mapaId
                        mob.zonaSpawn = zona.nome
                        table.insert(mobsAtivos, mob)
                    end
                end
            end
        end
    end
    -- BUG-03: # no dicionário retorna 0. Contamos via loop.
    local numMapas = 0
    for _ in pairs(AtlasConfig.Mapas) do numMapas = numMapas + 1 end
    print("[SpawnSystem] " .. #mobsAtivos .. " mobs spawned em " .. numMapas .. " mapas.")
end

function SpawnSystem.GetMobsAtivos()
    return mobsAtivos
end

function SpawnSystem.GetMobsPorMapa(mapaId)
    local mobs = {}
    for _, mob in ipairs(mobsAtivos) do
        if mob.mapa == mapaId then
            table.insert(mobs, mob)
        end
    end
    return mobs
end

-- ⚠️ REVISÃO 9: Respawn automático de mobs após morte
-- Quando um mob morre, ele não é removido da tabela — apenas marcado como "dead".
-- Após o cooldown de respawn, ele é recriado na mesma posição/zona.
-- Isso mantém o ecossistema vivo sem sobrecarregar o server com recriação constante.

local respawnTimers = {} -- { [mobId] = tick() }

function SpawnSystem.MarcarMorto(mob, playerKiller)
    mob.estado = "dead"
    mob.mortoEm = tick()

    -- Gerar drops (reutilizar lógica existente de AISystem.GerarDrops)
    -- local drops = AISystem.GerarDrops(mob)
    -- if playerKiller then
    --     AISystem.DistribuirDrops(playerKiller, drops)
    -- end

    -- Notificar clients que o mob morreu (para esconder modelo, parar IA)
    -- ReplicatedStorage.Remotes.Combat.MobDied:FireAllClients(mob.id)
end

function SpawnSystem.TentarRespawn(mob)
    if mob.estado ~= "dead" then return end

    local tempoPassado = tick() - (mob.mortoEm or 0)
    local cooldown = mob.respawnTime or 30 -- segundos (herdado do MobsConfig)

    if tempoPassado >= cooldown then
        -- Respawnar na posição original da zona
        mob.hp = mob.hpMax
        mob.estado = "idle"
        mob.alvo = nil
        mob.mortoEm = nil

        -- Notificar clients que o mob respawnou
        -- ReplicatedStorage.Remotes.Combat.MobRespawned:FireAllClients(mob.id, mob.posicao)
        print("[SpawnSystem] " .. mob.nome .. " (" .. mob.id .. ") respawnou.")
    end
end

-- Verificar respawns pendentes periodicamente (a cada 5 segundos)
task.spawn(function()
    while true do
        task.wait(5)
        for _, mob in ipairs(mobsAtivos) do
            SpawnSystem.TentarRespawn(mob)
        end
    end
end)

return SpawnSystem
```

---

## 3.7 — ATUALIZAÇÃO DO SERVERMAIN

O ServerMain precisa:
1. Detectar o mapa atual de cada jogador para enviar apenas mobs daquele mapa para a IA
2. Conectar portais de transição
3. Enviar dados do minimapa para o client

```lua
-- ServerMain.lua (trecho de atualização para Fase 3)

local MapaManager = require(script.Parent.Modules.MapaManager)
local AtlasConfig = require(ReplicatedStorage.Modules.Config.AtlasConfig)

-- Detectar mapa a cada frame para cada jogador e enviar dados do minimapa
RunService.Heartbeat:Connect(function(deltaTime)
    mobUpdateCounter = mobUpdateCounter + deltaTime
    if mobUpdateCounter >= 0.5 then
        mobUpdateCounter = 0

        -- Agrupar jogadores por mapa
        local jogadoresPorMapa = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local pos = player.Character.HumanoidRootPart.Position
                local mapa = MapaManager.DetectarMapa(player)
                if mapa then
                    -- Atualizar atributo se mudou
                    local atual = player:GetAttribute("MapaAtual")
                    if atual ~= mapa then
                        MapaManager.SetMapaAtual(player, mapa)
                    end

                    if not jogadoresPorMapa[mapa] then
                        jogadoresPorMapa[mapa] = {}
                    end
                    table.insert(jogadoresPorMapa[mapa], {
                        player = player,
                        posicao = pos,
                        -- ... stats para aggro
                    })
                end
            end
        end

        -- Atualizar IA apenas dos mobs do mapa onde há jogadores
        for _, mob in ipairs(SpawnSystem.GetMobsAtivos()) do
            local jogadores = jogadoresPorMapa[mob.mapa] or {}
            AISystem.UpdateMob(mob, 0.5, jogadores)
        end

        -- SUG-03: Enviar posições atualizadas para o minimapa usando FireClientUnreliable
        -- Throttling inteligente: só envia se o jogador moveu > 5 studs desde o último update
        local UpdateMinimapaEvent = ReplicatedStorage.Remotes.Mapa.UpdateMinimapa
        for mapaId, jogadores in pairs(jogadoresPorMapa) do
            local mobs = SpawnSystem.GetMobsPorMapa(mapaId)
            local mobData = {}
            for _, mob in ipairs(mobs) do
                if mob.estado ~= "dead" then
                    table.insert(mobData, {id = mob.id, posicao = mob.posicao})
                end
            end

            for _, entry in ipairs(jogadores) do
                local player = entry.player
                local lastPos = player:GetAttribute("LastMinimapPos")
                if not lastPos or (entry.posicao - lastPos).Magnitude > 5 then
                    player:SetAttribute("LastMinimapPos", entry.posicao)
                    -- Envio Unreliable para reduzir overhead de rede
                    UpdateMinimapaEvent:FireClientUnreliable(player, entry.posicao, mobData)
                end
            end
        end
    end
end)
```

---

## 3.8 — SEGURANÇA — VALIDAÇÃO SERVER-SIDE

⚠️ REVISÃO 10 — REGRA DE OURO:
Toda lógica de transição, validação de nível, teleport e respawn DEVE rodar no servidor.
O client nunca decide:
- Se o jogador pode passar por um portal (validação de nível é server-side)
- Para onde o jogador vai (o server calcula e aplica a posição)
- Se um mob morreu ou respawnou (o server controla o estado)
- Qual mapa o jogador está (o server detecta pela posição)

O client apenas:
- Exibe o resultado (minimapa, notificação de nível baixo, animação de portal)
- Envia inputs de movimento (que o Roblox já faz nativamente)

Esta regra se aplica a TODAS as fases do projeto. Se um novo desenvolvedor
(ou você mesmo no futuro) adicionar features, mantenha esta separação clara.

---

## 3.9 — REMOTES NECESSÁRIOS (Novos)

Adicionar em `ReplicatedStorage/Remotes/Mapa/`:

```
ReplicatedStorage/
    Remotes/
        Mapa/
            ChangeMap (RemoteEvent)       -- Server → Client: jogador mudou de mapa
            LevelTooLow (RemoteEvent)     -- Server → Client: nível insuficiente para portal
            UpdateMinimapa (RemoteEvent)  -- Server → Client: posições atualizadas para minimapa
```

---

## 3.10 — CHECKLIST DE IMPLEMENTAÇÃO

### Fase 3.1 — AtlasConfig e Estrutura
- [ ] Criar `AtlasConfig.lua` com configuração dos 6 mapas
- [ ] Criar `MapaManager.lua` com lógica de transição
- [ ] Adicionar RemoteEvents de Mapa (`ChangeMap`, `LevelTooLow`, `UpdateMinimapa`)
- [ ] Atualizar `SpawnSystem.lua` para usar `AtlasConfig`
- [ ] Atualizar `ServerMain.lua` para detectar mapa e agrupar jogadores

### Fase 3.2 — Minimapa
- [ ] Criar `MinimapaController.lua` no StarterPlayerScripts
- [ ] Criar UI do minimapa no StarterGui (Frame + indicadores)
- [ ] Implementar conversão de coordenadas mundo → minimapa
- [ ] Implementar atualização de posição do jogador no minimapa

### Fase 3.3 — Portais e Validação
- [ ] Criar script de portal (Part + Script com Touched)
- [ ] Implementar validação de nível nos portais
- [ ] Implementar feedback visual ao tentar passar sem nível
- [ ] Adicionar feedback visual nos portais (Partículas, cor, transparência)
- [ ] Criar zona de transição de ~10 studs entre mapas (corredor/ponte/cerca)
- [ ] Implementar spawnDeRespawn por mapa (zona segura após morte)

### Fase 3.4 — Testes
- [ ] Testar spawn correto de mobs por mapa
- [ ] Testar transição entre mapas (ida e volta)
- [ ] Testar validação de nível no portal do boss
- [ ] Testar minimapa em 2+ jogadores simultâneos
- [ ] Testar aggro de mobs por mapa (mobs do Mapa1_YbiráPuera não perseguem jogador no Mapa2_FlorestaMaeDaMata)
- [ ] Testar respawn automático de mobs (matar, aguardar cooldown, verificar reaparecimento)
- [ ] Testar respawn do jogador em zona segura (não dentro de zona de aggro)
- [ ] Testar feedback visual dos portais (partículas visíveis, cor correta)
- [ ] Testar throttling do minimapa (não floodar RemoteEvents)

---

## 3.11 — PROMPTS PARA IDE AGÊNTICA

Aqui estão os prompts prontos para você usar na IDE agêntica. Cada um gera um script completo.

### Prompt 1: AtlasConfig
```
Crie o script "AtlasConfig.lua" em ReplicatedStorage/Modules/Config/.
Use a estrutura de dados descrita no GDD Fase 3 do projeto ROBR.
Inclua a configuração completa dos 6 mapas: Mapa1_YbiráPuera, Mapa2_FlorestaMaeDaMata, Mapa3_TavyKatu, Mapa4_TupaMbara, Mapa5_TemploNasNuvens, Mapa6_YgaraMbya.
Cada mapa deve ter: nome, descricao, nivelRecomendado, centro, tamanho, chao, zonasDeSpawn (com mobs e quantidades), spawnDosJogadores, npcs, portais (com destino e nivelMinimo), ambiente.
Os mobs por zona são:
- Mapa1: MOB_001 (x5), MOB_015 (x3), MOB_002 (x4)
- Mapa2: MOB_003 (x3), MOB_011 (x2), MOB_013 (x2)
- Mapa3: MOB_004 (x3), MOB_012 (x2), MOB_016 (x2)
- Mapa4: MOB_005 (x2), MOB_008 (x2), MOB_014 (x2)
- Mapa5: MOB_006 (x2), MOB_009 (x2)
- Mapa6: MOB_007 (x1)
Os portais devem conectar: Mapa1→Mapa2 (nivel 8+), Mapa2→Mapa3 (nivel 13+), Mapa3→Mapa4 (nivel 18+), Mapa4→Mapa5 (nivel 22+), Mapa5→Mapa6 (nivel 25+).
Inclua funcoes: GetMapa, GetPortais, GetZonasDeSpawn, GetNPCs.
Cada mapa deve incluir obrigatoriamente o campo spawnDeRespawn (Vector3) e ambiente.musica (tabela com assetId, volume, loop).
Os portais devem ter visivel = true, transparencia, cor, e efeitoParticula.
```

### Prompt 2: MapaManager
```
Crie o script "MapaManager.lua" em ServerScriptService/Modules/.
Este script gerencia transicoes entre mapas do projeto ROBR.
Dependencias: DataController (script.Parent.DataController), AtlasConfig (ReplicatedStorage.Modules.Config.AtlasConfig).
RemoteEvents necessarios em ReplicatedStorage/Remotes/Mapa/: ChangeMap (RemoteEvent), LevelTooLow (RemoteEvent).
Funcoes:
- SetMapaAtual(player, mapaId): atualiza atributo "MapaAtual" do jogador e dispara ChangeMap
- DetectarMapa(player): retorna o mapa atual baseado na posicao do jogador (verificar centro e tamanho de cada mapa no AtlasConfig)
- ValidarPassagem(player, portalConfig): verifica nivel minimo do jogador
- TeleportarParaPortal(player, destinoMapa, destinoPosicao): move o jogador e atualiza mapa
- OnPortalTouched(portal, player): handler de colisao com portal
DetectarMapa deve ordenar mapas por proximidade antes de testar (evita falsos positivos em bordas).
```

### Prompt 3: SpawnSystem atualizado
```
Atualize o script "SpawnSystem.lua" em ServerScriptService/Modules/.
O novo SpawnSystem deve ler as zonas de spawn do AtlasConfig em vez de usar hardcode.
Dependencias: AtlasConfig (ReplicatedStorage.Modules.Config.AtlasConfig), AISystem (script.Parent.AISystem).
Funcoes:
- Init(): itera todos os mapas do AtlasConfig, suas zonasDeSpawn, e cria mobs nas posicoes aleatorias dentro do raio de cada zona
- GetMobsAtivos(): retorna todos os mobs ativos
- GetMobsPorMapa(mapaId): retorna apenas mobs de um mapa especifico
Cada mob criado deve ter o campo mob.mapa definido com o ID do mapa.
Incluir funcoes de respawn automatico: MarcarMorto(mob, playerKiller) e TentarRespawn(mob).
O respawn deve verificar cooldown (mob.respawnTime ou 30s padrao) e recriar o mob na posicao original.
```

### Prompt 4: MinimapaController
```
Crie o script "MinimapaController.lua" em StarterPlayerScripts/.
Este script gerencia o minimapa do jogador no client.
Dependencias: ReplicatedStorage.Remotes.Mapa.ChangeMap (RemoteEvent).
Crie a UI do minimapa dinamicamente:
- ScreenGui "MinimapaGui" no PlayerGui
- Frame "MinimapaFrame" (140x140, canto superior direito, cantos arredondados, fundo escuro) -- SUG-02: Padronizado para 140x140
- Frame "JogadorDot" (8x8, azul, centro do minimapa, representa o jogador)
- UICorner com CornerRadius UDim.new(0.5, 0) no MinimapFrame para fazer cIRCULO (nao quadrado)
- BackgroundColor3 = Color3.fromRGB(20, 50, 20) para o fundo esverdeado
- Label "N" (norte) no topo do circulo
- QuestTracker frame ABAIXO do minimapa (nao dentro), conforme mockup
- Usar throttling: so enviar atualizacao se a posicao mudou >5 studs desde o ultimo envio
- Usar FireClientUnreliable para atualizacoes do minimapa
Funcoes:
- Init(): cria a UI do minimapa
- MundoParaMinimapa(worldPos, mapaConfig): converte posicao do mundo para coordenadas 0-1 do minimapa
- OnChangeMap(mapaId): atualiza display quando jogador muda de mapa
O minimapa deve seguir o jogador (atualizar posicao a cada frame).
Usar throttling: so enviar atualizacao se a posicao mudou >5 studs desde o ultimo envio.
Usar FireClientUnreliable para atualizacoes do minimapa (perda de frames nao e critica).
```

### Prompt 5: Portal Script
```
Crie o script "Portal.lua" para ser anexado a Parts de portal no Workspace.
Este script fica dentro de cada Part de portal e detecta quando um jogador toca o portal.
Dependencias: MapaManager (ServerScriptService/Modules/MapaManager).
O Part deve ter um atributo "PortalConfig" (StringValue ou tabela via ModuleScript) com:
- destino (string): ID do mapa de destino
- destinoPosicao (Vector3): posicao para onde o jogador vai
- nivelMinimo (number): nivel minimo para passar
Quando Touched, o script:
1. Identifica o jogador
2. Chama MapaManager.ValidarPassagem(player, config)
3. Se valido: chama MapaManager.TeleportarParaPortal(player, destino, destinoPosicao)
4. Se invalido: dispara LevelTooLow event com mensagem
O portal deve ser visivel (Part com transparencia 0.7, cor verde-dourada) com ParticleEmitter anexado.
O ParticleEmitter simula nevoa/luz pulsante para indicar area interativa ao jogador.
```

---

*Última atualização: 2026-06-11*
*Autor: Agente OWL (gerado para Henrique Lima)*
*Baseado em: GDD Fase 0.B (Lore), Fase 1 (Fundação Técnica), projeto_status.md*
