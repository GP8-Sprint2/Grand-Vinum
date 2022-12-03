var database = require("../database/config");

function buscarUltimasMedidas(idBarril,limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        umidade as umidade,
        temperatura_C as temperatura,   
                        data_hora,
                        FORMAT(data_hora, 'HH:mm:ss') as data_hora
                    from metrica
                    where fkBarrilVinho = ${idBarril}
                    order by idMetrica desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        umidade as umidade,
        temperatura_C as temperatura, 
                        dataHora,
                        DATE_FORMAT(dataHora,'%H:%i:%s') as data_hora
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

function buscarMedidasEmTempoReal(idBarril) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        umidade as umidade, 
        temperatura_C as temperatura,  
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
                    where fkBarrilVinho = ${idBarril}
                    order by idmetrica desc limit 1`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function carregarTempIdeal(fkUsuario) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", fkUsuario)
    var instrucao = `
        SELECT 
        COUNT(fkBarrilVinho) AS tempIdeal
    FROM
        CadastroCliente
            JOIN
        barrilVinho ON idCadastroCliente = fkCadastroCliente
            JOIN
        metrica ON fkBarrilVinho = idBarrilVinho
    WHERE
    fkCadastroCliente = ${fkUsuario} and
            temperatura_C >= 14
                AND temperatura_C <= 16 and dataHora = (select dataHora from metrica order by dataHora desc limit 1);
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function carregarTempFora(fkUsuario) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", fkUsuario)
    var instrucao = `
        SELECT 
        COUNT(fkBarrilVinho) AS tempForaIdeal
    FROM
        CadastroCliente
            JOIN
        barrilVinho ON idCadastroCliente = fkCadastroCliente
            JOIN
        metrica ON fkBarrilVinho = idBarrilVinho
    WHERE
    fkCadastroCliente = ${fkUsuario} and
            temperatura_C < 14
                or temperatura_C > 16 and dataHora = (select dataHora from metrica order by dataHora desc limit 1);
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function carregarUmidadeIdeal(fkUsuario) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", fkUsuario)
    var instrucao = `
        SELECT 
        COUNT(fkBarrilVinho) AS umidadeIdeal
    FROM
        CadastroCliente
            JOIN
        barrilVinho ON idCadastroCliente = fkCadastroCliente
            JOIN
        metrica ON fkBarrilVinho = idBarrilVinho
    WHERE
    fkCadastroCliente = ${fkUsuario} and umidade >= 53
                AND umidade <= 57 and dataHora = (select dataHora from metrica order by dataHora desc limit 1);
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function carregarUmidadeFora(fkUsuario) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", fkUsuario)
    var instrucao = `
        SELECT 
        COUNT(fkBarrilVinho) AS umidadeForaIdeal
    FROM
        CadastroCliente
            JOIN
        barrilVinho ON idCadastroCliente = fkCadastroCliente
            JOIN
        metrica ON fkBarrilVinho = idBarrilVinho
    WHERE
    fkCadastroCliente = ${fkUsuario} and 
            umidade < 53
                or umidade > 57 and dataHora = (select dataHora from metrica order by dataHora desc limit 1);
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
