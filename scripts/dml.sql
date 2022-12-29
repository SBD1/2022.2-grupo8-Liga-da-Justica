-- Povoando a tabela do mapa
insert into tb_mapa(nome)
values
('Gotham'),
('Metropoles');


-- Povoando a tabela de região
insert into tb_regiao(nome, posicao_x, posicao_y, id_localmapa)
values
('Beco do Batman', 0, 1, 1),
('Beco do Batman', 0, 2, 1),
('Beco do Batman', 0, 3, 1),
('Beco do Batman', 0, 4, 1),
('Beco do Batman', 0, 5, 1),
('Beco do Batman', 1, 0, 1),
('Beco do Batman', 1, 1, 1),
('Beco do Batman', 1, 2, 1),
('Beco do Batman', 1, 3, 1),
('Beco do Batman', 1, 4, 1),
('Beco do Batman', 1, 5, 1),
('Torre do Lex Luthor', 0, 1, 2),
('Torre do Lex Luthor', 0, 2, 2),
('Torre do Lex Luthor', 0, 3, 2),
('Torre do Lex Luthor', 0, 4, 2),
('Torre do Lex Luthor', 0, 5, 2),
('Torre do Lex Luthor', 1, 0, 2),
('Torre do Lex Luthor', 1, 1, 2),
('Torre do Lex Luthor', 1, 2, 2),
('Torre do Lex Luthor', 1, 3, 2),
('Torre do Lex Luthor', 1, 4, 2),
('Torre do Lex Luthor', 1, 5, 2);


insert into tb_poderes(velocidade, furtividade, magia, forca,carisma,percepcao) 
values(2,3,3,2,4,7);




insert into tb_personagem(nome,experiencia,nivel,QTD_PontosDeVida, MAX_PontoDeVida,sexo, QTD_PontosDeEstamina, MAX_PontosDeEstamina, QTD_Honra, QTD_Defesa, QTD_Ataque, id_poderes, Id_Local_Atual)
values ('Legolas', 30, 3, 100, 100, 1, 50,50,10,1,1,1,4 );


-- Povoando a tabela das classes
insert into velocista(id_classe,personagem,ind_percepcao,ind_velocidade) values(1,1,45,70);
insert into velocista(id_classe,personagem,ind_percepcao,ind_velocidade) values(1,2,45,70);

insert into brutamonte(id_classe,personagem,ind_forca,ind_velocidade) values(2,3,70,20);
insert into brutamonte(id_classe,personagem,ind_forca,ind_velocidade) values(2,4,70,20);
insert into brutamonte(id_classe,personagem,ind_forca,ind_velocidade) values(2,5,70,20);

insert into detetive(id_classe,personagem,IND_Furtividade,IND_Carisma,ind_percepcao) values(3,6,70,40,40);
insert into detetive(id_classe,personagem,IND_Furtividade,IND_Carisma,ind_percepcao) values(3,7,70,40,40);
insert into detetive(id_classe,personagem,IND_Furtividade,IND_Carisma,ind_percepcao) values(3,8,70,40,40);

insert into magico(id_classe,personagem,IND_Magia, IND_Carisma) values(4,9,70,40);
insert into magico(id_classe,personagem,IND_Magia, IND_Carisma) values(4,10,70,40);

insert into combatente(id_classe,personagem, ind_forca,ind_velocidade) values (5,11,60,40);

-- Povoando Itens

insert into tb_instancia_item (id_item)
select id from tb_item

insert into tb_inventario (capacidade, qtd_atual,qtd_dinheiro,id_item, id_personagem)
values (99,1,50,5,1), (98,2,50,9,1), (97,3,51,17,1), (99,1,32,4,2), (98,2,36,18,2);

insert into tb_arma (nome, descricao, valor,min_level,tipo, mult_ataque)
Values('Espada','Arma branca constituída por uma longa lâmina de aço', 40, 3, 'Arma', 4);

insert into tb_arma (nome, descricao, valor,min_level,tipo, mult_ataque)
Values('Pistola','Arma de fogo portátil', 60, 2, 'Arma', 5);

insert into tb_arma (nome, descricao, valor,min_level,tipo, mult_ataque)
Values('Bastão Longo','Arma branca muito utilizada por lutadores de artes marciais', 20, 1, 'Arma', 3);

