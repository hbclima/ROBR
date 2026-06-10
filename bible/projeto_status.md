# PROJETO ROBR — Status e Contexto

> Arquivo de recuperação de contexto. Leia no início de cada sessão.
> Última atualização: 2026-06-12 (atualização: scripts de placeholder de mobs)

---

## 1. VISÃO GERAL

**O que é:** MMORPG no Roblox inspirado em Ragnarok Online (RO), com lore baseada no folclore brasileiro.
**Plataforma:** Roblox Studio + Luau (server-authoritative, multiplayer-first).
**Tema:** Biomas e entidades do folclore brasileiro (Tupã-Y como base cultural, Angá como força de corrupção).
**Público:** Inicialmente a dupla desenvolvedor (pai e filho); potencial expansão para jogadores Roblox.
**Diferencial:** Mecânicas core de RO (atributos, classes, grind, drops, party) + identidade cultural brasileira.

---

## 2. EQUIPE

- **Henrique Lima (pai):** Desenvolvedor principal, tomada de decisão estratégica.
- **Filho:** Co-desenvolvedor, aprendizado prático de game dev.
- **Agente OWL (IA):** Suporte intelectual, operacional e estratégico — pesquisa, documentação, geração de fichas, revisão de consistência, automação.

---

## 3. METODOLOGIA

**Cascata (Waterfall)** — fases sequenciais com critério de saída claro. Não se avança sem validação.

### Fases do plano MVP:

| Fase | Nome | Status |
|---|---|---|
| 0.1 | Visão do Jogo | ✅ Concluído |
| 0.2 | Definição de Classes | ✅ Concluído |
| 0.3 | Sistema de Atributos e Fórmulas | ✅ Concluído |
| 0.4 | Árvore de Skills | ✅ Concluído |
| 0.5 | Catálogo de Mobs | ✅ Concluído |
| 0.6 | Sistema de Progressão | ✅ Concluído |
| 0.7 | Inventário e Equipamentos | ✅ Concluído |
| 0.8 | Economia Básica | ✅ Concluído |
| 0.B | Lore e Identidade | ✅ Concluído |
| 1 | Fundação Técnica (core systems) | ✅ Concluído |
| 2 | Gameplay (combate, IA, skills) | ✅ Concluído |
| 3 | Mundo (mapas, navegação) | ✅ Concluído |
| 4 | Economia (drops, NPC, trade) | Pendente |
| 5 | Polimento e MVP | Pendente |

### Princípios:
- Multiplayer sempre: testar com 2+ jogadores antes de concluir.
- Dados separados de lógica: ModuleScripts independentes.
- Server-authoritative: Client nunca decide resultados.
- Lore/asset em paralelo, sem bloquear fundação técnica.

---

## 4. ESTRUTURA DE ARQUIVOS

```
onedrive_hermes:ROBR/
├── bible/
│   └── projeto_status.md
├── Bible/
│   └── mechanics.md              # APROVADO
├── Documentação/
│   ├── GDD_Fase01_Visão_do_Jogo.md
│   ├── GDD_Fase02_Classes_MVP_Template.md (Classes/)
│   ├── GDD_Fase03_Atributos_Formulas.md
│   ├── GDD_Fase04_Arvore_Skills.md
│   ├── GDD_Fase06_Sistema_Progressao.md
│   ├── GDD_Fase07_Inventario_Equipamentos.md
│   ├── GDD_Fase0B_Lore_Identidade.md
│   ├── Classes/
│   │   └── GDD_Fase02_Classes_MVP_Template.md
│   ├── Mobs/
│   │   ├── 0_TEMPLATE_MOB.md
│   │   ├── MOB_001 a MOB_016 (16 fichas)
│   │   └── (MOB_010 em HOLD)
│   ├── Pesquisa/
│   │   ├── boto-cor-de-rosa.md
│   │   ├── corpo_seco.md
│   │   ├── mula_sem_cabeca.md
│   │   ├── pesquisa_onca_pintada.md
│   │   ├── pesquisa_capivara.md
│   │   └── pesquisa_jacare_acu.md
│   └── Arte conceitual/
├── Tasks/
│   └── prompts_agente.md
├── RO_Clone_Roblox_Plano_MVP.md
├── prompts_agente.md
└── bibliografia_folclore_tupi_guarani.md
```

---

## 5. REGRAS DE NEGÓCIO (validadas pelo Henrique 2026-06-07)

