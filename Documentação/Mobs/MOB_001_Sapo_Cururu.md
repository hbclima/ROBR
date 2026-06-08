# MOB_001 — Sapo Cururu

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_001 |
| nome | Sapo Cururu |
| tipo_elemento | água |
| raridade | comum |
| status | aprovado |

**Descrição visual:**
> Sapo gigante (1,5m de comprimento), pele verde-escura com manchas marrons, olhos amarelos luminosos. Movimenta-se lentamente, infla as bochechas ao atacar. Estilo Roblox: corpo arredondado, textura simples, som de água ao pular.

**Origem no lore:**
> Espírito guardião das margens de rios, associado à fertilidade e às chuvas. Habita áreas úmidas protegendo os caminhos de água. É uma das primeiras entidades que jogadores iniciantes encontram.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 1 — Zona Inicial |
| zona_tipo | inicial |
| periodo | ambos |
| ambiente_especifico | margens do Rio Ibirapuera |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 1 |
| nivel_max | 6 |
| hp_max | 120 |
| ataque_base | 8 |
| tipo_dano | físico |
| defesa_base | 6 |
| xp_recompensa | 35 |
| respawn_segundos | 30 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | passivo |
| aggro_range_studs | 12 |
| padrao_movimento | Anda lentamente pela margem do rio, parando para inflar as bochechas |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Salto Pegajoso | debuff/controle | 18 | Ao pular sobre um jogador, reduz AGI em 30% por 4s (lentidão) |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_001 | Carta — Sapo Cururu | especial | 0.5 | 200 |
| ITEM_002 | Bolsa de Lodo Cururu | equipamento | 3.0 | 40 |
| ITEM_003 | Glande de Sapo | consumível | 15.0 | 5 |
| ITEM_004 | Pedaço de Casca de Árvore | comum | 60.0 | 2 |
| ITEM_005 | Pedaço de Lama Seca | comum | 55.0 | 1 |

### Itens especiais — descrição de efeitos

- **Carta — Sapo Cururu:** Equipada concede "Umidade Protetora" — reduz dano de fogo em 8% e aumenta regeneração de HP em área úmida.
- **Bolsa de Lodo Cururu:** Acessório que aumenta resistência a veneno em +5 e reduz cooldown de skills de cura em 5% quando em áreas com água.

---

## Notas de Design

> Mob passivo de zona inicial — primeiro contato do jogador com combate. Serve para ensinar mecânicas básicas sem punição severa. Aggro range de 8 studs é intencionalmente baixo para zona inicial (jogadores podem evitar se quiserem). Drop Carta — Sapo Cururu introduz sistema de cartas com buff defensivo contra fogo — útil contra Boitatá (MOB_004) futuramente.

---
*Última atualização: 2026-06-07*
