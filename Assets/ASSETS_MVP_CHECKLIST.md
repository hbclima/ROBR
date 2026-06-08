# ROBR — Lista de Assets do MVP

> **Última atualização:** 2026-06-11
> **Escopo:** Todos os assets visuais, sonoros e de interface necessários para o MVP.
> **Ordem:** Do mais simples/trabalhoso ao mais complexo/difícil.
> **Referência:** projeto_status.md, mechanics.md, RO_Clone_Roblox_Plano_MVP.md

---

## Legenda de Dificuldade

| Nível | Significado |
|-------|-------------|
| 🟢 Fácil | Primitives, UI elements, sons curtos — pode ser feito em minutos/horas |
| 🟡 Médio | Modelagem básica, texturas simples, animações rudimentares — horas/dias |
| 🔴 Difícil | Modelagem detalhada, rigging, animações complexas, integração — dias/semanas |
| ⚫ Muito Difícil | assets que exigem skill artístico avançado ou múltiplas dependências |

---

## 1. UI / HUD (Interface do Jogador)

> **Dificuldade base:** 🟢 Fácil → 🟡 Médio
> **Fase de uso:** Fase 2 (Gameplay) em diante

| # | Asset | Descrição | Dificuldade | Dependências |
|---|-------|-----------|-------------|--------------|
| 1.1 | Barra de HP | Barra horizontal vermelha/verde com texto "HP: X/Y" | 🟢 | Nenhuma |
| 1.2 | Barra de SP | Barra horizontal azul com texto "SP: X/Y" | 🟢 | Nenhuma |
| 1.3 | Barra de XP | Barra horizontal amarela abaixo de HP/SP | 🟢 | Nenhuma |
| 1.4 | Hotbar de Skills | 6-8 slots com ícone + cooldown overlay + tecla atalho | 🟡 | Ícones de skills |
| 1.5 | Inventário (grid) | Janela com slots de item, peso total, botões equipar/usar | 🟡 | Ícones de itens |
| 1.6 | Tooltip de item | Popup com nome, stats, descrição do item ao passar mouse | 🟢 | Nenhuma |
| 1.7 | Tela de seleção de classe | 3 cards com nome, ícone, descrição curta de cada classe | 🟡 | Ícones/arte das 3 classes |
| 1.8 | HUD de Party | Barras de HP/SP dos membros da party (até 4) | 🟡 | Nenhuma |
| 1.9 | Chat box | Caixa de texto com histórico, input, separação por canais | 🟢 | Nenhuma |
| 1.10 | Tela de Level Up | Animação/texto de notificação de level up | 🟢 | Nenhuma |
| 1.11 | Tela de Trade | Janela com slots de ambos os jogadores, botões aceitar/recusar | 🟡 | Ícones de itens |
| 1.12 | Tela de morte/respawn | Overlay escuro com mensagem "Você morreu" e timer | 🟢 | Nenhuma |
| 1.13 | Minimapa | Mapa pequeno no canto com posição do jogador e mobs próximos | 🟡 | Layout do mapa |
| 1.14 | NPC Shop UI | Janela com lista de itens, preços, botões comprar/vender | 🟡 | Ícones de itens |
| 1.15 | Distribuição de Stats | Tela com atributos (STR, AGI, VIT, INT, DEX, LUK) e botões +/- | 🟢 | Nenhuma |
| 1.16 | Tela de Game Over / Loading | Tela inicial com logo do jogo e "Clique para jogar" | 🟡 | Logo do jogo |

**Subtotal UI:** 16 assets

---

## 2. Ícones e Sprites 2D

> **Dificuldade base:** 🟢 Fácil → 🟡 Médio
> **Fase de uso:** Fase 2 em diante (usados na UI)

