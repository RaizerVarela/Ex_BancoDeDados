CREATE DATABASE consultas
GO 
USE consultas

CREATE TABLE cliente(
cpf CHAR(11) NOT NULL,
nome VARCHAR(100) NOT NULL,
telefone CHAR(10) NOT NULL,
PRIMARY KEY (cpf)
)
GO
CREATE TABLE fornecedor(
id INT NOT NULL IDENTITY(1,1),
nome VARCHAR(100) NOT NULL,
logradouro VARCHAR(200) NOT NULL,
numero VARCHAR(6) NOT NULL,
complemento VARCHAR(30) NOT NULL,
cidade VARCHAR(100) NOT NULL,
PRIMARY KEY (id)
)
GO
CREATE TABLE produto(
codigo INT NOT NULL IDENTITY(1, 1),
descricao VARCHAR(100) NOT NULL,
fornecedor INT NOT NULL,
preco DECIMAL(6,2),
PRIMARY KEY (codigo),
FOREIGN KEY (fornecedor) REFERENCES fornecedor(id)
)
GO
CREATE TABLE venda(
codigo INT NOT NULL IDENTITY(1,1),
produto INT NOT NULL,
cliente CHAR(11) NOT NULL,
quantidade INT NOT NULL,
valor_total DECIMAL(6,2),
dia DATE NOT NULL,
PRIMARY KEY (codigo, produto, cliente, dia),
FOREIGN KEY (produto) REFERENCES produto (codigo),
FOREIGN KEY (cliente) REFERENCES cliente (cpf)
)
GO
INSERT INTO cliente VALUES
(25186533710, 'Maria Antonia', 87652314),
(34578909290, 'Julio Cesar', 82736541),
(79182639800, 'Paulo Cesar', 90765273),
(87627315416, 'Luiz Carlos', 61289012),
(36587498700, 'Paula Carla', 23547888)
GO
INSERT INTO fornecedor (nome, logradouro, numero, complemento, cidade)VALUES
('LG', 'Rod. Bandeirantes', 70000, 'Km 70', 'Itapeva'),
('Asus',	'Av. Nações Unidas', 10206,	'Sala 225', 'São Paulo'),
('AMD', 'Av. Nações Unidas',	10206,	'Sala 1095', 'São Paulo'),
('Leadership', 'Av. Nações Unidas', 10206, 'Sala 87', 'São Paulo'),
('Inno',	'Av. Nações Unidas', 10206,	'Sala 34', 'São Paulo'),
('Kingston',	'Av. Nações Unidas', 10206, 'Sala 18', 'São Paulo')
GO
INSERT INTO produto (descricao, fornecedor, preco) VALUES
('Monitor 19 pol.',	1,	449.99),
('Zenfone',	2,	1599.99),
('Gravador de DVD - Sata',	1, 99.99),
('Leitor de CD', 1, 49.99),
('Processador - Ryzen 5', 3, 599.99),
('Mouse', 4, 19.99),
('Teclado', 4, 25.99),
('Placa de Video - RTX 2060', 2, 2399.99),
('Pente de Memória 4GB DDR 4 2400 MHz',	5, 259.99)
GO
INSERT INTO venda (produto, cliente, quantidade, valor_total, dia) VALUES
(1,	25186533710, 1,	449.99, '2009-09-04'),
(1,	25186533710, 1,	449.99, '2009-09-03'),
(4,	25186533710, 1,	49.99, '2009-09-03'),
(5,	25186533710, 1,	349.99, '2009-09-03'),
(6,	79182639800, 4,	79.96, '2009-09-06'),
(3,	87627315416, 1,	99.99, '2009-09-06'),
(7,	87627315416, 1,	25.99, '2009-09-06'),
(8,	87627315416, 1,	599.99, '2009-09-06'),
(2,	34578909290, 2,	1399.98, '2009-09-08')

-- 1
SELECT COUNT(p.codigo) AS produtos_n_vendidos 
FROM produto p, venda v 
WHERE v.produto = p.codigo
	AND v.produto IS NULL

