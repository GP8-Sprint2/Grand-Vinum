CREATE DATABASE sprint1;
USE sprint1;

CREATE TABLE CadastroCliente (
	idCliente INT PRIMARY KEY AUTO_INCREMENT, -- Identificação do cliente
    NomeEmpresa VARCHAR (60) NOT NULL, --  Nome da empresa
	CNPJ CHAR (18) NOT NULL, -- Deve conter (. / -) xx.xxx.xxx/xxxx-xx
	Celular_telefone VARCHAR (25), -- Deve conter (ddd) xxxxx-xxxx ou (ddd) xxxx-xxxx
    Email_Login VARCHAR (80) NOT NULL,
    Senha VARCHAR (30) NOT NULL,
	Logradouro VARCHAR (60), -- Rua
    Numero INT,
	Bairro VARCHAR (40), 
    Complemento VARCHAR (40),
    Cidade VARCHAR (40), 
	CEP CHAR (09) NOT NULL, 
    tipoVinho VARCHAR (10) NOT NULL, CONSTRAINT chkVinho CHECK(tipoVinho IN('Tinto','Rosé','Branco')),-- Cliente deve colocar o tipo de vinho que vai armazenar
    Quantidade INT NOT NULL -- Quantidade do produto em litros
); 

INSERT INTO CadastroCliente (NomeEmpresa, CNPJ, Celular_telefone, Email_Login, Senha, Logradouro, Numero, Bairro, Complemento, Cidade, CEP, tipoVinho, Quantidade) VALUES
('Vivivinhos', '20.645.889/0001-30', '(011) 2525-3030 ','vivivinhos@createemail.com','altertable123','Rua Dados', 595, 'Database', 'Sala 11', 'São Paulo','09420-905','Tinto', 280),
('Adegas Yoshi', '33.429.728/0002-40', '(011) 98765-3131','adegayoshi@uia.tome','input#in_senha','Rua Algoritmos', 999, 'Tome', 'sala 05', 'São Paulo','02014-222','Rosé', 200),
('Chola`s Cyber Winery', '11.000.101/1001-11','(011) 1111-1001','Winery@binary.tsmc','SenhaEmBinario','Rua Turing', 0101, 'Neuman', null , 'São Paulo','01111-000','Branco', 130),
('FazSentidoVinhos', '21.605.139/0001-50', '(011) 98231-3999','danvinhos@makeanysense.com','papai123','Rua Rio de Janeiro', 123, 'FazAlgumsentido', 'Sala 08', 'Rio de Janeiro','03920-005','Rosé', 334),
('VinhosDaCaramico', '25.501.328/0001-20', '(011) 95211-0093', 'vinhoscaramico@stylee.com', 'love', 'Avenida Grungee','321','bilingue', null , 'São Paulo', '08411-340', 'Tinto', '320');

SELECT*FROM CadastroCliente;
SELECT*FROM CadastroCliente WHERE idCliente = 1;
SELECT*FROM CadastroCliente WHERE tipoVinho =  'Tinto';

SELECT idCliente, NomeEmpresa, CNPJ, Celular_telefone,Email_Login, CEP, tipoVinho, Quantidade FROM CadastroCliente WHERE idCliente = 1;
SELECT idCliente, NomeEmpresa, CNPJ, Celular_telefone,Email_Login, tipoVinho, Quantidade FROM CadastroCliente  WHERE nomeEmpresa LIKE 'V%';
SELECT idCliente, NomeEmpresa, CNPJ, Celular_telefone,Email_Login, CEP, tipoVinho, Quantidade FROM CadastroCliente  WHERE nomeEmpresa LIKE '%o_';
SELECT NomeEmpresa, Email_Login, Senha FROM CadastroCliente WHERE idCliente= 1;

SELECT idCliente, NomeEmpresa, Celular_telefone, Logradouro, Numero, Bairro, Complemento, Cidade, CEP FROM CadastroCliente WHERE idCliente =1;
SELECT idCliente, NomeEmpresa, Celular_telefone,Logradouro, Numero, Bairro, Complemento, Cidade, CEP FROM CadastroCliente WHERE NomeEmpresa LIKE '_i%';

SELECT*FROM CadastroCliente WHERE idCliente = 2;
SELECT*FROM CadastroCliente WHERE tipoVinho =  'Rosé';

SELECT idCliente, NomeEmpresa, CNPJ, Celular_telefone,Email_Login, CEP, tipoVinho, Quantidade FROM CadastroCliente WHERE idCliente = 2;
SELECT idCliente, NomeEmpresa, CNPJ, Celular_telefone,Email_Login, tipoVinho, Quantidade FROM CadastroCliente  WHERE nomeEmpresa LIKE 'A%';
SELECT idCliente, NomeEmpresa, CNPJ, Celular_telefone,Email_Login, CEP, tipoVinho, Quantidade FROM CadastroCliente  WHERE nomeEmpresa LIKE '%h_';
SELECT NomeEmpresa, Email_Login, Senha FROM CadastroCliente WHERE idCliente= 2;

SELECT idCliente, NomeEmpresa, Celular_telefone, Logradouro, Numero, Bairro, Complemento, Cidade, CEP FROM CadastroCliente WHERE idCliente =2;
SELECT idCliente, NomeEmpresa, Celular_telefone, Logradouro, Numero, Bairro, Complemento, Cidade, CEP FROM CadastroCliente WHERE NomeEmpresa LIKE '% y%';

SELECT*FROM CadastroCliente WHERE idCliente = 3;
SELECT*FROM CadastroCliente WHERE tipoVinho =  'Branco';

SELECT idCliente, NomeEmpresa, CNPJ, Celular_telefone, CEP, tipoVinho, Quantidade FROM CadastroCliente WHERE idCliente = 3;
SELECT idCliente, NomeEmpresa, CNPJ, Celular_telefone, tipoVinho, Quantidade FROM CadastroCliente  WHERE nomeEmpresa LIKE 'C%';
SELECT idCliente, NomeEmpresa, CNPJ, Celular_telefone, CEP, tipoVinho, Quantidade FROM CadastroCliente  WHERE nomeEmpresa LIKE '%r_';
SELECT NomeEmpresa, Email_Login, Senha FROM CadastroCliente WHERE idCliente= 3;

SELECT idCliente, NomeEmpresa, Celular_telefone, Logradouro, Numero, Bairro, Complemento, Cidade, CEP FROM CadastroCliente WHERE idCliente =3;
SELECT idCliente, NomeEmpresa, Celular_telefone, Logradouro, Numero, Bairro, Complemento, Cidade, CEP FROM CadastroCliente WHERE NomeEmpresa LIKE '%b';

DROP TABLE CadastroCliente;