# ROBR — MMORPG Roblox Folclore Brasileiro

> MMORPG ambientado no universo do folclore brasileiro, construído na plataforma Roblox.

## Sobre o Projeto

ROBR é um MMORPG que traz para o universo gamer as lendas, criaturas e mitos do folclore brasileiro. O projeto combina mecânicas clássicas de RPG com elementos da cultura popular brasileira, criando uma experiência única na plataforma Roblox.

## Estrutura do Repositório

```
ROBR/
├── Bible/                      # Documentos centrais do projeto
│   ├── mechanics.md            # Mecânicas e fórmulas do jogo
│   └── projeto_status.md       # Status atual do desenvolvimento
├── Documentação/
│   ├── GDD_Fase01_Visão_do_Jogo.md
│   ├── Classes/                # Definições de classes (Tembira, Karaí, Payé)
│   │   └── GDD_Fase02_Classes_MVP_Template.md
│   ├── GDD_Fase03_Atributos_Formulas.md
│   ├── GDD_Fase04_Arvore_Skills.md
│   ├── GDD_Fase06_Sistema_Progressao.md
│   ├── GDD_Fase07_Sistema_Inventario_Equipamentos.md
│   ├── GDD_Fase08_Economia_Basica.md
│   ├── GDD_Fase0B_Lore_Identidade_Revisado.md
│   ├── Fase1_Fundacao_Tecnica.md
│   ├── Mobs/                   # Fichas dos mobs (MOB_001 a MOB_016)
│   │   ├── 0_TEMPLATE_MOB.md
│   │   ├── MOB_001_Sapo_Cururu.md
│   │   ├── MOB_002_Cobra_Dagua.md
│   │   ├── MOB_003_Mae_da_Mata.md
│   │   ├── MOB_004_Boitata.md
│   │   ├── MOB_005_Curupira.md
│   │   ├── MOB_006_Saci_Perere.md
│   │   ├── MOB_007_Boiuna.md
│   │   ├── MOB_008_Anhanga.md
│   │   ├── MOB_009_Jurupari.md
│   │   ├── MOB_010_Tupa_Jaguacu.md
│   │   ├── MOB_011_Boto_Cor_de_Rosa.md
│   │   ├── MOB_012_Mula_Sem_Cabeca.md
│   │   ├── MOB_013_Corpo_Seco.md
│   │   ├── MOB_014_Onca_Pintada.md
│   │   ├── MOB_015_Capivara.md
│   │   └── MOB_016_Jacare_Acu.md
│   ├── Pesquisa/                # Pesquisas de folclore por criatura
│   │   ├── boto-cor-de-rosa.md
│   │   ├── corpo_seco.md
│   │   ├── mula_sem_cabeca.md
│   │   ├── pesquisa_capivara.md
│   │   ├── pesquisa_jacare_acu.md
│   │   └── pesquisa_onca_pintada.md
│   └── Arte conceitual/         # Artes conceituais dos mobs
│       ├── Boitata.png
│       ├── Cobra D'agua.png
│       ├── Mae_da_Mata.png
│       └── Sapo_Cururu.png
├── Tasks/                      # Tarefas e prompts do agente
│   └── prompts_agente.md
├── bibliografia_folclore_tupi_guarani.md
├── prompts_agente.md
└── RO_Clone_Roblox_Plano_MVP.md  # Plano MVP do projeto
```

## Classes

| Classe | Papel | Inspiração |
|--------|-------|------------|
| **Tembira** | Tank (melee, alta defesa) | Guerreiro tribal |
| **Karaí** | DPS (magia à distância) | Pajé / Xamã |
| **Payé** | Support (cura, buffs) | Curandeiro |

## Mobs

16 mobs baseados em criaturas do folclore brasileiro:

| ID | Criatura | Tipo |
|----|----------|------|
| MOB_001 | Sapo-Cururu | Neutro |
| MOB_002 | Cobra D'Água | Hostil |
| MOB_003 | Mãe da Mata | Hostil |
| MOB_004 | Boitatá | Hostil |
| MOB_005 | Curupira | Hostil |
| MOB_006 | Saci-Pererê | Hostil |
| MOB_007 | Boiúna | **Boss MVP** |
| MOB_008 | Anhangá | Hostil |
| MOB_009 | Jurupari | Hostil |
| MOB_010 | Tupã-Jaguacu | Elite (em hold) |
| MOB_011 | Boto-Cor-de-Rosa | Hostil |
| MOB_012 | Mula Sem Cabeça | Hostil |
| MOB_013 | Corpo-Seco | Hostil |
| MOB_014 | Onça-Pintada | Neutro |
| MOB_015 | Capivara | Neutro |
| MOB_016 | Jacaré-Açu | Hostil |

## Mecânicas Principais

- **Moeda:** Guarani
- **Skills:** Máximo 6 por classe, 1 skill point por nível
- **Upgrades de skill:** +10% por ponto (máx 5)
- **Skills novas:** Custam 3 pontos
- **Cartas:** Drop rate fixo de 0.5%
- **Elites:** HP no limite máximo do baseline
- **Aggro range:** Mínimo 12 studs
- **Ressurreição:** Payé nível 15

## Fases do Projeto

| Fase | Descrição | Status |
|------|-----------|--------|
| 0.1 | Visão do Jogo | ✅ Completa |
| 0.2 | Classes MVP | ✅ Completa |
| 0.3 | Atributos e Fórmulas | ✅ Completa |
| 0.4 | Árvore de Skills | ✅ Completa |
| 0.6 | Sistema de Progressão | ✅ Completa |
| 0.7 | Inventário e Equipamentos | ✅ Completa |
| 0.8 | Economia Básica | ✅ Completa |
| 0.B | Lore e Identidade | ✅ Completa |
| 1 | Fundação Técnica | ⏳ Próxima |

## Contribuição

Este é um repositório privado. Todo o desolvimento é feito pelo agente OWL sob supervisão.

## Licença

Uso privado — todos os direitos reservados.
