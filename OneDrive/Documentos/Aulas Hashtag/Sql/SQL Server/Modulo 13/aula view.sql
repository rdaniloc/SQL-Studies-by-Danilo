/* Criando a primeira view

Quando falamos em views, existe 3 ações envolvidas:
1.	Criação da View
2.	Alteração da View
3.	Exclusão da View

Para cada uma dessas ações, temos um comando associado:
1.	CREATE VIEW
2.	ALTER VIEW
3.	DROP VIEW*/

-- 1. CREATE VIEW
-- A) Crie uma view contendo as seguintes informações da tabela DimCustomer: FirstName, EmailAddress e BirthDate. Chame essa
-- view de vwClientes.

create view vwClientes as
Select
	FirstName,
	EmailAddress,
	BirthDate
from 
	DimCustomer
go

-- b) Crie uma View contendo as seguintes informações da tabela DimProduct: ProductKey, ProductName, ProductSubcategory,
-- BrandName e UnitPrice. Chame essa view de vwProdutos.

create view vwProdutos as
select
	ProductKey,
	ProductName,
	ProductSubcategoryKey,
	BrandName,
	UnitPrice
from 
	DimProduct
go

-- 2.	ALTER VIEW
-- a) Altere a View criada no exemplo 1a para incluir apenas os clientes do sexo Feminino
select * from vwClientes
go

Alter view vwClientes as
select
	FirstName,
	EmailAddress,
	BirthDate,
	Gender
from
	DimCustomer
where Gender = 'F'
go

-- b) Altere a View criada no exemplo 1b para iniciar apenas os produtos da subcategoria 'Televisions'.



-- 3. DROP VIEW
-- Exclua a view vwClientes e vwProdutos

drop view vwClientes

