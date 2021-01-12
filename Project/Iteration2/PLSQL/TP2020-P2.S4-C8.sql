CREATE OR REPLACE PROCEDURE PRCREGISTARRESERVA(P_TIPOQUARTO NUMBER, P_DATAENTRADA DATE, P_DATASAIDA DATE,
                                               P_NUMPESSOAS NUMBER, P_IDCLIENTE NUMBER, P_NOMECLIENTE VARCHAR,
                                               P_NIF NUMBER, P_TELEFONE NUMBER, P_EMAIL VARCHAR) IS

    IDCLIENTE EXCEPTION;
    IDCLIENTE_NOMECLIENTE EXCEPTION;
    TIPOQUARTO_INVALIDO EXCEPTION ;
    LOTACAOMAXIMA EXCEPTION;
    NIF_TELEFONE EXCEPTION;
    EMAIL EXCEPTION;
    DATAENTRADA_DATASAIDA EXCEPTION;
    AUX_ID_RESERVA NUMBER;
    AUX_TIPOQUARTO NUMBER;
    AUX_IDCLIENTE  NUMBER;
    AUX_LOTACAO    NUMBER;
BEGIN

    -- VAMOS OBTER O ID DA RESERVA MAIS RECENTE E ADICIONAR 1 PARA CRIAR UMA NOVA RESERVA
    SELECT R.ID
    INTO AUX_ID_RESERVA
    FROM RESERVA R
    ORDER BY R.ID DESC FETCH FIRST ROW ONLY;
    AUX_ID_RESERVA := AUX_ID_RESERVA + 1;

    DBMS_OUTPUT.PUT_LINE('=====================================================');
    DBMS_OUTPUT.PUT_LINE('RESERVA NUM: ' || AUX_ID_RESERVA);


    -- VAMOS EFETUAR A VERIFICACAO SE A DATA DE ENTRADA OU SAIDA E INFERIOR A DATA DE SISTEMA OU SE A DATA DE SAIDA E
    -- INFERIOR A DATA DE ENTRADA (CASOS INVALIDOS)
    IF P_DATAENTRADA < SYSDATE OR P_DATASAIDA < SYSDATE OR P_DATAENTRADA > P_DATASAIDA THEN
        RAISE DATAENTRADA_DATASAIDA;
    END IF;

    -- VAMOS EFETUAR VERIFICAÇÕES DOS DADOS OBRIGATORIOS PASSADOS POR PARAMETROS
    -- INICIAR A VARIAVEL DE VERIFICACAO A 0
    AUX_TIPOQUARTO := 0;
    SELECT TQ.ID INTO AUX_TIPOQUARTO FROM TIPO_QUARTO TQ WHERE TQ.ID = P_TIPOQUARTO;
    IF AUX_TIPOQUARTO = 0 THEN RAISE TIPOQUARTO_INVALIDO; END IF;

    -- VAMOS VERIFICAR SE EXISTE ALGUM QUARTO QUE SEJA DO TIPO PASSADO POR PARAMETRO E POSSA ACOMODAR O NUMERO DE
    -- PESSOAS QUE SE PASSA POR PARAMETRO TAMBEM, CASO NAO EXISTA A VARIAVEL AUX_TIPOQUARTO VAI FICAR A 0
    AUX_LOTACAO := 0;
    SELECT COUNT(Q.ID)
    INTO AUX_LOTACAO
    FROM QUARTO Q
    WHERE Q.ID_TIPO_QUARTO = P_TIPOQUARTO
      AND Q.LOTACAO_MAXIMA >= P_NUMPESSOAS;
    IF AUX_LOTACAO = 0 THEN RAISE LOTACAOMAXIMA; END IF;

    -- VERIFICAMOS O CASO EM QUE O ID DO CLIENTE ESTA PRESENTE E TODOS OS PARAMETROS SAO NULOS
    IF
        (P_IDCLIENTE IS NOT NULL AND P_NIF IS NULL AND P_TELEFONE IS NULL AND P_EMAIL IS NULL)
    THEN
        --VAMOS VERIFICAR SE O ID DE CLIENTE EXISTE
        AUX_IDCLIENTE := 0;
        SELECT C.ID INTO AUX_IDCLIENTE FROM CLIENTE C WHERE C.ID = P_IDCLIENTE;
        IF AUX_IDCLIENTE = 0 THEN RAISE IDCLIENTE; END IF;

        INSERT INTO RESERVA
        VALUES (AUX_ID_RESERVA, P_IDCLIENTE, NULL, NULL, NULL, NULL, P_TIPOQUARTO, SYSDATE,
                P_DATAENTRADA, P_DATASAIDA, P_NUMPESSOAS, NULL, 1, NULL, NULL);

        DBMS_OUTPUT.PUT_LINE('RESERVA CRIADA COM SUCESSO:');
        DBMS_OUTPUT.PUT_LINE('DATA DE ENTRADA: ' || P_TIPOQUARTO);
        DBMS_OUTPUT.PUT_LINE('DATA DE SAIDA: ' || P_DATAENTRADA);
        DBMS_OUTPUT.PUT_LINE('ID DO CLIENTE: ' || P_IDCLIENTE);
        DBMS_OUTPUT.PUT_LINE('=====================================================');

        -- VERIFICAMOS QUANDO O ID DO CLIENTE ESTA PRESENTE E ALGUM DOS PARAMETROS QUE NAO PODEM ESTAR PRESENTES NAO SAO NULOS
    ELSIF
        (P_IDCLIENTE IS NOT NULL AND (P_NIF IS NOT NULL OR P_TELEFONE IS NOT NULL OR P_EMAIL IS NULL))
    THEN
        RAISE IDCLIENTE;

        -- VERIFICAMOS O CASO EM QUE O I DO CLIENTE E NULO E EXISTE O NOME DO CLIENTE, OS OUTROS PARAMETROS SAO OPCIONAIS
        -- DE QUALQUER DAS FORMAS
    ELSIF
        (P_IDCLIENTE IS NULL AND P_NOMECLIENTE IS NOT NULL)
    THEN

        -- VAMOS VERIFICAR SE O NIF E O TELEFONE INSERIDOS SAO VALIDOS
        IF P_NIF <= 0 OR P_TELEFONE <= 0 THEN RAISE NIF_TELEFONE; END IF;

        -- VAMOS VERIFICAR SE O EMAIL ESTA CORRETO
        -- REGEX RETIRADO DE: https://emailregex.com/
        IF NOT REGEXP_LIKE(P_EMAIL, '^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN
            RAISE EMAIL;
        END IF;

        INSERT INTO RESERVA
        VALUES (AUX_ID_RESERVA, NULL, P_NOMECLIENTE, P_NIF, P_EMAIL, P_TELEFONE, P_TIPOQUARTO, SYSDATE,
                P_DATAENTRADA, P_DATASAIDA, P_NUMPESSOAS, NULL, 1, NULL, NULL);

        DBMS_OUTPUT.PUT_LINE('=====================================================');
        DBMS_OUTPUT.PUT_LINE('RESERVA CRIADA COM SUCESSO:');
        DBMS_OUTPUT.PUT_LINE('DATA DE ENTRADA: ' || P_TIPOQUARTO);
        DBMS_OUTPUT.PUT_LINE('DATA DE SAIDA: ' || P_DATAENTRADA);
        DBMS_OUTPUT.PUT_LINE('NUMERO DE PESSOAS: ' || P_NUMPESSOAS);
        DBMS_OUTPUT.PUT_LINE('NOME DO CLIENTE: ' || P_NOMECLIENTE);
        DBMS_OUTPUT.PUT_LINE('EMAIL: ' || P_EMAIL);
        DBMS_OUTPUT.PUT_LINE('TELEFONE: ' || P_TELEFONE);
        DBMS_OUTPUT.PUT_LINE('=====================================================');

        COMMIT;
        --VERIFICAMOS O CASO EM QUE TANTO O ID DO CLIENTE COMO O NOME DO CLIENTE SAO NULOS. IMPOSSIVEL CRIAR A RESERVA
    ELSIF
        (P_IDCLIENTE IS NULL AND P_NOMECLIENTE IS NULL)
    THEN
        RAISE IDCLIENTE_NOMECLIENTE;
    END IF;

EXCEPTION
    WHEN
        IDCLIENTE THEN DBMS_OUTPUT.PUT_LINE(
                'INSERIU UM ID DE CLIENTE E OUTROS PARAMETROS. CASO QUEIRA USAR UM ID DE' ||
                ' CLIENTE DEIXE OS RESTANTES PARAMETROS EM BRANCO (NULL).');
    WHEN
        IDCLIENTE_NOMECLIENTE THEN DBMS_OUTPUT.PUT_LINE('NAO PODE COLOCAR AMBOS OS CAMPOS NOME DE CLIENTE E ID DE ' ||
                                                        'CLIENTE EM BRANCO.');
    WHEN TIPOQUARTO_INVALIDO THEN DBMS_OUTPUT.PUT_LINE('TIPO DE QUARTO NAO ENCONTRADO/INVALIDO.');
    WHEN LOTACAOMAXIMA THEN DBMS_OUTPUT.PUT_LINE('A LOTACAO MAXIMA INSERIDA EXCEDE A LOTACAO MAXIMA DE QUALQUER ' ||
                                                 'QUARTO.');
    WHEN NIF_TELEFONE THEN DBMS_OUTPUT.PUT_LINE('OS DADOS DE NIF OU TELEFONE INSERIDOS SAO INVALIDOS.');
    WHEN EMAIL THEN DBMS_OUTPUT.PUT_LINE('O EMAIL INSERIDO NAO E VALIDO.');
    WHEN DATAENTRADA_DATASAIDA THEN DBMS_OUTPUT.PUT_LINE('VERIFIQUE AS DATA DE ENTRADA E SAIDA.');
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