# MOB_007 — Boiúna

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_007 |
| nome | Boiúna |
| tipo_elemento | água |
| raridade | chefe |
| status | aprovado |

**Descrição visual:**
> Serpente colossal (30m+), corpo negro com reflexos azul-escuros, olhos bioluminescentes amarelos. Apenas a cabeça e parte do dorso ficam visíveis sobre a água. Movimenta-se lentamente, mas ataca com velocidade explosiva. Som de água borbulhando e tremores no chão.

**Origem no lore:**
> Uma das maiores criaturas do folclore brasileiro. Habita rios e lagos profundos, afunda canoas e devora pescadores. Associada a tempestades e inundações. É a versão ancestral e colossal da Cobra-d'Água.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 6 — Ygara-Mbya ("Caminho das Águas Escuras" — arena de boss) |
| zona_tipo | final |
| periodo | ambos |
| ambiente_especifico | lago subterrâneo, caverna inundada (Pantanal subterrâneo) |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 30 |
| nivel_max | 30 |
| hp_max | 4200 |
| ataque_base | 135 |
| tipo_dano | físico + água |
| defesa_base | 70 |
| xp_recompensa | 1400 |
| respawn_segundos | 720 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 35 |
| padrao_movimento | Fica submersa na maior parte do tempo; emerge para atacar. Fase 2: enrola-se em torno de um jogador. Fase 3: agita o lago inteiro |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Onda Devastadora | ataque/área | 40 | Onda gigante: knockback 6m + 90% do ataque base como dano de água |
| Manto Aquático | buff/auto | 50 | Dura 8s: reduz todo dano recebido em 40% (corpo submerso protegido) |
| Olhar Hipnótico | debuff/confusão | 55 | Hipnotiza 1 jogador aleatório por 4s — ele ataca aliados |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_046 | Carta — Boiúna | especial | 0.5 | 1800 |
| ITEM_047 | Escama de Boiúna | equipamento | 1.2 | 900 |
| ITEM_048 | Muco Aquático | consumível | 6.0 | 70 |
| ITEM_049 | Dente de Serpente Gigante | comum | 25.0 | 15 |
| ITEM_050 | Alga Sagrada | comum | 30.0 | 8 |

### Itens especiais — descrição de efeitos

- **Carta — Boiúna:** Equipada concede "Profundidade Abissal" — resistência a dano de água +30%, imunidade a confusão, e skills de cura restauram 5% a mais em área úmida.
- **Escama de Boiúna:** Peitoral lendário: defesa +45, resistência a dano de água +25%, reduz efeito de knockback em 60%.

---

## Notas de Design

> Boss de mapa com mecânica de fases (submerso/emergido). O Manto Aquático dá janela de vulnerabilidade — jogadores devem esperar o buff acabar para causar dano efetivo. Olhar Hipnótico cria caos em party. Respawn de 12min é adequado para boss. Carta rara (0.25%) com efeito poderoso — item de endgame.

---
*Última atualização: 2026-06-07*
