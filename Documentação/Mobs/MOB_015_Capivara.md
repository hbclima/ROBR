# MOB_015 — Capivara

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_015 |
| nome | Capivara |
| tipo_elemento | neutro |
| raridade | comum |
| status | aprovado |

**Descrição visual:**
> Grande roedor de 1,2m, pelagem marrom-avermelhada densa e áspera. Focinho arredondado, orelhas pequenas, patas parcialmente palmadas. Move-se em grupos de 3–5 indivíduos. Estilo Roblox: corpo arredondado e fofo, animação lenta e dócil, sons de assobio.

**Origem no lore:**
> Maior roedor do mundo, símbolo da vida ribeirinha brasileira. Vive em grupos familiares pacíficos às margens de rios e lagoas. É a presa favorita de onças e jacarés — sua presença indica que predadores estão por perto. Para viajantes, ver capivaras significa água doce por perto.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 1 — Zona Inicial |
| zona_tipo | inicial |
| periodo | dia |
| ambiente_especifico | margens de rios e lagoas |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 1 |
| nivel_max | 5 |
| hp_max | 80 |
| ataque_base | 4 |
| tipo_dano | físico |
| defesa_base | 4 |
| xp_recompensa | 20 |
| respawn_segundos | 20 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | passivo |
| aggro_range_studs | 12 |
| padrao_movimento | Em grupos de 3–5, pasta margens de rios. Foge ao receber dano. Contra-ataca apenas se encurralada |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Fuga Rápida | buff/auto | 15 | Ao receber dano, corre em direção à água com +50% velocidade por 3s |
| Investida Desesperada | ataque | 30 | Só ativa se encurralada: cabeceada que empurra 2m e causa 50% do ataque base |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_071 | Pele de Capivara | especial | 0.5 | 150 |
| ITEM_072 | Carne de Capivara | consumível | 30.0 | 8 |
| ITEM_073 | Pelo Macio | comum | 55.0 | 2 |
| ITEM_074 | Dente de Roedor | comum | 40.0 | 1 |
| ITEM_075 | Pata de Capivara | equipamento | 5.0 | 15 |

### Itens especiais — descrição de efeitos

- **Pele de Capivara:** Equipada concede "Pele Impermeável" — resistência a dano de água em 10% e velocidade de natação aumentada em 15%.
- **Carne de Capivara:** Consumível — restaura 15% do HP máximo ao ser consumido (cooldown 30s).

---

## Notas de Design

> Mob passivo de zona inicial — segundo mob mais fraco do jogo depois do Sapo Cururu. Serve para ensinar mecânica de grupo (spawns em grupo) e drop de consumível de cura (Carne de Capivara). Fuga Rápida torna difícil matar se o jogador for lento — ensina a atacar rápido. Capivara como drops de comida introduz economia de consumíveis.

---
*Última atualização: 2026-06-07*
