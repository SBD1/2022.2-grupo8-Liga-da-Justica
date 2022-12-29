CREATE TABLE faccao (
    ID_faccao serial not null,
    Nome varchar(30) not null,
    MULT_honra int not null,
    personagem int not null,

    CONSTRAINT pk_faccao primary key (ID_faccao),
    CONSTRAINT sk_faccao unique (Nome),
    CONSTRAINT fk_personagem FOREIGN KEY (personagem) REFERENCES tb_personagem (id_personagem)
);

CREATE TABLE heroi(

) inherits(faccao);

CREATE TABLE vilao(

) inherits(faccao);


CREATE TABLE classe (
    ID_Classe serial primary key,
    CONSTRAINT fk_personagem FOREIGN KEY (personagem) REFERENCES tb_personagem (id_personagem)
);

CREATE TABLE velocista(
    IND_Percepcao int not null,
    IND_Velocidade int not null
) inherits(classe);


CREATE TABLE Magico(
    IND_Magia int not null,
    IND_Carisma int not null
) inherits(classe);


CREATE TABLE Combatente(
    IND_Forca int not null,
    IND_Velocidade int not null
)inherits(classe);


CREATE TABLE Detetive(
    IND_Furtividade int not null,
    IND_Carisma int not null,
    IND_percepcao int not null
)inherits(classe);


CREATE TABLE Brutamonte(
    IND_Forca int not null,
    IND_Velocidade int not null,
)inherits(classe);


insert into velocista(id_classe,personagem,ind_percepcao,ind_velocidade) values(1,1,45,70);
insert into velocista(id_classe,personagem,ind_percepcao,ind_velocidade) values(1,2,45,70);

insert into brutamonte(id_classe,personagem,ind_forca,ind_velocidade) values(2,3,70,20);
insert into brutamonte(id_classe,personagem,ind_forca,ind_velocidade) values(2,4,70,20);
insert into brutamonte(id_classe,personagem,ind_forca,ind_velocidade) values(2,5,70,20);

insert into detetive(id_classe,personagem,IND_Furtividade,IND_Carisma,ind_percepcao) values(3,6,70,40,40);
insert into detetive(id_classe,personagem,IND_Furtividade,IND_Carisma,ind_percepcao) values(3,7,70,40,40);
insert into detetive(id_classe,personagem,IND_Furtividade,IND_Carisma,ind_percepcao) values(3,8,70,40,40);

insert into magico(id_classe,personagem,IND_Magia, IND_Carisma) values(4,9,70,40);
insert into magico(id_classe,personagem,IND_Magia, IND_Carisma) values(4,10,70,40);

insert into combatente(id_classe,personagem, ind_forca,ind_velocidade) values (5,11,60,40);
