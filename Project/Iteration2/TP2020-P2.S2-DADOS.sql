--sequences
--select * from user_sequences;
DECLARE
    V_CMD VARCHAR(2000);
BEGIN
    FOR R IN (SELECT SEQUENCE_NAME FROM USER_SEQUENCES)
        LOOP
            V_CMD := 'drop sequence ' || R.SEQUENCE_NAME;
            EXECUTE IMMEDIATE (V_CMD);
        END LOOP;
    --
    FOR R IN (SELECT TABLE_NAME FROM USER_TABLES)
        LOOP
            V_CMD := 'create sequence seq_' || R.TABLE_NAME;
            EXECUTE IMMEDIATE (V_CMD);
        END LOOP;
END;
/

--Pa�ses
DECLARE
    V_COUNT INT         := 3;
    V_LABEL VARCHAR(50) := 'Pa�s';
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO PAIS(ID, NOME) VALUES (SEQ_PAIS.NEXTVAL, V_LABEL || ' ' || I);
        END LOOP;
END;
/

--Distritos
DECLARE
    V_COUNT INT         := 5;
    V_LABEL VARCHAR(50) := 'Distrito';
BEGIN
    FOR R IN (SELECT ID, NOME FROM PAIS)
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO DISTRITO(ID, ID_PAIS, NOME)
                    VALUES (SEQ_DISTRITO.NEXTVAL, R.ID, V_LABEL || ' ' || I || ' ' || R.NOME);
                END LOOP;
        END LOOP;
END;
/

--Concelhos
DECLARE
    V_COUNT INT         := 5;
    V_LABEL VARCHAR(50) := 'Concelho';
BEGIN
    FOR R IN (SELECT ID, NOME FROM DISTRITO)
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO CONCELHO(ID, ID_DISTRITO, NOME)
                    VALUES (SEQ_CONCELHO.NEXTVAL, R.ID, V_LABEL || ' ' || I || ' ' || R.NOME);
                END LOOP;
        END LOOP;
END;
/

--Localidades
DECLARE
    V_COUNT INT         := 5;
    V_LABEL VARCHAR(50) := 'Localidade';
BEGIN
    FOR R IN (SELECT ID, NOME FROM CONCELHO)
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO LOCALIDADE(ID, ID_CONCELHO, NOME)
                    VALUES (SEQ_LOCALIDADE.NEXTVAL, R.ID, V_LABEL || ' ' || I || ' ' || R.NOME);
                END LOOP;
        END LOOP;
END;
/

--C�digos postais
DECLARE
    V_COUNT INT         := 5;
    V_LABEL VARCHAR(20) := 'C�digo Postal';
BEGIN
    FOR R IN (SELECT ID, NOME FROM LOCALIDADE)
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO CODIGO_POSTAL(ID, ID_LOCALIDADE, DESIGNACAO_POSTAL)
                    VALUES (SEQ_CODIGO_POSTAL.NEXTVAL, R.ID, V_LABEL || ' ' || I || ' ' || R.NOME);
                END LOOP;
        END LOOP;
END;
/

--Andares
DECLARE
    V_COUNT INT         := 3;
    V_LABEL VARCHAR(50) := 'Andar';
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO ANDAR(ID, NR_ANDAR, NOME) VALUES (SEQ_ANDAR.NEXTVAL, I, V_LABEL || ' ' || I);
        END LOOP;
END;
/

--Tipos de quarto
DECLARE
    V_COUNT INT         := 3;
    V_LABEL VARCHAR(50) := 'Tipo quarto';
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO TIPO_QUARTO(ID, NOME) VALUES (SEQ_TIPO_QUARTO.NEXTVAL, V_LABEL || ' ' || I);
        END LOOP;
END;
/

--Quartos
DECLARE
    V_COUNT          INT         := 7;
    V_LABEL          VARCHAR(20) := 'Quarto';
    CURSOR C_TQ IS SELECT ID
                   FROM TIPO_QUARTO
                   ORDER BY 1;
    R_TQ             C_TQ%ROWTYPE;
    V_ID_TIPO_QUARTO TIPO_QUARTO.ID%TYPE;
    V_LOTACAO        INT;
