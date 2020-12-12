CREATE OR REPLACE PROCEDURE PRCREGISTARRESERVA(P_TIPOQUARTO NUMBER, P_DATAENTRADA DATE, P_DATASAIDA DATE,
                                               P_NUMPESSOAS NUMBER, P_IDCLIENTE NUMBER, P_NOMECLIENTE VARCHAR,
                                               P_NIF NUMBER, P_TELEFONE NUMBER, P_EMAIL VARCHAR) IS
    AUX_ID_RESERVA NUMBER;
    IDCLIENTE EXCEPTION;
    IDCLIENTE_NOMECLIENTE EXCEPTION;
BEGIN

    -- VAMOS OBTER O ID DA RESERVA MAIS RECENTE E ADICIONAR 1 PARA CRIAR UMA NOVA RESERVA
    SELECT R.ID
    INTO AUX_ID_RESERVA
    FROM RESERVA R
    ORDER BY R.ID DESC FETCH FIRST ROW ONLY;
    AUX_ID_RESERVA := AUX_ID_RESERVA + 1;

    -- VERIFICAMOS O CASO EM QUE O ID DO CLIENTE ESTA PRESENTE E TODOS OS PARAMETROS SAO NULOS
    IF (P_IDCLIENTE IS NOT NULL AND P_NIF IS NULL AND P_TELEFONE IS NULL AND P_EMAIL IS NULL) THEN
        INSERT INTO RESERVA
        VALUES (AUX_ID_RESERVA, P_IDCLIENTE, NULL, NULL, NULL, NULL, P_TIPOQUARTO, SYSDATE,
                P_DATAENTRADA, P_DATASAIDA, P_NUMPESSOAS, NULL, 1, NULL, NULL);

        -- VERIFICAMOS QUANDO O ID DO CLIENTE ESTA PRESENTE E ALGUM DOS PARAMETROS QUE NAO PODEM ESTAR PRESENTES NAO SAO NULOS
    ELSIF (P_IDCLIENTE IS NOT NULL AND (P_NIF IS NOT NULL OR P_TELEFONE IS NOT NULL OR P_EMAIL IS NULL)) THEN
        RAISE IDCLIENTE;

        -- VERIFICAMOS O CASO EM QUE O I DO CLIENTE E NULO E EXISTE O NOME DO CLIENTE, OS OUTROS PARAMETROS SAO OPCIONAIS
        -- DE QUALQUER DAS FORMAS
    ELSIF (P_IDCLIENTE IS NULL AND P_NOMECLIENTE IS NOT NULL) THEN
        INSERT INTO RESERVA
        VALUES (AUX_ID_RESERVA, NULL, P_NOMECLIENTE, P_NIF, P_EMAIL, P_TELEFONE, P_TIPOQUARTO, SYSDATE,
                P_DATAENTRADA, P_DATASAIDA, P_NUMPESSOAS, NULL, 1, NULL, NULL);

        --VERIFICAMOS O CASO EM QUE TANTO O ID DO CLIENTE COMO O NOME DO CLIENTE SAO NULOS. IMPOSSIVEL CRIAR A RESERVA
    ELSIF (P_IDCLIENTE IS NULL AND P_NOMECLIENTE IS NULL) THEN
        RAISE IDCLIENTE_NOMECLIENTE;
    END IF;

EXCEPTION
    WHEN IDCLIENTE THEN DBMS_OUTPUT.PUT_LINE(
                'INSERIU UM ID DE CLIENTE E OUTROS PARAMETROS. CASO QUEIRA USAR UM ID DE' ||
                ' CLIENTE DEIXE OS RESTANTES PARAMETROS EM BRANCO (NULL)');
    WHEN IDCLIENTE_NOMECLIENTE THEN DBMS_OUTPUT.PUT_LINE('NAO PODE COLOCAR AMBOS OS CAMPOS NOME DE CLIENTE E ID DE ' ||
                                                         'CLIENTE EM BRANCO. VERIFICAR DADOS NOVAMENTE');
END;

-- TEST
BEGIN
    --EXPECTAVEL QUE CRIE SEM ERROS
    PRCREGISTARRESERVA(1, SYSDATE, SYSDATE + 1, 1, NULL, 'NOME', 123, 123, 'NOME@EMAIL.PT');
    PRCREGISTARRESERVA(1, SYSDATE, SYSDATE + 1, 1, 10, NULL, NULL, NULL, NULL);

    --EXPECTAVEL QUE DE ERRO DE ID DE CLIENTE E OUTROS PARAMETROS
    PRCREGISTARRESERVA(2, SYSDATE, SYSDATE + 1, 2, 1, 'NOME', 123, 123, 'NOME@EMAIL.PT');

    --EXPECTAVEL QUE DE ERRO DE AMBOS PARAMETROS NULOS
    PRCREGISTARRESERVA(3, SYSDATE, SYSDATE + 1, 3, NULL, NULL, 123, 123, 'NOME@EMAIL.PT');
END;