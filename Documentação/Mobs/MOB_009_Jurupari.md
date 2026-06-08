# MOB_009 — Jurupari

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_009 |
| nome | Jurupari |
| tipo_elemento | vento |
| raridade | elite |
| status | aprovado |

**Descrição visual:**
> Figura imponente, corpo coberto por penas escuras e máscara de madeira com chifres. Segura um bastão de trovão. Olhos brilham com faíscas amarelas. Quando fala, o trovão ecoa.

**Origem no lore:**
> Entidade do trovão e da justiça, mensageiro de Tupã. Puni transgressores com relâmpagos e silêncio. Habita templos nas montanhas. É uma das poucas entidades que pode enfrentar diretamente os bosses de corrupção — serve como **teste final de sabedoria** antes da arena do boss, onde o jogador deve provar seu caráter, não apenas sua força.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 5 — Templo nas Nuvens (zona de transição final) |
| zona_tipo | avançada |
| periodo | ambos |
| ambiente_especifico | templo nas nuvens, montanha tempestuosa |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 25 |
| nivel_max | 30 |
| hp_max | 900 |
| ataque_base | 76 |
| tipo_dano | trovão / mágico |
| defesa_base | 36 |
| xp_recompensa | 450 |
| respawn_segundos | 150 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 22 |
| padrao_movimento | Fica estático no templo; quando aggro, chama relâmpagos e se move com velocidade moderada |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Raio Trovejante | ataque/área | 45 | Área de 8m: 120% do ataque base como dano de trovão + paralisa por 1.5s |
| Lei do Silêncio | debuff/CC | 50 | Silencia todos os jogadores num raio de 10m por 3s (impede uso de skills) |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_026 | Carta — Jurupari | especial | 0.5 | 450 |
| ITEM_027 | Bastão do Trovão | equipamento | 5.5 | 120 |
| ITEM_028 | Runa de Silêncio | consumível | 28.0 | 18 |
| ITEM_029 | Pena de Jurupari | comum | 55.0 | 10 |
| ITEM_030 | Fragmento de Máscara | comum | 40.0 | 4 |

### Itens especiais — descrição de efeitos

- **Carta — Jurupari:** Equipada concede "Voz do Trovão" — skills mágicas têm 10% de chance de silenciar o alvo por 1.5s e resistência a silêncio +15.
- **Bastão do Trovão:** Arma que adiciona dano de trovão +20 e chance de 8% de paralisar o alvo por 2s.

---

## Notas de Design

> Mob elite de zona avançada com skill de silêncio em área (Lei do Silêncio). Esta é a primeira skill de silence AoE do jogo — requer que o party tenha estratégias alternativas (itens consumíveis, positioning). Raio Trovejante dá dano burst + paralisia. Counter: Runa de Silêncio (drop) crafta item anti-silêncio, criando loop de preparação.

---
*Última atualização: 2026-06-07*
