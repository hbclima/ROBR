# GDD — Fase 0.8: Economia Básica

> Define o sistema de economia do MVP: moeda, preços, NPC shop e trade.
> Critério de saída: tabela de preços validada e sistema de trade definido antes de Fase 1.

---

## 1. Moeda

| Termo | Uso |
|---|---|
| **Guarani** | Moeda principal do jogo |

**Fontes de renda:**
- Venda de drops para NPCs
- Trade entre jogadores (futuro)

**Destinos de gasto:**
- Compra de consumíveis e equipamentos de NPCs
- Trade entre jogadores

---

## 2. NPC Shop

### 2.1 — Itens Vendidos pelo NPC (Comprados pelo Jogador)

#### Consumíveis

| Item | Preço (Guarani) | Efeito | Nível Mínimo |
|---|---|---|---|
| Poção de Cura Pequena | 10 | Restaura 15% HP | 1 |
| Poção de Cura Média | 25 | Restaura 35% HP | 10 |
| Poção de Cura Grande | 60 | Restaura 60% HP | 20 |
| Poção de SP Pequena | 15 | Restaura 20% SP | 1 |
| Poção de SP Média | 35 | Restaura 40% SP | 10 |
| Antídoto | 20 | Remove veneno | 1 |
| Erva Revigorante | 30 | Remove medo, confusão, sono | 10 |

#### Equipamentos Básicos

| Item | Preço (Guarani) | Slot | Stats | Nível Mínimo |
|---|---|---|---|---|
| Tacape Simples | 50 | Arma | ATK +5 | 1 |
| Tacape de Madeira | 120 | Arma | ATK +12 | 10 |
| Tacape de Pedra | 300 | Arma | ATK +25 | 20 |
| Cajado Simples | 45 | Arma | MATK +6 | 1 |
| Cajado de Osso | 110 | Arma | MATK +14 | 10 |
| Cajado de Pena | 280 | Arma | MATK +28 | 20 |
| Roupa de Fibra | 30 | Armadura | DEF +3 | 1 |
| Couro Leve | 80 | Armadura | DEF +8 | 10 |
| Couro Tratado | 200 | Armadura | DEF +18 | 20 |
| Máscara de Palha | 25 | Capacete | DEF +2 | 1 |
| Máscara de Madeira | 60 | Capacete | DEF +5 | 10 |
| Cocar Simples | 40 | Capacete | DEF +3, INT +1 | 1 |
| Cipó Trançado | 100 | Acessório | VIT +2 | 10 |
| Amuleto de Osso | 150 | Acessório | INT +3 | 15 |

### 2.2 — Itens Comprados pelo NPC (Vendidos pelo Jogador)

Os jogadores podem vender drops de mobs para NPCs pelo valor de tabela definido nas fichas de mob (campo `valor_npc_guarani`).

**Regras:**
- NPC compra qualquer drop de mob pelo valor fixo da ficha
- NPC não compra equipamentos craftados ou loot de outros jogadores
- Sem limite de estoque — NPC compra infinitamente

---

## 3. Tabela de Preços de Drops (Referência Rápida)

