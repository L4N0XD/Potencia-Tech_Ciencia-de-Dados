-- Clientes
INSERT INTO Clientes (ID, Nome, Endereco, Telefone)
VALUES
    (1, 'Taylan', 'Rua A, 123', '(11) 1234-5678'),
    (2, 'Maria', 'Av. B, 456', '(22) 9876-5432');

-- Veiculos
INSERT INTO Veiculos (ID, Placa, Modelo, AnoFabricacao, ClienteID)
VALUES
    (1, 'ABC1234', 'Carro A', 2020, 1),
    (2, 'XYZ5678', 'Carro B', 2019, 2);

-- Servicos
INSERT INTO Servicos (ID, NomeServico, Preco)
VALUES
    (1, 'Troca de Óleo', 100.00),
    (2, 'Reparo no Motor', 250.00);

-- Mecanicos
INSERT INTO Mecanicos (ID, Nome, Especialidade)
VALUES
    (1, 'João', 'Mecânico de Motor'),
    (2, 'Maria', 'Mecânica Geral');

-- Ordens de Servico
INSERT INTO OrdensServico (ID, DataInicio, DataConclusao, ClienteID, VeiculoID, MecanicoID)
VALUES
    (1, '2023-08-01', '2023-08-05', 1, 1, 1),
    (2, '2023-08-02', NULL, 2, 2, 2);

-- Pecas
INSERT INTO Pecas (ID, NomePeca, Estoque, Preco)
VALUES
    (1, 'Filtro de Óleo', 50, 10.00),
    (2, 'Vela de Ignição', 100, 5.00);

-- PecasOrdemServico
INSERT INTO PecasOrdemServico (OrdemServicoID, PecaID, Quantidade)
VALUES
    (1, 1, 2),
    (1, 2, 4),
    (2, 1, 3);
