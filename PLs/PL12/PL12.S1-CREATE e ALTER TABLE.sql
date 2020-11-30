-- ** eliminar tabelas se existentes **
-- CASCADE CONSTRAINTS para eliminar as restri��es de integridade das chaves prim�rias e chaves �nicas
-- PURGE elimina a tabela da base de dados e da "reciclagem"
DROP TABLE codigoPostal CASCADE CONSTRAINTS PURGE;
DROP TABLE especialidade CASCADE CONSTRAINTS PURGE;
DROP TABLE medicamento CASCADE CONSTRAINTS PURGE;
DROP TABLE medico CASCADE CONSTRAINTS PURGE;
DROP TABLE paciente CASCADE CONSTRAINTS PURGE;
DROP TABLE consulta CASCADE CONSTRAINTS PURGE;
DROP TABLE medicamentoReceitado CASCADE CONSTRAINTS PURGE;

-- ## tabela especialidade ##
CREATE TABLE especialidade
(
    idEspecialidade INTEGER
        CONSTRAINT pkEspecialidadeIdEspecialidade PRIMARY KEY,
    designacao      VARCHAR2(30)
        CONSTRAINT nnEspecialidadeDesignacao NOT NULL
);

-- ## tabela medico ##
CREATE TABLE medico
(
    idMedico        INTEGER
        CONSTRAINT pkMedicoIdMedico PRIMARY KEY,
    idEspecialidade INTEGER
        CONSTRAINT nnMedicoIdEspecialidade NOT NULL,
    idMedicoChefe   INTEGER,
    nome            VARCHAR2(40)
        CONSTRAINT nnMedicoNome NOT NULL,
    hospital        VARCHAR2(20),

    dataNascimento  DATE
        CONSTRAINT nnMedicoDataNascimento NOT NULL,
    codPostal       VARCHAR(8)
);

-- ## tabela paciente ##
CREATE TABLE paciente
(
    idPaciente     INTEGER
        CONSTRAINT pkPacienteIdPaciente PRIMARY KEY,
    nome           VARCHAR2(40)
        CONSTRAINT nnPacienteNome NOT NULL,
    dataNascimento DATE
        CONSTRAINT nnPacienteDataNascimento NOT NULL,
    codPostal      VARCHAR(8)
);

-- ## tabela consulta ## 
CREATE TABLE consulta
(
    idConsulta INTEGER
        CONSTRAINT pkConsultaIdConsulta PRIMARY KEY,
    dataHora   DATE
        CONSTRAINT nnConsultaDataHora NOT NULL,
    idMedico   INTEGER
        CONSTRAINT nnConsultaIdMedico NOT NULL,
    idPaciente INTEGER
        CONSTRAINT nnConsultaIdPaciente NOT NULL,

    CONSTRAINT ukConsultaDataHoraIdMedico UNIQUE (dataHora, idMedico)
);

-- ## tabela medicamento ##
CREATE TABLE medicamento
(
    idMedicamento INTEGER
        CONSTRAINT pkMedicamentoIdMedicamento PRIMARY KEY,
    nome          VARCHAR2(40)
        CONSTRAINT nnMedicamentoNome NOT NULL,
    laboratorio   VARCHAR2(20)
        CONSTRAINT nnMedicamentoLaboratorio NOT NULL
);

-- ## tabela medicamentoReceitado ## 
CREATE TABLE medicamentoReceitado
(
    idConsulta    INTEGER,
    idMedicamento INTEGER,

    CONSTRAINT pkMedicamentoReceitaIdConsultaIdMedicamento PRIMARY KEY (idConsulta, idMedicamento)
);

-- ## tabela codigoPostal ##
CREATE TABLE codigoPostal
(
    codPostal  VARCHAR(8)
        CONSTRAINT pkCodigoPostaiCodPostal PRIMARY KEY
        CONSTRAINT ckCodigoPostalCodPostal CHECK ( REGEXP_LIKE(codPostal, '\d{4}-\d{3}') ),
    localidade VARCHAR2(20)
        CONSTRAINT nnCodigoPostaLocalidade NOT NULL
);

-- ** alterar tabelas para defini��o de chaves estrangeiras **
ALTER TABLE medico
    ADD CONSTRAINT fkMedicoCodPostal FOREIGN KEY (codPostal) REFERENCES codigoPostal (codPostal);
ALTER TABLE medico
    ADD CONSTRAINT fkMedicoIdEspecialidade FOREIGN KEY (idEspecialidade) REFERENCES especialidade (idEspecialidade);
ALTER TABLE medico
    ADD CONSTRAINT fkMedicoIdMedicoChefe FOREIGN KEY (idMedicoChefe) REFERENCES medico (idMedico);

ALTER TABLE medicamentoReceitado
    ADD CONSTRAINT fkMedicamentoReceitadoIdConsultas FOREIGN KEY (idConsulta) REFERENCES consulta (idConsulta);
ALTER TABLE medicamentoReceitado
    ADD CONSTRAINT fkMedicamentoReceitadoIdMedicamento FOREIGN KEY (idMedicamento) REFERENCES medicamento (idMedicamento);

ALTER TABLE paciente
    ADD CONSTRAINT fkPacienteCodPostal FOREIGN KEY (codPostal) REFERENCES codigoPostal (codPostal);

ALTER TABLE consulta
    ADD CONSTRAINT fkConsultaIdMedico FOREIGN KEY (idMedico) REFERENCES medico (idMedico);
ALTER TABLE consulta
    ADD CONSTRAINT fkConsultaPaciente FOREIGN KEY (idPaciente) REFERENCES paciente (idPaciente);

--se necess�rio por causa de problemas com o  REGEXP_LIKE
--ALTER SESSION SET NLS_SORT=BINARY;

-- ** guardar em DEFINITIVO as altera��es na base de dados, se a op��o Autocommit do SQL Developer n�o estiver ativada **
-- COMMIT;
