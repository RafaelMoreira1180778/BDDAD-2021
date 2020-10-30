-- ** atualizar tabelas **

-- ## Tabela Automovel ##

--1)    Reduzir 20% o preço de venda do automóvel da marca Kia; 
UPDATE automovel SET precoVenda = precoVenda * 0.8 WHERE UPPER(marca) LIKE 'KIA';

--2)    Verificar a atualização do registo da marca Kia;
SELECT * FROM automovel;

--3)    Reduzir 10% o preço de venda dos automóveis com ano de fabrico posterior a 2009; 
UPDATE automovel SET precoVenda = precoVenda * 0.9 WHERE ANOFABRICO > 2009;

--4)    Verificar a atualização de vários registos da tabela automovel;
SELECT * FROM automovel;


-- ** guardar em DEFINITIVO as alterações na base de dados, se a opção Autocommit do SQL Developer não estiver ativada **
-- COMMIT;
