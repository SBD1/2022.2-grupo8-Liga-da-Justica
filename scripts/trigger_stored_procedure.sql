-- TRIGGERS DE REGRAS DE GENERALIZAÇÃO E ESPECIALIZAÇÃO 
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

create trigger personagem_ja_existe
before insert on tb_personagem 
for each row execute procedure personagem_ja_existe();

-- Função para criar personagens com poucos parâmetros 

CREATE OR REPLACE FUNCTION criarPersonagem(nome varchar(30), sexo int, idClasse int, idFaccao int, idRaca int ) RETURNS VOID AS
$$
DECLARE
idMentor int;
idPosicao int;
begin
	select tb_npc_mentor.id into idMentor from tb_npc_mentor where id_classe = idClasse and id_faccao = idFaccao;

  if (idFaccao ='1') then idPosicao = 26;
    end if;
  if (idFaccao ='2') then idPosicao = 51;
    end if;

    insert into tb_personagem(experiencia, nivel, nome, QTD_PontosDeVida, MAX_PontoDeVida, sexo, QTD_PontosDeEstamina, MAX_PontosDeEstamina, QTD_Honra, QTD_Defesa, QTD_Ataque, QTD_Mortes, id_poder, id_Local_Atual, id_ajudante, id_mentor, id_classe, id_faccao, id_raca) 
   values (0, 1, nome, 100, 100, sexo , 100, 100, 50, 0, 0, 0, 1 , idPosicao, null, idMentor, idClasse , idFaccao , idRaca);

END
$$
  LANGUAGE 'plpgsql';;
 

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
$$ LANGUAGE 'plpgsql';

--Trigger para inserção de personagem 

CREATE TRIGGER  "tg_criaTbPoder " before INSERT 
ON tb_personagem FOR EACH ROW 
    EXECUTE function  criarPoderPersonagem();

--Trigger de morte/respawn do personagem e perda de dinheiro 

create or replace function tg_pers_morte() returns trigger as $tg_pers_morte$
begin 
	if (new.QTD_PontosDeVida <= 0) then 
   	   update tb_inventario 
   	   set qtd_dinheiro = '0'
   	   where id_personagem = new.id;
   	   new.qtd_mortes = old.qtd_mortes + 1;
   	   new.QTD_PontosDeVida := 100;
   	   		if (new.id_faccao = 1) then
   	   		new.id_local_atual := '26';
   	   		raise notice 'Seu herói morreu e perdeu todo o dinheiro';
   	   		elseif (new.id_faccao = 2) then
   	   		new.id_local_atual := '51';
   	   		raise notice 'Seu vilão morreu e perdeu todo o dinheiro';
   	   		end if;
    end if;
    return new;
end;
$tg_pers_morte$ language plpgsql;

create trigger tg_pers_morte
before update on tb_personagem
for each row execute procedure tg_pers_morte();


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


