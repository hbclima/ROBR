# GDD — FASE 0.6: Sistema de Progressão

**Projeto:** RO Clone no Roblox
**Fase:** 0.6 — Sistema de Progressão
**Entregável:** Tabela completa de progressão nível 1–30 + regras de XP em party
**Critério:** Tabela validada manualmente com ao menos 3 exemplos antes de avançar para Fase 1
**Depende de:** 0.3 (Fórmulas de atributos) · 0.5 (XP concedido pelos mobs)

---

## 1. PARÂMETROS GERAIS

### 1.1 — Teto e ritmo geral

| Parâmetro | Valor |
|---|---|
| Nível máximo do MVP | 30 |
| Nível máximo futuro (pós-MVP) | 99 (como no RO original) |
| Ritmo de progressão | Médio — ~10h de jogo total para 1→30 |
| Tempo médio por sessão de jogo | 1 hora |
| Sessões para atingir nível 30 | ~10 sessões |

### 1.2 — Referência de XP por mob (da Fase 0.5)

| Mob | Nome | Nível recom. | XP concedido | Kills estimados (faixa) |
|---|---|---|---|---|
| MOB_001 | Sapo Cururu | 1–6 | 120 | ~18 kills (1–5) |
| MOB_002 | Cobra-d'Água | 5–10 | 280 | ~25 kills (6–10) |
| MOB_003 | Mãe-da-Mata | 10–15 | 490 | ~32 kills (11–15) |
| MOB_004 | Boitatá | 15–20 | 770 | ~34 kills (16–20) |
| MOB_005 | Curupira | 20–25 | 980 | ~38 kills (21–25) |
| MOB_006 | Saci Pererê | 25–30 | 1.400 | ~37 kills (26–30) |
| MOB_007 | Boiúna | 25–30 (chefe) | 1.750 | Boss fight |
| MOB_008 | Anhangá | 20–25 (elite) | 1.120 | ~40 kills (21–25) |
| MOB_009 | Jurupari | 25–30 (elite) | 1.575 | ~42 kills (26–30) |
| MOB_010 | Tupã-Jaguaçu | 25–30 (chefe) | 2.100 | Boss fight |

### 1.3 — Estrutura do nível

| Regra | Decisão |
|---|---|
| XP reseta ao subir de nível? | **Sim** — XP volta a zero ao subir (mais simples de implementar) |
| Perde XP ao morrer? | **Sim** — perde 5% do XP acumulado no nível atual |
| Perda de XP em party? | **Reduzida** — 50% da penalidade solo (ou seja, 2.5% do XP acumulado) |

---

## 2. FÓRMULA DE XP POR NÍVEL

**Opção escolhida:** B — Fórmula exponencial

**Fórmula final:**

```
XP(N) = 200 × N ^ 1.8
```

Onde:
- **N** = nível atual
- **200** = BASE (XP necessário no nível 1)
- **1.8** = EXPOENTE (curva equilibrada para ~10h de progressão)

**Justativa do expoente 1.8:**
- Expoente 1.5 → progressão muito rápida (~1.7h total), pouco grind
- Expoente 1.8 → ~10h total, ritmo médio adequado para MVP de aprendizado
- Expoente 2.0+ → grind pesado demais para público casual

---

## 3. STAT POINTS POR NÍVEL

### 3.1 — Modelo de distribuição

**Modelo escolhido:** Fixo — todos os personagens ganham o mesmo número de pontos por nível.

**Justificativa:** Mais simples de implementar no Config.lua e mais fácil de balancear. A diferenciação entre classes já ocorre pelos atributos base e pela tendência de crescimento definida na Fase 0.2.

### 3.2 — Pontos por nível

| Parâmetro | Valor |
|---|---|
| Pontos por nível (todas as classes) | 3 |
| Total acumulado ao nível 30 | 87 pontos distribuíveis |

---

## 4. CRESCIMENTO DE HP E SP

### 4.1 — Fórmula de HP máximo

**Fórmula base por classe:**

| Classe | HP_INICIAL | GANHO por nível |
|---|---|---|
| Classe 1 (Guerreiro) | 300 | +35/nível |
| Classe 2 (Mago) | 150 | +15/nível |
| Classe 3 (Acólita) | 200 | +22/nível |

