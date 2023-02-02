import pg from "pg";

import { readFileSync } from "fs";

const { Client } = pg;
var sqlTables = readFileSync("scripts/ddl.sql").toString();
var sqlData = readFileSync("scripts/dml.sql").toString();

class Api {
  db = new Client({
    user: "postgres",
    host: "localhost",
    database: "postgres",
    password: "postgres",
    port: 5001,
  });

  constructor() {
    this.db.connect();
  }

  getLogin = async (name) => {
    let response = [];
    await this.db
      .query(`SELECT * FROM tb_personagem WHERE nome = '${name}'`)
      .then((results) => {
        response = results.rows;
      });
    return response[0];
  };

  createTables = async () => {
    let response = false;
    await this.db.query(sqlTables).then((results) => {
      response = true;
    });
    return response;
  };

  populateTables = async () => {
    let response = false;
    await this.db.query(sqlData).then((results) => {
      response = true;
    });
    return response;
  };

  getPosicao = async (id) => {
    let response = [];
    await this.db
      .query(
        `select r.posicao_x , r.posicao_y, r.nome from tb_regiao r where id= '${id}'`
      )
      .then((results) => {
        response = results.rows;
      });
    return response[0];
  };

  updatePosicao = async (id_posicao, id_personagem) => {
    let response = [];
    await this.db
      .query(
        `update tb_personagem set id_local_atual = ${id_posicao} where id=${id_personagem}
        `
      )
      .then((results) => {
        response = results.rows;
      });
    return response[0];
  };

  findIdPosicao = async (pos_x, pos_y, nome) => {
    let response = [];
    await this.db
      .query(
        `select * from tb_regiao where posicao_x ='${pos_x}' and posicao_y ='${pos_y}'  and nome = '${nome}'
        `
      )
      .then((results) => {
        response = results.rows;
      });
    return response[0];
  };

  checaPosicao = async (id) => {
    let response = [];
    let inimigo,mentor, mercador;
    await this.db
      .query(`select * from tb_npc where id_regiao ='${id}'`)
      .then((results) => {
        response = results.rows;
      });

    if (response.length != 0) {
      inimigo = await this.checaInimigo(response[0].id);
      mentor = await this.checaMentor(response[0].id);
      mercador = await this.checaMercador(response[0].id);
      
      if(inimigo){
        return("Inimigo")
      }
      if(mentor){
        return("Mercador")
      }
      if(mercador){
        return("Mentor")
      }

    } else {
      console.log("Não encontrei");
    }
  };

  checaInimigo = async (id) => {
    let response = [];
    await this.db
      .query(`select * from tb_npc_inimigo where id_npc ='${id}'`)
      .then((results) => {
        response = results.rows;
      });
    return response[0];
  };

  checaMentor = async (id) => {
    let response = [];
    await this.db
      .query(`select * from tb_npc_mentor where id_npc ='${id}'`)
      .then((results) => {
        response = results.rows;
      });
    return response[0];
  };

  checaMercador = async (id) => {
    let response = [];
    await this.db
      .query(`select * from tb_npc_mercador where id_npc ='${id}'`)
      .then((results) => {
        response = results.rows;
      });
    return response[0];
  };

  criarPersonagem = async (nome, sexo, idClasse, idFaccao, idRaca) => {
    let response = [];
    await this.db
      .query(`select criarPersonagem('${nome}', '${sexo}', '${idClasse}', '${idFaccao}', '${idRaca}')`)
      .then((results) => {
        console.log(response);
        response = results.rows;
      });
    return response[0];
  };
}

export default Api;