BEGIN
    FOR R IN (SELECT ID, NOME FROM ANDAR)
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    IF NOT C_TQ%ISOPEN THEN
                        OPEN C_TQ;
                    END IF;
                    FETCH C_TQ INTO R_TQ;
                    IF C_TQ%FOUND THEN
                        V_ID_TIPO_QUARTO := R_TQ.ID;
                    ELSE
                        CLOSE C_TQ;
                        OPEN C_TQ;
                        FETCH C_TQ INTO R_TQ;
                        V_ID_TIPO_QUARTO := R_TQ.ID;
                    END IF;
                    --
                    V_LOTACAO := MOD(R.ID * I, 3) + 2;
                    INSERT INTO QUARTO(ID, ID_ANDAR, NR_QUARTO, ID_TIPO_QUARTO, LOTACAO_MAXIMA)
                    VALUES (SEQ_QUARTO.NEXTVAL, R.ID, I, V_ID_TIPO_QUARTO, V_LOTACAO);
                END LOOP;
        END LOOP;
END;
/

--Clientes
DECLARE
    V_COUNT INT         := 500;
    V_LABEL VARCHAR(50) := 'Cliente';
    CURSOR C IS SELECT ID
                FROM LOCALIDADE
                ORDER BY 1;
    R       C%ROWTYPE;
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            IF NOT C%ISOPEN THEN
                OPEN C;
            END IF;
            FETCH C INTO R;
            IF NOT C%FOUND THEN
                CLOSE C;
                OPEN C;
                FETCH C INTO R;
            END IF;
            --
            INSERT INTO CLIENTE(ID, NOME, NIF, ID_LOCALIDADE, EMAIL, TELEFONE)
            VALUES (SEQ_CLIENTE.NEXTVAL, V_LABEL || ' ' || I, I, R.ID, NULL, NULL);
        END LOOP;
END;
/

--Tipos de funcion�rios
INSERT INTO TIPO_FUNCIONARIO(ID, NOME)
VALUES (1, 'Manuten��o');
INSERT INTO TIPO_FUNCIONARIO(ID, NOME)
VALUES (2, 'Camareira');
INSERT INTO TIPO_FUNCIONARIO(ID, NOME)
VALUES (3, 'Bar');
INSERT INTO TIPO_FUNCIONARIO(ID, NOME)
VALUES (4, 'Rece��o');

--Funcion�rios
DECLARE
    V_COUNT INT         := 10;
    V_LABEL VARCHAR(50) := 'Funcion�rio';
BEGIN
    FOR R IN (SELECT * FROM TIPO_FUNCIONARIO ORDER BY 1)
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO FUNCIONARIO(ID, NIF, NOME, ID_TIPO_FUNCIONARIO)
                    VALUES (SEQ_FUNCIONARIO.NEXTVAL, SEQ_FUNCIONARIO.CURRVAL, R.NOME || ' ' || I, R.ID);
                END LOOP;
        END LOOP;
END;
/

--Funcion�rios de manuten��o.
DECLARE
    V_ID_RESPONSAVEL FUNCIONARIO.ID%TYPE;
BEGIN
    FOR R IN (SELECT * FROM FUNCIONARIO WHERE ID_TIPO_FUNCIONARIO = 1)
        LOOP
            INSERT INTO FUNCIONARIO_MANUTENCAO(ID, ID_RESPONSAVEL, TELEFONE) VALUES (R.ID, V_ID_RESPONSAVEL, R.ID);
            V_ID_RESPONSAVEL := R.ID;
        END LOOP;
END;
/

--Camareiras.
BEGIN
    FOR R IN (SELECT * FROM FUNCIONARIO WHERE ID_TIPO_FUNCIONARIO = 2)
        LOOP
            INSERT INTO CAMAREIRA(ID) VALUES (R.ID);
        END LOOP;
