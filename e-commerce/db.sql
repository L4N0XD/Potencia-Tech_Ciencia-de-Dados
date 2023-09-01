-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`Usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT COMMENT 'ID do usuário, único e auto-incrementável.',
  `PrimeiroNome` VARCHAR(10) NOT NULL COMMENT 'Primeiro nome do usuário, campo obrigatório.',
  `NomeMeio` CHAR(3) NULL COMMENT 'Inicial do nome do meio, tipo CHAR(3).',
  `Sobrenome` VARCHAR(20) NOT NULL COMMENT 'Sobrenome do usuário, campo obrigatório.',
  `Endereco` VARCHAR(100) NOT NULL COMMENT 'Endereço do usuário, campo obrigatório.',
  `Telefone` VARCHAR(15) NOT NULL COMMENT 'Telefone do usuário, campo obrigatório.',
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`Entregas` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT COMMENT 'ID de entrega - auto-incremento e chave primária.',
  `CodigoRastreio` INT NOT NULL COMMENT 'Código de rastreamento da empresa de logística.',
  `StatusEntrega` ENUM('Aguardando', 'Em preparação', 'Enviado', 'Em trânsito', 'Saiu para entrega', 'Entregue') NOT NULL DEFAULT 'Aguardando' COMMENT 'Status da entrega: (\'Aguardando\',\'Em preparação\', \'Enviado\', \'Em trânsito\', \'Saiu para entrega\', \'Entregue\') com padrão \'Aguardando\'.',
  `ValorFrete` FLOAT NOT NULL DEFAULT 0 COMMENT 'Valor do frete, padrão 0.00, tipo FLOAT e não nulo.',
  PRIMARY KEY (`idEntrega`))
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`CartoesCredito` (
  `idCartaoCredito` INT NOT NULL AUTO_INCREMENT COMMENT 'ID do cartão, chave primária e auto-incremento.',
  `NomeTitular` VARCHAR(45) NOT NULL COMMENT 'Nome do titular do cartão.',
  `NumeroCartao` VARCHAR(15) NOT NULL COMMENT 'Número do cartão, deve ser único.',
  `Bandeira` VARCHAR(45) NOT NULL COMMENT 'Bandeira do cartão - Visa, Master, etc...',
  `DataValidade` DATE NOT NULL COMMENT 'Data de validade do cartão.',
  `fk_idUsuario` INT NOT NULL COMMENT 'Chave estrangeira do ID do usuário.',
  PRIMARY KEY (`idCartaoCredito`),
  UNIQUE INDEX `NumeroCartao_UNICO` (`NumeroCartao` ASC) VISIBLE,
  UNIQUE INDEX `idCartao_UNICO` (`idCartaoCredito` ASC) VISIBLE,
  INDEX `fk_Pagamentos_Usuarios_idx` (`fk_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamentos_Usuarios`
    FOREIGN KEY (`fk_idUsuario`)
    REFERENCES `L4N0XS_STORE`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`MetodosPagamento` (
  `idMetodo` INT NOT NULL AUTO_INCREMENT COMMENT 'ID do método de pagamento, chave primária e auto-incremento.',
  `TipoPagamento` VARCHAR(45) NOT NULL DEFAULT 'Pix' COMMENT 'Tipo de pagamento. Padrão: Pix, ex: Cartão, Boleto, Débito.',
  PRIMARY KEY (`idMetodo`),
  UNIQUE INDEX `TipoPagamento_UNICO` (`TipoPagamento` ASC) VISIBLE,
  UNIQUE INDEX `idMetodo_UNICO` (`idMetodo` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`Pedidos` (
  `idPedido` INT NOT NULL AUTO_INCREMENT COMMENT 'ID do pedido, chave primária e auto-incremento.',
  `fk_idUsuario` INT NOT NULL COMMENT 'Chave estrangeira da tabela de usuários (idUsuario).',
  `fk_idEntrega` INT NOT NULL COMMENT 'Chave estrangeira da tabela de entregas.',
  `fk_idMetodoPagamento` INT NOT NULL COMMENT 'Chave estrangeira da tabela de métodos de pagamento.',
  `fk_idCartaoCredito` INT NULL COMMENT 'Chave estrangeira do cartão de crédito.',
  `StatusPedido` ENUM('Cancelado', 'Confirmado', 'Em processamento') NOT NULL DEFAULT 'Em Processamento' COMMENT 'Status do pedido pode ser: \'Cancelado\', \'Confirmado\', \'Em processamento\'. Padrão: "Em processamento".',
  `Descricao` VARCHAR(255) NULL COMMENT 'Descrição do produto, campo não obrigatório.',
  `ValorTotal` FLOAT NOT NULL COMMENT 'Valor total do pedido, tipo FLOAT, valor padrão não pode ser nulo.',
  `DataPedido` DATE NOT NULL COMMENT 'Data do pedido, tipo DATE.',
  `NumeroPagamento` VARCHAR(45) NOT NULL COMMENT 'Registro do método de pagamento, seja boleto, débito ou cartão de crédito.',
  PRIMARY KEY (`idPedido`, `fk_idUsuario`, `fk_idEntrega`),
  INDEX `fk_Pedido_Usuario_idx` (`fk_idUsuario` ASC) VISIBLE,
  INDEX `fk_Pedidos_Entregas_idx` (`fk_idEntrega` ASC) VISIBLE,
  INDEX `fk_Pedidos_CartoesCredito_idx` (`fk_idCartaoCredito` ASC) VISIBLE,
  INDEX `fk_Pedidos_MetodosPagamento_idx` (`fk_idMetodoPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Usuario`
    FOREIGN KEY (`fk_idUsuario`)
    REFERENCES `L4N0XS_STORE`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Entregas`
    FOREIGN KEY (`fk_idEntrega`)
    REFERENCES `L4N0XS_STORE`.`Entregas` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_CartoesCredito`
    FOREIGN KEY (`fk_idCartaoCredito`)
    REFERENCES `L4N0XS_STORE`.`CartoesCredito` (`idCartaoCredito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_MetodosPagamento`
    FOREIGN KEY (`fk_idMetodoPagamento`)
    REFERENCES `L4N0XS_STORE`.`MetodosPagamento` (`idMetodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`Produtos` (
  `idProduto` INT NOT NULL AUTO_INCREMENT COMMENT 'Chave primária do tipo auto-incremento, campo produto.',
  `NomeProduto` VARCHAR(20) NOT NULL COMMENT 'Nome do produto, campo obrigatório.',
  `Classificacao` TINYINT NOT NULL DEFAULT 0 COMMENT 'Classificação: 1 se for para crianças, 0 se for para adultos, padrão 0.',
  `Categoria` ENUM('Eletrônico', 'Vestuário', 'Brinquedo', 'Alimento', 'Móvel') NOT NULL COMMENT 'Categoria pode ser: \'Eletrônico\', \'Vestuário\', \'Brinquedo\', \'Alimento\', \'Móvel\', não pode ser nulo.',
  `Tamanho` VARCHAR(10) NULL COMMENT 'Tamanho, campo não obrigatório.',
  `Avaliacao` FLOAT NULL DEFAULT 0 COMMENT 'Avaliação dos clientes, padrão 0, tipo FLOAT.',
  `Preco` FLOAT NOT NULL COMMENT 'Preço do produto.',
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`Fornecedores` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT COMMENT 'ID do fornecedor, campo chave primária e auto-incremento.',
  `RazaoSocial` VARCHAR(255) NOT NULL COMMENT 'Razão social do fornecedor, não pode ser nulo.',
  `CNPJ` CHAR(15) NOT NULL COMMENT 'CNPJ da empresa, tipo CHAR(15), não pode ser nulo e deve ser único.',
  `TelefoneContato` CHAR(11) NOT NULL COMMENT 'Telefone de contato, tipo CHAR(11), não pode ser nulo.',
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNICO` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `idFornecedor_UNICO` (`idFornecedor` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`FornecedoresProdutos` (
  `fk_idFornecedor` INT NOT NULL COMMENT 'Chave estrangeira da tabela de fornecedores.',
  `fk_idProduto` INT NOT NULL COMMENT 'Chave estrangeira da tabela de produtos.',
  `Quantidade` INT NOT NULL COMMENT 'Quantidade adquirida do fornecedor, não nulo.',
  PRIMARY KEY (`fk_idFornecedor`, `fk_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto_idx` (`fk_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`fk_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`fk_idFornecedor`)
    REFERENCES `L4N0XS_STORE`.`Fornecedores` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto`
    FOREIGN KEY (`fk_idProduto`)
    REFERENCES `L4N0XS_STORE`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`Estoques` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT COMMENT 'ID do estoque, tipo auto-incremento e chave primária.',
  `EnderecoEstoque` VARCHAR(255) NOT NULL COMMENT 'Endereço do estoque, não pode ser nulo.',
  `NomeResponsavel` VARCHAR(50) NULL DEFAULT 0 COMMENT 'Nome do responsável.',
  `TelefoneContato` CHAR(11) NULL COMMENT 'Telefone de contato.',
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`ProdutosEstoques` (
  `fk_idProduto` INT NOT NULL COMMENT 'Chave estrangeira da tabela de produtos.',
  `fk_idEstoque` INT NOT NULL COMMENT 'Chave estrangeira da tabela de estoque.',
  `Quantidade` INT NOT NULL COMMENT 'Quantidade em estoque.',
  PRIMARY KEY (`fk_idProduto`, `fk_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque_idx` (`fk_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto_idx` (`fk_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto`
    FOREIGN KEY (`fk_idProduto`)
    REFERENCES `L4N0XS_STORE`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque`
    FOREIGN KEY (`fk_idEstoque`)
    REFERENCES `L4N0XS_STORE`.`Estoques` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`PedidosProdutos` (
  `fk_idProduto` INT NOT NULL COMMENT 'Chave estrangeira da tabela de produtos.',
  `fk_idPedido` INT NOT NULL COMMENT 'Chave estrangeira da tabela de pedidos.',
  `Quantidade` INT NULL DEFAULT 1 COMMENT 'Quantidade solicitada no pedido, padrão 1.',
  `StatusProduto` ENUM('Disponível', 'Sem estoque') NOT NULL DEFAULT 'Disponível' COMMENT 'Status se o produto está disponível ou sem estoque para compra.',
  PRIMARY KEY (`fk_idProduto`, `fk_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido_idx` (`fk_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto_idx` (`fk_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto`
    FOREIGN KEY (`fk_idProduto`)
    REFERENCES `L4N0XS_STORE`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido`
    FOREIGN KEY (`fk_idPedido`)
    REFERENCES `L4N0XS_STORE`.`Pedidos` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`Vendedores` (
  `idVendedor` INT NOT NULL AUTO_INCREMENT COMMENT 'ID do vendedor, auto-incremento e chave primária.',
  `RazaoSocial` VARCHAR(255) NOT NULL COMMENT 'Razão Social do vendedor, não pode ser nulo.',
  `NomeFantasia` VARCHAR(255) NULL COMMENT 'Nome Fantasia, opcional.',
  `CNPJ` CHAR(15) NULL COMMENT 'CNPJ, único, não obrigatório (pode ser um vendedor pessoa física).',
  `CPF` CHAR(11) NULL COMMENT 'CPF, único.',
  `Endereco` VARCHAR(255) NOT NULL COMMENT 'Endereço, não pode ser nulo.',
  `TelefoneContato` CHAR(11) NOT NULL COMMENT 'Telefone de contato, não pode ser nulo.',
  PRIMARY KEY (`idVendedor`),
  UNIQUE INDEX `CNPJ_UNICO` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNICO` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`ProdutosTerceiros` (
  `fk_idVendedor` INT NOT NULL COMMENT 'Chave estrangeira da tabela de vendedores.',
  `fk_idProduto` INT NOT NULL COMMENT 'Chave estrangeira da tabela de produtos.',
  `Quantidade` INT NULL DEFAULT 1 COMMENT 'Quantidade vendida por terceiros.',
  PRIMARY KEY (`fk_idVendedor`, `fk_idProduto`),
  INDEX `fk_Terceiros - Vendedor_has_RelaçãoProduto/Pedido_Rel_idx` (`fk_idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiros - Vendedor_has_RelaçãoProduto/Pedido_Terce_idx` (`fk_idVendedor` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiros - Vendedor_has_RelaçãoProduto/Pedido_Terce`
    FOREIGN KEY (`fk_idVendedor`)
    REFERENCES `L4N0XS_STORE`.`Vendedores` (`idVendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiros - Vendedor_has_RelaçãoProduto/Pedido_Rel`
    FOREIGN KEY (`fk_idProduto`)
    REFERENCES `L4N0XS_STORE`.`PedidosProdutos` (`fk_idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `L4N0XS_STORE`.`Documentos` (
  `idDocumento` INT NOT NULL AUTO_INCREMENT COMMENT 'ID do tipo de documento do usuário.',
  `TipoDocumento` ENUM('CPF', 'CNPJ') NOT NULL DEFAULT 'CPF' COMMENT 'Tipo de documento, pode ser \'CPF\' ou \'CNPJ\'.',
  `NumeroDocumento` VARCHAR(15) NOT NULL COMMENT 'Número do documento, pode ser CPF ou CNPJ, tipo VARCHAR(14), único.',
  `fk_idUsuario` INT NOT NULL COMMENT 'Chave estrangeira da tabela de usuários.',
  PRIMARY KEY (`idDocumento`, `fk_idUsuario`),
  INDEX `fk_Documentos_Usuario_idx` (`fk_idUsuario` ASC) VISIBLE,
  UNIQUE INDEX `NumeroDocumento_UNICO` (`NumeroDocumento` ASC) VISIBLE,
  CONSTRAINT `fk_Documentos_Usuario`
    FOREIGN KEY (`fk_idUsuario`)
    REFERENCES `L4N0XS_STORE`.`Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
