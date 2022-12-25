CREATE TABLE TB_MISSAO (
    ID_Missao int not null,
    Nivel_min int,
    REQ_Faccao boolean not null,
    ID_Faccao int,
    REQ_Honra int
);

insert INTO tb_missao(id_missao,nivel_min,req_faccao,id_faccao)
VALUES(0,3,true,1)