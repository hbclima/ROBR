# GDD — Fase 0.2: Definição de Classes MVP

> Template de preenchimento — 3 classes + 1 slot vazio para expansão.
> Critério de saída: ficha das 3 classes aprovadas antes de iniciar Fase 1.

---

## Regra de Ouro do MVP

Com 3 classes, o grupo mínimo deve ser auto-suficiente:
- **1 Tank** (absorve dano, mantém aggro)
- **1 DPS** (elimina inimigos)
- **1 Support** (cura/buffs)

Se as 3 fichas não cobrirem esses 3 papéis, revise antes de avançar.

---

## Ordem de Preenchimento

1. **Identidade** — Nome, arquétipo e papel no grupo. Define tudo o mais.
2. **Atributos Base** — 6 valores iniciais (nível 1). Total recomendado: 60–80 pontos.
3. **Crescimento por Nível** — Tendência de distribuição de stat points.
4. **Papel em Party** — Primário e secundário.
5. **Skills** — 3 a 5 skills. Priorize skills que reforçam o papel em party.
6. **Dependência entre Classes** — Como complementa as outras.
7. **Progressão Futura** — Evolução pós-MVP (esboço).
8. **Validação** — Checklist individual + validação cruzada.

---

## C1 — CLASSE 1: TEMBIRA (Guerreiro)

### 1. Identidade

| Campo | Valor |
|---|---|
| nome | Tembira (Guerreiro) |
| arquétipo | Guerreiro corpo-a-corpo, protetor da tribo |
| dificuldade | Médio |
| descrição | O guerreiro da selva, mestre do tacape e da flecha envenenada. Protege seus aliados com bravura e conhecimento ancestral do terreno. |
| estilo_de_combate | Corpo-a-corpo agressivo com momentos de suporte defensivo. Usa emboscadas, camuflagem e venenos. Joga na linha de frente, atraindo aggro e protegendo o grupo. |

### 2. Atributos Base (Nível 1)

| Atributo | Valor | Descrição |
|---|---|---|
| STR | 5 | Força física / dano corpo-a-corpo |
| AGI | 2 | Velocidade de ataque e fuga |
| VIT | 9 | Vitalidade / HP máximo |
| INT | 1 | Inteligência / dano mágico e SP |
| DEX | 2 | Destreza / acerto e cast |
| LUK | 1 | Sorte / crit e drop rate |
| **Total** | **20** | |
| **Principal** | **VIT (9)** | Define o papel de tanque/linha de frente |
| **Secundário** | **STR (5)** | Garante dano corpo-a-corpo relevante |

### 3. Tendência de Crescimento por Nível

| Atributo | Prioridade | Justificativa |
|---|---|---|
| STR | Alta | Dano corpo-a-corpo é a segunda função; precisa escalar para manter relevância ofensiva |
| AGI | Média | Ajuda na esquiva e velocidade de ataque, mas não é essencial |
| VIT | Alta | É o pilar da classe — quanto mais HP e resistência, melhor o tank |
| INT | Ignorar | Não usa magia; sem utilidade |
| DEX | Média | Melhora acerto e uso de arco/flecha; útil mas não prioritário |
| LUK | Baixa | Sorte é secundária; pode ser ignorada no build principal |

### 4. Papel em Party

| Papel | Primário? | Observação |
|---|---|---|
| Tank | ✅ Sim | Absorve dano, mantém aggro com Taunt, protege aliados |
| DPS | ❌ Não | Dano aceitável, mas não é o foco principal |
| Support | ❌ Não | Tem buffs defensivos leves, mas não cura |
| Utility | ✅ Sim | Camuflagem, controle de área, venenos |

**Dependência:** Precisa do Payé para cura sustentada e do Karaí para controle de grupos e dano mágico contra inimigos resistentes.

**O que oferece ao grupo:** É o único que pode segurar o aggro na linha de frente e proteger aliados com escudo espiritual.

### 5. Skills (5)

| Skill | Custo SP | Cooldown | Tipo | Fórmula / Efeito | Descrição |
|---|---|---|---|---|---|
| Tacape Ancestral | 0 | 1.5s | Dano | ATK × 1.6 + STR | Golpe corpo-a-corpo básico com chance de atordoar por 1s (15%) |
| Taunt da Floresta | 10 | 12s | Controle | — | Atrai o aggro de todos os inimigos num raio de 5m por 4s |
| Camuflagem de Selva | 15 | 20s | Buff | — | Fica invisível por 5s; próximo ataque após sair causa +50% dano |
| Flecha Venenosa | 8 | 8s | Debuff | DEX × 1.2 + LUK | Flecha com veneno de timbó; dano contínuo (5% HP/3s por 9s) + reduz AGI em 20% |
| Escudo Espiritual | 20 | 30s | Buff | VIT × 0.8 + nível × 5 | Barreira que absorve X de dano por 6s para Tembira e aliados num raio de 3m |

