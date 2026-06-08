# MOB_011 — Boto Cor-de-Rosa

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_011 |
| nome | Boto Cor-de-Rosa |
| tipo_elemento | água |
| raridade | raro |
| status | aprovado |

**Descrição visual:**
> Forma humana: homem jovem elegante, roupa branca, chapéu de palha escondendo o espiráculo no topo da cabeça. Forma animal: golfinho rosado de 2m, olhos pequenos, focinho alongado. Em combate, alterna entre as duas fases — na forma humana usa charme e hipnose; na forma aquática, velocidade e ataques com cauda.

**Origem no lore:**
> Entidade da região amazônica que se transforma de golfinho em homem para seduzir vítimas em festas ribeirinhas. É um predador egoísta e traiçoeiro — disfarça-se de galanteador, encanta e leva suas presas para o fundo do rio. Sua fraqueza é o espiráculo que permanece no topo da cabeça mesmo em forma humana, escondido pelo chapéu.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 2 — Zona Intermediária |
| zona_tipo | intermediária |
| periodo | noite |
| ambiente_especifico | rios e igarapés da zona ribeirinha |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 12 |
| nivel_max | 15 |
| hp_max | 380 |
| ataque_base | 32 |
| tipo_dano | água + mágico |
| defesa_base | 16 |
| xp_recompensa | 170 |
| respawn_segundos | 180 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 18 |
| padrao_movimento | Alterna entre forma humana (lento, charmosa) e forma aquática (rápida, agressiva). Ataca em hit-and-run |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Encantamento do Boto | debuff/hipnose | 30 | Encanta 1 jogador por 3s — ele caminha em direção ao Boto sem poder atacar |
| Investida Aquática | ataque/deslocamento | 25 | Mergulha e emerge atrás do jogador mais distante: 90% do ataque base como dano de água + empurra 3m |
| Espiráculo Sônico | ataque/área | 40 | Emite onda sonora em área (6m): 70% do ataque base + silencia por 2s |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_051 | Carta — Boto Cor-de-Rosa | especial | 0.5 | 350 |
| ITEM_052 | Pele do Boto | equipamento | 4.0 | 80 |
| ITEM_053 | Óleo de Boto | consumível | 20.0 | 12 |
| ITEM_054 | Dente de Boto | comum | 45.0 | 4 |
| ITEM_055 | Escama Rosada | comum | 50.0 | 3 |

### Itens especiais — descrição de efeitos

- **Carta — Boto Cor-de-Rosa:** Equipada concede "Encanto das Águas" — skills de água têm 12% de chance de encantar o alvo por 1.5s e +8% de dano em ambientes aquáticos.
- **Pele do Boto:** Armadura leve que confere respiração subaquática por 30s (cooldown 3min) e +5 AGI em áreas com água.

---

## Notas de Design

> Mob raro de zona intermediária com mecânica de encantamento (hipnose). O Encantamento do Boto força o jogador a caminhar em direção ao perigo — requer que o party interrompa o encantamento causando dano ao Boto. Investida Aquática dá mobilidade e posicionamento. Espiráculo Sônico é silence AoE — primeira skill de silence do jogo. Pele do Boto habilita exploração subaquática futura.

---
*Última atualização: 2026-06-07*
