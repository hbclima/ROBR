# GDD — FASE 0.7: Sistema de Inventário e Equipamentos

**Projeto:** RO Clone no Roblox
**Fase:** 0.7 — Sistema de Inventário e Equipamentos
**Entregável:** Listagem de slots e tipos de item + fórmulas de modificação de stats
**Critério:** Slots definidos, tipos de item catalogados, fórmulas documentadas e validadas com exemplo manual
**Depende de:** 0.2 (Classes) · 0.3 (Atributos) · 0.6 (Progressão)

---

## 1. Slots de Equipamento

### 1.1 — Slots do MVP

| Slot | Nome exibido | MVP? | Observações |
|------|-------------|------|-------------|
| `arma_principal` | Arma Principal | ✅ Sim | Obrigatório. Define dano base do personagem. |
| `arma_secundaria` | — | ❌ Não | Adiado para pós-MVP |
| `capacete` | Capacete | ✅ Sim | Proteção da cabeça. |
| `armadura` | Armadura | ✅ Sim | Proteção do corpo. Slot principal de defesa. |
| `calca` | — | ❌ Não | Adiado para pós-MVP |
| `botas` | Botas | ✅ Sim | Proteção dos pés. Pode dar bônus de velocidade. |
| `luvas` | — | ❌ Não | Adiado para pós-MVP |
| `colar` | Colar | ✅ Sim | Acessório. Pode dar bônus variados. |
| `anel_1` | — | ❌ Não | Adiado para pós-MVP |
| `anel_2` | — | ❌ Não | Adiado para pós-MVP |
| `cinto` | — | ❌ Não | Adiado para pós-MVP |

**Total de slots no MVP: 5** (arma_principal, capacete, armadura, botas, colar)

### 1.2 — Regras de slot

| Regra | Valor |
|---|---|
| Slots simultâneos | 5 (todos os slots MVP) |
| Restrições por classe | **Tembira:** armas de 2 mãos apenas (não pode usar secundária). **Karaí:** cajado + escudo/livro |
| Slots bloqueados por nível | Nenhum no MVP — todos os slots disponíveis desde nível 1 |

---

## 2. Sistema de Peso

**Decisão:** Sem sistema de peso no MVP.

**Justificativa:** Simplifica significativamente a implementação do inventário e a experiência do jogador. O sistema de peso será adicionado no pós-MVP como melhoria de profundidade. O limite de inventário será por **quantidade de slots** (não por peso).

**Inventário do MVP:**
- **24 slots** de inventário (grade 6×4)
- Cada item ocupa 1 slot
- Itens stackáveis (consumíveis) ocupam 1 slot até o limite de stack

---

## 3. Tipos de Itens (MVP)

### 3.1 — Consumíveis

| ID do tipo | Nome | Efeito | Stackável? | Qtd. máx. | Peso unit. |
|-----------|------|--------|------------|-----------|-----------|
| `CONS_001` | Poção de HP | Restaura 50 HP instantâneo | Sim | 50 | — |
| `CONS_002` | Poção de SP | Restaura 30 SP instantâneo | Sim | 50 | — |
| `CONS_003` | Carne Assada | Restaura 20 HP em 10s (comer) | Sim | 30 | — |
| `CONS_004` | Chama Azulada | Aumenta ATK+5 por 60s (buff) | Sim | 20 | — |
| `CONS_005` | Cinza de Cobra | Ingrediente de crafting (pós-MVP) | Sim | 99 | — |
| `CONS_006` | Ovo de Serpente | Ingrediente / venda | Sim | 99 | — |

**Regras de consumíveis:**
- Limite de uso por combate: **5 consumíveis por combate**
- Cooldown entre usos: **2 segundos** (global item cooldown)
- Podem ser usados fora de combate? **Sim**

### 3.2 — Equipamentos

| ID do tipo | Categoria | Slot compatível | Restrição de classe | Stats base |
|-----------|-----------|-----------------|---------------------|-----------|
| `EQUIP_001` | Arma leve (espada) | arma_principal | Tembira | ATK +15 |
| `EQUIP_002` | Arma pesada (espada 2 mãos) | arma_principal | Tembira | ATK +30 |
| `EQUIP_003` | Cajado | arma_principal | Karaí | ATK +10, INT +2 |
| `EQUIP_004` | Escudo/Livro | — (bônus passivo) | Karaí | DEF +5 |
| `EQUIP_005` | Capacete de couro | capacete | Todas | DEF +3 |
| `EQUIP_006` | Capacete de metal | capacete | Tembira | DEF +6 |
| `EQUIP_007` | Armadura de couro | armadura | Todas | DEF +8 |
| `EQUIP_008` | Armadura de metal | armadura | Tembira | DEF +15 |
| `EQUIP_009` | Botas de couro | botas | Todas | DEF +2, AGI +1 |
| `EQUIP_010` | Botas de metal | botas | Tembira | DEF +5 |
| `EQUIP_011` | Colar de osso | colar | Todas | STR +2 |
| `EQUIP_012` | Colar de pedra | colar | Todas | INT +2 |
| `EQUIP_013` | Colar de fogo | colar | Todas | ATK +5 (flat) |

### 3.3 — Outros tipos (roadmap pós-MVP)

- **Cartas:** Itens especiais que concedem passivas quando equipados (inspirado em RO)
- **Materiais de crafting:** Para sistema de crafting futuro
- **Itens de quest:** Itens não-comerciáveis para missões

---

## 4. Fórmula de Modificação de Stats por Item

### 4.1 — Modificadores diretos (flat) — MVP

**Fórmula:**
```
stat_final = stat_base + soma(modificadores_flat_equipados)
```

