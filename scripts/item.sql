create table tb_item(
id serial constraint pk_id_item primary key,
nome varchar(50) not null,
descricao varchar(100),
valor int,
min_level int
);

create table tb_equipamento(
tipo varchar(10)
) inherits(tb_item);

create table tb_consumivel(
MULT_ataque int,
MULT_poder int,
MULT_qtd_PontosDeVida int ,
MULT_qtd_PonstosDeStamina int
) inherits(tb_item);

create table tb_Arma(
MULT_ataque int
) inherits(tb_equipamento);

create table tb_Armadura(
MULT_defesa int
) inherits(tb_equipamento);

create table tb_Acessorio(
MULT_Poder int
) inherits(tb_equipamento);

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