--Função que inicia uma batalha, mostra o vencedor e calcula a vida atual
CREATE OR REPLACE FUNCTION iniciar_batalha()
RETURNS TRIGGER AS $$

  DECLARE dano_inimigo INT;
  DECLARE qtd_ataque_personagem INT;
  DECLARE vida_inimigo INT;
  DECLARE vida_personagem INT;
  declare xp_inimigo int;
  declare xp_personagem int;
  declare faccao_personagem int;
  declare faccao_inimigo int;
  declare honra_personagem  int;
  declare dinheiro_personagem int;
  declare arma_personagem int; 

 
 begin
  select qtd_pontosdevida into vida_personagem from tb_personagem where tb_personagem.id = new.id_personagem;
  select arma_atual  into arma_personagem from tb_personagem where tb_personagem.arma_atual  = new.id_personagem;
  select qtd_dinheiro into dinheiro_personagem from tb_inventario  where tb_inventario.id_personagem = new.id_personagem;
  select id_faccao into faccao_personagem from tb_personagem where tb_personagem.id = new.id_personagem;
  select qtd_honra into honra_personagem from tb_personagem where tb_personagem.id = new.id_personagem;
  select experiencia into xp_personagem from tb_personagem where tb_personagem.id = new.id_personagem;
  SELECT Calcular_ataque(new.id_personagem, arma_personagem) INTO qtd_ataque_personagem ;
  select vida into vida_inimigo from tb_npc_inimigo WHERE tb_npc_inimigo.id = NEW.id_npc_inimigo;
  SELECT dano INTO dano_inimigo FROM tb_npc_inimigo WHERE tb_npc_inimigo.id = NEW.id_npc_inimigo;
  select experiencia into xp_inimigo from tb_npc_inimigo WHERE tb_npc_inimigo.id = NEW.id_npc_inimigo;
  select id_faccao into faccao_inimigo from tb_npc_inimigo WHERE tb_npc_inimigo.id = NEW.id_npc_inimigo;

  
  IF qtd_ataque_personagem >= dano_inimigo then
  	  vida_inimigo := vida_inimigo - (qtd_ataque_personagem - dano_inimigo);
      UPDATE tb_npc_inimigo SET vida = vida_inimigo WHERE id = NEW.id_npc_inimigo;
    RAISE NOTICE 'Personagem venceu a batalha';
   	update tb_batalha set vencedor = 'Personagem' where id = new.id;
   	update tb_personagem set experiencia = xp_personagem + xp_inimigo where id = new.id_personagem;
   	update tb_inventario  set qtd_dinheiro  = dinheiro_personagem + 10  where id = new.id_personagem;
   case 
   		when (faccao_personagem = '1' and faccao_inimigo ='2') then update tb_personagem set qtd_honra = honra_personagem + 5 where id = new.id_personagem;
   		when (faccao_personagem = '1' and faccao_inimigo ='1') then update tb_personagem set qtd_honra = honra_personagem - 5 where id = new.id_personagem;
   		when (faccao_personagem = '2' and faccao_inimigo ='1') then update tb_personagem set qtd_honra = honra_personagem + 5 where id = new.id_personagem;
   		when (faccao_personagem = '2' and faccao_inimigo ='2') then update tb_personagem set qtd_honra = honra_personagem - 5 where id = new.id_personagem;

   end case;
  else
  	vida_personagem := vida_personagem - (dano_inimigo - qtd_ataque_personagem);
    UPDATE tb_personagem SET qtd_pontosdevida  = vida_personagem WHERE id = NEW.id_personagem;
   	update tb_inventario  set qtd_dinheiro  = dinheiro_personagem - 10  where id_personagem  = new.id_personagem;
    RAISE NOTICE 'NPC inimigo venceu a batalha';
   	update tb_batalha set vencedor = 'NPC' where id = new.id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Trigger que é chamado toda vez que se inicia uma batalha
CREATE TRIGGER iniciar_batalha_trigger
AFTER INSERT ON tb_batalha
FOR EACH ROW
EXECUTE FUNCTION iniciar_batalha();


-- Função de calcular ataque do personagem
CREATE OR REPLACE FUNCTION Calcular_ataque(id_p int,arma_atual int) RETURNS Int AS $$

DECLARE 
  arma_personagem int;
  rowWeapons int;
  Mult_atq INT;

BEGIN

    --Recupera ataque do personagem
    SELECT QTD_Ataque into Mult_atq from tb_personagem where id = id_p;

    --Seleciona armas do personagem
    SELECT count(*) FROM tb_inventario inv,tb_instancia_item item,tb_item_equipamento_arma tiea
    where inv.id_personagem = id_p and tiea.id_equipamento = item.id_item 
    and item.id_inventario = inv.id and tiea.id_equipamento = arma_atual into rowWeapons;


    IF rowWeapons > 0 THEN        
      -- Retorna a arma que está sendo utilizada pelo personagem
      SELECT tiea.mult_ataque FROM tb_inventario inv,tb_instancia_item item,tb_item_equipamento_arma tiea
      where inv.id_personagem = id_p and tiea.id_equipamento = id_item
      and item.id_inventario = inv.id and tiea.id_equipamento = arma_atual into arma_personagem;
    else
      raise notice 'Não possue arma indicada';
      return Mult_atq;
    END IF;

    Mult_atq := Mult_atq + arma_personagem;

  --END IF;
  RETURN Mult_atq;