END;
/

--Artigos de consumo
DECLARE
    V_COUNT INT         := 30;
    V_LABEL VARCHAR(50) := 'Artigo consumo';
    V_PRECO NUMBER;
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO ARTIGO_CONSUMO(ID, NOME, PRECO)
            VALUES (SEQ_ARTIGO_CONSUMO.NEXTVAL, V_LABEL || ' ' || I, MOD(V_COUNT, I) + 1);
        END LOOP;
END;
/

--Modos de pagamento
INSERT INTO MODO_PAGAMENTO(ID, NOME)
VALUES (1, 'Numer�rio');
INSERT INTO MODO_PAGAMENTO(ID, NOME)
VALUES (2, 'Cheque');
INSERT INTO MODO_PAGAMENTO(ID, NOME)
VALUES (3, 'Cart�o de cr�dito');
INSERT INTO MODO_PAGAMENTO(ID, NOME)
VALUES (4, 'Cart�o de d�bito');

--Estados reserva
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (1, 'Aberta');
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (2, 'Check-in');
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (3, 'Check-out');
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (4, 'Cancelada');
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (5, 'Finalizada');

DECLARE
    V_COUNT INT         := 30;
    V_LABEL VARCHAR(50) := 'Artigo consumo';
    V_PRECO NUMBER;
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO ARTIGO_CONSUMO(ID, NOME, PRECO)
            VALUES (SEQ_ARTIGO_CONSUMO.NEXTVAL, V_LABEL || ' ' || I, MOD(V_COUNT, I) + 1);
        END LOOP;
END;
/

--�pocas
INSERT INTO EPOCA(ID, NOME, DATA_INI, DATA_FIM)
VALUES (1, '�poca 1', TO_DATE('2020-01-01', 'yyyy-mm-dd'), TO_DATE('2020-03-31', 'yyyy-mm-dd'));
INSERT INTO EPOCA(ID, NOME, DATA_INI, DATA_FIM)
VALUES (2, '�poca 2', TO_DATE('2020-04-01', 'yyyy-mm-dd'), TO_DATE('2020-06-30', 'yyyy-mm-dd'));
INSERT INTO EPOCA(ID, NOME, DATA_INI, DATA_FIM)
VALUES (3, '�poca 3', TO_DATE('2020-07-01', 'yyyy-mm-dd'), TO_DATE('2020-09-30', 'yyyy-mm-dd'));
INSERT INTO EPOCA(ID, NOME, DATA_INI, DATA_FIM)
VALUES (4, '�poca 4', TO_DATE('2020-09-01', 'yyyy-mm-dd'), TO_DATE('2020-12-31', 'yyyy-mm-dd'));

--Pre�os por �poca e tipo de quarto
DECLARE
    V_PRECO NUMBER;
BEGIN
    FOR R1 IN (SELECT * FROM EPOCA)
        LOOP
            FOR R2 IN (SELECT * FROM TIPO_QUARTO)
                LOOP
                    V_PRECO := MOD(R1.ID * R2.ID * 10, 20) + 30;
                    INSERT INTO PRECO_EPOCA_TIPO_QUARTO(ID_EPOCA, ID_TIPO_QUARTO, PRECO) VALUES (R1.ID, R2.ID, V_PRECO);
                END LOOP;
        END LOOP;
END;
/

INSERT INTO TIPO_INTERVENCAO(ID, NOME)
VALUES (1, 'Limpeza');
INSERT INTO TIPO_INTERVENCAO(ID, NOME)
VALUES (2, 'Manuten��o');

--reservas (N por cada dia, de 1-1-2020 at� 31-12-2020)
DECLARE
    K_COUNT          INT         := 10;
    V_COUNT          INT;
    V_LABEL          VARCHAR(50) := 'Reserva';
    V_DI             DATE;
    V_DF             DATE;
    V_D              DATE;
    V_ID_CLIENTE     CLIENTE.ID%TYPE;
    V_STEP           INT         := 7; --de K em K reservas escolho efetivamente um cliente.
    V_ID_RESERVA     INT;
    V_NR_PESSOAS     INT;
    V_ID_TIPO_QUARTO INT;
    V_DIAS           INT;
    V_LAG_DIAS       INT;
    V_PRECO          NUMBER;
