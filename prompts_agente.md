# Prompts de Tarefa — Agente MMORPG

Estes são os templates de instrução para as tarefas recorrentes.
Envie via Telegram com os parâmetros substituídos.

---

## TAREFA: Pesquisa de Entidade do Folclore

```
TAREFA: pesquisa_folclore
ENTIDADE: [nome da entidade]

Pesquise a entidade "[nome da entidade]" no folclore brasileiro.
Salve o resultado em /mmorpg-project/research/[nome_slug].md com as seguintes seções:

1. Origem histórica e regional
2. Variações regionais do nome e aparência
3. Poderes e habilidades atribuídos
4. Comportamento (ameaçador, protetor, neutro?)
5. Habitat natural
6. Referências culturais notáveis
7. Potencial para mecânicas de jogo (lista de ideias)

Ao final, responda com um resumo de 3-5 linhas.
```

---

## TAREFA: Gerar Ficha de Mob

```
TAREFA: gerar_ficha_mob
ENTIDADE: [nome da entidade]
ID: MOB_[número]
ZONA: [Mapa X — Nome]
RARIDADE: [comum|incomum|raro|elite|chefe]
NOTAS_EXTRAS: [qualquer restrição ou ideia específica, ou "nenhuma"]

Leia:
- /mmorpg-project/bible/mechanics.md
- /mmorpg-project/research/[nome_slug].md (se existir)

Crie a ficha de mob usando o template em /mmorpg-project/mobs/0_TEMPLATE_MOB.md.
Respeite os parâmetros de balanceamento do bible para a zona indicada.
Salve em /mmorpg-project/mobs/[ID]_[Nome].md

Ao final, responda com os atributos principais (nível, HP, ataque, defesa, XP) e os drops gerados.
```

---

## TAREFA: Revisão de Consistência

```
TAREFA: revisao_consistencia

Leia todos os arquivos em /mmorpg-project/mobs/ (exceto 0_TEMPLATE_MOB.md).
Leia /mmorpg-project/bible/mechanics.md.

Verifique e reporte:
1. Fichas com campos obrigatórios faltando
2. Mobs com HP/XP fora da faixa esperada para o nível
3. Mobs sem nenhum drop comum (chance > 30%)
4. IDs duplicados
5. Fichas com status "rascunho" há mais de 7 dias

Formato de resposta: lista por categoria, com nome do arquivo e problema encontrado.
```

---

## TAREFA: Listar Status das Fichas

```
TAREFA: listar_fichas

Liste todas as fichas em /mmorpg-project/mobs/ (exceto template).
Para cada uma, mostre: ID | Nome | Status | Zona | Nível

Formato: tabela markdown.
```

---

## TAREFA: Atualizar Campo de Ficha

```
TAREFA: atualizar_campo
ARQUIVO: [ex: MOB_004_Boitata.md]
CAMPO: [nome do campo]
VALOR_NOVO: [novo valor]
MOTIVO: [breve justificativa]

Atualize o campo indicado na ficha.
Adicione o motivo nas Notas de Design se for uma alteração de balanceamento.
Atualize a data de última atualização.
Confirme a alteração feita.
```