-- 2
SELECT p.descricao AS nome_produto, f.nome AS nome_fornecedor, COUNT(p.codigo) AS qtd_produto_vendida
FROM produto p, fornecedor f, venda v
WHERE p.fornecedor = f.id AND p.codigo = v.produto
GROUP BY p.descricao, f.nome, v.quantidade

--3
SELECT c.nome AS nome_cliente, COUNT(c.cpf) AS quantidade_produtos
FROM cliente c, venda v
WHERE v.cliente = c.cpf
GROUP BY c.nome, c.cpf
ORDER BY quantidade_produtos DESC

--4
SELECT p.descricao AS nome_produto, COUNT(p.codigo) AS quantidade_comprada
FROM produto p, venda v
WHERE p.codigo = v.produto AND p.preco IN (SELECT MIN(p.preco) FROM produto p)
GROUP BY p.descricao

--5
SELECT f.nome AS nome_fornecedor, COUNT(p.codigo) AS quantidade_produtos
FROM fornecedor f, produto p
WHERE f.id = p.fornecedor
GROUP BY f.nome

--6
SELECT v.codigo AS codigo_compra, c.nome, c.telefone, DATEDIFF(DAY, v.dia, '2009-10-20') AS dias_passados
FROM venda v, cliente c
WHERE v.cliente = c.cpf
GROUP BY v.codigo, c.nome, c.telefone, v.dia

--7
SELECT SUBSTRING(c.cpf, 1, 3) + '.' + SUBSTRING(c.cpf, 4, 3) + '.' +
	SUBSTRING(c.cpf, 7, 3) + '-' + SUBSTRING(c.cpf, 10, 2) AS cpf, c.nome,
	COUNT(v.cliente) AS quantidade_compra
FROM cliente c, venda v 
WHERE c.cpf = v.cliente
GROUP BY c.cpf, c.nome
HAVING COUNT(v.cliente) > 2

--8
SELECT SUBSTRING(c.cpf, 1, 3) + '.' + SUBSTRING(c.cpf, 4, 3) + '.' +
	SUBSTRING(c.cpf, 7, 3) + '-' + SUBSTRING(c.cpf, 10, 2) AS cpf, c.nome,
	SUM(v.valor_total) AS total
FROM cliente c, venda v
WHERE v.cliente = c.cpf
GROUP BY c.cpf, c.nome

--9
SELECT v.codigo AS codigo_compra, CONVERT(CHAR(10), v.dia, 103) 
    AS data_com, CASE
    WHEN (DAY(v.dia) % 7 = 1) THEN
        'Domingo'
    WHEN (DAY(v.dia) % 7 = 2) THEN
        'Segunda-Feira'
    WHEN (DAY(v.dia) % 7 = 3) THEN
        'Terça-Feira'
    WHEN (DAY(v.dia) % 7 = 4) THEN
        'Quarta-Feira'
    WHEN (DAY(v.dia) % 7 = 5) THEN
        'Quinta-Feira'
    WHEN (DAY(v.dia) % 7 = 6) THEN
        'Sexta-Feira'
    WHEN (DAY(v.dia) % 7 = 0) THEN
        'Sábado'
    END AS dia_semana FROM venda v
GROUP BY v.codigo, v.dia

--Quantos produtos não foram vendidos ?	
--Nome do produto, Nome do fornecedor, count() do produto nas vendas	
--Nome do cliente e Quantos produtos cada um comprou ordenado pela quantidade	
--Nome do produto e Quantidade de vendas do produto com menor valor do catálogo de produtos	
--Nome do Fornecedor e Quantos produtos cada um fornece	
--Considerando que hoje é 20/10/2009, consultar o código da compra, nome do cliente, telefone do cliente e quantos dias da data da compra	
--CPF do cliente, mascarado (XXX.XXX.XXX-XX), Nome do cliente e quantidade que comprou mais de 2 produtos	
--CPF do cliente, mascarado (XXX.XXX.XXX-XX), Nome do Cliente e Soma do valor_total gasto	
--Código da compra, data da compra em formato (DD/MM/AAAA) e uma coluna, chamada dia_semana, que escreva o dia da semana por extenso	
--Exemplo: Caso dia da semana 1, escrever domingo. Caso 2, escrever segunda-feira, assim por diante, até caso dia 7, escrever sábado

