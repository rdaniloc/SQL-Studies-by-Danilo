-- Exercícios do Módulo 4
use ContosoRetailDW 
-- 1.

select 
	TOP (100) 
	* 
from 
	FactSales
Order by 
	SalesAmount DESC;

-- 2.
SELECT top (10)
	ProductKey,
	ProductName,
	ProductDescription,
	Size,
	Weight,
	UnitPrice
from 
	DimProduct
order by 
	UnitPrice desc, 
	Weight desc,
	AvailableForSaleDate Asc;

-- 3.

select
	ProductName as 'Nome do Produto',
	Weight as 'Peso'
from
	DimProduct
where
	Weight >= 100
order by
	Weight Desc;

-- 4.
select 
	StoreName as 'Nome da Loja',
	OpenDate as 'Data de Abertura',
	EmployeeCount as 'Quantidade de Empregados'
from
	DimStore
where
	CloseDate is null;

-- 5.

select 
	*
from 
	DimProduct
where 
	(BrandName = 'Litware') and 
	ProductName like '%Home Theater%' and 
	AvailableForSaleDate = '20090315'

-- 6.

select
	StoreName,
	StoreDescription,
	Status
from
	DimStore
where
	CloseDate is not null;

-- 7.
-- A) Categoria 1
select 
	StoreName,
	StoreDescription,
	EmployeeCount
from 
	DimStore
where 
	EmployeeCount <= 20
-- B) Categoria 2
select
	StoreName,
	StoreDescription,
	EmployeeCount
from
	DimStore
where
	EmployeeCount between 21 and 50
-- C) Categoria 3
select
	StoreName,
	StoreDescription,
	EmployeeCount
from
	DimStore
where
	EmployeeCount > 50;

-- 8.
select
	ProductKey,
	ProductName,
	ProductDescription,
	UnitPrice
from
	DimProduct
Where
	ProductDescription like '%LCD%'
-- 9.
select
	ProductName,
	BrandName,
	ColorName,
	UnitPrice
from 
	DimProduct
where 
	(BrandName in ('Contoso', 'litware', 'Fabrikam')) and 
	ColorName in ('Green', 'Orange', 'Black', 'Silver', 'Pink');

-- 10.

select 
	* 
from 
	DimProduct
where
	BrandName = 'Contoso' and
	ColorName = 'Silver' and
	Weight between 10 and 30
order by
	UnitPrice desc