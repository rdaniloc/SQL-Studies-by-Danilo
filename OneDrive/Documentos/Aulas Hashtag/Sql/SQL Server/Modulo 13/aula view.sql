/* Criando a primeira view

Quando falamos em views, existe 3 a��es envolvidas:
1.	Cria��o da View
2.	Altera��o da View
3.	Exclus�o da View

Para cada uma dessas a��es, temos um comando associado:
1.	CREATE VIEW
2.	ALTER VIEW
3.	DROP VIEW*/

-- 1. CREATE VIEW
-- A) Crie uma view contendo as seguintes informa��es da tabela DimCustomer: FirstName, EmailAddress e BirthDate. Chame essa
-- view de vwClientes.

create view vwClientes as
Select
	FirstName,
	EmailAddress,
	BirthDate
from 
	DimCustomer
go

-- b) Crie uma View contendo as seguintes informa��es da tabela DimProduct: ProductKey, ProductName, ProductSubcategory,
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

