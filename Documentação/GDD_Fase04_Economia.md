# GDD — Fase 4: Economia

> Define o sistema de economia do MVP: drops, loot, NPC shop e trade entre jogadores.
> Critério de saída: sistemas de drop, venda, compra e trade funcionais no Roblox Studio.
> Dependências: Fase 1 (Fundação Técnica), Fase 2 (Gameplay/Combate), Fase 3 (Mundo)
> Referência de preços: GDD_Fase08_Economia_Basica.md

---

## 1. Visão Geral

A Fase 4 implementa a **economia jogável** do ROBR. São 4 sistemas interconectados:

| Sistema | Módulo Luau | Responsabilidade |
|---|---|---|
| DropTable | `DropTable.lua` | Tabela de drops por mob (item, chance, valor) |
| LootManager | `LootManager.lua` | Gera drops ao matar mob, entrega ao jogador |
| NPCShop | `NPCShop.lua` | Compra de jogador (vende itens) e venda de jogador (compra drops) |
| TradeManager | `TradeManager.lua` | Trade direto entre dois jogadores |

**Fluxo completo:**
```
Mob morto → LootManager consulta DropTable → Drop gerado → Jogador coleta
Jogador → NPCShop: vende drops (ganha Wira'i) ou compra itens (gasta Wira'i)
Jogador A ↔ Jogador B: TradeManager (itens + Wira'i)
```

**Regras de negócio (herdadas da Fase 0.8):**
- Moeda: Wira'i
- Cartas: drop rate fixo 0.5% (exceto Saci Sombrio 0.8%)
- NPC compra qualquer drop de mob pelo valor fixo da ficha
- NPC não compra equipamentos craftados ou loot de outros jogadores
- Sem limite de estoque NPC
- Trade: máx 10 itens, máx 999.999 Wira'i, distância 10 studs, taxa 0%
- Itens equipados não podem ser trocados
- Sem inflação: preços fixos
- Sem auction house no MVP

---

## 2. Estrutura de Arquivos

```
ReplicatedStorage/
  Modules/
    Config/
      DropTable.lua          ← Tabela de drops (Server + Client read-only)
    Server/
      LootManager.lua        ← Geração de drops (server-only)
      NPCShop.lua            ← Lógica de compra/venda NPC
      TradeManager.lua       ← Lógica de trade entre jogadores
    Client/
      NPCShopUI.lua          ← Interface do NPC Shop
      TradeUI.lua            ← Interface de trade

ServerScriptService/
  ServerMain.lua             ← Referencia LootManager, NPCShop, TradeManager

ReplicatedStorage/
  Remotes/
    Economy/
      BuyItem (RemoteFunction)    ← Client→Server: comprar item do NPC
      SellItem (RemoteFunction)   ← Client→Server: vender item ao NPC
      TradeRequest (RemoteEvent)  ← Jogador A solicita trade
      TradeAccept (RemoteEvent)   ← Jogador B aceita
      TradeConfirm (RemoteEvent)  ← Ambos confirmam
      TradeCancel (RemoteEvent)   ← Qualquer lado cancela
      TradeUpdate (RemoteEvent)   ← Server→Client: atualiza janela
```

---

## 3. Sistema de Drops

### 3.1 — DropTable.lua (ModuleScript)

Módulo de configuração (read-only). Centraliza TODOS os drops de TODOS os mobs em uma tabela indexada por `mobId`.

**Estrutura de dados:**
```lua
DropTable.Items = {
    ["MOB_001"] = {
        { id = "ITEM_001", nome = "Carta — Sapo Cururu", tipo = "especial", chance = 0.5, valorNpc = 200 },
        { id = "ITEM_002", nome = "Bolsa de Lodo Cururu", tipo = "equipamento", chance = 3.0, valorNpc = 40 },
        -- ... mais drops
    },
    -- ... mais mobs
}
```

**Funções públicas:**
- `DropTable.GetDrops(mobId)` → retorna array de drops do mob
- `DropTable.GetItem(itemId)` → retorna dados de um item específico
- `DropTable.GetValue(itemId)` → retorna valor NPC do item

### 3.2 — Tabela Completa de Drops

#### MOB_001 — Sapo Cururu (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_001 | Carta — Sapo Cururu | especial | 0.5 | 200 |
| ITEM_002 | Bolsa de Lodo Cururu | equipamento | 3.0 | 40 |
| ITEM_003 | Glande de Sapo | consumível | 15.0 | 5 |
| ITEM_004 | Pedaço de Casca de Árvore | comum | 60.0 | 2 |
| ITEM_005 | Pedaço de Lama Seca | comum | 55.0 | 1 |