| Atributo | Pode ser modificado por item? | Observações |
|----------|------------------------------|-------------|
| Força (STR) | ✅ Sim | Colares, armaduras especiais |
| Inteligência (INT) | ✅ Sim | Cajados, colares |
| Destreza (DEX) | ❌ Não | Adiado para pós-MVP |
| Agilidade (AGI) | ✅ Sim | Botas |
| Vitalidade (VIT) | ❌ Não | Adiado para pós-MVP |
| Sorte (LUK) | ❌ Não | Adiado para pós-MVP |

### 4.2 — Modificadores percentuais

**Decisão:** Não existem no MVP. Apenas modificadores flat.

**Justificativa:** Simplifica o cálculo e o balanceamento. Modificadores percentuais serão adicionados no pós-MVP para itens de raridade Épico e acima.

### 4.3 — Stats secundários derivados de equipamento

| Stat secundário | Fórmula | Afetado por item? |
|----------------|---------|------------------|
| Defesa física | `DEF_base + soma(DEF_equipamentos)` | ✅ Sim |
| Ataque (ATK) | `ATK_base + soma(ATK_equipamentos)` | ✅ Sim |
| Resistência mágica | `INT * 2` | ❌ Não (apenas INT) |
| Velocidade de ataque | `AGI * 0.5` | ❌ Não (apenas AGI) |
| Chance de crítico | `LUK * 0.2` | ❌ Não (apenas LUK) |

### 4.4 — Exemplo preenchido (validação)

**Personagem:** Tembira nível 10
**Stats base (sem equipamento):** STR=15, INT=5, AGI=10, VIT=12, DEX=8, LUK=3
**HP base:** 615 | **ATK base:** ~25

**Equipamento:**
- Espada de 2 mãos (EQUIP_002): ATK +30
- Armadura de couro (EQUIP_007): DEF +8
- Capacete de couro (EQUIP_005): DEF +3
- Botas de couro (EQUIP_009): DEF +2, AGI +1
- Colar de osso (EQUIP_011): STR +2

**Stats calculados:**
- STR: 15 + 2 = **17**
- AGI: 10 + 1 = **11**
- ATK: 25 + 30 = **55**
- DEF: 0 + 8 + 3 + 2 = **13**
- HP: 615 + (17 × 8) = **751** (VIT não mudou, mas STR afeta HP via fórmula de classe)

---

## 5. Rarezas de Item (MVP)

| Rareza | Nome | Cor de exibição | Qtd. máx. de afixos | Observações |
|--------|------|----------------|---------------------|-------------|
| 1 | Comum | Branco (#FFFFFF) | 0 | Sem bônus adicional. Item base. |
| 2 | Incomum | Verde (#00FF00) | 1 | 1 afixo bônus (ex: +3 STR extra) |
| 3 | Raro | Azul (#0088FF) | 2 | 2 afixos bônus |
| 4 | Épico | Roxo (#AA00FF) | 3 | 3 afixos bônus. Drop apenas de elites/chefes. |

**Afixos possíveis (por raridade):**
- **Incomum:** +3 em qualquer atributo primário
- **Raro:** +5 em qualquer atributo primário OU +10% ATK/DEF
- **Épico:** +8 em qualquer atributo primário OU +15% ATK/DEF OU efeito especial

**Drops por raridade:**
| Raridade | Fonte de drop |
|----------|--------------|
| Comum | Todos os mobs |
| Incomum | Mobs incomuns+ (raridade ≥ incomum) |
| Raro | Mobs raros+ (raridade ≥ raro) |
| Épico | Mobs elite e chefe apenas |

---

## 6. Entregável da Etapa

| Item de entrega | Status | Link/Localização |
|----------------|--------|-----------------|
| Lista de slots definidos | ✅ | Seção 1 |
| Lista de tipos de item MVP | ✅ | Seção 3 |
| Fórmulas de modificação documentadas | ✅ | Seção 4 |
| Exemplo de cálculo validado | ✅ | Seção 4.4 |
| Tabela de raridades | ✅ | Seção 5 |

---

## 7. Dependências e Riscos

**Depende de:**
- 0.2 (Definição das Classes) — para restrições de equipamento
- 0.3 (Sistema de Atributos) — para fórmulas de stats derivados
- 0.6 (Sistema de Progressão) — para nível máximo e stats por nível

**Bloqueia:**
- Fase 3.B (Equipamentos) — implementação do sistema de inventário e equipamento no código

**Riscos identificados:**

| Risco | Probabilidade | Impacto | Mitigação |
|-------|--------------|---------|-----------|
| Itens de raridade Épico muito poderosos quebram o PvP | Média | Alto | Limitar afixos percentuais a +15% máximo no MVP |
| Inventário de 24 slots pode ser insuficiente | Baixa | Médio | Ajustar para 30 slots se necessário após teste |
| Restrição de classe confunde jogadores novos | Média | Médio | Tooltip claro no item indicando classe permitida |

---

## 8. Notas e Decisões

| Data | Decisão | Motivo |
|------|---------|--------|
| 2026-06-06 | 5 slots no MVP (arma, capacete, armadura, botas, colar) | Simplificação para MVP. Outros slots no pós-MVP. |
| 2026-06-06 | Sem sistema de peso no MVP | Simplificação. Inventário limitado por slots (24). |
| 2026-06-06 | Guerreiro: armas de 2 mãos; Mago: cajado + escudo/livro | Diferenciação clara de classes no equipamento. |
| 2026-06-06 | 4 raridades (Comum, Incomum, Raro, Épico) | Equilíbrio entre profundidade e complexidade para MVP. |
| 2026-06-06 | Apenas modificadores flat no MVP | Simplifica balanceamento. Percentuais no pós-MVP. |
| 2026-06-06 | 24 slots de inventário | Suficiente para MVP sem sistema de peso. |

---

*Última atualização: 2026-06-06*
