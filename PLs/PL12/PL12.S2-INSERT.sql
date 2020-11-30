-- ** inserir dados nas tabelas **

-- ## tabela CodigoPostal ##
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('2580-631', 'Alenquer');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('2720-465', 'Alverca');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4600-012', 'Amarante');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4750-264', 'Barcelos');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('2750-040', 'Cascais');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4445-622', 'Ermesinde');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4420-584', 'Gondomar');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4420-282', 'Gondomar');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('1500-103', 'Lisboa');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('1099-052', 'Lisboa');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('1070-204', 'Lisboa');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4470-208', 'Maia');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4450-718', 'Matosinhos');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4450-227', 'Matosinhos');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4454-510', 'Matosinhos');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('2781-902', 'Oeiras');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4200-197', 'Porto');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4100-079', 'Porto');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4100-217', 'Porto');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4200-058', 'Porto');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4150-706', 'Porto');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4350-043', 'Porto');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4050-078', 'Porto');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4490-567', 'P�voa do Varzim');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4460-393', 'Senhora da Hora');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4440-501', 'Valongo');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4481-908', 'Vila do Conde');
INSERT INTO codigoPostal(codPostal, localidade)
VALUES ('4400-356', 'Vila Nova de Gaia');

-- ## tabela Especialidade ##
INSERT INTO especialidade(idEspecialidade, designacao)
VALUES (1, 'Pediatria');
INSERT INTO especialidade(idEspecialidade, designacao)
VALUES (2, 'Cardiologia');
INSERT INTO especialidade(idEspecialidade, designacao)
VALUES (3, 'Oftalmologia');
INSERT INTO especialidade(idEspecialidade, designacao)
VALUES (4, 'Dermotologia');

-- ## tabela Paciente ##
INSERT INTO paciente(idPaciente, nome, dataNascimento, codPostal)
VALUES (1, 'Alfredo Gama', TO_DATE('12-08-2003', 'dd-mm-yyyy'), '4454-510');
INSERT INTO paciente(idPaciente, nome, dataNascimento, codPostal)
VALUES (2, 'Cec�lia Mendes', TO_DATE('31-10-2007', 'dd-mm-yyyy'), '4460-393');
INSERT INTO paciente(idPaciente, nome, dataNascimento, codPostal)
VALUES (3, 'Carolina Santos', TO_DATE('26-05-2013', 'dd-mm-yyyy'), '4460-393');
INSERT INTO paciente(idPaciente, nome, dataNascimento, codPostal)
VALUES (4, 'Daniela Seabra', TO_DATE('05-06-2013', 'dd-mm-yyyy'), '4454-510');
INSERT INTO paciente(idPaciente, nome, dataNascimento, codPostal)
VALUES (5, 'Laura Barbosa', TO_DATE('07-07-2000', 'dd-mm-yyyy'), '2750-040');
INSERT INTO paciente(idPaciente, nome, dataNascimento, codPostal)
VALUES (6, 'Paulo Barbosa', TO_DATE('13-02-1953', 'dd-mm-yyyy'), '4460-393');
INSERT INTO paciente(idPaciente, nome, dataNascimento, codPostal)
VALUES (7, 'Judite Matos', TO_DATE('23-08-1961', 'dd-mm-yyyy'), '4450-227');

