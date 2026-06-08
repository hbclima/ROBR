---
original_file: RO_Clone_Roblox_Plano_MVP.docx
converted: 2026-06-06
---

**PROJETO**

**Ragnarok Online Clone**

**no Roblox**

*Plano de Desenvolvimento MVP — Metodologia Cascata*

**Plataforma**

Roblox Studio + Luau

**Metodologia**

Cascata (Waterfall)

**Escopo**

MVP — Mecânicas Core do RO

**Equipe**

2 pessoas (pai e filho)

# **1. Visão Geral e Premissas**

Este documento define o plano de desenvolvimento em cascata para o MVP de um jogo no Roblox inspirado nas mecânicas de Ragnarok Online (RO). O objetivo não é replicar lore ou assets originais, mas reproduzir a estrutura de gameplay que torna RO funcionalmente distinto: sistema de atributos com fórmulas, classes com árvores de skills, grind de mobs com drops probabilísticos, party com dependência entre classes e um embrião de economia player-driven.

A metodologia cascata é adequada aqui porque o projeto é conduzido por uma dupla (pai e filho) aprendendo desenvolvimento de games — o sequenciamento rígido evita dispersão entre sistemas e garante que cada camada seja validada antes da próxima ser construída.

## **1.1 Princípios do Plano**

- Cada fase tem um critério de saída claro. Não se avança sem validação.
- Multiplayer sempre: todo sistema é testado com 2+ jogadores simultâneos antes de ser concluído.
- Dados separados de lógica: tabelas de configuração (classes, mobs, drops) ficam em ModuleScripts independentes do código de gameplay.
- Server-authoritative: o Client nunca decide o resultado de ações — apenas solicita ao Server.
- Lore e assets são elaborados em paralelo à fundação técnica, sem bloquear o desenvolvimento.

**Sobre o uso do IDE agêntico + MCP**

O fluxo recomendado é: (1) você define a mechanic em linguagem natural com referência ao RO, (2) o LLM gera o ModuleScript correspondente, (3) o MCP injeta no Studio na hierarquia correta, (4) você testa em multiplayer e descreve o que está errado. Nunca aceite código gerado sem verificar se respeita a separação Server/Client.

**FASE 0 — CONCEPÇÃO E PLANEJAMENTO**

*Documentação antes de qualquer código*

A fase 0 é inteiramente documental. O código só começa na Fase 1. Aqui se definem as regras que todos os sistemas vão obedecer — mudar fórmulas depois de sistemas construídos em cima delas é custoso.

## **0.A — Game Design Document (GDD)**

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

0.1

Visão do Jogo

Definir em 1 parágrafo o que o jogo é, para quem é e o que o diferencia. Referência: 'MMORPG no Roblox com progressão de classes, grind de mobs e economia player-driven, inspirado em RO.'

Documento de 1 página aprovado pela dupla

0.2

Definição das Classes MVP

Escolher 2 classes iniciais (ex.: Guerreiro e Mago). Documentar: atributos principais, papel em party (tank/damage/support), estilo de combate esperado.

Ficha de 2 classes preenchida

0.3

Sistema de Atributos

Definir os 6 atributos base (STR, AGI, VIT, INT, DEX, LUK). Documentar as fórmulas de: dano físico, dano mágico, defesa, hit rate, flee rate, velocidade de cast. Adaptar do RO conforme necessário.

Planilha de fórmulas validada com cálculo manual de 3 exemplos

0.4

Árvore de Skills MVP

Definir 3 a 5 skills por classe. Para cada skill: custo de SP, cooldown, tipo (dano/buff/debuff/cura), fórmula de efeito.

Tabela de skills das 2 classes preenchida

0.5

Catálogo de Mobs MVP

Definir 5 a 7 mobs. Para cada mob: nível recomendado, HP, ataque, defesa, aggro range, padrão de movimento, tabela de drops com probabilidades.