- **Boss MVP:** apenas 1 boss ativo (MOB_007 Boiúna). MOB_010 em HOLD para versão final.
- **Cartas:** todas com drop rate fixo de 0.5% no MVP.
- **Elites:** HP no limite máximo do baseline (não acima).
- **Aggro range:** mínimo 12 studs.
- **Mobs neutros:** animais dos biomas brasileiros sem elemento mágico (3 criados).
- **Moeda:** Wira'i (inspirada em *wira* = "valor" em tupi).
- **Versão final:** 2–5 tipos de mobs por mapa.

---

## 6. STATUS ATUAL

### Concluído:
- [x] Plano MVP, GDD Fase 01/02/03/04/06/07/08
- [x] Bible/mechanics.md (APROVADO)
- [x] 16 fichas de mob criadas (13 folclóricas + 3 neutros)
- [x] 16 fichas migradas para formato tabela e aprovadas
- [x] 6 pesquisas de folclore
- [x] Revisão de consistência: 15/15 mobs MVP aprovados
- [x] 3 classes definidas e validadas (Tembira, Karaí, Payé)
- [x] Fase 0.B — Lore e Identidade (bestário, nomenclatura, guia visual)
- [x] Moeda atualizada: Zeny → Guarani → Wira'i (todos os documentos)
- [x] **Fase 1 — Fundação Técnica** (implementação Roblox Studio)
  - Estrutura de pastas completa (ReplicatedStorage, ServerScriptService, StarterPlayerScripts, Workspace)
  - 11 ModuleScripts criados (MobsConfig, ClassesConfig, Formulas, DamageCalculator, AISystem, SpawnSystem, CombatManager, DataController, PartyManager + skeletons)
  - 11 RemoteEvents + 1 RemoteFunction criados
  - ServerMain, ClientMain, Party implementados
  - DataController com save/load via DataStore
  - ShopManager, TradeManager, MobManager, InventoryManager (skeletons)
- [x] **Fase 2 — Gameplay** (combate funcional, IA de mobs, skills, HUD)
  - IA de Mobs (`AISystem`): Patrulha, Aggro, Fuga (Flee) de mobs passivos, e Retorno à base (Leashing/Tethering) com regeneração de HP e imunidade.
  - Saci Sombrio (`MOB_006`): Modelo procedimental físico com Gorro Vermelho, comportamento de frenesi a <30% HP (+50% speed e fumaça roxa), e habilidades `Sumiço Corrompido` (invisibilidade + imunidade + dano verdadeiro atrás do alvo) e `Redemoinho Sombrio` (partículas de redemoinho + puxar alvos + dano contínuo).
  - Combate Funcional (`CombatManager`): Sincronização de HP lógico e físico, validação de alcance de combate (15 studs), bloqueio de dano para mobs imunes.
  - Feedback Visual (`CombatClient`): Números de dano flutuantes coloridos (amarelo para crítico, vermelho para dano sofrido, branco para causado, cinza "MISS" para esquivas) e partículas locais de impacto.
- [x] **Fase 3 — Mundo** (mapas, navegação, portais, minimapa, BGM) — 2026-06-12
  - **Sincronização dos Mapas (Workspace):** Diretórios renomeados para tupi (YbiráPuera, TavyKatu, TupaMbara, YgaraMbya).
  - **Infraestrutura de Comunicação (Remotes):** 3 RemoteEvents em ReplicatedStorage.Remotes.Mapa (ChangeMap, LevelTooLow, UpdateMinimapa).
  - **Configuração Centralizada:** AtlasConfig.lua com specs completas dos 6 mapas (limites, baseplates, spawns, NPCs, portais, atmosfera).
  - **Lógica do Servidor e Portais:** MapaManager.lua com detecção geométrica de mapa por jogador, debounce server-side (3s), validação autoritativa de nível (ex: nível 25 para Boss Gate no Mapa 6). PortalSetup instancia dinamicamente 10 portais com cores, ParticleEmitter e PortalHandler.
  - **Otimização de Mobs e Rede:** SpawnSystem.lua refatorado para ler zonas do AtlasConfig e espalhar 37 mobs. ServerMain otimiza IA (apenas mapas com jogadores ativos) e reduz tráfego (thirling >5 studs via FireClientUnreliable).
  - **Minimapa e Efeitos Visuais/BGM (Client):** MinimapaController.lua — UI circular 140x140px, pontos vermelhos dinâmicos de mobs vivos, transição atmosférica suave com Tweening de névoa, atmosfera, iluminação e BGM.
  - **Construção Procedural do Mundo:** Chão (Baseplates) com materiais por bioma, Dummy NPCs com BillboardGui, discos de demarcação de spawn, StreamingEnabled global.
  - **Scripts de Placeholder de Mobs:** MobPlaceholderFactory.lua — gera 15 modelos 3D placeholder com Parts coloridos por raridade, Humanoid funcional, BillboardGui e Atributos. AISystem.lua — compatível com os placeholders (patrulha, aggro, leashing, morte).