| # | Asset | Descrição | Dificuldade | Dependências |
|---|-------|-----------|-------------|--------------|
| 2.1 | Ícones de Skills — Tembira | 6 ícones (ex: escudo, espada, provocar, endurecer, etc.) | 🟢 | Definição das skills |
| 2.2 | Ícones de Skills — Karaí | 6 ícones (ex: bola de fogo, gelo, escudo mágico, etc.) | 🟢 | Definição das skills |
| 2.3 | Ícones de Skills — Payé | 6 ícones (ex: cura, ressurreição, buff, etc.) | 🟢 | Definição das skills |
| 2.4 | Ícones de Itens — Armas | Ícones de espada, cajado, arco (placeholder) | 🟢 | Nenhuma |
| 2.5 | Ícones de Itens — Armaduras | Ícones de armadura leve, pesada, manto | 🟢 | Nenhuma |
| 2.6 | Ícones de Itens — Consumíveis | Poção vermelha, poção azul, comida | 🟢 | Nenhuma |
| 2.7 | Ícones de Itens — Drops/Materiais | Couro, erva, osso, etc. (itens dropados por mobs) | 🟢 | Tabela de drops |
| 2.8 | Ícones de Classes | 3 ícones representando Tembira, Karaí, Payé | 🟢 | Nenhuma |
| 2.9 | Ícones de Elementos | 7 ícones (fogo, água, terra, vento, sombra, sagrado, neutro) | 🟢 | Nenhuma |
| 2.10 | Ícones de Raridade | Bordas/fundo coloridos por raridade (comum, incomum, raro, elite, chefe) | 🟢 | Nenhuma |
| 2.11 | Ícone de Moeda | Ícone do Guarani (moeda) | 🟢 | Nenhuma |
| 2.12 | Ícones de Status | Buff/debuff icons (atordoado, envenenado, etc.) | 🟢 | Nenhuma |

**Subtotal Ícones:** ~60 ícones individuais (12 categorias)

---

## 3. Modelos 3D de Mobs

> **Dificuldade base:** 🟡 Médio → 🔴 Difícil
> **Fase de uso:** Fase 2 (Gameplay) — mobs precisam de modelo para spawnar

### 3.1 Mobs Comuns (baixa complexidade)

| # | Mob | Descrição do Modelo | Dificuldade | Notas |
|---|-----|---------------------|-------------|-------|
| 3.1.1 | Sapo Cururu | Sapo verde simples, proporções cartunescas | 🟢 | Base: sphere + parts para pernas |
| 3.1.2 | Capivara | Roedor grande, corpo cilíndrico, cabeça arredondada | 🟢 | Base: parts simples |
| 3.1.3 | Cobra-d'Água | Cobra segmentada, corpo longo e fino | 🟡 | Requer segmentos ou mesh simples |
| 3.1.4 | Mãe-da-Mata | Figura humanoide rústica, cabelos longos, vestido de folhas | 🟡 | Humanoide base + detalhes |
| 3.1.5 | Boitatá | Serpente de fogo, corpo longo com chamas | 🟡 | Efeito de partículas para fogo |

### 3.2 Mobs Incomuns/Raros (média complexidade)

| # | Mob | Descrição do Modelo | Dificuldade | Notas |
|---|-----|---------------------|-------------|-------|
| 3.2.1 | Boto Cor-de-Rosa | Boto rosa estilizado, corpo de golfinho | 🟡 | Mesh simples + cor rosa |
| 3.2.2 | Corpo Seco | Figura humanoide esquelética, roupas rasgadas | 🟡 | Humanoide + textura escura |
| 3.2.3 | Curupira | Pequeno humanoide, cabelo vermelho, pés virados | 🟡 | Humanoide pequeno + detalhes |
| 3.2.4 | Anhangá | Figura sombria com asas, aura escura | 🔴 | Requer asas + efeito de sombra |
| 3.2.5 | Onça-Pintada | Felino grande com manchas | 🟡 | Base: parts para corpo + textura manchada |
| 3.2.6 | Jacaré-Açu | Jacaré grande, corpo alongado, mandíbula forte | 🟡 | Parts alongados + textura |

### 3.3 Mobs Elite (alta complexidade)

| # | Mob | Descrição do Modelo | Dificuldade | Notas |
|---|-----|---------------------|-------------|-------|
| 3.3.1 | Mula Sem Cabeça | Mula sem cabeça, fogo no pescoço, corpo de cavalo | 🔴 | Modelagem complexa + efeito de fogo |
| 3.3.2 | Saci Pererê | Pequeno humanoide de uma perna, gorro vermelho, cachimbo | 🟡 | Humanoide + acessórios |
| 3.3.3 | Jurupari | Figura demoníaca, chifres, corpo musculoso | 🔴 | Humanoide detalhado + chifres |

