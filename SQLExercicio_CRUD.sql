-- Criação da database
CREATE DATABASE livraria

USE livraria

CREATE TABLE livro (
CodigoLivro integer not null,
Nome varchar(100) not null,
Lingua varchar(50) not null,
Ano integer not null
PRIMARY KEY (CodigoLivro)
)
GO
CREATE TABLE edicoes (
ISBN integer not null,
Preco decimal(7,2) not null,
Ano integer not null,
NumPaginas integer not null,
QtdEstoque integer not null
PRIMARY KEY (ISBN)
)
GO
CREATE TABLE autor (
CodigoAutor integer not null,
Nome varchar(100) not null,
Nascimento date not null,
Pais varchar(50) not null,
Biografia varchar(max) not null
PRIMARY KEY (CodigoAutor)
)
GO
CREATE TABLE editora (
CodigoEditora integer not null,
Nome varchar(50) not null,
Logradouro varchar(255) not null,
Numero integer not null,
CEP char(8) not null,
Telefone char(8) not null
PRIMARY KEY (CodigoEditora)
)
GO
CREATE TABLE livro_autor (
LivroCodigoLivro integer not null,
AutorCodigoAutor integer not null
FOREIGN KEY (LivroCodigoLivro) references livro (CodigoLivro),
FOREIGN KEY (AutorCodigoAutor) references autor (CodigoAutor),
)
GO
CREATE TABLE livro_edicao_editora (
EdicoesISBN integer not null,
EditoraCodigoEditora integer not null,
LivroCodigoLivro integer not null
FOREIGN KEY (EdicoesISBN) references edicoes (ISBN),
FOREIGN KEY (EditoraCodigoEditora) references editora (CodigoEditora),
FOREIGN KEY (LivroCodigoLivro) references livro (CodigoLivro),
)

EXEC sp_rename 'dbo.edicoes.Ano','AnoEdicao','column'

ALTER TABLE editora
ALTER COLUMN Nome varchar(30)

INSERT INTO livro VALUES 
(1001, 'CCNA 4.1', 'PT-BR', 2015),
(1002, 'HTML5', 'PT-BR', 2017),
(1003, 'Redes de Computadores', 'EN', 2010),
(1004, 'Android em Ação', 'PT-BR', 2018)

-- Existiu a necessidade de fazer um drop na coluna, para que cria-la novamente com o valor int
ALTER TABLE autor
DROP COLUMN Nascimento

ALTER TABLE autor
ADD Ano int not null

INSERT INTO autor VALUES 
(10001, 'Inácio da Silva', 'Brasil', 'Programadr WEB desde 1995', 1975),
(10002, 'Andrew Tannenbaum', 'EUA', 'Chefe do Departamento de Sistemas de Computação da Universidade de Vrij', 1944),
(10003, 'Luis Rocha', 'Brasil', 'Programador Mobile desde 2000', 1967),
(10004, 'David Halliday', 'Brasil', 'Físico PH.D desde 1941', 1916)

INSERT INTO livro_autor VALUES
(1001, 10001),
(1002, 10003),
(1003, 10002),
(1004, 10003)

INSERT INTO edicoes VALUES
(0130661023, 189.99, 2018, 653, 10)

UPDATE autor
SET Biografia = 'Chefe do Departamento de Sistemas de Computação da Universidade de Vrije'
WHERE CodigoAutor = 10002

UPDATE edicoes
SET QtdEstoque = QtdEstoque - 2
WHERE ISBN = 0130661023

DELETE autor
WHERE CodigoAutor = 10004
