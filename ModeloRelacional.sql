CREATE SEQUENCE seq_Fatura;
CREATE SEQUENCE seq_Pagamento;
CREATE TABLE Quarto
(
    Id                        varchar2(1) NOT NULL,
    LotacaoMaxima             number(1)   NOT NULL,
    TipoQuartoId              varchar2(1) NOT NULL,
    NumeroQuartoId            number(1)   NOT NULL,
    NumeroQuartoNumAndar      number(1)   NOT NULL,
    NumeroQuartoNumSequencial number(3)   NOT NULL,
    NumeroQuartoAndarId       varchar2(1) NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE NumeroQuarto
(
    NumSequencial number(3)   NOT NULL,
    AndarId       varchar2(1) NOT NULL,
    PRIMARY KEY (NumSequencial,
                 AndarId)
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
    Id               varchar2(1)                      NOT NULL,
    ClienteNif       number(2)                        NOT NULL,
    QuartoId         varchar2(1)                      NOT NULL,
    DataInicio       date                             NOT NULL,
    DataFim          date                             NOT NULL,
    NumPessoas       number(1)                        NOT NULL,
    Estado           varchar2(15) DEFAULT 'Reservada' NOT NULL,
    DataCancelamento date                             NOT NULL,
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
CREATE TABLE Conta
(
    ReservaId    varchar2(1) NOT NULL,
    Valor        number(3)   NOT NULL,
    DataAbertura date        NOT NULL,
    PRIMARY KEY (ReservaId)
);
CREATE TABLE Fatura
(
    Id             number(2)   NOT NULL,
    ValorConta     number(2)   NOT NULL,
    Data           date        NOT NULL,
    ReservaId      varchar2(1) NOT NULL,
    PagamentoId    number(2)   NOT NULL,
    ContaReservaId varchar2(1) NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE Camareira
(
    FuncionárioNif number(10) NOT NULL,
    PRIMARY KEY (FuncionárioNif)
);
CREATE TABLE FuncionarioRestauracao
(
    FuncionárioNif number(10) NOT NULL,
    PRIMARY KEY (FuncionárioNif)
);
CREATE TABLE FuncionarioRececao
(
    FuncionárioNif number(10) NOT NULL,
    PRIMARY KEY (FuncionárioNif)
);
CREATE TABLE FuncinarioManutencao
(
    FuncionárioNif     number(10) NOT NULL,
    TelefoneManutencao number(9)  NOT NULL,
    NifResponsavel     number(10),
    PRIMARY KEY (FuncionárioNif)
);
CREATE TABLE Pagamento
(
    Id                number(2)    NOT NULL,
    Timestamp         timestamp(0) NOT NULL,
    TipoPagamentoTipo number(2)    NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE TipoPagamento
(
    Tipo      number(2) GENERATED AS IDENTITY,
    Descricao varchar2(10) NOT NULL,
    PRIMARY KEY (Tipo)
);
CREATE TABLE IntervencaoLimpeza
(
    Id           number(3) GENERATED AS IDENTITY,
    Timestamp    timestamp(0) NOT NULL,
    CamareiraNif number(10)   NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE IntervencaoManutencao
(
    Id                      number(3) GENERATED AS IDENTITY,
    Timestamp               timestamp(0),
    FuncinarioManutencaoNif number(10) NOT NULL,
    PRIMARY KEY (Id)
);
CREATE TABLE DespesaFrigobar
(
    Produto                 varchar2(10),
    Quantidade              number(2),
    Data                    date,
    ContaReservaId          varchar2(1) NOT NULL,
    CamareiraFuncionárioNif number(10)  NOT NULL
);
CREATE TABLE Funcionario
(
    Nif      number(10) GENERATED AS IDENTITY,
    Nome     varchar2(10) NOT NULL,
    Morada   varchar2(20) NOT NULL,
    Telefone number(9)    NOT NULL,
    Email    varchar2(20) NOT NULL,
    PRIMARY KEY (Nif)
);
ALTER TABLE Quarto
    ADD CONSTRAINT FKQuarto70849 FOREIGN KEY (TipoQuartoId) REFERENCES TipoQuarto (Id);
ALTER TABLE Quarto
    ADD CONSTRAINT FKQuarto766074 FOREIGN KEY (NumeroQuartoNumSequencial, NumeroQuartoAndarId) REFERENCES NumeroQuarto (NumSequencial, AndarId);
ALTER TABLE Preco
    ADD CONSTRAINT FKPreco260308 FOREIGN KEY (TipoQuartoId) REFERENCES TipoQuarto (Id);
ALTER TABLE Preco
    ADD CONSTRAINT FKPreco928663 FOREIGN KEY (EpocaAnoId) REFERENCES EpocaAno (Id);
ALTER TABLE Reserva
    ADD CONSTRAINT FKReserva503584 FOREIGN KEY (ClienteNif) REFERENCES Cliente (Nif);
ALTER TABLE Fatura
    ADD CONSTRAINT FKFatura34283 FOREIGN KEY (ContaReservaId) REFERENCES Conta (ReservaId);
ALTER TABLE Fatura
    ADD CONSTRAINT FKFatura910040 FOREIGN KEY (ReservaId) REFERENCES Reserva (Id);
ALTER TABLE Fatura
    ADD CONSTRAINT FKFatura898646 FOREIGN KEY (PagamentoId) REFERENCES Pagamento (Id);
ALTER TABLE Pagamento
    ADD CONSTRAINT FKPagamento401572 FOREIGN KEY (TipoPagamentoTipo) REFERENCES TipoPagamento (Tipo);
ALTER TABLE IntervencaoLimpeza
    ADD CONSTRAINT FKIntervenca593039 FOREIGN KEY (CamareiraNif) REFERENCES Camareira (FuncionárioNif);
ALTER TABLE Reserva
    ADD CONSTRAINT FKReserva881425 FOREIGN KEY (QuartoId) REFERENCES Quarto (Id);
ALTER TABLE NumeroQuarto
    ADD CONSTRAINT FKNumeroQuar47313 FOREIGN KEY (AndarId) REFERENCES Andar (Id);
ALTER TABLE DespesaFrigobar
    ADD CONSTRAINT FKDespesaFri550100 FOREIGN KEY (ContaReservaId) REFERENCES Conta (ReservaId);
ALTER TABLE DespesaFrigobar
    ADD CONSTRAINT FKDespesaFri651977 FOREIGN KEY (CamareiraFuncionárioNif) REFERENCES Camareira (FuncionárioNif);
ALTER TABLE Conta
    ADD CONSTRAINT FKConta993810 FOREIGN KEY (ReservaId) REFERENCES Reserva (Id);
ALTER TABLE Camareira
    ADD CONSTRAINT FKCamareira329289 FOREIGN KEY (FuncionárioNif) REFERENCES Funcionario (Nif);
ALTER TABLE FuncinarioManutencao
    ADD CONSTRAINT FKFuncinario967183 FOREIGN KEY (FuncionárioNif) REFERENCES Funcionario (Nif);
ALTER TABLE FuncionarioRestauracao
    ADD CONSTRAINT FKFuncionari742513 FOREIGN KEY (FuncionárioNif) REFERENCES Funcionario (Nif);
ALTER TABLE FuncionarioRececao
    ADD CONSTRAINT FKFuncionari212864 FOREIGN KEY (FuncionárioNif) REFERENCES Funcionario (Nif);
ALTER TABLE IntervencaoManutencao
    ADD CONSTRAINT FKIntervenca464968 FOREIGN KEY (FuncinarioManutencaoNif) REFERENCES FuncinarioManutencao (FuncionárioNif);