### 3.4 Boss (muito alta complexidade)

| # | Mob | Descrição do Modelo | Dificuldade | Notas |
|---|-----|---------------------|-------------|-------|
| 3.4.1 | Boiúna | Cobra gigante aquática, escamas brilhantes, olhos luminosos | 🔴 | Modelo grande + textura + efeitos |
| 3.4.2 | Tupã-Jaguaçu (HOLD) | Entidade divina, jaguar + elementos sagrados | ⚫ | Pós-MVP |

**Subtotal Mobs:** 16 modelos (15 ativos + 1 hold)

---

## 4. Modelos 3D de Personagens (Classes)

> **Dificuldade base:** 🟡 Médio → 🔴 Difícil
> **Fase de uso:** Fase 2 (Gameplay)

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 4.1 | Tembira (base) | Humanoide masculino/feminino, armadura pesada, escudo | 🟡 | Rig padrão R15 do Roblox |
| 4.2 | Karaí (base) | Humanoide com manto/magia, cajado/orb | 🟡 | Rig padrão R15 |
| 4.3 | Payé (base) | Humanoide com vestes de curandeiro, símbolo sagrado | 🟡 | Rig padrão R15 |
| 4.4 | Variações de equipamento | Modelos de arma/armadura que aparecem no personagem ao equipar | 🔴 | Requer rigging + attachment points |

**Subtotal Personagens:** 3 bases + variações de equipamento

---

## 5. Mapas / Ambientes

> **Dificuldade base:** 🟡 Médio → ⚫ Muito Difícil
> **Fase de uso:** Fase 3 (Mundo) — mas podem ser feitos em paralelo

### 5.1 Mapa 1 — Zona Inicial (Pântano/Várzea)

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 5.1.1 | Terreno base | Chão de terra/grama com água rasa | 🟢 | Terrain tool do Studio |
| 5.1.2 | Árvores de pântano | Árvores baixas com raízes expostas | 🟡 | Parts + meshes simples |
| 5.1.3 | Vegetação | Samambaias, juncos, flores aquáticas | 🟢 | Parts simples |
| 5.1.4 | Rochas | Rochas de rio, pedras médias | 🟢 | Parts arredondados |
| 5.1.5 | Ponte/Caminho | Trilha de terra ou ponte de madeira | 🟢 | Parts |
| 5.1.6 | Spawn points | Áreas demarcadas para spawn de mobs | 🟢 | Invisíveis em runtime |
| 5.1.7 | Ponto de respawn | Área segura com visual de acampamento | 🟡 | Fogueira, barraca |

### 5.2 Mapa 2 — Zona Intermediária (Mata Atlântica)

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 5.2.1 | Terreno base | Chão de terra com raízes e folhas | 🟢 | Terrain tool |
| 5.2.2 | Árvores altas | Árvores de copa densa, troncos grossos | 🟡 | Parts + meshes |
| 5.2.3 | Vegetação rasteira | Arbustos, cogumelos, trepadeiras | 🟢 | Parts simples |
| 5.2.4 | Ruínas | Ruínas de pedra com símbolos (lore) | 🟡 | Parts + texturas |
| 5.2.5 | Rio/Cachoeira | Água corrente com queda | 🟡 | Terrain water + partículas |
| 5.2.6 | Portal de transição | Portal visual entre mapas | 🟡 | Efeito de partículas |

### 5.3 Mapa 3 — Zona Avançada (Floresta Sombria/Caatinga)

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 5.3.1 | Terreno base | Terra seca, areia, pedras | 🟢 | Terrain tool |
| 5.3.2 | Vegetação espinhosa | Cactos, arbustos secos | 🟢 | Parts simples |
| 5.3.3 | Formações rochosas | Cânions, pedras grandes | 🟡 | Parts + meshes |
| 5.3.4 | Área do Boss | Arena circular com altar/rio | 🟡 | Parts + decoração |
| 5.3.5 | Efeitos atmosféricos | Névoa, partículas de poeira | 🟡 | ParticleEmitter |

