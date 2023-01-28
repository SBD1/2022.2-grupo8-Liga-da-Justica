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
