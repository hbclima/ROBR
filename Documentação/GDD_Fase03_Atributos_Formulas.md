# GDD — Fase 0.3: Sistema de Atributos e Fórmulas

> Define os 6 atributos base e todas as fórmulas de combate do MVP.
> Critério de saída: fórmulas validadas com 3 exemplos manuais antes de avançar.

---

## 1. Os 6 Atributos

| Atributo | Nome | Afeta |
|---|---|---|
| STR | Força | Dano físico, peso máximo de carga |
| AGI | Agilidade | Velocidade de ataque, esquiva (flee) |
| VIT | Vitalidade | HP máximo, defesa física, resistência a debuffs |
| INT | Inteligência | Dano mágico, SP máximo, defesa mágica |
| DEX | Destreza | Acerto (hit rate), velocidade de cast, dano com arco |
| LUK | Sorte | Chance de crítico (crit), drop rate, perfeição de hit |

---

## 2. Fórmulas de Combate

### 2.1 — Dano Físico (ATK)

```
ATK_final = ATK_base + (STR × 2) + (DEX × 0.5) + (LUK × 0.2)
```

**Onde:**
- `ATK_base` = ataque base do mob/jogador (do campo `ataque_base` na ficha)
- STR contribui mais (×2) — atributo primário para dano físico
- DEX contribui pouco (×0.5) — bônus secundário
- LUK contribui mínimo (×0.2) — sorte no golpe

**Dano final ao alvo:**
```
Dano = ATK_final - DEF_alvo
```
(Mínimo de 1 dano por hit)

### 2.2 — Dano Mágico (MATK)

```
MATK_final = MATK_base + (INT × 2.5) + (DEX × 0.3)
```

**Onde:**
- `MATK_base` = base mágico (para mobs: campo `ataque_base` quando `tipo_dano` é mágico)
- INT contribui mais (×2.5) — atributo primário para dano mágico
- DEX contribui pouco (×0.3) — precisão no feitiço

**Dano final ao alvo:**
```
Dano_mágico = MATK_final - MDEF_alvo
```
(Mínimo de 1 dano por hit)

### 2.3 — Defesa Física (DEF)

```
DEF_final = DEF_base + (VIT × 1.5) + (STR × 0.3)
```

### 2.4 — Defesa Mágica (MDEF)

```
MDEF_final = MDEF_base + (INT × 1.0) + (VIT × 0.5)
```

### 2.5 — Hit Rate (Acerto)

```
Hit_rate = 75 + (DEX × 1.5) + (nível × 0.5)
```

**Contra o alvo:**
```
Hit_final = Hit_rate - Flee_alvo
```
(Mínimo 5%, máximo 95%)

### 2.6 — Flee Rate (Esquiva)

```
Flee_rate = 10 + (AGI × 1.5) + (nível × 0.3)
```

**Contra o atacante:**
```
Flee_final = Flee_rate - Hit_atacante
```
(Mínimo 5%, máximo 95%)

### 2.7 — Critical Rate (Crítico)

```
Crit_rate = (LUK × 0.5) + 1
```
(Máximo 25% no MVP)

**Dano crítico:**
```
Dano_crit = Dano_normal × 1.5
```

### 2.8 — Velocidade de Ataque (ASPD)

```
ASPD = 200 - (AGI × 0.8) - (DEX × 0.2)
```
(Valores menores = mais rápido. Mínimo: 150)

### 2.9 — Velocidade de Cast (Cast Time)

```
Cast_reduction = (DEX × 0.4) + (INT × 0.2)
```
(Percentual de redução do cast time base da skill)

### 2.10 — HP Máximo

```
HP_max = HP_base_classe + (nível - 1) × ganho_HP + (VIT × 8)
```

### 2.11 — SP Máximo

```
SP_max = SP_base + (INT × 3)
Onde: SP_base = 50 + (nível - 1) × 6
```

---

## 3. Tabela de Valores Iniciais (Nível 1, sem equipamento)

