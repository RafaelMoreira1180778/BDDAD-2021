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
DROP TABLE FuncionarioManutencao CASCADE CONSTRAINTS;
DROP TABLE Pagamento CASCADE CONSTRAINTS;
DROP TABLE TipoPagamento CASCADE CONSTRAINTS;
DROP TABLE IntervencaoLimpeza CASCADE CONSTRAINTS;
DROP TABLE IntervencaoManutencao CASCADE CONSTRAINTS;
DROP TABLE DespesaFrigobar CASCADE CONSTRAINTS;
DROP TABLE Funcionario CASCADE CONSTRAINTS;
DROP TABLE PedidoIntervencao CASCADE CONSTRAINTS;
DROP TABLE Produto CASCADE CONSTRAINTS;
CREATE TABLE Quarto (
  Id                        number(2) NOT NULL, 
  LotacaoMaxima             number(1) NOT NULL, 
  TipoQuartoId              number(1) NOT NULL, 
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
  Nome   varchar2(20) NOT NULL, 
  Numero number(1) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE TipoQuarto (
  Id        number(1) NOT NULL, 
  Descricao varchar2(10), 
  PRIMARY KEY (Id));
CREATE TABLE Preco (
  Valor        number(10), 
  TipoQuartoId number(1) NOT NULL, 
  EpocaAnoId   varchar2(1) NOT NULL);
CREATE TABLE EpocaAno (
  Id         varchar2(1) NOT NULL, 
  DataInicio date NOT NULL, 
  DataFim    date NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE Reserva (
  Id               number(3) NOT NULL, 
  ClienteNif       number(9) NOT NULL, 
  QuartoId         number(2) NOT NULL, 
  DataInicio       date NOT NULL, 
  DataFim          date NOT NULL, 
  NumPessoas       number(1) NOT NULL, 
  Estado           varchar2(15) NOT NULL, 
  DataCancelamento date, 
  PRIMARY KEY (Id));
CREATE TABLE Cliente (
  Nif        number(9) NOT NULL, 
  Nome       varchar2(30) NOT NULL, 
  email      varchar2(40), 
  Telefone   number(9), 
  Concelho   varchar2(20) NOT NULL, 
  Localidade varchar2(20) NOT NULL, 
  PRIMARY KEY (Nif));
CREATE TABLE Conta (
  NumUnico     number(3) NOT NULL, 
  ReservaId    number(3) NOT NULL, 
  DataAbertura date NOT NULL, 
  PRIMARY KEY (NumUnico));
CREATE TABLE Fatura (
  Id             number(2) NOT NULL, 
  ValorConta     number(2) NOT NULL, 
  Data           date NOT NULL, 
  ReservaId      number(3) NOT NULL, 
  ContaReservaId varchar2(1) NOT NULL, 
  ContaNumUnico  number(3) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE Camareira (
  FuncionarioNif number(9) NOT NULL, 
  PRIMARY KEY (FuncionarioNif));
CREATE TABLE FuncionarioRestauracao (
  FuncionarioNif number(9) NOT NULL, 
  PRIMARY KEY (FuncionarioNif));
CREATE TABLE FuncionarioRececao (
  FuncionarioNif number(9) NOT NULL, 
  PRIMARY KEY (FuncionarioNif));
CREATE TABLE FuncionarioManutencao (
  FuncionarioNif     number(9) NOT NULL, 
  TelefoneManutencao number(9) NOT NULL, 
  NifResponsavel     number(10), 
  PRIMARY KEY (FuncionarioNif));
CREATE TABLE Pagamento (
  Id                number(2) NOT NULL, 
  "Date"            number(10) NOT NULL, 
  TipoPagamentoTipo number(2) NOT NULL, 
  FaturaId          number(2) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE TipoPagamento (
  Tipo      number(2) NOT NULL, 
  Descricao varchar2(10) NOT NULL, 
  PRIMARY KEY (Tipo));
CREATE TABLE IntervencaoLimpeza (
  Id                  number(3) NOT NULL, 
  Data                date NOT NULL, 
  CamareiraNif        number(9) NOT NULL, 
  PedidoIntervencaoId number(3) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE IntervencaoManutencao (
  Id                       number(3) NOT NULL, 
  Data                     date NOT NULL, 
  FuncionarioManutencaoNif number(9) NOT NULL, 
  PedidoIntervencaoId      number(3) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE DespesaFrigobar (
  Data                    date NOT NULL, 
  ContaNumUnico           number(3) NOT NULL, 
  CamareiraFuncionarioNif number(9) NOT NULL, 
  ProdutoId               number(3) NOT NULL);
CREATE TABLE Funcionario (
  Nif      number(9) NOT NULL, 
  Nome     varchar2(30) NOT NULL, 
  Morada   varchar2(100) NOT NULL, 
  Telefone number(9) NOT NULL, 
  Email    varchar2(40) NOT NULL, 
  PRIMARY KEY (Nif));
CREATE TABLE PedidoIntervencao (
  Id             number(3) NOT NULL, 
  ReservaId      number(3) NOT NULL, 
  Estado         varchar2(15), 
  Data           date, 
  FuncionarioNif number(9) NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE Produto (
  Id    number(3) NOT NULL, 
  Nome  varchar2(30) NOT NULL, 
  Tipo  varchar2(10) NOT NULL, 
  Custo number(3), 
  PRIMARY KEY (Id));
ALTER TABLE Quarto ADD CONSTRAINT quartoTipoQuarto FOREIGN KEY (TipoQuartoId) REFERENCES TipoQuarto (Id);
ALTER TABLE Quarto ADD CONSTRAINT quartoNumSeqNumQuarto FOREIGN KEY (NumeroQuartoNumSequencial, NumeroQuartoAndarId) REFERENCES NumeroQuarto (NumSequencial, AndarId);
ALTER TABLE Preco ADD CONSTRAINT precoTipoQuarto FOREIGN KEY (TipoQuartoId) REFERENCES TipoQuarto (Id);
ALTER TABLE Preco ADD CONSTRAINT precoEpocaAno FOREIGN KEY (EpocaAnoId) REFERENCES EpocaAno (Id);
ALTER TABLE Reserva ADD CONSTRAINT reservaNifCliente FOREIGN KEY (ClienteNif) REFERENCES Cliente (Nif);
ALTER TABLE Fatura ADD CONSTRAINT faturaNumUnicoConta FOREIGN KEY (ContaNumUnico) REFERENCES Conta (NumUnico);
ALTER TABLE Fatura ADD CONSTRAINT faturaIdReserva FOREIGN KEY (ReservaId) REFERENCES Reserva (Id);
ALTER TABLE Pagamento ADD CONSTRAINT pagamentoTipoPagamento FOREIGN KEY (TipoPagamentoTipo) REFERENCES TipoPagamento (Tipo);
ALTER TABLE IntervencaoLimpeza ADD CONSTRAINT intervencaoLimpezaNifCamareira FOREIGN KEY (CamareiraNif) REFERENCES Camareira (FuncionarioNif);
ALTER TABLE Reserva ADD CONSTRAINT reservaIdQuarto FOREIGN KEY (QuartoId) REFERENCES Quarto (Id);
ALTER TABLE NumeroQuarto ADD CONSTRAINT numeroQuartoIdAndar FOREIGN KEY (AndarId) REFERENCES Andar (Id);
ALTER TABLE DespesaFrigobar ADD CONSTRAINT despesaFrigobarNumUnicoConta FOREIGN KEY (ContaNumUnico) REFERENCES Conta (NumUnico);
ALTER TABLE Conta ADD CONSTRAINT contaIdReserva FOREIGN KEY (ReservaId) REFERENCES Reserva (Id);
ALTER TABLE Camareira ADD CONSTRAINT camareiraNifFuncionario FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
ALTER TABLE FuncionarioManutencao ADD CONSTRAINT funcionarioManutencaoNifFuncionario FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
ALTER TABLE FuncionarioRestauracao ADD CONSTRAINT funcionarioRestauracaoNifFuncionario FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
ALTER TABLE FuncionarioRececao ADD CONSTRAINT funcionarioRececaoNifFuncionario FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
ALTER TABLE IntervencaoManutencao ADD CONSTRAINT intervencaoManutencaoNifFuncionario FOREIGN KEY (FuncionarioManutencaoNif) REFERENCES FuncionarioManutencao (FuncionarioNif);
ALTER TABLE PedidoIntervencao ADD CONSTRAINT pedidoIntervencaoIdReserva FOREIGN KEY (ReservaId) REFERENCES Reserva (Id);
ALTER TABLE Pagamento ADD CONSTRAINT pagamentoIdFatura FOREIGN KEY (FaturaId) REFERENCES Fatura (Id);
ALTER TABLE IntervencaoManutencao ADD CONSTRAINT intervencaoManutencaoIdPedidoIntervencao FOREIGN KEY (PedidoIntervencaoId) REFERENCES PedidoIntervencao (Id);
ALTER TABLE DespesaFrigobar ADD CONSTRAINT despesaFrigobarIdProduto FOREIGN KEY (ProdutoId) REFERENCES Produto (Id);
ALTER TABLE IntervencaoLimpeza ADD CONSTRAINT intervencaoLimpezaIdPedidoIntervencao FOREIGN KEY (PedidoIntervencaoId) REFERENCES PedidoIntervencao (Id);
ALTER TABLE DespesaFrigobar ADD CONSTRAINT despesaFrigobarNifCamareira FOREIGN KEY (CamareiraFuncionarioNif) REFERENCES Camareira (FuncionarioNif);
ALTER TABLE PedidoIntervencao ADD CONSTRAINT FKPedidoInte425898 FOREIGN KEY (FuncionarioNif) REFERENCES Funcionario (Nif);
