CREATE OR REPLACE PROCEDURE registrar_venda_e_atualizar_estoque(
    p_produto_id INT,
    p_quantidade INT,
    OUT p_status TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Inicia um bloco transacional (implícito se não houver um externo)
    -- ou pode haver COMMIT/ROLLBACK explícitos aqui.

    -- 1. Inserir a venda
    INSERT INTO vendas (produto_id, quantidade, data_venda)
    VALUES (p_produto_id, p_quantidade, NOW());

    -- 2. Atualizar o estoque do produto
    UPDATE produtos
    SET estoque = estoque - p_quantidade
    WHERE id = p_produto_id;

    -- Verificar se a atualização do estoque foi bem-sucedida
    IF NOT FOUND THEN
        -- Se o produto_id não foi encontrado, reverte a transação
        ROLLBACK;
        p_status := 'Erro: Produto não encontrado ou estoque insuficiente.';
        RETURN; -- Sai da procedure
    END IF;

    -- Se tudo ocorreu bem, confirma a transação
    COMMIT; -- Confirma as alterações
    p_status := 'Venda registrada e estoque atualizado com sucesso.';

EXCEPTION
    WHEN OTHERS THEN
        -- Em caso de qualquer outro erro, reverte a transação
        ROLLBACK;
        p_status := 'Erro inesperado: ' || SQLERRM;
END;
$$;

Como cha
