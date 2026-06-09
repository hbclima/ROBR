# MOB_013 — Corpo Seco

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_013 |
| nome | Corpo Seco |
| tipo_elemento | sombra |
| raridade | raro |
| status | aprovado |

**Descrição visual:**
> Figura humanóide esquelética, pele seca e retada sobre os ossos, olhos fundos com brilho fantasmagórico. Move-se com passos rígidos e estalados. Desaparece e reaparece em locais próximos. Exala aura de frio e mau cheiro de terra de cemitério. Som de ossos estalando a cada movimento.

**Origem no lore:**
> Pessoa que cometeu pecado imperdão em vida. Após a morte, não é aceito nem pelos céus nem pelo submundo — a terra rejeita o corpo. O cadáver seco sai do túmulo e vaga à noite. Na Lore de Yvyvuçu, é uma manifestação visível da corrupção de Angá sobre almas pecadoras — a maldição torna visível o pecado da alma.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 2 — Floresta de Mãe-da-Mata (zona intermediária) |
| zona_tipo | intermediária |
| periodo | noite |
| ambiente_especifico | cemitérios, estradas rurais, áreas de enterro |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 10 |
| nivel_max | 14 |
| hp_max | 320 |
| ataque_base | 38 |
| tipo_dano | sombra |
| defesa_base | 14 |
| xp_recompensa | 150 |
| respawn_segundos | 200 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo |
| aggro_range_studs | 15 |
| padrao_movimento | Aparece atrás do jogador mais distante, ataca e desaparece. Reaparece em outro ponto. Movimento errático e imprevisível |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Aparição Assustadora | debuff/medo | 30 | Teleporta-se atrás de 1 jogador: causa medo por 2.5s + 80% do ataque base como dano sombra |
| Toque da Maldição | debuff/curse | 35 | Toque no alvo mais próximo: reduz cura recebida em 30% e ATK em 15% por 8s |
| Desaparecimento | buff/auto | 20 | Fica invisível por 3s, próximo ataque causa +50% de dano (ambush) |

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_wirai |
|---|---|---|---|---|
| ITEM_061 | Carta — Corpo Seco | especial | 0.5 | 320 |
| ITEM_062 | Ossos Amaldiçoados | equipamento | 4.5 | 70 |
| ITEM_063 | Promessa Quebrada | consumível | 22.0 | 10 |
| ITEM_064 | Pele Seca | comum | 48.0 | 4 |
| ITEM_065 | Terra de Cemitério | comum | 52.0 | 2 |

### Itens especiais — descrição de efeitos

- **Carta — Corpo Seco:** Equipada concede "Maldição do Esqueleto" — ataques têm 8% de chance de reduzir a cura recebida pelo alvo em 20% por 6s e resistência a medo +15.
- **Ossos Amaldiçoados:** Acessório que concede invisibilidade por 2s ao receber dano fatal (cooldown 5min) e +4 VIT.

---

## Notas de Design

> Mob raro de zona intermediária com mecânica de teleporte e medo. Aparição Assustadora é teleporte + medo + dano burst — requer que jogadores mantenham distância e estejam atentos ao posicionamento. Toque da Maldição cria debuff anti-cura que força tanks a gerenciar recursos. Desaparecimento dá mecânica de ambush — recompensa jogadores atentos que antecipam o reaparecimento. Ossos Amaldiçoadores dá efeito de "segunda chance" ao jogador.

---
*Última atualização: 2026-06-11 — Yvyvuçu: Espíritos da Terra*
