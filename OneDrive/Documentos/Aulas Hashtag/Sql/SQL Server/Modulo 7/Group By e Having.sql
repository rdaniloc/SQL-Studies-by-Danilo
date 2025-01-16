-- Group By com funções de Agregação

select * from DimProduct

select
	BrandName,
	COUNT(*)
from
	DimProduct
Group By BrandName

-- Grupo By parte 2

select
	StoreType,
	SUM(EmployeeCount)
from
	DimStore
group by StoreType

-- Trabalhando com a tabela de Product

select * from DimProduct

select
	BrandName,
	AVG(UnitCost)
from
	DimProduct
Group By BrandName

-- Função MAx

select * from DimProduct

Select
	ClassName,
	Max(UnitPrice)
from
	DimProduct
Group By ClassName

-- Group By com Order By

select * from DimStore

Select
	StoreType,
	SUM(EmployeeCount) as 'Total_Funcionarios'
from
	DimStore
Group By StoreType
Order BY 'Total_Funcionarios' Desc

-- Where + Group By

select * from DimProduct

select
	ColorName as 'Cor do Produto',
	COUNT(*) as 'Total de Produtos'
from
	DimProduct
where BrandName = 'Contoso'
group by ColorName

-- group by + having

select * from DimProduct

select
	BrandName as 'Marca',
	COUNT(BrandName) as 'Total por Marca'
from
	DimProduct
group by BrandName
having COUNT(BrandName) >= 200


-- Where vs Having

select
	BrandName as 'Marca',
	COUNT(BrandName) as 'Total por Marca'
from
	DimProduct
where ClassName = 'Economy' -- Filtra a tabela original, antes do agrupamento
group by BrandName
having COUNT(BrandName) >= 200 -- Filtra a tabela depois do Agrupamento