Ficha de 5-7 mobs preenchida

0.6

Sistema de Progressão

Definir: curva de XP por nível (níveis 1-30 para MVP), stat points ganhos por nível, regras de party XP sharing e penalidade por diferença de nível.

Tabela de XP e crescimento por nível 1-30

0.7

Sistema de Inventário e Equipamentos

Definir slots de equipamento (arma, armadura, capacete, etc.), sistema de peso, tipos de itens do MVP (consumíveis, equipamentos), fórmula de modificação de stats por item.

Listagem de slots e tipos de item

0.8

Economia Básica

Definir Guarani como moeda, preços de NPC shop, itens que os mobs dropam com valor de mercado estimado.

Tabela de preços base do NPC shop

## **0.B — Lore e Identidade do Jogo**

A lore não precisa ser extensa no MVP, mas precisa existir antes do desenvolvimento de assets para orientar nomenclaturas, visual e tom. Ela é desenvolvida em paralelo com o GDD técnico.

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

0.9

Definição do Mundo

Criar o nome do mundo/continente, o contexto histórico em 3 a 5 parágrafos. Definir o conflito central que motiva os personagens a lutar e crescer.

Documento de lore de mundo (1-2 páginas)

0.10

Identidade das Classes

Para cada classe MVP, escrever: origem no lore do mundo, motivação, vínculo com a facção ou ameaça central. Não precisa ser extenso — 1 parágrafo por classe.

Fichas de identidade das 2 classes

0.11

Bestário MVP

Para cada mob do catálogo, escrever: o que é, de onde vem no lore, por que está no mundo do jogador. Define o tom visual esperado (útil para assets no Roblox).

Bestário com 5-7 entradas

0.12

Nomenclatura

Definir nomes para: o mundo, as regiões dos 2-3 mapas MVP, as moedas, as classes e suas evoluções futuras planejadas. Manter consistência de tom (fantasia medieval, fantasia oriental, etc.).

Glossário de nomes aprovado

0.13

Guia Visual de Tom

Definir paleta de cores principal, referências visuais de personagens e cenários, estilo de UI (clean/ornamentado), e tom da trilha sonora esperada.

Moodboard ou documento de referências visuais

**Critério de Saída da Fase 0**

GDD completo com fórmulas validadas manualmente + documento de lore com mundo, classes e bestário + glossário de nomes. Nenhum código iniciado antes disso.

**FASE 1 — FUNDAÇÃO TÉCNICA**

*Ambiente e arquitetura antes de qualquer feature*

A Fase 1 estabelece a espinha dorsal técnica. Nenhuma feature de gameplay é implementada aqui — apenas a infraestrutura que vai suportar tudo. É tentador pular esta fase, mas fazê-lo significa reescrever partes do projeto mais tarde.

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

1.1

Estrutura de Pastas no Studio

Criar a hierarquia canônica: ServerScriptService (Scripts de servidor), StarterPlayerScripts (LocalScripts de cliente), ReplicatedStorage (ModuleScripts compartilhados), ServerStorage (dados privados do servidor).

Hierarquia criada e documentada com comentários

1.2

ModuleScript de Configuração Central

Criar o arquivo Config.lua em ReplicatedStorage contendo: tabela de atributos por classe, fórmulas de combate, tabela de mobs, tabela de drops, tabela de XP por nível, constantes do jogo.

Config.lua populado com dados do GDD

1.3

Sistema de DataStore

Implementar save/load de dados do jogador via DataStore2 ou DataStoreService nativo. Dados a persistir: nível, XP, atributos, classe, inventário, Guarani.

Jogador entra, dados carregam; jogador sai, dados salvam. Validado em 2 contas.

1.4

Framework de Eventos

Mapear e criar todos os RemoteEvents e RemoteFunctions necessários para o MVP: CombatEvent, SkillEvent, DropPickup, TradeRequest, PartyInvite, LevelUp. Documentar quem dispara e quem escuta cada um.

