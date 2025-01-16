-- 1. Comando Select... From: Retorna todas as linhas da tabela, independente das colunas selecionadas

select top(10) * from DimProduct;

-- 2. Retorna as 10% primeiras linhas da tabela de Clientes.

Select top(10) Percent * from DimCustomer;

select top (1000) * from FactSales;

-- Comando Select Distinct: Retorna os valores distintos de uma tabela

-- Retorne todas as linhas da tabela dimProduct
select * from DimProduct

-- Retorne os valores distintos da coluna colorName da tabela dim Product
select distinct ColorName from DimProduct

-- retorne todas as linhas da tabela dimEmployee
Select * from DimEmployee;

-- Retorne os valores distintos da coluna DepartamentName da tabela dimEmployee
select
	distinct DepartmentName
from
	DimEmployee;

-- Comando AS: Renomeando Colunas (aliasing)

-- Selecione as 3 colunas da tabela dimProduct: ProductName, BrandName e ColorName

select
	ProductName as Produto,
	BrandName as Marca,
	ColorName as Cor
from DimProduct;

-- 1.
-- a)
select
	distinct count(ProductKey)
from DimProduct;

-- tem 2517 produtos cadastrados
-- b)
Select
	distinct count(CustomerKey)
from 
	DimCustomer;
-- A quantidade de clientes diminuiu

-- 2.
select
	CustomerKey as "ID Cliente",
	FirstName as "Primeiro Nome",
	LastName as "Ultimo Nome",
	EmailAddress as "Endereco de Email",
	BirthDate as "Data de Nascimento"
from
	DimCustomer;

--	3º
--	a)
select 
	top(100) *
from DimCustomer;
-- b)
select
	top(10) PERCENT *
from
DimCustomer;

-- c)
select
	FirstName as "Primeiro Nome",
	EmailAddress as "Endereco de Email",
	BirthDate as "Data de Nascimento"
from DimCustomer

-- 4)
select
	distinct Manufacturer
from
	DimProduct;
-- 5)
select distinct ProductKey from FactSales;