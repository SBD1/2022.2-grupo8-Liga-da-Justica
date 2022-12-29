CREATE TYPE multiply_poder AS ENUM ('1', '2', '3', '4', '5');

create table tb_npc(
	id serial constraint pk_id_npc primary key,
	nome varchar(30) not null,
	id_personagem int not null,
	constraint fk_personagem foreign key (id_personagem) references tb_personagem (id)
);

create table tb_npc_mercador(
	tipo varchar(30)
) inherits (tb_npc);

create table tb_npc_ajudante(
	vida int not null,
	dano int not null
) inherits (tb_npc);

create table tb_npc_mentor(
	MULT_poder multiply_poder
) inherits (tb_npc);

create table tb_npc_inimigo(
	vida int not null,
	dano int not null
) inherits (tb_npc);
