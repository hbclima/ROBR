# MOB_016 — Jacaré-Açu

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_016 |
| nome | Jacaré-Açu |
| tipo_elemento | neutro |
| raridade | raro |
| status | aprovado |

**Descrição visual:**
> Réptil colossal de 4,5m, escamas negras com reflexos escuros, olhos amarelos protuberantes. Mandíbula massiva com dentes visíveis. Permanece quase totalmente submerso, apenas olhos e narinas acima da água. Estilo Roblox: corpo longo e baixo, animação de flutuação, splash ao emergir.

**Origem no lore:**
> Maior predador aquático da América do Sul, senhor das águas amazônicas. Pode chegar a 5,5m e pesar meia tonelada. Para os povos ribeirinhos, o jacaré-açu é o dono do rio — respeitado e temido. Sua mordida é a segunda mais forte do reino animal. Fica imóvel por horas, atacando com velocidade explosiva quando a presa se aproxima.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 3 — Zona Intermediária Avançada |
| zona_tipo | intermediária_avançada |
| periodo | ambos |
| ambiente_especifico | rios, lagos e igarapés de água escura |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 16 |
| nivel_max | 20 |
| hp_max | 600 |
| ataque_base | 48 |
| tipo_dano | físico |
| defesa_base | 30 |
| xp_recompensa | 230 |
| respawn_segundos | 150 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 18 |
| padrao_movimento | Permanece submerso e imóvel. Quando jogador entra na água ou se aproxima da margem, emerge com ataque explosivo. Persegue curtas distâncias |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Ataque de Emboscada | ataque/surprise | 30 | Emerge da água: 140% do ataque base + derruba por 2s. Só ativa se jogador estiver na água ou a até 4m da margem |
| Morde e Arrasta | ataque/debuff | 40 | Mordida no alvo: 100% do ataque base + arrasta o jogador para a água (zona de perigo) por 3s |
| Casco Resistente | buff/auto | 50 | Dura 6s: reduz todo dano recebido em 35% (escamas endurecidas) |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_guarani |
|---|---|---|---|---|
| ITEM_075 | Pele de Jacaré | especial | 0.5 | 380 |
| ITEM_076 | Dente de Jacaré | equipamento | 4.5 | 85 |
| ITEM_077 | Músculo de Jacaré | consumível | 18.0 | 14 |
| ITEM_078 | Escama Negra | comum | 42.0 | 5 |
| ITEM_079 | Gordura de Jacaré | comum | 35.0 | 3 |

### Itens especiais — descrição de efeitos

- **Pele de Jacaré:** Equipada concede "Couraça do Rio" — defesa +20, resistência a dano de água +15%, e imunidade ao efeito de "arrasto para água" de mobs.
- **Dente de Jacaré:** Arma que adiciona dano físico +18 e 10% de chance de causar sangramento (3% HP por 5s).

---

## Notas de Design

> Mob raro de zona intermediária avançada com mecânica de emboscada aquática. Ataque de Emboscada só funciona perto da água — jogadores em terra ficam seguros. Morde e Arrasta é a skill mais perigosa: leva o jogador para zona de perigo aquática onde o jacaré é mais forte. Casco Resistente dá janela de defesa — jogadores devem esperar o buff acabar. Pele de Jacaré é item anti-contra aquático, preparação para futuras zonas de água.

---
*Última atualização: 2026-06-07*
