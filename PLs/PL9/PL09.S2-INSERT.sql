-- ** inserir dados nas tabelas **

-- tabela Editora 
INSERT INTO editora(idEditora, nome)
VALUES (1, 'BMG');
INSERT INTO editora(idEditora, nome)
VALUES (2, '4AD');
INSERT INTO editora(idEditora, nome)
VALUES (3, 'Polydor');
INSERT INTO editora(idEditora, nome)
VALUES (4, 'Universal Music');
INSERT INTO editora(idEditora, nome)
VALUES (5, 'Warner Music');
INSERT INTO editora(idEditora, nome)
VALUES (6, 'Island Records');
INSERT INTO editora(idEditora, nome)
VALUES (7, 'Parlaphone');
INSERT INTO editora(idEditora, nome)
VALUES (8, 'ADF');
INSERT INTO editora(idEditora, nome)
VALUES (9, 'Valentim de Carvalho');

-- tabela CD
INSERT INTO cd(codCd, idEditora, titulo, dataCompra, valorPago, localCompra)
VALUES (1, 8, 'Punkzilla', TO_DATE('22/04/2011', 'DD/MM/YY'), 55.00, 'FNAC');
INSERT INTO cd(codCd, idEditora, titulo, dataCompra, valorPago, localCompra)
VALUES (2, 1, 'Classic Duets', TO_DATE('21/05/2017', 'DD/MM/YY'), 30.50, 'Worten');
INSERT INTO cd(codCd, idEditora, titulo, dataCompra, valorPago, localCompra)
VALUES (3, 7, 'The Wall', TO_DATE('22/04/2011', 'DD/MM/YY'), 25.80, 'FNAC');
INSERT INTO cd(codCd, idEditora, titulo, dataCompra, valorPago, localCompra)
VALUES (4, 1, 'Hits 4', TO_DATE('10/09/2017', 'DD/MM/YY'), 42.30, 'Worten');
INSERT INTO cd(codCd, idEditora, titulo, dataCompra, valorPago, localCompra)
VALUES (5, 6, 'Songs of Experience', TO_DATE('01/01/2018', 'DD/MM/YY'), 10.99, NULL);
INSERT INTO cd(codCd, idEditora, titulo, dataCompra, valorPago, localCompra)
VALUES (6, 5, 'Giesta 2', TO_DATE('15/06/2017', 'DD/MM/YY'), 9.10, NULL);
INSERT INTO cd(codCd, idEditora, titulo, dataCompra, valorPago, localCompra)
VALUES (7, 4, 'O Mundo ao Contrário', TO_DATE('01/01/2004', 'DD/MM/YY'), 12.90, 'FNAC');
INSERT INTO cd(codCd, idEditora, titulo, dataCompra, valorPago, localCompra)
VALUES (8, 3, 'Born to Die', TO_DATE('27/01/2012', 'DD/MM/YY'), 9.90, 'iTunes');