| Atributo | Tembira (Tank) | Karaí (Mago) | Payé (Support) |
|---|---|---|---|
| STR | 5 | 1 | 1 |
| AGI | 2 | 2 | 2 |
| VIT | 9 | 3 | 7 |
| INT | 1 | 11 | 8 |
| DEX | 2 | 2 | 1 |
| LUK | 1 | 1 | 1 |
| **HP** | **372** | **174** | **256** |
| **SP** | **53** | **83** | **74** |
| **ATK** | **15** | **4** | **5** |
| **MATK** | **4** | **29** | **25** |
| **DEF** | **19** | **6** | **13** |
| **Hit** | **78** | **78** | **77** |
| **Flee** | **13** | **13** | **13** |

**Fórmulas usadas:**
- HP = HP_base + (VIT × 8) → Tembira: 300 + 72 = 372
- SP = 50 + (INT × 3) → Karaí: 50 + 33 = 83
- ATK = ATK_base + (STR × 2) + (DEX × 0.5) → Tembira: 0 + 10 + 1 = 11 (ATK_base ~4 para nível 1)
- MATK = MATK_base + (INT × 2.5) + (DEX × 0.3) → Karaí: 0 + 27.5 + 0.6 ≈ 29
- DEF = DEF_base + (VIT × 1.5) + (STR × 0.3) → Tembira: 4 + 13.5 + 1.5 ≈ 19
- Hit = 75 + (DEX × 1.5) + 0.5 → 75 + 3 + 0.5 ≈ 78
- Flee = 10 + (AGI × 1.5) + 0.3 → 10 + 3 + 0.3 ≈ 13

---

## 4. Validação com Exemplos

### Exemplo 1: Tembira (nível 1, VIT 9, STR 5) atacando Sapo Cururu (nível 1, HP 120, DEF 6)

```
ATK_Tembira = 4 + (5 × 2) + (2 × 0.5) + (1 × 0.2) = 15.2
Dano = 15.2 - 6 = 9.2 ≈ 9 por hit
Kills necessários: 120 / 9 = ~14 hits
ASPD ≈ 200 - (2 × 0.8) - (2 × 0.2) = 198 → ~1.5s entre hits
Tempo estimado: ~21 segundos para matar
```
✅ Ritmo adequado para mob inicial

### Exemplo 2: Karaí (nível 15, INT 30) usando Chama de Yara em Boitatá (nível 17, HP 520, MDEF ~25)

```
MATK_Karaí = 0 + (30 × 2.5) + (5 × 0.3) = 76.5
Skill_dano = 76.5 × 2.0 + (15 × 3) = 198
Dano_final = 198 - 25 = 173
Kills: 520 / 173 = ~3 hits
```
✅ 3 hits para matar mob intermediário é平衡 para mago com skill de 3s cooldown

### Exemplo 3: Party de 3 (nível 25) vs Boiúna (nível 30, HP 4200, DEF ~50)

```
Dano médio por hit (melee): ~40 - 50 = ~10 (mínimo 1)
Dano mágico (Karaí, MATK ~70): skill 140 - 50(MDEF) = ~90
Cura por tick (Payé): INT 25 × 2.2 + 25 × 4 = ~155 HP

Party DPS estimado: ~150/s (3 jogadores)
Tempo para matar: 4200 / 150 = ~28 segundos
Boiúna ATK ~135/s → precisa de healing constante
```
✅ Combate viável e desafiador com party de 3

---

## 5. Notas de Design
- **Mobs usam as mesmas fórmulas que jogadores** — os atributos dos mobs (STR, AGI, VIT, INT, DEX, LUK) são derivados dos valores de HP, ATK, DEF das fichas. Isso garante consistência e prepara para PvP futuro.
- **Distribuição de stat points: manual** — o jogador escolhe onde colocar os 3 pontos ganhos por nível.

- Expoentes e multiplicadores adaptados do RO original, simplificados para Luau
- Fórmulas inline — sem dependência de lookup tables
- Máximo de crítico em 25% para evitar RNG excessivo no MVP
- ASPD mínimo de 150 para evitar ataques instantâneos
- Hit/Flee clamping entre 5% e 95% para evitar imunidade total

---

*Última atualização: 2026-06-07*
