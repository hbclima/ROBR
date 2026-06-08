# GDD — Fase 0.4: Árvore de Skills MVP

> Define a árvore de evolução de skills das 3 classes.
> Cada classe começa com 5 skills no nível 1 e ganha 1 skill point por nível para upar skills existentes ou desbloquear novas.
> Máximo de 6 skills ativas por classe.
> Critério de saída: árvore completa níveis 1–30 validada antes de avançar para Fase 1.

---

## Regras Gerais

- **Skills iniciais (nível 1):** 5 skills por classe (já definidas na Fase 0.2)
- **Máximo de skills:** 6 skills ativas por classe
- **Skill points:** 1 ponto por nível (30 pontos totais ao nível 30)
- **Usos do skill point:**
  - **Upar skill existente:** aumenta dano/efeito em +10% por ponto (máximo 5 upgrades por skill)
  - **Desbloquear skill nova:** custa 3 pontos (só disponível a partir do nível 10)
- **Tipos de skill:**
  - **Ataque:** Causa dano direto
  - **Buff:** Melhora stats do próprio jogador ou aliados
  - **Debuff:** Reduz stats do inimigo
  - **Controle:** Atordoa, puxa, empurra, silencia
  - **Cura:** Restaura HP/SP
  - **Passiva:** Efeito permanente sem ativação

---

## C1 — TEMBIRA (Guerreiro): Árvore de Skills

### Skills Disponíveis

| # | Skill | Tipo | Custo SP | Cooldown | Fórmula Base | Descrição | Desbloqueio |
|---|---|---|---|---|---|---|---|
| S1 | Tacape Ancestral | Ataque | 0 | 1.5s | ATK × 1.6 + STR | Golpe básico; 15% atordoar 1s | Nível 1 |
| S2 | Taunt da Floresta | Controle | 10 | 12s | — | Atrai aggro de inimigos em 5m por 4s | Nível 1 |
| S3 | Camuflagem de Selva | Buff | 15 | 20s | — | Invisível 5s; próximo ataque +50% dano | Nível 1 |
| S4 | Flecha Venenosa | Debuff | 8 | 8s | DEX × 1.2 + LUK | Veneno: 5% HP/3s por 9s + reduz AGI 20% | Nível 1 |
| S5 | Escudo Espiritual | Buff | 20 | 30s | VIT × 0.8 + nível × 5 | Barreira que absorve dano por 6s (raio 3m) | Nível 1 |
| S6 | Golpe Giratório | Ataque | 12 | 6s | ATK × 1.2 + STR × 0.5 | Ataque em área (raio 4m); atordoa 1s | Nível 10 (3 pts) |

### Upgrades (por skill point investido)

| Skill | Efeito por Upgrade | Máximo |
|---|---|---|
| Tacape Ancestral | +10% dano | 5 upgrades (+50%) |
| Taunt da Floresta | +1s de duração | 5 upgrades (+5s) |
| Camuflagem de Selva | +1s de invisibilidade | 5 upgrades (+5s) |
| Flecha Venenosa | +5% dano do veneno | 5 upgrades (+25%) |
| Escudo Espiritual | +15% absorção | 5 upgrades (+75%) |
| Golpe Giratório | +10% dano | 5 upgrades (+50%) |

### Build Recomendada (30 pontos)

| Skill | Pontos | Efeito Final |
|---|---|---|
| Tacape Ancestral | 5 | Dano +50% |
| Taunt da Floresta | 5 | Duração 9s |
| Escudo Espiritual | 5 | Absorção +75% |
| Camuflagem de Selva | 3 | Duração 8s |
| Flecha Venenosa | 3 | Veneno +15% |
| Golpe Giratório | 3 | Desbloqueado + dano base |
| **Total** | **24** | Sobram 6 pontos para flexibilidade |

---

## C2 — KARAÍ (Mago): Árvore de Skills

### Skills Disponíveis

| # | Skill | Tipo | Custo SP | Cooldown | Fórmula Base | Descrição | Desbloqueio |
|---|---|---|---|---|---|---|---|
| S1 | Chama de Yara | Ataque | 12 | 3s | INT × 2.0 + nível × 3 | Dano mágico; 20% chance burn 4s | Nível 1 |
| S2 | Invocação de Angá | Controle | 18 | 18s | — | Espírito auxiliar ataca por 8s (HP baixo, distrai) | Nível 1 |
| S3 | Maldição de Anhangá | Debuff | 15 | 15s | INT × 0.7 | Reduz dano do alvo 30% + vulnerável a mágico por 6s | Nível 1 |
| S4 | Visão Onírica | Buff | 10 | 25s | — | Revela inimigos ocultos (10m); previne 1 surpresa por 5s | Nível 1 |
| S5 | Ilusão da Floresta | Controle | 20 | 30s | — | Inimigos em 6m ficam confusos por 5s | Nível 1 |
| S6 | Tempestade de Yara | Ataque | 35 | 12s | INT × 3.0 + nível × 4 | Dano em área (raio 7m); 30% chance burn 6s | Nível 10 (3 pts) |

