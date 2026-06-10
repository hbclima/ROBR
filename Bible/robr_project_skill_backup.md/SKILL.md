---
name: robr_project
description: "Operações do projeto ROBR (MMORPG Roblox + Folclore Brasileiro). Ponto de entrada para TODAS as operações do projeto: pesquisa de folclore, geração de ficha de mob, listagem, atualização, revisão de consistência, conversão de documentos e preenchimento de GDD. Funciona em qualquer plataforma (Telegram, WhatsApp, Discord, etc.). Consulte esta skill antes de qualquer operação de arquivo no projeto ROBR."
---

# Projeto ROBR — Referência Operacional

## Início de Sessão

**SEMPRE** inicie sessões de trabalho no ROBR lendo:
1. `rclone cat onedrive_hermes:ROBR/bible/projeto_status.md`
2. `rclone cat onedrive_hermes:ROBR/Bible/mechanics.md`

O remote `onedrive_hermes` aponta para a raiz do OneDrive. O projeto está em `ROBR/`.

**NUNCA** use caminhos locais `/mmorpg-project/`. Sempre use `onedrive_hermes:ROBR/...`.

## Sincronização GitHub ↔ OneDrive

**REGRAS FUNDAMENTAIS:**
- GitHub: `hbclima/ROBR` (private, branch main), clone local em `/tmp/`
- Remote OneDrive: `onedrive_hermes`, path `ROBR/`

**SEMPRE que atualizar um, atualizar o outro:**
- Nunca enviar para GitHub sem copiar para OneDrive
- Nunca salvar no OneDrive sem fazer push para GitHub
- Sincronizar a cada mudança significativa, não deixe desync acumular

```bash
# OneDrive → GitHub
git checkout main && git pull  # garante estar atualizado
rclone copy "onedrive_hermes:ROBR/" /tmp/  # baixa OneDrive
# copiar arquivos novos/atualizados para repo local
git add -A && git commit -m "descrição" && git push origin main

# GitHub → OneDrive
git checkout main && git pull  # baixa mudanças do GitHub
rclone copy /tmp/ "onedrive_hermes:ROBR/" --create-empty-src-dirs  # sobe para OneDrive
```

**Pitfall:** `rclone copy` precisa de diretório como destino, não caminho de arquivo.
**Pitfall:** Arquivos vazios (0 bytes) bloqueiam copy — use `rclone deletefile` + `rcat`.

## Comandos rclone Essenciais

| Operação | Comando |
|---|---|
| Ler arquivo de texto | `rclone cat "onedrive_hermes:ROBR/caminho/arquivo.md"` |
| Enviar texto direto | `cat arquivo.md \| rclone rcat "onedrive_hermes:ROBR/caminho/arquivo.md"` |
| Listar arquivos | `rclone lsf "onedrive_hermes:ROBR/Documentação/Mobs/" --recursive` |
| Deletar arquivo | `rclone deletefile "onedrive_hermes:ROBR/caminho/arquivo.md"` |
| Deletar diretório | `rclone purge "onedrive_hermes:ROBR/caminho/diretorio"` |

### ⚠️ Regra de Ouro: Escrita de Arquivos de Texto

- **SEMPRE use `rclone rcat`** para escrever arquivos de texto (`.md`, `.txt`, `.lua`, `.json`, etc.)
- **NUNCA use `rclone copy`** para texto — cria DIRETÓRIOS em vez de arquivos para arquivos pequenos (< 5KB)
- **Sintoma:** `rclone lsf` mostra `MOB_XXX.md/` (barra = diretório, não arquivo)
- **Solução:** `rclone deletefile` + reenvie com `rclone rcat`
- **Para binários** (`.docx`, `.png`): use `rclone copy`

