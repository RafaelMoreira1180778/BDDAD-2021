--(a) Apresentar todos os pedidos de interven��o em aberto (interven��o ainda n�o registada) alocados a funcion�rios
-- de manuten��o que n�o fizeram nenhuma interven��o (registo) nas �ltimas 48 horas;

SELECT *
FROM PEDIDOINTERVENCAO pi
WHERE (SELECT FUNCIONARIOMANUTENCAONIF FROM INTERVENCAOMANUTENCAO im WHERE pi.FUNCIONARIONIF = im.FUNCIONARIOMANUTENCAONIF);

--(b) Apresentar a data, a hora e o nome dos clientes que reservaram quartos somente durante o m�s de Abril e Junho deste ano. No caso de algum
-- cliente ter reservado um quarto do tipo suite, dever� apresentar a localidade desse cliente numa coluna intitulada �Zona do Pa�s�. O resultado
-- dever� ser apresentado por ordem alfab�tica do nome de cliente e por ordem descendente da data e hora da reserva.