#### MOB_002 — Cobra-d'Água (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_006 | Carta — Cobra-d'Água | especial | 0.5 | 220 |
| ITEM_007 | Escama Serpentina | equipamento | 3.5 | 50 |
| ITEM_008 | Veneno de Cobra | consumível | 18.0 | 7 |
| ITEM_009 | Pele de Réptil | comum | 50.0 | 5 |
| ITEM_010 | Dente de Cobra | comum | 45.0 | 2 |

#### MOB_003 — Mãe-da-Mata (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_011 | Carta — Mãe-da-Mata | especial | 0.5 | 260 |
| ITEM_012 | Máscara de Cipó | equipamento | 4.0 | 60 |
| ITEM_013 | Pólen Alucinógeno | consumível | 20.0 | 9 |
| ITEM_014 | Pétala Seca | comum | 55.0 | 5 |
| ITEM_015 | Cipó Retorcido | comum | 50.0 | 1 |

#### MOB_004 — Boitatá (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_016 | Carta — Boitatá | especial | 0.5 | 300 |
| ITEM_017 | Escama de Fogo Serpente | equipamento | 4.5 | 75 |
| ITEM_018 | Chama Azulada | consumível | 22.0 | 12 |
| ITEM_019 | Cinza de Cobra | comum | 60.0 | 2 |
| ITEM_020 | Ovo de Serpente | comum | 35.0 | 8 |

#### MOB_005 — Curupira (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_036 | Carta — Curupira | especial | 0.5 | 350 |
| ITEM_037 | Pegada Invertida | equipamento | 4.0 | 70 |
| ITEM_038 | Erva de Guardião | consumível | 20.0 | 10 |
| ITEM_039 | Cabelo Vermelho | comum | 40.0 | 3 |
| ITEM_040 | Folha de Ipê | comum | 35.0 | 2 |

#### MOB_006 — Saci Sombrio (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_041 | Carta — Saci Sombrio | especial | 0.8 | 500 |
| ITEM_042 | Gorro Sombrio do Saci | equipamento | 6.5 | 120 |
| ITEM_043 | Fumo Corrompido | consumível | 25.0 | 18 |
| ITEM_044 | Folha de Tabaco | comum | 50.0 | 2 |
| ITEM_045 | Pó de Cinza Negra | comum | 35.0 | 5 |

#### MOB_007 — Boiúna (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_046 | Carta — Boiúna | especial | 0.5 | 1800 |
| ITEM_047 | Escama de Boiúna | equipamento | 1.2 | 900 |
| ITEM_048 | Muco Aquático | consumível | 6.0 | 70 |
| ITEM_049 | Dente de Serpente Gigante | comum | 25.0 | 15 |
| ITEM_050 | Alga Sagrada | comum | 30.0 | 8 |

#### MOB_008 — Anhangá (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_021 | Carta — Anhangá | especial | 0.5 | 380 |
| ITEM_022 | Manto do Submundo | equipamento | 5.0 | 90 |
| ITEM_023 | Essência de Espírito | consumível | 25.0 | 15 |
| ITEM_024 | Fumaça Fantasma | comum | 50.0 | 3 |
| ITEM_025 | Osso de Anhangá | comum | 30.0 | 10 |

#### MOB_009 — Jurupari (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_026 | Carta — Jurupari | especial | 0.5 | 450 |
| ITEM_027 | Bastão do Trovão | equipamento | 5.5 | 120 |
| ITEM_028 | Runa de Silêncio | consumível | 28.0 | 18 |
| ITEM_029 | Pena de Jurupari | comum | 55.0 | 10 |
| ITEM_030 | Fragmento de Máscara | comum | 40.0 | 4 |

#### MOB_011 — Boto Cor-de-Rosa (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_051 | Carta — Boto Cor-de-Rosa | especial | 0.5 | 350 |
| ITEM_052 | Pele do Boto | equipamento | 4.0 | 80 |
| ITEM_053 | Óleo de Boto | consumível | 20.0 | 12 |
| ITEM_054 | Dente de Boto | comum | 45.0 | 4 |
| ITEM_055 | Escama Rosada | comum | 50.0 | 3 |

