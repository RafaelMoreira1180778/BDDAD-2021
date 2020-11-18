--(a) Apresentar todos os pedidos de intervenção em aberto (intervenção ainda não registada) alocados a funcionários
-- de manutenção que não fizeram nenhuma intervenção (registo) nas últimas 48 horas;

SELECT *
FROM PEDIDOINTERVENCAO pi
WHERE (SELECT FUNCIONARIOMANUTENCAONIF FROM INTERVENCAOMANUTENCAO im WHERE pi.FUNCIONARIONIF = im.FUNCIONARIOMANUTENCAONIF);

--(b) Apresentar a data, a hora e o nome dos clientes que reservaram quartos somente durante o mês de Abril e Junho deste ano. No caso de algum
-- cliente ter reservado um quarto do tipo suite, deverá apresentar a localidade desse cliente numa coluna intitulada “Zona do País”. O resultado
-- deverá ser apresentado por ordem alfabética do nome de cliente e por ordem descendente da data e hora da reserva.

