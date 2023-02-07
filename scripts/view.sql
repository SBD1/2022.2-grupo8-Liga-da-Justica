-- View que mostra dados do personagem e do inventario
CREATE VIEW vw_personagem_inventario AS
SELECT tb_personagem.experiencia, tb_personagem.nivel, tb_personagem.nome, tb_personagem.qtd_pontosdevida, 
       tb_personagem.sexo, tb_personagem.qtd_pontosdeestamina, tb_personagem.qtd_honra, tb_personagem.qtd_defesa, 
       tb_personagem.qtd_ataque, tb_personagem.qtd_mortes, tb_personagem.id_poder, tb_personagem.id_Local_Atual, 
       tb_personagem.id_ajudante, tb_personagem.id_mentor, tb_personagem.id_classe, tb_personagem.id_faccao, 
       tb_personagem.id_raca, tb_personagem.arma_atual, tb_personagem.armadura_atual, tb_personagem.acessorio_atual,
       tb_inventario.qtd_atual, tb_inventario.qtd_dinheiro
FROM tb_personagem
JOIN tb_inventario
ON tb_personagem.id = tb_inventario.id_personagem;

-- View de Mapa
CREATE VIEW vw_mapa AS
SELECT id, nome FROM tb_mapa;

-- View de Região
CREATE VIEW vw_regiao AS
SELECT id, nome, posicao_x, posicao_y, id_localMapa FROM tb_regiao;

-- View de Item
CREATE VIEW vw_item AS
SELECT id, nome, descricao, valor, min_level FROM tb_item;

-- View de Equipamento
CREATE VIEW vw_item_equipamento AS
SELECT id, id_item, nome, descricao, valor, min_level, tipo FROM tb_item_equipamento;

-- View de Consumível
CREATE VIEW vw_item_consumivel AS
SELECT id_item, nome, descricao, valor, min_level, MULT_ataque, MULT_poder, MULT_qtd_PontosDeVida, MULT_qtd_PonstosDeStamina FROM tb_item_consumivel;

-- View de Arma
CREATE VIEW vw_item_equipamento_arma AS
SELECT id_equipamento, nome, descricao, valor, min_level, tipo, MULT_ataque FROM tb_item_equipamento_arma;

-- View de Armadura
CREATE VIEW vw_item_equipamento_armadura AS
SELECT id_equipamento, nome, descricao, valor, min_level, tipo, MULT_defesa FROM tb_item_equipamento_armadura;

-- View de Acessório
CREATE VIEW vw_item_equipamento_acessorio AS
SELECT id_equipamento, nome, descricao, valor, min_level, tipo, MULT_Poder FROM tb_item_equipamento_acessorio;

-- View de Poder
CREATE VIEW vw_poderes AS
SELECT id, Velocidade, Furtividade, Magia, Forca, Carisma, Percepcao FROM tb_poderes;

-- View de Raça
CREATE VIEW vw_raca AS
SELECT id, nome FROM tb_raca;

-- View de Humano
CREATE VIEW vw_raca_humano AS
SELECT IND_carisma, IND_percepcao, IND_furtividade, id_raca, nome FROM tb_raca_humano;

-- View de Homi-Magi
CREATE VIEW vw_raca_homi_magi AS
SELECT IND_magia, IND_percepcao, IND_velocidade, id_raca, nome FROM tb_raca_homi_magi;

-- view para Atlante
create view vw_atlante as
select ind_forca, ind_furtividade, ind_velocidade, id_raca, id_personagem, nome 
from tb_raca_atlante;

-- view para Amazonas
create view vw_amazonas as
select *
from tb_raca_amazonas;

-- view para Alien
create view vw_alien as
select *
from tb_raca_alien;


--faccao
CREATE VIEW vw_faccao AS
SELECT *
FROM tb_faccao;

--fac heroi
CREATE VIEW vw_faccao_heroi AS
SELECT *
FROM tb_faccao_heroi;

--fac vilao
CREATE VIEW vw_faccao_vilao AS
SELECT *
FROM tb_faccao_vilao;


-- View de dados de todas as classes
CREATE VIEW vw_classes AS
SELECT id, nome
FROM tb_classe;

-- View de dados dos velocistas
CREATE VIEW vw_velocistas AS
SELECT id_classe, nome, IND_Percepcao, IND_Velocidade
FROM tb_classe_velocista;

-- View de dados dos magicos
CREATE VIEW vw_magos AS
SELECT id_classe, nome, IND_Magia, IND_Carisma
FROM tb_classe_magico;

-- View de dados dos combatentes
CREATE VIEW vw_combatentes AS
SELECT id_classe, nome, IND_Forca, IND_Velocidade
FROM tb_classe_combatente;

-- View de dados dos detetives
CREATE VIEW vw_detetives AS
SELECT id_classe, nome, IND_Furtividade, IND_Carisma, IND_percepcao
FROM tb_classe_detetive;

-- View de dados dos brutamontes
CREATE VIEW vw_brutamontes AS
SELECT id_classe, nome, IND_Forca, IND_Velocidade
FROM tb_classe_brutamonte;

-- View de dados dos npcs
CREATE VIEW vw_npcs AS
SELECT id, nome, id_regiao
FROM tb_npc;

-- View de dados dos npcs mentores
CREATE VIEW vw_npcs_mentores AS
SELECT id_npc, nome, id_classe, id_faccao, MULT_poder
FROM tb_npc_mentor;

-- View de dados dos npcs ajudantes
CREATE VIEW vw_npcs_ajudantes AS
SELECT id_npc, nome, vida, dano
FROM tb_npc_ajudante;

-- View de dados dos npcs inimigos
CREATE VIEW vw_npcs_inimigos AS
select *
FROM tb_npc_inimigo;

--personagem
CREATE VIEW vw_personagem AS
SELECT *
FROM tb_personagem;

--inventario
CREATE VIEW vw_inventario AS
SELECT id, capacidade, qtd_atual, qtd_dinheiro, id_personagem
FROM tb_inventario;

--instancia de item
CREATE VIEW vw_instancia_item AS
SELECT id, id_item, id_inventario
FROM tb_instancia_item;

-- Missao
CREATE VIEW vw_missao AS
SELECT id, nivel_min, REQ_Faccao, REQ_Honra, id_personagem, id_instancia_item
FROM tb_missao;

-- Mercador
CREATE VIEW vw_npc_mercador AS
SELECT id, id_npc, nome, tipo, id_instancia_item
FROM tb_npc_mercador;

-- Batalha
CREATE VIEW vw_batalha AS
SELECT *
FROM tb_batalha;