#### MOB_012 — Mula Sem Cabeça (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_056 | Carta — Mula Sem Cabeça | especial | 0.5 | 400 |
| ITEM_057 | Ferradura de Aço | equipamento | 3.5 | 85 |
| ITEM_058 | Tocha Eterna | consumível | 18.0 | 15 |
| ITEM_059 | Pele de Mula | comum | 40.0 | 5 |
| ITEM_060 | Casco Queimado | comum | 35.0 | 3 |

#### MOB_013 — Corpo Seco (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_061 | Carta — Corpo Seco | especial | 0.5 | 320 |
| ITEM_062 | Ossos Amaldiçoados | equipamento | 4.5 | 70 |
| ITEM_063 | Promessa Quebrada | consumível | 22.0 | 10 |
| ITEM_064 | Pele Seca | comum | 48.0 | 4 |
| ITEM_065 | Terra de Cemitério | comum | 52.0 | 2 |

#### MOB_014 — Onça-Pintada (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_066 | Pele de Onça | especial | 0.5 | 350 |
| ITEM_067 | Garra de Arranhadura | equipamento | 4.0 | 80 |
| ITEM_068 | Presa de Onça | consumível | 20.0 | 12 |
| ITEM_069 | Carne de Onça | comum | 45.0 | 6 |
| ITEM_070 | Pelo Dourado | comum | 50.0 | 3 |

#### MOB_015 — Capivara (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_071 | Pele de Capivara | especial | 0.5 | 150 |
| ITEM_072 | Carne de Capivara | consumível | 30.0 | 8 |
| ITEM_073 | Pelo Macio | comum | 55.0 | 2 |
| ITEM_074 | Dente de Roedor | comum | 40.0 | 1 |
| ITEM_075 | Pata de Capivara | equipamento | 5.0 | 15 |

#### MOB_016 — Jacaré-Açu (5 drops)

| id_item | nome_item | tipo | chance_% | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_075 | Pele de Jacaré | especial | 0.5 | 380 |
| ITEM_076 | Dente de Jacaré | equipamento | 4.5 | 85 |
| ITEM_077 | Músculo de Jacaré | consumível | 18.0 | 14 |
| ITEM_078 | Escama Negra | comum | 42.0 | 5 |
| ITEM_079 | Gordura de Jacaré | comum | 35.0 | 3 |

### 3.3 — LootManager.lua (ModuleScript Server)

Responsável por gerar drops quando um mob morre e entregá-los ao jogador.

**Integração:** chamado pelo `AISystem` quando o HP do mob chega a 0.

**Algoritmo de drop:**
1. Consulta `DropTable.GetDrops(mobId)`
2. Para cada drop, rola `math.random() * 100 < chance`
3. Se passou, adiciona ao loot do jogador
4. Notifica o cliente via RemoteEvent

**Estrutura:**
```lua
local LootManager = {}

function LootManager.GenerateLoot(mobId, player)
    local drops = DropTable.GetDrops(mobId)
    local loot = {}
    for _, drop in ipairs(drops) do
        if math.random() * 100 < drop.chance then
            table.insert(loot, drop)
            -- Adicionar ao inventário do jogador
            InventoryManager.AddItem(player, drop.id)
        end
    end
    -- Notificar cliente
    Remotes.Loot:FireClient(player, mobId, loot)
    return loot
end

return LootManager
```

**Nota:** No MVP, o drop é adicionado diretamente ao inventário (sem pickup físico no chão). O jogador recebe uma notificação visual.

---

## 4. NPC Shop

### 4.1 — NPCShop.lua (ModuleScript Server)

Gerencia a loja do NPC: vende itens para o jogador e compra drops do jogador.

