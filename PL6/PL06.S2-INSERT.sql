-- ** inserir dados nas tabelas **

-- ## tabela Automovel ##
DELETE
FROM AUTOMOVEL;

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES ('45-PD-98', 'Mercedes', 2300, 2000, 34050);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES ('65-87-GR', 'Nissan', 1700, 2009, 23490.5);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES ('42-90-AS', 'Kia', 1300, 2008, 20870);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES ('BL-87-23', 'Volkswagen', 1100, 2017, 15600.75);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES ('83-QD-27', 'BMW', 2100, 2014, 35600);

INSERT INTO automovel(matricula, marca, cilindrada, anoFabrico, precoVenda)
VALUES ('XO-65-98', 'Toyota', 2100, 2010, 15940.123456789);

-- ## tabela Cliente ##
DELETE
FROM CLIENTE;

INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES ('Sérgio Conceição', 987345, 105098124, TO_DATE('1974-11-15', 'yyyy-mm-dd'));

INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES ('António Oliveira', 937587, 104052455, TO_DATE('1952-10-06', 'yyyy-mm-dd'));

INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES ('Fernando Santos', NULL, 102000906, TO_DATE('1954-10-10', 'yyyy-mm-dd'));

INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES ('Artur Jorge', 7098428, 100829087, TO_DATE('1946-02-13', 'yyyy-mm-dd'));

INSERT INTO cliente(nome, nrIdentificacaoCivil, nif, dataNascimento)
VALUES ('Jesualdo Ferreira', NULL, 107559969, TO_DATE('1946-05-24', 'yyyy-mm-dd'));

-- ## tabela AutomovelCliente ##
DELETE
FROM AUTOMOVELCLIENTE;

INSERT INTO automovelCliente(matricula, idCliente)
VALUES ('65-87-GR', 1);

INSERT INTO automovelCliente(matricula, idCliente)
VALUES ('83-QD-27', 4);

INSERT INTO automovelCliente(matricula, idCliente)
VALUES ('42-90-AS', 2);

INSERT INTO automovelCliente(matricula, idCliente)
VALUES ('45-PD-98', 1);

INSERT INTO automovelCliente(matricula, idCliente)
VALUES ('XO-65-98', 5);

INSERT INTO automovelCliente(matricula, idCliente)
VALUES ('BL-87-23', 3);

-- ## tabela Revisao ##
DELETE
FROM REVISAO;

INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES ('65-87-GR', TO_TIMESTAMP('2018-10-04 09:00:00', 'yyyy-mm-dd hh24:mi:ss'));

INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES ('83-QD-27', TO_TIMESTAMP('2018-11-04 14:45:00', 'yyyy-mm-dd hh24:mi:ss'));

INSERT INTO revisao(matricula, dataHoraMarcacao, efetuada)
VALUES ('42-90-AS', TO_TIMESTAMP('2018-10-23 10:50:00', 'yyyy-mm-dd hh24:mi:ss'), 'N');

INSERT INTO revisao(matricula, dataHoraMarcacao, efetuada)
VALUES ('XO-65-98', TO_TIMESTAMP('2018-12-01 18:30:00', 'yyyy-mm-dd hh24:mi:ss'), 'n');

INSERT INTO revisao(matricula, dataHoraMarcacao, efetuada)
VALUES ('65-87-GR', TO_TIMESTAMP('2015-06-07 10:50:00', 'yyyy-mm-dd hh24:mi:ss'), 'S');

INSERT INTO revisao(matricula, dataHoraMarcacao, efetuada)
VALUES ('XO-65-98', TO_TIMESTAMP('2016-11-22 12:20:00', 'yyyy-mm-dd hh24:mi:ss'), 'S');

-- ** guardar em DEFINITIVO as alterações na base de dados, se a opção Autocommit do SQL Developer não estiver ativada **
-- COMMIT;