**Skill Icônica:** Taunt da Floresta — define o papel de tank.

### 6. Progressão Futura

| Nível | Evolução | Foco |
|---|---|---|
| 15 | Tembira-Chefe | Liderança e buffs para o grupo |
| 30 | Tembira-Tupã | Guerreiro abençoado por Tupã, poderes de trovão e escudo divino |

### 7. Notas

- **Visual:** tacape decorado com penas, pintura corporal, escudo de casca de árvore
- **Risco:** se o jogador focar só em STR e ignorar VIT, perde o papel de tank
- **Arma secundária:** arco para situações de emboscada

### 8. Validação

- ✅ Papel em party claramente definido
- ✅ Atributos base fazem sentido para o papel
- ✅ Pelo menos 1 skill que define o papel (Taunt)
- ✅ Descrição compreensível
- ✅ Tendência de crescimento preenchida
- ✅ Progressão futura esboçada

---

## C2 — CLASSE 2: KARAÍ (Mago / Feiticeiro)

### 1. Identidade

| Campo | Valor |
|---|---|
| nome | Karaí |
| arquétipo | Mago/feiticeiro espiritual, manipulador de espíritos |
| dificuldade | Médio |
| descrição | O feiticeiro que conversa com os espíritos e domina as forças ocultas da floresta. Lança maldições, invoca entidades e controla o campo de batalha com ilusões. |
| estilo_de_combate | À distância reativo. Usa feitiços verbais, maracá e fumaça. Foca em controle de área, debuffs e dano mágico escalável. Evita combate corpo-a-corpo. |

### 2. Atributos Base (Nível 1)

| Atributo | Valor | Descrição |
|---|---|---|
| STR | 1 | Força física / dano corpo-a-corpo |
| AGI | 2 | Velocidade de ataque e fuga |
| VIT | 3 | Vitalidade / HP máximo |
| INT | 11 | Inteligência / dano mágico e SP |
| DEX | 2 | Destreza / acerto e cast |
| LUK | 1 | Sorte / crit e drop rate |
| **Total** | **20** | |
| **Principal** | **INT (11)** | Define o poder mágico e SP |
| **Secundário** | **DEX (2)** | Melhora acerto de feitiços e uso de maracá |

### 3. Tendência de Crescimento por Nível

| Atributo | Prioridade | Justificativa |
|---|---|---|
| STR | Ignorar | Irrelevante para feitiços |
| AGI | Média | Ajuda na esquiva e velocidade de cast; útil para sobrevivência |
| VIT | Média | Precisa de HP mínimo para não morrer fácil, mas não é tanque |
| INT | Alta | É o coração da classe — escala dano, SP e eficácia de controle |
| DEX | Média | Melhora acerto de feitiços e reduz chance de interrupção |
| LUK | Baixa | Pode ser ignorada no build principal |

### 4. Papel em Party

| Papel | Primário? | Observação |
|---|---|---|
| Tank | ❌ Não | Pouca resistência física |
| DPS | ✅ Sim | Dano mágico alto, especialmente contra inimigos vulneráveis a espíritos |
| Support | ❌ Não | Não cura, mas pode dar buffs mágicos leves |
| Utility | ✅ Sim | Controle de área, debuffs, ilusões, invocação |

**Dependência:** Precisa do Tembira para segurar o aggro e protegê-lo enquanto canaliza feitiços; precisa do Payé para cura.

**O que oferece ao grupo:** É o único que pode lidar com inimigos espirituais, quebrar resistências e controlar múltiplos alvos.

### 5. Skills (5)

| Skill | Custo SP | Cooldown | Tipo | Fórmula / Efeito | Descrição |
|---|---|---|---|---|---|
| Chama de Yara | 12 | 3s | Dano | INT × 2.0 + nível × 3 | Chama azulada que causa dano mágico; 20% de chance de queimar por 4s |
| Invocação de Angá | 18 | 18s | Controle | — | Invoca espírito auxiliar que ataca o inimigo mais próximo por 8s |
| Maldição de Anhangá | 15 | 15s | Debuff | INT × 0.7 | Reduz dano do alvo em 30% e o torna vulnerável a dano mágico por 6s |
| Visão Onírica | 10 | 25s | Buff | — | Revela inimigos ocultos num raio de 10m; previne 1 ataque surpresa por 5s |
| Ilusão da Floresta | 20 | 30s | Controle | — | Todos os inimigos num raio de 6m ficam confusos por 5s |

