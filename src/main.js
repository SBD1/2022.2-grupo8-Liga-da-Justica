import Api from "./api.js";
import { question } from "readline-sync";
import { mapa } from "./mapa.js";
import { inventario } from "./Inventario.js";
import { mercador } from "./Mercador.js";

class Player {
  constructor(id, nome, id_localAtual, pos_x, pos_y) {
    this.id = id;
    this.nome = nome;
    this.id_localAtual = id_localAtual;
    this.pos_x = pos_x;
    this.pos_y = pos_y;
  }
}

function askAndReturn(texto) {
  return question(texto);
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms *1000));
}

function findProxRegiao(regiaoAtual) {
  let obj = {};
  switch (regiaoAtual) {
    case "QG da Liga":
      obj.nome = "Arkham City";
      obj.pos = 4;
      break;
    case "QG dos Vilões":
      obj.nome = "Metrópoles";
      obj.pos = 4;
      break;
    case "Arkham City":
      obj.nome = "Metrópoles";
      obj.pos = 4;
      break;
    case "Metrópoles":
      obj.nome = "Arkham City";
      obj.pos = 4;
      break;
    default:
      return "regiao não existe";
  }
  return obj;
}

function findPrevRegiao(regiaoAtual) {
  let obj = {};
  switch (regiaoAtual) {
    case "QG da Liga":
      obj.nome = "Metrópoles";
      obj.pos = 0;
      break;
    case "QG dos Vilões":
      obj.nome = "Arkham City";
      obj.pos = 0;
      break;
    case "Arkham City":
      obj.nome = "QG dos Vilões";
      obj.pos = 0;
      break;
    case "Metrópoles":
      obj.nome = "QG da Liga";
      obj.pos = 0;
      break;
    default:
      return "regiao não existe";
  }
  return obj;
}

