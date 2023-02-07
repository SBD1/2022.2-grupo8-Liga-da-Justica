import { question } from "readline-sync";
import Api from "./api.js";

const api = new Api();

function askAndReturn(texto) {
    return question(texto);
}

export const mercador = async (id_personagem, id_npc) => {
    
    console.log("Você encontrou um mercador");
    let q = askAndReturn('1- Negociar\n2- Sair\n');
    
    if(q == 1) {
        
        console.log('\nEscolha qual item deseja negociar:\n')
        let n = askAndReturn('1- Equipamento\n2- Consumivel\n');

        n = Number.parseInt(n);

        switch(n){

            case 1:
                console.log('\nEscolha qual desses equipamentos deseja negociar:');
                let i = askAndReturn('\n1- Armas\n2- Armaduras\n3- Acessorios\n');
                let a;
                
                i = Number.parseInt(i);
                
                switch (i) {

                
                    case 1:
                        console.log('\nEscolha uma dessas armas:\n');
                        a = askAndReturn('1- Espada\n2- Pistola\n3- Bastao longo\n4- Tridente\n5- Arco e flecha\n6- Soco ingles\n');
                        
                        if(verifica(1,6,Number.parseInt(a))) break;

                        await api.verificarCompra(id_personagem,Number.parseInt(a),id_npc);

                        console.log(`Voce adquiriu a arma: ${a}\n`);
                        
                        break;
                    case 2:
                        console.log('\nEscolha uma dessas armaduras:\n');
                        a = askAndReturn('7- Capacete de combate\n8- Coleto balistico\n9- Armadura completa balistica\n10- Amvabraco de titanio\n11- joelheira comum\n');
                        
                        if(verifica(7,11,Number.parseInt(a))) break;

                        await api.verificarCompra(id_personagem,Number.parseInt(a),id_npc);

                        console.log(`Voce adquiriu a armadura: ${a}\n`);

                        break;
                    case 3:
                        console.log('\nEscolha um desses acessorios:\n');
                        a = askAndReturn('12- Capa usada do Batman\n13- Capa usada do Superman\n14- Braceletes usados da Mulher Maravilha\n15- Mascara capanga coringa\n16- Cartola magica\n');

                        if(verifica(12,16,Number.parseInt(a))) break;

                        await api.verificarCompra(id_personagem,Number.parseInt(a),id_npc);

                        console.log(`Voce adquiriu o consumivel: ${a}\n`);

                        break;
                    default:
                        break;
                } 
                break;
            case 2:
                console.log('\nEscolha qual desses consumiveis deseja negociar:');
                let e = askAndReturn('\n17- Pocao de vida\n18- Tonico\n19- Injecao de adrenalina\n20- Pocao magica\n21- Band-Aid\n');

                if(verifica(17,21,Number.parseInt(e))) break;

                await api.verificarCompra(id_personagem,Number.parseInt(e),id_npc);

                console.log(`Voce adquiriu o consumivel: ${e}\n`);
                break;
            default:
                break;
        }
    
    }else if(q == 2) {
        console.log('Voce saiu da negociacao');
    }
}

function verifica(min,max,input){
    if(input < min || input > max) return true;

    return false
}

//mercador(1,16)

