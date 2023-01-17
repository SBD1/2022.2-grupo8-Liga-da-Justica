-- Ver Facção do personagem
select tb_personagem.nome, tb_faccao.nome
	from tb_personagem inner join tb_faccao
		on tb_personagem.id_faccao = tb_faccao.id
		
-- Ver nível do personagem
select tb_personagem.nome, tb_personagem.nivel
    from tb_personagem 

-- Ver classe do personagem
select tb_personagem.nome, tb_classe.nome
    from tb_personagem inner join tb_classe
        on tb_personagem.id_classe = tb_classe.id
      
-- Ver localização do personagem
select tb_personagem.nome, tb_regiao.nome, tb_regiao.posicao_x, tb_regiao.posicao_y 
	from tb_personagem inner join tb_regiao
		on tb_personagem.id_local_atual = tb_regiao.id 

-- Ver raça do personagem
select tb_personagem.nome, tb_raca.nome
	from tb_personagem inner join tb_raca
		on tb_personagem.id_raca = tb_raca.id 

-- Ver poderes do personagem 
select tb_personagem.nome, tb_poderes.velocidade, tb_poderes.furtividade, tb_poderes.magia, tb_poderes.forca, tb_poderes.carisma, tb_poderes.percepcao 
	from tb_personagem inner join tb_poderes
		on tb_personagem.id = tb_poderes.id 