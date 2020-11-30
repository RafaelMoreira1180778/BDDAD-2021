-- ** inserir dados inválidos **

--A.	Tabela Automovel
--1)	Registos com matrícula com formato inválido;
INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('av-23-27', 'Renault', 1100, 2009, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('23-av-27', 'Renault', 1100, 2009, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('23-28-av', 'Renault', 1100, 2009, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('23-bv-av', 'Renault', 1100, 2009, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)   
VALUES('cv-bv-av', 'Renault', 1100, 2009, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)   
VALUES('23-45-Av', 'Renault', 1100, 2009, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)   
VALUES('23-78-aV', 'Renault', 1100, 2009, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('23-28-94', 'Renault', 1100, 2009, 35600);

--2)	Registo com matrícula (chave primária) existente na tabela;
INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('45-PD-98', 'BMW', 2100, 2014, 35600);

--3)	Registo com matrícula NULL;
INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES(NULL, 'BMW', 2100, 2014, 35600);

--alternativa
INSERT INTO automovel(marca, cilindrada, anoFabrico, precoVenda)             
VALUES('BMW', 2100, 2014, 35600);

--4)	Registo com marca NULL;
INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('93-SC-27', null, 2100, 2014, 35600);

--alternativa                                                                   
INSERT INTO automovel(matricula, cilindrada, anoFabrico, precoVenda)        
VALUES('93-SC-27', 2100, 2014, 35600);

--5)	Registos com cilindrada inválida;
INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('93-SC-27', 'BMW', 999, 2014, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('93-SC-27', 'BMW', 6001, 2014, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('93-SC-27', 'BMW', -2001, 2014, 35600);

--6)	Registos com anoFabrico inválidos;
INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('93-SC-27', 'BMW', 2100, 1999, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('93-SC-27', 'BMW', 2100, 2022, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('93-SC-27', 'BMW', 2100, -2003, 35600);

--7)	Registos com precoVenda inválido.
INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('93-SC-27', 'BMW', 2100, 2014, -10000.00);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES('93-SC-27', 'BMW', 2100, 2014, 1234567890.5);

--B.	Tabela Cliente
--1)	Registo com um idCliente inexistente na tabela; 
INSERT INTO cliente(idCliente, nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES(10, 'Jorge Jesus', 870598, 105727913, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

--2)	Registo com idCliente (chave primária) NULL;
INSERT INTO cliente(idCliente, nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES(NULL, 'Jorge Jesus', 890146, 107559369, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

--3)	Registo com nome NULL;
INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES(NULL, 890146, 107559369, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

--4)	Registo com nrIdentificacaoCivil existente na tabela. 
--      Notar que esta situação ocorre sempre com campos UNIQUE;
INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', 937587, 107559369, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

--5)	Registo(s) com nrIdentificacaoCivil inválido, excluindo o caso da alínea anterior;
INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', 89014, 107559369, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', -890146, 107559369, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

--6)	Registo com nif existente na tabela;
INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', 987345, 107559369, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

--7)	Registo com nif NULL;
INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', 890146, NULL, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

--8)	Registo(s) com nif inválido, excluindo os casos das duas alíneas anteriores;
INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', 890146, -107559369, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', 890146, 10755936, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', 890146, 1075593692, TO_DATE('1954-06-24', 'yyyy-mm-dd'));

--9)	Registo(s) com dataNascimento inválida.
INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', 890146, 1075593692, TO_DATE('1954-16-24', 'yyyy-mm-dd'));

INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES('Jorge Jesus', 890146, 1075593692, TO_DATE('1954-02-30', 'yyyy-mm-dd'));     

--C.	Tabela AutomovelCliente
--1)	Registo com chave primária existente na tabela;
INSERT INTO automovelCliente(matricula, idCliente)
VALUES('65-GR-87', 1);

--2)	Registos com campo(s) NULL;
INSERT INTO automovelCliente(matricula, idCliente)
VALUES(NULL, 1);

INSERT INTO automovelCliente(matricula, idCliente)
VALUES('65-GR-87', NULL);

INSERT INTO automovelCliente(matricula, idCliente)
VALUES(NULL, NULL);

--3)	Registo(s) com idCliente ou matricula inexistente na tabela Cliente ou Automovel, respetivamente. 
--      Notar que esta situação ocorre sempre com chaves estrangeiras.
INSERT INTO automovelCliente(matricula, idCliente)
VALUES('65-GR-87', 8);

INSERT INTO automovelCliente(matricula, idCliente)
VALUES('75-GR-87', 2);

--D.	Tabela Revisao
--1)	Registo com chave primária existente na tabela;
INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES('42-90-AS', TO_TIMESTAMP('2018-10-23 10:50:00', 'yyyy-mm-dd hh24:mi:ss'));

--2)	Registos com campo(s) NULL na chave primária;
INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES(NULL, TO_TIMESTAMP('2018-10-23 10:50:00', 'yyyy-mm-dd hh24:mi:ss'));

INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES('42-90-AS', NULL);

INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES(NULL, NULL);

--3)	Registo com matricula inexistente na tabela Automoveis; 
INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES('28-90-AS', TO_TIMESTAMP('2020-10-23 10:50:00', 'yyyy-mm-dd hh24:mi:ss'));

--4)	Registos com o campo efetuada diferente de S e N, em maiúsculas e minúsculas;
INSERT INTO revisao(matricula, dataHoraMarcacao, efetuada)
VALUES('42-90-AS', TO_TIMESTAMP('2007-10-23 10:50:00', 'yyyy-mm-dd hh24:mi:ss'), 'x');

INSERT INTO revisao(matricula, dataHoraMarcacao, efetuada)
VALUES('42-90-AS', TO_TIMESTAMP('2007-10-23 10:50:00', 'yyyy-mm-dd hh24:mi:ss'), 'X');

--5)	Registo com o campo efetuada com valor NULL.
INSERT INTO revisao(matricula, dataHoraMarcacao, efetuada)
VALUES('42-90-AS', TO_TIMESTAMP('2007-10-23 10:50:00', 'yyyy-mm-dd hh24:mi:ss'), NULL);
