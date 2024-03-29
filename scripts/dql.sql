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

-- Ver experiencia do personagem
select tb_personagem.nome, tb_personagem.experiencia
	from tb_personagem 

-- Ver quantidade de honra do personagem
select tb_personagem.nome, tb_personagem.qtd_honra
	from tb_personagem 

-- Ver quantidade de defesa do personagem
select tb_personagem.nome, tb_personagem.qtd_defesa
	from tb_personagem

-- Ver quantidade de ataque do personagem
select tb_personagem.nome, tb_personagem.qtd_ataque 
	from tb_personagem

-- Encontrar nome do usuário(Login)
select * from tb_personagem where nome = '${nome}'

--Encontrar posição específica no mapa
select r.posicao_x , r.posicao_y, r.nome from tb_regiao r where id= '${id}'

--Atualizar posição do personagem 
update tb_personagem set id_local_atual = '${id}' where id= '${id}'

-- Encontar ID de uma posição tendo outros os outros dados
select * from tb_regiao where posicao_x = '${pos_x}' and posicao_y ='${pos_y}'  and nome = '${nome}'

-- Ver Armas do Personagem
SELECT tiea.nome, tiea.mult_ataque FROM tb_inventario inv,tb_instancia_item item,tb_item_equipamento_arma tiea
WHERE inv.id_personagem = '${id_personagem}' AND tiea.id_equipamento = item.id_item 
AND item.id_inventario = inv.id;

--Ver Armaduras do personagem
SELECT tiea.nome, tiea.descricao, tiea.mult_defesa
FROM  tb_instancia_item tii ,tb_item_equipamento_armadura tiea, tb_inventario inv
WHERE inv.id_personagem = '${id_personagem}' and tii.id_inventario  = inv.id
and tiea.id_equipamento = tii.id_item

--Ver consumiveis do personagem

select tbc.nome, tbc.descricao  
FROM  tb_instancia_item tii ,tb_item_consumivel tbc, tb_inventario inv
WHERE inv.id_personagem = ${id_personagem} and tii.id_inventario  = inv.id
and tbc.id_item = tii.id_item 

-- Ver Acessorios do personagem

SELECT tiea.nome, tiea.descricao, tiea.mult_poder FROM tb_inventario inv,tb_instancia_item item,tb_item_equipamento_acessorio tiea
where inv.id_personagem = '${id_personagem}' and tiea.id_equipamento = item.id_item 
and item.id_inventario = inv.id