Documento de mapa de eventos + objetos criados no Studio

1.5

Sistema de Log de Desenvolvimento

Criar um módulo de logging server-side para facilitar debug durante o desenvolvimento. Níveis: INFO, WARN, ERROR.

Módulo funcional, testado com print de evento de teste

1.6

Teste de Ambiente Multiplayer

Criar sessão de teste com 2 jogadores simultâneos. Validar que DataStore funciona independentemente por jogador e que RemoteEvents chegam ao destinatário correto.

2 jogadores em sessão simultânea sem erros de console

**Critério de Saída da Fase 1**

2 jogadores entram no jogo, dados são carregados e salvos corretamente para cada um, sem erros no console. A estrutura de pastas e o mapa de eventos estão documentados.

**FASE 2 — PERSONAGEM E COMBATE BASE**

*Loop mínimo de combate jogável*

A Fase 2 entrega o primeiro loop jogável: criar personagem, atacar um mob, ganhar XP, subir de nível. É o núcleo do jogo — se isso não for divertido, nada mais importa.

## **2.A — Sistema de Personagem**

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

2.1

Seleção de Classe Inicial

Implementar tela de seleção de classe ao primeiro login. Classe escolhida é salva no DataStore e carrega os atributos base correspondentes do Config.lua.

Novo jogador escolhe classe; atributos base são carregados corretamente

2.2

Atributos e Fórmulas

Implementar no Server o ModuleScript de cálculo de stats derivados (HP máximo, SP máximo, dano, defesa, hit, flee) a partir dos atributos base e fórmulas do GDD.

Guerreiro e Mago com stats corretos conforme planilha do GDD

2.3

Stat Points por Nível

Implementar distribuição manual de stat points ao subir de nível. UI no Client envia escolha; Server valida e aplica.

Jogador sobe de nível, distribui pontos, stats recalculam corretamente

2.4

HP e SP como Recursos

Implementar HP e SP com regeneração passiva ao longo do tempo. Valores sincronizados Server → Client para exibição na UI.

Barras de HP e SP visíveis e atualizadas em tempo real

## **2.B — Sistema de Combate**

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

2.5

Auto-attack

Implementar ataque automático baseado em range e cooldown. Servidor calcula dano usando fórmulas do GDD (inclui hit/flee roll). Cliente anima o ataque.

Jogador clica em mob, auto-attack funciona com fórmula correta de dano

2.6

Mob — Máquina de Estados

Implementar IA básica de mob com estados: Idle (parado), Aggroed (perseguindo), Attacking (atacando), Returning (voltando à posição original). Usar PathfindingService para movimento.

Mob reage ao jogador entrando em range, persegue, ataca e volta se jogador fugir

2.7

Morte e Respawn do Mob

Implementar morte do mob com delay de respawn configurável por tipo de mob. Mob morto não é alvo e não aplica dano.

Mob morre, desaparece, reaparece no tempo correto

2.8

Distribuição de XP

Implementar cálculo e distribuição de XP ao matar mob. XP concedido ao jogador que aplicou o último golpe (regra MVP — party vem depois).

Matar mob concede XP correto conforme tabela do GDD

2.9

Level Up

Implementar lógica de level up: XP atinge limiar → nível sobe → stat points concedidos → HP/SP restaurados → evento notifica Client.

Level up ocorre no nível correto, com notificação visual no Client

2.10

Morte do Jogador

Implementar morte do jogador: perde % de XP base (configurável), respawn em ponto fixo, HP restaurado.

Jogador morre, perde XP correto, respawna no ponto definido

**Critério de Saída da Fase 2**

Dois jogadores jogando simultaneamente conseguem criar personagens de classes diferentes, combater mobs, subir de nível e sentir diferença entre as classes no combate. Sem crashes em sessão de 30 minutos.

**FASE 3 — SKILLS E PROGRESSÃO**

