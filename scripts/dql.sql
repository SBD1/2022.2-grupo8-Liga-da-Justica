-- Ver Facção do personagem
select tb_personagem.nome, tb_faccao.nome
	from tb_personagem join tb_faccao
		on tb_personagem.id_faccao = tb_faccao.id

-- Ver nível do personagem
select tb_personagem.nome, tb_personagem.nivel
    from tb_personagem 