**Dependências:** `DataController` (para Wira'i e inventário), `DropTable` (para valores de venda).

#### 4.1.1 — Itens Vendidos pelo NPC (NPC vende → Jogador compra)

Os mesmos da Fase 0.8:

**Consumíveis:**

| Item | Preço (Wira'i) | Efeito | Nível Mín |
|---|---|---|---|
| Poção de Cura Pequena | 10 | Restaura 15% HP | 1 |
| Poção de Cura Média | 25 | Restaura 35% HP | 10 |
| Poção de Cura Grande | 60 | Restaura 60% HP | 20 |
| Poção de SP Pequena | 15 | Restaura 20% SP | 1 |
| Poção de SP Média | 35 | Restaura 40% SP | 10 |
| Antídoto | 20 | Remove veneno | 1 |
| Erva Revigorante | 30 | Remove medo, confusão, sono | 10 |

**Equipamentos Básicos:**

| Item | Preço (Wira'i) | Slot | Stats | Nível Mín |
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

#### 4.1.2 — Itens Comprados pelo NPC (Jogador vende → NPC compra)

Qualquer drop de mob pode ser vendido pelo valor `valorNpc` definido na DropTable.

**Regras:**
- NPC compra infinitamente (sem limite de estoque)
- NPC NÃO compra: equipamentos craftados, itens de outros jogadores, itens comprados de NPC
- Valor fixo (não negociável no MVP)

#### 4.1.3 — Funções do NPCShop

```lua
local NPCShop = {}

-- Jogador compra item do NPC
function NPCShop.BuyItem(player, itemId, quantity)
    -- 1. Verificar nível mínimo
    -- 2. Verificar Wira'i suficiente
    -- 3. Debitar Wira'i (DataController)
    -- 4. Adicionar item ao inventário
    -- 5. Retornar sucesso/falha
end

-- Jogador vende item ao NPC
function NPCShop.SellItem(player, itemId, quantity)
    -- 1. Verificar se item existe no inventário
    -- 2. Verificar se é vendível (é drop de mob)
    -- 3. Remover item do inventário
    -- 4. Creditar Wira'i (DataController)
    -- 5. Retornar sucesso + valor recebido
end

-- Retorna lista de itens à venda (para UI)
function NPCShop.GetShopItems()
    return SHOP_ITEMS -- tabela de itens vendidos pelo NPC
end

return NPCShop
```

### 4.2 — Comunicação com Client

**RemoteFunctions (síncronas, com retorno):**
- `BuyItem(player, itemId, quantity)` → `{ success: bool, message: string, newBalance: number }`
- `SellItem(player, itemId, quantity)` → `{ success: bool, message: string, newBalance: number, soldValue: number }`

**RemoteEvent (server → client, notificação):**
- `ShopNotification(player, message, type)` — type: "success", "error", "info"

---

## 5. Trade entre Jogadores

### 5.1 — TradeManager.lua (ModuleScript Server)

Gerencia o ciclo de vida de um trade entre dois jogadores.

**Ciclo de vida:**
```
1. Jogador A → TradeRequest → Server → encaminha para Jogador B
2. Jogador B → TradeAccept → Server → cria sessão de trade
3. Ambos adicionam itens/Wira'i → TradeUpdate → Server valida e espelha
4. Ambos confirmam → TradeConfirm → Server executa troca
5. Qualquer lado cancela → TradeCancel → Server destrói sessão
```

**Estrutura de sessão:**
```lua
local tradeSession = {
    playerA = playerA,
    playerB = playerB,
    itemsA = {},      -- { itemId, quantity }
    itemsB = {},
    wiraiA = 0,
    wiraiB = 0,
    confirmedA = false,
    confirmedB = false,
    active = true,
}
```

**Validações server-side (TODAS obrigatórias):**
1. Ambos jogadores no mesmo mapa
2. Distância ≤ 10 studs
3. Itens existem no inventário (e não estão equipados)
4. Wira'i ≤ 999.999 por trade
5. Total de itens ≤ 10 por lado
6. Jogador não está em outro trade
7. Itens de carta equipados não podem ser trocados

**Funções:**
```lua
local TradeManager = {}

function TradeManager.RequestTrade(from, to)
    -- Verifica se ambos estão disponíveis
    -- Envia solicitação ao jogador alvo
end

function TradeManager.AcceptTrade(player)
    -- Cria sessão de trade
    -- Notifica ambos jogadores
end

function TradeManager.AddItem(player, itemId, quantity)
    -- Adiciona item à oferta do jogador
    -- Reseta confirmações (mudança invalida confirmação)
    -- Espelha para ambos
end

function TradeManager.AddWirai(player, amount)
    -- Adiciona Wira'i à oferta
    -- Reseta confirmações
    -- Espelha para ambos
end

function TradeManager.ConfirmTrade(player)
    -- Marca jogador como confirmado
    -- Se ambos confirmaram → ExecutaTrade()
end

function TradeManager.ExecuteTrade(session)
    -- Valida TODAS as regras novamente
    -- Troca itens e Wira'i entre jogadores
    -- Notifica ambos
    -- Destrói sessão
end

function TradeManager.CancelTrade(player)
    -- Destrói sessão
    -- Notifica ambos
end

return TradeManager
```

### 5.2 — Comunicação com Client

**RemoteEvents:**
- `TradeRequest` (A→Server→B): `{ fromPlayer, fromName }`
- `TradeAccept` (B→Server): `{ player }`
- `TradeUpdate` (Server→Both): `{ itemsA, itemsB, wiraiA, wiraiB, confirmedA, confirmedB }`
- `TradeConfirm` (Either→Server): `{ player }`
- `TradeCancel` (Either→Server): `{ player }`
- `TradeResult` (Server→Both): `{ success, message }`

---

## 6. Notificações de Loot (Client)

Quando o jogador mata um mob, o cliente recebe o evento de loot e exibe uma notificação visual.

**Comportamento:**
- Notificação no canto inferior-right da tela
- Mostra ícone + nome do item + cor por raridade
- Dura 3 segundos, fade out
- Múltiplos drops: empilha notificações verticalmente

**Cores por tipo de drop:**
| Tipo | Cor |
|---|---|
| comum | #9CA3AF (cinza) |
| consumível | #3B82F6 (azul) |
| equipamento | #22C55E (verde) |
| especial (carta) | #FFD700 (dourado) |

---

## 7. Prompts para IDE Agêntica

### Prompt 1: DropTable.lua

```
Crie o ModuleScript "DropTable.lua" em ReplicatedStorage/Modules/Config/.

Este módulo é uma tabela de configuração read-only com TODOS os drops de TODOS os 15 mobs MVP do projeto ROBR.

Estrutura:
- DropTable.Items = tabela indexada por mobId (string "MOB_001" a "MOB_016", excluindo MOB_010)
- Cada entrada é um array de drop entries: { id, nome, tipo, chance, valorNpc }
- Tipos de drop: "comum", "consumível", "equipamento", "especial"
- Chance é porcentagem (0.5 a 60.0)
- valorNpc é inteiro (Wira'i)

Funções públicas:
- DropTable.GetDrops(mobId) → retorna array de drops ou {}
- DropTable.GetItem(itemId) → retorna entry do item ou nil
- DropTable.GetValue(itemId) → retorna valorNpc ou 0

Inclua TODOS os 15 mobs MVP com seus drops completos:
MOB_001 (5 drops), MOB_002 (5), MOB_003 (5), MOB_004 (5), MOB_005 (5),
MOB_006 (5), MOB_007 (5), MOB_008 (5), MOB_009 (5), MOB_011 (5),
MOB_012 (5), MOB_013 (5), MOB_014 (5), MOB_015 (5), MOB_016 (5).

IDs de item: ITEM_001 a ITEM_079 (ver tabela completa no GDD).
Cartas (tipo "especial") têm chance fixa de 0.5% (exceto MOB_006 Saci Sombrio: 0.8%).
```

### Prompt 2: LootManager.lua

```
Crie o ModuleScript "LootManager.lua" em ReplicatedStorage/Modules/Server/.

Dependências:
- ReplicatedStorage.Modules.Config.DropTable
- ReplicatedStorage.Modules.Server.InventarioManager (ou InventoryManager)
- ReplicatedStorage.Remotes.Loot (RemoteEvent)

Função principal:
- LootManager.GenerateLoot(mobId, player)
  1. Consulta DropTable.GetDrops(mobId)
  2. Para cada drop, rola math.random() * 100 < drop.chance
  3. Se passou, chama InventoryManager.AddItem(player, drop.id, 1)
  4. Coleta todos os drops gerados em um array 'loot'
  5. Dispara Remotes.Loot:FireClient(player, mobId, loot)
  6. Retorna o array de loot

Integração: Esta função deve ser chamada pelo AISystem quando um mob morre (HP <= 0).
O AISystem já tem acesso ao mobId e ao player que deu o killing blow.

Nota: No MVP, drops vão direto ao inventário (sem pickup físico no chão).
```

### Prompt 3: NPCShop.lua

```
Crie o ModuleScript "NPCShop.lua" em ReplicatedStorage/Modules/Server/.

Dependências:
- ReplicatedStorage.Modules.Config.DropTable
- ReplicatedStorage.Modules.Server.DataController
- ReplicatedStorage.Modules.Server.InventoryManager (ou InventarioManager)
- ReplicatedStorage.Remotes.Economy.BuyItem (RemoteFunction)
- ReplicatedStorage.Remotes.Economy.SellItem (RemoteFunction)

Estrutura:
- NPCShop.SHOP_ITEMS = tabela com 19 itens à venda (7 consumíveis + 12 equipamentos)
  Cada entry: { id, nome, preco, slot, stats, nivelMin }
  IDs: SHOP_001 a SHOP_019

Funções:
- NPCShop.BuyItem(player, itemId, quantity)
  Valida: nível mínimo, Wira'i suficiente, espaço no inventário
  Executa: debita Wira'i via DataController, adiciona item via InventoryManager
  Retorna: { success, message, newBalance }

- NPCShop.SellItem(player, itemId, quantity)
  Valida: item existe no inventário, item é vendível (tipo != "craftado")
  Executa: remove item via InventoryManager, credita Wira'i via DataController
  Retorna: { success, message, newBalance, soldValue }

- NPCShop.GetShopItems() → retorna SHOP_ITEMS

Regras:
- NPC compra qualquer drop de mob (qualquer tipo exceto "craftado")
- NPC não compra itens comprados de NPC (para evitar exploit)
- Preços fixos (sem flutuação)
- Sem limite de estoque
```

### Prompt 4: TradeManager.lua

```
Crie o ModuleScript "TradeManager.lua" em ReplicatedStorage/Modules/Server/.

Dependências:
- ReplicatedStorage.Modules.Server.DataController
- ReplicatedStorage.Modules.Server.InventoryManager
- ReplicatedStorage.Remotes.Economy.TradeRequest (RemoteEvent)
- ReplicatedStorage.Remotes.Economy.TradeAccept (RemoteEvent)
- ReplicatedStorage.Remotes.Economy.TradeUpdate (RemoteEvent)
- ReplicatedStorage.Remotes.Economy.TradeConfirm (RemoteEvent)
- ReplicatedStorage.Remotes.Economy.TradeCancel (RemoteEvent)
- ReplicatedStorage.Remotes.Economy.TradeResult (RemoteEvent)

Estrutura de sessão:
local tradeSession = {
    playerA, playerB,
    itemsA = {}, itemsB = {},
    wiraiA = 0, wiraiB = 0,
    confirmedA = false, confirmedB = false,
    active = true,
}

Tabela global: TradeManager.ActiveSessions = {} -- indexada por player

Funções:
- TradeManager.RequestTrade(from, to)
  Valida: to não está em trade, ambos online
  Envia RemoteEvent para to com { fromPlayer, fromName }

- TradeManager.AcceptTrade(player)
  Cria sessão, adiciona a ActiveSessions
  Notifica ambos via TradeUpdate

- TradeManager.AddItem(player, itemId, quantity)
  Valida: item existe no inventário, não está equipado, não é carta equipada
  Adiciona à oferta, reseta confirmações de AMBOS
  Espelha via TradeUpdate para ambos

- TradeManager.AddWirai(player, amount)
  Valida: amount <= saldo, amount <= 999999
  Adiciona à oferta, reseta confirmações
  Espelha via TradeUpdate

- TradeManager.ConfirmTrade(player)
  Marca confirmação
  Se ambos confirmados → ExecuteTrade()

- TradeManager.ExecuteTrade(session)
  Valida TODAS as regras novamente (distância, inventário, Wira'i)
  Troca itens e Wira'i entre jogadores via DataController e InventoryManager
  Notifica ambos via TradeResult
  Remove sessão de ActiveSessions

- TradeManager.CancelTrade(player)
  Remove sessão, notifica ambos

Regras de validação:
- Distância ≤ 10 studs entre jogadores
- Mesmo mapa
- Máx 10 itens por lado
- Máx 999.999 Wira'i por trade
- Itens equipados não podem ser trocados
- Cartas equipadas não podem ser trocados
- Jogador não pode estar em 2 trades simultâneos
```

### Prompt 5: RemoteEvents de Economia

```
Crie os seguintes RemoteEvents e RemoteFunctions em ReplicatedStorage/Remotes/Economy/:

RemoteFunctions (2):
- BuyItem: Server handler chama NPCShop.BuyItem(player, itemId, quantity)
- SellItem: Server handler chama NPCShop.SellItem(player, itemId, quantity)

RemoteEvents (6):
- Loot: Server→Client, payload: { mobId, loot }
- TradeRequest: Client→Server→Client, payload: { fromPlayer, fromName }
- TradeAccept: Client→Server, payload: { player }
- TradeUpdate: Server→Client, payload: { itemsA, itemsB, wiraiA, wiraiB, confirmedA, confirmedB }
- TradeConfirm: Client→Server, payload: { player }
- TradeCancel: Client→Server, payload: { player }
- TradeResult: Server→Client, payload: { success, message }

Cada RemoteEvent/Function precisa:
1. Criar o Instance no local correto
2. Conectar o server handler (no ServerMain ou script de inicialização)
3. Conectar o client handler (no ClientMain ou UI script)
```

---

## 8. Checklist de Implementação

### 8.1 — Infraestrutura
- [ ] Criar pasta `ReplicatedStorage/Remotes/Economy/`
- [ ] Criar 2 RemoteFunctions: BuyItem, SellItem
- [ ] Criar 6 RemoteEvents: Loot, TradeRequest, TradeAccept, TradeUpdate, TradeConfirm, TradeCancel, TradeResult
- [ ] Registrar handlers no ServerMain.lua
- [ ] Registrar handlers no ClientMain.lua

### 8.2 — DropTable
- [ ] Criar `ReplicatedStorage/Modules/Config/DropTable.lua`
- [ ] Inserir drops dos 15 mobs MVP (75 drops totais)
- [ ] Implementar GetDrops(mobId)
- [ ] Implementar GetItem(itemId)
- [ ] Implementar GetValue(itemId)
- [ ] Testar: `print(DropTable.GetDrops("MOB_001")[1].nome)` → "Carta — Sapo Cururu"

### 8.3 — LootManager
- [ ] Criar `ReplicatedStorage/Modules/Server/LootManager.lua`
- [ ] Implementar GenerateLoot(mobId, player)
- [ ] Integrar com AISystem (chamar ao matar mob)
- [ ] Integrar com InventoryManager (adicionar item)
- [ ] Disparar RemoteEvent Loot para o cliente
- [ ] Testar: matar mob → verificar item no inventário

### 8.4 — NPCShop
- [ ] Criar `ReplicatedStorage/Modules/Server/NPCShop.lua`
- [ ] Definir SHOP_ITEMS (19 itens)
- [ ] Implementar BuyItem(player, itemId, qty)
- [ ] Implementar SellItem(player, itemId, qty)
- [ ] Implementar GetShopItems()
- [ ] Conectar RemoteFunctions BuyItem e SellItem
- [ ] Testar: comprar poção (debitar Wira'i, receber item)
- [ ] Testar: vender drop (remover item, creditar Wira'i)

### 8.5 — TradeManager
- [ ] Criar `ReplicatedStorage/Modules/Server/TradeManager.lua`
- [ ] Implementar RequestTrade, AcceptTrade
- [ ] Implementar AddItem, AddWirai
- [ ] Implementar ConfirmTrade, ExecuteTrade
- [ ] Implementar CancelTrade
- [ ] Conectar todos os RemoteEvents de trade
- [ ] Testar: 2 jogadores → solicitar trade → adicionar itens → confirmar → verificar troca

### 8.6 — UI (Client)
- [ ] Criar UI de NPC Shop (janela com abas: Comprar/Vender)
- [ ] Criar UI de Trade (janela com 2 painéis + confirmação)
- [ ] Criar notificações de Loot (cantos inferior-right)
- [ ] Conectar UI aos RemoteEvents/Functions
- [ ] Testar: abrir loja → comprar → verificar saldo

### 8.7 — Validação Multiplayer
- [ ] Testar drop com 2+ jogadores (cada um recebe seu loot)
- [ ] Testar trade com 2 jogadores em servidores diferentes
- [ ] Testar cancelamento de trade (itens retornam)
- [ ] Testar venda simultânea no NPC (sem conflito)

---

## 9. Notas de Design

- **Server-authoritative:** TODA validação de economia acontece no servidor. Client apenas envia intenções e exibe resultados.
- **Sem exploits:** Nunca confie no cliente. Sempre re-valide no servidor (Wira'i, inventário, distância).
- **Atomicidade do trade:** A troca deve ser atômica — ou tudo troca, ou nada. Use pcall para rollback em caso de erro.
- **Performance:** DropTable é read-only e cacheada. Sem overhead de rede.
- **Extensibilidade:** DropTable é um ModuleScript de configuração. Adicionar novos mobs/drops = adicionar entradas na tabela, sem mudar código.

---

*Última atualização: 2026-06-12 — Fase 4: Economia (GDD)*
