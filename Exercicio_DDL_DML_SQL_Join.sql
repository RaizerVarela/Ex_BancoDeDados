USE usersProjectss

INSERT INTO users(nome, nomeUsuario, senha, email)VALUES
('Joao', 'Ti_joao', '123mudar', 'joao@empresa.com')

INSERT INTO projects(nome, descricao, dataProj) VALUES
('Atualização de Sistemas', 'Modificação de Sistemas Operacionais nos PCs', '12/09/2014')

SELECT * FROM users
SELECT * FROM projects

--1) Id, Name e Email de Users, Id, Name, Description e Data de Projects, dos usuários que participaram do projeto Name Re-folha
SELECT users.id, users.nome, users.email, projects.id, projects.nome, projects.descricao, projects.dataProj FROM users 
INNER JOIN users_has_projects 
ON users_has_projects.id_usuario = users.id
INNER JOIN projects 
ON users_has_projects.id_projetos = projects.id
WHERE projects.nome = 'Re-folha'
ORDER BY users.nome ASC

--2) Name dos Projects que não tem Users
SELECT p.nome AS 'Nome Projeto' FROM projects p
LEFT OUTER JOIN users_has_projects uhp
ON uhp.id_projetos = p.id
WHERE uhp.id_usuario IS NULL;

--3) Name dos Users que não tem Projects
SELECT u.nome AS 'Nome Funcionario' FROM users_has_projects uhp
RIGHT OUTER JOIN users u
ON u.id = uhp.id_usuario
WHERE uhp.id_projetos IS NULL;