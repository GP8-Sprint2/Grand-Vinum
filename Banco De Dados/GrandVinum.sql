-- Criar Database
create database GrandVinum;

-- Selecionar Database
use GrandVinum;

-- Criar tabelas

CREATE TABLE CadastroCliente (
idCadastroCliente int primary key auto_increment,
nome varchar(45),
cnpj char(14),
telCel varchar(12),
email varchar(45), constraint chkEmail check (email LIKE "%@%"),
senha varchar(45) 
);

CREATE TABLE metricas(
idMetricas INT PRIMARY KEY AUTO_INCREMENT,
temperatura_Cº DECIMAL(4,2),
umidade CHAR(7),
dataHora DATETIME,
fkCadastroCliente int,
foreign key (fkCadastroCliente) references cadastroCliente (idCadastroCliente)
);

CREATE TABLE Endereco (
idEndereco int auto_increment,
logradouro varchar(45),
numero int,
bairro varchar(45),
complemento varchar(45),
cidade varchar(50),
cep char(8),
fkCadastroCliente int,
foreign key (fkCadastroCliente) references CadastroCliente (idCadastroCliente),
primary key (idEndereco,fkCadastroCliente)
);

CREATE TABLE vinho (
idVinho int auto_increment,
tipo varchar(45),
quantidade varchar(45),
fkCadastroCliente int,
foreign key (fkCadastroCliente) references CadastroCliente (idCadastroCliente),
primary key (idVinho,fkCadastroCliente)
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

insert into metricas values
(null,'12','14%','2022-09-06 16:00:00',1),
(null,'13','13%','2022-08-07 21:48:00',4),
(null,'14','12%','2022-07-08 15:09:45',2),
(null,'15','11%','2022-06-09 09:22:42',3);

insert into vinho values
(null,'Tinto','70',1),
(null,'Rosé','50',3),
(null,'Tinto','30',2),
(null,'Rosé','20',4);


-- Selecionar tabelas 
select*from CadastroCliente;
select*from endereco;
select*from metricas;
select*from vinho;


-- -- Exibir os dados da tabela metricas somente quando a umidade for menor que 12%.
select*from metricas where umidade < 12;

-- Exibir apenas o logradouro e o bairro da tabela endereço, de um determinado cep que termine com a numeração 30.
select logradouro, bairro from endereco where cep like '%30';

-- Exibir os dados da tabela vinho, somente quando o tipo for Rosé.
select*from vinho where tipo = 'Rosé';

-- Exibir os dados da tabela metricas somente quando a temperaturas for maior que 13C°.
select*from metricas where temperatura_Cº > 13;

-- selecionar o nome, cnpj e email da tabela CadastroCliente, cujo nome contenha a letra 'P'.
select nome, cnpj, email from CadastroCliente  where nome like '%p%';

-- Exibir os dados dos cadastros ordenados por nome em ordem descrecente, cujo email contenha '.com.br'.
select * from CadastroCliente where email like '%.com.br%' order by nome desc;

-- Exibir os dados dos vinhos e dos cadastros correspondentes. 
select*from vinho as v join CadastroCliente as cc on fkCadastroCliente = idCadastroCliente;

-- Exibir os dados dos endereços correspondetes ao seu cadastro.
select*from Endereco as e join CadastroCliente as cc on fkCadastroCliente = idCadastroCliente;

-- Exibir os dados dos vinhos, cadastros e dos endereços correspondentes.
select*from vinho as v join CadastroCliente as cc on v.fkCadastroCliente = idCadastroCliente join Endereco as e on e.fkCadastroCliente = idCadastroCliente;

-- Exibir os dados dos clientes junto com os tipos de vinho.
select cc.nome as NomeCliente, v.tipo TipoDoVinho from CadastroCliente as cc join vinho as v on fkCadastroCliente = idCadastroCliente;

-- Exibir os dados dos vinhos, cadastros, endereços e metricas correspondentes.
select*from vinho as v join CadastroCliente as cc on v.fkCadastroCliente = idCadastroCliente join Endereco as e on e.fkCadastroCliente = idCadastroCliente join metricas as m on m.fkCadastroCliente=idMetricas;

