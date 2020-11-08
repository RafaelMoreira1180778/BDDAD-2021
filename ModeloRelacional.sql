DROP SEQUENCE seq_Intervencao;
DROP SEQUENCE seq_Fatura;
DROP SEQUENCE seq_Pagamento;
DROP TABLE Quarto CASCADE CONSTRAINTS;
DROP TABLE NumeroQuarto CASCADE CONSTRAINTS;
DROP TABLE Andar CASCADE CONSTRAINTS;
DROP TABLE TipoQuarto CASCADE CONSTRAINTS;
DROP TABLE AndarQuarto CASCADE CONSTRAINTS;
DROP TABLE Preco CASCADE CONSTRAINTS;
DROP TABLE EpocaAno CASCADE CONSTRAINTS;
DROP TABLE Reserva CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE DisponibilidadeQuarto CASCADE CONSTRAINTS;
DROP TABLE Conta CASCADE CONSTRAINTS;
DROP TABLE Funcionario CASCADE CONSTRAINTS;
DROP TABLE TipoFuncionario CASCADE CONSTRAINTS;
DROP TABLE Intervencao CASCADE CONSTRAINTS;
DROP TABLE TipoIntervencao CASCADE CONSTRAINTS;
DROP TABLE Fatura CASCADE CONSTRAINTS;
DROP TABLE Pagamento CASCADE CONSTRAINTS;
CREATE SEQUENCE seq_Intervencao;
CREATE SEQUENCE seq_Fatura;
CREATE SEQUENCE seq_Pagamento;
CREATE TABLE Quarto
(
    Id             varchar2(1) NOT NULL,
    LotacaoMaxima  number(1)   NOT NULL,
    TipoQuartoId   varchar2(1) NOT NULL,
    NumeroQuartoId number(1)   NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE NumeroQuarto
(
    Id            number(1) GENERATED AS IDENTITY,
    NumAndar      number(1) NOT NULL,
    NumSequencial number(3) NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE Andar
(
    Id     varchar2(1) NOT NULL,
    Nome   varchar2(3) NOT NULL,
    Numero number(1)   NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE TipoQuarto
(
    Id        varchar2(1) NOT NULL,
    Descricao varchar2(3),
    PRIMARY KEY (Id)
);
CREATE TABLE AndarQuarto
(
    AndarId  varchar2(1) NOT NULL,
    QuartoId varchar2(1) NOT NULL,
    PRIMARY KEY (AndarId,
                 QuartoId)
);
CREATE TABLE Preco
(
    Valor        number(10),
    TipoQuartoId varchar2(1) NOT NULL,
    EpocaAnoId   varchar2(1) NOT NULL
);
CREATE TABLE EpocaAno
(
    Id         varchar2(1) NOT NULL,
    DataInicio date        NOT NULL,
    DataFim    date        NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE Reserva
(
    Id           varchar2(1)                      NOT NULL,
    ClienteNif   number(2)                        NOT NULL,
    TipoQuartoId varchar2(1)                      NOT NULL,
    DataInicio   date                             NOT NULL,
    DataFim      date                             NOT NULL,
    NumPessoas   number(1)                        NOT NULL,
    Estado       varchar2(15) DEFAULT 'Reservada' NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE Cliente
(
    Nif      number(2) GENERATED AS IDENTITY,
    Nome     varchar2(2) NOT NULL,
    email    varchar2(3),
    Telefone number(2),
    ContaId  number(2)   NOT NULL,
    PRIMARY KEY (Nif)
);
CREATE TABLE DisponibilidadeQuarto
(
    QuartoId        varchar2(1)                    NOT NULL,
    Disponibilidade varchar2(15) DEFAULT 'Ocupado' NOT NULL,
    DataInicio      date                           NOT NULL,
    DataFim         date                           NOT NULL
);
CREATE TABLE Conta
(
    Id           number(2) GENERATED AS IDENTITY,
    Valor        number(3) NOT NULL,
    DataAbertura date      NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE Funcionario
(
    Nif               number(2) GENERATED AS IDENTITY,
    Morada            varchar2(3) NOT NULL,
    Telefone          number(2)   NOT NULL,
    Email             varchar2(3) NOT NULL,
    TipoFuncionarioId number(1)   NOT NULL,
    TelefoneServico   number(2),
    NifResponsavel    number(2),
    PRIMARY KEY (Nif)
);
CREATE TABLE TipoFuncionario
(
    Id        number(1) GENERATED AS IDENTITY,
    Descricao varchar2(2) NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE Intervencao
(
    Id                number(2)   NOT NULL,
    QuartoId          varchar2(1) NOT NULL,
    FuncionarioNif    number(2)   NOT NULL,
    TipoIntervencaoId number(1)   NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE TipoIntervencao
(
    Id        number(1) GENERATED AS IDENTITY,
    Descricao varchar2(3),
    PRIMARY KEY (Id)
);
CREATE TABLE Fatura
(
    Id          number(2)   NOT NULL,
    ValorConta  number(2)   NOT NULL,
    PagamentoId number(2)   NOT NULL,
    Data        date        NOT NULL,
    ReservaId   varchar2(1) NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE Pagamento
(
    Id        number(2)    NOT NULL,
    Timestamp timestamp(0) NOT NULL,
    Cheque    varchar2(2),
    CCredito  number(3),
    CDebito   number(3),
    PRIMARY KEY (Id)
);
ALTER TABLE Quarto
    ADD CONSTRAINT FKQuarto70849 FOREIGN KEY (TipoQuartoId) REFERENCES TipoQuarto (Id);
ALTER TABLE AndarQuarto
    ADD CONSTRAINT FKAndarQuart74915 FOREIGN KEY (AndarId) REFERENCES Andar (Id);
ALTER TABLE AndarQuarto
    ADD CONSTRAINT FKAndarQuart267342 FOREIGN KEY (QuartoId) REFERENCES Quarto (Id);
ALTER TABLE Quarto
    ADD CONSTRAINT FKQuarto167695 FOREIGN KEY (NumeroQuartoId) REFERENCES NumeroQuarto (Id);
ALTER TABLE Preco
    ADD CONSTRAINT FKPreco260308 FOREIGN KEY (TipoQuartoId) REFERENCES TipoQuarto (Id);
ALTER TABLE Preco
    ADD CONSTRAINT FKPreco928663 FOREIGN KEY (EpocaAnoId) REFERENCES EpocaAno (Id);
ALTER TABLE Reserva
    ADD CONSTRAINT FKReserva503584 FOREIGN KEY (ClienteNif) REFERENCES Cliente (Nif);
ALTER TABLE Reserva
    ADD CONSTRAINT FKReserva642482 FOREIGN KEY (TipoQuartoId) REFERENCES TipoQuarto (Id);
ALTER TABLE DisponibilidadeQuarto
    ADD CONSTRAINT FKDisponibil56187 FOREIGN KEY (QuartoId) REFERENCES Quarto (Id);
ALTER TABLE Cliente
    ADD CONSTRAINT FKCliente747773 FOREIGN KEY (ContaId) REFERENCES Conta (Id);
ALTER TABLE Funcionario
    ADD CONSTRAINT FKFuncionari996076 FOREIGN KEY (TipoFuncionarioId) REFERENCES TipoFuncionario (Id);
ALTER TABLE Funcionario
    ADD CONSTRAINT FKFuncionari913191 FOREIGN KEY (NifResponsavel) REFERENCES Funcionario (Nif);
ALTER TABLE Intervencao
    ADD CONSTRAINT FKIntervenca238381 FOREIGN KEY (QuartoId) REFERENCES Quarto (Id);
ALTER TABLE Intervencao
    ADD CONSTRAINT FKIntervenca266976 FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
ALTER TABLE Intervencao
    ADD CONSTRAINT FKIntervenca347399 FOREIGN KEY (TipoIntervencaoId) REFERENCES TipoIntervencao (Id);
ALTER TABLE Fatura
    ADD CONSTRAINT FKFatura437572 FOREIGN KEY (ValorConta) REFERENCES Conta (Id);
ALTER TABLE Fatura
    ADD CONSTRAINT FKFatura898646 FOREIGN KEY (PagamentoId) REFERENCES Pagamento (Id);
ALTER TABLE Fatura
    ADD CONSTRAINT FKFatura910040 FOREIGN KEY (ReservaId) REFERENCES Reserva (Id);
