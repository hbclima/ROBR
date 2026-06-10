# ROBR — Análise de Gap: Documentado vs. Implementado

> Data: 2026-06-12
> Propósito: Mapear o que existe de fato no Roblox Studio vs. o que está apenas documentado/plano.

---

## 1. INFRAESTRUTURA (Scripts/ModuleScripts) — STATUS

### ✅ IMPLEMENTADOS (existem no Studio e no GitHub)

| Arquivo | Local | Status |
|---------|-------|--------|
| ServerMain.lua | ServerScriptService | ✅ Loop Heartbeat, IA por mapa, minimapa throttling |
| DataController | ServerScriptService | ✅ Save/load via DataStore |
| CombatManager | ServerScriptService | ✅ Validação de alcance, dano server-side |
| PartyManager | ServerScriptService | ✅ Criação de grupos, XP compartilhado |
| ShopManager | ServerScriptService | ⚠️ Skeleton (validação existe, UI não) |
| TradeManager | ServerScriptService | ⚠️ Skeleton (ciclo de vida básico) |
| MobManager | ServerScriptService | ⚠️ Skeleton (registro de vida/propriedades) |
| InventoryManager | ServerScriptService | ⚠️ Skeleton (equipar/remover) |
| PortalSetup | ServerScriptService | ✅ Instancia 10 portais dinamicamente |
| PortalHandlerTemplate | ServerScriptService | ✅ Desabilitado, clonado para portais |
| AISystem | ServerScriptService/Modules | ✅ Patrulha, Aggro, Flee, Leashing |
| SpawnSystem | ServerScriptService/Modules | ✅ Lê AtlasConfig, 37 mobs, respawn 30s |
| MapaManager | ServerScriptService/Modules | ✅ Detecção geométrica, debounce 3s, validação nível |
| Party | ServerScriptService/Modules | ✅ Classe auxiliar de grupos |
| MobsConfig | ReplicatedStorage/Modules/Config | ✅ 16 mobs com atributos |
| ClassesConfig | ReplicatedStorage/Modules/Config | ✅ 3 classes com atributos iniciais |
| SkillsConfig | ReplicatedStorage/Modules/Config | ✅ Custos, alcances, fórmulas |
| DropsConfig | ReplicatedStorage/Modules/Config | ✅ Tabela de loot, cartas 0.5% |
| AtlasConfig | ReplicatedStorage/Modules/Config | ✅ 6 mapas completos |
| ItensConfig | ReplicatedStorage/Modules/Config | ✅ Consumíveis e equipamentos |
| Formulas | ReplicatedStorage/Modules/Shared | ✅ Evasão, Crítico, Velocidade Ataque |
| DamageCalculator | ReplicatedStorage/Modules/Shared | ✅ Dano físico/mágico + elementos |
| Utils | ReplicatedStorage/Modules/Shared | ✅ Funções auxiliares |
| Constants | ReplicatedStorage/Modules/Shared | ✅ Limites de nível, taxas |
| ClientMain | StarterPlayerScripts | ✅ Input F/E/Tab, carregamento |
| InputHandler | StarterPlayerScripts | ✅ Redirecionamento de teclas |
| CombatClient | StarterPlayerScripts | ✅ Números flutuantes, partículas de hit |
| UIController | StarterPlayerScripts | ⚠️ Skeleton (visibilidade de painéis) |
| ShopClient | StarterPlayerScripts | ⚠️ Skeleton (UI de loja) |
| TradeClient | StarterPlayerScripts | ⚠️ Skeleton (UI de trade) |
| MinimapaController | StarterPlayerScripts | ✅ UI circular 140x140, pontos vermelhos, tweens BGM |

### 📡 REMOTES — STATUS