insert into tb_arma (nome, descricao, valor,min_level,tipo, mult_ataque)
Values('Tridente','Arma branca de três pontas originada de atlântida', 0, 6, 'Arma', 9);


insert into tb_arma (nome, descricao, valor,min_level,tipo, mult_ataque)
Values('Arco e flecha','Arma de longo alcance', 15, 1, 'Arma', 2);

insert into tb_arma (nome, descricao, valor,min_level,tipo, mult_ataque)
Values('Soco inglês','Arma branca utilizada para aumentar o poder do seu soco', 10, 1, 'Arma', 1);

insert into tb_armadura  (nome, descricao, valor,min_level,tipo, mult_defesa)
Values('Capacete de combate','proteção na cabeça utilizada por soldados', 15, 2, 'Armadura', 2);

insert into tb_armadura  (nome, descricao, valor,min_level,tipo, mult_defesa)
Values('Colete Balístico','proteção no tronco para evitar tiros', 15, 1, 'Armadura', 3);

insert into tb_armadura  (nome, descricao, valor,min_level,tipo, mult_defesa)
Values('Armadura completa balística','Roupa completa feita de um tecido aprova de balas', 70, 4, 'Armadura', 6);

insert into tb_armadura  (nome, descricao, valor,min_level,tipo, mult_defesa)
Values('Amvabraço de Titânio ','Proteção da parte inferior do antebraço', 40, 1, 'Armadura', 2);

insert into tb_armadura  (nome, descricao, valor,min_level,tipo, mult_defesa)
Values('Joelheira comum','Proteção dos joelhos, muito utilizada para evitar quedas', 5, 1, 'Armadura', 1);

insert into tb_acessorio  (nome, descricao, valor,min_level,tipo, mult_poder)
Values('Capa usada do Batman','Capa utilizada pelo cavaleiro das trevas no seu antigo uniforme', 50, 1, 'Acessorio', 5);

insert into tb_acessorio  (nome, descricao, valor,min_level,tipo, mult_poder)
Values('Capa usada do Superman','Capa utilizada pelo Superman no seu antigo uniforme', 80, 1, 'Acessorio', 2);

insert into tb_acessorio  (nome, descricao, valor,min_level,tipo, mult_poder)
Values('Braceletes usados da Mulher-maravilha','Bracelete utilizado pela heroína no seu antigo uniforme', 60, 1, 'Acessorio', 3);

insert into tb_acessorio  (nome, descricao, valor,min_level,tipo, mult_poder)
Values('Máscara capanga coringa','Adereço utilizado pela gangue do coringa para assutar os cidadãos', 10, 1, 'Acessorio', 1);

insert into tb_acessorio  (nome, descricao, valor,min_level,tipo, mult_poder)
Values('Cartola mágica','Chapéu encantado por magias desconhecidas', 100, 3, 'Acessorio', 8);

insert into tb_consumivel  (nome, descricao, valor,min_level, mult_ataque, mult_poder, mult_qtd_pontosdevida, mult_qtd_ponstosdestamina)
Values('Poção de vida','Mistura de ingredientes que aumentam a vida de quem tomar', 10, 1, 0, 0, 2, 0);

insert into tb_consumivel  (nome, descricao, valor,min_level, mult_ataque, mult_poder, mult_qtd_pontosdevida, mult_qtd_ponstosdestamina)
Values('Tônico','aumenta sua stamina', 10, 1, 0, 0, 0, 2);

insert into tb_consumivel  (nome, descricao, valor,min_level, mult_ataque, mult_poder, mult_qtd_pontosdevida, mult_qtd_ponstosdestamina)
Values('Injeção de andrenalina','aumenta sua stamina', 30, 2, 2, 4, -1, 0);

insert into tb_consumivel  (nome, descricao, valor,min_level, mult_ataque, mult_poder, mult_qtd_pontosdevida, mult_qtd_ponstosdestamina)
Values('Poção mágica','Mistura de ingredientes que aumentam o poder mágico de quem tomar', 50, 1, 0, 4, 0, 0);

insert into tb_consumivel  (nome, descricao, valor,min_level, mult_ataque, mult_poder, mult_qtd_pontosdevida, mult_qtd_ponstosdestamina)
Values('Band-aid','curativo para ferimentos', 3, 1, 0, 0, 2, 0);