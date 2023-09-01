# Desafio de Projeto Lógico Para Banco de Dados:
## Potência Tech powered by iFood | Ciência de Dados

## Esquema ER (E-Commerce):
<img src="/e-commerce/img/modelo.png" alt="Modelo"/>

## Explicando (E-Commerce):
O desafio consiste em replicar a modelagem de um banco de dados para um cenário de e-commerce, levando em consideração os conceitos de chave primária, chave estrangeira e constraints. Além disso, devemos aplicar o mapeamento de modelos aos refinamentos propostos no módulo de modelagem conceitual.

### Cenário Modelado(E-Commerce):

O cenário modelado envolve um e-commerce com diversas entidades, incluindo Usuários (clientes), Pedidos, Produtos, Fornecedores, Estoques, Vendedores, Documentos, Métodos de Pagamento e Entregas.

### Refinamentos Propostos(E-Commerce):

Cliente PJ e PF: Agora, um cliente pode ser uma Pessoa Jurídica (PJ) ou Pessoa Física (PF), mas não ambas. Isso implica em uma distinção entre tipos de clientes e suas informações.

Pagamento: Cada cliente pode ter mais de uma forma de pagamento cadastrada, permitindo flexibilidade nas transações.

Entrega: A entidade de Entrega possui status e código de rastreio, proporcionando informações sobre o processo de entrega.

## Queries SQL (E-Commerce):

A seguir, algumas das queries SQL que podem ser utilizadas para obter informações do banco de dados modelado:

### 1. Quantos pedidos foram feitos por cada cliente?
> SELECT U.PrimeiroNome, U.Sobrenome, COUNT(P.idPedido) AS TotalPedidos
> FROM Usuarios U
> LEFT JOIN Pedidos P ON U.idUsuario = P.fk_idUsuario
> GROUP BY U.idUsuario;

### 2. Alguns vendedores também são fornecedores?
> SELECT V.RazaoSocial AS NomeVendedor, F.RazaoSocial AS NomeFornecedor
> FROM Vendedores V
> INNER JOIN Fornecedores F ON V.CNPJ = F.CNPJ;

### 3. Relação de produtos fornecedores e estoques:
> SELECT F.RazaoSocial AS Fornecedor, P.NomeProduto AS Produto, PE.Quantidade AS QuantidadeEmEstoque
> FROM FornecedoresProdutos FP
> INNER JOIN Fornecedores F ON FP.fk_idFornecedor = F.idFornecedor
> INNER JOIN Produtos P ON FP.fk_idProduto = P.idProduto
> INNER JOIN ProdutosEstoques PE ON PE.fk_idProduto = P.idProduto;

### 4. Relação de nomes dos fornecedores e nomes dos produtos:
> SELECT F.RazaoSocial AS Fornecedor, P.NomeProduto AS Produto
> FROM FornecedoresProdutos FP
> INNER JOIN Fornecedores F ON FP.fk_idFornecedor = F.idFornecedor
> INNER JOIN Produtos P ON FP.fk_idProduto = P.idProduto;

### 5. Qual é o total de vendas de cada vendedor?
> SELECT V.RazaoSocial AS Vendedor, SUM(PP.Quantidade) AS TotalVendas
> FROM Vendedores V
> LEFT JOIN ProdutosTerceiros PT ON V.idVendedor = PT.fk_idVendedor
> LEFT JOIN PedidosProdutos PP ON PT.fk_idProduto = PP.fk_idProduto
> GROUP BY V.idVendedor;

### 6. Quais são os produtos em estoque e suas quantidades?
> SELECT P.NomeProduto, PE.Quantidade
> FROM Produtos P
> INNER JOIN ProdutosEstoques PE ON P.idProduto = PE.fk_idProduto;

### 7. Qual é o valor total de pedidos por método de pagamento?
> SELECT MP.TipoPagamento, SUM(P.ValorTotal) AS TotalPorMetodo
> FROM MetodosPagamento MP
> LEFT JOIN Pedidos P ON MP.idMetodo = P.fk_idMetodoPagamento
> GROUP BY MP.idMetodo;

### 8. Qual é o status de entrega atual de cada pedido?
> SELECT E.StatusEntrega, COUNT(P.idPedido) AS TotalPedidos
> FROM Entregas E
> LEFT JOIN Pedidos P ON E.idEntrega = P.fk_idEntrega
> GROUP BY E.StatusEntrega;

## Esquema ER (Oficina):
<img src="/Oficina/img/modelo.png" alt="Modelo"/>

## Explicando (Oficina):
Neste projeto, foi desenvolvido um banco de dados relacional para uma oficina mecânica com base em um esquema conceitual previamente elaborado. O objetivo principal foi criar o esquema lógico do banco de dados e implementá-lo em um sistema de gerenciamento de banco de dados (SGBD) MySQL. Em seguida, foram realizadas consultas SQL para demonstrar a funcionalidade do banco de dados.


## Queries SQL (Oficina):
A seguir, algumas das queries SQL que podem ser utilizadas para obter informações do banco de dados modelado:

### 1. Recuperação de todos os serviços realizados em uma ordem de serviço específica.
>SELECT OS.ID AS OrdemServico, S.NomeServico, S.Preco
>FROM OrdensServico OS
>INNER JOIN Servicos S ON OS.ServicoID = S.ID
>WHERE OS.ID = 1;

### 2. Recuperação do total gasto por um cliente em serviços.
>SELECT C.Nome AS Cliente, SUM(S.Preco) AS TotalGasto
>FROM Clientes C
>INNER JOIN OrdensServico OS ON C.ID = OS.ClienteID
>INNER JOIN Servicos S ON OS.ServicoID = S.ID
>GROUP BY C.Nome;

### 3. Lista de veículos que já foram atendidos por um mecânico específico.
>SELECT M.Nome AS Mecanico, V.Placa, V.Modelo
>FROM Mecanicos M
>INNER JOIN OrdensServico OS ON M.ID = OS.MecanicoID
>INNER JOIN Veiculos V ON OS.VeiculoID = V.ID
>WHERE M.Nome = 'João';

### 4. Peças mais utilizadas em ordens de serviço.
>SELECT P.NomePeca, SUM(POS.Quantidade) AS TotalUtilizado
>FROM PecasOrdemServico POS
>INNER JOIN Pecas P ON POS.PecaID = P.ID
>GROUP BY P.NomePeca
>HAVING SUM(POS.Quantidade) > 10;

### 5. Lista de mecânicos disponíveis para uma nova ordem de serviço.
>SELECT M.Nome AS Mecanico, M.Especialidade
>FROM Mecanicos M
>LEFT JOIN OrdensServico OS ON M.ID = OS.MecanicoID
>WHERE OS.ID IS NULL;