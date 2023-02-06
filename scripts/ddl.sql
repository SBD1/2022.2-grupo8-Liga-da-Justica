
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
   	constraint  fk_localMapa foreign key(id_localMapa)  references tb_mapa (id)
);

-- Item

create table tb_item(
	id serial constraint pk_id_item primary key,
	nome varchar(50) not null,
	descricao varchar(100),
	valor int,
	min_level int
);

-- Equipamento
create table tb_item_equipamento(
	id serial constraint pk_id_equipamento primary key,
	id_item int not null,
	nome varchar(50) not null,
	descricao varchar(100),
	valor int,
	min_level int,
	tipo varchar(10),
	constraint  fk_id_item foreign key(id_item)  references tb_item (id)
);

-- Consumivel
create table tb_item_consumivel(
	id_item int not null,
	nome varchar(50) not null,
	descricao varchar(100),
	valor int,
	min_level int,
	MULT_ataque int,
	MULT_poder int,
	MULT_qtd_PontosDeVida int ,
	MULT_qtd_PonstosDeStamina int,
	constraint  fk_id_item foreign key(id_item)  references tb_item (id)
);

-- Arma
create table tb_item_equipamento_arma(
	id_equipamento int not null,
	nome varchar(50) not null,
	descricao varchar(100),
	valor int,
	min_level int,
	tipo varchar(10),
	MULT_ataque int,
	constraint  fk_id_equipamento foreign key(id_equipamento)  references tb_item_equipamento (id)
);

-- Armadura
create table tb_item_equipamento_armadura(
	id_equipamento int not null,
	nome varchar(50) not null,
	descricao varchar(100),
	valor int,
	min_level int,
	tipo varchar(10),
	MULT_defesa int,
	constraint  fk_id_equipamento foreign key(id_equipamento)  references tb_item_equipamento (id)
);