### 5.4 Mapa 4+ — Zonas Avançadas (Pós-MVP inicial)

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 5.4.1 | Mapa 4 — Sertão | Vegetação de caatinga, solo rachado | 🟡 | Similar ao mapa 3 |
| 5.4.2 | Mapa 5 — Pantanal | Áreas alagadas, vegetação densa | 🟡 | Similar ao mapa 1 |
| 5.4.3 | Mapa 6 — Rio Amazonas (Boss) | Área aquática com ilha/altar | 🔴 | Requer água + arena |

**Subtotal Mapas:** 6 mapas com ~30 assets de ambiente

---

## 6. Efeitos Visuais (VFX)

> **Dificuldade base:** 🟢 Fácil → 🔴 Difícil
> **Fase de uso:** Fase 2 (combate) em diante

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 6.1 | Hit effect | Flash branco/vermelho ao receber dano | 🟢 | ParticleEmitter simples |
| 6.2 | Número de dano | Texto flutuante com valor do dano | 🟢 | BillboardGui + TextLabel |
| 6.3 | Efeito de cura | Partículas verdes subindo | 🟢 | ParticleEmitter |
| 6.4 | Efeito de level up | Explosão de partículas douradas | 🟡 | ParticleEmitter + som |
| 6.5 | Efeito de morte | Dissolução/desaparecimento do mob | 🟡 | Tween + transparência |
| 6.6 | Efeito de drop | Brilho no item dropado no chão | 🟢 | PointLight + ParticleEmitter |
| 6.7 | Efeito de skill — Fogo | Bola de fogo, explosão | 🟡 | ParticleEmitter + mesh |
| 6.8 | Efeito de skill — Água | Jato de água, onda | 🟡 | ParticleEmitter |
| 6.9 | Efeito de skill — Terra | Rochas subindo, tremor | 🟡 | Parts + ParticleEmitter |
| 6.10 | Efeito de skill — Vento | Rajada de vento, folhas | 🟡 | ParticleEmitter |
| 6.11 | Efeito de skill — Sombra | Névoa escura, sombra | 🟡 | ParticleEmitter + cor |
| 6.12 | Efeito de skill — Sagrado | Luz dourada, partículas brilhantes | 🟡 | ParticleEmitter + PointLight |
| 6.13 | Efeito de portal | Espiral de partículas coloridas | 🟡 | ParticleEmitter |
| 6.14 | Efeito de buff/debuff | Ícone flutuante + aura colorida | 🟢 | ParticleEmitter + BillboardGui |
| 6.15 | Efeito de fogo (Boitatá/Mula) | Chamas contínuas no corpo | 🟡 | ParticleEmitter anexado |
| 6.16 | Efeito de água (Boiúna) | Ondas, respingos | 🟡 | ParticleEmitter + terrain |

**Subtotal VFX:** 16 efeitos

---

## 7. Animações

> **Dificuldade base:** 🟡 Médio → 🔴 Difícil
> **Fase de uso:** Fase 2 (Gameplay)

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 7.1 | Idle (personagem) | Animação de respiração/parado | 🟢 | Animation Editor do Studio |
| 7.2 | Walk (personagem) | Animação de caminhada | 🟢 | Animation Editor |
| 7.3 | Run (personagem) | Animação de corrida | 🟢 | Animation Editor |
| 7.4 | Attack (personagem) | Animação de ataque básico | 🟡 | Animation Editor |
| 7.5 | Hit (personagem) | Reação ao receber dano | 🟢 | Animation Editor |
| 7.6 | Death (personagem) | Animação de morte | 🟡 | Animation Editor |
| 7.7 | Cast (personagem) | Animação de uso de skill | 🟡 | Animation Editor |
| 7.8 | Idle (mob genérico) | Animação de mob parado | 🟢 | Animation Editor |
| 7.9 | Walk (mob genérico) | Animação de mob andando | 🟢 | Animation Editor |
| 7.10 | Attack (mob genérico) | Animação de mob atacando | 🟡 | Animation Editor |
| 7.11 | Death (mob genérico) | Animação de mob morrendo | 🟡 | Animation Editor |
| 7.12 | Animações únicas de boss | Boiúna: ataque de mergulho, sibilar, etc. | 🔴 | Múltiplas animações |