BEGIN
    DELETE FROM RESERVA;
    V_DI := TO_DATE('2020-01-01', 'yyyy-mm-dd');
    V_DF := TO_DATE('2020-12-31', 'yyyy-mm-dd');
    V_D := V_DI;
    WHILE V_D < V_DF
        LOOP
            FOR I IN 1..K_COUNT
                LOOP
                    V_ID_RESERVA := SEQ_RESERVA.NEXTVAL;
                    --gerar alguns clientes
                    SELECT COUNT(0) INTO V_COUNT FROM CLIENTE;
                    V_ID_CLIENTE := MOD(V_COUNT, V_ID_RESERVA - (TRUNC(V_ID_RESERVA / V_COUNT)) * V_COUNT);
                    IF V_ID_CLIENTE <= 10 THEN V_ID_CLIENTE := NULL; END IF;
                    --tipo de quarto � obtido ciclicamente
                    SELECT COUNT(0) INTO V_COUNT FROM TIPO_QUARTO;
                    V_ID_TIPO_QUARTO := MOD(V_ID_RESERVA, V_COUNT) + 1;
                    --N� de dias da reserva � obtido ciclicamente.
                    V_DIAS := MOD(V_ID_RESERVA, 3) + 1;
                    V_LAG_DIAS := MOD(V_ID_RESERVA, 30);
                    --N� de pessoas(1 at� 4)
                    V_NR_PESSOAS := MOD(V_ID_RESERVA, 4) + 1;
                    --Pre�o
                    BEGIN
                        SELECT A.PRECO
                        INTO V_PRECO
                        FROM PRECO_EPOCA_TIPO_QUARTO A
                                 JOIN EPOCA B ON (A.ID_EPOCA = B.ID)
                        WHERE ID_TIPO_QUARTO = V_ID_TIPO_QUARTO
                          AND V_D + V_LAG_DIAS BETWEEN B.DATA_INI AND B.DATA_FIM;
                    EXCEPTION
                        WHEN OTHERS THEN
                            V_PRECO := 35;
                    END;
                    --
                    INSERT INTO RESERVA(ID, ID_CLIENTE, NOME, ID_TIPO_QUARTO, DATA, DATA_ENTRADA, DATA_SAIDA,
                                        NR_PESSOAS, PRECO, ID_ESTADO_RESERVA)
                    VALUES (V_ID_RESERVA, V_ID_CLIENTE, 'Cliente reserva ' || V_ID_RESERVA, V_ID_TIPO_QUARTO, V_D,
                            V_D + V_LAG_DIAS, V_D + V_LAG_DIAS + V_DIAS, V_NR_PESSOAS, V_PRECO * V_DIAS, 1);
                END LOOP;
            ----
            V_D := V_D + 1;
        END LOOP;
END;
/

--
COMMIT;
--sequences
--select * from user_sequences;
DECLARE
    V_CMD VARCHAR(2000);
BEGIN
    FOR R IN (
        SELECT SEQUENCE_NAME
        FROM USER_SEQUENCES
        )
        LOOP
            V_CMD := 'drop sequence ' || R.SEQUENCE_NAME;
            EXECUTE IMMEDIATE (V_CMD);
        END LOOP;
--
    FOR R IN (
        SELECT TABLE_NAME
        FROM USER_TABLES
        )
        LOOP
            V_CMD := 'create sequence seq_' || R.TABLE_NAME;
            EXECUTE IMMEDIATE (V_CMD);
        END LOOP;
END;
/ --Pa�ses
DECLARE
    V_COUNT INT         := 3;
    V_LABEL VARCHAR(50) := 'Pa�s';
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO PAIS(ID, NOME)
            VALUES (SEQ_PAIS.NEXTVAL, V_LABEL || ' ' || I);
        END LOOP;