### Pitfalls de Caminho
- **prompts_agente.md** referencia `/mmorpg-project/` — DESATUALIZADO. Use `onedrive_hermes:ROBR/...`
- **bible/** (minúsculo) = `projeto_status.md` ≠ **Bible/** (maiúsculo) = `mechanics.md`

## Regras de Negócio (validadas pelo Henrique em 2026-06-07 e 2026-06-08)

| Regra | Valor |
|---|---|
| Boss MVP | Apenas MOB_007 (Boiúna). MOB_010 em HOLD |
| Cartas MVP | Drop rate fixo de 0.5% |
| Elites | HP no limite máximo do baseline (não acima) |
| Aggro range mínimo | 12 studs (inicial), 18+ (intermediária+) |
| Skills por mob | Máximo 3 no MVP |
| Drops por mob | Mínimo 1 comum, máximo 6 total |
| Skills por classe | Máximo 6 ativas. 1 skill point por nível (30 ao nível 30) |
| Upgrades de skill | +10% dano/efeito por ponto (máx 5 por skill). Manual |
| Skills novas | Custam 3 pts. Nível 10 (Tembira/Karaí), nível 15 (Payé) |
| Stat points | 3 por nível, distribuição manual |
| XP | XP(N) = 200 × N^1.8 |
| Party XP | (XP_mob × 1.25) ÷ nº_membros |
| Morte | Perde 5% XP acumulado (2.5% em party) |
| Fórmulas | Mobs usam as mesmas fórmulas que jogadores |
| Moeda | **Guarani** (não Zeny) |
| **Detalhes completos** | Ver `references/design_decisions_03_04.md` |

## Estado dos Mobs

**Total: 16 mobs** (15 ativos + 1 hold)

| ID | Nome | Nível | HP | Elem | Raridade | Mapa |
|---|---|---|---|---|---|---|
| MOB_001 | Sapo Cururu | 1–6 | 120 | água | comum | 1 |
| MOB_002 | Cobra-d'Água | 5–10 | 210 | água | comum | 1–2 |
| MOB_015 | Capivara | 1–5 | 80 | neutro | comum | 1 |
| MOB_003 | Mãe-da-Mata | 10–15 | 350 | terra | incomum | 2 |
| MOB_011 | Boto Cor-de-Rosa | 12–15 | 380 | água | raro | 2 |
| MOB_013 | Corpo Seco | 10–14 | 320 | sombra | raro | 2 |
| MOB_004 | Boitatá | 15–20 | 520 | fogo | incomum | 3 |
| MOB_012 | Mula Sem Cabeça | 18–22 | 600 | fogo | elite | 3 |
| MOB_016 | Jacaré-Açu | 16–20 | 600 | neutro | raro | 3 |
| MOB_005 | Curupira | 20–25 | 800 | terra | raro | 4 |
| MOB_008 | Anhangá | 25–30 | 700 | sombra | raro | 4 |
| MOB_014 | Onça-Pintada | 20–25 | 900 | neutro | raro | 4 |
| MOB_006 | Saci Pererê | 25–30 | 900 | vento | elite | 5 |
| MOB_009 | Jurupari | 25–30 | 900 | vento | elite | 5 |
| MOB_007 | Boiúna | 30 | 4200 | água | chefe | 6 |
| MOB_010 | Tupã-Jaguaçu | 30 | 3500 | sagrado | chefe | hold |

## Classes

| Classe | Papel | Principal | Skills Iniciais |
|---|---|---|---|
| Tembira | Tank/Utility | VIT | 5 base + 1 nova (nível 10) |
| Karaí | DPS/Utility | INT | 5 base + 1 nova (nível 10) |
| Payé | Support/Utility | INT | 5 base + 1 nova (nível 15) |

**Validação cruzada:** ✅ 9/9 critérios aprovados.

## Lore e Identidade (Fase 0.B)

| Elemento | Valor |
|---|---|
| Nome do mundo | Yvyvuçu ("terra grande" em tupi-guarani) |
| Povo | Tupã-Y |
| Força das trevas | Angá |
| Conflito | 6 pontos de corrupção espalhados pelos mapas |

**Mapas:**
| Mapa | Nome | Descrição |
|---|---|---|
| 1 | Rio Ibirapuera | Zona inicial |
| 2 | Floresta de Mãe-da-Mata | Zona intermediária |
| 3 | Clareira Queimada | Zona intermediária avançada |
| 4 | Cemitério Indígena | Zona avançada |
| 5 | Templo nas Nuvens | Zona de transição |
| 6 | Lago Subterrâneo | Boss arena |

**Detalhes completos:** Ver `references/lore_identidade.md`

## Economia (Fase 0.8)

| Parâmetro | Valor |
|---|---|
| Moeda | Guarani |
| Poção de Cura Pequena | 10 Guarani |
| Poção de Cura Média | 25 Guarani |
| Poção de Cura Grande | 60 Guarani |
| Tacape Simples | 50 Guarani |
| Cajado Simples | 45 Guarani |
| Roupa de Fibra | 30 Guarani |
| Trade max itens | 10 |
| Trade max Guarani | 999.999 |
| Taxa de transação | 0% (MVP) |

**Detalhes completos:** Ver `references/economia_basica.md`

## Pitfalls Gerais

- **web_search NÃO disponível** — use `curl -sL` + `browser_navigate`
- **pip3 NÃO disponível** — use `npm`
- **image_generate (FAL) NÃO disponível** — FAL_KEY não configurado. Para mockups visuais, use HTML/CSS puro (write_file → arquivo .html). Para assets de jogo (sprites, ícones), use o skill `sketch` ou `claude-design`. Para geração via IA de imagens, configure FAL_KEY ou use o skill `comfyui`.
- **HTML mockups são o padrão** — quando image_generate falhar, pivote para mockups HTML/CSS interativos. São visualizáveis no browser, servem como protótipo funcional e como guia de implementação para Roblox UI.
- **Plataformas alvo: PC + Console + Mobile** — toda UI deve considerar os 3 form factors. PC (1920×1080), Console (safe area 90%), Mobile (375×812, touch targets ≥44px).
- **NÃO repita pesquisa já feita na sessão** — use o conhecimento existente
- **Respostas diretas** — não explique cada passo, apenas faça
- **Parser de drops Python falha** — prefira `grep` em shell para validar drops/skills em tabelas markdown
- **Mobs usan mesmas fórmulas que jogadores** — atributos derivados das fichas
- **GDD Fase 0.6 usa classes "Swordman/Mage/Acolyte"** — nomes desatualizados, usar Tembira/Karaí/Payé
- **Moeda: Guarani** — nunca "Zeny" ou "zeny" em nenhum documento
- **Formato de documentos** — manter estrutura narrativa, aplicar padrão visual (tabelas, seções) sem reescrever conteúdo existente
- **Bulk update de campos** — use `rclone cat | sed | rclone rcat` para atualizar múltiplos arquivos. Verifique com `grep` após
- **Fases do projeto** — Fase 0.1 a 0.8 e 0.B concluídas. Próximo: Fase 1 (Fundação Técnica)
- **GitHub sync** — Repo `hbclima/ROBR` (private). Ver `references/github_sync.md` para o padrão de sincronização OneDrive ↔ GitHub

## Operações

### Pesquisa de Folclore
Trigger: `pesquisa: [entidade]` | Referência: `references/ops_pesquisa_folclore.md`

### Gerar Ficha de Mob
Trigger: `TAREFA: gerar_ficha_mob` | Referência: `references/ops_gerar_ficha_mob.md`

### Atualizar Campo
Trigger: `atualizar campos` ou `TAREFA: atualizar_campo`

### Revisão de Consistência
Trigger: `TAREFA: revisao_consistencia` | Verificar: campos obrigatórios, HP/XP baseline, drops comum, IDs duplicados, cartas 0.5%, aggro ≥ 12, skills ≤ 3

### Validar Bible
Trigger: `validar bible` | Cruzar Bible com fichas ativas

### Converter Documentos
Trigger: conversão .docx → .md | Referência: `references/docx_to_md_script.md`

### Gerar Mockups de UI
Trigger: `gerar mockup UI`, `mockup de interface`, `UI assets`
Referência: `references/ops_gerar_mockup_ui.md`

---

*Este documento é complementado por `references/design_decisions_03_04.md` (fórmulas e skills), `references/lore_identidade.md` (lore e identidade visual) e `references/economia_basica.md` (economia e preços).*