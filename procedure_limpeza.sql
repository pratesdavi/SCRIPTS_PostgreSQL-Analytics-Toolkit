CREATE OR REPLACE PROCEDURE limpeza_f_validacao_coleta_tv()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Iniciando limpeza da tabela f_validacao_coleta_tv...';

    -- Limpeza da coluna 'exposto' para 'SIM'
    UPDATE f_validacao_coleta_tv
    SET exposto = 'SIM'
    WHERE exposto IN ('Sim', 'sim', 'SIm');
    RAISE NOTICE 'Coluna "exposto" (SIM) tratada.';

    -- Limpeza da coluna 'exposto' para 'NAO'
    UPDATE f_validacao_coleta_tv
    SET exposto = 'NAO'
    WHERE exposto IN ('Não', 'não', 'Nao', 'nao');
    RAISE NOTICE 'Coluna "exposto" (NAO) tratada.';

    -- Limpeza da coluna 'presenca' para 'SIM'
    UPDATE f_validacao_coleta_tv
    SET presenca = 'SIM'
    WHERE presenca IN ('Sim', 'sim', 'SIm');
    RAISE NOTICE 'Coluna "presenca" (SIM) tratada.';

    -- Limpeza da coluna 'presenca' para 'NAO'
    UPDATE f_validacao_coleta_tv
    SET presenca = 'NAO'
    WHERE presenca IN ('Não', 'não', 'Nao', 'nao');
    RAISE NOTICE 'Coluna "presenca" (NAO) tratada.';

    -- Limpeza da coluna 'quem_validou': padroniza para 'DAVI'
    -- Inclui 'Davi', strings vazias, e nulos em uma única atualização.
    UPDATE f_validacao_coleta_tv
    SET quem_validou = 'DAVI'
    WHERE quem_validou IN ('Davi', 'davi', '') OR quem_validou IS NULL;
    RAISE NOTICE 'Coluna "quem_validou" tratada.';

    -- Limpeza da coluna 'erro': define nulo onde é string vazia
    UPDATE f_validacao_coleta_tv
    SET erro = NULL
    WHERE erro = '';
    RAISE NOTICE 'Coluna "erro" tratada.';

    -- Exclusão de registros onde 'validado' é nulo
    DELETE FROM f_validacao_coleta_tv
    WHERE validado IS NULL;
    RAISE NOTICE 'Registros com "validado" nulo excluídos.';

    -- Nova limpeza da coluna 'validado' baseada na coluna 'erro'
    UPDATE f_validacao_coleta_tv
    SET validado = CASE
        WHEN erro IN ('VALIDADO - PREÇO INCORRETO', 'ALERTA - FOTO ILEGÍVEL', 'ALERTA - NÚMERO DE EXPOSIÇÃO ZERADO', 'ALERTA - PRODUTOS EXPOSTOS EM EXCESSO', 'VALIDADO - MODELO DA ETIQUETA DIFERENTE DO INPUTADO')
        THEN 'SIMM - COM ERRO'
        ELSE 'SIM - SEM ERRO'
    END
    WHERE validado IS NOT NULL; -- Apenas atualiza onde 'validado' já não é nulo
    RAISE NOTICE 'Coluna "validado" tratada com base nos erros.';

    RAISE NOTICE 'Limpeza da tabela f_validacao_coleta_tv concluída.';
END;
$$;
