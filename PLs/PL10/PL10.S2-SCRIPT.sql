--1A
SELECT idMarinheiro, nome, classificacao
FROM Marinheiro
WHERE classificacao = (SELECT MAX(classificacao) from Marinheiro);


--1B
SELECT M1.idmarinheiro, M1.nome, M1.classificacao
FROM marinheiro M1
WHERE M1.classificacao IN (SELECT DISTINCT M2.classificacao
                           FROM marinheiro M2
                           ORDER BY 1 DESC
                               FETCH FIRST 1 ROWS ONLY)
ORDER BY M1.nome;

--1C
SELECT idMarinheiro, nome, classificacao
FROM marinheiro
         CROSS JOIN (SELECT MAX(classificacao) maximo FROM marinheiro)
WHERE classificacao = maximo;

--2A
SELECT IDMARINHEIRO,
       NOME,
       CLASSIFICACAO,
       CASE
           WHEN CLASSIFICACAO > (SELECT AVG(CLASSIFICACAO) FROM MARINHEIRO) THEN 'Superior à média'
           END AS OBS
FROM MARINHEIRO;

--2B
With mediaMarinheiro as (SELECT AVG(CLASSIFICACAO) AS MEDIA FROM MARINHEIRO)
SELECT IDMARINHEIRO,
       NOME,
       CLASSIFICACAO,
       CASE
           WHEN CLASSIFICACAO > (SELECT mediaMarinheiro.MEDIA from mediaMarinheiro) THEN 'Superior à média'
           END AS OBS
FROM MARINHEIRO;

--3A
SELECT M.idMarinheiro, M.nome
FROM marinheiro M
WHERE M.idMarinheiro NOT IN (SELECT R.idMarinheiro
                             FROM reserva R)
ORDER BY M.idMarinheiro;

--3B
SELECT M.idMarinheiro, M.nome
FROM marinheiro M
WHERE M.idMarinheiro <> ANY (SELECT R.idMarinheiro
                             FROM reserva R)
ORDER BY M.idMarinheiro;

--3C
Select m.idmarinheiro, m.nome
from marinheiro m
minus
select m.idmarinheiro, m.nome
from marinheiro m
         inner join reserva r on r.idmarinheiro = m.idmarinheiro;

--4
SELECT R1.data
FROM reserva R1
GROUP BY R1.data
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM reserva R2
                   GROUP BY R2.data);

--5
SELECT Count(Reserva.idMarinheiro) AS QTD_MARINHEIRO
FROM Reserva
         INNER JOIN Barco ON Reserva.idBarco = Barco.idBarco
WHERE cor = 'verde'
  AND Reserva.idMarinheiro IN (SELECT Reserva.idMarinheiro
                               FROM Reserva
                                        INNER JOIN Barco ON Reserva.idBarco = Barco.idBarco
                               where cor = 'vermelho');