CREATE OR REPLACE FUNCTION FNCGETQUARTORESERVA(ID_RESERVA_PARAM NUMBER) RETURN NUMBER
AS
    DATA_RESERVA       DATE;
    ESTADO_RESERVA     NUMBER;
    C_TODOSQUARTOS     SYS_REFCURSOR;
    AUX_ID             NUMBER;
    TIPOQUARTO_RESERVA NUMBER;
BEGIN

    -- CONDICOES PARA VERIFICAR SE O PARAMETRO INTRODUZIDO E VALIDO
    IF ID_RESERVA_PARAM IS NULL THEN
        RETURN NULL;
    END IF;

    -- INICIA O VALOR DO ESTADO DE RESERVA A 0 PARA VERIFICAR SE EXISTE RESERVA
    ESTADO_RESERVA := 0;

    -- VAI COLOCAR DENTRO DAS VARIAVEIS DATA_RESERVA E ESTADO_RESERVA A DATA DA RESERVA A PROCURAR E O ID DO ESTADO
    -- DA MESMA CASO ELA EXISTA, SENAO O VALOR ESTADO_RESERVA FICA A 0
    SELECT R.DATA_ENTRADA, R.ID_ESTADO_RESERVA, R.ID_TIPO_QUARTO
    INTO DATA_RESERVA, ESTADO_RESERVA, TIPOQUARTO_RESERVA
    FROM RESERVA R
    WHERE R.ID = ID_RESERVA_PARAM;

    IF ESTADO_RESERVA = 2 OR ESTADO_RESERVA = 3 OR ESTADO_RESERVA = 4 OR ESTADO_RESERVA = 5 THEN
        RETURN NULL;
    ELSIF ESTADO_RESERVA = 0 THEN
        RETURN NULL;
    END IF;

    -- VAI COLOCAR NO CURSOR, POR ORDEM, TODOS OS QUARTOS QUE RESPEITAM A CONDIÇÃO DE ESTAREM NUM ANDAR MAIS BAIXO E
    -- TEREM MENOS DIAS DE OCUPAÇÃO
    OPEN C_TODOSQUARTOS FOR
        SELECT Q.ID
        FROM QUARTO Q
                 JOIN CHECKIN CI ON Q.ID = CI.ID_QUARTO
                 JOIN RESERVA R ON CI.ID_RESERVA = R.ID
        WHERE Q.ID_TIPO_QUARTO = TIPOQUARTO_RESERVA
        GROUP BY Q.ID, Q.ID_ANDAR
        ORDER BY Q.ID_ANDAR, COUNT(R.DATA_SAIDA - R.DATA_ENTRADA);

    -- VAI ITERAR O CURSOR E, PARA CADA QUARTO (UMA VEZ QUE ESTÁ POR ORDEM) VAI VERIFICAR SE ESSE SE ENCONTRA
    -- DISPONÍVEL NA DATA DA RESERVA, CASO ESTEJA RETORNA ESSE QUARTO, SENÃO RETORNA NULL
    LOOP
        FETCH C_TODOSQUARTOS INTO AUX_ID;
        IF NOT ISQUARTOINDISPONIVEL(AUX_ID, DATA_RESERVA) THEN
            RETURN AUX_ID;
        END IF;
        EXIT WHEN C_TODOSQUARTOS%NOTFOUND;
    END LOOP;

    RETURN NULL;
END;

COMMIT;

-- TEST
BEGIN
    -- EXPECTAVEL QUARTO COM ID 5
    DBMS_OUTPUT.PUT_LINE('QUARTO A ALOCAR PARA A RESERVA COM ID 1: ' || FNCGETQUARTORESERVA(1));

    -- EXPECTAVEL NENHUM QUARTO
    DBMS_OUTPUT.PUT_LINE('QUARTO A ALOCAR PARA A RESERVA COM ID 50: ' || FNCGETQUARTORESERVA(50));

    -- EXPECTAVEL QUARTO COM ID 19
    DBMS_OUTPUT.PUT_LINE('QUARTO A ALOCAR PARA A RESERVA COM ID 27: ' || FNCGETQUARTORESERVA(27));

    -- EPECTAVEL QUARTO COM ID 14
    DBMS_OUTPUT.PUT_LINE('QUARTO A ALOCAR PARA A RESERVA COM ID 31: ' || FNCGETQUARTORESERVA(31));

    DBMS_OUTPUT.PUT_LINE('QUARTO A ALOCAR PARA A RESERVA COM ID 31: ' || FNCGETQUARTORESERVA(NULL));
END;