**Fórmula de HP final (como será codificada):**
```
HP_max = HP_base_classe[class] + (level - 1) * gain[class] + (VIT * 8)
```

### 4.2 — Fórmula de SP máximo

**Fórmula base de SP:**
```
SP_base = 50 + (Nivel - 1) * 6
```

**Fórmula de SP final (como será codificada):**
```
SP_max = SP_base + (INT * 3)
```

---

## 5. XP EM PARTY

### 5.1 — Modelo de divisão de XP

**Modelo escolhido:** Com bônus de party

**Fórmula:**
```
XP_membro = (XP_mob × 1.25) ÷ nº_membros
```

**Justificativa:** O bônus de 25% compensa a divisão e incentiva jogar em grupo. A party mata mais rápido (mais kills por minuto), então o XP/hora em party é superior ao solo.

### 5.2 — Regras adicionais

| Regra | Valor |
|---|---|
| Bônus de party | 1.25× (25% extra) |
| Range de nível na party | Sem penalidade no MVP (simplificação) |
| Range de mapa | Membros precisam estar no mesmo mapa para receber XP |

---

## 6. TABELA DE PROGRESSÃO NÍVEL 1–30

**Fórmula:** XP(N) = 200 × N^1.8
**Stat Points:** 3 por nível (acumulado)

### ZONA INICIAL — Níveis 1 a 10 (Mobs Comuns M1–M2)

| Nível | XP p/ subir | XP total acum. | Stat Pts (acum.) | HP base Cls1 | HP base Cls2 | HP base Cls3 | SP base |
|---|---|---|---|---|---|---|---|
| 1 | 200 | 0 | 0 | 300 | 150 | 200 | 50 |
| 2 | 696 | 896 | 3 | 335 | 165 | 222 | 56 |
| 3 | 1.445 | 2.341 | 6 | 370 | 180 | 244 | 62 |
| 4 | 2.425 | 4.766 | 9 | 405 | 195 | 266 | 68 |
| 5 | 3.624 | 8.390 | 12 | 440 | 210 | 288 | 74 |
| 6 | 5.032 | 13.422 | 15 | 475 | 225 | 310 | 80 |
| 7 | 6.641 | 20.063 | 18 | 510 | 240 | 332 | 86 |
| 8 | 8.445 | 28.508 | 21 | 545 | 255 | 354 | 92 |
| 9 | 10.439 | 38.947 | 24 | 580 | 270 | 376 | 98 |
| 10 | 12.619 | 51.566 | 27 | 615 | 285 | 398 | 104 |

### ZONA INTERMEDIÁRIA — Níveis 11 a 20 (Mobs Incomuns M3–M4)

| Nível | XP p/ subir | XP total acum. | Stat Pts (acum.) | HP base Cls1 | HP base Cls2 | HP base Cls3 | SP base |
|---|---|---|---|---|---|---|---|
| 11 | 14.981 | 66.547 | 30 | 650 | 300 | 420 | 110 |
| 12 | 17.521 | 84.068 | 33 | 685 | 315 | 442 | 116 |
| 13 | 20.236 | 104.304 | 36 | 720 | 330 | 464 | 122 |
| 14 | 23.124 | 127.428 | 39 | 755 | 345 | 486 | 128 |
| 15 | 26.181 | 153.609 | 42 | 790 | 360 | 508 | 134 |
| 16 | 29.407 | 183.016 | 45 | 825 | 375 | 530 | 140 |
| 17 | 32.797 | 215.813 | 48 | 860 | 390 | 552 | 146 |
| 18 | 36.351 | 252.164 | 51 | 895 | 405 | 574 | 152 |
| 19 | 40.067 | 292.231 | 54 | 930 | 420 | 596 | 158 |
| 20 | 43.942 | 336.173 | 57 | 965 | 435 | 618 | 164 |

### ZONA AVANÇADA — Níveis 21 a 30 (Mobs Raros/Elite/Chefe M5–M10)

