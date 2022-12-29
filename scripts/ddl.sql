-- Multiply
CREATE TYPE multiply_poder AS ENUM ('1', '2', '3', '4', '5');

--Mapa
create table tb_mapa(
	id serial constraint pk_id_mapa primary key,
   	nome varchar(50) not null
);

-- Região
create table tb_regiao(
	id serial constraint pk_id_regiao primary key,
   	nome varchar(30) not null,
   	posicao_x int not null,
   	posicao_y int not null,
   	id_localMapa int not null,
   	constraint  fk_LocalMapa foreign key(id_localMapa)  references tb_mapa (id)
);

--poder
create table tb_poderes(
	id serial constraint pk_id_poder primary key,
	Velocidade int,
	Furtividade int,
	Magia int,
	Forca int,
	Carisma int,
	Percepcao int
);

-- Personagem
create table tb_personagem(
	id serial constraint pk_id_personagem primary key,
	experiencia int not null,
	nivel int not null,
	nome varchar(30) not null,
	QTD_PontosDeVida int not null,
	MAX_PontoDeVida int not null,
	sexo int not null,
	QTD_PontosDeEstamina int not null,
	MAX_PontosDeEstamina int not null,
	QTD_Honra int not null,
	QTD_Defesa int not null,
	QTD_Ataque int not null,
	id_poderes int not null,
	constraint fk_poderes foreign key(id_poderes) references tb_poderes (id),
	id_Local_Atual int not null,
	constraint fk_Local_Atual foreign key(id_Local_Atual) references tb_regiao (id)
);

-- Raça
create table tb_raca(
   id serial constraint pk_id_raca primary key,
   nome varchar(10) not null,
   id_personagem int not null,
   constraint fk_personagem foreign key(id_personagem) references tb_personagem (id)
);

-- Humano
create table tb_humano(
	IND_carisma int not null,
	IND_percepcao int not null,
	IND_furtividade int not null
) inherits(tb_raca);

-- Homi-Magi
create table tb_homi_magi(
	IND_magia int not null,
	IND_percepcao int not null,
	IND_velocidade int not null
) inherits(tb_raca);

-- Atlante
create table tb_atlante(
	IND_forca int not null,
	IND_furtividade int not null,
	IND_velocidade int not null
) inherits(tb_raca);

-- Amazonas
create table tb_amazonas(
	IND_forca int not null,
	IND_carisma int not null,
	IND_velocidade int not null
) inherits(tb_raca);

-- Alien 
create table tb_alien(
	IND_forca int not null,
	IND_percepcao int not null,
	IND_velocidade int not null
) inherits(tb_raca);

CREATE TABLE tb_faccao (
    ID_faccao serial not null,
    Nome varchar(30) not null,
    id_personagem int not null,
    CONSTRAINT pk_faccao primary key (ID_faccao),
    CONSTRAINT sk_faccao unique (Nome),
    CONSTRAINT fk_personagem FOREIGN KEY (id_personagem) REFERENCES tb_personagem (id)
);

-- Heroi 
CREATE TABLE tb_heroi(
	MULT_honra int not null
) inherits(tb_faccao);

-- Vilao
CREATE TABLE tb_vilao(
	MULT_honra int not null
) inherits(tb_faccao);

-- Classe
CREATE TABLE tb_classe (
    ID_Classe serial primary key,
    id_personagem int not null,
    CONSTRAINT fk_personagem FOREIGN KEY (id_personagem) REFERENCES tb_personagem (id)
);

-- Velocista
CREATE TABLE tb_velocista(
    IND_Percepcao int not null,
    IND_Velocidade int not null
) inherits(tb_classe);

-- Magico
CREATE TABLE tb_magico(
    IND_Magia int not null,
    IND_Carisma int not null
) inherits(tb_classe);

-- Combatente
CREATE TABLE tb_combatente(
    IND_Forca int not null,
    IND_Velocidade int not null
)inherits(tb_classe);

-- Detetive
CREATE TABLE tb_detetive(
    IND_Furtividade int not null,
    IND_Carisma int not null,
    IND_percepcao int not null
)inherits(tb_classe);

-- Brutamonte
CREATE TABLE tb_brutamonte(
    IND_Forca int not null,
    IND_Velocidade int not null
)inherits(tb_classe);

-- Item
create table tb_item(
id serial constraint pk_id_item primary key,
nome varchar(50) not null,
descricao varchar(100),
valor int,
min_level int
);

-- Equipamento
create table tb_equipamento(
tipo varchar(10)
) inherits(tb_item);

-- Consumivel
create table tb_consumivel(
MULT_ataque int,
MULT_poder int,
MULT_qtd_PontosDeVida int ,
MULT_qtd_PonstosDeStamina int
) inherits(tb_item);

-- Arma
create table tb_Arma(
MULT_ataque int
) inherits(tb_equipamento);

-- Armadura
create table tb_Armadura(
MULT_defesa int
) inherits(tb_equipamento);

-- Acessorio
create table tb_Acessorio(
MULT_Poder int
) inherits(tb_equipamento);

-- Instancia do Item
create table tb_instancia_item (
id serial not null,
id_item int not null,
constraint pk_instancia_item primary key (id)
);

-- Inventario
create table tb_inventario(
id serial not null, 
capacidade int DEFAULT 100 NOT NULL,
qtd_atual int, 
qtd_dinheiro int,
id_item int,
id_personagem int not null,
constraint pk_iventario primary key(id),
constraint fk_id_intem foreign key(id_item) references tb_instancia_item (id),
constraint fk_personagem foreign key (id_personagem) references tb_personagem (id)
);

-- Missao
create table tb_missao (
	id serial constraint pk_id_missao primary key,
	nivel_min int,
	REQ_Faccao boolean,
	id_personagem int,
	constraint fk_personagem foreign key (id_personagem) references tb_personagem (id)
)

-- npc
create table tb_npc(
	id serial constraint pk_id_npc primary key,
	nome varchar(30) not null,
	id_personagem int not null,
	constraint fk_personagem foreign key (id_personagem) references tb_personagem (id)
);

-- npc mercador
create table tb_npc_mercador(
	tipo varchar(30)
) inherits (tb_npc);

-- npc ajudante
create table tb_npc_ajudante(
	vida int not null,
	dano int not null
) inherits (tb_npc);

-- npc mentor
create table tb_npc_mentor(
	MULT_poder multiply_poder
) inherits (tb_npc);

-- npc inimigo
create table tb_npc_inimigo(
	vida int not null,
	dano int not null
) inherits (tb_npc);
