-- 1) Questão

select * from DimProduct
select * from DimProductSubcategory

select
	ProductKey,
	ProductName,
	DimProductSubcategory.ProductSubcategoryKey,
	ProductSubcategoryName
from
	DimProduct
right join DimProductSubcategory
	on DimProductSubcategory.ProductSubcategoryKey = DimProduct.ProductSubcategoryKey

-- 2) Questão

select * from DimProductSubcategory
Select * from DimProductCategory

select
	ProductSubcategoryKey,
	ProductSubcategoryName,
	DimProductCategory.ProductCategoryKey,
	ProductCategoryName
from
	DimProductSubcategory
left join DimProductCategory
	on DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

-- 3) Questão

select * from DimStore
select * from DimGeography

select
	StoreKey,
	StoreName,
	EmployeeCount,
	ContinentName,
	RegionCountryName
from
	DimStore
left join DimGeography
	on DimStore.GeographyKey = DimGeography.GeographyKey

-- 4) Questão

select * from DimProduct
select * from DimProductCategory
select * from DimProductSubcategory

select
	ProductKey,
	ProductName,
	DimProductSubcategory.ProductSubcategoryName,
	DimProductCategory.ProductCategoryName,
	DimProductCategory.ProductCategoryKey
from DimProduct
Left Join DimProductSubcategory
	on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		left join DimProductCategory
			on DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

-- 5) Questão

select top(100) * from FactStrategyPlan
select * from DimAccount

select 
	StrategyPlanKey,
	Datekey,
	AccountName,
	Amount
from 
	FactStrategyPlan
inner join DimAccount
	on FactStrategyPlan.AccountKey = DimAccount.AccountKey

-- 6) Questão

select * from FactStrategyPlan
select
	StrategyPlanKey,
	Datekey,
	ScenarioName,
	Amount
from FactStrategyPlan
inner join DimScenario
	on DimScenario.ScenarioKey = FactStrategyPlan.ScenarioKey

-- 7) Questão
select * from DimProduct
select * from DimProductSubcategory

select
	ProductKey,
	ProductName,
	DimProductSubcategory.ProductSubcategoryKey,
	ProductSubcategoryName
from
	DimProduct
Right join DimProductSubcategory
	on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
where ProductKey is null

-- 8) Questão

select * from DimChannel
Select * from DimProduct
select * from DimProductCategory
Select * from DimProductSubcategory
select * from DimPromotion
select top(100) * from FactSales

select Distinct
	DimProduct.BrandName,
	DimChannel.ChannelName
from DimProduct cross join DimChannel
where BrandName in ('Fabrikam', 'Contoso', 'Litware')

-- 9) Questão

select top(100) * from FactOnlineSales
select * from DimPromotion

select 
	OnlineSalesKey,
	DateKey,
	PromotionName,
	SalesAmount
from FactOnlineSales
left join DimPromotion
	on FactOnlineSales.PromotionKey = DimPromotion.PromotionKey
where PromotionName <> 'No Discount'
order by DateKey asc

-- 10) Questão

select top(1) * from FactSales
select top(1) * from DimChannel
Select top(1) * from DimStore
Select top(1) * from DimProduct


select top(100)
	SalesKey,
	ChannelName,
	StoreName,
	ProductName,
	SalesAmount
from FactSales
Left Join DimChannel
	on FactSales.channelKey = DimChannel.ChannelKey
left join DimStore
	on FactSales.StoreKey = DimStore.StoreKey
left join DimProduct
	on FactSales.ProductKey = DimProduct.ProductKey
order by SalesAmount Desc