**Skill Icônica:** Maldição de Anhangá — define o papel de controlador e debuffer espiritual.

### 6. Progressão Futura

| Nível | Evolução | Foco |
|---|---|---|
| 15 | Karaí-Mor | Invocação e feitiços de área |
| 30 | Karaí-Tupã | Mestre dos elementos, acesso a trovões e tempestades |

### 7. Notas

- **Visual:** maracá, penas, cocar, fumaça de tabaco, runas pintadas no corpo
- **Risco:** frágil em combate corpo-a-corpo; precisa de posicionamento cuidadoso
- **Mecânica:** feitiços são "cantados" — animações longas que podem ser interrompidas se atacado

### 8. Validação

- ✅ Papel em party claramente definido
- ✅ Atributos base fazem sentido para o papel
- ✅ Pelo menos 1 skill que define o papel (Maldição)
- ✅ Descrição compreensível
- ✅ Tendência de crescimento preenchida
- ✅ Progressão futura esboçada

---

## C3 — CLASSE 3: PAYÉ (Clérigo / Pajé)

### 1. Identidade

| Campo | Valor |
|---|---|
| nome | Payé |
| arquétipo | Curandeiro espiritual, sacerdote/pajé |
| dificuldade | Fácil |
| descrição | O pajé que canaliza as bênçãos de Tupã e dos ancestrais. Cura feridas, exorciza espíritos malignos e protege a tribo com rituais sagrados. |
| estilo_de_combate | Suporte reativo. Atua atrás da linha de frente, curando e protegendo. Usa cantos, ervas e rituais. Tem poderes defensivos e de purificação. |

### 2. Atributos Base (Nível 1)

| Atributo | Valor | Descrição |
|---|---|---|
| STR | 1 | Força física / dano corpo-a-corpo |
| AGI | 2 | Velocidade de ataque e fuga |
| VIT | 7 | Vitalidade / HP máximo |
| INT | 8 | Inteligência / dano mágico e SP |
| DEX | 1 | Destreza / acerto e cast |
| LUK | 1 | Sorte / crit e drop rate |
| **Total** | **20** | |
| **Principal** | **INT (8)** | Define poder de cura e eficácia dos rituais |
| **Secundário** | **VIT (7)** | Precisa de resistência para sobreviver em combate |

### 3. Tendência de Crescimento por Nível

| Atributo | Prioridade | Justificativa |
|---|---|---|
| STR | Ignorar | Não usa força física como arma |
| AGI | Média | Ajuda na mobilidade e velocidade de rituais |
| VIT | Alta | Precisa sobreviver para continuar curando; é o "segundo tanque" |
| INT | Alta | É o coração da classe — escala cura, SP e eficácia de buffs |
| DEX | Baixa | Melhora precisão de rituais, mas é menos prioritário |
| LUK | Baixa | Pode ser ignorada no build principal |

### 4. Papel em Party

| Papel | Primário? | Observação |
|---|---|---|
| Tank | ❌ Não | Tem boa VIT, mas não segura aggro |
| DPS | ❌ Não | Dano quase nulo |
| Support | ✅ Sim | Cura, buffs e purificação — papel essencial |
| Utility | ✅ Sim | Exorcismo, remoção de debuffs, buffs de proteção |

**Dependência:** Precisa do Tembira para protegê-lo de inimigos físicos e do Karaí para lidar com ameaças espirituais que não consegue exorcizar sozinho.

**O que oferece ao grupo:** É o único que cura e purifica. Sem ele, o grupo não se sustenta em combates longos.

### 5. Skills (5)

| Skill | Custo SP | Cooldown | Tipo | Fórmula / Efeito | Descrição |
|---|---|---|---|---|---|
| Cura da Floresta | 12 | 2s | Cura | INT × 2.2 + nível × 4 | Restaura HP de um aliado. Cura +20% se usado em área de mata densa |
| Bênção de Tupã | 18 | 25s | Buff | INT × 0.6 + nível × 2 | Aumenta resistência a dano físico e mágico de todos os aliados em 25% por 10s |
| Exorcismo de Angá | 15 | 20s | Cura/Debuff | — | Remove 1 efeito negativo de um aliado e causa dano a espíritos invocados |
| Canto dos Antepassados | 25 | 40s | Buff | — | Todos os aliados recuperam 5% HP e SP a cada 2s por 8s (total 20%) |
| Água Sagrada de Iara | 10 | 10s | Cura | INT × 1.5 | Cura instantânea menor em área (3m) — ideal para emergências |

**Skill Icônica:** Cura da Floresta — a skill que define o Payé.

