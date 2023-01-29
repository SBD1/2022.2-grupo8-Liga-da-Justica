-- TRIGGERS DE REGRAS DE GENERALIZAÇÃO E ESPECIALIZAÇÃO 

create trigger personagem_ja_existe
before update or insert on tb_personagem 
for each row execute procedure personagem_ja_existe();

create or replace function personagem_ja_existe() returns trigger 
as $personagem_ja_existe$
begin 
	perform * from tb_personagem where nome = new.nome;
	if found then 
		raise exception 'Este personagem já existe como um personagem principal';
	end if;
	return new;
end
$personagem_ja_existe$ language plpgsql;

-- Função para criar personagens com poucos parâmetros 

CREATE OR REPLACE FUNCTION criarPersonagem(nome varchar(30), sexo int, idClasse int, idFaccao int, idRaca int ) RETURNS VOID AS
$$
DECLARE
idMentor int;
begin
	select tb_npc_mentor.id into idMentor from tb_npc_mentor where id_classe = idClasse and id_faccao = idFaccao;

    insert into tb_personagem(experiencia, nivel, nome, QTD_PontosDeVida, MAX_PontoDeVida, sexo, QTD_PontosDeEstamina, MAX_PontosDeEstamina, QTD_Honra, QTD_Defesa, QTD_Ataque, id_poder, id_Local_Atual, id_ajudante, id_mentor, id_classe, id_faccao, id_raca) 
   values (0, 1, nome, 100, 100, sexo , 100, 100, 50, 0, 0, 1 , 1, null, idMentor, idClasse , idFaccao , idRaca);

END
$$
  LANGUAGE 'plpgsql';
 

-- Função para criar a tabela de poder ao criar um personagem 

 CREATE OR REPLACE FUNCTION criarPoderPersonagem() RETURNS TRIGGER  AS
$$
DECLARE
idPoder int;
indVelocidade int := 1;
indFurtividade int := 1; 
indMagia int := 1;
indForca int := 1; 
indCarisma int := 1;
indPercepcao int := 1;
RacaindVelocidade int := 0;
RacaindFurtividade int := 0; 
RacaindMagia int := 0;
RacaindForca int := 0; 
RacaindCarisma int := 0;
RacaindPercepcao int := 0;
begin

case
	when (new.id_classe = '1') then select i.ind_percepcao, i.ind_velocidade from tb_classe_velocista i into indPercepcao, indVelocidade; 
	when (new.id_classe = '2') then select i.ind_magia, i.ind_carisma from tb_classe_magico i into indMagia, indCarisma; 
	when (new.id_classe = '3') then select i.ind_forca, i.ind_velocidade from tb_classe_combatente i into indForca, indVelocidade; 
	when (new.id_classe = '4') then select i.ind_percepcao, i.ind_furtividade, i.ind_carisma from tb_classe_detetive i into indPercepcao, indFurtividade, indCarisma; 
	when (new.id_classe = '5') then select i.ind_forca, i.ind_velocidade from tb_classe_brutamonte i into indForca, indVelocidade; 
else 
	raise exception 'Id de Classe não existente';

end case;

case
	when (new.id_raca = '1') then select i.ind_percepcao, i.ind_furtividade, i.ind_carisma from tb_raca_humano i into RacaindPercepcao, RacaindFurtividade, RacaindCarisma; 
	when (new.id_raca = '2') then select i.ind_magia, i.ind_percepcao, i.ind_velocidade from tb_raca_homi_magi  i into RacaindMagia, RacaindPercepcao, RacaindVelocidade; 
	when (new.id_raca = '3') then select i.ind_forca, i.ind_velocidade, i.ind_carisma from tb_raca_amazonas i into RacaindForca, RacaindVelocidade, RacaindCarisma; 
	when (new.id_raca = '4') then select i.ind_forca, i.ind_furtividade, i.ind_velocidade from tb_raca_atlante i into RacaindForca, RacaindFurtividade, RacaindVelocidade; 
	when (new.id_raca = '5') then select i.ind_forca, i.ind_percepcao, i.ind_velocidade from tb_raca_alien i into RacaindForca, RacaindPercepcao, RacaindVelocidade; 
else 
	raise exception 'Id de Classe não existente';

end case;
		
	insert into tb_poderes(Velocidade, Furtividade, Magia, Forca, Carisma, Percepcao) values (indVelocidade + RacaindVelocidade , indFurtividade + RacaindFurtividade, indMagia + RacaindMagia, indForca + RacaindForca, indCarisma + RacaindCarisma, indPercepcao + RacaindPercepcao) RETURNING id into idPoder;
	new.id_poder := idPoder;
	
return new;

END
$$
  LANGUAGE 'plpgsql';

--Trigger para inserção de personagem 

CREATE TRIGGER  "tg_criaTbPoder " before INSERT 
ON tb_personagem FOR EACH ROW 
    EXECUTE function  criarPoderPersonagem();

--Trigger de morte/respawn do personagem e perda de dinheiro 

create or replace function tg_pers_morte() returns trigger as $tg_pers_morte$
begin 
	if (new.QTD_PontosDeVida = 0) then 
   	   update tb_inventario 
   	   set qtd_dinheiro = '0'
   	   where id_personagem = new.id;
    end if;
    return new;
end;
$tg_pers_morte$ language plpgsql;

create trigger tg_pers_morte
after update on tb_personagem
for each row execute procedure tg_pers_morte();

CREATE OR REPLACE FUNCTION tg_respawn_personagem()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.QTD_PontosDeVida = 0 THEN
    NEW.id_Local_Atual := 1;
    RAISE NOTICE 'Você morreu e perdeu todo dinheiro em seu inventário';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_respawn_personagem_trigger
BEFORE INSERT OR UPDATE ON tb_personagem
FOR EACH ROW
EXECUTE FUNCTION tg_respawn_personagem();


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