-- ## tabela Medico ##
-- ** m�dicos chefe **
-- *** Hospital Pedro Hispano ***
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (1, 2, NULL, 'Abel Santos', 'Pedro Hispano', TO_DATE('05-09-1973', 'dd-mm-yyyy'), '4200-197');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (2, 1, NULL, 'Adriana Sousa', 'Pedro Hispano', TO_DATE('23-03-1970', 'dd-mm-yyyy'), '4481-908');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (3, 4, NULL, 'Adriano Reis', 'Pedro Hispano', TO_DATE('07-07-1963', 'dd-mm-yyyy'), '4445-622');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (4, 3, NULL, 'Carla Dias', 'Pedro Hispano', TO_DATE('28-02-1960', 'dd-mm-yyyy'), '4460-393');
-- *** Hospital Santa Maria ***
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (5, 2, NULL, 'Ant�nio Coelho', 'Santa Maria', TO_DATE('02-02-1976', 'dd-mm-yyyy'), '1500-103');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (6, 1, NULL, 'Alvaro Dunas', 'Santa Maria', TO_DATE('15-06-1970', 'dd-mm-yyyy'), '1099-052');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (7, 4, NULL, 'Manuela Silva', 'Santa Maria', TO_DATE('01-01-1958', 'dd-mm-yyyy'), '1070-204');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (8, 3, NULL, 'Ant�nio Oliveira', 'Santa Maria', TO_DATE('16-04-1956', 'dd-mm-yyyy'), '2580-631');
-- *** Hospital Santo Ant�nio ***
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (9, 2, NULL, 'Catarina Dolores', 'Santo Ant�nio', TO_DATE('09-11-1954', 'dd-mm-yyyy'), '4100-079');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (10, 1, NULL, 'Benjamim Mateus', 'Santo Ant�nio', TO_DATE('12-12-1958', 'dd-mm-yyyy'), '4100-217');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (11, 4, NULL, 'Francisco Cardoso', 'Santo Ant�nio', TO_DATE('11-09-1958', 'dd-mm-yyyy'), '4450-718');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (12, 3, NULL, 'D�bora Brand�o', 'Santo Ant�nio', TO_DATE('05-06-1961', 'dd-mm-yyyy'), '4420-584');
-- *** Hospital S�o Jo�o ***
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (13, 2, NULL, 'Am�lia Silva', 'S�o Jo�o', TO_DATE('17-05-1968', 'dd-mm-yyyy'), '4150-706');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (15, 4, NULL, 'Marcos Marcelo', 'S�o Jo�o', TO_DATE('28-05-1961', 'dd-mm-yyyy'), '4350-043');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (16, 3, NULL, 'Nicolau Vieira', 'S�o Jo�o', TO_DATE('11-09-1968', 'dd-mm-yyyy'), '4600-012');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (26, 2, 13, 'Angelo Rodrigo', 'S�o Jo�o', TO_DATE('02-02-1973', 'dd-mm-yyyy'), '4420-282');

-- ** m�dicos n�o-chefe **
-- *** Hospital Pedro Hispano ***
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (17, 2, 1, 'Ana Moura', 'Pedro Hispano', TO_DATE('13-08-1985', 'dd-mm-yyyy'), '4454-510');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (18, 1, 2, 'Artur Rocha', 'Pedro Hispano', TO_DATE('25-01-1978', 'dd-mm-yyyy'), '4490-567');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (19, 4, 3, 'Cl�udia Martins', 'Pedro Hispano', TO_DATE('17-05-1968', 'dd-mm-yyyy'), '4400-356');
-- *** Hospital Santa Maria ***
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (20, 2, 5, 'Carina Pinto', 'Santa Maria', TO_DATE('27-08-1980', 'dd-mm-yyyy'), '2750-040');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (21, 4, 7, 'Nelson Vit�ria', 'Santa Maria', TO_DATE('03-09-1961', 'dd-mm-yyyy'), '2781-902');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (22, 3, 8, 'Patr�cia Carvalho', 'Santa Maria', TO_DATE('12-03-1980', 'dd-mm-yyyy'), '2720-465');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (27, 2, 5, 'Fernando Santos', 'Santa Maria', TO_DATE('26-05-1985', 'dd-mm-yyyy'), '2750-040');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (28, 2, 5, 'Marina Costa', 'Santa Maria', TO_DATE('12-12-1983', 'dd-mm-yyyy'), '1070-204');
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (29, 4, 7, 'Rui Antunes', 'Santa Maria', TO_DATE('11-11-1990', 'dd-mm-yyyy'), '1070-204');
-- *** Hospital Santo Ant�nio ***
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (25, 3, 12, 'M�rio Nascimento', 'Santo Ant�nio', TO_DATE('13-03-1968', 'dd-mm-yyyy'), '4440-501');
-- ** Hospital S�o Jo�o **
INSERT INTO medico(idMedico, idEspecialidade, idMedicoChefe, nome, hospital, dataNascimento, codPostal)
VALUES (30, 2, 13, 'Jacinto Almeida', 'S�o Jo�o', TO_DATE('13-05-1987', 'dd-mm-yyyy'), '4490-567');

