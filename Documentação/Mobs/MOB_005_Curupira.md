# MOB_005 — Curupira

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_005 |
| nome | Curupira |
| tipo_elemento | terra |
| raridade | raro |
| status | aprovado |

**Descrição visual:**
> Guardião da floresta, figura ágil de ~1,2m, cabelos vermelhos flamejantes, olhos amarelos brilhantes. Pés virados para trás (pegadas invertidas). Movimenta-se em zigue-zague, deixando rastro de folhas secas. Estilo Roblox: corpo esguio, textura de casca de árvore, efeito de partículas de folhas.

**Origem no lore:**
> Protetor das matas no folclore brasileiro. Confunde caçadores e lenhadores que destroem a floresta, deixando pegadas falsas para desorientá-los. Seus pés invertidos fazem com que suas pegadas levem na direção oposta.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 4 — Zona Avançada |
| zona_tipo | avançada |
| periodo | ambos |
| ambiente_especifico | mata densa, trilha de caçadores |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 20 |
| nivel_max | 25 |
| hp_max | 800 |
| ataque_base | 62 |
| tipo_dano | físico + natureza |
| defesa_base | 30 |
| xp_recompensa | 280 |
| respawn_segundos | 100 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 20 |
| padrao_movimento | Anda rapidamente em zigue-zague, salta entre árvores, pode se esconder na vegetação (3s de camuflagem) |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Trilha Enganosa | debuff/confusão | 30 | Inverte o controle de movimento de 1–2 jogadores por 3s |
| Salto do Guardião | ataque/deslocamento | 40 | Pula sobre o jogador mais distante, causa 110% do ataque base e derruba (knockdown 1.5s) |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_036 | Carta — Curupira | especial | 0.5 | 350 |
| ITEM_037 | Pegada Invertida | equipamento | 4.0 | 70 |
| ITEM_038 | Erva de Guardião | consumível | 20.0 | 10 |
| ITEM_039 | Cabelo Vermelho | comum | 40.0 | 3 |
| ITEM_040 | Folha de Ipê | comum | 35.0 | 2 |

### Itens especiais — descrição de efeitos

- **Carta — Curupira:** Equipada concede "Trilha Protegida" — 10% de chance de inverter o efeito de um CC recebido (ao ser atordoado, o jogador se move em vez de ficar parado).
- **Pegada Invertida:** Botas que aumentam a esquiva em +8 e reduzem a chance de ser rastreado por mobs agressivos em 20%.

---

## Notas de Design

> Mob de zona avançada com mecânica de CC baseada em confusão de movimento (controles invertidos). A skill "Trilha Enganosa" é a primeira skill de inversão de controles do jogo — requer teste multiplayer cuidadoso. Salto do Guardião dá mobilidade e burst. Item "Pegada Invertida" cria build de stealth/ES interessante.

---
*Última atualização: 2026-06-07*
