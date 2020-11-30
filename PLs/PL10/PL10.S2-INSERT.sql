-- ** inserir dados nas tabelas **

-- ## tabela Marinheiro ##
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (22, 'Dustin', 7, TO_DATE('1975-09-13', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (29, 'Brutus', 1, TO_DATE('1987-06-02', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (31, 'Lubber', 8, TO_DATE('1965-03-17', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (32, 'Andy', 8, TO_DATE('1995-01-01', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (58, 'Rusty', 10, TO_DATE('1985-07-02', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (64, 'Horácio', 7, TO_DATE('1985-03-17', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (71, 'Zorba', 10, TO_DATE('2004-02-19', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (74, 'Horácio', 9, TO_DATE('1985-02-22', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (85, 'Art', 3, TO_DATE('1995-09-05', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (95, 'Bob', 3, TO_DATE('1957-08-12', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (13, 'Popeye', 3, TO_DATE('1998-06-23', 'yyyy-mm-dd'));
INSERT INTO marinheiro(idMarinheiro, nome, classificacao, dataNascimento)
VALUES (44, 'Haddock', 3, TO_DATE('1957-05-31', 'yyyy-mm-dd'));

-- ## tabela Barco ##
INSERT INTO barco(idBarco, designacao, cor)
VALUES (101, 'Interlake', 'azul');
INSERT INTO barco(idBarco, designacao, cor)
VALUES (102, 'Interlake', 'vermelho');
INSERT INTO barco(idBarco, designacao, cor)
VALUES (103, 'Clipper', 'verde');
INSERT INTO barco(idBarco, designacao, cor)
VALUES (104, 'Marine', 'vermelho');

-- ## tabela Reserva ##
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (22, 101, TO_DATE('2019/10/10', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (22, 102, TO_DATE('2019/10/10', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (22, 103, TO_DATE('2019/08/10', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (22, 104, TO_DATE('2019/07/10', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (31, 102, TO_DATE('2019/10/11', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (31, 103, TO_DATE('2019/06/11', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (31, 104, TO_DATE('2019/12/11', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (64, 101, TO_DATE('2019/05/09', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (64, 102, TO_DATE('2019/08/09', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (64, 102, TO_DATE('2019/09/09', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (64, 102, TO_DATE('2019/10/09', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (74, 103, TO_DATE('2019/08/09', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (44, 101, TO_DATE('2020/05/09', 'yyyy/mm/dd'));
INSERT INTO reserva(idMarinheiro, idBarco, data)
VALUES (44, 101, TO_DATE('2020/09/09', 'yyyy/mm/dd'));

-- ** guardar em DEFINITIVO as alterações na base de dados, se a opção Autocommit do SQL Developer não estiver ativada **
-- COMMIT;