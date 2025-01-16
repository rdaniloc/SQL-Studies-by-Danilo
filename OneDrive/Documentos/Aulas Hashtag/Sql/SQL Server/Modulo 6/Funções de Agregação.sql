-- Funções de Agregação
-- 1- Sum
select 
	top (100) *
from
	FactSales

select
	SUM(SalesQuantity) as 'Quantidade Vendida',
	SUM(ReturnQuantity) as 'Total Devolvido'
from
	FactSales

-- Função Count

select * From DimProduct

select
	COUNT(*) as 'Total de Produtos'
from
	DimProduct

select
	COUNT(ProductName) as 'Qtd Produtos'
from
	DimProduct

select
	COUNT(Size)
from
	DimProduct

-- Função Count + Distinct

select * from DimProduct

select
	COUNT(distinct BrandName)
from
	DimProduct

-- Funções Min e Max

select * from DimProduct

select
	MAX(UnitCost) as 'Custo Maximo',
	min(UnitCost) as 'Custo Minimo'
from
	DimProduct

-- Função AVG

select * from DimCustomer

select
	AVG(YearlyIncome) as 'Média Anual de Salário'
from
	DimCustomer

