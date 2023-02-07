  ## Versionamento
  |Data|Versão|Autor|Alteração| 
  |----|------|---------|-----|
  |27/11/2022|1.0| [João Victor](https://github.com/CorreiaJV),  [Matheus Soares](https://github.com/MtsSrs),  [Matheus Perillo](https://github.com/MatheusPerillo), [Vitor Manoel](https://github.com/Vitormanoel17) , [Iago Cabral](https://github.com/iagocabral) | Versão Inicial do Dicionário de Dados|
  |27/11/2022|  1.1   | [João Victor](https://github.com/CorreiaJV) | Adição introdução do documento |
  |27/11/2022|  1.2   | [Matheus Soares](https://github.com/MtsSrs), [Matheus Perillo](https://github.com/MatheusPerillo) | Adição das chaves estrangeiras |
|27/11/2022|  1.3   | [Matheus Soares](https://github.com/MtsSrs), [João Victor](https://github.com/CorreiaJV)  | Revisão final e Adição de vocábulos faltantes |
 
# Dicionário de Dados
<p style="text-align: justify"> É o conjunto dos vocábulos ou dos termos utilizados na descrição dos objetos modelados para o banco de dados. Os termos são dispostos com o seu respectivo significado para apresentar uma descrição textual da estrutura lógica e física do banco de dados.
</p>

<br/>

## Entidade: Personagem
#### Descrição: Personagem principal, será manuseado pelo jogador.


|Variável| Nome Variável | Tipo | Descrição | Valores Permitidos | Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: |
|ID do personagem  | ID | int | Identificação do personagem | 1-100 | não |
| Experiência do personagem | Experiencia | int | Quantidade de experiência do personagem | 1-1000 | não |
| Nível do personagem | Nivel | int | Nível atual do personagem | 1-10 | não|
| Nome do personagem | Nome | varchar | Nome do personagem jogável | 3-30 | não | 
| Quantidade de pontos de vida | QTD_PontosDeVida | int | Quantidade atual de vida do personagem | 0-150 | não | 
| Máximo pontos de vida | MAX_PontoDeVida | int | Quantidade máxima de vida do personagem | 50-150 | não | 
| Sexo do personagem | sexo | int | Identificador do sexo do personagem| '1' = masculino '2' = feminino| não |
| Quantidade de pontos de Estamina | QTD_PontosDeEstamina | int | Quantidade atual de pontos de stamina do personagem | 0-100 | não | 
| Máximo quantidade de Estamina | MAX_PontosDeEstamina | int | Quantidade máxima de stamina do personagem | 50-100 | não |
| Honra | QTD_Honra | int | Quantidade de honra que o personagem possui | 1-100 | não |
| Defesa | QTD_Defesa | int | Quantidade de defesa que o personagem possui | 0-100 | não | 
| Quantidade de ataque | QTD_Ataque | int | Quantidade de ataque que o personagem possui | 1-100 | não | 
| Referência de ataque | poderes | int | Referência do poder do personagem | 0-3 | não |
|Identificador de Região| Local_Atual | int | Identificador Único de Região| '1'= Gotham '2'= Metrópoles | não |
| Quantidade de Morte | QTD_mortes | int | Quantidade de mortes do personagem | 0 - 1000 | sim |
| ID do poder | ID_poder | int | Chave estrangeira da tabela de poderes | 1-100 | não |
| ID local atual | id_local_atual | int | Chave estrangeira da tabela de região | 1-100 | não |
| ID do ajudante | ID_ajudante | int | Chave estrangeira da tabela de npc ajudante | 1-10 | sim |
| ID do mentor | ID_mentor | int | Chave estrangeira da tabela de npc mentor | 1-10 | não |
| ID da classe | ID_classe | int | Chave estrangeira da tabela de classe | 1-5| não |
| ID da Facção | ID_faccao | int | Chave estrangeira da tabela de Facção | 1-2| não |
| ID da Raça | ID_raca| int | Chave estrangeira da tabela de Raça | 1-5| não |
| Arma atual | arma_atual | int | Chave estrangeira da tabela de Item | 1-50 | sim |
| Armadura atual | armadura_atual | int | Chave estrangeira da tabela de Item | 1-50 | sim |
| Acessorio atual | acessorio_atual | int | Chave estrangeira da tabela de Item | 1-50 | sim |


## Entidade: Raça
#### Descrição: Conjunto de características intrínsecas do personagem alterando seus indicadores de poderes naturais.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? |
| :----: | :----: | :----: | :----: | :----: | :----: |
| Id da raça  | ID_Raça | int | Identificador da raça | 1 - 5 | não | 
| Nome | nome | varchar | Nome da raça | 1-10 | não | 
| Indicador de Velocidade| IND_velocidade| int | Indicador de incremento de velocidade| 1 - 100 | não | 
| Indicador de Furtividade| IND_furtividade| int | Indicador de incremento de furtividade| 1 - 100 | não | 
| Indicador de Magia| IND_magia| int | Indicador de incremento de magia| 1 - 100 | não | 
| Indicador de Força| IND_forca| int | Indicador de incremento de força| 1 - 100 | não | 
| Indicador de Carisma| IND_carisma| int | Indicador de incremento de carisma| 1 - 100 | não | 
| Indicador de Percepção| IND_percepcao| int | Indicador de incremento de percepção| 1 - 100 | não | 




## Entidade: Classe
#### Descrição: Modifica a forma de um personagem perceber e interagir com o mundo, bem como seu relacionamento com as outras pessoas e os possíveis poderes

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? |
| :----: | :----: | :----: | :----: | :----: | :----: | 
|Identificador de Classe| ID_Classe | int | Identificador Único de Classe | 1 - 5 | não | 
|nome da classe | nome | varchar | Identificação da classe| 1-30 | não |

## Entidade: Velocista
#### Descrição: Classe com indicadores de velocidade e percepção que alteram os poderes do jogador

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? |
| :----: | :----: | :----: | :----: | :----: | :----: |
|Indicador de Percepção| IND_Percepcao| int | Indicador de incremento de Percepção| 1 - 100 | não | 
|Indicador de Velocidade| IND_Velocidade| int | Indicador de incremento de Velocidade| 1 - 100 | não | 
|Identificador de Classe| ID_Classe | int |Chave estrengeira de classe| 1 - 5 | não | 
|nome da classe | nome | varchar | Identificação da classe| 1-30 | não |

## Entidade: Mágico
#### Descrição: Classe com indicadores de magia e carisma que alteram os poderes do jogador

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
|Indicador de Magia| IND_Magia| int | Indicador de incremento de Magia| 1 - 100 | não | 
|Indicador de Carisma| IND_Carisma| int | Indicador de incremento de Carisma| 1 - 100 | não | 
|Identificador de Classe| ID_Classe | int |Chave estrengeira de classe| 1 - 5 | não | 
|nome da classe | nome | varchar | Identificação da classe| 1-30 | não |

## Entidade: Combatente
#### Descrição: Classe com indicadores de força e velocidade que alteram os poderes do jogador


|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
|Indicador de Força| IND_Forca| int | Indicador de incremento de Força| 1 - 100 | não | 
|Indicador de Velocidade| IND_Velocidade| int | Indicador de incremento de Velocidade| 1 - 100 | não | 
|Identificador de Classe| ID_Classe | int |Chave estrengeira de classe | 1 - 5 | não | 
|nome da classe | nome | varchar | Identificação da classe| 1-30 | não |

## Entidade: Detetive
#### Descrição: Classe com indicadores de furtividade,carisma e percepção que alteram os poderes do jogador 

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
| Indicador de furtividade | IND_furtividade | int | Indicador de incremento de furtividade | 1 - 100 | não |  |
|Indicador de Carisma| IND_Carisma| int | Indicador de incremento de Carisma| 1 - 100 | não | 
|Indicador de Percepção| IND_Percepcao| int | Indicador de incremento de Percepção| 1 - 100 | não | 
|Identificador de Classe| ID_Classe | int |Chave estrengeira de classe | 1 - 5 | não | 
|nome da classe | nome | varchar | Identificação da classe| 1-30 | não |

## Entidade: Brutamonte
#### Descrição: Classe com indicadores de força e velocidade que alteram os poderes do jogador

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
| Indicador de força | IND_Forca | int | Indicador de incremento de força | 1 - 100 | não |  |
|Indicador de Velocidade| IND_velocidade| int | Indicador de incremento de velocidade|1 - 100 | não | 
|Identificador de Classe| ID_Classe | int |Chave estrengeira de classe | 1 - 5 | não | 
|nome da classe | nome | varchar | Identificação da classe| 1-30 | não |

## Entidade: Facção
#### Descrição: Grupo de indivíduos unidos em prol de uma causa, nesse universo o personagem opta por heróis ou vilões 

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
| identificador de facção | ID_Faccao  | int | Identificador único de facção | '1'=Herói '2'=Vilão| não | 
| Nome | Nome | varchar | Nome da facção | 3-30 | não | 


## Entidade: NPC
#### Descrição: Personagem não jogável.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
|Identificador de NPC| ID_NPC | int | Identificador Único de NPC| 1-4 | não | 
| Nome | Nome | varchar | Nome do NPC| 3-30 | não | 
|ID da região  | id_regiao | int | Chave estrangeira da tabela de região, Identificação da região do npc | 1-100 | não |

## Entidade: Mercador
#### Descrição: NPC negocia itens.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
| Tipo| Tipo | varchar | Classificação do Mercador| 3-30 | sim |
| Nome | Nome | varchar | Nome do NPC| 3-30 | não | 
| ID da região  | id_regiao | int | Chave estrangeira da tabela de região, Identificação da região do npc | 1-100 | não |
| ID do npc | ID_npc | int | Chave estrangeira da tabela de npc | 1-100| não |
| ID da instancia de item | id_instancia_item | int | Chave estrangeira da tabela de instancia de item | 1-50 | não |
| Requisito de honra minimo | req_honra_min | int | Quantidade minima de honra | 0-100 | não |
| Requisito de honra máximo | req_honra_min | int | Quantidade maximo de honra | 0-100 | não |
| Desconto | desconto | int | Quantidade de desconto | 0-10 | não |


## Entidade: Inimigo
#### Descrição: NPC hostil ao jogador.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
| ID do npc | ID_npc | int | Chave estrangeira da tabela de npc | 1-100 | não|
| Nome | Nome | varchar | Nome do NPC| 3-30 | não | 
|Vida| Vida | int | Indicador de Vida atual do Inimigo| 0 - 100 | não | 
|Dano| Dano | int | Indicador de Dano causado pelo inimigo | 1 - 100 | não | 
| Experiência do inimigo | experiencia | int | Indicador de quantidade de experiência do inimigo | 0-100 | não |
| Tempo | tempo | timestamp | Indicador de tempo do inimigo | 00:00 - 23:59 | não |
| Id Facção | id_faccao | int | Chave estrangeira para tabela de facção | 1-2 | não |

## Entidade: Mentor
#### Descrição: NPC que instrui e ajuda o personagem

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
|ID do npc | ID_npc | int | Chave estrangeira da tabela de npc | 1-100 | não|
| Nome | Nome | varchar | Nome do NPC| 3-30 | não | 
| Multiplicador de Poder | MULT_Poder | int | Multiplicador do atributo de Poder do personagem | 1 - 5 | não |  
| Id Facção | id_faccao | int | Chave estrangeira para tabela de facção | 1-2 | não |
| Id Classe | id_classe | int | Chave estrangeira para tabela de classe | 1-5 | não |


## Entidade: Ajudante
#### Descrição: NPC que pode ajudar o personagem em momentos específicos 

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
|Vida| Vida | int | Indicador de Vida atual do Inimigo| 0 - 100 | não | 
|Dano| Dano | int | Indicador de Dano causado pelo inimigo | 1 - 100 | não | 
|ID do npc | ID_npc | int | Chave estrangeira da tabela de npc | 1-100 | não|
| Nome | Nome | varchar | Nome do NPC| 3-30 | não | 

## Entidade: Região
#### Descrição: Local em que o jogador está e pode explorar.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
|Identificador de Região| ID_Regiao | int | Identificador Único de Região| '1'= Gotham '2'= Metrópoles | não | 
| Nome | Nome | varchar | Nome da Região | 3-30 | não | 
| Posição X | posicao_x | int | Posição no eixo x dentro da região | 0 - 200 | não | 
| Posição Y | posicao_y | int | Posição no eixo y dentro da região | 0 - 200 | não | 
|Identificador de Mapa| LocalMapa | varchar | Identificador Único de Mapa| 1 | não |

## Entidade: Mapa
#### Descrição: Conjunto de regiões.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
|Identificador de Mapa| ID_Mapa | varchar | Identificador Único de Mapa| 1 | não | 
| Nome | Nome | varchar | Nome do Mapa | 3-30 | não | 


## Entidade: Inventário
#### Descrição: Espaço para guardar itens e dinheiro do personagem.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: |
| ID do inventário | ID_Inventário | int | Identificação do inventário | 1 - 3 | não |   
| Capacidade do inventário | Capacidade | int | Tamanho do inventário | 1 - 100 | Não | 
| Quantidade atual de itens | QTD_Atual | int | Quantidade atual de itens no inventário do personagem | 0 - 100 | sim | 
| Quantidade de dinheiro disponível | QTD_Dinheiro | int | Quantidade de dinheiro disponível no inventário do personagem | 0 - 99999 | sim | 
| Id personagem | id_personagem | int | Chave estrangeira para tabela de personagem | 1-100 | não |

## Entidade: Instância de Item
#### Descrição: Referência de um dos possíveis itens do jogo.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
| ID da instância do item | ID_InstaItem | int | Identificação da instância do item no inventário do personagem | 0-50 | não |
| ID do inventário | ID_Inventário | int | Chave estrangeira para tabela de inventário | 1 - 3 | sim |
|Referência de Item| item_ref | int | Chave estrangeira para tabela de item| 0 - 500 | não |

## Entidade: Item
#### Descrição: Itens que um jogador pode ter.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: |
|Identificador de Item| ID_Item | int | Identificador Único de Item| 0 - 500 | não |
| Nome | Nome | varchar | Nome do Item | 3 - 30 | não |
| Valor | Valor| int | Valor Monetário para adquirir o item | 1 - 500| sim |
|Descrição| descricao | varchar | Descrição em texto sobre o Item | 1 - 100 | sim |
| Nível Minímo | Min_Level | int | Nível requisitado para adquirir um item | 1 - 30 | sim | 

## Entidade: Equipamento
#### Descrição: Itens equipáveis.
|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: |
| ID do equipamento | id | int | identificador do equipamento | 1 - 50| não |
| ID do item | id_item | int | chave estrangeira para tabela do item | 1 - 50 | não |
| Nome | Nome | varchar | Nome do Item | 3 - 30 | não |
|Descrição| descricao | varchar | Descrição em texto sobre o Item | 1 - 100 | sim |
| Valor | Valor| int | Valor Monetário para adquirir o item | 1 - 500| sim |
| Nível Minímo | Min_Level | int | Nível requisitado para adquirir um item | 1 - 30 | sim | 
| Tipo| Tipo | varchar | Classificação do equipamento | 3-30 | sim |

## Entidade: Arma
#### Descrição: Item equipável que aumenta o dano de ataque do personagem.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: |
| Multiplicador de Ataque | MULT_Ataque | int | Multiplicador do atributo de ataque do personagem| 1 - 5 | não|
| ID do equipamento | id_equipamento | int | Chave estrangeira para equipamento | 1 - 50| não | 
| Nome | Nome | varchar | Nome do Item | 3 - 30 | não |
|Descrição| descricao | varchar | Descrição em texto sobre o Item | 1 - 100 | sim |
| Valor | Valor| int | Valor Monetário para adquirir o item | 1 - 500| sim |
| Nível Minímo | Min_Level | int | Nível requisitado para adquirir um item | 1 - 30 | sim | 
| Tipo| Tipo | varchar | Classificação do equipamento | 3-30 | sim |

## Entidade: Armadura
#### Descrição: Item equipável que aumenta a defesa do personagem.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: |
| Multiplicador de Defesa | MULT_Defesa | int | Multiplicador do atributo de Defesa do personagem| 1 - 5 | não|
| ID do equipamento | id_equipamento | int | Chave estrangeira para equipamento | 1 - 50| não | 
| Nome | Nome | varchar | Nome do Item | 3 - 30 | não |
|Descrição| descricao | varchar | Descrição em texto sobre o Item | 1 - 100 | sim |
| Valor | Valor| int | Valor Monetário para adquirir o item | 1 - 500| sim |
| Nível Minímo | Min_Level | int | Nível requisitado para adquirir um item | 1 - 30 | sim | 
| Tipo| Tipo | varchar | Classificação do equipamento | 3-30 | sim |


## Entidade: Acessório 
#### Descrição: Item equipável que aumenta o poder do personagem.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: |
| Multiplicador de Poder | MULT_Poder | int | Multiplicador do atributo de Poder do personagem| 1 - 5 | não|
| ID do equipamento | id_equipamento | int | Chave estrangeira para equipamento | 1 - 50| não | 
| Nome | Nome | varchar | Nome do Item | 3 - 30 | não |
|Descrição| descricao | varchar | Descrição em texto sobre o Item | 1 - 100 | sim |
| Valor | Valor| int | Valor Monetário para adquirir o item | 1 - 500| sim |
| Nível Minímo | Min_Level | int | Nível requisitado para adquirir um item | 1 - 30 | sim | 
| Tipo| Tipo | varchar | Classificação do equipamento | 3-30 | sim |


## Entidade: Consumível 
#### Descrição: Item utilizado apenas uma vez que melhora algum atributo e/ou poder do personagem.

|Variável| Nome Variável | Tipo | Descrição | Valores permitidos| Possui valores nulo? | 
| :----: | :----: | :----: | :----: | :----: | :----: | 
| ID do item | id_item | int | chave estrangeira para tabela do item | 1 - 50 | não |
| Multiplicador do pontos de vida | MULT_QTD_PontosDeVida |int| Consumível que aumenta a quantidade de vida | 0 - 100  | não |
| Multiplicador do pontos de estâmina | MULT_QTD_PontosDeEstamina | int |Consumível que aumenta os pontos de estâmina  |  0 - 100| não |
| Multiplicador do pontos de poder | MULT_Poder | int |Consumível que aumenta a quantidade de pontos de poder | 0 - 100 | não | 
| Multiplicador do pontos de ataque | MULT_Ataque | int | Consumível que aumenta a quantidade dos pontos de poder | 0 - 100 | não |
| Nome | Nome | varchar | Nome do Item | 3 - 30 | não |
|Descrição| descricao | varchar | Descrição em texto sobre o Item | 1 - 100 | sim |
| Valor | Valor| int | Valor Monetário para adquirir o item | 1 - 500| sim |
| Nível Minímo | Min_Level | int | Nível requisitado para adquirir um item | 1 - 30 | sim | 


## Entidade: Poderes
#### Descrição: Poderes distintos atribuídos a personagens diferentes.

|Variável| Nome Variável| Tipo | Descrição | Valores permitidos| Possui valores nulo? |
| :----: | :----: | :----: | :----: | :----: | :----: | 
| ID do poder | ID_Poderes | int  | Identificação do poder do personagem| 0 - 3 | não | 
| Poder de velocidade | Velocidade | int | Poder de velocidade do personagem | 0 - 100 | sim | 
| Poder de furtividade | Furtividade  | int | Poder de furtividade do personagem | 0 - 100 | sim | 
| Poder de magia | Magia | int | Poder de magia do personagem | 0 - 100 | sim | 
| Poder de força | Força | int | Poder de força do personagem | 0 - 100 | sim | 
| Poder de carisma | Carisma | int | Poder de carisma do personagem | 0 - 100 | sim | 
| Poder de percepção | Percepção | int | Poder de percepção do personagem | 0 - 100 | sim | 

## Entidade: Missão
#### Descrição: Missões a serem cumpridas pelo personagem.

|Variável| Nome Variável| Tipo | Descrição | Valores permitidos| Possui valores nulo? |
| :----: | :----: | :----: | :----: | :----: | :----: | 
| ID da missão| ID_Missão | int  | Identificação das missões| 1 - 95 | não | 
| Nivel Mínimo  |Nível_min  | int  | Nível mínimo do personagem para  realizar essa missão |1 - 30 | sim | 
| Requisito de Facção  | REQ_Facção| Boolean | Requisito da necessidade de ter uma facção para realizar a missão  | 1 - 2  | sim |
| Requisito de Honra | REQ_Honra | int |Requisito da necessidade de ter uma quantidade miníma de honra para realizar a missão |1 - 100 | sim | 
|ID do personagem  | personagem | int | Identificação do personagem | 1-3 | não |
