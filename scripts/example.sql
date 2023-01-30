CREATE OR REPLACE FUNCTION iniciar_batalha()
RETURNS TRIGGER AS $$

  DECLARE dano_inimigo INT;
  DECLARE qtd_ataque_personagem INT;
  DECLARE vida_inimigo INT;
  DECLARE vida_personagem INT;
 
 begin
  select qtd_pontosdevida into vida_personagem from tb_personagem where tb_personagem.id = new.id_personagem;
  select vida into vida_inimigo from tb_npc_inimigo WHERE tb_npc_inimigo.id = NEW.id_npc_inimigo;
  SELECT dano INTO dano_inimigo FROM tb_npc_inimigo WHERE tb_npc_inimigo.id = NEW.id_npc_inimigo;

  SELECT qtd_ataque INTO qtd_ataque_personagem FROM tb_personagem WHERE tb_personagem.id = NEW.id_personagem;

  IF qtd_ataque_personagem >= dano_inimigo then
  	  vida_inimigo := vida_inimigo - (qtd_ataque_personagem - dano_inimigo);
      UPDATE tb_npc_inimigo SET vida = vida_inimigo WHERE id = NEW.id_npc_inimigo;
    RAISE NOTICE 'Personagem venceu a batalha';
   	update tb_batalha set vencedor = 'Personagem' where id = new.id;
  else
  	vida_personagem := vida_personagem - (dano_inimigo - qtd_ataque_personagem);
    UPDATE tb_personagem SET qtd_pontosdevida  = vida_personagem WHERE id = NEW.id_personagem;
    RAISE NOTICE 'NPC inimigo venceu a batalha';
   	update tb_batalha set vencedor = 'NPC' where id = new.id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER iniciar_batalha_trigger
AFTER INSERT ON tb_batalha
FOR EACH ROW
EXECUTE FUNCTION iniciar_batalha();


-- povoamento teste 
insert into tb_personagem(experiencia, nivel, nome, QTD_PontosDeVida, MAX_PontoDeVida, sexo, QTD_PontosDeEstamina, MAX_PontosDeEstamina, QTD_Honra, QTD_Defesa, QTD_Ataque, id_poder, id_Local_Atual, id_ajudante, id_mentor, id_classe, id_faccao, id_raca) values (1, 4, 'Personagem 1', 100, 150, 0, 123, 175, 80, 5, 4, 2, 17, 1, 1, 1, 1, 1);
insert into tb_batalha(id_npc_inimigo, id_personagem) values (2,5);

-- simulação
BEGIN;
UPDATE tb_npc_inimigo SET dano = 20 WHERE nome = 'Arlequina';
UPDATE tb_personagem SET QTD_Ataque = 15 WHERE nome = 'Personagem 1';
COMMIT;

-- Executar uma consulta para verificar o resultado
SELECT * FROM tb_personagem WHERE nome = 'Personagem 1';