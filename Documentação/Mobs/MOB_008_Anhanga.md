# MOB_008 — Anhangá

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_008 |
| nome | Anhangá |
| tipo_elemento | sombra |
| raridade | raro |
| status | aprovado |

**Descrição visual:**
> Espírito sombrio em forma de vulto sem rosto definido, envolto em névoa cinza-azulada. Olhos brancos vazios. Flutua e deixa rastro de fumaça fria. Som de sussurros ininteligíveis.

**Origem no lore:**
> Espírito maligno do submundo de Yvyvuçu, causador de pesadelos, doenças e desgraças. Manifestação da corrupção de Angá sobre o mundo dos mortos. Atrai azar, drena energia vital e espalha o medo. Habita cemitérios e matas fechadas, perseguindo aqueles que perturbam os ancestrais.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 4 — Tupã-Mbara ("Campo dos Ancestrais" — zona avançada) |
| zona_tipo | avançada |
| periodo | noite |
| ambiente_especifico | cemitério indígena, mata fechada à noite |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 25 |
| nivel_max | 30 |
| hp_max | 700 |
| ataque_base | 58 |
| tipo_dano | mágico (dreno/medo) |
| defesa_base | 28 |
| xp_recompensa | 320 |
| respawn_segundos | 120 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 18 |
| padrao_movimento | Flutua, teletransporta-se, persegue o jogador mais fraco |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Dreno de Vida | ataque/dreno | 30 | Rouba 18% do HP atual do alvo e transfere para o Anhangá |
| Medo Ancestral | debuff/CC | 40 | Força 1–2 jogadores a recuar descontroladamente por 2.5s (medo) |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_021 | Carta — Anhangá | especial | 0.5 | 380 |
| ITEM_022 | Manto do Submundo | equipamento | 5.0 | 90 |
| ITEM_023 | Essência de Espírito | consumível | 25.0 | 15 |
| ITEM_024 | Fumaça Fantasma | comum | 50.0 | 3 |
| ITEM_025 | Osso de Anhangá | comum | 30.0 | 10 |

### Itens especiais — descrição de efeitos

- **Carta — Anhangá:** Equipada concede "Sombra Devoradora" — aumenta dano contra espíritos em +15% e reduz o custo de skills de medo em 10%.
- **Manto do Submundo:** Robe que confere resistência a dano sombrio +20 e reduz o efeito de drenos de HP em 12%.

---

## Notas de Design

> Mob de zona avançada com mecânica de dreno de vida — o Dreno de Vida transfere HP para o mob, tornando-o mais durável quanto mais tempo o combate durar. Medo Ancestral cria CC de recuo que pode separar parties. O Manto do Submundo é item anti-dreno, útil contra outros mobs de sombra futuros.

---
*Última atualização: 2026-06-11 — Yvyvuçu: Espíritos da Terra*