END;
/ --Distritos
DECLARE
    V_COUNT INT         := 5;
    V_LABEL VARCHAR(50) := 'Distrito';
BEGIN
    FOR R IN (
        SELECT ID,
               NOME
        FROM PAIS
        )
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO DISTRITO(ID, ID_PAIS, NOME)
                    VALUES (SEQ_DISTRITO.NEXTVAL,
                            R.ID,
                            V_LABEL || ' ' || I || ' ' || R.NOME);
                END LOOP;
        END LOOP;
END;
/ --Concelhos
DECLARE
    V_COUNT INT         := 5;
    V_LABEL VARCHAR(50) := 'Concelho';
BEGIN
    FOR R IN (
        SELECT ID,
               NOME
        FROM DISTRITO
        )
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO CONCELHO(ID, ID_DISTRITO, NOME)
                    VALUES (SEQ_CONCELHO.NEXTVAL,
                            R.ID,
                            V_LABEL || ' ' || I || ' ' || R.NOME);
                END LOOP;
        END LOOP;
END;
/ --Localidades
DECLARE
    V_COUNT INT         := 5;
    V_LABEL VARCHAR(50) := 'Localidade';
BEGIN
    FOR R IN (
        SELECT ID,
               NOME
        FROM CONCELHO
        )
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO LOCALIDADE(ID, ID_CONCELHO, NOME)
                    VALUES (SEQ_LOCALIDADE.NEXTVAL,
                            R.ID,
                            V_LABEL || ' ' || I || ' ' || R.NOME);
                END LOOP;
        END LOOP;
END;
/ --C�digos postais
DECLARE
    V_COUNT INT         := 5;
    V_LABEL VARCHAR(20) := 'C�digo Postal';
BEGIN
    FOR R IN (
        SELECT ID,
               NOME
        FROM LOCALIDADE
        )
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO CODIGO_POSTAL(ID, ID_LOCALIDADE, DESIGNACAO_POSTAL)
                    VALUES (SEQ_CODIGO_POSTAL.NEXTVAL,
                            R.ID,
                            V_LABEL || ' ' || I || ' ' || R.NOME);
                END LOOP;
        END LOOP;
END;
/ --Andares
DECLARE
    V_COUNT INT         := 3;
    V_LABEL VARCHAR(50) := 'Andar';
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO ANDAR(ID, NR_ANDAR, NOME)
            VALUES (SEQ_ANDAR.NEXTVAL, I, V_LABEL || ' ' || I);
        END LOOP;
END;
/ --Tipos de quarto
DECLARE
    V_COUNT INT         := 3;
    V_LABEL VARCHAR(50) := 'Tipo quarto';
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO TIPO_QUARTO(ID, NOME)
            VALUES (SEQ_TIPO_QUARTO.NEXTVAL, V_LABEL || ' ' || I);
        END LOOP;
END;
/ --Quartos
DECLARE
    V_COUNT          INT         := 7;
    V_LABEL          VARCHAR(20) := 'Quarto';
    CURSOR C_TQ IS
        SELECT ID
        FROM TIPO_QUARTO
        ORDER BY 1;
    R_TQ             C_TQ %ROWTYPE;
    V_ID_TIPO_QUARTO TIPO_QUARTO.ID %TYPE;
    V_LOTACAO        INT;
BEGIN
    FOR R IN (
        SELECT ID,
               NOME
        FROM ANDAR
        )
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    IF NOT C_TQ %ISOPEN THEN
                        OPEN C_TQ;
                    END IF;
                    FETCH C_TQ INTO R_TQ;
                    IF C_TQ %FOUND THEN
                        V_ID_TIPO_QUARTO := R_TQ.ID;
                    ELSE
                        CLOSE C_TQ;
                        OPEN C_TQ;
                        FETCH C_TQ INTO R_TQ;
                        V_ID_TIPO_QUARTO := R_TQ.ID;
                    END IF;
