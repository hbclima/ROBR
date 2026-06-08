# ROBR — UI Mockups v0.1.0

## Visão Geral

Mockups interativos de interface do usuário para o MMORPG ROBR, projetados para
funcionar em **PC (1920×1080)**, **Console (1920×1080 com safe area)** e
**Mobile (375×812pt, touch-optimized)**.

## Arquivos

| Arquivo | Descrição |
|---------|-----------|
| `ui_mockups.html` | Mockups PC/Console — 5 telas interativas |
| `ui_mockups_mobile.html` | Mockups Mobile — 4 telas otimizadas para toque |
| `tokens.json` | Design tokens (cores, espaçamento, tipografia, border-radius) |

## Telas Incluídas

### HUD Principal
- Barras de HP/MP/XP com frame de retrato do personagem
- Minimap circular com indicadores de quest/NPC/inimigo
- Hotbar de skills (6 slots) com indicador de cooldown
- Chat multi-canal (Grupo, Guilda, Sistema, Mundo)
- Barras de buff/debuff
- Botões de menu rápido (Inventário, Skills, Mapa, Status, Config)
- Frame de alvo com barra de vida

### Inventário
- Painel de equipamento com slots visuais (7 slots)
- Grade de inventário (5×6) com raridade por cor
- Painel de detalhes do item com stats e descrição
- Tabs de filtro (Todos, Armas, Armaduras, Consumo, Missão)
- Indicador de moeda Guarani
- Botões de ação (Usar, Vender, Descartar)

### Árvore de Skills
- Seletor de classe (Tembira, Karaí, Payé)
- Árvore com 3 tiers (Básico, Avançado, Mestre)
- Estados: aprendido (✓), disponível (glow), locked (cinza)
- Painel de detalhe da skill com stats e custo em SP
- Contador de Skill Points

### Status do Personagem
- Preview 3D do personagem
- Stats primários e derivados com valores base + bônus
- Barra de XP
- Sistema de títulos (ativos/locked)
- Contadores de coleção

### Diálogo com NPC
- Painel com borda tribal brasileira
- Retrato do NPC + nome + título
- Texto de diálogo com opções clicáveis
- Indicador de quest disponível (animado)

## Design System

### Paleta de Cores
- **Primary**: `#2D6A4F` (verde floresta)
- **Secondary**: `#40916C` (verde claro)
- **Accent**: `#D4A373` (dourado terroso)
- **Health**: `#22C55E` | **Mana**: `#3B82F6` | **XP**: `#A855F7`
- **Raridade**: Comum (cinza), Incomum (verde), Raro (azul), Épico (roxo), Lendário (laranja)
- **Gold (moeda)**: `#FFD700` (Guarani)
- **Backgrounds**: `#0D1117` → `#161B22` → `#21262D`

### Tipografia
- Display: Cinzel (serif, títulos)
- UI: Segoe UI / Roboto (corpo, botões)

### Espaçamento
- xs: 4px | sm: 8px | md: 16px | lg: 24px | xl: 32px

### Border Radius
- sm: 4px | md: 8px | lg: 12px | pill: 9999px

## Multi-Plataforma

### PC (1920×1080)
- Layout completo com todos os painéis visíveis
- Hotbar horizontal de 6 slots
- Chat à esquerda, minimapa à direita
- Mouse-driven interactions

### Console (1920×1080)
- Similar ao PC com safe area de 90%
- Navegação por D-pad com highlight
- Menu radial para skills (não mockado nesta versão)

### Mobile (375×812)
- Hotbar vertical 2×3 (lado direito)
- Botões de ação grandes (44×44pt mínimo)
- Inventário em grade 5×5
- Skill tree em scroll vertical
- Menu inferior fixo (Inferior Tab Bar)
- Notch e home indicator respeitados

## Como Visualizar

Abra os arquivos HTML diretamente no browser:

```bash
# PC/Console
open Assets/mockup/ui_mockups.html

# Mobile
open Assets/mockup/ui_mockups_mobile.html
```

## Próximos Passos

- [ ] Validar mockups com stakeholder (Henrique)
- [ ] Ajustar cores/layout conforme feedback
- [ ] Criar variante Console com navegação D-pad
- [ ] Gerar assets exportáveis (PNG/SVG) para Roblox Studio
- [ ] Documentar guia de implementação para cada plataforma
- [ ] Criar guia de estilo de ícones