**Subtotal Animações:** ~12 animações base + variações

---

## 8. Áudio / Som

> **Dificuldade base:** 🟢 Fácil → 🟡 Médio
> **Fase de uso:** Fase 2 em diante

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 8.1 | Som de hit (físico) | Som de impacto/espada | 🟢 | Biblioteca gratuita (Freesound, etc.) |
| 8.2 | Som de hit (mágico) | Som de impacto mágico | 🟢 | Biblioteca gratuita |
| 8.3 | Som de level up | Fanfarra curta de level up | 🟢 | Biblioteca gratuita |
| 8.4 | Som de morte (jogador) | Som de derrota | 🟢 | Biblioteca gratuita |
| 8.5 | Som de morte (mob) | Som de criatura morrendo | 🟢 | Biblioteca gratuita |
| 8.6 | Som de drop | Som de item caindo/brilhando | 🟢 | Biblioteca gratuita |
| 8.7 | Som de coleta | Som de item coletado | 🟢 | Biblioteca gratuita |
| 8.8 | Som de compra/venda | Som de moeda/comércio | 🟢 | Biblioteca gratuita |
| 8.9 | Som de skill — Fogo | Som de explosão/chamas | 🟢 | Biblioteca gratuita |
| 8.10 | Som de skill — Água | Som de água/onda | 🟢 | Biblioteca gratuita |
| 8.11 | Som de skill — Cura | Som de cura/buff | 🟢 | Biblioteca gratuita |
| 8.12 | Som de portal | Som de teletransporte | 🟢 | Biblioteca gratuita |
| 8.13 | Som de hit crítico | Som de impacto forte | 🟢 | Biblioteca gratuita |
| 8.14 | Som de miss/erro | Som de erro/errou o ataque | 🟢 | Biblioteca gratuita |
| 8.15 | Música de fundo — Mapa 1 | Música ambiente de pântano | 🟡 | Royalty-free ou gerada por IA |
| 8.16 | Música de fundo — Mapa 2 | Música ambiente de floresta | 🟡 | Royalty-free ou gerada por IA |
| 8.17 | Música de fundo — Mapa 3 | Música ambiente sombria | 🟡 | Royalty-free ou gerada por IA |
| 8.18 | Música de fundo — Boss | Música de tensão/combate | 🟡 | Royalty-free ou gerada por IA |
| 8.19 | Música de fundo — Menu | Música do menu principal | 🟡 | Royalty-free ou gerada por IA |
| 8.20 | Som de UI — Clique | Som de botão clicado | 🟢 | Biblioteca gratuita |
| 8.21 | Som de UI — Notificação | Som de alerta/notificação | 🟢 | Biblioteca gratuita |
| 8.22 | Som de UI — Erro | Som de ação bloqueada | 🟢 | Biblioteca gratuita |

**Subtotal Áudio:** ~22 sons/músicas

---

## 9. Texturas e Materiais

> **Dificuldade base:** 🟢 Fácil → 🟡 Médio
> **Fase de uso:** Fase 2 em diante

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 9.1 | Textura de grama | Textura para terreno de mapa 1/2 | 🟢 | Roblox material ou imagem |
| 9.2 | Textura de terra | Textura para terreno de mapa 3 | 🟢 | Roblox material ou imagem |
| 9.3 | Textura de água | Textura para rios/pântano | 🟢 | Roblox water material |
| 9.4 | Textura de pedra | Textura para rochas/ruínas | 🟢 | Roblox material |
| 9.5 | Textura de madeira | Textura para pontes/estruturas | 🟢 | Roblox material |
| 9.6 | Textura de escama | Textura para Boiúna/cobra | 🟡 | Imagem customizada |
| 9.7 | Textura de pele | Textura para mobs humanoides | 🟡 | Imagem customizada |
| 9.8 | Textura de metal | Textura para armas/armaduras | 🟢 | Roblox material |
| 9.9 | Textura de tecido | Textura para roupas/mantos | 🟡 | Imagem customizada |
| 9.10 | Textura de fogo | Textura para efeitos de fogo | 🟢 | Roblox fire material |
| 9.11 | Textura de sombra | Textura para efeitos sombrios | 🟢 | Roblox material + cor |