--
                    V_LOTACAO := MOD(R.ID * I, 3) + 2;
                    INSERT INTO QUARTO(ID,
                                       ID_ANDAR,
                                       NR_QUARTO,
                                       ID_TIPO_QUARTO,
                                       LOTACAO_MAXIMA)
                    VALUES (SEQ_QUARTO.NEXTVAL,
                            R.ID,
                            I,
                            V_ID_TIPO_QUARTO,
                            V_LOTACAO);
                END LOOP;
        END LOOP;
END;
/ --Clientes
DECLARE
    V_COUNT INT         := 500;
    V_LABEL VARCHAR(50) := 'Cliente';
    CURSOR C IS
        SELECT ID
        FROM LOCALIDADE
        ORDER BY 1;
    R       C %ROWTYPE;
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            IF NOT C %ISOPEN THEN
                OPEN C;
            END IF;
            FETCH C INTO R;
            IF NOT C %FOUND THEN
                CLOSE C;
                OPEN C;
                FETCH C INTO R;
            END IF;
--
            INSERT INTO CLIENTE(ID, NOME, NIF, ID_LOCALIDADE, EMAIL, TELEFONE)
            VALUES (SEQ_CLIENTE.NEXTVAL,
                    V_LABEL || ' ' || I,
                    I,
                    R.ID,
                    NULL,
                    NULL);
        END LOOP;
END;
/ --Tipos de funcion�rios
INSERT INTO TIPO_FUNCIONARIO(ID, NOME)
VALUES (1, 'Manuten��o');
INSERT INTO TIPO_FUNCIONARIO(ID, NOME)
VALUES (2, 'Camareira');
INSERT INTO TIPO_FUNCIONARIO(ID, NOME)
VALUES (3, 'Bar');
INSERT INTO TIPO_FUNCIONARIO(ID, NOME)
VALUES (4, 'Rece��o');
--Funcion�rios
DECLARE
    V_COUNT INT         := 10;
    V_LABEL VARCHAR(50) := 'Funcion�rio';
BEGIN
    FOR R IN (
        SELECT *
        FROM TIPO_FUNCIONARIO
        ORDER BY 1
        )
        LOOP
            FOR I IN 1..V_COUNT
                LOOP
                    INSERT INTO FUNCIONARIO(ID, NIF, NOME, ID_TIPO_FUNCIONARIO)
                    VALUES (SEQ_FUNCIONARIO.NEXTVAL,
                            SEQ_FUNCIONARIO.CURRVAL,
                            R.NOME || ' ' || I,
                            R.ID);
                END LOOP;
        END LOOP;
END;
/ --Funcion�rios de manuten��o.
DECLARE
    V_ID_RESPONSAVEL FUNCIONARIO.ID %TYPE;
BEGIN
    FOR R IN (
        SELECT *
        FROM FUNCIONARIO
        WHERE ID_TIPO_FUNCIONARIO = 1
        )
        LOOP
            INSERT INTO FUNCIONARIO_MANUTENCAO(ID, ID_RESPONSAVEL, TELEFONE)
            VALUES (R.ID, V_ID_RESPONSAVEL, R.ID);
            V_ID_RESPONSAVEL := R.ID;
        END LOOP;
END;
/ --Camareiras.
BEGIN
    FOR R IN (
        SELECT *
        FROM FUNCIONARIO
        WHERE ID_TIPO_FUNCIONARIO = 2
        )
        LOOP
            INSERT INTO CAMAREIRA(ID)
            VALUES (R.ID);
        END LOOP;
END;
/ --Artigos de consumo
DECLARE
    V_COUNT INT         := 30;
    V_LABEL VARCHAR(50) := 'Artigo consumo';
    V_PRECO NUMBER;
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO ARTIGO_CONSUMO(ID, NOME, PRECO)
            VALUES (SEQ_ARTIGO_CONSUMO.NEXTVAL,
                    V_LABEL || ' ' || I,
                    MOD(V_COUNT, I) + 1);
        END LOOP;
