import Api from "./api.js";

export const mapa = (posX,posY) => {

    var mapaX = [
    
        ["(     )","(     )","(     )","(     )","(     )"],
        ["(     )","(     )","(     )","(     )","(     )"],
        ["(     )","(     )","(     )","(     )","(     )"],
        ["(     )","(     )","(     )","(     )","(     )"],
        ["(     )","(     )","(     )","(     )","(     )"],
    
    ];

    mapaX[posX][posY] = "( YOU )";
    console.log(mapaX);

}