-- Acessorio
create table tb_item_equipamento_acessorio(
	id_equipamento int not null,
	nome varchar(50) not null,
	descricao varchar(100),
	valor int,
	min_level int,
	tipo varchar(10),
	MULT_Poder int,
	constraint  fk_id_equipamento foreign key(id_equipamento)  references tb_item_equipamento (id)
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


-- Raça
create table tb_raca(
   id serial constraint pk_id_raca primary key,
   nome varchar(10) not null
);

-- Humano
create table tb_raca_humano(
	IND_carisma int not null,
	IND_percepcao int not null,
	IND_furtividade int not null,
	id_raca int not null,
	nome varchar(10) not null,
	constraint fk_id_raca foreign key(id_raca) references tb_raca (id)
);

-- Homi-Magi
create table tb_raca_homi_magi(
	IND_magia int not null,
	IND_percepcao int not null,
	IND_velocidade int not null,
	id_raca int not null,
	nome varchar(10) not null ,
	constraint fk_id_raca foreign key(id_raca) references tb_raca (id)
);

-- Atlante
create table tb_raca_atlante(
	IND_forca int not null,
	IND_furtividade int not null,
	IND_velocidade int not null,
	id_raca int not null,
	id_personagem int not null,
	nome varchar(10) not null ,
	constraint fk_id_raca foreign key(id_raca) references tb_raca (id)
);

-- Amazonas
create table tb_raca_amazonas(
	IND_forca int not null,
	IND_carisma int not null,
	IND_velocidade int not null,
	id_raca int not null,
	nome varchar(10) not null ,
	constraint fk_id_raca foreign key(id_raca) references tb_raca (id)
);

-- Alien 
create table tb_raca_alien(
	IND_forca int not null,
	IND_percepcao int not null,
	IND_velocidade int not null,
	id_raca int not null,
	nome varchar(10) not null ,
	constraint fk_id_raca foreign key(id_raca) references tb_raca (id)
);

CREATE TABLE tb_faccao (
    id serial not null,
    nome varchar(30) not null,
    CONSTRAINT pk_faccao primary key (id),
    CONSTRAINT sk_faccao unique (Nome)
);

-- Heroi 
CREATE TABLE tb_faccao_heroi(
	id_faccao int not null,
	nome varchar(30) not null,
	MULT_honra int not null,
	CONSTRAINT fk_faccao FOREIGN KEY (id_faccao) REFERENCES tb_faccao (id)
);

-- Vilao
CREATE TABLE tb_faccao_vilao(
	id_faccao int not null,
	nome varchar(30) not null,
	MULT_honra int not null,
	CONSTRAINT fk_faccao FOREIGN KEY (id_faccao) REFERENCES tb_faccao (id)
);

-- Classe
CREATE TABLE tb_classe (
    id serial primary key,
    nome varchar(30) not null
);

-- Velocista
CREATE TABLE tb_classe_velocista(
    IND_Percepcao int not null,
    IND_Velocidade int not null,
    id_classe int not null, 
    nome varchar(30) not null,
    constraint fk_id_classe foreign key(id_classe) references tb_classe (id)
);

-- Magico
CREATE TABLE tb_classe_magico(
    IND_Magia int not null,
    IND_Carisma int not null,
	id_classe int not null,
	nome varchar(30) not null,
	constraint fk_id_classe foreign key(id_classe) references tb_classe (id)
);

-- Combatente
CREATE TABLE tb_classe_combatente(
    IND_Forca int not null,
    IND_Velocidade int not null,
    id_classe int not null, 
    nome varchar(30) not null,
    constraint fk_id_classe foreign key(id_classe) references tb_classe (id)
);

-- Detetive
CREATE TABLE tb_classe_detetive(
    IND_Furtividade int not null,
    IND_Carisma int not null,
    IND_percepcao int not null,
    id_classe int not null, 
    nome varchar(30) not null,
    constraint fk_id_classe foreign key(id_classe) references tb_classe (id)
);

-- Brutamonte
CREATE TABLE tb_classe_brutamonte(
    IND_Forca int not null,
    IND_Velocidade int not null,
    id_classe int not null, 
    nome varchar(30) not null,
    constraint fk_id_classe foreign key(id_classe) references tb_classe (id)
);

create table tb_npc(
	id serial constraint pk_id_npc primary key,
	nome varchar(30) not null,
	id_regiao int not null,
	constraint  fk_regiao foreign key(id_regiao)  references tb_regiao (id)
);

-- npc mentor
 create table tb_npc_mentor(
	id serial constraint pk_id_mentor primary key,
	id_npc int not null,
	nome varchar(30) not null,
	id_classe int not null,
	id_faccao int not null, 
	MULT_poder int,
	constraint  fk_npc foreign key(id_npc)  references tb_npc (id),
	constraint  fk_classe foreign key(id_classe)  references tb_classe (id),
	constraint  fk_faccao foreign key(id_faccao)  references tb_faccao (id)
);



-- npc ajudante
create table tb_npc_ajudante(
	id serial constraint pk_id_ajudante primary key,
	id_npc int not null,
	nome varchar(30) not null,
	vida int not null,
	dano int not null,
	constraint  fk_npc foreign key(id_npc)  references tb_npc (id)
);



-- npc inimigo
create table tb_npc_inimigo(
	id serial constraint pk_id_inimigo primary key,
	id_npc int not null,
	id_faccao int not null,
	nome varchar(30) not null,
	vida int not null,
	dano int not null,
	experiencia int not null,
	tempo TIMESTAMP default NOW() not null,
	constraint  fk_id_faccao foreign key(id_faccao)  references tb_faccao (id),
	constraint  fk_npc foreign key(id_npc)  references tb_npc (id)
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
	QTD_Mortes int,
	id_poder int not null,
	id_Local_Atual int not null,
	id_ajudante int,
	id_mentor int not null,
	id_classe int not null,
	id_faccao int not null,
	id_raca int not null,
	arma_atual int,
	armadura_atual int,
	acessorio_atual int,
	constraint fk_poderes foreign key(id_poder) references tb_poderes (id),
	constraint fk_ajudante foreign key(id_ajudante) references tb_npc_ajudante (id),
	constraint fk_mentor foreign key(id_mentor) references tb_npc_mentor (id),
	constraint fk_Local_Atual foreign key(id_Local_Atual) references tb_regiao (id),
	constraint fk_classe foreign key(id_classe) references tb_classe (id),
	constraint fk_faccao foreign key(id_faccao) references tb_faccao (id),
	constraint fk_raca foreign key(id_raca) references tb_raca (id),
	constraint fk_arma foreign key(arma_atual) references tb_item (id),
	constraint fk_armadura foreign key(armadura_atual) references tb_item (id),
	constraint fk_acessorio foreign key(acessorio_atual) references tb_item (id)
);

-- Inventario
create table tb_inventario(
	id serial not null, 
	capacidade int DEFAULT 100 NOT NULL,
	qtd_atual int, 
	qtd_dinheiro int,
	id_personagem int not null,
	constraint pk_inventario primary key(id),
	constraint fk_personagem foreign key (id_personagem) references tb_personagem (id)
);

-- Instancia do Item
create table tb_instancia_item (
	id serial not null,
	id_item int not null,
	id_inventario int,
	constraint pk_instancia_item primary key (id),
	constraint fk_id_item foreign key(id_item)  references tb_item (id),
	constraint fk_id_inventario foreign key(id_inventario) references tb_inventario (id) 
);

create table tb_missao (
	id serial constraint pk_id_missao primary key,
	nivel_min int,
	REQ_Faccao boolean,
	REQ_Honra boolean,
	id_personagem int not null,
	id_instancia_item int,
	constraint fk_id_personagem foreign key (id_personagem) references tb_personagem (id),
	constraint fk_InstaItem foreign key (id_instancia_item) references tb_instancia_item (id)
);

-- npc mercador
create table tb_npc_mercador(
	id serial constraint pk_id_mercador primary key,
	id_npc int not null,
	nome varchar(30) not null,
	tipo varchar(30),
	id_instancia_item int not null,
	constraint  fk_npc foreign key(id_npc)  references tb_npc (id),
	constraint fk_InstaItem foreign key(id_instancia_item)  references tb_instancia_item (id)
);

-- batalha
create table tb_batalha(
	id serial constraint pk_id_batalha primary key,
	id_npc_inimigo  int not null,
	id_personagem int not null,
	vencedor varchar (10),
	constraint fk_id_personagem foreign key(id_personagem) references tb_personagem(id),
	constraint fk_npc_inimigo foreign key(id_npc_inimigo) references tb_npc_inimigo (id)
);