**Subtotal Texturas:** 11 texturas

---

## 10. Logo e Identidade Visual

> **Dificuldade base:** 🟡 Médio
> **Fase de uso:** Fase 6 (Polish) — mas pode ser feito antes

| # | Asset | Descrição | Dificuldade | Notas |
|---|-------|-----------|-------------|-------|
| 10.1 | Logo do jogo | Logo "ROBR" com estilo folclore brasileiro | 🟡 | Ferramenta externa (GIMP, Canva, IA) |
| 10.2 | Ícone do jogo (Roblox) | Ícone 512x512 para a página do jogo | 🟡 | Derivado do logo |
| 10.3 | Thumbnail do jogo | Imagem de capa para a página do Roblox | 🟡 | Derivado do logo + screenshot |
| 10.4 | Banner do jogo | Banner horizontal para página do Roblox | 🟡 | Derivado do logo |

**Subtotal Identidade:** 4 assets

---

## Resumo Geral

| Categoria | Quantidade | Dificuldade Predominante |
|-----------|------------|--------------------------|
| UI / HUD | 16 | 🟢 → 🟡 |
| Ícones 2D | ~60 | 🟢 |
| Modelos 3D — Mobs | 16 | 🟡 → 🔴 |
| Modelos 3D — Personagens | 3+ | 🟡 → 🔴 |
| Mapas / Ambientes | ~30 | 🟡 → ⚫ |
| Efeitos Visuais (VFX) | 16 | 🟢 → 🟡 |
| Animações | ~12+ | 🟡 → 🔴 |
| Áudio / Som | ~22 | 🟢 → 🟡 |
| Texturas / Materiais | 11 | 🟢 → 🟡 |
| Logo / Identidade | 4 | 🟡 |
| **TOTAL** | **~190 assets** | |

---

## Ordem de Execução Recomendada

Considerando dependências e o princípio de "assets em paralelo sem bloquear":

### Onde estamos (Fase 2 — Gameplay)
1. **UI/HUD básico** (1.1-1.5, 1.10, 1.12) — necessário para testar combate
2. **Ícones de skills** (2.1-2.3) — necessário para hotbar
3. **Modelos placeholder de mobs** (3.1.1, 3.1.2) — esferas/cubos coloridos para teste
4. **Animações básicas** (7.1-7.3, 7.8-7.9) — idle/walk para personagem e mob
5. **VFX básicos** (6.1, 6.2, 6.5, 6.6) — hit, dano, morte, drop
6. **Sons básicos** (8.1-8.8) — hit, level up, morte, drop

### Próxima fase (Fase 3 — Mundo)
7. **Mapa 1 completo** (5.1.1-5.1.7)
8. **Modelos finais dos mobs do Mapa 1** (Sapo Cururu, Capivara, Cobra-d'Água)
9. **VFX de skills** (6.7-6.12)
10. **Músicas de fundo** (8.15-8.19)

### Fase 4+ (Economia e além)
11. **Mapas 2, 3, 4+** (5.2-5.4)
12. **Modelos finais dos mobs restantes** (3.2-3.4)
13. **Animações de boss** (7.12)
14. **Logo e identidade** (10.1-10.4)

---

## Notas Importantes

1. **Placeholders primeiro:** Use esferas, cubos e cilindros coloridos como placeholders durante o desenvolvimento. Substitua por modelos finais depois.
2. **Roblox nativo:** Muitos assets (terrain, água, materiais básicos) já existem nativamente no Roblox Studio — não precisa criar do zero.
3. **Roblox Asset Library:** Verifique a Toolbox do Studio por assets gratuitos que podem ser reutilizados (árvores, rochas, efeitos).
4. **Estilo visual:** Defina um estilo consistente (cartoon/stylized low-poly) antes de criar os modelos finais. Isso facilita a produção e mantém coerência.
5. **Rigging:** Use o sistema R15 nativo do Roblox para personagens. Para mobs, considere R6 ou até mesmo models sem rig (apenas parts) para mobs simples.
6. **Performance:** Limite o número de partes por modelo. Mobs com muitas parts impactam performance em sessões multiplayer.
