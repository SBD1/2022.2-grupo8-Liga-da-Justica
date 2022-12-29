-- Povoando a tabela do mapa
insert into tb_mapa(nome)
values
('Beco do Batman'),
('Prédio Lex Luthor'),
('Avenida Mulher Maravilha'),
('Super-man Land'),
('Estádio Flash'),
('Rua Detetive Gordon');

-Povoando a tabela de região
insert into tb_regiao(nome, posicao_x, posicao_y, localmapa)
values
('Gotham', 1, 1, 1),
('Metropoles', 2, 1, 2),
('Metropoles', 2, 4, 3),
('Metropoles', 2, 7, 4),
('Metropoles', 2, 8, 5),
('Gotham', 1, 4, 6);