### Em andamento:
- (nenhum)

---

## 7. MOBS DOCUMENTADOS — 16 total

### MVP Ativo (15 mobs):

| ID | Nome | Nível | HP | Elem | Raridade | Mapa |
|---|---|---|---|---|---|---|
| MOB_001 | Sapo Cururu | 1–6 | 120 | água | comum | Ybirá-Puera |
| MOB_002 | Cobra-d'Água | 5–10 | 210 | água | comum | Ybirá-Puera / Mãe-da-Mata |
| MOB_015 | Capivara | 1–5 | 80 | neutro | comum | Ybirá-Puera |
| MOB_003 | Mãe-da-Mata | 10–15 | 350 | terra | incomum | Floresta de Mãe-da-Mata |
| MOB_011 | Boto Cor-de-Rosa | 12–15 | 380 | água | raro | Floresta de Mãe-da-Mata |
| MOB_013 | Corpo Seco | 10–14 | 320 | sombra | raro | Floresta de Mãe-da-Mata |
| MOB_004 | Boitatá | 15–20 | 520 | fogo | incomum | Tavy-Katu |
| MOB_012 | Mula Sem Cabeça | 18–22 | 600 | fogo | elite | Tavy-Katu |
| MOB_016 | Jacaré-Açu | 16–20 | 600 | neutro | raro | Tavy-Katu |
| MOB_005 | Curupira | 20–25 | 800 | terra | raro | Tupã-Mbara |
| MOB_008 | Anhangá | 25–30 | 700 | sombra | raro | Tupã-Mbara |
| MOB_014 | Onça-Pintada | 20–25 | 900 | neutro | raro | Tupã-Mbara |
| MOB_006 | Saci Sombrio | 25–30 | 950 | vento corrompido | elite | Templo nas Nuvens |
| MOB_009 | Jurupari | 25–30 | 900 | vento | elite | Templo nas Nuvens |
| MOB_007 | Boiúna | 30 | 4200 | água | chefe | Ygara-Mbya |

### Hold:
| MOB_010 | Tupã-Jaguaçu | 30 | 3500 | sagrado | chefe | hold |

---

## 8. CLASSES

| Classe | Papel | Principal | Secundário | Skills |
|---|---|---|---|---|
| Tembira (Guerreiro) | Tank/Utility | VIT | STR | 6 skills + upgrades |
| Karaí (Mago) | DPS/Utility | INT | DEX | 6 skills + upgrades |
| Payé (Clérigo) | Support/Utility | INT | VIT | 6 skills + upgrades |

**Sistema de skill points:** 1 ponto por nível (30 ao nível 30). Custo para upar skill existente: 1 ponto (+10% efeito). Custo para desbloquear skill nova: 3 pontos.

---

## 9. PRÓXIMOS PASSOS

1. ~~Fase 0.8 — Economia Básica~~ — ✅ Concluído
2. ~~Fase 1 — Fundação Técnica~~ — ✅ Concluído (Roblox Studio)
3. ~~Fase 2 — Gameplay~~ — ✅ Concluído (IA, Combate, VFX de dano)
4. ~~Fase 3 — Mundo~~ — ✅ Concluído (mapas, portais, minimapa, BGM, 2026-06-12)
5. **Assets de Mobs (placeholders)** — PRÓXIMO: executar MobPlaceholderFactory.CreateAll() no Studio
6. **Fase 4 — Economia** — NPC shop funcional, trade, drops, loja de Wira'i
7. **Fase 5 — Polimento e MVP** — balanceamento, bug fixes, playtest final

---

## CONVENÇÕES

- **Caminho:** `onedrive_hermes:ROBR/` (nunca `/mmorpg-project/`)
- **Leitura:** `rclone cat` | **Escrita texto:** `rclone rcat`
- **Elementos:** fogo, água, terra, vento, sombra, sagrado, neutro
- **Raridades:** comum, incomum, raro, elite, chefe
- **Status:** rascunho, revisão, aprovado, hold
- **Cartas MVP:** 0.5% | **Boss MVP:** MOB_007 | **Moeda:** Wira'i