| Drop | Valor NPC (Guarani) | Tipo |
|---|---|---|
| Carta — Sapo Cururu | 200 | Especial |
| Bolsa de Lodo Cururu | 40 | Equipamento |
| Glande de Sapo | 5 | Consumível |
| Pedaço de Casca de Árvore | 2 | Comum |
| Pedaço de Lama Seca | 1 | Comum |
| Carta — Cobra-d'Água | 220 | Especial |
| Escama Serpentina | 50 | Equipamento |
| Veneno de Cobra | 7 | Consumível |
| Pele de Réptil | 5 | Comum |
| Dente de Cobra | 2 | Comum |
| Pele de Capivara | 150 | Especial |
| Carne de Capivara | 8 | Consumível |
| Pelo Macio | 2 | Comum |
| Dente de Roedor | 1 | Comum |
| Pata de Capivara | 15 | Equipamento |
| Carta — Mãe-da-Mata | 260 | Especial |
| Máscara de Cipó | 60 | Equipamento |
| Pólen Alucinógeno | 9 | Consumível |
| Pétala Seca | 5 | Comum |
| Cipó Retorcido | 1 | Comum |
| Carta — Boto Cor-de-Rosa | 350 | Especial |
| Pele do Boto | 80 | Equipamento |
| Óleo de Boto | 12 | Consumível |
| Dente de Boto | 4 | Comum |
| Escama Rosada | 3 | Comum |
| Carta — Corpo Seco | 320 | Especial |
| Ossos Amaldiçoados | 70 | Equipamento |
| Promessa Quebrada | 10 | Consumível |
| Pele Seca | 4 | Comum |
| Terra de Cemitério | 2 | Comum |
| Carta — Boitatá | 300 | Especial |
| Escama de Fogo Serpente | 75 | Equipamento |
| Chama Azulada | 12 | Consumível |
| Cinza de Cobra | 2 | Comum |
| Ovo de Serpente | 8 | Comum |
| Carta — Mula Sem Cabeça | 400 | Especial |
| Ferradura de Aço | 85 | Equipamento |
| Tocha Eterna | 15 | Consumível |
| Pele de Mula | 5 | Comum |
| Casco Queimado | 3 | Comum |
| Carta — Jacaré-Açu | 380 | Especial |
| Pele de Jacaré | 85 | Equipamento |
| Músculo de Jacaré | 14 | Consumível |
| Escama Negra | 5 | Comum |
| Gordura de Jacaré | 3 | Comum |
| Carta — Curupira | 350 | Especial |
| Pegada Invertida | 70 | Equipamento |
| Erva de Guardião | 10 | Consumível |
| Cabelo Vermelho | 3 | Comum |
| Folha de Ipê | 2 | Comum |
| Carta — Anhangá | 380 | Especial |
| Manto do Submundo | 90 | Equipamento |
| Essência de Espírito | 15 | Consumível |
| Fumaça Fantasma | 3 | Comum |
| Osso de Anhangá | 10 | Comum |
| Carta — Onça-Pintada | 350 | Especial |
| Garra de Arranhadura | 80 | Equipamento |
| Presa de Onça | 12 | Consumível |
| Carne de Onça | 6 | Comum |
| Pelo Dourado | 3 | Comum |
| Carta — Saci Pererê | 420 | Especial |
| Gorro Vermelho do Saci | 95 | Equipamento |
| Fumo de Cachimbo | 14 | Consumível |
| Folha de Tabaco | 2 | Comum |
| Pó de Carvão | 4 | Comum |
| Carta — Jurupari | 450 | Especial |
| Bastão do Trovão | 120 | Equipamento |
| Runa de Silêncio | 18 | Consumível |
| Pena de Jurupari | 10 | Comum |
| Fragmento de Máscara | 4 | Comum |
| Carta — Boiúna | 1800 | Especial |
| Escama de Boiúna | 900 | Equipamento |
| Muco Aquático | 70 | Consumível |
| Dente de Serpente Gigante | 15 | Comum |
| Alga Sagrada | 8 | Comum |

---

## 4. Sistema de Trade

### 4.1 — Trade entre Jogadores

**Mecânica:**
1. Jogador A abre o menu de trade com Jogador B (aproximação + interação)
2. Ambos colocam itens e/ou Guarani na janela de trade
3. Ambos confirmam
4. Transação executada instantaneamente

**Regras:**
- Ambos jogadores precisam estar no mesmo mapa
- Sem taxa de transação no MVP
- Itens equipados não podem ser trocados (precisa desequipar primeiro)
- Cartas equipadas não podem ser trocadas
- Trade pode ser cancelado por qualquer lado antes da confirmação

### 4.2 — Limites

| Parâmetro | Valor |
|---|---|
| Máximo de itens por trade | 10 |
| Máximo de Guarani por trade | 999.999 |
| Distância máxima entre jogadores | 10 studs |
| Taxa de transação | 0% (MVP) |

---

## 5. Progressão Econômica Estimada

### Por Nível de Jogador

| Nível | Guarani Estimado (acumulado) | Fonte Principal |
|---|---|---|
| 1–5 | ~500–1.000 | Drops de Sapo Cururu, Capivara |
| 6–10 | ~2.000–5.000 | Drops de Cobra-d'Água, venda de equipamentos |
| 11–15 | ~8.000–15.000 | Drops de Mãe-da-Mata, Boto |
| 16–20 | ~20.000–35.000 | Drops de Boitatá, Mula, Jacaré |
| 21–25 | ~50.000–80.000 | Drops de Curupira, Anhangá, Onça |
| 26–30 | ~100.000–150.000 | Drops de Saci, Jurupari, Boiúna |

### Poder de Compra Estimado

| Nível | O que o jogador pode comprar |
|---|---|
| 1–5 | Consumíveis básicos, equipamento inicial |
| 6–10 | Equipamento intermediário, poções médias |
| 11–15 | Bom equipamento, poções grandes |
| 16–20 | Equipamento avançado, acesso a todas as poções |
| 21–30 | Equipamento de elite, acúmulo de Guarani para trade |

---

## 6. Notas de Design

- **Sem inflação:** Preços fixos de NPC (não flutuam com oferta/demanda no MVP)
- **Sem auction house:** Trade apenas direto entre jogadores no MVP
- **Cartas como investimento:** Cartas raras (0.5% drop) têm alto valor de venda para NPC, mas o real valor é o efeito quando equipadas
- **Guarani como limitador:** O jogador não pode comprar tudo — precisa escolher entre consumíveis, equipamentos e poupar para trade
- **Venda de drops como renda principal:** O grind de mobs é a fonte primária de Guarani

---

*Última atualização: 2026-06-08*