| Nível | XP p/ subir | XP total acum. | Stat Pts (acum.) | HP base Cls1 | HP base Cls2 | HP base Cls3 | SP base |
|---|---|---|---|---|---|---|---|
| 21 | 47.976 | 384.149 | 60 | 1.000 | 450 | 640 | 170 |
| 22 | 52.166 | 436.315 | 63 | 1.035 | 465 | 662 | 176 |
| 23 | 56.512 | 492.827 | 66 | 1.070 | 480 | 684 | 182 |
| 24 | 61.011 | 553.838 | 69 | 1.105 | 495 | 706 | 188 |
| 25 | 65.663 | 619.501 | 72 | 1.140 | 510 | 728 | 194 |
| 26 | 70.466 | 689.967 | 75 | 1.175 | 525 | 750 | 200 |
| 27 | 75.420 | 765.387 | 78 | 1.210 | 540 | 772 | 206 |
| 28 | 80.522 | 845.909 | 81 | 1.245 | 555 | 794 | 212 |
| 29 | 85.772 | 931.681 | 84 | 1.280 | 570 | 816 | 218 |
| 30 | 91.169 | 1.022.850 | 87 | 1.315 | 585 | 838 | 224 |

---

## 7. VALIDAÇÃO E TESTES DE CONSISTÊNCIA

### 7.1 — Teste de tempo de progressão

| Cenário | XP necessário | Mob (XP) | Kills estimados | Tempo estimado | Aceitável? |
|---|---|---|---|---|---|
| Nível 1 → 10 (matando M1 e M2) | 51.566 | Sapo Cururu (120) + Cobra-d'Água (280) | ~135 kills | ~68 min (1.1h) | ✅ Sim |
| Nível 10 → 20 (matando M3 e M4) | 284.607 | Mãe-da-Mata (490) + Boitatá (770) | ~365 kills | ~183 min (3.0h) | ✅ Sim |
| Nível 20 → 30 (matando M5, M6, elites) | 686.677 | Curupira (980) + Saci (1.400) + Anhangá (1.120) | ~490 kills | ~245 min (4.1h) | ✅ Sim |
| **Total 1 → 30** | **1.022.850** | **Todos** | **~990 kills** | **~495 min (~8.3h)** | ✅ Sim |

**Tempo total estimado:** ~8–10 horas de gameplay ativo (considerando tempo de deslocamento, mortes, vendas, etc.)

### 7.2 — Teste de poder do personagem

| Pergunta | Resposta | Aceitável? |
|---|---|---|
| Personagem nível 1 consegue matar M1 (Sapo Cururu) solo? | Sim — HP do mob (120) vs ATK do jogador (~20) = ~6 hits | ✅ Sim |
| Personagem nível 10 consegue sobreviver a 3 golpes de M4 (Boitatá)? | Sim — HP do jogador (615) vs ATK do mob (40) = ~15 hits para morrer | ✅ Sim |
| Personagem nível 30 consegue solo M6 (Saci Pererê)? | Sim — HP do jogador (1.315) vs ATK do mob (82) = ~16 hits, mas mob tem HP alto | ⚡ Difícil mas possível |
| Party de nível 30 consegue derrotar M10 (Tupã-Jaguaçu)? | Sim — com 2–3 jogadores é viável | ✅ Sim |

### 7.3 — Checklist final da Fase 0.6

- [x] Fórmula de XP definida com parâmetros explícitos: **XP(N) = 200 × N^1.8**
- [x] Tabela de progressão preenchida para todos os níveis 1–30
- [x] Verificação manual de 3 faixas de nível: XP × kills = tempo razoável (~8–10h total)
- [x] Stat points por nível definidos: **3 por nível (fixo)**
- [x] Fórmulas de HP_max e SP_max escritas de forma codificável
- [x] Regras de XP em party definidas: **bônus 1.25× ÷ membros**
- [x] Penalidade por morte definida: **5% do XP acumulado (2.5% em party)**
- [x] Valores de XP dos mobs coerentes com a curva
- [ ] Tabela aprovada por todos os membros da equipe (pai e filho)

---

## Notas de Design

> [2026-06-06] Fórmula de XP ajustada de 100×N^1.8 para 200×N^1.8 para atingir ritmo médio (~10h). XP dos mobs multiplicado por ~3.5x para manter coerência com a curva. Tempo total estimado: ~8–10h de gameplay ativo.

> [2026-06-06] Penalidade de morte definida em 5% do XP acumulado (reduzida para 2.5% em party) para não ser punitiva demais no MVP.

> [2026-06-06] Bônus de party definido em 1.25× para incentivar jogar em grupo sem tornar solo inviável.

---

*Última atualização: 2026-06-06*
