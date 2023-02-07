import pg from "pg";

import { readFileSync } from "fs";

const { Client } = pg;
var sqlTables = readFileSync("scripts/ddl.sql").toString();
var sqlData = readFileSync("scripts/dml.sql").toString();
var sqlTrg = readFileSync("scripts/trigger_stored_procedure.sql").toString();


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

  createTriggers = async () => {
    let response = false;
    await this.db.query(sqlTrg).then((results) => {
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

  getConsumivel = async (id_personagem) => {
    let response = [];
    await this.db
      .query(
        `select tbc.nome, tbc.descricao, tbc.id_item  
        FROM  tb_instancia_item tii ,tb_item_consumivel tbc, tb_inventario inv
        WHERE inv.id_personagem = ${id_personagem} and tii.id_inventario  = inv.id
        and tbc.id_item = tii.id_item 
        `
      )
      .then((results) => {
        response = results.rows;
    });

    return response;
  };

  setArma = async (id_personagem,id_arma) => {
    console.log("NO banco")
    await this.db
    .query(
      `SELECT selecionar_arma('${id_personagem}','${id_arma}')`
    )

  };


  getArma = async (id_personagem) => {
    let response = [];
    await this.db
      .query(
        `SELECT tiea.nome, tiea.mult_ataque, tiea.id_equipamento 
        FROM tb_inventario inv,tb_instancia_item item,tb_item_equipamento_arma tiea
        WHERE inv.id_personagem = '${id_personagem}' AND tiea.id_equipamento = item.id_item 
        AND item.id_inventario = inv.id;
        `
      )
      .then((results) => {
        response = results.rows;
    });

    return response;
  };

  setArmadura = async (id_personagem,id_armadura) => {

    await this.db
      .query(
        `SELECT selecionar_arma('${id_personagem}','${id_armadura}') 
        `
      )
    
  };

  getArmadura = async (id_personagem) => {
    let response = [];
    await this.db
      .query(
        `SELECT tiea.nome, tiea.descricao, tiea.mult_defesa, tiea.id_equipamento
        FROM  tb_instancia_item tii ,tb_item_equipamento_armadura tiea, tb_inventario inv
        WHERE inv.id_personagem = '${id_personagem}' and tii.id_inventario  = inv.id
        and tiea.id_equipamento = tii.id_item
        `
      )
      .then((results) => {
        response = results.rows;
    });

    return response;
  };

  setAcessorio = async (id_personagem,id_acessorio) => {
  
    await this.db
    .query(
      `SELECT selecionar_arma('${id_personagem}','${id_acessorio}') 
      `
    )
  };

  getAcessorio = async (id_personagem) => {
    let response = [];
    await this.db
      .query(
        `SELECT tiea.nome, tiea.descricao, tiea.mult_poder, tiea.id_equipamento
        FROM tb_inventario inv,tb_instancia_item item,tb_item_equipamento_acessorio tiea
        where inv.id_personagem = '${id_personagem}' and tiea.id_equipamento = item.id_item 
        and item.id_inventario = inv.id 
        `
      )
      .then((results) => {
        response = results.rows;
    });

    return response;
  };

  ConsumirItem = async (id_personagem,id_item) => {

    await this.db
      .query(
        `SELECT consumir_item('${id_personagem}','${id_item}')
        `
      )

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

  verificarCompra = async (id_p,id_item,id_npc) => {

    await this.db
      .query(
        `select verificar_compra('${id_p}','${id_item}','${id_npc}')
        `
      ).then((result) => {
        //console.log(result)
        if(result.rows[0].verificar_compra == 0) console.log("Voce nao possui saldo ou honra suficiente");

      })
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

  calcular_ataque = async (id_personagem, arma_atual) => {
    let response = [];
    await this.db
      .query(
        `SELECT Calcular_ataque(${id_personagem}, ${arma_atual}); `
      ).then((results) => {
        response = results.rows;
      });
   
    return response[0];
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
