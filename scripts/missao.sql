create table tb_missao (
	id serial constraint pk_id_missao primary key,
	nivel_min int,
	REQ_Faccao boolean,
	id_personagem int,
	constraint fk_personagem foreign key (id_personagem) references tb_personagem (id)
)
