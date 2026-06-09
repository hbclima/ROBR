# MOB_002 — Cobra-d'Água

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_002 |
| nome | Cobra-d'Água |
| tipo_elemento | água |
| raridade | comum |
| status | aprovado |

**Descrição visual:**
> Serpente de 3m, corpo azul-esverdeado com reflexos metálicos, olhos negros brilhantes. Desliza silenciosamente na água e na vegetação. Movimento sinuoso, pode ficar parcialmente submersa.

**Origem no lore:**
> Protetora dos rios, guardiã menor do Boitatá. Protege as águas contra a corrupção de Angá. Ataca caçadores que poluem ou pescam em excesso. Habita margens e pântanos, sendo uma guardiã das águas doces.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 1–2 — Ybirá-Puera / Floresta de Mãe-da-Mata |
| zona_tipo | inicial |
| periodo | ambos |
| ambiente_especifico | margens e pântanos |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 5 |
| nivel_max | 10 |
| hp_max | 210 |
| ataque_base | 16 |
| tipo_dano | físico + veneno |
| defesa_base | 10 |
| xp_recompensa | 80 |
| respawn_segundos | 45 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 12 |
| padrao_movimento | Desliza rapidamente em zigue-zague, pode se esconder na vegetação por 3s |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Mordida Venenosa | debuff/veneno | 22 | Dano contínuo de 6% do HP do alvo por 6s e reduz cura recebida em 20% |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_006 | Carta — Cobra-d'Água | especial | 0.5 | 220 |
| ITEM_007 | Escama Serpentina | equipamento | 3.5 | 50 |
| ITEM_008 | Veneno de Cobra | consumível | 18.0 | 7 |
| ITEM_009 | Pele de Réptil | comum | 50.0 | 5 |
| ITEM_010 | Dente de Cobra | comum | 45.0 | 2 |

### Itens especiais — descrição de efeitos

- **Carta — Cobra-d'Água:** Equipada concede "Muda Silenciosa" — aumenta AGI em +6 e chance de camuflagem em 10% ao estar em vegetação ou água.
- **Escama Serpentina:** Armadura leve que confere resistência a veneno +10 e reduz o custo de skills de esquiva em 8%.

---

## Notas de Design

> Mob de transição entre Mapa 1 e 2. Dano por veneno introduz mecânica de DoT (damage over time) com redução de cura — importante para tanks aprenderem a gerenciar debuffs cedo.

---
*Última atualização: 2026-06-11 — Yvyvuçu: Espíritos da Terra*
