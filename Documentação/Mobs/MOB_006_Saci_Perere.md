# MOB_006 — Saci Sombrio

## Identidade

| Campo | Valor |
|---|---|
| id | MOB_006 |
| nome | Saci Sombrio |
| tipo_elemento | vento corrompido |
| raridade | elite |
| status | aprovado |
| jogo | Yvyvuçu: Espíritos da Terra |

**Descrição visual:**
> Versão corrompida do famoso espírito travesso. Figura pequena (~1m), uma perna só, mas com o gorro agora escurecido e manchado de roxo — como se impregnado pela corrupção de Angá. A fumaça do cachimbo é negra e espirala em padrões sinistros. Movimenta-se em saltos rápidos, deixando rastro de vento sombrio e risada distorcida. Efeito de partículas: redemoinhos com faíscas escuras que corroem a vegetação ao redor.

**Origem no lore:**
> Antes, o Saci era um espírito travesso que divertia-se pregando peças inofensivas em viajantes. Mas a corrupção de Angá o transformou no **Saci Sombrio** — suas travessuras agora são perigosas, seus redemoinhos carregam ilusões que desorientam e enlouquecem. Habita clareiras de bambu e vilas abandonadas no Templo nas Nuvens, onde usa seu domínio sobre o vento para confundir e atacar os que se aproximam. Derrotá-lo e purificá-lo pode render ao jogador uma habilidade temporária de controle de redemoinho.

**Habitat:**
| Campo | Valor |
|---|---|
| mapa | Mapa 5 — Templo nas Nuvens (zona de transição final) |
| zona_tipo | avançada |
| periodo | ambos |
| ambiente_especifico | clareira de bambu, vila abandonada, ruínas do templo |

---

## Atributos de Combate

| Atributo | Valor |
|---|---|
| nivel_min | 25 |
| nivel_max | 30 |
| hp_max | 950 |
| ataque_base | 88 |
| tipo_dano | mágico / vento corrompido |
| defesa_base | 40 |
| xp_recompensa | 450 |
| respawn_segundos | 140 |

---

## Comportamento e IA

| Campo | Valor |
|---|---|
| comportamento | agressivo, evasivo |
| aggro_range_studs | 28 |
| padrao_movimento | Salta rapidamente entre pontos aleatórios, desaparece em redemoinho sombrio e reaparece atrás do jogador mais lento. Usa camuflagem de vento por 2s. Quando abaixo de 30% de HP, entra em frenesi — velocidade de movimento +50%, mas fica vulnerável por 4s após cada reaparecimento |

### Skills

| skill | tipo | cooldown_s | efeito |
|---|---|---|---|
| Redemoinho Sombrio | debuff/CC | 35 | Cria redemoinho corrompido que puxa todos os jogadores para o centro, causa dano contínuo (5% HP/s por 3s) e os confunde (inverte controles) |
| Sumiço Corrompido | buff/auto | 45 | Dura 4s: invisível e imune. Ao reaparecer, causa 10% do HP máximo do jogador mais próximo como dano verdadeiro + debuff "Vertigem" (reduz precisão em 30% por 5s) |
| Sopro de Ilusão | debuff | 22 | Lança nuvem de fumaça negra em cone à frente. Jogadores atingidos têm visão reduzida em 70% e perdem o mapa por 4s |
| Benção Falsa¹ | utilitária | 60 | Ao ser reduzido a <15% de HP, tenta "se render" — se o jogador parar de atacar, ele desaparece e reaparece atrás, usando Sumiço Corrompido imediatamente |

¹ *Mecânica de trapaça que referencia a natureza enganadora do Saci. Não é um ataque direto, mas um blefe estratégico.*

---

## Drops

| id_item | nome_item | tipo | drop_chance_pct | valor_npc_wira'i |
|---|---|---|---|---|
| ITEM_041 | Carta — Saci Sombrio | especial | 0.8 | 500 |
| ITEM_042 | Gorro Sombrio do Saci | equipamento | 6.5 | 120 |
| ITEM_043 | Fumo Corrompido | consumível | 25.0 | 18 |
| ITEM_044 | Folha de Tabaco | comum | 50.0 | 2 |
| ITEM_045 | Pó de Cinza Negra | comum | 35.0 | 5 |

### Itens especiais — descrição de efeitos

- **Carta — Saci Sombrio:** Equipada concede "Travessura Corrompida" — 18% de chance de anular um ataque recebido e 8% de chance de causar dano verdadeiro (5% do HP do alvo) no próximo ataque. Ao ser usada em combinação com itens de purificação, ativa o efeito "Redenção": transforma o Saci Sombrio em aliado temporário por 10 minutos.

- **Gorro Sombrio do Saci:** Headgear que aumenta AGI em +10 e concede "Sumiço" (invisibilidade por 1.8s) a cada 2.5 minutos. Enquanto equipado, o jogador deixa um rastro de vento visível para aliados (facilita coordenação de grupo).

- **Fumo Corrompido:** Consumível. Ao usar, o jogador cria um redemoinho que confunde inimigos num raio de 6 studs por 3s (cooldown 90s). Efeito único por jogador.

---

## Notas de Design

> O Saci Sombrio é um mob elite que testa a coordenação do grupo. O **Redemoinho Sombrio** força jogadores a se espalharem para minimizar dano em área. O **Sumiço Corrompido** exige que o tanque/aguerrido se posicione estrategicamente para absorver o burst de reaparecimento. A **Benção Falsa** é uma mecânica de "trapaça" que pune jogadores que agem por impulso — se o grupo parar de atacar ao ver o Saci "se render", ele contra-ataca com vantagem.

> Derrotá-lo e purificá-lo (via quest específica) permite que o jogador recupere o **Gorro Sombrio** e desbloqueie a habilidade temporária de **Controle de Redemoinho**, reforçando o tema de restauração do equilíbrio central ao jogo.

> HP ajustado para 950 (ligeiramente acima do baseline anterior) para refletir a natureza de elite corrompido. XP aumentada para 450, refletindo a dificuldade e importância narrativa.

---
*Última atualização: 2026-06-08 — Yvyvuçu: Espíritos da Terra*