END;
$$ LANGUAGE plpgsql;

-- Função para consumir item
CREATE OR REPLACE FUNCTION consumir_item(id_p int, id_consumivel int) returns void as $$

DECLARE
  atq int;
  poder int;
  pontos_de_vida int;
  pontos_de_estamina int;
  rowItems int;
  personagem tb_personagem%ROWTYPE;

BEGIN
	
  SELECT count(*)  
  FROM  tb_instancia_item tii ,tb_item_consumivel tbc, tb_inventario inv
  WHERE inv.id_personagem = id_p and tii.id_inventario  = inv.id
  and tbc.id_item = tii.id_item  and tbc.id_item = id_consumivel into rowItems;
  
 IF rowItems > 0 THEN
 
	  SELECT tbc.mult_ataque,tbc.mult_poder, tbc.mult_qtd_pontosdevida, tbc.mult_qtd_ponstosdestamina  
	  FROM  tb_instancia_item tii ,tb_item_consumivel tbc, tb_inventario inv
	  WHERE inv.id_personagem = id_p and tii.id_inventario  = inv.id
	  and tbc.id_item = tii.id_item  and tbc.id_item = id_consumivel into atq,poder,pontos_de_vida,
	  pontos_de_estamina;

    SELECT * FROM tb_personagem where id = id_p into personagem;
    personagem.qtd_ataque := personagem.qtd_ataque + atq;
 	  personagem.QTD_PontosDeVida := personagem.QTD_PontosDeVida + pontos_de_vida;
    personagem.QTD_PontosDeEstamina := personagem.QTD_PontosDeEstamina + pontos_de_Estamina;
	  -- Falta mult_poder
   
    UPDATE tb_personagem SET qtd_ataque = personagem.qtd_ataque WHERE id = id_p;
   	UPDATE tb_personagem SET QTD_PontosDeVida = personagem.QTD_PontosDeVida WHERE id = id_p;
 	  UPDATE tb_personagem SET QTD_PontosDeEstamina = personagem.QTD_PontosDeEstamina WHERE id = id_p;
    -- Falta mult_poder
  else
    raise notice 'Nenhum item consumivel encontrado';
  END IF;
 
END;
$$ LANGUAGE plpgsql;

/* Função de respawn de acordo com a vida (not working well)
CREATE OR REPLACE FUNCTION tg_inimigo_morte() RETURNS TRIGGER AS $$
DECLARE
 id_regiaoAntiga int;
 tempoAtual TIMESTAMP;
BEGIN 
	SELECT NOW() INTO tempoAtual;
	select id_regiao into id_regiaoAntiga from tb_npc where id = new.id_npc;
	
	IF (NEW.vida = 0) THEN	
		UPDATE tb_npc SET id_regiao = 101 WHERE id = NEW.id_npc;
		raise notice 'entrei no 1 if';
	END IF;
	
	IF (NEW.vida = 0 and (extract(minute from age(tempoAtual, (SELECT tempo FROM tb_npc_inimigo WHERE id = NEW.id_npc))) >= 5)) then
	
		
		UPDATE tb_npc SET id_regiao = id_regiaoAntiga WHERE id = new.id_npc;
		new.vida := 100;
		raise notice 'entrei no 2 if';
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


update tb_npc_inimigo 
	set vida = 0 where id_npc = 14
	
update tb_npc_inimigo 
	set vida = 30 where id_npc = 8

-Trigger de respawn de acordo com vida (not working well)
CREATE TRIGGER tg_inimigo_morte
BEFORE UPDATE ON tb_npc_inimigo
FOR EACH ROW 
EXECUTE FUNCTION tg_inimigo_morte();
*/

