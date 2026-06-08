# MOB_010 — Tupã-Jaguaçu

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_010 |
| nome | Tupã-Jaguaçu |
| tipo_elemento | sagrado |
| raridade | chefe |
| status | hold |

**Descrição visual:**
> Jaguar colossal (15m) com pelagem dourada que emite luz própria. Olhos como sóis. Garras de relâmpago. Ao rugir, trovões ecoam e o céu escurece. Flutua levemente acima do chão do templo. Aura de energia sagrada emana de todo o corpo.

**Origem no lore:**
> O Jaguar Sagrado, mensageiro supremo de Tupã. Guardião do Ygara-Mbya — Caminho das Águas Escuras. Representa a força da natureza em sua forma mais pura e devastadora. É o boss final do MVP.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 6 — Ygara-Mbya ("Caminho das Águas Escuras" — arena de boss) |
| zona_tipo | final |
| periodo | ambos |
| ambiente_especifico | Ygara-Mbya — Caminho das Águas Escuras |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 30 |
| nivel_max | 30 |
| hp_max | 3500 |
| ataque_base | 120 |
| tipo_dano | sagrado + físico |
| defesa_base | 65 |
| xp_recompensa | 1200 |
| respawn_segundos | 600 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 30 |
| padrao_movimento | Fase 1: patrulha o templo. Fase 2 (HP < 60%): invoca trovões no mapa inteiro. Fase 3 (HP < 25%): modo frenesi, ataques mais rápidos e letais |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Garras do Trovão | ataque/área | 35 | Ataque em área (10m): 130% do ataque base como dano sagrado + atordoa por 2s |
| Rugido de Tupã | debuff/medo | 50 | Todos os jogadores no mapa são empurrados para trás e recebem debuff de medo (reduz dano causado em 25%) por 5s |
| Relâmpago Primordial | ataque/alvo | 60 | Relâmpago no jogador mais distante: 150% do ataque base como dano sagrado + marca o alvo (próximo ataque causa +50% de dano) |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_031 | Carta — Tupã-Jaguaçu | especial | 0.15 | 2500 |
| ITEM_032 | Garra Dourada | equipamento | 1.0 | 1200 |
| ITEM_033 | Essência do Trovão | consumível | 5.0 | 100 |
| ITEM_034 | Pelo Dourado | comum | 20.0 | 20 |
| ITEM_035 | Fragmento de Templo | comum | 25.0 | 12 |

### Itens especiais — descrição de efeitos

- **Carta — Tupã-Jaguaçu:** Equipada concede "Bênção do Trovão" — ataques têm 8% de chance de invocar um relâmpago (dano sagrado extra igual a 30% do ataque) e resistência a medo +25%.
- **Garra Dourada:** Arma lendária que causa dano físico + sagrado, +25 ATK, e 10% de chance de atordoar no hit.

---

## Notas de Design

> Boss final do MVP. Mecânica de 3 fases com escalada de dificuldade. Rugido de Tupã é fear AoE que reduz dano do party — requer coordenação. Relâmpago Primordial marca alvo para burst — tanks precisam gerenciar posição. Carta ultra-rara (0.15%) com efeito de proc de relâmpago. Respawn de 10min adequado para boss final.

---
*Última atualização: 2026-06-07*
