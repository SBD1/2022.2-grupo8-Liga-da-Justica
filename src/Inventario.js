import { question } from "readline-sync";
import Api from "./api.js";

function askAndReturn(texto) {
    return question(texto);
}

const api = new Api();

export const inventario = async (id) => {


    console.log(`====== Inventario ${id} ==========`)
    console.log("1 - Consumivel")
    console.log("2 - Equipamento")
    var res = askAndReturn("Selecione: ");

    switch (res) {
        case '1':

            const response = await api.getConsumivel(id);
            
            if(verifyLength(response)) break;

            for(const cons of response){
                console.log(`Nome: ${cons.nome} | Descrição: ${cons.descricao} `)
            }

            break;
        case '2':
            
            console.log("1 - Armadura")
            console.log("2 - Arma")
            console.log("3 - Acessorio")
            res = askAndReturn("Selecione: ");

                switch (res) {

                    case '1':
                        const armadura = await api.getArmadura(id);

                        if(verifyLength(armadura)) break;

                        //console.log(armadura)

                        for(const cons of armadura){
                            console.log(`Nome: ${cons.nome} | mult_defesa: ${cons.mult_defesa} | descricao: ${cons.descricao}`)
                        }

                        break;
                    case '2':

                        const arma = await api.getArma(id);

                        if(verifyLength(arma)) break;

                        for(const cons of arma){
                            console.log(`Nome: ${cons.nome} | Mult_Ataque: ${cons.mult_ataque}`)
                        }
                        break;
                    case '3':

                        const acessorio = await api.getAcessorio(id);
                        if(verifyLength(acessorio)) break;

                        for(const cons of acessorio){
                            console.log(`Nome: ${cons.nome} | Mult_poder: ${cons.mult_poder} | descricao ${cons.descricao}`)
                        }

                        break;
                    default:

                        console.log("Algum erro ocorreu, tente novamente");
                        break;
                }


            break;
        default:
            console.log("Algum erro ocorreu, tente novamente");
            break;
    }

    console.log(" ");

}

function verifyLength(item){
    if (item.length == 0){
        console.log("Nenhum item encontrado");
        return true;
    }
    return false;
}

//inventario(1)