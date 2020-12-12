begin
    for r in (select 'drop table ' || table_name || ' cascade constraints' cmd from user_tables order by table_name)
        loop
            execute immediate (r.cmd);
        end loop;
end;
/

create table pais
(
    id   int
        constraint pk_pais primary key,
    nome varchar(250)
);

create table distrito
(
    id      int
        constraint pk_distrito primary key,
    id_pais int
        constraint fk_distrito_pais references pais (id),
    nome    varchar(250)
);

create table concelho
(
    id          int
        constraint pk_concelho primary key,
    id_distrito int
        constraint fk_concelho_distrito references distrito (id),
    nome        varchar(250)
);

create table localidade
(
    id          int
        constraint pk_localidade primary key,
    id_concelho int
        constraint fk_localidade_concelho references concelho (id),
    nome        varchar(250)
);

create table codigo_postal
(
    id                int
        constraint pk_codigo_postal primary key,
    id_localidade     int
        constraint fk_codigo_postal_localidade references localidade (id),
    designacao_postal varchar(250)
);

create table cliente
(
    id            int
        constraint pk_cliente primary key,
    nome          varchar(250),
    nif           varchar(15) unique,
    id_localidade int
        constraint fk_cliente_localidade references localidade (id),
    email         varchar(200) unique,
    telefone      varchar(20)
);

create table estado_reserva
(
    id   int
        constraint pk_estado_reserva primary key,
    nome varchar(250)
);

create table epoca
(
    id       int
        constraint pk_epoca primary key,
    nome     varchar(250),
    data_ini date
        constraint nn_epoca_data_ini not null,
    data_fim date,
    constraint ck_epoca_datas check (data_ini < data_fim)
);

create table andar
(
    id       int
        constraint pk_andar primary key,
    nome     varchar(250),
    nr_andar int unique
);

create table tipo_quarto
(
    id   int
        constraint pk_tipo_quarto primary key,
    nome varchar(250)
);

create table preco_epoca_tipo_quarto
(
    id_epoca       int
        constraint fk_preco_epoca_epoca references epoca (id),
    id_tipo_quarto int
        constraint fk_preco_epoca_tipo references tipo_quarto (id),
    constraint pk_preco_epoca_tipo_quarto primary key (id_epoca, id_tipo_quarto),
    preco          number(6, 2)
);

create table quarto
(
    id             int
        constraint pk_quarto primary key,
    id_andar       int not null
        constraint fk_quarto_andar references andar (id),
    nr_quarto      int not null,
    id_tipo_quarto int
        constraint fk_quarto_tipo_quarto references tipo_quarto (id),
    lotacao_maxima int,
    constraint uk_quarto unique (id_andar, nr_quarto)
);

create table reserva
(
    id                 int
        constraint pk_reserva primary key,
    id_cliente         int
        constraint fk_reserva_cliente references cliente (id),
    nome               varchar(250),
    nif                varchar(20),
    email              varchar(200),
    telefone           varchar(20),
    id_tipo_quarto     int not null
        constraint fk_reserva_tipo_quarto references tipo_quarto (id),
    data               date,
    data_entrada       date,
    data_saida         date,
    nr_pessoas         int,
    preco              number(6, 2),
    id_estado_reserva  int
        constraint fk_reserva_estado references estado_reserva (id),
    custo_cancelamento number(6, 2),
    custo_extra        number(6, 2)
);

create table checkin
(
    id_reserva int
        constraint pk_checkin primary key
        constraint fk_checkin_id_reserva references reserva (id),
    data       date not null,
    id_quarto  int
        constraint fk_reserva_quarto references quarto (id)
);

create table hospedes_checkin
(
    id_reserva              int
        constraint fk_hospedes_checkin_reserva references checkin (id_reserva),
    nr_hospede              int,
    constraint pk_hospedes_checkin primary key (id_reserva, nr_hospede),
    nome                    varchar(200),
    id_pais
        constraint fk_hospedes_checkin_pais references pais (id),
    genero                  varchar(1)
        constraint ck_hospedes_checkin_genero check (upper(genero) in ('M', 'F')),
    documento_identificacao varchar(50)
);

