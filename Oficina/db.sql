
CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco VARCHAR(255),
    Telefone VARCHAR(15)
);

CREATE TABLE Veiculos (
    ID INT PRIMARY KEY,
    Placa VARCHAR(10) UNIQUE,
    Modelo VARCHAR(50),
    AnoFabricacao INT,
    ClienteID INT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);

CREATE TABLE Servicos (
    ID INT PRIMARY KEY,
    NomeServico VARCHAR(100),
    Preco DECIMAL(10, 2)
);

CREATE TABLE OrdensServico (
    ID INT PRIMARY KEY,
    DataInicio DATE,
    DataConclusao DATE,
    ClienteID INT,
    VeiculoID INT,
    MecanicoID INT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID),
    FOREIGN KEY (VeiculoID) REFERENCES Veiculos(ID),
    FOREIGN KEY (MecanicoID) REFERENCES Mecanicos(ID)
);

CREATE TABLE Mecanicos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Especialidade VARCHAR(100)
);

CREATE TABLE Pecas (
    ID INT PRIMARY KEY,
    NomePeca VARCHAR(100),
    Estoque INT,
    Preco DECIMAL(10, 2)
);

CREATE TABLE PecasOrdemServico (
    OrdemServicoID INT,
    PecaID INT,
    Quantidade INT,
    FOREIGN KEY (OrdemServicoID) REFERENCES OrdensServico(ID),
    FOREIGN KEY (PecaID) REFERENCES Pecas(ID)
);

