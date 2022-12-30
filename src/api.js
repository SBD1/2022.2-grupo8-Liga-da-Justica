const pg = require('pg')
const readline = require('readline-sync');


class Player{
    constructor(id,nome, id_localAtual, pos_x, pos_y){
        this.id=id,
        this.nome= nome;
        this.id_localAtual = id_localAtual;
        this.pos_x = pos_x;
        this.pos_y =pos_y;
    }
}

class Api{
     db = new pg.Client({
        user: 'postgres',
        host:'localhost',
        database:'postgres',
        password:'postgres',
        port: 5001
    });

    constructor(){
        this.db.connect();
    }

        getLogin = async (name) => {
        let response  = [];
        await this.db.query(`SELECT * FROM tb_personagem WHERE nome = '${name}'`)
            .then((results) => {
                response = results.rows
            })
        return response[0];
    };

    getPosicao = async (id) => {
        let response  = [];
        await this.db.query(`select r.posicao_x , r.posicao_y, r.nome from tb_regiao r where id= '${id}'`)
            .then((results) => {
                response = results.rows
            })
        return response[0];
    };

    updatePosicao = async (id_posicao, id_personagem) => {
        let response  = [];
        await this.db.query(`update tb_personagem set id_local_atual = ${id_posicao} where id=${id_personagem}
        `)
            .then((results) => {
                response = results.rows
            })
        return response[0];
    };

    findIdPosicao = async (pos_x, pos_y, nome) => {
        let response  = [];
        await this.db.query(`select * from tb_regiao where posicao_x ='${pos_x}' and posicao_y ='${pos_y}'  and nome = '${nome}'
        `)
            .then((results) => {
                response = results.rows
            })
        return response[0];
    };
}







function askAndReturn(texto){
    return readline.question(texto)
}


main = async () =>{
const api = new Api();
const r = askAndReturn('1- Jogar\n2- Sair\n')
let player = new Player()
let posicao= 0
let username =''

    if (r == 2) {
        process.exit()
    }
    
    if (r == 1) {
        let aux=1
        while (aux !=0){
            username = askAndReturn("Digite o nome do personagem:")
            try {
                result=  await api.getLogin(username)
                posicao = await api.getPosicao(result.id_local_atual)
                
                 player = new Player(result.id, result.nome,result.id_local_atual, posicao.posicao_x, posicao.posicao_y)

                console.log("Bem-vindo " + player.nome)
                break;
             } catch (error) {
                 console.log(error)
             }

        }

        while(aux!=0){
            try {
                result=  await api.getLogin(username)
                posicao = await api.getPosicao(result.id_local_atual)
            } catch (error) {
                console.log(error)
            }            
            console.log(`Você está em '${posicao.nome} (${posicao.posicao_x}, ${posicao.posicao_y})'`)
            const m= askAndReturn('1- Andar para frente\n2- Andar para trás\n3- Andar para cima\n4- Andar para baixo\n')
            console.log(m)
            if(m==1){
                try {
                    pos= await api.findIdPosicao(posicao.posicao_x +1 , posicao.posicao_y, posicao.nome) 
                    console.log(pos.id)
                    await api.updatePosicao(pos.id, player.id)
                } catch (error) {
                    console.log(error)
                }
                
            }
            if(m==2){
                try {
                    pos= await api.findIdPosicao(posicao.posicao_x -1 , posicao.posicao_y, posicao.nome) 
                    console.log(pos.id)
                    await api.updatePosicao(pos.id, player.id)
                } catch (error) {
                    console.log(error)
                }
                
            }
            if(m==3){
                try {
                    pos= await api.findIdPosicao(posicao.posicao_x , posicao.posicao_y+1, posicao.nome) 
                    console.log(pos.id)
                    await api.updatePosicao(pos.id, player.id)
                } catch (error) {
                    console.log(error)
                }
                
            }

            if(m==4){
                try {
                    pos= await api.findIdPosicao(posicao.posicao_x , posicao.posicao_y-1, posicao.nome) 
                    console.log(pos.id)
                    await api.updatePosicao(pos.id, player.id)
                } catch (error) {
                    console.log(error)
                }
                
            }
        }
    }
}

main()



