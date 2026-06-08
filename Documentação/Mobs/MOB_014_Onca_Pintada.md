# MOB_014 — Onça-Pintada

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_014 |
| nome | Onça-Pintada |
| tipo_elemento | neutro |
| raridade | raro |
| status | aprovado |

**Descrição visual:**
> Felino de 1,8m, pelagem amarelo-dourado com rosetas pretas únicas. Olhos âmbar penetrantes. Musculatura poderosa, mandíbula proeminente. Move-se com silêncio felino. Estilo Roblox: corpo esguio mas musculoso, animação de caminhada furtiva, efeito de olhos brilhantes no escuro.

**Origem no lore:**
> Maior felino das Américas e predador de topo dos biomas brasileiro. Para os povos Tupi-Guarani, a onça era sagrada — guerreiros valentes se transformavam em onças após a morte. Nas matas, seu rugido é o som do perigo absoluto. Caça por emboscada, com uma mordida capaz de perfurar cascos de tartaruga.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 4 — Zona Avançada |
| zona_tipo | avançada |
| periodo | noite |
| ambiente_especifico | mata densa, trilhas da floresta |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 20 |
| nivel_max | 25 |
| hp_max | 900 |
| ataque_base | 65 |
| tipo_dano | físico |
| defesa_base | 40 |
| xp_recompensa | 300 |
| respawn_segundos | 180 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 22 |
| padrao_movimento | Emboscada — permanece imóvel na vegetação, ataca quando jogador se aproxima. Persegue em curtos bursts de alta velocidade |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Emboscada Súbita | ataque/surprise | 35 | Deixa-se invisível na vegetação por até 8s. Primeiro ataque: 150% do ataque base + atordoa por 1.5s |
| Rugido Aterrorizante | debuff/medo | 45 | Área (8m): medo por 2s + reduz ATK em 20% por 6s |
| Garra Rasante | ataque/área | 30 | Ataque circular: 90% do ataque base em área (5m) |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_066 | Pele de Onça | especial | 0.5 | 350 |
| ITEM_067 | Garra de Arranhadura | equipamento | 4.0 | 80 |
| ITEM_068 | Presa de Onça | consumível | 20.0 | 12 |
| ITEM_069 | Carne de Onça | comum | 45.0 | 6 |
| ITEM_070 | Pelo Dourado | comum | 50.0 | 3 |

### Itens especiais — descrição de efeitos

- **Pele de Onça:** Equipada concede "Furtividade Predatória" — aumenta chance de ataque crítico em 15% e velocidade de movimento em 8% ao permanecer parado por mais de 3s.
- **Garra de Arranhadura:** Arma que adiciona dano físico +15 e 8% de chance de causar sangramento (4% HP por 4s).

---

## Notas de Design

> Mob raro de zona avançada com mecânica de emboscada. A skill Emboscada Súbita torna a onça invisível na vegetação — jogadores precisam prestar atenção a partículas/som ambiente para detectar a presença. Rugido Aterrorizante é fear + debuff de ATK — requer resistência a medo. Drop Pele de Onça beneficia builds DPS que usam posicionamento.

---
*Última atualização: 2026-06-07*
