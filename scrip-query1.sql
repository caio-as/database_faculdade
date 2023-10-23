-- Criando banco de dados
CREATE DATABASE Faculdade;
USE faculdade;

-- Criando tabelas
CREATE TABLE Aluno (
    idAluno INT NOT NULL,
    matricula VARCHAR(10),
    nome VARCHAR(50),
    PRIMARY KEY (idAluno)
);

CREATE TABLE Curso (
    idCurso INT NOT NULL,
    nome VARCHAR(50),
    PRIMARY KEY (idCurso)
);

CREATE TABLE AlunoCurso (
    idAluno INT NOT NULL,
    idCurso INT NOT NULL,
    anoEntrada INT NOT NULL,
    FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno),
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Disciplina (
    idDisciplina INT NOT NULL,
    cargaHoraria INT NOT NULL,
    nome VARCHAR(50),
    PRIMARY KEY (idDisciplina)
);

CREATE TABLE Historico (
    idAluno INT NOT NULL,
    idDisciplina INT NOT NULL,
    nota FLOAT,
    dataHistorico DATE,
    FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno),
    FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina)
);

CREATE TABLE Grade (
    idGrade INT NOT NULL,
    idCurso INT NOT NULL,
    ano INT NOT NULL,
    cargaHorariaTotal INT NOT NULL,
    PRIMARY KEY (idGrade),
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
    );
    
    CREATE TABLE GradeDisciplina (
    idGrade INT NOT NULL,
    idDisciplina INT NOT NULL,
    FOREIGN KEY (idGrade) REFERENCES Grade(idGrade),
    FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina)
    );
    
    
-- listar o quantitativo de cursos existentes
SELECT COUNT(*) as Quantidade_de_Cursos
FROM Curso;

-- listar o nome das disciplinas existentes
SELECT nome
FROM Disciplina;

-- listar o nome de todos os cursos e o nome de seus alunos, mostrar em ordem decrescente pelo nome dos cursos
SELECT c.nome as Nome_do_Curso, a.nome as Nome_do_Aluno
FROM Curso c
JOIN AlunoCurso ac ON c.idCurso = ac.idCurso
JOIN Aluno a ON ac.idAluno = a.idAluno
ORDER BY c.nome DESC;

-- listar o nome das disciplinas e a média das notas das disciplinas
SELECT d.nome AS Nome_da_Disciplina, AVG(h.nota) AS Media_das_Notas
FROM Disciplina d
JOIN Historico h ON d.idDisciplina = h.idDisciplina
GROUP BY d.nome;

/* listar o nome de todos os cursos e a quantidade de alunos em cada curso. comandos join e group by */
SELECT c.nome AS Nome_do_Curso, COUNT(ac.idAluno) AS Quantidade_de_Alunos
FROM Curso c
LEFT JOIN AlunoCurso ac ON c.idCurso = ac.idCurso
GROUP BY c.nome;