### Upgrades (por skill point investido)

| Skill | Efeito por Upgrade | Máximo |
|---|---|---|
| Chama de Yara | +10% dano | 5 upgrades (+50%) |
| Invocação de Angá | +2s de duração | 5 upgrades (+10s) |
| Maldição de Anhangá | +5% redução de dano | 5 upgrades (+25%) |
| Visão Onírica | +2m de raio | 5 upgrades (+10m) |
| Ilusão da Floresta | +1s de confusão | 5 upgrades (+5s) |
| Tempestade de Yara | +10% dano | 5 upgrades (+50%) |

### Build Recomendada (30 pontos)

| Skill | Pontos | Efeito Final |
|---|---|---|
| Chama de Yara | 5 | Dano +50% |
| Maldição de Anhangá | 5 | Redução +25% |
| Ilusão da Floresta | 5 | Duração 10s |
| Tempestade de Yara | 3 | Desbloqueado + dano base |
| Invocação de Angá | 3 | Duração 14s |
| Visão Onírica | 3 | Raio 16m |
| **Total** | **24** | Sobram 6 pontos para flexibilidade |

---

## C3 — PAYÉ (Clérigo): Árvore de Skills

### Skills Disponíveis

| # | Skill | Tipo | Custo SP | Cooldown | Fórmula Base | Descrição | Desbloqueio |
|---|---|---|---|---|---|---|---|
| S1 | Cura da Floresta | Cura | 12 | 2s | INT × 2.2 + nível × 4 | Cura 1 aliado; +20% em mata densa | Nível 1 |
| S2 | Bênção de Tupã | Buff | 18 | 25s | INT × 0.6 + nível × 2 | +25% resistência (física + mágica) por 10s (grupo) | Nível 1 |
| S3 | Exorcismo de Angá | Cura/Debuff | 15 | 20s | — | Remove 1 debuff de aliado; dano a espíritos invocados | Nível 1 |
| S4 | Canto dos Antepassados | Buff | 25 | 40s | — | Grupo recupera 5% HP/SP a cada 2s por 8s | Nível 1 |
| S5 | Água Sagrada de Iara | Cura | 10 | 10s | INT × 1.5 | Cura instantânea em área (3m) | Nível 1 |
| S6 | Ressurreição | Cura | 40 | 120s | — | Revive aliado morto com 30% HP (range 5m) | Nível 15 (3 pts) |

### Upgrades (por skill point investido)

| Skill | Efeito por Upgrade | Máximo |
|---|---|---|
| Cura da Floresta | +10% cura | 5 upgrades (+50%) |
| Bênção de Tupã | +5% resistência | 5 upgrades (+25%) |
| Exorcismo de Angá | +1s de redução de cooldown | 5 upgrades (-5s) |
| Canto dos Antepassados | +1s de duração | 5 upgrades (+5s) |
| Água Sagrada de Iara | +10% cura | 5 upgrades (+50%) |
| Ressurreição | +10% HP no revive | 5 upgrades (+50%) |

### Build Recomendada (30 pontos)

| Skill | Pontos | Efeito Final |
|---|---|---|
| Cura da Floresta | 5 | Cura +50% |
| Bênção de Tupã | 5 | Resistência +50% |
| Canto dos Antepassados | 5 | Duração 13s |
| Água Sagrada de Iara | 3 | Cura +30% |
| Exorcismo de Angá | 3 | Cooldown 17s |
| Ressurreição | 3 | Desbloqueado + 30% HP |
| **Total** | **24** | Sobram 6 pontos para flexibilidade |

---

## Tabela Resumo

| Classe | Skills Iniciais | Skill Nova | Total | Skill Points (nível 30) |
|---|---|---|---|---|
| Tembira | 5 | 1 (nível 10) | 6 | 30 |
| Karaí | 5 | 1 (nível 10) | 6 | 30 |
| Payé | 5 | 1 (nível 15) | 6 | 30 |

---

## Validação Cruzada

| Critério | Tembira | Karaí | Payé |
|---|---|---|---|
| Skill de dano principal? | ✅ Tacape Ancestral | ✅ Chama de Yara | ✅ (secundário) |
| Skill de controle/utility? | ✅ Taunt | ✅ Ilusão | ✅ Exorcismo |
| Skill de buff/defesa? | ✅ Escudo Espiritual | ✅ Visão Onírica | ✅ Bênção de Tupã |
| Skill de cura? | ❌ (não é papel) | ❌ (não é papel) | ✅ Cura da Floresta |
| Skill de área (AoE)? | ✅ Golpe Giratório | ✅ Tempestade de Yara | ✅ Água Sagrada |
| Skill de revive? | ❌ | ❌ | ✅ Ressurreição |
| Máximo 6 skills? | ✅ 6 | ✅ 6 | ✅ 6 |
| Escala com atributo principal? | ✅ STR/VIT | ✅ INT | ✅ INT/VIT |

---

*Última atualização: 2026-06-07*
