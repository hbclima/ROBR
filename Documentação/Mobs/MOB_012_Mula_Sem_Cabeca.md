# MOB_012 — Mula Sem Cabeça

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_012 |
| nome | Mula Sem Cabeça |
| tipo_elemento | fogo |
| raridade | elite |
| status | aprovado |

**Descrição visual:**
> Mula preta de 2m de altura, no lugar da cabeça uma tocha de fogo vivo que nunca se apaga. Ferraduras de aço nos cascos que faiscam a cada passo. Relincho ensurdecedor misturado com soluços humanos. Rastro de fogo no chão por onde passa. Olhos vermelhos brilhantes no pescoço onde deveria haver cabeça.

**Origem no lore:**
> Mulher que cometeu pecado imperdão (relação com padre ou antes do casamento) e foi amaldiçoada. Transforma-se em mula sem cabeça nas noites de quinta-feira, vagando por matas e campos, despedaçando quem encontra pelo caminho. O fogo no pescoço é a chama do pecado que nunca se apaga. Só desaparece ao terceiro cantar do galo.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 3 — Zona Intermediária Avançada |
| zona_tipo | intermediária_avançada |
| periodo | noite |
| ambiente_especifico | matas, campos, trilhas rurais |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 18 |
| nivel_max | 22 |
| hp_max | 600 |
| ataque_base | 65 |
| tipo_dano | fogo + físico |
| defesa_base | 24 |
| xp_recompensa | 260 |
| respawn_segundos | 300 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 22 |
| padrao_movimento | Corre em linha reta pelo mapa, derruba tudo no caminho. Para abruptamente e muda de direção. Deixa rastro de fogo no chão |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Investida Flamejante | ataque/linha | 30 | Corre em linha reta (12m): 110% do ataque base como dano de fogo. Rastro de fogo no chão por 4s (burn: 4% HP/s) |
| Relincho Aterrorizante | debuff/medo | 40 | Relincho em área (10m): medo por 2s (jogadores recuam descontroladamente) + reduz ATK em 15% por 5s |
| Patada Incendiária | ataque/single-target | 25 | Patada no alvo mais próximo: 130% do ataque base + queimadura (6% HP por 5s) |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_056 | Carta — Mula Sem Cabeça | especial | 0.5 | 400 |
| ITEM_057 | Ferradura de Aço | equipamento | 3.5 | 85 |
| ITEM_058 | Tocha Eterna | consumível | 18.0 | 15 |
| ITEM_059 | Pele de Mula | comum | 40.0 | 5 |
| ITEM_060 | Casco Queimado | comum | 35.0 | 3 |

### Itens especiais — descrição de efeitos

- **Carta — Mula Sem Cabeça:** Equipada concede "Fogo do Pecado" — ataques corpo a corpo têm 10% de chance de causar queimadura (5% HP por 4s) e resistência a medo +20.
- **Ferradura de Aço:** Botas que aumentam velocidade de movimento em 10% e deixam rastro de fogo que causa dano leve em mobs que passarem por ele.

---

## Notas de Design

> Mob elite de zona intermediária avançada com mecânica de investida em linha (similar a uma charge). Investida Flamejante cria zona de perigo no terreno (rastro de fogo) — jogadores precisam se posicionar para não serem empurrados para o fogo. Relinchi Aterrorizante é fear AoE que reduz dano — requer que tanks tenham resistência a medo. Patada Incendiária dá burst single-target com queimadura. Respawn de 5min adequado para elite.

---
*Última atualização: 2026-06-07*
