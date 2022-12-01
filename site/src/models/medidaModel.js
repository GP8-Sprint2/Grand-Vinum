var database = require("../database/config");

function buscarUltimasMedidas(idBarril,limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        momento,
                        FORMAT(momento, 'HH:mm:ss') as momento_grafico
                    from medida
                    where fk_aquario = ${idBarril}
                    order by idMetrica desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        umidade as umidade,
        temperatura_C as temperatura, 
                        dataHora,
                        DATE_FORMAT(dataHora,'%H:%i:%s') as momento_grafico
                    from metrica
                    where fkBarrilVinho = ${idBarril}
                    order by idMetrica desc limit ${limite_linhas}`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal() {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        umidade as umidade, 
        temperatura_C as temperatura,,  
                        dataHora,
                        FORMAT(dataHora, 'HH:mm:ss') as data_hora
                    from metrica
                    order by idmetrica desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        umidade as umidade, 
        temperatura_C as temperatura,
                        dataHora,
                        DATE_FORMAT(dataHora,'%H:%i:%s') as data_hora
                    from metrica 
                    order by idmetrica desc limit 1`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function carregarTempIdeal(idBarril) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", idBarril)
    var instrucao = `
        SELECT 
        COUNT(idMetrica) as tempIdeal
    FROM
        metrica
            JOIN
        barrilVinho ON fkBarrilVinho = idBarrilVinho
    WHERE
        temperatura_C >= 14
            AND temperatura_C <= 16;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function carregarTempFora(idBarril) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", idBarril)
    var instrucao = `
        SELECT 
        COUNT(idMetrica) as tempForaIdeal
    FROM
        metrica
            JOIN
        barrilVinho ON fkBarrilVinho = idBarrilVinho
    WHERE
        temperatura_C < 14
            OR temperatura_C > 16;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function carregarUmidadeIdeal(idBarril) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", idBarril)
    var instrucao = `
        SELECT 
        COUNT(idMetrica) as umidadeIdeal
    FROM
        metrica
            JOIN
        barrilVinho ON fkBarrilVinho = idBarrilVinho
    WHERE
        umidade >= 53
            AND umidade <= 57;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function carregarUmidadeFora(idBarril) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", idBarril)
    var instrucao = `
        SELECT 
        COUNT(idMetrica) as umidadeForaIdeal
    FROM
        metrica
            JOIN
        barrilVinho ON fkBarrilVinho = idBarrilVinho
    WHERE
        umidade < 53
            OR umidade > 57;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    carregarTempIdeal,
    carregarTempFora,
    carregarUmidadeIdeal,
    carregarUmidadeFora
}
