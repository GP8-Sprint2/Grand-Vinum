-- Criar Database
create database GrandVinum;

-- Selecionar Database
use GrandVinum;

-- Criar tabelas

CREATE TABLE CadastroCliente (
    idCadastroCliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cnpj CHAR(14),
    telCel VARCHAR(12),
    email VARCHAR(45),
    CONSTRAINT chkEmail CHECK (email LIKE '%@%'),
    senha VARCHAR(45)
);

CREATE TABLE Endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(45),
    numero INT,
    bairro VARCHAR(45),
    complemento VARCHAR(45),
    cidade VARCHAR(50),
    cep CHAR(8),
    fkCadastroCliente INT,
    FOREIGN KEY (fkCadastroCliente)
        REFERENCES CadastroCliente (idCadastroCliente)
);


create table barrilVinho (
idBarrilVinho int primary key auto_increment,
tipoMadeira varchar(45),
quantidade double,
tipoVinho VARCHAR(45) CONSTRAINT chktipoVinho CHECK(tipoVinho IN('tinto','rose','branco')),
fkCadastroCliente int,
foreign key (fkCadastroCliente) references CadastroCliente (idCadastroCliente)
);

CREATE TABLE metrica (
    idmetrica INT AUTO_INCREMENT,
    dataHora DATETIME,
    umidade DECIMAL(4 , 2 ),
    temperatura_C DECIMAL(4 , 2 ),
    fkBarrilVinho INT,
    PRIMARY KEY (idmetrica , fkBarrilVinho),
    FOREIGN KEY (fkBarrilVinho)
        REFERENCES barrilVinho (idBarrilVinho)
);


-- Inserir Dados
insert into CadastroCliente values
( null, 'Vínicola Terranova', '39828926000377', '11 38113862', 'paralegal@tnova.com.br', '12345678'),
( null, 'Vínicola Rio Sol', '10882577000128', '31 38898600', 'tqa.contabil@hotmail.com', '12345678'),
( null, 'Vínicola Guaspari ', '11005453000127', '11 21647321', 'kazuo.koga@msppar.com.br', '12345678'),
( null, 'Vínicola Larentis ', '03794429000196', '54 34490000', 'jaqueline@carpper.com.br', '12345678');

insert into endereco values
(null,'Rua Pedro Ferreira', 155, 'Centro', 'Andar 13 Sala 1304','Itajai','88301030',1),
(null,'Rua do Ouro', 548, 'Serra', null,'Belo Horizonte','30220000',2),
(null,'Rua Pedro Ferrari', 300, 'Parque dos Lagos', 'Fazenda Santa Maria','Espirito Santo do Pinhal','13990000',3),
(null,'Via Trento', 280, 'Merlot', null,'Bento Gonçalves','95701720',4);


insert into barrilVinho values
(null,'Carvalho','100',1),
(null,'Vinhático','300',2),
(null,'Araribá ','200',3),
(null,'Peroba-do-Campo','400',4);

insert into vinho values
(null,'Tinto',1),
(null,'Rosé',4),
(null,'Tinto',3),
(null,'Rosé',2);

insert into metrica values
(null,'2022-09-06 16:00:00',50.00,12.00,1),
(null,'2022-08-07 21:48:00',42.00,16.00,2),
(null,'2022-07-08 15:09:45',60.00,20.00,3),
(null,'2022-06-09 09:22:42',55.00,15.00,4);

-- Selecionar tabelas 
select*from CadastroCliente;
select*from endereco;
select*from barrilVinho;
select*from vinho;
select*from metrica;


-- -- Exibir os dados da tabela metrica somente quando a umidade for menor que 50%.
select*from metrica where umidade < 50;

-- -- Exibir os dados da tabela barrilVinho somente quando o tipo da madeira for carvalho.
select*from barrilVinho where tipoMadeira = 'Carvalho';

-- Exibir apenas o logradouro e o bairro da tabela endereço, de um determinado cep que termine com a numeração 30.
select logradouro, bairro from endereco where cep like '%30';

-- Exibir os dados da tabela vinho, somente quando o tipo for Rosé.
select*from vinho where tipo = 'Rosé';

-- Exibir os dados da tabela metrica somente quando a temperaturas for maior que 13C°.
select*from metrica where temperatura_C > 13;

-- selecionar o nome, cnpj e email da tabela CadastroCliente, cujo nome contenha a letra 'P'.
select nome, cnpj, email from CadastroCliente  where nome like '%p%';

-- Exibir os dados dos cadastros ordenados por nome em ordem descrecente, cujo email contenha '.com.br'.
select * from CadastroCliente where email like '%.com.br%' order by nome desc;

-- Exibir os dados dos barris de vinhos e dos cadastros correspondentes. 
select*from barrilVinho as v join CadastroCliente as cc on fkCadastroCliente = idCadastroCliente;

-- Exibir os dados dos endereços correspondetes ao seu cadastro.
select*from Endereco as e join CadastroCliente as cc on fkCadastroCliente = idCadastroCliente;

-- Exibir os dados dos barris de vinhos, cadastros e dos endereços correspondentes.
select*from barrilVinho as v join CadastroCliente as cc on v.fkCadastroCliente = idCadastroCliente join Endereco as e on e.fkCadastroCliente = idCadastroCliente;

-- Exibir os dados dos clientes junto com os barris e vinhos.
select*from CadastroCliente as cc join barrilVinho as bv on bv.fkCadastroCliente = cc.idCadastroCliente join vinho as v on v.fkBarrilVinho = bv.idBarrilVinho;

-- Exibir os dados dos cadastros,endereços, barris, vinhos e metrica correspondentes.
select*from CadastroCliente as cc join Endereco as e on e.fkCadastroCliente = idCadastroCliente join barrilVinho as bv on bv.fkCadastroCliente = cc.idCadastroCliente join vinho as v on v.fkBarrilVinho = bv.idBarrilVinho join metrica as m on v.fkBarrilVinho = m.idMetrica;

