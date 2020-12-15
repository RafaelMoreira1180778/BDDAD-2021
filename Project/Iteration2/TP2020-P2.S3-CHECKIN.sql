--Checkins
CREATE OR REPLACE FUNCTION ISQUARTOINDISPONIVEL(P_ID_QUARTO INT, P_DATA DATE) RETURN BOOLEAN
    IS
    V_COUNT INT;
BEGIN
    SELECT COUNT(*)
    INTO V_COUNT
    FROM CHECKIN A
             LEFT JOIN CHECKOUT B ON (A.ID_RESERVA = B.ID_RESERVA)
    WHERE A.ID_QUARTO = P_ID_QUARTO
      AND ((A.DATA >= TRUNC(P_DATA) AND B.DATA IS NULL) --tenho checkin mas n?o tenho checkout
        OR
           (A.DATA <= TRUNC(P_DATA) AND B.DATA >= TRUNC(P_DATA)));
    RETURN (V_COUNT > 0);
END;
/

DECLARE
    V_DATA_REF DATE := TO_DATE('2020-11-30', 'yyyy-mm-dd');
    CURSOR CA IS SELECT *
                 FROM ARTIGO_CONSUMO
                 ORDER BY 1;
    RA         CA%ROWTYPE;
    CURSOR CC IS SELECT *
                 FROM CAMAREIRA
                 ORDER BY 1;
    RC         CC%ROWTYPE;
BEGIN
    FOR R1 IN (SELECT * FROM RESERVA WHERE DATA_ENTRADA < V_DATA_REF AND DATA_SAIDA <= V_DATA_REF)
        LOOP
            FOR R2 IN (SELECT * FROM QUARTO WHERE ID_TIPO_QUARTO = R1.ID_TIPO_QUARTO ORDER BY ID)
                LOOP
                    IF NOT ISQUARTOINDISPONIVEL(R2.ID, R1.DATA_ENTRADA) THEN
                        INSERT INTO CHECKIN(ID_RESERVA, DATA, ID_QUARTO) VALUES (R1.ID, R1.DATA_ENTRADA, R2.ID);
                        INSERT INTO CHECKOUT(ID_RESERVA, DATA) VALUES (R1.ID, R1.DATA_SAIDA);
                        INSERT INTO CONTA_CONSUMO(ID, DATA_ABERTURA, ID_RESERVA)
                        VALUES (SEQ_CONTA_CONSUMO.NEXTVAL, R1.DATA_ENTRADA, R1.ID);
                        IF NOT CA%ISOPEN THEN
                            OPEN CA;
                        END IF;
                        FETCH CA INTO RA;
                        IF CA%NOTFOUND THEN
                            CLOSE CA;
                            OPEN CA;
                            FETCH CA INTO RA;
                        END IF;
                        IF NOT CC%ISOPEN THEN
                            OPEN CC;
                        END IF;
                        FETCH CC INTO RC;
                        IF CC%NOTFOUND THEN
                            CLOSE CC;
                            OPEN CC;
                            FETCH CC INTO RC;
                        END IF;
                        INSERT INTO LINHA_CONTA_CONSUMO(ID_CONTA_CONSUMO, LINHA, ID_ARTIGO_CONSUMO, DATA_REGISTO,
                                                        QUANTIDADE, PRECO_UNITARIO, ID_CAMAREIRA)
                        VALUES (SEQ_CONTA_CONSUMO.CURRVAL, 1, RA.ID, R1.DATA_ENTRADA, 1, RA.PRECO, RC.ID);
                        EXIT;
                    END IF;
                END LOOP;
        END LOOP;
END;
/

--
COMMIT;