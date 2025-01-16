-- Exercícios Do Modulo 7

-- 1.
select top (100) * from FactSales

-- A) Quantidade Vendida de acordo com o canal de vendas
select
	channelKey,
	SUM(SalesQuantity) as QTD_Vendida
from 
	FactSales
group by channelKey 

-- B) Quantidade vendida e devolvida de acordo por loja

select
	storeKey,
	SUM(SalesQuantity) as Qtd_Vendida,
	SUM(ReturnQuantity) as Qtd_Devolvida
from
	FactSales
group by storeKey

-- C) Quantidade Vendida e Retornada por canal de vendas no ano de 2007

select
	channelKey,
	SUM(SalesAmount) as Faturamento_Total
from
	FactSales 
where
	DateKey between '20070101' and '20071231'
group by channelKey

-- 2.

select
	ProductKey,
	SUM(SalesAmount) as Valor_das_Vendas
from
	FactSales
group by ProductKey
Order by Valor_das_Vendas desc

-- a) Tabela ordenada de acordo com a quantidade vendida e com o resultado de vendas maior que $5.000.000

select 
	ProductKey,
	SUM(SalesAmount) as Valor_Vendas
from
	FactSales
group by ProductKey
having SUM(SalesAmount) >= 5000000
order by SUM(SalesAmount) desc

-- b) Top 10 produtos com maior vendas

select top (10)
	ProductKey,
	SUM(SalesAmount) as Faturamento_Total 
from
	FactSales
group by ProductKey
Order By Faturamento_Total desc

select top (100) * from FactSales

-- 3.
-- A) Id do cliente que mais realizou compras online
select top (1)
	CustomerKey,
	SUM(SalesQuantity) as Qtd_Vendida
from
	FactOnlineSales
group by CustomerKey
Order by Qtd_Vendida desc

-- B) Os 3 produtos mais comprados pelo cliente da pergunta A
select top (3)
	ProductKey,
	SUM(SalesQuantity) as Qtd_Vendida
from
	FactOnlineSales
where CustomerKey = 19037
group By ProductKey
order By Qtd_Vendida desc

-- 4.
-- A) Faça um agrupamento e descubra a quantidade total de produtos por marca
select 
	BrandName,
	count(ProductKey) as Qtd_Produtos
from
	DimProduct
group by BrandName

-- B) Média de preço unitário por classe

select
	ClassName,
	AVG(UnitPrice) as Preco_Unitario
from
	DimProduct
group by ClassName
order by Preco_Unitario desc

-- C) Peso total que cada cor de produto possuí

select
	ColorName,
	SUM(Weight) as Peso_Total
from
	DimProduct
group by ColorName
order By Peso_Total desc

-- 5.
select
	StockTypeName,
	SUM(Weight) as Peso_Total
from
	DimProduct
where BrandName = 'Contoso'
group by StockTypeName
order by Peso_Total desc

-- 6.
-- a) Quantidade total de cores
select count(distinct(ColorName)) from DimProduct

-- b) Quantidade de cores que cada marca possui
select
	BrandName,
	COUNT(distinct(ColorName)) as Qtd_Cores
from 
	DimProduct
group by
	BrandName
order by Qtd_Cores desc

-- 7.
select
	Gender,
	COUNT(CustomerKey) as Qtd_Clientes,
	AVG(YearlyIncome) as Média_Salarial
from 
	DimCustomer
group by 
	Gender
having Gender is not null
order by
	Qtd_Clientes desc,
	Média_Salarial desc

-- 8.
select 
	Education,
	COUNT(CustomerKey) as Qtd_Clientes,
	AVG(YearlyIncome) as Media_Salarial
from DimCustomer
where Education is not null
group by Education
order by 
	Qtd_Clientes desc, 
	Media_Salarial desc

-- 9.
select 
	DepartmentName,
	COUNT(EmployeeKey) as Qtd_Funcionários
from DimEmployee
where Status is not null
group by DepartmentName
order by Qtd_Funcionários desc

-- 10.
select
	Title,
	Sum(VacationHours) as Qtd_Horas
from DimEmployee
where
	Gender = 'F' and
	DepartmentName in ('Production', 'Marketing', 'Engineering', 'Finance') and
	StartDate between '1999-01-01' and '2000-12-31'
group by Title
order by Qtd_Horas desc