*Identidade de classe e profundidade de build*

A Fase 3 adiciona a camada que diferencia as classes além dos atributos: o sistema de skills. É aqui que o jogador começa a sentir que tem um personagem com identidade.

## **3.A — Sistema de Skills**

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

3.1

Framework de Skills

Criar ModuleScript central de skills: cada skill é uma tabela com custo de SP, cooldown, tipo, fórmula de efeito. Servidor executa; Client anima.

Framework funcional com 1 skill de teste disparando corretamente

3.2

Skills da Classe 1 (Guerreiro)

Implementar 3-5 skills do Guerreiro conforme GDD: ex. Bash (dano aumentado), Provoke (aggro forçado de mob), Endure (redução temporária de dano recebido).

Todas as skills do Guerreiro funcionais e testadas

3.3

Skills da Classe 2 (Mago)

Implementar 3-5 skills do Mago conforme GDD: ex. Fireball (dano mágico em área), Ice Wall (obstáculo físico), Energy Coat (escudo de SP).

Todas as skills do Mago funcionais e testadas

3.4

Cooldown e SP como Limitante

Garantir que cooldowns são server-side (não apenas visual) e que o SP é verificado antes da skill ser executada.

Tentar usar skill sem SP ou em cooldown resulta em recusa com feedback visual

3.5

UI de Skills

Implementar hotbar de skills no Client com indicadores de cooldown e SP disponível.

Hotbar funcional, cooldown visível, SP atualizado em tempo real

## **3.B — Equipamentos**

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

3.6

Sistema de Inventário

Implementar inventário com slots limitados por peso. Itens adicionados/removidos via Server. UI de inventário no Client.

Jogador coleta item, aparece no inventário, peso atualiza

3.7

Equipamento de Itens

Implementar slots de equipamento (arma, armadura, capacete). Equipar item modifica stats derivados via recálculo no Server.

Equipar espada aumenta dano; remover espada reduz dano. Verificado com fórmula.

3.8

Restrições de Classe

Implementar restrição de equipamento por classe (ex.: Mago não pode equipar espadas pesadas).

Tentar equipar item de classe errada resulta em recusa com mensagem

**Critério de Saída da Fase 3**

Guerreiro e Mago jogando juntos têm estilos de combate claramente diferentes. Skills funcionam com custo de SP e cooldown validados no servidor. Equipamentos modificam stats corretamente.

**FASE 4 — MUNDO E ECONOMIA**

*Razão para explorar e acumular*

A Fase 4 cria o contexto do jogo: mapas com mobs distribuídos por dificuldade, drops que têm valor, e um sistema de troca que começa a criar economia entre jogadores.

## **4.A — Mapas e Drops**

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

4.1

Mapa 1 — Zona Inicial

Construir o primeiro mapa com mobs de nível 1-10. Configurar spawn points, densidade de mobs e limites de área. Visual alinhado com o guia de tom da lore.

Mapa jogável com mobs respawnando corretamente na densidade definida

4.2

Mapa 2 — Zona Intermediária

Construir o segundo mapa com mobs de nível 10-20. Transição de mapa via portal ou zona de passagem.

Dois mapas conectados, transição funcional

4.3

Mapa 3 — Zona Avançada

Construir o terceiro mapa com mobs de nível 20-30, incluindo um mob MVP (boss com respawn longo e drops especiais).

Três mapas conectados, boss respawnando no timer correto

4.4

Sistema de Drops

Implementar drop probabilístico ao matar mob: rolar chance para cada item da tabela de drops do Config.lua. Item dropado spawna no mundo como objeto coletável.

Drops ocorrem com frequência aproximada à probabilidade configurada (testado em 50+ kills)

4.5

Coleta de Drops

Implementar coleta de item do chão via interação do jogador. Item vai para inventário se houver espaço e peso disponível.

Jogador coleta item do chão, inventário atualiza, item desaparece do mundo

