CREATE DATABASE livraria
GO
USE livraria

CREATE TABLE autores (
	cod	INT	NOT NULL IDENTITY(10001, 1),
	nome VARCHAR(40) NOT NULL,
	pais VARCHAR(20),
	biografia VARCHAR(50)
	PRIMARY KEY (cod)
)

CREATE TABLE clientes (
	cod	INT	NOT NULL IDENTITY(1001, 1),
	nome VARCHAR(40) NOT NULL,
	logradouro	VARCHAR(40),
	numero	INT,
	telefone CHAR(9)
	PRIMARY KEY (cod)
)

CREATE TABLE corredores (
	cod	INT NOT NULL IDENTITY(3251, 1),
	tipo VARCHAR(20) NOT NULL
	PRIMARY KEY (cod)
)

GO

CREATE TABLE livros (
	cod	INT	NOT NULL IDENTITY(1, 1),
	nome VARCHAR(50) NOT NULL,
	cod_autor INT NOT NULL,
	pag	INT	NOT NULL,
	idioma	VARCHAR(20)	NOT NULL,
	cod_corredor INT NOT NULL
	PRIMARY KEY (cod)
	FOREIGN KEY (cod_autor) REFERENCES Autores(cod),
	FOREIGN KEY (cod_corredor) REFERENCES Corredores(cod)
)

GO

CREATE TABLE emprestimo (
	cod_cli	INT NOT NULL,
	cod_livro INT				NOT NULL,
	dia DATE NOT NULL
	PRIMARY KEY (cod_cli, cod_livro)
	FOREIGN KEY (cod_cli) REFERENCES Clientes(cod),
	FOREIGN KEY (cod_livro) REFERENCES Livros(cod)
)

GO

INSERT INTO autores VALUES 
	('Ramez E. Elmasri', 'EUA', 'Professor da Universidade do Texas'),
	('Andrew Tannenbaum', 'Holanda', 'Desenvolvedor do Minix'),
	('Diva Mar�lia Flemming', 'Brasil', 'Professora Adjunta da UFSC'),
	('David Halliday', 'EUA', 'Ph.D. da University of Pittsburgh'),
	('Marco Antonio Furlan de Souza', 'Brasil', 'Prof. do IMT'),
	('Alfredo Steinbruch', 'Brasil', 'Professor de Matem�tica da UFRS e da PUCRS')

INSERT INTO clientes VALUES
	('Luis Augusto', 'R. 25 de Mar�o', 250, '996529632'),
	('Maria Luisa', 'R. XV de Novembro', 890, '998526541'),
	('Claudio Batista', 'R. Anhaia', 112, '996547896'),
	('Wilson Mendes', 'R. do Hip�dromo', 1250, '991254789'),
	('Ana Maria', 'R. Augusta', 896, '999365589'),
	('Cinthia Souza', 'R. Volunt�rios da P�tria', 1023, '984256398'),
	('Luciano Britto', NULL, NULL, '995678556'),
	('Ant�nio do Valle', 'R. Sete de Setembro', 1894, NULL)

INSERT INTO corredores VALUES
	('Inform�tica'),
	('Matem�tica'),
	('F�sica'),
	('Qu�mica')

GO

INSERT INTO livros (cod_autor, cod_corredor, nome, pag, idioma) VALUES
	(10001, 3251, 'Sistemas de Banco de dados', 720, 'Portugu�s'), 
	(10002, 3251, 'Sistemas Operacionais Modernos', 580, 'Portugu�s'), 
	(10003, 3252, 'Calculo A', 290, 'Portugu�s'),
	(10004, 3253, 'Fundamentos de F�sica I', 185, 'Portugu�s'), 
	(10005, 3251, 'Algoritmos e L�gica de Programa��o', 90, 'Portugu�s'), 
	(10006, 3252, 'Geometria Anal�tica', 75, 'Portugu�s'),
	(10004, 3253, 'Fundamentos de F�sica II', 150, 'Portugu�s'), 
	(10002, 3251, 'Redes de Computadores', 493, 'Ingl�s'),
	(10002, 3251, 'Organiza��o Estruturada de Computadores', 576, 'Portugu�s')

