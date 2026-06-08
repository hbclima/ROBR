# MOB_003 — Mãe-da-Mata

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_003 |
| nome | Mãe-da-Mata |
| tipo_elemento | terra |
| raridade | incomum |
| status | aprovado |

**Descrição visual:**
> Figura feminina etérea, corpo envolto em folhas e cipós, rosto semi-oculto por uma máscara de madeira. Flutua a 30cm do chão, deixa rastro de pétalas. Luz verde suave emana dela.

**Origem no lore:**
> Espírito protetor da floresta, punidora de caçadores gananciosos. Controla a ilusão e o sono dos invasores. Habita clareiras sagradas no coração da mata, protegendo a vida selvagem de predadores humanos.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 2 — Zona Intermediária |
| zona_tipo | intermediária |
| periodo | ambos |
| ambiente_especifico | floresta densa, clareira sagrada |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 10 |
| nivel_max | 15 |
| hp_max | 350 |
| ataque_base | 24 |
| tipo_dano | mágico (ilusão) |
| defesa_base | 14 |
| xp_recompensa | 140 |
| respawn_segundos | 60 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 15 |
| padrao_movimento | Flutua lentamente, teletransporta-se para confundir jogadores |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Sopro Sonífero | debuff/CC | 25 | Põe 1 jogador aleatório para dormir por 3s (incapacitado) |
| Ilusão de Pétalas | buff/auto | 40 | Dura 5s: 60% imune a skills diretas + 50% chance de desviar ataques físicos |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_011 | Carta — Mãe-da-Mata | especial | 0.5 | 260 |
| ITEM_012 | Máscara de Cipó | equipamento | 4.0 | 60 |
| ITEM_013 | Pólen Alucinógeno | consumível | 20.0 | 9 |
| ITEM_014 | Pétala Seca | comum | 55.0 | 5 |
| ITEM_015 | Cipó Retorcido | comum | 50.0 | 1 |

### Itens especiais — descrição de efeitos

- **Carta — Mãe-da-Mata:** Equipada concede "Ilusão Protetora" — 15% de chance de anular o próximo ataque de CC (confusão, sono) e reduz dano mágico em 5%.
- **Máscara de Cipó:** Headgear que aumenta resistência a efeitos mentais (sono, confusão) em +15 e dá +3 INT.

---

## Notas de Design

> Mob de zona intermediária com skill de sleep (Sopro Sonífero) — primeiro CC de incapacitação do jogo. Ensina jogadores a respeitar aggro range e a gerenciar debuffs. Ilusão de Pétalas dá janela de invulnerabilidade — jogadores precisam esperar o buff acabar. Máscara de Cipó é counter direto contra sleep, criando loop de preparação.

---
*Última atualização: 2026-06-07*
