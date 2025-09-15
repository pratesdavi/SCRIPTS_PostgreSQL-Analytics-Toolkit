-- QUANTIDADE VALIDADO POR PESSOA NO DIA:
select
	quem_validou as "responsável",
	count(*) as qtd_validado,
	data_validacao
from
	nomedobanco.f_validacao_vendas
where
	data_validacao::date = CURRENT_DATE
group by quem_validou, data_validacao;
