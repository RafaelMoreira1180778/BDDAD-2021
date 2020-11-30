-- ** alterar tabelas, adicionando campos **

-- ## Tabela Revisao ##

--1)    Eliminar a restrição de chave primária natural da tabela Revisao; 
ALTER TABLE revisao
    DROP CONSTRAINT pkRevisaoMatriculaDataHoraMarcacao;

--2)    Adicionar o novo campo idRevisao para armazenar valores inteiros positivos gerados automaticamente (auto-incrementados); 
ALTER TABLE revisao
    ADD idRevisao INTEGER GENERATED AS IDENTITY;

--3)    Especificar o novo campo idRevisao como chave primária artificial;
ALTER TABLE revisao
    ADD CONSTRAINT pkRevisaoNrRevisao PRIMARY KEY (idRevisao);

--4)    Adicionar um registo com a mesma matricula e a data_hora_marcacao de outro registo;
INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES ('42-90-AS', TO_TIMESTAMP('2018/10/23 10:50:00', 'yyyy/mm/dd hh24:mi:ss'));

--5)    Verificar a presença do novo registo na tabela, violando a referida correspondência unívoca entre as chaves primárias, 
--      natural e artificial;
SELECT *
FROM revisao
ORDER BY matricula;

--6)    Eliminar o registo adicionado anteriormente.
DELETE
FROM revisao
WHERE idRevisao = 8;

--7)	Resolver o problema indicado na alínea 5, adicionando uma restrição que garanta combinações únicas dos campos matricula 
--      e dataHoraMarcacao;
ALTER TABLE revisao
    ADD CONSTRAINT ukRevisaoMatriculaDataHoraMarcacao UNIQUE (matricula, dataHoraMarcacao);

--8)	Testar a nova restrição imposta, repetindo a alínea 4;

--9)	Adicionar dois registos, um com valor NULL no campo matricula e outro com valor NULL no campo dataHoraMarcacao;
INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES (NULL, TO_TIMESTAMP('2018/10/23 10:50:00', 'yyyy/mm/dd hh24:mi:ss'));

INSERT INTO revisao(matricula, dataHoraMarcacao)
VALUES ('42-90-AS', NULL);

--10)	Verificar que os dois registos foram adicionados à tabela, violando a chave primária natural;
SELECT *
FROM revisao
ORDER BY matricula;

--11)	Resolver o problema verificado, começando por eliminar os dois registos adicionados;
DELETE
FROM revisao
WHERE DATAHORAMARCACAO is NULL
   OR MATRICULA is NULL;

--12)	Alterar novamente a tabela de modo a impedir o valor NULL nos campos matricula e dataHoraMarcacao;
ALTER TABLE revisao
    MODIFY matricula CONSTRAINT nnRevisaoMatricula NOT NULL;
/* a completar */

--13)	Repetir o passo 9 para verificar a resolução do problema com o NULL na chave primária natural.


-- ** guardar em DEFINITIVO as alterações na base de dados, se a opção Autocommit do SQL Developer não estiver ativada **
-- COMMIT;