-- ## tabela Consulta ##
-- ** Paciente Alfredo Gama **
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (1, TO_DATE('25-09-2009 10:10', 'dd-mm-yyyy hh24:mi'), 2, 1);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (2, TO_DATE('03-09-2012 14:30', 'dd-mm-yyyy hh24:mi'), 2, 1);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (3, TO_DATE('12-05-2016 15:00', 'dd-mm-yyyy hh24:mi'), 2, 1);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (4, TO_DATE('23-09-2019 10:30', 'dd-mm-yyyy hh24:mi'), 2, 1);
-- ** Paciente Cec�lia Mendes **
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (5, TO_DATE('08-03-2016 15:30', 'dd-mm-yyyy hh24:mi'), 17, 2);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (6, TO_DATE('23-09-2019 15:30', 'dd-mm-yyyy hh24:mi'), 18, 2);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (7, TO_DATE('28-09-2019 15:30', 'dd-mm-yyyy hh24:mi'), 19, 2);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (8, TO_DATE('25-09-2019 15:30', 'dd-mm-yyyy hh24:mi'), 4, 2);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (9, TO_DATE('07-10-2019 10:30', 'dd-mm-yyyy hh24:mi'), 18, 2);
-- ** Paciente Carolina Santos **
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (10, TO_DATE('15-03-2018 16:30', 'dd-mm-yyyy hh24:mi'), 1, 3);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (11, TO_DATE('10-10-2018 09:30', 'dd-mm-yyyy hh24:mi'), 17, 3);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (12, TO_DATE('10-10-2018 12:30', 'dd-mm-yyyy hh24:mi'), 2, 3);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (13, TO_DATE('10-10-2018 14:00', 'dd-mm-yyyy hh24:mi'), 3, 3);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (14, TO_DATE('11-10-2018 10:00', 'dd-mm-yyyy hh24:mi'), 4, 3);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (15, TO_DATE('12-10-2018 16:30', 'dd-mm-yyyy hh24:mi'), 19, 3);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (16, TO_DATE('07-10-2019 11:30', 'dd-mm-yyyy hh24:mi'), 18, 3);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (17, TO_DATE('07-10-2019 14:00', 'dd-mm-yyyy hh24:mi'), 19, 3);
-- ** Paciente Daniela Seabra **
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (18, TO_DATE('05-05-2018 16:00', 'dd-mm-yyyy hh24:mi'), 1, 4);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (19, TO_DATE('09-10-2018 10:30', 'dd-mm-yyyy hh24:mi'), 1, 4);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (20, TO_DATE('10-10-2018 14:30', 'dd-mm-yyyy hh24:mi'), 2, 4);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (21, TO_DATE('10-10-2018 15:00', 'dd-mm-yyyy hh24:mi'), 3, 4);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (22, TO_DATE('11-10-2018 11:00', 'dd-mm-yyyy hh24:mi'), 4, 4);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (23, TO_DATE('13-10-2018 15:30', 'dd-mm-yyyy hh24:mi'), 19, 4);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (24, TO_DATE('08-10-2019 11:30', 'dd-mm-yyyy hh24:mi'), 18, 4);
-- ** Paciente Laura Barbosa **
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (25, TO_DATE('15-03-2014 16:30', 'dd-mm-yyyy hh24:mi'), 5, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (26, TO_DATE('10-10-2018 09:30', 'dd-mm-yyyy hh24:mi'), 20, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (27, TO_DATE('15-09-2019 16:00', 'dd-mm-yyyy hh24:mi'), 5, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (28, TO_DATE('05-10-2019 09:00', 'dd-mm-yyyy hh24:mi'), 20, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (29, TO_DATE('10-10-2018 12:30', 'dd-mm-yyyy hh24:mi'), 6, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (30, TO_DATE('07-10-2019 11:30', 'dd-mm-yyyy hh24:mi'), 6, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (31, TO_DATE('01-09-2019 14:00', 'dd-mm-yyyy hh24:mi'), 7, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (32, TO_DATE('08-10-2018 16:30', 'dd-mm-yyyy hh24:mi'), 21, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (34, TO_DATE('08-08-2019 12:00', 'dd-mm-yyyy hh24:mi'), 21, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (33, TO_DATE('11-10-2018 10:00', 'dd-mm-yyyy hh24:mi'), 8, 5);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (35, TO_DATE('05-10-2019 14:00', 'dd-mm-yyyy hh24:mi'), 22, 5);
-- ** Paciente Paulo Barbosa **
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (37, TO_DATE('11-11-2010 14:30', 'dd-mm-yyyy hh24:mi'), 13, 6);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (38, TO_DATE('22-08-2015 09:30', 'dd-mm-yyyy hh24:mi'), 15, 6);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (39, TO_DATE('15-04-2016 14:00', 'dd-mm-yyyy hh24:mi'), 13, 6);
-- ** Paciente Judite Matos **
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (40, TO_DATE('15-06-2019 16:00', 'dd-mm-yyyy hh24:mi'), 11, 7);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (41, TO_DATE('15-12-2018 16:00', 'dd-mm-yyyy hh24:mi'), 17, 7);
INSERT INTO consulta(idConsulta, dataHora, idMedico, idPaciente)
VALUES (42, TO_DATE('08-03-2016 18:45', 'dd-mm-yyyy hh24:mi'), 1, 7);

-- ## tabela Medicamento ##
INSERT INTO medicamento(idMedicamento, nome, laboratorio)
VALUES (1, 'Aspirina', 'Bayer');
INSERT INTO medicamento(idMedicamento, nome, laboratorio)
VALUES (2, 'Voltaren', 'Novartis');
INSERT INTO medicamento(idMedicamento, nome, laboratorio)
VALUES (3, 'Aspegic', 'Infarmed');
INSERT INTO medicamento(idMedicamento, nome, laboratorio)
VALUES (4, 'Kompensan', 'Infarmed');
INSERT INTO medicamento(idMedicamento, nome, laboratorio)
VALUES (5, 'Benuron', 'Infarmed');
INSERT INTO medicamento(idMedicamento, nome, laboratorio)
VALUES (6, 'Xanax', 'Pfizer');
INSERT INTO medicamento(idMedicamento, nome, laboratorio)
VALUES (7, 'Risidon', 'Infarmed');

-- ## tabela MedicamentoReceitado ##
-- ** Consulta 1 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (1, 1);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (1, 3);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (1, 2);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (1, 4);
-- ** Consulta 2 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (2, 1);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (2, 4);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (2, 5);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (2, 3);
-- ** Consulta 3 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (3, 1);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (3, 3);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (3, 5);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (3, 4);
-- ** Consulta 4 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (4, 4);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (4, 5);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (4, 7);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (4, 6);
-- ** Consulta 5 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (5, 1);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (5, 2);
-- ** Consulta 6 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (6, 1);
-- ** Consulta 7 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (7, 2);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (7, 3);
-- ** Consulta 9 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (9, 2);
-- ** Consulta 10 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (10, 4);
-- ** Consulta 12 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (12, 1);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (12, 2);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (12, 3);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (12, 4);
-- ** Consulta 16 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (16, 3);
-- ** Consulta 20 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (20, 1);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (20, 2);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (20, 3);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (20, 4);
-- ** Consulta 21 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (21, 1);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (21, 2);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (21, 3);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (21, 4);
-- ** Consulta 22 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (22, 3);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (22, 4);
-- ** Consulta 24 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (24, 2);
-- ** Consulta 25 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (25, 1);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (25, 2);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (25, 3);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (25, 4);
-- ** Consulta 29 **
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (29, 1);
INSERT INTO medicamentoReceitado(idConsulta, idMedicamento)
VALUES (29, 2);

-- ** guardar em DEFINITIVO as altera��es na base de dados, se a op��o Autocommit do SQL Developer n�o estiver ativada **
-- COMMIT;