GO

INSERT INTO emprestimo (cod_cli, dia, cod_livro) VALUES 
	(1001, '2012-05-10 00:00:00.000', 1),
	(1001, '2012-05-10 00:00:00.000', 2),
	(1001, '2012-05-10 00:00:00.000', 8),
	(1002, '2012-05-11 00:00:00.000', 4),
	(1002, '2012-05-11 00:00:00.000', 7),
	(1003, '2012-05-12 00:00:00.000', 3),
	(1004, '2012-05-14 00:00:00.000', 5),
	(1001, '2012-05-15 00:00:00.000', 9)

-- Fazer uma consulta que retorne o nome do cliente e a data do empr�stimo formatada padr�o BR (dd/mm/yyyy)
-- Fazer uma consulta que retorne Nome do autor e Quantos livros foram escritos por Cada autor, ordenado pelo n�mero de livros. Se o nome do autor tiver mais de 25 caracteres, mostrar s� os 13 primeiros.
-- Fazer uma consulta que retorne o nome do autor e o pa�s de origem do livro com maior n�mero de p�ginas cadastrados no sistema
-- Fazer uma consulta que retorne nome e endere�o concatenado dos clientes que tem livros emprestados

/*
Nome dos Clientes, sem repetir e, concatenados como
ender�o_telefone, o logradouro, o numero e o telefone) dos
clientes que N�o pegaram livros. Se o logradouro e o 
n�mero forem nulos e o telefone n�o for nulo, mostrar s� o telefone. Se o telefone for nulo e o logradouro e o n�mero n�o forem nulos, mostrar s� logradouro e n�mero. Se os tr�s existirem, mostrar os tr�s.
O telefone deve estar mascarado XXXXX-XXXX
*/

-- Fazer uma consulta que retorne Quantos livros n�o foram emprestados
-- Fazer uma consulta que retorne Nome do Autor, Tipo do corredor e quantos livros, ordenados por quantidade de livro
-- Considere que hoje � dia 18/05/2012, fa�a uma consulta que apresente o nome do cliente, o nome do livro, o total de dias que cada um est� com o livro e, uma coluna que apresente, caso o n�mero de dias seja superior a 4, apresente 'Atrasado', caso contr�rio, apresente 'No Prazo'
-- Fazer uma consulta que retorne cod de corredores, tipo de corredores e quantos livros tem em cada corredor
-- Fazer uma consulta que retorne o Nome dos autores cuja quantidade de livros cadastrado � maior ou igual a 2.
-- Considere que hoje � dia 18/05/2012, fa�a uma consulta que apresente o nome do cliente, o nome do livro dos empr�stimos que tem 7 dias ou mais


-- Fazer uma consulta que retorne o nome do cliente e a data do empr�stimo formatada padr�o BR (dd/mm/yyyy)
SELECT c.nome,
		CONVERT(CHAR(10), p.dia,103) AS dia
FROM clientes c, emprestimo p
WHERE c.cod = p.cod_cli
GROUP BY c.nome, p.dia


-- Fazer uma consulta que retorne Nome do autor e Quantos livros foram escritos por Cada autor, ordenado pelo n�mero de livros. 
-- Se o nome do autor tiver mais de 25 caracteres, mostrar s� os 13 primeiros.*/
SELECT CASE WHEN (LEN(a.nome) > 25) THEN
			SUBSTRING(a.nome, 1, 13)
		ELSE 
			a.nome
		END AS nome,
		COUNT(l.cod_autor) AS quantidade
FROM Autores a INNER JOIN Livros l
ON a.cod = l.cod_autor
GROUP BY a.nome
ORDER BY quantidade


-- Fazer uma consulta que retorne o nome do autor e o pa�s de origem do livro com maior n�mero de p�ginas cadastrados no sistema
SELECT a.nome, a.pais
FROM autores a, livros l
WHERE a.cod = l.cod_autor 
	AND l.pag IN 
	(SELECT MAX(pag)
	FROM Livros)


-- Fazer uma consulta que retorne nome e endere�o concatenado dos clientes que tem livros emprestados
SELECT DISTINCT c.nome,
		c.logradouro+', '+CAST(c.numero AS VARCHAR(5)) AS endere�o
