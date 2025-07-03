create or replace procedure limpeza_f_coleta_preco()
language plpgsql
as $$
begin
	raise notice 'Iniciando limpeza da tabela f_coleta_preco'
	
	-- limpeza de exposto SIM
	UPDATE f_coleta_preco
	SET exposto = 'SIM'
	WHERE exposto IN ('Sim', 'sim', 'SIm');
	raise notice 'coluna "exposto"  tratada.';

	-- limpeza de exposto NAO
	UPDATE f_coleta_preco
	SET exposto = 'NAO'
	WHERE exposto IN ('Não', 'não', 'Nao', 'nao');
	raise notice 'coluna "exposto"  tratada.';

	-- limpeza de presenca SIM
	UPDATE f_coleta_preco
	SET presenca = 'SIM'
	WHERE presenca IN ('Sim', 'sim', 'SIm');
	raise notice 'coluna "presenca"  tratada.';
	
	-- limpeza de presenca NAO
	UPDATE f_coleta_preco
	SET presenca = 'NAO'
	WHERE presenca IN ('Não', 'não', 'Nao', 'nao');
	raise notice 'coluna "presenca"  tratada.';
end;
$$;


call limpeza f_coleta_preco();
