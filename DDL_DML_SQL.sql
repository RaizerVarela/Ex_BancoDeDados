CREATE DATABASE usersProjects
GO
USE usersProjects
GO

CREATE TABLE users (
id INT NOT NULL IDENTITY (1,1),
nome VARCHAR(45) NOT NULL,
nomeUsuario VARCHAR(45) NOT NULL,
senha VARCHAR(45) NOT NULL DEFAULT ('123mudar'),
email VARCHAR(45) NOT NULL
PRIMARY KEY (id)
)
--Adição de Unique, para definição do nome manualmente
ALTER TABLE users 
ADD CONSTRAINT unq_nome_usuario UNIQUE (nomeUsuario);
GO
CREATE TABLE projects(
id INT NOT NULL IDENTITY (10001,1),
nome VARCHAR(45) NOT NULL,
descricao  VARCHAR(45) NULL,
dataProj DATE NOT NULL CHECK('01/09/2014' < GETDATE())
PRIMARY KEY (id)
)
GO
CREATE TABLE users_has_projects(
id_usuario INT NOT NULL,
id_projetos INT NOT NULL
FOREIGN KEY (id_usuario) REFERENCES users (id),
FOREIGN KEY (id_projetos) REFERENCES projects (id),
)

--Alteração do tamanho de alguns colunas
ALTER TABLE users
DROP CONSTRAINT unq_nome_usuario

ALTER TABLE users
ALTER COLUMN nomeUsuario VARCHAR(10)

ALTER TABLE users 
ADD CONSTRAINT unq_nome_usuario UNIQUE (nomeUsuario);

ALTER TABLE users
ALTER COLUMN senha VARCHAR(8)

--Inserção de dados
INSERT INTO users(nome, nomeUsuario, senha, email)VALUES
('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

INSERT INTO projects(nome, descricao, dataProj) VALUES
('Re‐folha', 'Refatoração das Folhas', '05/09/2014'),
('Manutenção PC´s', 'Manutenção PC´s', '06/09/2014'),
('10003 Auditoria', NULL, '07/09/2014')

INSERT INTO users_has_projects VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)

-- Alterar data do projeto 10002, que atrasou
UPDATE projects
SET dataProj = '12/09/2014'
WHERE id = 10002

--Alteração do nome de usuario (com o nome como condição)
UPDATE users
SET nomeUsuario = 'Rh_cido'
WHERE nome = 'Aparecido'

--Alteração de senha (condições nome de usuario e senha atual)
UPDATE users
SET senha = '888@*'
WHERE nomeUsuario = 'Rh_maria' AND senha = '123mudar'

--Deletando usuario de id 2 do projeto 10002
DELETE users_has_projects
WHERE id_usuario = 2

--Adição da coluna budget
ALTER TABLE projects
ADD budget DECIMAL(7,2) NULL

--Adição de valores a coluna budget
UPDATE projects
SET budget = 5750
WHERE id = 10001

UPDATE projects
SET budget = 7850
WHERE id = 10002

UPDATE projects
SET budget = 9530
WHERE id = 10003

--Consulta nome de usuario e senha
SELECT nomeUsuario, senha
FROM users
WHERE nome = 'Ana'

--Verificar quem ainda tem a senha 123mudar
SELECT nome, id, email
FROM users
WHERE senha = '123mudar'

--Consulta de bugets com valor entre 2000 e 8000
SELECT id, nome 
FROM projects
WHERE budget > 2000 AND budget < 8000


SELECT * FROM projects
SELECT * FROM users
SELECT * FROM users_has_projects