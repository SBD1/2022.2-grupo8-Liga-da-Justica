--Mapa
create table tb_mapa(
	id serial constraint pk_id_mapa primary key,
   	nome varchar(33) not null
);

-- For regiao type
create type  nome_regiao AS ENUM (
    'Gotham', 'Metropoles'
);

-- Região
create table tb_regiao(
	id serial constraint pk_id_regiao primary key,
   	nome nome_regiao not null ,
   	posicao_x int not null,
   	posicao_y int not null,
   	localMapa int not null,
   	constraint  fk_LocalMapa foreign key(localMapa)  references tb_mapa (id)
);

--poder
create table tb_poderes(
	id serial constraint pk_id_poder primary key,
	Velocidade int,
	Furtividade int,
	Magia int,
	Força int,
	Carisma int,
	Percepção int
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
	poderes int not null,
	constraint fk_poderes foreign key(poderes) references tb_poderes (id),
	Local_Atual int not null,
	constraint fk_Local_Atual foreign key(Local_Atual) references tb_regiao (id)
);

-- Raça
create table tb_raca(
   id serial constraint pk_id_raca primary key,
   nome varchar(10) not null,
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
