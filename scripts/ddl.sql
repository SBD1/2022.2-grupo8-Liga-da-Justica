-- For mapa type
create TYPE nome_regiao AS ENUM (
    'Gotham', 'Metropoles'
);

-- Região
CREATE TABLE TB_REGIAO(
	id serial constraint pk_ID_Regiao primary key,
   	Nome nome_regiao not null ,
   	posicao_x int not null,
   	posicao_y int not null,
   	LocalMapa varchar(1) not null
 
);

--Mapa
CREATE TABLE TB_MAPA(
	id serial constraint pk_ID_Mapa primary key,
   	Nome varchar(33) not null
);


-- Raça
CREATE TABLE TB_RACA(
   id serial constraint pk_ID_Raca primary key,
   Nome varchar(10) not null,
   IND_velocidade int not null,
   IND_furtividade int not null,
   IND_magia int not null,
   IND_forca int not null,
   IND_carisma int not null,
   IND_percepcao int not null,
   personagem int not null
);