--Checkins
create or replace function isQuartoIndisponivel(p_id_quarto int, p_data date) return boolean
    is
    v_count int;
begin
    select count(*)
    into v_count
    from checkin a
             left join checkout b on (a.id_reserva = b.id_reserva)
    where a.id_quarto = p_id_quarto
      and ((a.data >= trunc(p_data) and b.data is null) --tenho checkin mas n?o tenho checkout
        or
           (a.data <= trunc(p_data) and b.data >= trunc(p_data)));
    return (v_count > 0);
end;
/

declare
    v_data_ref date := to_date('2020-11-30', 'yyyy-mm-dd');
    cursor ca is select *
                 from artigo_consumo
                 order by 1;
    ra         ca%rowtype;
    cursor cc is select *
                 from camareira
                 order by 1;
    rc         cc%rowtype;
begin
    for r1 in (select * from reserva where data_entrada < v_data_ref and data_saida <= v_data_ref)
        loop
            for r2 in (select * from quarto where id_tipo_quarto = r1.id_tipo_quarto order by id)
                loop
                    if not isQuartoIndisponivel(r2.id, r1.data_entrada) then
                        insert into checkin(id_reserva, data, id_quarto) values (r1.id, r1.data_entrada, r2.id);
                        insert into checkout(id_reserva, data) values (r1.id, r1.data_saida);
                        insert into conta_consumo(id, data_abertura, id_reserva)
                        values (seq_conta_consumo.nextval, r1.data_entrada, r1.id);
                        if not ca%isopen then
                            open ca;
                        end if;
                        fetch ca into ra;
                        if ca%notfound then
                            close ca;
                            open ca;
                            fetch ca into ra;
                        end if;
                        if not cc%isopen then
                            open cc;
                        end if;
                        fetch cc into rc;
                        if cc%notfound then
                            close cc;
                            open cc;
                            fetch cc into rc;
                        end if;
                        insert into linha_conta_consumo(id_conta_consumo, linha, id_artigo_consumo, data_registo,
                                                        quantidade, preco_unitario, id_camareira)
                        values (seq_conta_consumo.currval, 1, ra.id, r1.data_entrada, 1, ra.preco, rc.id);
                        exit;
                    end if;
                end loop;
        end loop;
end;
/

--
commit;