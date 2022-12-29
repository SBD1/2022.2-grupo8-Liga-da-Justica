--Mapa
create table tb_mapa(
	id serial constraint pk_ID_Mapa primary key,
   	Nome varchar(33) not null
);

-- For regiao type
create type  nome_regiao AS ENUM (
    'Gotham', 'Metropoles'
);

-- Região
create table tb_regiao(
	id serial constraint pk_ID_Regiao primary key,
   	Nome nome_regiao not null ,
   	posicao_x int not null,
   	posicao_y int not null,
   	LocalMapa int not null,
   	constraint  fk_LocalMapa foreign key(LocalMapa)  references tb_mapa (id)
);

-- Raça
create table tb_raca(
   id serial constraint pk_ID_Raca primary key,
   Nome varchar(10) not null,
   IND_velocidade int not null,
   IND_furtividade int not null,
   IND_magia int not null,
   IND_forca int not null,
   IND_carisma int not null,
   IND_percepcao int not null,
   id_personagem int not null,
   constraint fk_personagem foreign key(id_personagem) references tb_personagem (id)
);

-- Humano
create table tb_humano(

) inherits(tb_raca);

-- Homi-Magi
create table tb_homi_magi(

) inherits(tb_raca);

-- Atlante
create table tb_atlante(

) inherits(tb_raca);

-- Amazonas
create table tb_amazonas(

) inherits(tb_raca);

-- Alien 
create table tb_alien(

) inherits(tb_raca);