END;
/ --Modos de pagamento
INSERT INTO MODO_PAGAMENTO(ID, NOME)
VALUES (1, 'Numer�rio');
INSERT INTO MODO_PAGAMENTO(ID, NOME)
VALUES (2, 'Cheque');
INSERT INTO MODO_PAGAMENTO(ID, NOME)
VALUES (3, 'Cart�o de cr�dito');
INSERT INTO MODO_PAGAMENTO(ID, NOME)
VALUES (4, 'Cart�o de d�bito');
--Estados reserva
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (1, 'Aberta');
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (2, 'Check-in');
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (3, 'Check-out');
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (4, 'Cancelada');
INSERT INTO ESTADO_RESERVA(ID, NOME)
VALUES (5, 'Finalizada');
DECLARE
    V_COUNT INT         := 30;
    V_LABEL VARCHAR(50) := 'Artigo consumo';
    V_PRECO NUMBER;
BEGIN
    FOR I IN 1..V_COUNT
        LOOP
            INSERT INTO ARTIGO_CONSUMO(ID, NOME, PRECO)
            VALUES (SEQ_ARTIGO_CONSUMO.NEXTVAL,
                    V_LABEL || ' ' || I,
                    MOD(V_COUNT, I) + 1);
        END LOOP;
END;
/ --�pocas
INSERT INTO EPOCA(ID, NOME, DATA_INI, DATA_FIM)
VALUES (1,
        '�poca 1',
        TO_DATE('2020-01-01', 'yyyy-mm-dd'),
        TO_DATE('2020-03-31', 'yyyy-mm-dd'));
INSERT INTO EPOCA(ID, NOME, DATA_INI, DATA_FIM)
VALUES (2,
        '�poca 2',
        TO_DATE('2020-04-01', 'yyyy-mm-dd'),
        TO_DATE('2020-06-30', 'yyyy-mm-dd'));
INSERT INTO EPOCA(ID, NOME, DATA_INI, DATA_FIM)
VALUES (3,
        '�poca 3',
        TO_DATE('2020-07-01', 'yyyy-mm-dd'),
        TO_DATE('2020-09-30', 'yyyy-mm-dd'));
INSERT INTO EPOCA(ID, NOME, DATA_INI, DATA_FIM)
VALUES (4,
        '�poca 4',
        TO_DATE('2020-09-01', 'yyyy-mm-dd'),
        TO_DATE('2020-12-31', 'yyyy-mm-dd'));
--Pre�os por �poca e tipo de quarto
DECLARE
    V_PRECO NUMBER;
BEGIN
    FOR R1 IN (
        SELECT *
        FROM EPOCA
        )
        LOOP
            FOR R2 IN (
                SELECT *
                FROM TIPO_QUARTO
                )
                LOOP
                    V_PRECO := MOD(R1.ID * R2.ID * 10, 20) + 30;
                    INSERT INTO PRECO_EPOCA_TIPO_QUARTO(ID_EPOCA, ID_TIPO_QUARTO, PRECO)
                    VALUES (R1.ID, R2.ID, V_PRECO);
                END LOOP;
        END LOOP;
END;
/
INSERT INTO TIPO_INTERVENCAO(ID, NOME)
VALUES (1, 'Limpeza');
INSERT INTO TIPO_INTERVENCAO(ID, NOME)
VALUES (2, 'Manuten��o');
--reservas (N por cada dia, de 1-1-2020 at� 31-12-2020)
DECLARE
    K_COUNT          INT         := 10;
    V_COUNT          INT;
    V_LABEL          VARCHAR(50) := 'Reserva';
    V_DI             DATE;
    V_DF             DATE;
    V_D              DATE;
    V_ID_CLIENTE     CLIENTE.ID %TYPE;
    V_STEP           INT         := 7;
--de K em K reservas escolho efetivamente um cliente.
    V_ID_RESERVA     INT;
    V_NR_PESSOAS     INT;
    V_ID_TIPO_QUARTO INT;
    V_DIAS           INT;
    V_LAG_DIAS       INT;
    V_PRECO          NUMBER;
