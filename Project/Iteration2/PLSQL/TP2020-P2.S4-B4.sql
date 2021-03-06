CREATE OR REPLACE FUNCTION FNCOBTERREGISTOMENSALCAMAREIRA(MES_PARAM INT, ANO_PARAM INT) RETURN SYS_REFCURSOR
    IS
    CURSOR_CAMAREIRA SYS_REFCURSOR;
    AUX_ANO          NUMBER;
BEGIN

    --VERIFICACAO PARA O ANO, CASO SEJA NULL TEM DE SER O ATUAL
    IF ANO_PARAM IS NULL OR ANO_PARAM = 0 THEN
        AUX_ANO := EXTRACT(YEAR FROM SYSDATE);
    ELSIF ANO_PARAM IS NOT NULL THEN
        AUX_ANO := ANO_PARAM;
    END IF;

    -- COLOCA NO CURSOS CAMAREIRA O ID, O NOME, O SOMATORIO DE TODOS OS REGISTOS EFETUADOS, A DATA DO PRIMEIRO
    -- REGISTO E A DATA DO ULTIMO REGISTO E A QUANTIDADE DE DIAS EM QUE NAO HOUVE REGISTOS. EFETUA UM JOIN NA TABELA
    -- FUNCIONARIO PARA IR BUSCAR NOME E LEFT JOIN NA TABELALINHA_CONTA_CONSUMO PARA IR BUSCAR A RESTANTE INFORMACAO.
    -- O LEFT JOIN PERMITE IR BUSCAR OS DIAS EM QUE NAO HOUVE REGISTOS.
    -- OS DADOS ESTAO AGRUPADOS PELO NOME/ID DA CAMAREIRA
    OPEN CURSOR_CAMAREIRA FOR
        SELECT C.ID,
               F.NOME,
               SUM(LCC.QUANTIDADE * LCC.PRECO_UNITARIO) AS CONSUMO_TOTAL,
               MIN(LCC.DATA_REGISTO)                    AS
                                                           PRIMEIRO_REGISTO,
               MAX(LCC.DATA_REGISTO)                    AS ULTIMO_REGISTO,
               AVG(TO_NUMBER(TO_CHAR(LAST_DAY(DATA_REGISTO), 'dd')))
                   - SUM(NVL2(LCC.DATA_REGISTO, 1, 0))  AS DIAS_SEM_REGISTO
        FROM CAMAREIRA C
                 JOIN FUNCIONARIO F ON F.ID = C.ID
                 LEFT JOIN LINHA_CONTA_CONSUMO LCC ON LCC.ID_CAMAREIRA = C.ID
        WHERE EXTRACT(MONTH FROM LCC.DATA_REGISTO) = MES_PARAM
          AND EXTRACT(YEAR FROM LCC.DATA_REGISTO) = AUX_ANO
        GROUP BY C.ID, F.NOME;
    RETURN CURSOR_CAMAREIRA;
END;

-- TEST
DECLARE
    CAMAREIRA_INFO   SYS_REFCURSOR;
    CAMAREIRA_ID     CAMAREIRA.ID%TYPE;
    CAMAREIRA_NOME   FUNCIONARIO.NOME%TYPE;
    CONTAGEM_EUR     NUMBER;
    DATA_PRIMEIRO    DATE;
    DATA_ULTIMO      DATE;
    DIAS_SEM_REGISTO NUMBER;
    P_MES            NUMBER;
    P_ANO            NUMBER;
BEGIN
    P_MES := 2;
    P_ANO := NULL;
    DBMS_OUTPUT.PUT_LINE('======================================================');
    DBMS_OUTPUT.PUT_LINE('MES: ' || P_MES || ' ANO: ' || P_ANO);
    CAMAREIRA_INFO := FNCOBTERREGISTOMENSALCAMAREIRA(P_MES, P_ANO);
    FETCH CAMAREIRA_INFO INTO
        CAMAREIRA_ID,CAMAREIRA_NOME,CONTAGEM_EUR,DATA_PRIMEIRO,DATA_ULTIMO, DIAS_SEM_REGISTO;
    IF NOT CAMAREIRA_INFO%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('ID DA CAMAREIRA: ' || CAMAREIRA_ID);
        DBMS_OUTPUT.PUT_LINE('NOME DA CAMAREIRA: ' || CAMAREIRA_NOME);
        DBMS_OUTPUT.PUT_LINE('VALOR REGISTADO: ' || CONTAGEM_EUR || ' €');
        DBMS_OUTPUT.PUT_LINE('DATA DO PRIMEIRO REGISTO: ' || DATA_PRIMEIRO);
        DBMS_OUTPUT.PUT_LINE('DATA DO ULTIMO REGISTO: ' || DATA_ULTIMO);
        DBMS_OUTPUT.PUT_LINE('NUMERO DE DIAS SEM REGISTOS: ' || DIAS_SEM_REGISTO);
    ELSE
        RAISE NO_DATA_FOUND;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NAO ENCONTRADO');
END;