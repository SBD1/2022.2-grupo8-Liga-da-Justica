-- Ver Facção do personagem
select tb_personagem.nome, tb_faccao.nome
	from tb_personagem join tb_faccao
		on tb_personagem.id_faccao = tb_faccao.id

-- Ver nível do personagem
select tb_personagem.nome, tb_personagem.nivel
    from tb_personagem 

-- Ver classe do personagem
select tb_personagem.nome, tb_classe.nome
    from tb_personagem join tb_classe
        on tb_personagem.id_classe = tb_classe.id