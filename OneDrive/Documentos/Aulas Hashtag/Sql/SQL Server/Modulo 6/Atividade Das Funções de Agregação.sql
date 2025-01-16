-- Atividade do Modulo 6

-- 1.
select 
	SUM(SalesQuantity) as 'Qtd Vendida',
	SUM(ReturnQuantity) as 'Qtd Devolvida'
from 
	FactSales
where channelKey = 1

-- 2.
select
	AVG(YearlyIncome) as 'Média Salarial'
from
	DimCustomer
where
	Occupation = 'Professional'

-- 3
-- a) Loja com o maior número de funcionários
select
	StoreName,
	EmployeeCount
from
	DimStore
where EmployeeCount = 325
-- b) Loja com o menor número de funcionários
select
	StoreName,
	EmployeeCount
from
	DimStore
where
	EmployeeCount = 7

-- 4.

select * from DimEmployee
-- A ) Quantidade total de funcionários do Sexo Masculino
select
	COUNT(Gender) as 'Qtd Func Masculunos'
from
	DimEmployee
where
	Gender = 'M'

-- B) Funcionários dos sexo Feminino

select
	COUNT(Gender) as 'QTD Func Feminino'
from
	DimEmployee
where
	Gender = 'F'

-- C) Funcionário mais antigo

select 
	CONCAT(FirstName, ' ', LastName) as Nome,
	EmailAddress as Email,
	StartDate as Data_Contratacao
from
	DimEmployee
where
	Gender = 'M' and
	StartDate = '1996-07-31'

-- D) Funcionária mais antiga

select
	CONCAT(FirstName, ' ', LastName) as Nome,
	EmailAddress as Email,
	StartDate as Data_Contratacao
from
	DimEmployee
Where
	Gender = 'F' and
	StartDate = '1998-01-26'

-- 5.
select * from DimProduct
 
-- A) Quantidade distinta

select
	COUNT(distinct(ColorName)) as Qtd_Cores,
	COUNT(distinct(BrandName)) as Qtd_Marcas,
	COUNT(distinct(ClassName)) as Qtd_Classe
from
	DimProduct