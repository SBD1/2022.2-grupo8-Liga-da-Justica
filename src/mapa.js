import Api from "./api.js";

export const mapa = (posX,posY) => {

    var mapaX = [
    
        ["(     )","(     )","(     )","(     )","(     )"],
        ["(     )","(     )","(     )","(     )","(     )"],
        ["(     )","(     )","(     )","(     )","(     )"],
        ["(     )","(     )","(     )","(     )","(     )"],
        ["(     )","(     )","(     )","(     )","(     )"],
    
    ];

    mapaX[posY][posX] = "( YOU )";
    console.log(mapaX);

}