-- tabela Musica
--CD 1
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (1, 1, 'Dream of Waking', 'AFI', 3.05);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (2, 1, 'Still', 'Rufio', 3.02);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (3, 1, 'Behind the Music', 'The Vandals', 2.41);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (4, 1, 'Why Are You Alive', 'The Vandals', 2.34);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (5, 1, 'Vandals', 'The Vandals', 4.01);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (6, 1, 'Days of the Phoenix', 'AFI', 3.28);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (7, 1, 'Wester', 'AFI', 3.02);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (8, 1, 'Blue Jeans', 'Lana Del Rey', 3.29);
--CD 2
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (1, 2, 'Bizet: Les pécheurs de perles...', 'Orquestra Filarmónica Real', 5.24);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (2, 2, 'Verdi: Otello/Act 2', 'Orquestra Sinfónica Chicago', 6.47);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (3, 2, 'Verdi: Aida/Act 4', 'Loring Maazel', 4.38);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (4, 2, 'Puccini: Turandot', 'Zubin Mehta', 3.08);
--CD 3
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (1, 3, 'In the Flesh', 'Pink Floyd', 3.02);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (2, 3, 'The Thin Lee', 'Pink Floyd', 2.30);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (3, 3, 'Mother', 'Pink Floyd', 5.34);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (4, 3, 'Don''t Leave Me Now', 'Pink Floyd', 4.21);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (5, 3, 'Young Lust', 'Pink Floyd', 3.19);
--CD 4
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (1, 4, 'It''s Alright(Baby''s Coming Back)', 'Eurythmics', 3.05);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (2, 4, 'Hounds of Love', 'Kate Bush', 3.02);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (3, 4, 'Calling America', 'Electric Light Orchestra', 2.41);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (4, 4, 'Suspicious Minds', 'Fine Young Cannibals', 2.34);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (5, 4, 'I''m Your Man', 'Wham!', 3.28);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (6, 4, 'Blue Jeans', 'Lana Del Rey', 3.29);
--CD 5
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (1, 5, 'Love is All We Have Left', 'U2', 2.41);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (2, 5, 'Lights of Home', 'U2', 4.16);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (3, 5, 'You''re the Best Thing About Me', 'U2', 3.45);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (4, 5, 'Get Out of Your Own Way', 'U2', 3.58);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (5, 5, 'American Soul', 'U2', 4.21);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (6, 5, 'Summer of Love', 'U2', 3.24);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (7, 5, 'Red Flag Day', 'U2', 3.19);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (8, 5, 'The Showman', 'U2', 3.23);
--CD 6
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (1, 6, 'Valsa em Espiral', 'Miguel Araújo', 3.34);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (2, 6, '1987', 'Miguel Araújo', 4.12);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (3, 6, 'Meio Conto', 'Miguel Araújo', 3.13);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (4, 6, 'Via Norte', 'Miguel Araújo', 3.35);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (5, 6, 'Sangemil', 'Miguel Araújo', 4.03);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (6, 6, 'Lurdes Valsa Lenta', 'Miguel Araújo', 4.41);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (7, 6, 'Axl Rose', 'Miguel Araújo', 5.03);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (8, 6, '20% Mais', 'Miguel Araújo', 1.20);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (9, 6, 'Vândalo', 'Miguel Araújo', 4.45);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (10, 6, 'Aqui Dali', 'Miguel Araújo', 4.45);
--CD 7
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (1, 7, 'Desejo', 'Xutos e Pontapés', 3.25);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (2, 7, 'Diz-me', 'Xutos e Pontapés', 4.37);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (3, 7, 'Ai Se Ele Cai', 'Xutos e Pontapés', 3.12);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (4, 7, 'Pequeno Pormenor', 'Xutos e Pontapés', 2.58);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (5, 7, 'Zona Limite', 'Xutos e Pontapés', 3.27);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (6, 7, 'Fim de Semana', 'Xutos e Pontapés', 5.27);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (7, 7, 'Gota a Gota', 'Xutos e Pontapés', 2.35);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (8, 7, 'Teimosia', 'Xutos e Pontapés', 4.13);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (9, 7, 'O Mundo ao Contrário', 'Xutos e Pontapés', 4.18);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (10, 7, 'Sombra Colorida', 'Xutos e Pontapés', 2.38);
--CD 8
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (1, 8, 'Born to Die', 'Lana Del Rey', 4.46);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (2, 8, 'Off the Races', 'Lana Del Rey', 4.59);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (3, 8, 'Blue Jeans', 'Lana Del Rey', 3.29);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (4, 8, 'Video Games', 'Lana Del Rey', 4.41);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (5, 8, 'Diet Mountain Dew', 'Lana Del Rey', 3.42);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (6, 8, 'National Anthen', 'Lana Del Rey', 3.50);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (7, 8, 'Dark Paradise', 'Lana Del Rey', 4.03);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (8, 8, 'Radio', 'Lana Del Rey', 3.34);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (9, 8, 'Carmen', 'Lana Del Rey', 4.08);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (10, 8, 'Million Dollar Man', 'Lana Del Rey', 3.50);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (11, 8, 'Summertime Sadness', 'Lana Del Rey', 4.24);
INSERT INTO musica(nrMusica, codCd, titulo, interprete, duracao)
VALUES (12, 8, 'This Is What Make Us Girls', 'Lana Del Rey', 4.00);

-- ** guardar em DEFINITIVO as alterações na base de dados, se a opção Autocommit do SQL Developer não estiver ativada **
-- COMMIT;
