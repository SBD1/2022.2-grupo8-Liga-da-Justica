# Modelo Entidade-Relacionamento

## 1. Versionamento
|Data | Versão | Autor | Alterações | 
|:--:|:------:| ----------------------------------------- | -------- | 
|25/11/2022|  1.0   | Matheus Soares & João Victor Correia & Vitor Manoel | Criação do documento MER | 

<div style="text-align: center">
<p>Tabela 1: Versionamento</p>
</div>

## 2. Entidades
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

## 3. Atributos
- **Personagem**: <ins>ID_Personagem</ins>, experiência, nível, nome, QTD_PontosDeVida, MAX_PontoDeVida, sexo, QTD_PontosDeStamina, MAX_PontosDeStamina, QTD_Honra, QTD_Defesa, QTD_Ataque;
- **Raça**: <ins>ID_Raça</ins>, Nome, IND_Velocidade, IND_Furtividade, IND_Magia, IND_Força, IND_Carisma, IND_Percepção;
    - **Humano**
    - **Homi-Magi**
    - **Atlante**
    - **Amazonas** 
    - **Alien**
- **Classe**: <ins>ID_Classe</ins>;
    - **Velocista**: IND_Velocidade, IND_Percepção;
    - **Mágico**: IND_Magia, IND_Carisma;
    - **Combatente**: IND_Força, IND_Velocidade;
    - **Detetive**: IND_Furtividade, IND_Carisma, IND_Percepção;
    - **Brutamonte**: IND_Força, IND_Velocidade;
- **Facção**: <ins>ID_Facção</ins>,Nome, MULT_Honra;
- **NPC**: <ins>ID_NPC</ins>, Nome;
    - **Mercador**: Tipo;
    - **Inimigo**: Vida, Dano;
    - **Mentor**: MULT_Poder;
    - **Ajudante**: Vida, Dano;
- **Região**: <ins>ID_Região</ins>, Nome, posição_x, posição_y;
- **Mapa**: <ins>ID_Mapa</ins>, Nome;
- **Inventário**: <ins>ID_Inventário</ins>, Capacidade, QTD_Atual, QTD_Dinheiro;
- **Instância de Item**: <ins>ID_InstaItem</ins>
- **Item**: <ins>ID_Item</ins>, Nome, Valor, Descrição, Min_Level;
    - **Equipamento**
        - **Arma**: MULT_Ataque;
        - **Armadura**: MULT_Defesa;
        - **Acessório**: MULT_Poder;
    - **Consumível**: MULT_QTD_PontosDeVida, MULT_QTD_PontosDeStamina, MULT_Poder, MULT_Ataque.
- **Poderes**: <ins>ID_Poderes</ins>, Velocidade, Furtividade, Magia, Força, Carisma, Percepção.
- **Missão**: <ins>ID_Missão</ins>, Nível_min, REQ_Facção, REQ_Honra;

## 4. Relacionamentos

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

**Inventário carrega Instância de Item**
- Um Inventário pode carregar nenhuma ou várias Instâncias de itens(0,n). Uma Instância de Item pode ser carregado por nenhum ou um inventário(0,1). 

**Instancia_Item referencia Item**

- Uma instância de item pode referenciat somente um item (1,1). Um item pode ser referenciado por nenhuma instancia de item ou várias (0,n).

**Região contém Personagem**

- Uma região pode conter nenhum personagem ou vários (0,n). Um personagem pode estar contido em somente uma região (1,1).

**Região contem NPC**

- Uma região pode conter nenhum NPC ou vários (0,n). Um NPC pode estar contido em somente uma região (1,1).

**Mapa contem Região**

- Um mapa pode conter no mínimo uma região ou várias (1,n). Uma região pode estar contido em somente um mapa (1,1).
