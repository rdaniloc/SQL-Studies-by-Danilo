-- Atividade de views

/*
1. 
a) A partir da tabela DimProduct, crie uma View contendo as informa��es de
ProductName, ColorName, UnitPrice e UnitCost, da tabela DimProduct. Chame essa View
de vwProdutos.
b) A partir da tabela DimEmployee, crie uma View mostrando FirstName, BirthDate,
DepartmentName. Chame essa View de vwFuncionarios.
c) A partir da tabela DimStore, crie uma View mostrando StoreKey, StoreName e
OpenDate. Chame essa View de vwLojas.*/
-- a)
create view vwProduto as
select
	ProductName,
	ColorName,
	UnitPrice,
	UnitCost
from 
	DimProduct
go
select * from vwProduto
-- b)
create view vwFuncionarios as
select
	FirstName,
	BirthDate,
	DepartmentName
from
	DimEmployee
go

-- c
create view vwLojas as
select
	StoreKey,
	StoreName,
	OpenDate
from
	DimStore
go

/*
2. Crie uma View contendo as informa��es de Nome Completo (FirstName +
LastName), G�nero (por extenso), E-mail e Renda Anual (formatada com R$).
Utilize a tabela DimCustomer. Chame essa View de vwClientes.
*/

Create view vwCliente as
select
	FirstName + ' ' + LastName as Nome_Completo,
	replace(REPLACE(Gender, 'M', 'Maculino'), 'F', 'Feminino') as 'G�nero',
	EmailAddress as Email,
	format(YearlyIncome, 'C') as 'Renda Anual'
from
	DimCustomer
go
select * from vwCliente
/*
3. 
a) A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Fa�a
um SELECT de todas as colunas. Chame essa View de vwLojasAtivas.
b) A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os
funcion�rios da �rea de Marketing. Fa�a um SELECT das colunas: FirstName, EmailAddress
e DepartmentName. Chame essa de vwFuncionariosMkt.
c) Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e
Litware. Al�m disso, a sua View deve considerar apenas os produtos de cor Silver. Fa�a
um SELECT de todas as colunas da tabela DimProduct. Chame essa View de
vwContosoLitwareSilver.
*/

-- a)
create view vwLojasAtivas as
select  
	*
from 
	DimStore 
where Status = 'On'
go

-- b)
create view vwFuncionariosMKT as
select
	FirstName,
	EmailAddress,
	DepartmentName
from
	DimEmployee
where DepartmentName = 'Marketing'
go

-- c)

create view vwContosoLitwareSilver as
select
	*
from 
	DimProduct
where 
	BrandName in ('Contoso', 'Litware') and 
	ColorName = 'Silver'
go

/*
4. Crie uma View que seja o resultado de um agrupamento da tabela FactSales. Este
agrupamento deve considerar o SalesQuantity (Quantidade Total Vendida) por Nome do
Produto. Chame esta View de vwTotalVendidoProdutos.
OBS: Para isso, voc� ter� que utilizar um JOIN para relacionar as tabelas FactSales e
DimProduct.
*/
select top(3) * from FactSales
go
select * from DimProduct
go

create view vwTotalVendidoProdutos as
select
	FactSales.ProductKey as Id_Produto,	
	ProductName as Nome_Produto,
	SUM(SalesQuantity) as Qtd_Vendida
from DimProduct
inner join FactSales
	on DimProduct.ProductKey = FactSales.ProductKey
group By FactSales.ProductKey, ProductName
Order By Qtd_Vendida desc
go

/*
5. Fa�a as seguintes altera��es nas tabelas da quest�o 1.
a. Na View criada na letra a da quest�o 1, adicione a coluna de BrandName.
b. Na View criada na letra b da quest�o 1, fa�a um filtro e considere apenas os
funcion�rios do sexo feminino.
c. Na View criada na letra c da quest�o 1, fa�a uma altera��o e filtre apenas as lojas
ativas.
*/

-- a)
select * from vwProduto
go

alter view vwProduto as
select
	ProductName,
	BrandName,
	ColorName,
	UnitPrice,
	UnitCost
from
	DimProduct
go

-- b)
select * from vwFuncionarios
go
select * from DimEmployee
go

alter view vwFuncionarios as
select
	FirstName,
	Gender,
	BirthDate,
	DepartmentName
from
	DimEmployee
where Gender = 'F'
go

-- c)
alter view vwLojas as 
select
	StoreKey,
	StoreName,
	Status,
	OpenDate
from
	DimStore
where Status = 'On'
go

/*
6. 
a) Crie uma View que seja o resultado de um agrupamento da tabela DimProduct. O
resultado esperado da consulta dever� ser o total de produtos por marca. Chame essa
View de vw_6a.
b) Altere a View criada no exerc�cio anterior, adicionando o peso total por marca. Aten��o:
sua View final dever� ter ent�o 3 colunas: Nome da Marca, Total de Produtos e Peso Total.
c) Exclua a View vw_6a.
*/

-- a)
create view vw_6a as
select
	BrandName as Marca,
	COUNT(*) as QtdProdutos
from DimProduct
group by BrandName
go

-- b)
alter view vw_6a as
select
	BrandName,
	COUNT(*) as QtdProdutos,
	SUM(Weight) Peso_Total
from 
	DimProduct
group by
	BrandName
go

-- c)
drop view vw_6a