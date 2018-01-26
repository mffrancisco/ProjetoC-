
IF DB_ID('CursoFerias') IS NOT NULL 
	DROP DATABASE CursoFerias

IF @@ERROR = 3702 
	PRINT('Banco de Dados não pode ser dropado, pois existem conexões am aberto.')

CREATE DATABASE CursoFerias
GO

USE CursoFerias
GO

CREATE TABLE Enderecos
(
	CodigoEndereco int primary key identity(1,1),
	Cep	int NOT NULL,
	Logradouro varchar(50) NOT NULL,
	Bairro varchar(30) NOT NULL,
	Cidade varchar(30) NOT NULL,
	UF char(2) NOT NULL
)

CREATE TABLE Clientes
(
	CodigoCliente int primary key identity(1,1),
	CodigoEndereco int foreign key references Enderecos(CodigoEndereco),
	CPF varchar(14) NOT NULL,
	Nome varchar(50) NOT NULL,
	Telefone varchar(15),
	Email varchar(50),
	Numero smallint NOT NULL,
	Complemento varchar(30)
)
		
CREATE TABLE Vendas
(
	CodigoVenda int primary key identity(1,1),
	CodigoCliente int foreign key references Clientes(CodigoCliente),
	DataVenda datetime NOT NULL,
	SubTotal decimal(10,2) NOT NULL,
	Desconto decimal(10,2),
	Total decimal(10,2) NOT NULL,
	Entrega char(1)
)

CREATE TABLE EnderecoEntrega
(
	CodigoEndereco int foreign key references Enderecos(CodigoEndereco),
	CodigoVenda	int foreign key references Vendas(CodigoVenda),
	Numero smallint NOT NULL,
	Complemento varchar(30),
	CONSTRAINT PK_EnderecoEntrega PRIMARY KEY(CodigoEndereco, CodigoVenda)
)

CREATE TABLE Produtos
(
	CodigoProduto int primary key identity(1,1),
	Nome varchar(50) NOT NULL,
	Preco decimal(10,2) NOT NULL,
	Estoque smallint NOT NULL
)

CREATE TABLE HistoricoProdutos
(
	CodigoHistorico int primary key identity(1,1),
	CodigoProduto	int,
	Nome varchar(50) NOT NULL,
	Preco decimal(10,2) NOT NULL,
	Estoque smallint NOT NULL
)

CREATE TABLE VendaItens
(
	CodigoVenda	int foreign key references Vendas(CodigoVenda),
	CodigoProduto int foreign key references Produtos(CodigoProduto),
	QuantidadeVendida smallint NOT NULL,
	CONSTRAINT PK_VendaItens PRIMARY KEY(CodigoVenda, CodigoProduto)
)
			