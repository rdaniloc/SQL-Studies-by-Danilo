-- Fun��es de Agrega��o
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

-- Fun��o Count

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

-- Fun��o Count + Distinct

select * from DimProduct

select
	COUNT(distinct BrandName)
from
	DimProduct

-- Fun��es Min e Max

select * from DimProduct

select
	MAX(UnitCost) as 'Custo Maximo',
	min(UnitCost) as 'Custo Minimo'
from
	DimProduct

-- Fun��o AVG

select * from DimCustomer

select
	AVG(YearlyIncome) as 'M�dia Anual de Sal�rio'
from
	DimCustomer

