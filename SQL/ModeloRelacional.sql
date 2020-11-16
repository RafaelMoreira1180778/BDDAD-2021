DROP TABLE Quarto CASCADE CONSTRAINTS;
DROP TABLE NumeroQuarto CASCADE CONSTRAINTS;
DROP TABLE Andar CASCADE CONSTRAINTS;
DROP TABLE TipoQuarto CASCADE CONSTRAINTS;
DROP TABLE Preco CASCADE CONSTRAINTS;
DROP TABLE EpocaAno CASCADE CONSTRAINTS;
DROP TABLE Reserva CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE Conta CASCADE CONSTRAINTS;
DROP TABLE Fatura CASCADE CONSTRAINTS;
DROP TABLE Camareira CASCADE CONSTRAINTS;
DROP TABLE FuncionarioRestauracao CASCADE CONSTRAINTS;
DROP TABLE FuncionarioRececao CASCADE CONSTRAINTS;
DROP TABLE FuncinarioManutencao CASCADE CONSTRAINTS;
DROP TABLE Pagamento CASCADE CONSTRAINTS;
DROP TABLE TipoPagamento CASCADE CONSTRAINTS;
DROP TABLE IntervencaoLimpeza CASCADE CONSTRAINTS;
DROP TABLE IntervencaoManutencao CASCADE CONSTRAINTS;
DROP TABLE DespesaFrigobar CASCADE CONSTRAINTS;
DROP TABLE Funcionario CASCADE CONSTRAINTS;
DROP TABLE PedidoIntervencao CASCADE CONSTRAINTS;
DROP TABLE Produto CASCADE CONSTRAINTS;
CREATE TABLE Quarto (
  Id                        varchar2(1) NOT NULL, 
  LotacaoMaxima             number(1) NOT NULL, 
  TipoQuartoId              varchar2(1) NOT NULL, 
  NumeroQuartoId            number(1) NOT NULL, 
  NumeroQuartoNumAndar      number(1) NOT NULL, 
  NumeroQuartoNumSequencial number(3) NOT NULL, 
  NumeroQuartoAndarId       varchar2(1) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE NumeroQuarto (
  NumSequencial number(3) NOT NULL, 
  AndarId       varchar2(1) NOT NULL, 
  PRIMARY KEY (NumSequencial, 
  AndarId));
CREATE TABLE Andar (
  Id     varchar2(1) NOT NULL, 
  Nome   varchar2(3) NOT NULL, 
  Numero number(1) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE TipoQuarto (
  Id        varchar2(1) NOT NULL, 
  Descricao varchar2(3), 
  PRIMARY KEY (Id));
CREATE TABLE Preco (
  Valor        number(10), 
  TipoQuartoId varchar2(1) NOT NULL, 
  EpocaAnoId   varchar2(1) NOT NULL);
CREATE TABLE EpocaAno (
  Id         varchar2(1) NOT NULL, 
  DataInicio date NOT NULL, 
  DataFim    date NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE Reserva (
  Id               varchar2(1) NOT NULL, 
  ClienteNif       number(2) NOT NULL, 
  QuartoId         varchar2(1) NOT NULL, 
  DataInicio       date NOT NULL, 
  DataFim          date NOT NULL, 
  NumPessoas       number(1) NOT NULL, 
  Estado           varchar2(15) DEFAULT 'Reservada' NOT NULL, 
  DataCancelamento date NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE Cliente (
  Nif      number(2) GENERATED AS IDENTITY, 
  Nome     varchar2(2) NOT NULL, 
  email    varchar2(3), 
  Telefone number(2), 
  ContaId  number(2) NOT NULL, 
  PRIMARY KEY (Nif));
CREATE TABLE Conta (
  ReservaId    varchar2(1) NOT NULL, 
  DataAbertura date NOT NULL, 
  PRIMARY KEY (ReservaId));
CREATE TABLE Fatura (
  Id             number(2) GENERATED AS IDENTITY, 
  ValorConta     number(2) NOT NULL, 
  Data           date NOT NULL, 
  ReservaId      varchar2(1) NOT NULL, 
  ContaReservaId varchar2(1) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE Camareira (
  FuncionarioNif number(10) NOT NULL, 
  PRIMARY KEY (FuncionarioNif));
CREATE TABLE FuncionarioRestauracao (
  FuncionarioNif number(10) NOT NULL, 
  PRIMARY KEY (FuncionarioNif));
CREATE TABLE FuncionarioRececao (
  FuncionarioNif number(10) NOT NULL, 
  PRIMARY KEY (FuncionarioNif));
CREATE TABLE FuncinarioManutencao (
  FuncionarioNif     number(10) NOT NULL, 
  TelefoneManutencao number(9) NOT NULL, 
  NifResponsavel     number(10), 
  PRIMARY KEY (FuncionarioNif));
CREATE TABLE Pagamento (
  Id                number(2) GENERATED AS IDENTITY, 
  Timestamp         timestamp(0) NOT NULL, 
  TipoPagamentoTipo number(2) NOT NULL, 
  FaturaId          number(2) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE TipoPagamento (
  Tipo      number(2) GENERATED AS IDENTITY, 
  Descricao varchar2(10) NOT NULL, 
  PRIMARY KEY (Tipo));
CREATE TABLE IntervencaoLimpeza (
  Id                  number(3) GENERATED AS IDENTITY, 
  Timestamp           timestamp(0) NOT NULL, 
  CamareiraNif        number(10) NOT NULL, 
  PedidoIntervencaoId number(3) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE IntervencaoManutencao (
  Id                      number(3) GENERATED AS IDENTITY, 
  Timestamp               timestamp(0), 
  FuncinarioManutencaoNif number(10) NOT NULL, 
  PedidoIntervencaoId     number(3) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE DespesaFrigobar (
  Data                    date, 
  ContaReservaId          varchar2(1) NOT NULL, 
  CamareiraFuncionarioNif number(10) NOT NULL, 
  ProdutoId               number(3) NOT NULL);
CREATE TABLE Funcionario (
  Nif      number(10) GENERATED AS IDENTITY, 
  Nome     varchar2(10) NOT NULL, 
  Morada   varchar2(20) NOT NULL, 
  Telefone number(9) NOT NULL, 
  Email    varchar2(20) NOT NULL, 
  PRIMARY KEY (Nif));
CREATE TABLE PedidoIntervencao (
  Id        number(3) GENERATED AS IDENTITY, 
  ReservaId varchar2(1) NOT NULL, 
  Estado    varchar2(5), 
  Data      date, 
  PRIMARY KEY (Id));
CREATE TABLE Produto (
  Id    number(3) GENERATED AS IDENTITY, 
  Nome  varchar2(15) NOT NULL, 
  Tipo  varchar2(10) NOT NULL, 
  Custo number(3), 
  PRIMARY KEY (Id));
ALTER TABLE Quarto ADD CONSTRAINT FKQuarto70849 FOREIGN KEY (TipoQuartoId) REFERENCES TipoQuarto (Id);
ALTER TABLE Quarto ADD CONSTRAINT FKQuarto766074 FOREIGN KEY (NumeroQuartoNumSequencial, NumeroQuartoAndarId) REFERENCES NumeroQuarto (NumSequencial, AndarId);
ALTER TABLE Preco ADD CONSTRAINT FKPreco260308 FOREIGN KEY (TipoQuartoId) REFERENCES TipoQuarto (Id);
ALTER TABLE Preco ADD CONSTRAINT FKPreco928663 FOREIGN KEY (EpocaAnoId) REFERENCES EpocaAno (Id);
ALTER TABLE Reserva ADD CONSTRAINT FKReserva503584 FOREIGN KEY (ClienteNif) REFERENCES Cliente (Nif);
ALTER TABLE Fatura ADD CONSTRAINT FKFatura34283 FOREIGN KEY (ContaReservaId) REFERENCES Conta (ReservaId);
ALTER TABLE Fatura ADD CONSTRAINT FKFatura910040 FOREIGN KEY (ReservaId) REFERENCES Reserva (Id);
ALTER TABLE Pagamento ADD CONSTRAINT FKPagamento401572 FOREIGN KEY (TipoPagamentoTipo) REFERENCES TipoPagamento (Tipo);
ALTER TABLE IntervencaoLimpeza ADD CONSTRAINT FKIntervenca55148 FOREIGN KEY (CamareiraNif) REFERENCES Camareira (FuncionarioNif);
ALTER TABLE Reserva ADD CONSTRAINT FKReserva881425 FOREIGN KEY (QuartoId) REFERENCES Quarto (Id);
ALTER TABLE NumeroQuarto ADD CONSTRAINT FKNumeroQuar47313 FOREIGN KEY (AndarId) REFERENCES Andar (Id);
ALTER TABLE DespesaFrigobar ADD CONSTRAINT FKDespesaFri550100 FOREIGN KEY (ContaReservaId) REFERENCES Conta (ReservaId);
ALTER TABLE DespesaFrigobar ADD CONSTRAINT FKDespesaFri327193 FOREIGN KEY (CamareiraFuncionarioNif) REFERENCES Camareira (FuncionarioNif);
ALTER TABLE Conta ADD CONSTRAINT FKConta993810 FOREIGN KEY (ReservaId) REFERENCES Reserva (Id);
ALTER TABLE Camareira ADD CONSTRAINT FKCamareira994113 FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
ALTER TABLE FuncinarioManutencao ADD CONSTRAINT FKFuncinario681003 FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
ALTER TABLE FuncionarioRestauracao ADD CONSTRAINT FKFuncionari580889 FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
ALTER TABLE FuncionarioRececao ADD CONSTRAINT FKFuncionari110539 FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
ALTER TABLE IntervencaoManutencao ADD CONSTRAINT FKIntervenca858434 FOREIGN KEY (FuncinarioManutencaoNif) REFERENCES FuncinarioManutencao (FuncionarioNif);
ALTER TABLE PedidoIntervencao ADD CONSTRAINT FKPedidoInte127117 FOREIGN KEY (ReservaId) REFERENCES Reserva (Id);
ALTER TABLE Pagamento ADD CONSTRAINT FKPagamento756229 FOREIGN KEY (FaturaId) REFERENCES Fatura (Id);
ALTER TABLE IntervencaoManutencao ADD CONSTRAINT FKIntervenca872512 FOREIGN KEY (PedidoIntervencaoId) REFERENCES PedidoIntervencao (Id);
ALTER TABLE DespesaFrigobar ADD CONSTRAINT FKDespesaFri434984 FOREIGN KEY (ProdutoId) REFERENCES Produto (Id);
ALTER TABLE IntervencaoLimpeza ADD CONSTRAINT FKIntervenca112471 FOREIGN KEY (PedidoIntervencaoId) REFERENCES PedidoIntervencao (Id);
