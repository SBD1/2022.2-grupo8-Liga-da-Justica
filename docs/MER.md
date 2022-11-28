
## Versionamento

|Data | Versão | Autor | Alterações | 
|:--:|:------:| ----------------------------------------- | -------- | 
|25/11/2022|  1.0   |  [Matheus Soares](https://github.com/MtsSrs), [Vitor Manoel](https://github.com/Vitormanoel17) , [João Victor](https://github.com/CorreiaJV)  | Criação do documento MER | 
|27/11/2022|  1.1   | [João Victor](https://github.com/CorreiaJV) | Adição introdução do documento | 
|27/11/2022|  1.2   | [Matheus Soares](https://github.com/MtsSrs), [Matheus Perillo](https://github.com/MatheusPerillo) | Adição dos novos atributos |


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

## 2. Atributos
- **Personagem**: <ins>ID_Personagem</ins>, experiência, nível, nome, QTD_PontosDeVida, MAX_PontoDeVida, sexo, QTD_PontosDeStamina, MAX_PontosDeStamina, QTD_Honra, QTD_Defesa, QTD_Ataque, poderes, LocalAtual;
- **Raça**: <ins>ID_Raça</ins>, Nome, IND_Velocidade, IND_Furtividade, IND_Magia, IND_Força, IND_Carisma, IND_Percepção, personagem;
    - **Humano**
    - **Homi-Magi**
    - **Atlante**
    - **Amazonas** 
    - **Alien**
- **Classe**: <ins>ID_Classe</ins>, personagem;
    - **Velocista**: IND_Velocidade, IND_Percepção;
    - **Mágico**: IND_Magia, IND_Carisma;
    - **Combatente**: IND_Força, IND_Velocidade;
    - **Detetive**: IND_Furtividade, IND_Carisma, IND_Percepção;
    - **Brutamonte**: IND_Força, IND_Velocidade;
- **Facção**: <ins>ID_Facção</ins>,Nome, MULT_Honra, personagem;
- **NPC**: <ins>ID_NPC</ins>, Nome, personagem;
    - **Mercador**: Tipo;
    - **Inimigo**: Vida, Dano;
    - **Mentor**: MULT_Poder;
    - **Ajudante**: Vida, Dano;
- **Região**: <ins>ID_Região</ins>, Nome, posição_x, posição_y, LocalMapa;
- **Mapa**: <ins>ID_Mapa</ins>, Nome;
- **Inventário**: <ins>ID_Inventário</ins>, Capacidade, QTD_Atual, QTD_Dinheiro, dono;
- **Instância de Item**: <ins>ID_InstaItem</ins>, item_ref
- **Item**: <ins>ID_Item</ins>, Nome, Valor, Descrição, Min_Level;
    - **Equipamento**: tipo;
        - **Arma**: MULT_Ataque;
        - **Armadura**: MULT_Defesa;
        - **Acessório**: MULT_Poder;
    - **Consumível**: MULT_QTD_PontosDeVida, MULT_QTD_PontosDeStamina, MULT_Poder, MULT_Ataque.
- **Poderes**: <ins>ID_Poderes</ins>, Velocidade, Furtividade, Magia, Força, Carisma, Percepção.
- **Missão**: <ins>ID_Missão</ins>, Nível_min, REQ_Facção, REQ_Honra, personagem;

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

- Um personagem realiza nenhuma ou várias missões (0,n). Uma missão é realizada no mínimo um e no máximo por um personagem (1,1).

**Personagem negocia instância de item**

- Um personagem negocia uma ou várias instância de item (1,n). Uma instância de item pode ser negociada por somente um personagem.

**Inventário carrega Instância de Item**
- Um Inventário pode carregar nenhuma ou várias Instâncias de itens(0,n). Uma Instância de Item pode ser carregado por nenhum ou um inventário(0,1). 

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

**Mercador negocia com personagem**

- Um mercador negocia no mínimo com um e no máximo um personagem (1,1). Um personagem negocia no mínimo com um e no máximo um mercador (1,1).

**Ajudante ajuda personagem**

- Um ajudante ajuda no mínimo um e no máximo um personagem (1,1). Um personagem é ajudado mínimo um ou vários ajudantes (1,n).

**Mentor instrui personagem**

- Um mentor instrui no mínimo um e no máximo um personagem (1,1). Um personagem é instruído no mínimo por um e no máximo um mentor (1,1).

**Inimigo ataca personagem**

- Um inimigo ataca no mínimo um e no máximo um personagem (1,1). Um personagem ataca no mínimo um ou vários inimigos (1,n).
