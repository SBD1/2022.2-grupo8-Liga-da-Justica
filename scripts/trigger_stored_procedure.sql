-- TRIGGERS PARA MANTER AS REGRAS DE GENERALIZAÇÃO E ESPECIALIZAÇÃO 

insert into tb_personagem(experiencia, nivel, nome, QTD_PontosDeVida, MAX_PontoDeVida, sexo, QTD_PontosDeEstamina, MAX_PontosDeEstamina, QTD_Honra, QTD_Defesa, QTD_Ataque, id_poder, id_Local_Atual, id_ajudante, id_mentor, id_classe, id_faccao, id_raca) values (97, 4, 'Correia', 100, 150, 0, 123, 175, 80, 5, 4, 2, 17, 1, 1, 1, 1, 1);

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
begin
	
	insert into tb_poderes(Velocidade, Furtividade, Magia, Forca, Carisma, Percepcao) values ('4', '4', '4', '4', '4', '4') RETURNING id into idPoder;
	new.id_poder := idPoder;
	
return new;

END
$$
  LANGUAGE 'plpgsql';

--Trigger para inserção de personagem 

CREATE TRIGGER  "tg_criaTbPoder " before INSERT 
ON tb_personagem FOR EACH ROW 
    EXECUTE function  criarPoderPersonagem();