-- Atividade de views

/*
1. 
a) A partir da tabela DimProduct, crie uma View contendo as informações de
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
2. Crie uma View contendo as informações de Nome Completo (FirstName +
LastName), Gênero (por extenso), E-mail e Renda Anual (formatada com R$).
Utilize a tabela DimCustomer. Chame essa View de vwClientes.
*/

Create view vwCliente as
select
	FirstName + ' ' + LastName as Nome_Completo,
	replace(REPLACE(Gender, 'M', 'Maculino'), 'F', 'Feminino') as 'Gênero',
	EmailAddress as Email,
	format(YearlyIncome, 'C') as 'Renda Anual'
from
	DimCustomer
go
select * from vwCliente
/*
3. 
a) A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Faça
um SELECT de todas as colunas. Chame essa View de vwLojasAtivas.
b) A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os
funcionários da área de Marketing. Faça um SELECT das colunas: FirstName, EmailAddress
e DepartmentName. Chame essa de vwFuncionariosMkt.
c) Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e
Litware. Além disso, a sua View deve considerar apenas os produtos de cor Silver. Faça
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
OBS: Para isso, você terá que utilizar um JOIN para relacionar as tabelas FactSales e
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
5. Faça as seguintes alterações nas tabelas da questão 1.
a. Na View criada na letra a da questão 1, adicione a coluna de BrandName.
b. Na View criada na letra b da questão 1, faça um filtro e considere apenas os
funcionários do sexo feminino.
c. Na View criada na letra c da questão 1, faça uma alteração e filtre apenas as lojas
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
resultado esperado da consulta deverá ser o total de produtos por marca. Chame essa
View de vw_6a.
b) Altere a View criada no exercício anterior, adicionando o peso total por marca. Atenção:
sua View final deverá ter então 3 colunas: Nome da Marca, Total de Produtos e Peso Total.
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