const main = async () => {
  const api = new Api();
  let player = new Player();
  let result = {};
  let posicao = 0;
  let npc = {};
  let username = "";
  let regiao = "";
  let aux = 1;
  let r = askAndReturn(
    "1- Jogar\n2- Sair\n3- Criar e Popular Tabelas\n4- Criar personagem\n"
  );

  if (r == 4) {
    let res = 0;
    try {
      const nome = askAndReturn("Escreva o nome do seu personagem: ");
      const sexo = askAndReturn("\nEscolha o sexo do seu personagem:\n0- Masculino\n1- Feminino\n");
      const classe = askAndReturn("\nEscolha a classe do seu personagem:\n1- Velocista\n2- Magico\n3- Combatente\n4- Detetive\n5- Brutamonte\n");
      const faccao = askAndReturn("\nEscolha a faccao do seu personagem:\n1- Heroi\n2- Vilao\n");
      const raca = askAndReturn("\nEscolha a raca do seu personagem:\n1- Humano\n2- Homi Magi\n3- Amazonas\n4- Atlante\n5- Alien\n");
      await api.criarPersonagem(nome, sexo, classe, faccao, raca);
      console.log('\n\nSeu personagem foi criado com sucesso!\n\n');
      await sleep(3);
    } catch (error) {
      console.log(error);
    }
    r = askAndReturn("1- Jogar\n2- Sair\n");
  }

  if (r == 3) {
    try {
      let res = await api.createTables();
      if (res) {
        console.log("\n\nTabelas criadas com sucesso");
      }
    } catch (error) {
      console.log(error);
    }
    try {
      let res = await api.populateTables();
      let trg = await api.createTriggers();
      if (res) {
        console.log("Dados inseridos com sucesso\n\n");
        await sleep(3);
      }
    } catch (error) {
      console.log(error);
    }
    r = askAndReturn("1- Jogar\n2- Sair\n");
  }
  if (r == 2) {
    process.exit();
  }

  if (r == 1) {
    while (aux != 0) {
      username = askAndReturn("Digite o nome do personagem:");
      try {
        const result = await api.getLogin(username);
        posicao = await api.getPosicao(result.id_local_atual);

        player = new Player(
          result.id,
          result.nome,
          result.id_local_atual,
          posicao.posicao_x,
          posicao.posicao_y
        );

        console.log("\n\nBem-vindo " + player.nome + "\n\n");
        await sleep(3);
        break;
      } catch (error) {
        console.log(error);
      }
    }

    while (aux != 0) {
      let m = 0;
      try {
        result = await api.getLogin(username);
        posicao = await api.getPosicao(result.id_local_atual);
        npc = await api.checaPosicao(result.id_local_atual);
      } catch (error) {
        console.log("Aqui:");
        console.log(error);
      }

      mapa(posicao.posicao_x, posicao.posicao_y);

      console.log(
        `voce está em '${posicao.nome} (${posicao.posicao_x}, ${posicao.posicao_y})'\n`
      );

      switch (npc.tipo) {
        case "Inimigo":
          const ini = await api.checaInimigo(npc.idNpc);
          console.log("\nvoce encontrou um inimigo!");
          await sleep(2);
          console.log(
            `\nDados do inimigo:\n 'nome: ${ini.nome} Força de ataque: ${ini.dano},EXP: ${ini.experiencia}'\n`
          );
          await sleep(2);
          let i = askAndReturn(
            " \nO que voce ira fazer?\n 1- Lutar\n2- Fugir\n"
          );
          if (i == 1) {


            i = askAndReturn("Visualizar Inventario antes da batalha (S/N): ");

            if (i.toLowerCase() == 's') await inventario(player.id);

            console.log("\n\nHora do duelo\n\n");
            await sleep(2);
            const batalha = await api.batalhar(result.id, npc.idNpc);
            if (batalha.vencedor == "NPC") {
              console.log("\n\nvoce perdeu a batalha para:" + ini.nome + "\n\n")
              await sleep(3);
            }
            if (batalha.vencedor == "Personagem") {
              console.log("\n\nvoce venceu:" + ini.nome+ "\n\n")
              await sleep(3);
            }
          }
          if (i == 2) {
            console.log("\n\nvoce Fugiu!\n\n")
            await sleep(3);
            console.log(
              `voce está em '${posicao.nome} (${posicao.posicao_x}, ${posicao.posicao_y})'\n`
            );
          }

          break;
        case "Mercador":
          
          //console.log(npc.idNpc)
          await mercador(player.id,npc.idNpc);

          break;

        case "Mentor":
          console.log("\n\nvoce encontrou um mentor\n\n");
          await sleep(3);
          break;
      }

      if (posicao.posicao_x == 4 && posicao.posicao_y == 4) {
        m = askAndReturn(
          "1- Andar para frente\n2- Andar para tras\n3- Andar para cima\n4- Andar para baixo\n5- Ver meus dados\n6- Ver inventário\n7- Ir para proxima regiao\n"
        );
        regiao = findProxRegiao(posicao.nome);
      } else if (posicao.posicao_x == 0 && posicao.posicao_y == 0) {
        m = askAndReturn(
          "1- Andar para frente\n2- Andar para tras\n3- Andar para cima\n4- Andar para baixo\n5- Ver meus dados\n6- Ver inventário\n7- Voltar para a regiao anterior\n"
        );
        regiao = findPrevRegiao(posicao.nome);
      } else {
        m = askAndReturn(
          "1- Andar para frente\n2- Andar para tras\n3- Andar para cima\n4- Andar para baixo\n5- Ver meus dados\n6- Ver inventario\n"
        );
      }
      if (m == 1) {
        try {
          let pos = await api.findIdPosicao(
            posicao.posicao_x + 1,
            posicao.posicao_y,
            posicao.nome
          );
          await api.updatePosicao(pos.id, player.id);
        } catch (error) {
          console.log(error);
        }
      }
      if (m == 2) {
        try {
          let pos = await api.findIdPosicao(
            posicao.posicao_x - 1,
            posicao.posicao_y,
            posicao.nome
          );
          await api.updatePosicao(pos.id, player.id);
        } catch (error) {
          console.log(error);
        }
      }
      if (m == 3) {
        try {
          let pos = await api.findIdPosicao(
            posicao.posicao_x,
            posicao.posicao_y + 1,
            posicao.nome
          );
          await api.updatePosicao(pos.id, player.id);
        } catch (error) {
          console.log(error);
        }
      }

      if (m == 4) {
        try {
          let pos = await api.findIdPosicao(
            posicao.posicao_x,
            posicao.posicao_y - 1,
            posicao.nome
          );
          await api.updatePosicao(pos.id, player.id);
        } catch (error) {
          console.log(error);
        }
      }
      if (m == 5) {
        const atq= await api.calcular_ataque(player.id, result.arma_atual)
        console.log(
          `\nSeus dados:\nnome: ${result.nome} \nEXP: ${result.experiencia}, \nQuantidade de vida: ${result.qtd_pontosdevida} 
           \nQuantidade de defesa: ${result.qtd_defesa} \nQuantidade de ataque: ${atq.calcular_ataque} \nQuantidade de honra: ${result.qtd_honra}`
        );
        await sleep(3);
      }
      if (m == 6) {
        await inventario(player.id)
        
      }
      if (m == 7) {
        try {
          let pos = await api.findIdPosicao(
            regiao.pos,
            regiao.pos,
            regiao.nome
          );
          console.log(regiao.nome + ":" + regiao.pos + "--", pos);
          await api.updatePosicao(pos.id, player.id);
        } catch (error) {
          console.log(error);
        }
      }
    }
  }
};

main();
