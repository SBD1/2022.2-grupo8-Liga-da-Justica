
## Versionamento

|Data | Versão | Autor | Alterações | 
|:--:|:------:| ----------------------------------------- | -------- | 
|25/11/2022|  1.0   |  [Matheus Soares](https://github.com/MtsSrs), [Vitor Manoel](https://github.com/Vitormanoel17) , [João Victor](https://github.com/CorreiaJV)  | Criação do documento MER | 
|27/11/2022|  1.1   | [João Victor](https://github.com/CorreiaJV) | Adição introdução do documento | 
|27/11/2022|  1.2   | [Matheus Soares](https://github.com/MtsSrs), [Matheus Perillo](https://github.com/MatheusPerillo) | Adição dos novos atributos |
|06/02/2023|  1.3   | [Matheus Soares](https://github.com/MtsSrs) | Revisão final e adição de atributos |


# Modelo Entidade-Relacionamento

O Modelo Entidade Relacionamento para bancos de dados é um modelo que descreve os objetos (entidades) envolvidos em um negócio, com suas características (atributos) e como elas se relacionam entre si (relacionamentos).

## 1. Entidades
- **Personagem**
- **Raça**
    - **Humano**
    - **Homi-Magi**
    - **Atlante**
    - **Amazonas**
    - **Alien**
- **Classe**
    - **Velocista** 
    - **Mágico** 
    - **Combatente** 
    - **Detetive** 
    - **Brutamonte**
- **Facção**
    - **Herói**
    - **Vilão**
- **NPC**
    - **Inimigo**
    - **Mercador**
    - **Mentor**
    - **Ajudante**
- **Região**
- **Mapa**
- **Inventário**
- **Instância de Item**
- **Item**
    - **Equipamento**
        - **Armas**
        - **Armadura**
        - **Acessórios**
    - **Consumível**
- **Poderes**
- **Missão**
- **Batalha**

## 2. Atributos
- **Personagem**: <ins>ID_Personagem</ins>, experiência, nível, nome, QTD_PontosDeVida, MAX_PontoDeVida, sexo, QTD_PontosDeStamina, MAX_PontosDeStamina, QTD_Honra, QTD_Defesa, QTD_Ataque,QTD_Mortes, id_Local_Atual, id_mentor, id_classe, id_faccao, id_raca, id_ajudante, poderes, arma_atual, armadura_atual, acessorio_atual, LocalAtual;
- **Raça**: <ins>ID_Raça</ins>, Nome;
    - **Humano**
    <ins>ID_Raça</ins>, nome, IND_carisma, IND_percepcao, IND_furtividade;
    - **Homi-Magi**
    <ins>ID_Raça</ins>, nome, IND_magia, IND_percepcao, IND_velocidade;
    - **Atlante**
    <ins>ID_Raça</ins>, nome, IND_forca, IND_furtividade, IND_velocidade
    - **Amazonas** 
    <ins>ID_Raça</ins>, nome, IND_forca, IND_carisma, IND_velocidade;
    - **Alien**
    <ins>ID_Raça</ins>, nome, IND_forca, IND_percepcao, IND_velocidade;
- **Classe**: 
    <ins>ID_Classe</ins>, nome;
    - **Velocista**:
    <ins>ID_Classe</ins>, nome,IND_Percepcao, IND_Velocidade;
    - **Mágico**: 
    <ins>ID_Classe</ins>, nome, IND_Magia, IND_Carisma;
    - **Combatente**:
    <ins>ID_Classe</ins>, nome, IND_Forca, IND_Velocidade;
    - **Detetive**:
    <ins>ID_Classe</ins>, nome, IND_Furtividade, IND_Carisma, IND_percepcao;
    - **Brutamonte**:
    <ins>ID_Classe</ins>, nome,IND_Forca, IND_Velocidade;
- **Facção**: <ins>ID_Facção</ins>,Nome;
    - **Herói**:
    <ins>ID_Facção</ins>,Nome, MULT_honra;
    - **Vilão**
    <ins>ID_Facção</ins>,Nome, MULT_honra;
- **NPC**: <ins>ID_NPC</ins>, Nome, id_regiao;
    - **Mercador**:
    <ins>ID_NPC</ins>, Nome, id_regiao, tipo, id_instancia_item, req_honra_min, req_honra_max, desconto;
    - **Inimigo**:
    <ins>ID_NPC</ins>, Nome, id_regiao, vida, dano, experiencia, tempo TIMESTAMP, id_faccao;
    - **Mentor**:
    <ins>ID_NPC</ins>, Nome, id_regiao, id_classe, id_faccao, MULT_poder;
    - **Ajudante**:
    <ins>ID_NPC</ins>, Nome, id_regiao, vida, dano;
- **Região**: <ins>ID_Região</ins>, Nome, posição_x, posição_y, LocalMapa;
- **Mapa**: <ins>ID_Mapa</ins>, Nome;
- **Inventário**: <ins>ID_Inventário</ins>, Capacidade, QTD_Atual, QTD_Dinheiro, id_personagem;
- **Instância de Item**: <ins>ID_InstaItem</ins>, id_item_ref, id_inventario;
- **Item**: <ins>ID_Item</ins>, Nome, Valor, Descrição, Min_Level;
    - **Equipamento**:<ins>ID_Item</ins>, id_item, nome, descricao, valor, min_level, tipo;
        - **Arma**: <ins>id_equipamento</ins>, nome, descricao, valor, min_level, tipo, MULT_ataque;
        - **Armadura**: <ins>id_equipamento</ins>, nome, descricao, valor, min_level, tipo, MULT_defesa;
        - **Acessório**: <ins>id_equipamento</ins>, nome varchar(50) not null, descricao, valor, min_level, tipo, MULT_Poder;
    - **Consumível**: <ins>ID_Item</ins>, nome, descricao, valor, min_level, MULT_ataque, MULT_poder, MULT_qtd_PontosDeVida, MULT_qtd_PonstosDeStamina;
- **Poderes**: <ins>ID_Poderes</ins>, Velocidade, Furtividade, Magia, Força, Carisma, Percepção.
- **Missão**: <ins>ID_Missão</ins>, Nível_min, REQ_Facção, REQ_Honra, personagem, id_instancia_item;
- **Batalha**: <ins>ID_Batalha</ins>, id_npc_inimigo, id_personagem, vencedor;
## 3. Relacionamentos

**Personagem possui Classe**
- Um Personagem pode possuir no mínimo uma classe, e no máximo uma classe (1,1). Uma Classe pode ser pertencida por  no mínimo nenhum personagem ou vários (0,n);

**Personagem pertence Raça**
- Um Personagem pode pertencer a no mínimo uma Raça, e no máximo uma Raça (1,1). Uma Raça pode ser pertencida por  no mínimo nenhum personagem ou vários (0,n);

**Personagem possui Poderes**
- Um Personagem pode possuir nenhum ou no máximo um poder(0,1). Um poder pode ser pertencido por nenhum ou vários personagens(0,n);

**Personagem pertence Facção**
- Um Personagem pode pertencer a no mínimo uma Facção, e no máximo uma Facção (1,1). Uma Facção pode ser pertencida por  no mínimo nenhum personagem ou vários (0,n);

**Personagem possui Inventário**

- Um personagem pode carregar no mínimo um inventário, e no máximo um inventário (1,1). Um inventário só pode ser carregado por um personagem (1,1).

**Personagem realiza missão**

- Um personagem realiza uma ou várias missões (1,n). Uma missão é realizada no mínimo um ou por vários personagens (1,n).

**Personagem negocia instância de item**

- Um personagem negocia uma ou várias instância de item (1,n). Uma instância de item pode ser negociada por somente um personagem.

**Inventário carrega Instância de Item**
- Um Inventário pode carregar nenhuma ou várias Instâncias de itens(0,n). Uma Instância de Item pode ser carregado por nenhum ou um inventário(0,1). 

**Mercador carrega Instância de Item**
- Um mercador carrega uma ou várias instâncias de item(1,n). Uma Instância de item é carregada somente por um mercador (1,1).

**Instancia_Item referencia Item**

- Uma instância de item pode referenciar somente um item (1,1). Um item pode ser referenciado por nenhuma instancia de item ou várias (0,n).

**Missão recompensa instância de item**

- Uma missão recompensa nenhuma ou várias instância de item (0,n). Uma insância de item pode ser recompensada em uma ou várias missões (1,n).

**Região contém Personagem**

- Uma região pode conter nenhum personagem ou vários (0,n). Um personagem pode estar contido em somente uma região (1,1).

**Região contem NPC**

- Uma região pode conter nenhum NPC ou vários (0,n). Um NPC pode estar contido em somente uma região (1,1).

**Mapa contem Região**

- Um mapa pode conter no mínimo uma região ou várias (1,n). Uma região pode estar contido em somente um mapa (1,1).

**NPC contém Missão**

- Um NPC pode conter no mínimo uma ou mais missões (1,n). Uma missão pode conter no mínimo a um NPC ou vários (0,n).

**Ajudante ajuda personagem**

- Um ajudante ajuda no mínimo um e no máximo um personagem (1,1). Um personagem é ajudado mínimo um ou vários ajudantes (1,n).

**Mentor instrui personagem**

- Um mentor instrui no mínimo um e no máximo um personagem (1,1). Um personagem é instruído no mínimo por um e no máximo um mentor (1,1).

**Inimigo ataca personagem**

- Um inimigo ataca no mínimo um e no máximo um personagem (1,1). Um personagem ataca no mínimo um ou vários inimigos (1,n).