create table checkout
(
    id_reserva  int
        constraint pk_checkout_id_reserva primary key
        constraint fk_checkout_id_reserva references checkin (id_reserva),
    data        date not null,
    observacoes varchar(1000),
    valor_extra number(6, 2)
);

create table conta_consumo
(
    id            int
        constraint pk_conta_consumo primary key,
    data_abertura date,
    id_reserva    int
        constraint fk_conta_consumo_reserva references reserva (id)
);

create table artigo_consumo
(
    id    int
        constraint pk_artigo_consumo primary key,
    nome  varchar(250),
    preco number(6, 2)
);

create table tipo_funcionario
(
    id   int
        constraint pk_tipo_funcionario primary key,
    nome varchar(250)
);

create table funcionario
(
    id            int
        constraint pk_funcionario primary key,
    nif           varchar(20),
    nome          varchar(250),
    morada        varchar(200),
    codigo_postal int
        constraint fk_funcionario_codigo_postal references codigo_postal (id),
    email         varchar(200),
    telefone      varchar(20),
    id_tipo_funcionario
        constraint fk_funcionario_tipo_func references tipo_funcionario (id)
);

create table funcionario_manutencao
(
    id             int
        constraint pk_funcionario_manutencao primary key
        constraint fk_funcionario_manutencao_func references funcionario (id),
    id_responsavel int
        constraint fk_funcionario_manutencao_resp references funcionario_manutencao (id),
    telefone       varchar(20)
);

create table camareira
(
    id int
        constraint pk_camareira primary key
        constraint fk_camareira_funcionario references funcionario (id)
);

create table linha_conta_consumo
(
    id_conta_consumo  int
        constraint fk_linha_conta_consumo references conta_consumo (id),
    linha             int,
    constraint pk_linha_conta_consumo primary key (id_conta_consumo, linha),
    id_artigo_consumo int
        constraint fk_linha_conta_consumo_artigo references artigo_consumo (id),
    data_registo      date,
    quantidade        int,
    preco_unitario    number(6, 2),
    id_camareira      int
        constraint fk_linha_conta_consumo_cam references camareira (id)
);

create table fatura
(
    id                     int
        constraint pk_fatura primary key,
    numero                 int
        constraint nn_fatura_numero not null,
    data                   date not null,
    id_cliente             int
        constraint fk_fatura_cliente references cliente (id),
    id_reserva             int unique
        constraint fk_fatura_reserva references reserva (id),
    valor_faturado_reserva number(8, 2),
    valor_faturado_consumo number(8, 2)
);

create table linha_fatura
(
    id_fatura           int
        constraint fk_linha_fatura_fatura references fatura (id),
    linha               int,
    constraint pk_linha_fatura primary key (id_fatura, linha),
    id_conta_consumo    int,
    linha_conta_consumo int,
    constraint fk_linha_fatura_conta_consumo foreign key (id_conta_consumo, linha_conta_consumo) references linha_conta_consumo (id_conta_consumo, linha),
    valor_consumo       number(8, 2)
);

create table modo_pagamento
(
    id   int
        constraint pk_modo_pagamento primary key,
    nome varchar(250)
);

create table pagamento
(
    id_fatura         int
        constraint fk_pagamento_fatura references fatura (id),
    id_modo_pagamento int
        constraint fk_pagamento_modo references modo_pagamento (id),
    valor             number(8, 2),
    constraint pk_pagamento primary key (id_fatura, id_modo_pagamento)
);

create table tipo_intervencao
(
    id   int
        constraint pk_tipo_intervencao primary key,
    nome varchar(250)
);

create table intervencao
(
    id                  int
        constraint pk_intervencao primary key,
    id_quarto           int not null
        constraint fk_intervencao references quarto (id),
    id_funcionario      int
        constraint fk_intervencao_funcionario references funcionario (id),
    data                date,
    descricao           varchar(1000),
    id_tipo_intervencao int not null
        constraint fk_intervencao_tipo references tipo_intervencao (id)
);