FROM clientes c, emprestimo e
WHERE c.cod = e.cod_cli


/*
Nome dos Clientes, sem repetir e, concatenados como
ender�o_telefone, o logradouro, o numero e o telefone) dos
clientes que N�o pegaram livros. Se o logradouro e o 
n�mero forem nulos e o telefone n�o for nulo, mostrar s� o telefone. 
Se o telefone for nulo e o logradouro e o n�mero n�o forem nulos, mostrar s� logradouro e n�mero. 
Se os tr�s existirem, mostrar os tr�s.
O telefone deve estar mascarado XXXXX-XXXX
*/
SELECT DISTINCT c.nome,
		CASE WHEN ((c.logradouro IS NULL ) AND (c.numero IS NULL)) THEN
			SUBSTRING(c.telefone,1,5)+'-'+SUBSTRING(c.telefone,6,9)
		WHEN (c.telefone IS NULL) THEN
			c.logradouro+', '+CAST(c.numero AS VARCHAR(5))
		ELSE
			c.logradouro+', '+CAST(c.numero AS VARCHAR(5))+' - '+SUBSTRING(c.telefone,1,5)+'-'+SUBSTRING(c.telefone,6,9)
		END AS endere�o_telefone
FROM clientes c LEFT OUTER JOIN emprestimo e
ON c.cod = e.cod_cli
WHERE e.cod_cli IS NULL


-- Fazer uma consulta que retorne Quantos livros n�o foram emprestados
SELECT COUNT(l.cod) total_nao_emprestados
FROM livros l LEFT OUTER JOIN emprestimo e
ON e.cod_livro = l.cod
WHERE e.cod_livro IS NULL


-- Fazer uma consulta que retorne Nome do Autor, Tipo do corredor e quantos livros, ordenados por quantidade de livro
SELECT a.nome, c.tipo, COUNT(l.cod_corredor) quantidade
FROM autores a INNER JOIN livros l
ON a.cod = l.cod_autor
INNER JOIN corredores c
ON c.cod = l.cod_corredor
GROUP BY a.nome, c.tipo
ORDER BY quantidade


-- Considere que hoje � dia 18/05/2012, fa�a uma consulta que apresente o nome do cliente, o nome do livro, o total de dias que cada um est� com o livro e,
-- uma coluna que apresente, caso o n�mero de dias seja superior a 4, apresente 'Atrasado', caso contr�rio, apresente 'No Prazo'
SELECT c.nome AS cliente,
		l.nome AS livro,
		DATEDIFF(DAY, e.dia, '18/05/2012') AS total_dias,
		CASE WHEN (DATEDIFF(DAY, e.dia, '18/05/2012') > 4) THEN
			'Atrasado'
		ELSE
			'No prazo'
		END AS situa��o
FROM clientes c INNER JOIN emprestimo e
ON c.cod = e.cod_cli
INNER JOIN livros L
ON l.cod = e.cod_livro


-- Fazer uma consulta que retorne cod de corredores, tipo de corredores e quantos livros tem em cada corredor
SELECT c.cod, c.tipo, COUNT(l.cod_corredor) quantidade
FROM Corredores c LEFT OUTER JOIN Livros l
ON c.cod = l.cod_corredor
GROUP BY c.cod, c.tipo


-- Fazer uma consulta que retorne o Nome dos autores cuja quantidade de livros cadastrado � maior ou igual a 2.
SELECT a.nome
FROM autores a,livros l
WHERE a.cod = l.cod_autor
GROUP BY a.nome
HAVING COUNT(l.cod_autor) >= 2


-- Considere que hoje � dia 18/05/2012, fa�a uma consulta que apresente o nome do cliente, o nome do livro dos empr�stimos que tem 7 dias ou mais
SELECT		c.nome AS cliente,
			l.nome AS livro
FROM		clientes c, livros l, emprestimo e
WHERE		c.cod = e.cod_cli AND
			l.cod = e.cod_livro
GROUP BY	c.nome, l.nome, e.dia
HAVING		(DATEDIFF(DAY, e.dia, '18/05/2012') >=7)
