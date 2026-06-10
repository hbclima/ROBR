# Bible — Mecânicas do Jogo (mechanics.md)

> Este documento é a referência fixa para o agente ao criar ou revisar fichas de mobs.
> Última atualização: 2026-06-11 — APROVADO (Wira'i, Angá, nomenclatura)

---

## 1. Estrutura de Zonas e Níveis

| Mapa | Tipo | Nível recomendado |
|---|---|---|
| Mapa 1 (Ybirá-Puera) | inicial | 1–10 |
| Mapa 2 (Floresta de Mãe-da-Mata) | intermediária | 10–15 |
| Mapa 3 (Tavy-Katu) | clareira amaldiçoada | 15–20 |
| Mapa 4 (Tupã-Mbara) | campo dos ancestrais | 20–25 |
| Mapa 5 (Templo nas Nuvens) | templo nas alturas | 25–30 |
| Mapa 6 (Ygara-Mbya) | boss arena | 30 (Boss) / 27–30 |

---

## 2. Tiers de Raridade

| Raridade | Descrição |
|---|---|
| comum | Mob padrão, spawn abundante |
| incomum | Encontrado com menos frequência, mais HP/dano |
| raro | Spawn baixo, mecânicas diferenciadas |
| elite | Mini-boss de zona. HP no limite máximo do baseline |
| chefe | Boss de mapa |

---

## 3. Elementos

Os elementos definem resistências e fraquezas.

| Elemento | Fraco contra | Forte contra |
|---|---|---|
| fogo | água | terra, vento |
| água | terra | fogo |
| terra | vento | água |
| vento | fogo | terra |
| sombra | sagrado | neutro |
| sagrado | sombra | neutro |
| neutro | — | — |

---

## 4. Parâmetros de Balanceamento (referência MVP)

### HP por nível recomendado

| Nível | HP esperado |
|---|---|
| 1–5 | 50–150 |
| 6–10 | 150–300 |
| 11–15 | 300–450 |
| 16–20 | 450–600 |
| 21–25 | 600–900 |

### XP por nível recomendado

| Nível | XP esperado |
|---|---|
| 1–5 | 10–50 |
| 6–10 | 50–120 |
| 11–15 | 120–200 |
| 16–20 | 200–300 |
| 21–25 | 300–500 |

---

## 5. Drops — Convenções

- **comum:** chance 30–70%, valor NPC 1–10 Wira'i
- **consumível:** chance 10–30%, valor NPC 10–50 Wira'i
- **equipamento:** chance 2–10%, valor NPC 50–200 Wira'i
- **especial (carta):** chance 0.05–1%, valor NPC 200–500 Wira'i
- Cada mob deve ter ao menos 1 drop comum e no máximo 6 drops no total (MVP)
- **Cartas MVP:** drop rate fixo de 0.5%

---

## 6. IA e Comportamento

- **passivo:** só ataca se atacado primeiro. Usar em mobs de zona inicial.
- **agressivo:** ataca ao entrar no aggro range. Padrão para zonas intermediárias e avançadas.
- **aggro_range_studs padrão:** 12–15 studs (inicial), 18–25 studs (intermediária+). Mínimo: 12 studs.
- Skills: máximo de 3 skills por mob no MVP

---

## 7. IDs — Convenção de Numeração

| Prefixo | Uso |
|---|---|
| MOB_001+ | Mobs |
| ITEM_001+ | Itens de drop |
| NPC_001+ | NPCs |
| MAP_001+ | Mapas |

---

## 8. Campos obrigatórios em toda ficha

- id, nome, tipo_elemento, raridade, status
- nivel_min, nivel_max, hp_max, ataque_base, defesa_base, xp_recompensa, respawn_segundos
- comportamento, aggro_range_studs
- Pelo menos 1 drop preenchido
- Origem no lore (mínimo 2 frases)

---

## 9. Regras de Negócio MVP (validadas em 2026-06-07)

- **Boss MVP:** apenas 1 boss ativo (MOB_007 Boiúna). Demais bosses em HOLD para versão final.
- **Elites:** HP no limite máximo do baseline (não acima).
- **Cartas:** drop rate fixo de 0.5% para todas as cartas no MVP.
- **Aggro range:** mínimo 12 studs para todos os mobs.
- **Mobs neutros:** animais dos biomas brasileiros sem elemento mágico.
- **Versão final:** 2–5 tipos de mobs diferentes por mapa.
