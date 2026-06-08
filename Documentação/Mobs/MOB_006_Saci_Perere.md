# MOB_006 — Saci Sombrio

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_006 |
| nome | Saci Sombrio |
| tipo_elemento | vento |
| raridade | elite |
| status | aprovado |

**Descrição visual:**
> Figura pequena (~1m), uma perna só, gorro vermelho brilhante, cachimbo na boca. Movimenta-se em saltos rápidos, cria redemoinhos de vento ao desaparecer. Som de ventania e risada travessa. Estilo Roblox: baixa estatura, efeito de partículas de vento, som ambiente.

**Origem no lore:**
> Versão corrompida do famoso espírito travesso. Seu redemoinho agora é envenenado pela corrupção de Angá, e suas travessuras se tornaram perigosas. Ataca viajantes com ventos cortantes e ilusões que desorientam. Pode ser derrotado e, ao ser purificado, oferece ao jogador uma habilidade temporária (controle de redemoinho).

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 5 — Templo nas Nuvens (zona de transição final) |
| zona_tipo | avançada |
| periodo | ambos |
| ambiente_especifico | clareira de bambu, vila abandonada |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 25 |
| nivel_max | 30 |
| hp_max | 900 |
| ataque_base | 82 |
| tipo_dano | mágico / vento |
| defesa_base | 38 |
| xp_recompensa | 400 |
| respawn_segundos | 140 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 24 |
| padrao_movimento | Salta rapidamente entre pontos aleatórios, desaparece em redemoinho e reaparece atrás do jogador mais lento. Usa camuflagem de vento por 2s |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Redemoinho Travesso | debuff/CC | 35 | Cria redemoinho que puxa todos os jogadores para o centro e os confunde por 2.5s (inverte controles) |
| Sumiço Mágico | buff/auto | 45 | Dura 4s: invisível e imune a todos os ataques. Ao reaparecer, causa 8% do HP máximo do jogador mais próximo como dano verdadeiro |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_041 | Carta — Saci Sombrio | especial | 0.5 | 420 |
| ITEM_042 | Gorro Vermelho do Saci | equipamento | 5.0 | 95 |
| ITEM_043 | Fumo de Cachimbo | consumível | 22.0 | 14 |
| ITEM_044 | Folha de Tabaco | comum | 50.0 | 2 |
| ITEM_045 | Pó de Carvão | comum | 30.0 | 4 |

### Itens especiais — descrição de efeitos

- **Carta — Saci Sombrio:** Equipada concede "Travessura" — 15% de chance de anular um ataque recebido (esquiva especial) e 5% de chance de duplicar o dano do próximo ataque.
- **Gorro Vermelho do Saci:** Headgear que aumenta AGI em +8 e concede "Sumiço" (invisibilidade por 1.5s) a cada 3 minutos.

---

## Notas de Design

> Mob elite de zona avançada com mecânica de CC em grupo (Redemoinho Travesso puxa + inverte controles). Sumiço Mágico dá burst de dano verdadeiro ao reaparecer — jogadores precisam se espalhar para minimizar dano. HP 1100 é alto para o nível (baseline 600-900) mas justificado pela raridade elite. Contra: Gorro Vermelho do Saci é recompensa que beneficia builds de AGI/esquiva.

---
*Última atualização: 2026-06-07*
