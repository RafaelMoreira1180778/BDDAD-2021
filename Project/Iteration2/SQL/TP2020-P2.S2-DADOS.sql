--sequences
--select * from user_sequences;
declare
    v_cmd varchar(2000);
begin
    for r in (select sequence_name from user_sequences)
        loop
            v_cmd := 'drop sequence ' || r.sequence_name;
            execute immediate (v_cmd);
        end loop;
    --
    for r in (select table_name from user_tables)
        loop
            v_cmd := 'create sequence seq_' || r.table_name;
            execute immediate (v_cmd);
        end loop;
end;
/

--Pa�ses
declare
    v_count int         := 3;
    v_label varchar(50) := 'Pa�s';
begin
    for i in 1..v_count
        loop
            insert into pais(id, nome) values (seq_pais.nextval, v_label || ' ' || i);
        end loop;
end;
/

--Distritos
declare
    v_count int         := 5;
    v_label varchar(50) := 'Distrito';
begin
    for r in (select id, nome from pais)
        loop
            for i in 1..v_count
                loop
                    insert into distrito(id, id_pais, nome)
                    values (seq_distrito.nextval, r.id, v_label || ' ' || i || ' ' || r.nome);
                end loop;
        end loop;
end;
/

--Concelhos
declare
    v_count int         := 5;
    v_label varchar(50) := 'Concelho';
begin
    for r in (select id, nome from distrito)
        loop
            for i in 1..v_count
                loop
                    insert into concelho(id, id_distrito, nome)
                    values (seq_concelho.nextval, r.id, v_label || ' ' || i || ' ' || r.nome);
                end loop;
        end loop;
end;
/

--Localidades
declare
    v_count int         := 5;
    v_label varchar(50) := 'Localidade';
begin
    for r in (select id, nome from concelho)
        loop
            for i in 1..v_count
                loop
                    insert into localidade(id, id_concelho, nome)
                    values (seq_localidade.nextval, r.id, v_label || ' ' || i || ' ' || r.nome);
                end loop;
        end loop;
end;
/

--C�digos postais
declare
    v_count int         := 5;
    v_label varchar(20) := 'C�digo Postal';
begin
    for r in (select id, nome from localidade)
        loop
            for i in 1..v_count
                loop
                    insert into codigo_postal(id, id_localidade, designacao_postal)
                    values (seq_codigo_postal.nextval, r.id, v_label || ' ' || i || ' ' || r.nome);
                end loop;
        end loop;
end;
/

--Andares
declare
    v_count int         := 3;
    v_label varchar(50) := 'Andar';
begin
    for i in 1..v_count
        loop
            insert into andar(id, nr_andar, nome) values (seq_andar.nextval, i, v_label || ' ' || i);
        end loop;
end;
/

--Tipos de quarto
declare
    v_count int         := 3;
    v_label varchar(50) := 'Tipo quarto';
begin
    for i in 1..v_count
        loop
            insert into tipo_quarto(id, nome) values (seq_tipo_quarto.nextval, v_label || ' ' || i);
        end loop;
end;
/

--Quartos
declare
    v_count          int         := 7;
    v_label          varchar(20) := 'Quarto';
    cursor c_tq is select id
                   from tipo_quarto
                   order by 1;
    r_tq             c_tq%rowtype;
    v_id_tipo_quarto tipo_quarto.id%type;
    v_lotacao        int;
begin
    for r in (select id, nome from andar)
        loop
            for i in 1..v_count
                loop
                    if not c_tq%isopen then
                        open c_tq;
                    end if;
                    fetch c_tq into r_tq;
                    if c_tq%found then
                        v_id_tipo_quarto := r_tq.id;
                    else
                        close c_tq;
                        open c_tq;
                        fetch c_tq into r_tq;
                        v_id_tipo_quarto := r_tq.id;
                    end if;
                    --
                    v_lotacao := mod(r.id * i, 3) + 2;
                    insert into quarto(id, id_andar, nr_quarto, id_tipo_quarto, lotacao_maxima)
                    values (seq_quarto.nextval, r.id, i, v_id_tipo_quarto, v_lotacao);
                end loop;
        end loop;
end;
/

--Clientes
declare
    v_count int         := 500;
    v_label varchar(50) := 'Cliente';
    cursor c is select id
                from localidade
                order by 1;
    r       c%rowtype;
begin
    for i in 1..v_count
        loop
            if not c%isopen then
                open c;
            end if;
            fetch c into r;
            if not c%found then
                close c;
                open c;
                fetch c into r;
            end if;
            --
            insert into cliente(id, nome, nif, id_localidade, email, telefone)
            values (seq_cliente.nextval, v_label || ' ' || i, i, r.id, null, null);
        end loop;
end;
/

--Tipos de funcion�rios
insert into tipo_funcionario(id, nome)
values (1, 'Manuten��o');
insert into tipo_funcionario(id, nome)
values (2, 'Camareira');
insert into tipo_funcionario(id, nome)
values (3, 'Bar');
insert into tipo_funcionario(id, nome)
values (4, 'Rece��o');

--Funcion�rios
declare
    v_count int         := 10;
    v_label varchar(50) := 'Funcion�rio';
begin
    for r in (select * from tipo_funcionario order by 1)
        loop
            for i in 1..v_count
                loop
                    insert into funcionario(id, nif, nome, id_tipo_funcionario)
                    values (seq_funcionario.nextval, seq_funcionario.currval, r.nome || ' ' || i, r.id);
                end loop;
        end loop;
end;
/

--Funcion�rios de manuten��o.
declare
    v_id_responsavel funcionario.id%type;