| Remote | Local | Status |
|--------|-------|--------|
| RequestData | ReplicatedStorage/Remotes/Data | ✅ RemoteFunction |
| UpdateStats | ReplicatedStorage/Remotes/Data | ✅ |
| LevelUp | ReplicatedStorage/Remotes/Data | ✅ |
| Attack | ReplicatedStorage/Remotes/Combat | ✅ |
| UseSkill | ReplicatedStorage/Remotes/Combat | ✅ |
| DamageResult | ReplicatedStorage/Remotes/Combat | ✅ |
| OpenShop | ReplicatedStorage/Remotes/Shop | ✅ |
| BuyItem | ReplicatedStorage/Remotes/Shop | ✅ |
| SellItem | ReplicatedStorage/Remotes/Shop | ✅ |
| RequestTrade | ReplicatedStorage/Remotes/Trade | ✅ |
| AcceptTrade | ReplicatedStorage/Remotes/Trade | ✅ |
| CancelTrade | ReplicatedStorage/Remotes/Trade | ✅ |
| ChangeMap | ReplicatedStorage/Remotes/Mapa | ✅ |
| LevelTooLow | ReplicatedStorage/Remotes/Mapa | ✅ |
| UpdateMinimapa | ReplicatedStorage/Remotes/Mapa | ✅ |

**Total: 14 RemoteEvents + 1 RemoteFunction — todos implementados**

---

## 2. ASSETS VISUAIS — STATUS

### ❌ NÃO IMPLEMENTADOS (nenhum existe no Studio)

#### 2.1 Modelos 3D de Mobs (15 mobs MVP + 1 hold)

| Mob | Mapa | Dificuldade | Status |
|-----|------|-------------|--------|
| Sapo Cururu | Ybirá-Puera | 🟢 | ❌ Não existe |
| Capivara | Ybirá-Puera | 🟢 | ❌ Não existe |
| Cobra-d'Água | Ybirá-Puera | 🟡 | ❌ Não existe |
| Mãe-da-Mata | Floresta Mãe-da-Mata | 🟡 | ❌ Não existe |
| Boto Cor-de-Rosa | Floresta Mãe-da-Mata | 🟡 | ❌ Não existe |
| Corpo Seco | Floresta Mãe-da-Mata | 🟡 | ❌ Não existe |
| Boitatá | Tavy-Katu | 🟡 | ❌ Não existe |
| Mula Sem Cabeça | Tavy-Katu | 🔴 | ❌ Não existe |
| Jacaré-Açu | Tavy-Katu | 🟡 | ❌ Não existe |
| Curupira | Tupã-Mbara | 🟡 | ❌ Não existe |
| Anhangá | Tupã-Mbara | 🔴 | ❌ Não existe |
| Onça-Pintada | Tupã-Mbara | 🟡 | 🟡 | ❌ Não existe |
| Saci Sombrio | Templo Nuvens | 🟡 | ⚠️ Modelo procedimental existe (Fase 2) |
| Jurupari | Templo Nuvens | 🔴 | ❌ Não existe |
| Boiúna (Boss) | Ygara-Mbya | 🔴 | ❌ Não existe |
| Tupã-Jaguaçu | hold | ⚫ | ❌ Não existe (hold) |

**Total: 0/15 mobs com modelo 3D. Apenas Saci Sombrio tem modelo procedimental.**

#### 2.2 Modelos 3D de Personagens (Classes)

| Classe | Status |
|--------|--------|
| Tembira (Guerreiro) | ❌ Não existe |
| Karaí (Mago) | ❌ Não existe |
| Payé (Clérigo) | ❌ Não existe |

**Nota: Roblox usa avatar padrão do jogador. Modelos customizados são opcionais para MVP.**

#### 2.3 UI / HUD

| Asset | Status |
|-------|--------|
| Barra de HP | ❌ Não existe |
| Barra de SP | ❌ Não existe |
| Barra de XP | ❌ Não existe |
| Hotbar de Skills | ❌ Não existe |
| Inventário (grid) | ❌ Não existe |
| Tooltip de item | ❌ Não existe |
| Tela de seleção de classe | ❌ Não existe |
| HUD de Party | ❌ Não existe |
| Chat box | ❌ Não existe (usa chat padrão Roblox) |
| Tela de Level Up | ❌ Não existe |
| Tela de Trade | ❌ Não existe |
| Tela de morte/respawn | ❌ Não existe |
| Minimapa | ⚠️ Controller existe, UI não criada |
| NPC Shop UI | ❌ Não existe |
| Distribuição de Stats | ❌ Não existe |
| Tela de Game Over / Loading | ❌ Não existe |

