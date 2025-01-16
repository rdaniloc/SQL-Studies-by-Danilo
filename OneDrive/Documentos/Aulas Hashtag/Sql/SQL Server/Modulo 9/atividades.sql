-- EXERC�CIO DE FIXA��O GROUP BY MAIS JOIN

-- 1. 
--a) Fa�a um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal de vendas (ChannelName). Voc� deve ordenar a tabela final de acordo com SalesQuantity, em ordem decrescente.

select 
	DimChannel.ChannelName, 
	sum(SalesQuantity) as QtdVendida
from FactSales
inner join DimChannel
	on FactSales.channelKey = DimChannel.ChannelKey
Group by ChannelName
order by QtdVendida desc

-- b) Fa�a um agrupamento mostrando a quantidade total vendida (Sales Quantity) e quantidade total devolvida (Return Quantity) de acordo com o nome das lojas (StoreName).

select
	DimStore.StoreName,
	SUM(SalesQuantity) as QtdVendida,
	SUM(ReturnQuantity) as QtdRetornada
from 
	FactSales
inner join DimStore
	on FactSales.StoreKey = DimStore.StoreKey
group by StoreName
order by StoreName asc

-- c) Fa�a um resumo do valor total vendido (Sales Amount) para cada m�s (CalendarMonthLabel) e ano (CalendarYear).
select top(1) * from FactSales
select 
	CalendarYear,
	CalendarMonthLabel,
	SUM(SalesAmount) as Valor
from DimDate
inner join FactSales
	on DimDate.Datekey = FactSales.DateKey
Group By CalendarYear, CalendarMonthLabel, CalendarMonth
Order By CalendarMonth
-- 2.
-- a) Descubra qual � a cor de produto que mais � vendida (de acordo com SalesQuantity).
select 
	DimProduct.ColorName,
	SUM(SalesQuantity) as QtdVendida
from FactSales
inner join DimProduct
	on FactSales.ProductKey = DimProduct.ProductKey
group by ColorName
order by QtdVendida desc

-- b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.
select
	DimProduct.ColorName,
	SUM(SalesQuantity) as QtdVendida
from FactSales
inner join DimProduct
	on FactSales.ProductKey = DimProduct.ProductKey
group by ColorName
having SUM(SalesQuantity) > 3000000

-- 3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto (ProductCategoryName). Obs: Voc� precisar� fazer mais de 1 INNER JOIN, dado que a rela��o entre FactSales e DimProductCategory n�o � direta.
select
	DimProductCategory.ProductCategoryName as Categoria,
	sum(SalesQuantity) as QtdVendida
from FactSales
inner join DimProduct
	on FactSales.ProductKey = DimProduct.ProductKey
	inner join DimProductSubcategory
		on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
			inner join DimProductCategory
				on DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
group by ProductCategoryName

-- 4. a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o nome completo do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).
select top(1)
	FactOnlineSales.CustomerKey,
	FirstName,
	LastName,
	sum(SalesQuantity) as QtdVendida
from FactOnlineSales
inner join DimCustomer
	on FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
where CustomerType = 'Person'
group by FactOnlineSales.CustomerKey, FirstName, LastName
order by QtdVendida desc

-- b) Feito isso, fa�a um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da letra a, considerando o nome do produto.

select top(10)
	DimProduct.ProductName,
	SUM(SalesQuantity) as QtdVendida
from DimProduct
inner join FactOnlineSales
	on DimProduct.ProductKey = FactOnlineSales.ProductKey
where CustomerKey = 7765
group by ProductName
Order By QtdVendida desc

-- 5. Fa�a um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o sexo dos clientes.
Select 
	Gender,
	SUM(SalesQuantity) as QtdVendida
from DimCustomer
inner join FactOnlineSales
	on DimCustomer.CustomerKey = FactOnlineSales.CustomerKey
group by Gender
having not Gender is null
Order by QtdVendida desc

-- 6. Fa�a uma tabela resumo mostrando a taxa de c�mbio m�dia de acordo com cada CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100.

select
	DimCurrency.CurrencyDescription,
	AVG(AverageRate) as MediadeCambio
from FactExchangeRate
inner join DimCurrency
	on FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
group by CurrencyDescription
having AVG(AverageRate) >= 10 and AVG(AverageRate) <= 100
order by MediadeCambio desc

-- 7. Calcule a SOMA TOTAL de AMOUNT referente � tabela FactStrategyPlan destinado aos cen�rios: Actual e Budget.
select
	DimScenario.ScenarioName,
	sum(Amount) as ValorTotal
from FactStrategyPlan
inner join DimScenario
	on FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
group by ScenarioName
having ScenarioName <> 'Forecast'

-- 8. Fa�a uma tabela resumo mostrando o resultado do planejamento estrat�gico por ano.

select top (1) * from DimDate

select 
	DimDate.CalendarYear,
	SUM(Amount) as ValorTotal 
from FactStrategyPlan
Inner Join DimDate
	on FactStrategyPlan.Datekey = DimDate.Datekey
group by CalendarYear

-- 9. Fa�a um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em considera��o em sua an�lise apenas a marca Contoso e a cor Silver.

select * from DimProduct
select * from DimProductSubcategory
select 
	ProductSubcategoryName,
	COUNT(ProductKey) as QtdProdutos
from DimProductSubcategory
inner join DimProduct
	on DimProductSubcategory.ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
where BrandName = 'Contoso' and ColorName = 'Silver'
Group by ProductSubcategoryName
order by QtdProdutos desc

-- 10. Fa�a um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName. A tabela final dever� ser ordenada de acordo com a coluna BrandName.

Select
	BrandName,
	ProductSubcategoryName,
	COUNT(ProductKey)
from DimProduct
inner join DimProductSubcategory
	on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
group by BrandName, ProductSubcategoryName
order by BrandName asc, ProductSubcategoryName asc  