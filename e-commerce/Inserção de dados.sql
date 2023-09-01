--Inserção de dados na tabela Usuarios:
INSERT INTO `L4N0XS_STORE`.`Usuarios` (`PrimeiroNome`, `NomeMeio`, `Sobrenome`, `Endereco`, `Telefone`) VALUES
('João', 'A.', 'Silva', 'Rua A, 123', '(11) 1234-5678'),
('Maria', NULL, 'Pereira', 'Av. B, 456', '(22) 9876-5432');

--Inserção de dados na tabela Entregas:
INSERT INTO `L4N0XS_STORE`.`Entregas` (`CodigoRastreio`, `StatusEntrega`, `ValorFrete`) VALUES
(123456, 'Em preparação', 15.99),
(789012, 'Enviado', 12.50);

-- Inserção de dados na tabela CartoesCredito:
INSERT INTO `L4N0XS_STORE`.`CartoesCredito` (`NomeTitular`, `NumeroCartao`, `Bandeira`, `DataValidade`, `fk_idUsuario`) VALUES
('João A. Silva', '1234567890123456', 'Visa', '2025-12-31', 1);

INSERT INTO `L4N0XS_STORE`.`CartoesCredito` (`NomeTitular`, `NumeroCartao`, `Bandeira`, `DataValidade`, `fk_idUsuario`) VALUES
('Maria Pereira', '9876543210987654', 'MasterCard', '2024-11-30', 2);

--Inserção de dados na tabela MetodosPagamento:
INSERT INTO `L4N0XS_STORE`.`MetodosPagamento` (`TipoPagamento`) VALUES
('Cartão'),
('Boleto'),
('Débito');

--Inserção de dados na tabela Pedidos:
INSERT INTO `L4N0XS_STORE`.`Pedidos` (`fk_idUsuario`, `fk_idEntrega`, `fk_idMetodoPagamento`, `fk_idCartaoCredito`, `StatusPedido`, `Descricao`, `ValorTotal`, `DataPedido`, `NumeroPagamento`) VALUES
(1, 1, 1, 1, 'Confirmado', 'Pedido de eletrônicos', 1500.00, '2023-08-31', '1234-5678-9012-3456');

INSERT INTO `L4N0XS_STORE`.`Pedidos` (`fk_idUsuario`, `fk_idEntrega`, `fk_idMetodoPagamento`, `StatusPedido`, `Descricao`, `ValorTotal`, `DataPedido`, `NumeroPagamento`) VALUES
(2, 2, 2, 'Em processamento', 'Pedido de roupas', 250.00, '2023-08-31', '9876-5432-1098-7654');

--Inserção de dados na tabela Produtos:
INSERT INTO `L4N0XS_STORE`.`Produtos` (`NomeProduto`, `Classificacao`, `Categoria`, `Tamanho`, `Avaliacao`, `Preco`) VALUES
('Smartphone', 0, 'Eletrônico', '6 polegadas', 4.5, 799.99),
('Camiseta', 0, 'Vestuário', 'M', 4.0, 29.99),
('Bola de Futebol', 1, 'Brinquedo', NULL, 4.8, 19.99);

--Inserção de dados na tabela Fornecedores:
INSERT INTO `L4N0XS_STORE`.`Fornecedores` (`RazaoSocial`, `CNPJ`, `TelefoneContato`) VALUES
('Fornecedor Eletrônicos Ltda.', '12345678901234', '01123456789'),
('Fornecedor Vestuário S.A.', '98765432109876', '02987654321');

-- Inserção de dados na tabela FornecedoresProdutos:
INSERT INTO `L4N0XS_STORE`.`FornecedoresProdutos` (`fk_idFornecedor`, `fk_idProduto`, `Quantidade`) VALUES
(1, 1, 50);

INSERT INTO `L4N0XS_STORE`.`FornecedoresProdutos` (`fk_idFornecedor`, `fk_idProduto`, `Quantidade`) VALUES
(2, 2, 100);

--Inserção de dados na tabela Estoques:
INSERT INTO `L4N0XS_STORE`.`Estoques` (`EnderecoEstoque`, `NomeResponsavel`, `TelefoneContato`) VALUES
('Rua X, 123', 'Carlos', '01123456789'),
('Av. Y, 456', 'Ana', '02987654321');

--Inserção de dados na tabela ProdutosEstoques:
INSERT INTO `L4N0XS_STORE`.`ProdutosEstoques` (`fk_idProduto`, `fk_idEstoque`, `Quantidade`) VALUES
(1, 1, 10);

INSERT INTO `L4N0XS_STORE`.`ProdutosEstoques` (`fk_idProduto`, `fk_idEstoque`, `Quantidade`) VALUES
(2, 2, 20);

--Inserção de dados na tabela PedidosProdutos:
INSERT INTO `L4N0XS_STORE`.`PedidosProdutos` (`fk_idProduto`, `fk_idPedido`, `Quantidade`, `StatusProduto`) VALUES
(1, 1, 2, 'Disponível');

INSERT INTO `L4N0XS_STORE`.`PedidosProdutos` (`fk_idProduto`, `fk_idPedido`, `Quantidade`, `StatusProduto`) VALUES
(2, 2, 3, 'Sem estoque');

--Inserção de dados na tabela Vendedores:
INSERT INTO `L4N0XS_STORE`.`Vendedores` (`RazaoSocial`, `NomeFantasia`, `CNPJ`, `CPF`, `Endereco`, `TelefoneContato`) VALUES
('Loja de Eletrônicos Ltda.', NULL, '09876543210987', NULL, 'Av. Z, 789', '03987654321'),
('Loja de Roupas', 'Moda Fina', NULL, '12345678901', 'Rua W, 567', '04123456789');

--Inserção de dados na tabela ProdutosTerceiros:
INSERT INTO `L4N0XS_STORE`.`ProdutosTerceiros` (`fk_idVendedor`, `fk_idProduto`, `Quantidade`) VALUES
(1, 1, 5);

INSERT INTO `L4N0XS_STORE`.`ProdutosTerceiros` (`fk_idVendedor`, `fk_idProduto`, `Quantidade`) VALUES
(2, 2, 10);

--Inserção de dados na tabela Documentos:
INSERT INTO `L4N0XS_STORE`.`Documentos` (`TipoDocumento`, `NumeroDocumento`, `fk_idUsuario`) VALUES
('CPF', '12345678901', 1);

INSERT INTO `L4N0XS_STORE`.`Documentos` (`TipoDocumento`, `NumeroDocumento`, `fk_idUsuario`) VALUES
('CNPJ', '98765432109876', 2);
