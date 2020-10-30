-- ** eliminar tabelas se existentes **
-- CASCADE CONSTRAINTS para eliminar as restrições de integridade das chaves primárias e chaves únicas
-- PURGE elimina a tabela da base de dados e da "reciclagem"
DROP TABLE revisao CASCADE CONSTRAINTS PURGE;
DROP TABLE automovelCliente CASCADE CONSTRAINTS PURGE;
DROP TABLE cliente CASCADE CONSTRAINTS PURGE;
DROP TABLE automovel CASCADE CONSTRAINTS PURGE;

-- ** criar tabelas **
-- ## tabela Automovel ##
CREATE TABLE automovel
(
    matricula  CHAR(8)
        CONSTRAINT pkAutomovelMatricula PRIMARY KEY,
    marca      VARCHAR(40)
        CONSTRAINT nnAutomovelMarca NOT NULL,
    cilindrada INTEGER
        CONSTRAINT nnAutomovelCilindrada NOT NULL
        CONSTRAINT ckAutomovelCilindrada CHECK (cilindrada BETWEEN 1000 AND 6000),
    anoFabrico INTEGER
        CONSTRAINT nnAutomovelAnoFabrico NOT NULL
        CONSTRAINT ckAutomovelAnoFabrico CHECK (anoFabrico >= 2000)
        CONSTRAINT afAutomovelAnoFabrico CHECK (anoFabrico <= 2021),
    precoVenda NUMERIC(10, 2)
        CONSTRAINT nnAutomovelPrecoVenda NOT NULL
        CONSTRAINT ckAutomovelPrecoVenda CHECK (precoVenda > 0),

    CONSTRAINT ckAutomovelMatricula CHECK (REGEXP_LIKE(matricula,
                                                       '^\d{2}-[A-Z]{2}-\d{2}$|^\d{2}-\d{2}-[A-Z]{2}$|^[A-Z]{2}-\d{2}-\d{2}$'))
    --alternativa
--    CONSTRAINT ckAutomovelMatricula CHECK (REGEXP_LIKE(matricula, '[0-9]{2}-[A-Z]{2}-[0-9]{2}|[0-9]{2}-[0-9]{2}-[A-Z]{2}|[A-Z]{2}-[0-9]{2}-[0-9]{2}'))
);

-- ## tabela Cliente ##
CREATE TABLE cliente
(
    idCliente            INTEGER GENERATED AS IDENTITY
        CONSTRAINT pkClienteIdCliente PRIMARY KEY,
    nome                 VARCHAR(40)
        CONSTRAINT nnClienteNome NOT NULL,
    nrIdentificacaoCivil INTEGER
        CONSTRAINT ckClienteNrIdentificacaoCivil CHECK (REGEXP_LIKE(nrIdentificacaoCivil, '^\d{6,}$'))
        CONSTRAINT ukClienteNrIdentificacaoCivil UNIQUE,
    nif                  INTEGER
        CONSTRAINT nnClienteNif NOT NULL
        CONSTRAINT ckClienteNif CHECK (REGEXP_LIKE(nif, '^\d{9}$'))
        CONSTRAINT ukClienteNif UNIQUE,
    dataNascimento       DATE
        CONSTRAINT nnClienteDataNascimen NOT NULL
);

-- ## tabela AutomovelCliente ##
CREATE TABLE automovelCliente
(
    matricula CHAR(8),
    idCliente INTEGER,

    CONSTRAINT pkAutomovelClienteMatriculaIdCliente PRIMARY KEY (matricula, idCliente)
);

CREATE TABLE revisao
(
    matricula        CHAR(8) NULL,
    dataHoraMarcacao TIMESTAMP,
    efetuada         CHAR(1) DEFAULT 'N'
        CONSTRAINT rgEfetuada CHECK (REGEXP_LIKE(efetuada, '[SsNn]'))
        CONSTRAINT nnEfetuada NOT NULL,

    CONSTRAINT pkRevisaoMatriculaDataHoraMarcacao PRIMARY KEY (matricula, dataHoraMarcacao)
);

-- ** alterar tabelas para definição de chaves estrangeiras **
-- ## tabela AutomovelCliente ##
ALTER TABLE automovelCliente
    ADD CONSTRAINT fkAutomovelClienteMatricula FOREIGN KEY (matricula) REFERENCES automovel (matricula);
ALTER TABLE automovelCliente
    ADD CONSTRAINT fkAutomovelClienteIdCliente FOREIGN KEY (idCliente) REFERENCES cliente (idCliente);

ALTER TABLE revisao
    ADD CONSTRAINT pkRevisaoMatricula FOREIGN KEY (matricula) references automovel (matricula);

--se necessário por causa de problemas com o  REGEXP_LIKE
--ALTER SESSION SET NLS_SORT=BINARY;

-- ** guardar em DEFINITIVO as alterações na base de dados, se a opção Autocommit do SQL Developer não estiver ativada **
-- COMMIT; 