-- Function para verificar se o jogador possui a arma que deseja selecionar
CREATE OR REPLACE FUNCTION selecionar_arma(id_p int, id_arma int) returns void as $$

DECLARE
 rowWeapons int;
BEGIN
	
	
  	select  count(*) FROM tb_inventario inv,tb_instancia_item item,tb_item_equipamento_arma tiea
    where inv.id_personagem = id_p  and tiea.id_equipamento = item.id_item 
    and item.id_inventario = inv.id and tiea.id_equipamento = id_arma into rowWeapons;
	

    IF rowWeapons = 1 THEN
    	UPDATE tb_personagem SET arma_atual = id_arma WHERE id = id_p;
  	else
      raise exception 'não possue arma indicada';      
    END IF;
   
END;
$$ LANGUAGE plpgsql;

-- Function para verificar se o jogador possui a armadura que deseja selecionar
CREATE OR REPLACE FUNCTION selecionar_armadura(id_p int, id_armadura int) returns void as $$

DECLARE
 rowWeapons int;
BEGIN
	
	
  	select  count(*) FROM tb_inventario inv,tb_instancia_item item,tb_item_equipamento_armadura tiea
    where inv.id_personagem = id_p  and tiea.id_equipamento = item.id_item 
    and item.id_inventario = inv.id and tiea.id_equipamento = id_armadura into rowWeapons;
	

    IF rowWeapons = 1 THEN
    	UPDATE tb_personagem SET armadura_atual = id_armadura WHERE id = id_p;
  	else
      raise exception 'não possue armadura indicada';      
    END IF;
   
END;
$$ LANGUAGE plpgsql;

-- Function para verificar se o jogador possui o acessorio que deseja selecionar
CREATE OR REPLACE FUNCTION selecionar_acessorio(id_p int, id_acessorio int) returns void as $$

DECLARE
 rowWeapons int;
BEGIN
	
  	select  count(*) FROM tb_inventario inv,tb_instancia_item item,tb_item_equipamento_acessorio tiea
    where inv.id_personagem = id_p  and tiea.id_equipamento = item.id_item 
    and item.id_inventario = inv.id and tiea.id_equipamento = id_acessorio into rowWeapons;
	
    IF rowWeapons = 1 THEN
    	UPDATE tb_personagem SET acessorio_atual = id_acessorio WHERE id = id_p;
  	else
      raise exception 'não possue acessorio indicado';      
    END IF;
   
END;
$$ LANGUAGE plpgsql;


create or replace function verificar_compra(id_p int, item int, npc int) returns int as $$

declare 
	inventario int;
	valor_item int;
	saldo int;
	desconto_npc int;
	req_honra int;
	min_honra int;
	id_mercador int;
	count_npc int;
begin
 	
	--select tnm.id from tb_npc tn, tb_npc_mercador tnm  where tn.id = npc and tnm.id_npc = tn.id into id_mercador;
	select id from tb_inventario ti where id_personagem  = id_p into inventario; 
	select qtd_dinheiro from tb_inventario ti where id_personagem = id_p into saldo;
	select valor from tb_item where id = item into valor_item;
	select qtd_honra from tb_personagem tp where id = id_p into req_honra;
	select desconto,req_honra_min from tb_npc_mercador where id_npc  = npc into desconto_npc, min_honra; 
	
	
	select count(*) from tb_npc_mercador where id_npc = npc into count_npc;

	if count_npc = 0 then
		raise notice 'Algo ocorreu de errado na escolha de npc';
    return 0;
  end if;

	valor_item = valor_item - desconto_npc;

	if ((saldo < valor_item) or (req_honra < min_honra)) then
		raise notice 'Voce nao tem saldo ou honra suficiente';
    return 0;
	else
		insert into tb_instancia_item (id_item,id_inventario) values(item,inventario);
		update tb_inventario set qtd_dinheiro = saldo - valor_item where id = inventario;
		update tb_inventario set qtd_atual = qtd_atual + 1 where id = inventario;		
	end if;
	
  return 1;
end;
$$ language plpgsql;