**Total: 0/16 assets de UI implementados. Apenas o controller do minimapa existe.**

#### 2.4 Ícones 2D

| Categoria | Status |
|-----------|--------|
| Ícones de Skills (18 total) | ❌ Não existem |
| Ícones de Itens (armas/armaduras) | ❌ Não existem |
| Ícones de Consumíveis | ❌ Não existem |
| Ícones de Drops/Materiais | ❌ Não existem |
| Ícones de Classes (3) | ❌ Não existem |
| Ícones de Elementos (7) | ❌ Não existem |
| Ícones de Raridade (5) | ❌ Não existe |
| Ícone de Moeda (Wira'i) | ❌ Não existe |
| Ícones de Status (buff/debuff) | ❌ Não existem |

**Total: ~60 ícones — 0 existem**

#### 2.5 VFX / Partículas

| Efeito | Status |
|--------|--------|
| Hit effect | ⚠️ CombatClient renderiza números, partículas básicas |
| Número de dano | ✅ Implementado no CombatClient |
| Efeito de cura | ❌ Não existe |
| Efeito de level up | ❌ Não existe |
| Efeito de morte (mob) | ❌ Não existe |
| Efeito de drop (brilho) | ❌ Não existe |
| VFX de skills (fogo/água/terra/vento/sombra/sagrado) | ❌ Não existem |
| Efeito de portal | ⚠️ ParticleEmitter nos portais existe |
| Efeito de buff/debuff | ❌ Não existe |
| Efeito de fogo contínuo (Boitatá/Mula) | ❌ Não existe |
| Efeito de água (Boiúna) | ❌ Não existe |

**Total: ~2/16 VFX implementados**

#### 2.6 Animações

| Animação | Status |
|----------|--------|
| Idle (personagem) | ❌ Não existe (usa padrão Roblox) |
| Walk (personagem) | ❌ Não existe (usa padrão Roblox) |
| Run (personagem) | ❌ Não existe (usa padrão Roblox) |
| Attack (personagem) | ❌ Não existe |
| Hit (personagem) | ❌ Não existe |
| Death (personagem) | ❌ Não existe |
| Cast (personagem) | ❌ Não existe |
| Idle/Walk/Attack/Death (mobs) | ❌ Não existem |
| Animações de boss | ❌ Não existem |

**Total: 0/12+ animações customizadas. Roblox usa animações padrão.**

#### 2.7 Áudio / Som

| Som | Status |
|-----|--------|
| Hit (físico/mágico) | ❌ Não existe |
| Level up | ❌ Não existe |
| Morte (jogador/mob) | ❌ Não existe |
| Drop/coleta | ❌ Não existe |
| Compra/venda | ❌ Não existe |
| Skills (fogo/água/cura) | ❌ Não existem |
| Portal | ❌ Não existe |
| Hit crítico | ❌ Não existe |
| Miss/erro | ❌ Não existe |
| BGM (5 mapas + boss + menu) | ❌ Não existem |
| UI (clique/notificação/erro) | ❌ Não existem |

**Total: 0/22 sons implementados**

#### 2.8 Texturas e Materiais

| Textura | Status |
|---------|--------|
| Grama/terra/água/pedra/madeira | ⚠️ Usa materiais nativos do Roblox |
| Escama (Boiúna/cobra) | ❌ Não existe |
| Pele (mobs humanoides) | ❌ Não existe |
| Metal (armas/armaduras) | ⚠️ Usa material nativo |
| Tecido (roupas/mantos) | ❌ Não existe |
| Fogo/sombra | ⚠️ Usa efeitos nativos |

**Total: materiais nativos do Roblox são usados. Nenhuma textura customizada.**

#### 2.9 Logo e Identidade Visual

| Asset | Status |
|-------|--------|
| Logo do jogo | ❌ Não existe |
| Ícone do jogo (512x512) | ❌ Não existe |
| Thumbnail | ❌ Não existe |
| Banner | ❌ Não existe |

**Total: 0/4 assets de identidade**

---

## 3. MAPAS / AMBIENTE — STATUS

| Mapa | Chao | NPCs | Spawns | Zones | Portais | Atmosfera |
|------|------|------|--------|-------|---------|-----------|
| Ybirá-Puera | ✅ Baseplate | ✅ Dummy NPCs | ✅ | ✅ | ✅ | ✅ Config |
| Floresta Mãe-da-Mata | ✅ Baseplate | ✅ Dummy NPCs | ✅ | ✅ | ✅ | ✅ Config |
| Tavy-Katu | ✅ Baseplate | ✅ Dummy NPCs | ✅ | ✅ | ✅ | ✅ Config |
| Tupã-Mbara | ✅ Baseplate | ✅ Dummy NPCs | ✅ | ✅ | ✅ | ✅ Config |
| Templo nas Nuvens | ✅ Baseplate | ✅ Dummy NPCs | ✅ | ✅ | ✅ | ✅ Config |
| Ygara-Mbya | ✅ Baseplate | ✅ Dummy NPCs | ✅ | ✅ | ✅ | ✅ Config |

**Infraestrutura de mapas: ✅ Completa (baseplates, zones, spawns, portais, NPCs dummy)**

### ❌ PENDENTE nos mapas:
- Vegetação (árvores, arbustos, flores) — não existe
- Rochas e formações — não existe
- Estruturas (ruínas, pontes, altares) — não existe
- Água/rios/cachoeiras — não existe (só baseplate)
- Efeitos atmosféricos (névoa, partículas) — configurados no AtlasConfig mas não aplicados fisicamente
- BGM — configurado mas sem arquivos de audio

---

## 4. RESUMO DE GAPS

| Categoria | Documentado | Implementado | Pendente |
|-----------|-------------|--------------|----------|
| Scripts/ModuleScripts | 30 | 30 | 0 |
| Remotes | 15 | 15 | 0 |
| Modelos 3D Mobs | 16 | 1 (Saci) | 15 |
| Modelos 3D Personagens | 3 | 0 | 3 |
| UI/HUD | 16 | 0 | 16 |
| Ícones 2D | ~60 | 0 | ~60 |
| VFX/Partículas | 16 | 2 | 14 |
| Animações | ~12 | 0 | ~12 |
| Áudio/Som | ~22 | 0 | ~22 |
| Texturas | 11 | 0 (nativas) | 11 |
| Logo/Identidade | 4 | 0 | 4 |
| Mapas (estrutura) | 6 | 6 | 0 |
| Mapa (detalhes ambiente) | ~30 | 0 | ~30 |
| **TOTAL** | **~241** | **~54** | **~187** |

---

## 5. PRIORIDADE DE IMPLEMENTAÇÃO

### Prioridade 1 — Crítico (bloqueia gameplay)
1. **Modelos placeholder de mobs** — 15 mobs com Parts coloridos (1-2 dias)
2. **UI básica** — HP, SP, XP, hotbar de skills (2-3 dias)
3. **Animações básicas** — idle/walk/attack para mobs (1-2 dias)

### Prioridade 2 — Alta (experiência jogável)
4. **Modelos finais dos mobs do Mapa 1** — Sapo, Capivara, Cobra (2-3 dias)
5. **VFX de skills** — fogo, água, terra, vento, sombra, sagrado (2-3 dias)
6. **Sons básicos** — hit, level up, morte, drop (1 dia — biblioteca gratuita)
7. **Ícones de skills** — 18 ícones (1-2 dias)

### Prioridade 3 — Média (polimento)
8. **Modelos finais dos mobs restantes** — 12 mobs (5-7 dias)
9. **Detalhes dos mapas** — vegetação, rochas, água (3-5 dias)
10. **BGM** — 6 músicas ambiente (1-2 dias — royalty-free ou IA)
11. **UI completa** — inventário, shop, trade, party (3-4 dias)

### Prioridade 4 — Baixa (pós-MVP)
12. **Animações de boss** — Boiúna (2-3 dias)
13. **Texturas customizadas** — escamas, pele, tecido (2-3 dias)
14. **Logo e identidade visual** (1 dia)
15. **Modelos de personagem customizados** (3-5 dias)