begin
    for r in (select * from funcionario where id_tipo_funcionario = 1)
        loop
            insert into funcionario_manutencao(id, id_responsavel, telefone) values (r.id, v_id_responsavel, r.id);
            v_id_responsavel := r.id;
        end loop;
end;
/

--Camareiras.
begin
    for r in (select * from funcionario where id_tipo_funcionario = 2)
        loop
            insert into camareira(id) values (r.id);
        end loop;
end;
/

--Artigos de consumo
declare
    v_count int         := 30;
    v_label varchar(50) := 'Artigo consumo';
    v_preco number;
begin
    for i in 1..v_count
        loop
            insert into artigo_consumo(id, nome, preco)
            values (seq_artigo_consumo.nextval, v_label || ' ' || i, mod(v_count, i) + 1);
        end loop;
end;
/

--Modos de pagamento
insert into modo_pagamento(id, nome)
values (1, 'Numer�rio');
insert into modo_pagamento(id, nome)
values (2, 'Cheque');
insert into modo_pagamento(id, nome)
values (3, 'Cart�o de cr�dito');
insert into modo_pagamento(id, nome)
values (4, 'Cart�o de d�bito');

--Estados reserva
insert into estado_reserva(id, nome)
values (1, 'Aberta');
insert into estado_reserva(id, nome)
values (2, 'Check-in');
insert into estado_reserva(id, nome)
values (3, 'Check-out');
insert into estado_reserva(id, nome)
values (4, 'Cancelada');
insert into estado_reserva(id, nome)
values (5, 'Finalizada');

declare
    v_count int         := 30;
    v_label varchar(50) := 'Artigo consumo';
    v_preco number;
begin
    for i in 1..v_count
        loop
            insert into artigo_consumo(id, nome, preco)
            values (seq_artigo_consumo.nextval, v_label || ' ' || i, mod(v_count, i) + 1);
        end loop;
end;
/

--�pocas
insert into epoca(id, nome, data_ini, data_fim)
values (1, '�poca 1', to_date('2020-01-01', 'yyyy-mm-dd'), to_date('2020-03-31', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim)
values (2, '�poca 2', to_date('2020-04-01', 'yyyy-mm-dd'), to_date('2020-06-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim)
values (3, '�poca 3', to_date('2020-07-01', 'yyyy-mm-dd'), to_date('2020-09-30', 'yyyy-mm-dd'));
insert into epoca(id, nome, data_ini, data_fim)
values (4, '�poca 4', to_date('2020-09-01', 'yyyy-mm-dd'), to_date('2020-12-31', 'yyyy-mm-dd'));

--Pre�os por �poca e tipo de quarto
declare
    v_preco number;
begin
    for r1 in (select * from epoca)
        loop
            for r2 in (select * from tipo_quarto)
                loop
                    v_preco := mod(r1.id * r2.id * 10, 20) + 30;
                    insert into preco_epoca_tipo_quarto(id_epoca, id_tipo_quarto, preco) values (r1.id, r2.id, v_preco);
                end loop;
        end loop;
end;
/

insert into tipo_intervencao(id, nome)
values (1, 'Limpeza');
insert into tipo_intervencao(id, nome)
values (2, 'Manuten��o');

--reservas (N por cada dia, de 1-1-2020 at� 31-12-2020)
declare
    k_count          int         := 10;
    v_count          int;
    v_label          varchar(50) := 'Reserva';
    v_di             date;
    v_df             date;
    v_d              date;
    v_id_cliente     cliente.id%type;
    v_step           int         := 7; --de K em K reservas escolho efetivamente um cliente.
    v_id_reserva     int;
    v_nr_pessoas     int;
    v_id_tipo_quarto int;
    v_dias           int;
    v_lag_dias       int;
    v_preco          number;
begin
    delete from reserva;
    v_di := to_date('2020-01-01', 'yyyy-mm-dd');
    v_df := to_date('2020-12-31', 'yyyy-mm-dd');
    v_d := v_di;
    while v_d < v_df
        loop
            for i in 1..k_count
                loop
                    v_id_reserva := seq_reserva.nextval;
                    --gerar alguns clientes
                    select count(0) into v_count from cliente;
                    v_id_cliente := mod(v_count, v_id_reserva - (trunc(v_id_reserva / v_count)) * v_count);
                    if v_id_cliente <= 10 then v_id_cliente := null; end if;
                    --tipo de quarto � obtido ciclicamente
                    select count(0) into v_count from tipo_quarto;
                    v_id_tipo_quarto := mod(v_id_reserva, v_count) + 1;
                    --N� de dias da reserva � obtido ciclicamente.
                    v_dias := mod(v_id_reserva, 3) + 1;
                    v_lag_dias := mod(v_id_reserva, 30);
                    --N� de pessoas(1 at� 4)
                    v_nr_pessoas := mod(v_id_reserva, 4) + 1;
                    --Pre�o
                    begin
                        select a.preco
                        into v_preco
                        from preco_epoca_tipo_quarto a
                                 join epoca b on (a.id_epoca = b.id)
                        where id_tipo_quarto = v_id_tipo_quarto
                          and v_d + v_lag_dias between b.data_ini and b.data_fim;
                    exception
                        when others then
                            v_preco := 35;
                    end;
                    --
                    insert into reserva(id, id_cliente, nome, id_tipo_quarto, data, data_entrada, data_saida,
                                        nr_pessoas, preco, id_estado_reserva)
                    values (v_id_reserva, v_id_cliente, 'Cliente reserva ' || v_id_reserva, v_id_tipo_quarto, v_d,
                            v_d + v_lag_dias, v_d + v_lag_dias + v_dias, v_nr_pessoas, v_preco * v_dias, 1);
                end loop;
            ----
            v_d := v_d + 1;
        end loop;
end;
/

--
commit;
