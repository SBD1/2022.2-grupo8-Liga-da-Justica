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
    let inimigo, mentor, mercador;
    let obj = {};
    await this.db
      .query(`select * from tb_npc where id_regiao ='${id}'`)
      .then((results) => {
        response = results.rows;
      });

    if (response.length != 0) {
      inimigo = await this.checaInimigo(response[0].id);
      mentor = await this.checaMentor(response[0].id);
      mercador = await this.checaMercador(response[0].id);

      if (inimigo) {
        obj.tipo = "Inimigo";
        obj.idNpc = inimigo.id_npc;
        return obj;
      }
      if (mentor) {
        obj.tipo = "Mentor";
        obj.idNpc = mentor.id_npc;
        return obj;
      }
      if (mercador) {
        obj.tipo = "Mercador";
        obj.idNpc = mercador.id_npc;
        return obj;
      }
    } else {
      obj.tipo = "Nda";
      return obj;
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

  batalhar = async (id_personagem, id_inimigo) => {
    let response = [];
    
    const ini = await this.checaInimigo(id_inimigo);
    await this.db
      .query(
        `insert into tb_batalha(id_personagem, id_npc_inimigo) values('${id_personagem}','${ini.id}'); `
      );

    response = await this.findBatalha(id_personagem, ini.id);
   
    return response;
  };

  findBatalha = async (id_personagem, id_inimigo) => {
    let response = [];
    await this.db
      .query(
        `select * from tb_batalha where id_personagem ='${id_personagem}' and id_npc_inimigo ='${id_inimigo}'`
      )
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

  matarPersonagem = async (id) => {
    console.log("entrei");
    let response = [];
    await this.db
      .query(`update tb_personagem set qtd_pontosdevida = 0 where id= ${id}`)
      .then((results) => {
        console.log(response);
        response = results.rows;
      });
    return response[0];
  };
}

export default Api;
