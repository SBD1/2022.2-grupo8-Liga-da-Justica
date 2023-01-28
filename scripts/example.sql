-- Função que avisa que um novo personagem foi adicionado (ESSA FUNCIONA)
CREATE OR REPLACE FUNCTION notify_new_personagem() RETURNS TRIGGER AS $$
BEGIN
  RAISE NOTICE 'Novo personagem inserido na tabela tb_personagem: %', NEW;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--Trigger da função
CREATE TRIGGER notify_personagem_insert
AFTER INSERT ON tb_personagem
FOR EACH ROW
EXECUTE FUNCTION notify_new_personagem();


-- Função que atualiza o nivel de acordo com a experiencia ( exp/100)
CREATE OR REPLACE FUNCTION increase_character_level() RETURNS TRIGGER AS $$
BEGIN
  --IF NEW.experiencia >= (OLD.nivel * 10) THEN
    UPDATE tb_personagem SET nivel = (NEW.experiencia / 100) WHERE id = OLD.id;
  --END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que é chamado toda vez que tem uma atualização na experiencia
CREATE TRIGGER increase_level
AFTER UPDATE OF experiencia ON tb_personagem
FOR EACH ROW
EXECUTE FUNCTION increase_character_level();

insert into tb_personagem(experiencia, nivel, nome, QTD_PontosDeVida, MAX_PontoDeVida, sexo, QTD_PontosDeEstamina, MAX_PontosDeEstamina, QTD_Honra, QTD_Defesa, QTD_Ataque, id_poder, id_Local_Atual, id_ajudante, id_mentor, id_classe, id_faccao, id_raca) values (97, 4, 'ExpTeste', 100, 150, 0, 123, 175, 80, 5, 4, 2, 17, 1, 1, 1, 1, 1);
UPDATE tb_personagem SET experiencia = 600 WHERE nome = 'ExpTeste';
SELECT nivel FROM tb_personagem WHERE nome = 'ExpTeste';
-- Expected output: 6

-- Delete inventario, not tested yet
CREATE OR REPLACE FUNCTION zerar_inventario_func() RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.QTD_PontosDeVida = 0) THEN
        DELETE FROM tb_inventario WHERE ID_Personagem = NEW.ID_Personagem;
       raise notice 'O inventario foi apagado'; 
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
--
CREATE TRIGGER zerar_inventario
AFTER UPDATE ON tb_personagem
FOR EACH ROW
EXECUTE FUNCTION zerar_inventario_func();
-- Test Case - ID needed 
insert into tb_personagem(experiencia, nivel, nome, QTD_PontosDeVida, MAX_PontoDeVida, sexo, QTD_PontosDeEstamina, MAX_PontosDeEstamina, QTD_Honra, QTD_Defesa, QTD_Ataque, id_poder, id_Local_Atual, id_ajudante, id_mentor, id_classe, id_faccao, id_raca) values (84, 3, 'Joao', 10, 100, 0, 120, 145, 5, 3, 2, 1, 8, 1, 1, 2, 1, 2);
insert into tb_inventario(capacidade, qtd_atual,qtd_dinheiro, id_personagem) values (99, 1, 50, 8);
UPDATE tb_personagem SET QTD_PontosDeVida = 0 WHERE Nome = 'Joao';
SELECT * FROM tb_inventario WHERE ID_Personagem = (SELECT ID_Personagem FROM tb_personagem WHERE Nome = 'Joao');