BEGIN
    DELETE FROM RESERVA;
    V_DI := TO_DATE('2020-01-01', 'yyyy-mm-dd');
    V_DF := TO_DATE('2020-12-31', 'yyyy-mm-dd');
    V_D := V_DI;
    WHILE V_D < V_DF
        LOOP
            FOR I IN 1..K_COUNT
                LOOP
                    V_ID_RESERVA := SEQ_RESERVA.NEXTVAL;
--gerar alguns clientes
                    SELECT COUNT(0)
                    INTO V_COUNT
                    FROM CLIENTE;
                    V_ID_CLIENTE := MOD(
                            V_COUNT,
                            V_ID_RESERVA - (TRUNC(V_ID_RESERVA / V_COUNT)) * V_COUNT
                        );
                    IF V_ID_CLIENTE <= 10 THEN
                        V_ID_CLIENTE := NULL;
                    END IF;
--tipo de quarto � obtido ciclicamente
                    SELECT COUNT(0)
                    INTO V_COUNT
                    FROM TIPO_QUARTO;
                    V_ID_TIPO_QUARTO := MOD(V_ID_RESERVA, V_COUNT) + 1;
--N� de dias da reserva � obtido ciclicamente.
                    V_DIAS := MOD(V_ID_RESERVA, 3) + 1;
                    V_LAG_DIAS := MOD(V_ID_RESERVA, 30);
--N� de pessoas(1 at� 4)
                    V_NR_PESSOAS := MOD(V_ID_RESERVA, 4) + 1;
--Pre�o
                    BEGIN
                        SELECT A.PRECO
                        INTO V_PRECO
                        FROM PRECO_EPOCA_TIPO_QUARTO A
                                 JOIN EPOCA B ON (A.ID_EPOCA = B.ID)
                        WHERE ID_TIPO_QUARTO = V_ID_TIPO_QUARTO
                          AND V_D + V_LAG_DIAS BETWEEN B.DATA_INI AND B.DATA_FIM;
                    EXCEPTION
                        WHEN OTHERS THEN V_PRECO := 35;
                    END;
--
                    INSERT INTO RESERVA(ID,
                                        ID_CLIENTE,
                                        NOME,
                                        ID_TIPO_QUARTO,
                                        DATA,
                                        DATA_ENTRADA,
                                        DATA_SAIDA,
                                        NR_PESSOAS,
                                        PRECO,
                                        ID_ESTADO_RESERVA)
                    VALUES (V_ID_RESERVA,
                            V_ID_CLIENTE,
                            'Cliente reserva ' || V_ID_RESERVA,
                            V_ID_TIPO_QUARTO,
                            V_D,
                            V_D + V_LAG_DIAS,
                            V_D + V_LAG_DIAS + V_DIAS,
                            V_NR_PESSOAS,
                            V_PRECO * V_DIAS,
                            1);
                END LOOP;
----
            V_D := V_D + 1;
        END LOOP;
END;

INSERT INTO CONTA_CONSUMO
VALUES (1, TO_DATE('2020-12-11', 'yyyy-mm-dd'), 1);

INSERT INTO LINHA_CONTA_CONSUMO
VALUES (1, 1, 1, TO_DATE('2020-12-11', 'yyyy-mm-dd'), 2, 1.00, 11);
INSERT INTO LINHA_CONTA_CONSUMO
VALUES (1, 2, 2, TO_DATE('2020-12-11', 'yyyy-mm-dd'), 4, 1.00, 11);
INSERT INTO LINHA_CONTA_CONSUMO
VALUES (1, 3, 3, TO_DATE('2020-12-12', 'yyyy-mm-dd'), 1, 1.00, 11);
INSERT INTO LINHA_CONTA_CONSUMO
VALUES (1, 4, 4, TO_DATE('2020-12-13', 'yyyy-mm-dd'), 3, 3.00, 11);

/ --
COMMIT;
