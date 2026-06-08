# MOB_004 — Boitatá

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_004 |
| nome | Boitatá |
| tipo_elemento | fogo |
| raridade | incomum |
| status | aprovado |

**Descrição visual:**
> Cobra gigante de fogo (8–10m), corpo translúcido com chamas azuladas e avermelhadas. Olhos incandescentes. Deixa rastro de fogo no chão. Som de crepitação constante.

**Origem no lore:**
> Espírito do fogo que protege a mata contra destruidores. Aparece como uma tocha viva que persegue invasores à noite. No folclore brasileiro, o Boitatá é uma serpente de fogo originária do Mato Grosso e do Sul do Brasil, protetora das florestas e dos campos.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 3 — Zona Intermediária Avançada |
| zona_tipo | intermediária_avançada |
| periodo | noite |
| ambiente_especifico | clareira queimada, floresta noturna |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 15 |
| nivel_max | 20 |
| hp_max | 520 |
| ataque_base | 40 |
| tipo_dano | fogo |
| defesa_base | 22 |
| xp_recompensa | 220 |
| respawn_segundos | 90 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 20 |
| padrao_movimento | Desliza rapidamente, ataca em espiral, lança fogo em linha reta |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Fogo Serpente | ataque_área | 35 | Cospe linha de fogo: 80% do ataque base como dano de fogo. Chão em chamas por 3s (burn: 3% HP/s) |
| Regeneração de Fogo | buff_auto | 45 | Recupera 12% do HP máximo em 6s. Só ativa quando está queimando um jogador |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_016 | Carta — Boitatá | especial | 0.5 | 300 |
| ITEM_017 | Escama de Fogo Serpente | equipamento | 4.5 | 75 |
| ITEM_018 | Chama Azulada | consumível | 22.0 | 12 |
| ITEM_019 | Cinza de Cobra | comum | 60.0 | 2 |
| ITEM_020 | Ovo de Serpente | comum | 35.0 | 8 |

### Itens especiais — descrição de efeitos

- **Carta — Boitatá:** Equipada concede "Fogo Eterno" — skills de fogo causam +10% de dano e têm 8% de chance de infligir burn (DoT 3s).
- **Escama de Fogo Serpente:** Arma que adiciona dano de fogo +12 e 10% de chance de causar burn no ataque corpo-a-corpo.

---

## Notas de Design

> Mob de transição entre zona intermediária e avançada. O buff de regeneração condicionado ao burn cria mecânica interessante: jogadores que usam builds de fogo potencializam o mob involuntariamente.

---
*Última atualização: 2026-06-07*