## **4.B — Economia**

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

4.6

NPC Shop — Compra

Implementar NPC de loja. Jogador compra itens gastando Guarani. Estoque da loja é fixo e infinito (MVP).

Jogador compra item do NPC, Guarani deduzido, item no inventário

4.7

NPC Shop — Venda

Jogador pode vender itens do inventário ao NPC por valor base definido no Config.lua.

Jogador vende item, Guarani creditado, item removido do inventário

4.8

Trade Direto entre Jogadores

Implementar tela de trade: jogador A propõe itens + Guarani, jogador B aceita ou recusa. Transação executada no Server atomicamente.

Dois jogadores trocam itens sem duplicação ou perda. Testado com 10 trades.

4.9

Guarani persistido

Garantir que o saldo de Guarani é salvo no DataStore e recarregado ao login.

Jogador sai com X Guarani, volta com X Guarani.

**Critério de Saída da Fase 4**

Dois mapas ou mais acessíveis, drops funcionando com probabilidade correta, trade entre jogadores sem bugs de duplicação, NPC shop operacional. Testado em sessão de 1 hora com 2 jogadores.

**FASE 5 — CAMADA SOCIAL**

*Razão para jogar com outros*

A Fase 5 é a que transforma um jogo solo num MMORPG. Party e dependência entre classes são o núcleo emocional do RO — é aqui que a experiência se diferencia.

## **5.A — Sistema de Party**

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

5.1

Criar e Entrar em Party

Implementar convite de party: jogador A convida B, B aceita, ambos entram no mesmo grupo. Máximo de 4 jogadores (MVP).

Party criada e exibida na UI de todos os membros

5.2

XP Sharing em Party

Implementar distribuição de XP entre membros da party no mesmo mapa. Aplicar penalidade proporcional à diferença de nível conforme regra do GDD.

XP distribuído corretamente entre membros. Penalidade de nível validada com 3 casos do GDD.

5.3

Visualização de HP/SP dos Aliados

Exibir barras de HP e SP dos membros da party na UI do Client.

Barras visíveis e atualizadas em tempo real para todos os membros

5.4

Skills de Party (Cura/Buff)

Garantir que skills de cura e buff funcionam em aliados da party. Servidor valida que o alvo é membro da mesma party antes de aplicar o efeito.

Mago cura Guerreiro da party; skill não funciona em jogadores fora da party

5.5

Sair da Party

Implementar saída voluntária e expulsão pelo líder. XP sharing cessa imediatamente.

Saída de party refletida em todos os membros sem erros

## **5.B — Chat**

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

5.6

Canal de Chat Geral

Implementar chat geral visível por todos os jogadores no servidor.

Mensagens enviadas e recebidas em tempo real por todos os jogadores

5.7

Canal de Chat de Party

Implementar canal de party visível apenas pelos membros do grupo.

Mensagem no canal de party não visível para jogadores fora da party

5.8

Moderação Básica

Implementar filtro de chat usando o TextService nativo do Roblox (obrigatório pela política da plataforma).

Palavrões e termos bloqueados são filtrados pelo TextService

**Critério de Saída da Fase 5**

Guerreiro e Mago em party juntos têm desempenho claramente melhor do que solo. XP sharing funciona. Chat de party funciona. Sessão de 1 hora sem crashes ou bugs de sincronização.

**FASE 6 — POLISH E LANÇAMENTO DO MVP**

*Estabilidade, UX e publicação*

A Fase 6 não adiciona novas mecânicas — polido o que existe para que o jogo seja jogável por pessoas além dos desenvolvedores. É a fase mais subestimada e frequentemente negligenciada.

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

6.1

Auditoria de DataStore

Revisar todos os pontos de save/load. Implementar retry em falhas de DataStore. Testar perda de conexão durante save.

Nenhuma perda de dados em 20 sessões de teste com desconexão forçada

6.2

Tratamento de Erros