### 6. Progressão Futura

| Nível | Evolução | Foco |
|---|---|---|
| 15 | Payé-Mor | Cura em área e buffs de resistência |
| 30 | Payé-Tupã | Grande sacerdote — ressurreição, purificação em massa, bênçãos permanentes |

### 7. Notas

- **Visual:** maracá, ervas, cocar branco, água de cachoeira em cabaça
- **Risco:** se posicionado mal, pode ser alvo fácil — precisa de proteção do Tembira
- **Mecânica:** rituais poderosos têm animações longas (trade-off tempo vs eficácia)

### 8. Validação

- ✅ Papel em party claramente definido
- ✅ Atributos base fazem sentido para o papel
- ✅ Pelo menos 1 skill que define o papel (Cura)
- ✅ Descrição compreensível
- ✅ Tendência de crescimento preenchida
- ✅ Progressão futura esboçada

---

## C4 — CLASSE 4: [NOME]

> Slot vazio para expansão pós-MVP.

### 1. Identidade

| Campo | Valor |
|---|---|
| nome | |
| arquétipo | |
| dificuldade | ☐ Fácil ☐ Médio ☐ Difícil |
| descrição | |
| estilo_de_combate | |

### 2. Atributos Base (Nível 1)

| Atributo | Valor | Descrição |
|---|---|---|
| STR | | Força física / dano corpo-a-corpo |
| AGI | | Velocidade de ataque e fuga |
| VIT | | Vitalidade / HP máximo |
| INT | | Inteligência / dano mágico e SP |
| DEX | | Destreza / acerto e cast |
| LUK | | Sorte / crit e drop rate |
| **Total** | | |
| **Principal** | | |
| **Secundário** | | |

### 3. Tendência de Crescimento por Nível

| Atributo | Prioridade | Justificativa |
|---|---|---|
| STR | ☐ Alta ☐ Média ☐ Baixa ☐ Ignorar | |
| AGI | ☐ Alta ☐ Média ☐ Baixa ☐ Ignorar | |
| VIT | ☐ Alta ☐ Média ☐ Baixa ☐ Ignorar | |
| INT | ☐ Alta ☐ Média ☐ Baixa ☐ Ignorar | |
| DEX | ☐ Alta ☐ Média ☐ Baixa ☐ Ignorar | |
| LUK | ☐ Alta ☐ Média ☐ Baixa ☐ Ignorar | |

### 4. Papel em Party

| Papel | Primário? | Observação |
|---|---|---|
| Tank | ☐ Sim ☐ Não | |
| DPS | ☐ Sim ☐ Não | |
| Support | ☐ Sim ☐ Não | |
| Utility | ☐ Sim ☐ Não | |

**Dependência:**

**O que oferece ao grupo:**

### 5. Skills (3–5)

| Skill | Custo SP | Cooldown | Tipo | Fórmula / Efeito | Descrição |
|---|---|---|---|---|---|
| | | | | | |
| | | | | | |
| | | | | | |
| | | | | | |
| | | | | | |

**Skill Icônica:**

### 6. Progressão Futura

| Nível | Evolução | Foco |
|---|---|---|
| 15 | | |
| 30 | | |

### 7. Notas

### 8. Validação

- ☐ Papel em party claramente definido
- ☐ Atributos base fazem sentido
- ☐ Pelo menos 1 skill que define o papel
- ☐ Descrição compreensível
- ☐ Tendência de crescimento preenchida
- ☐ Progressão futura esboçada

---

## Validação Cruzada — As 3 Classes em Conjunto

Após preencher as 3 fichas, responda:

| Pergunta | Sim | Não |
|---|---|---|
| Existe pelo menos 1 classe com papel primário de Tank? | ✅ | ☐ |
| Existe pelo menos 1 classe com papel primário de DPS? | ✅ | ☐ |
| Existe pelo menos 1 classe com papel primário de Support? | ✅ | ☐ |
| As 3 classes têm estilos de combate claramente diferentes? | ✅ | ☐ |
| Nenhuma classe consegue desempenhar sozinha todos os papéis? | ✅ | ☐ |
| As skills das 3 classes se complementam? | ✅ | ☐ |
| Os atributos principais das 3 classes são diferentes? | ✅ | ☐ |
| A progressão de nível 1 a 30 faz sentido? | ✅ | ☐ |
| As 3 fichas estão aprovadas pela equipe (pai e filho)? | ✅ | ☐ |

**Próximo passo após aprovação:** Fase 0.3 (Sistema de Atributos e Fórmulas) → Fase 0.4 (Árvore de Skills) → Fase 1 (Fundação Técnica).
