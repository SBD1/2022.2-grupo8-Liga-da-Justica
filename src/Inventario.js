import { question } from "readline-sync";
import Api from "./api.js";

function askAndReturn(texto) {
    return question(texto);
}

function separador(){
    console.log("=====================================================================================================\n")
}


const api = new Api();

/* 
    Parametro:
    id = Identificador do personagem atual
*/

export const inventario = async (id) => {


    console.log(`====== Inventario ${id} ==========`)
    console.log("1 - Consumivel")
    console.log("2 - Equipamento")

    separador()

    var res = askAndReturn("Selecione: ")

    switch (res) {
        case '1':

            const response = await api.getConsumivel(id);
            
            if(verifyLength(response)) break;

            separador();

            for(const cons of response){
                console.log(`id: ${cons.id_item} | Nome: ${cons.nome} | Descrição: ${cons.descricao} `)
            }

            res = askAndReturn("====== Deseja consumir algum item (S/N): ========");

            if(res.toLowerCase() == 's'){

                res = askAndReturn("Escolha o numero indicador do consumivel: ");
                const id_item = Number.parseInt(res);
                await api.ConsumirItem(id,id_item)
            }

            separador();

            break;
        case '2':
            
            separador();

            
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
                            console.log(`Id: ${cons.id_equipamento} | Nome: ${cons.nome} | mult_defesa: ${cons.mult_defesa} | descricao: ${cons.descricao}`)
                        }

                        res = askAndReturn("====== Deseja selecionar alguma armadura (S/N): ========\n");

                        if(res.toLowerCase() == 's'){
            
                            res = askAndReturn("Escolha o numero indicador da armadura: ");
                            const id_item = Number.parseInt(res);
                            await api.setArmadura(id,id_item)
                        }
            
                        break;
                    case '2':

                        const arma = await api.getArma(id);

                        if(verifyLength(arma)) break;

                        for(const cons of arma){
                            console.log(`Id: ${cons.id_equipamento} | Nome: ${cons.nome} | Mult_Ataque: ${cons.mult_ataque}`)
                        }
                        
                        res = askAndReturn("====== Deseja selecionar alguma arma (S/N): ========\n");

                        if(res.toLowerCase() == 's'){
            
                            res = askAndReturn("Escolha o numero indicador da arma: ");
                            const id_item = Number.parseInt(res);
                            await api.setArma(id,id_item)
                        }

                        break;
                    case '3':

                        const acessorio = await api.getAcessorio(id);
                        if(verifyLength(acessorio)) break;

                        for(const cons of acessorio){
                            console.log(`Id: ${cons.id_equipamento} | Nome: ${cons.nome} | Mult_poder: ${cons.mult_poder} | descricao ${cons.descricao}`)
                        }

                        res = askAndReturn("====== Deseja selecionar alguma acessorio (S/N): ========\n");

                        if(res.toLowerCase() == 's'){
            
                            res = askAndReturn("Escolha o numero indicador da acessorio: ");
                            const id_item = Number.parseInt(res);
                            await api.setAcessorio(id,id_item)
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
    separador();

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