Implementar pcall em todas as chamadas críticas do Server. Erros logados e não expostos ao Client.

Nenhum erro não tratado visível no console após 2 horas de jogo

6.3

Balanceamento Inicial

Ajustar fórmulas de dano, XP e drops com base em sessões de teste. Documentar cada ajuste no GDD.

Curva de progressão do nível 1 ao 10 jogável em sessão de 1-2 horas

6.4

UI e UX Revisão

Revisar toda a UI: tipografia legível, ícones claros, feedback visual em todas as ações (hit, miss, level up, drop, trade).

Novo jogador entende o loop básico sem instruções em menos de 10 minutos

6.5

Tutorial Mínimo

Implementar tooltip ou sequência de onboarding cobrindo: como atacar, como usar skill, como coletar drop, como criar party.

Primeiro acesso guiado sem confusão nas ações básicas

6.6

Teste de Carga

Simular 5-10 jogadores simultâneos. Monitorar performance do servidor (script activity no Studio).

Servidor estável com 5 jogadores simultâneos por 30 minutos

6.7

Revisão de Política do Roblox

Verificar conformidade com Community Standards e ToS: filtro de chat, sem vantagens pay-to-win no MVP, assets sem IP de terceiros.

Checklist de conformidade preenchido e aprovado

6.8

Publicação

Configurar o jogo como público no Roblox. Definir descrição, ícone e miniaturas alinhados com a identidade de lore.

Jogo publicado e acessível por link. Primeiros 3 jogadores externos testam sem instrução.

**Critério de Saída da Fase 6 — MVP Concluído**

Jogo publicado e jogável por 5+ jogadores simultâneos sem crashes. Loop de progressão do nível 1 ao 20 funcional. Economia básica operacional. DataStore sem perda de dados documentada.

# **7. Resumo das Fases e Dependências**

A cascata sequencial abaixo representa as dependências entre fases. Nenhuma fase pode ser iniciada sem o critério de saída da anterior estar cumprido.

**#**

**Atividade**

**Descrição / Entregável**

**Critério de Saída**

Fase 0

Concepção e Planejamento

GDD completo + Lore + Glossário

Sem código iniciado antes disso

Fase 1

Fundação Técnica

DataStore + Eventos + Estrutura de pastas

Fase 0 concluída

Fase 2

Personagem e Combate Base

Loop mínimo: personagem → mob → XP → nível

Fase 1 concluída

Fase 3

Skills e Progressão

Skills por classe + Equipamentos

Fase 2 concluída e testada em multiplayer

Fase 4

Mundo e Economia

Mapas + Drops + NPC shop + Trade

Fase 3 concluída

Fase 5

Camada Social

Party + XP sharing + Chat

Fase 4 concluída

Fase 6

Polish e Lançamento

Balanceamento + UX + Publicação

Fase 5 concluída

## **Features Adiadas Conscientemente (Pós-MVP)**

- War of Emperium / PvP — requer balanceamento maduro
- Sistema de Guild — adiciona complexidade sem validar o loop core
- Crafting — não está no loop central do RO que queremos replicar primeiro
- Pets e Mounts — cosmético; não altera mecânicas core
- Segunda evolução de classe (ex.: Knight → Lord Knight) — expansão natural após MVP
- Cash shop — só após retenção provada e modelo de monetização definido
- Múltiplos servidores / instâncias — infraestrutura avançada do Roblox

**Nota sobre o uso do IDE agêntico ao longo do projeto**

O LLM é mais útil nas Fases 1 a 4, onde a lógica é bem definida pelo GDD. Na Fase 5 (social) e Fase 6 (polish), o julgamento humano sobre 'o que é divertido' e 'o que parece certo' é insubstituível. Nunca aceite código gerado sem verificar: (a) está no Script ou LocalScript correto? (b) valida no Server antes de executar? (c) testa com 2 jogadores e não apenas 1?