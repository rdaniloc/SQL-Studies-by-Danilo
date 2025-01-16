SELECT TOP(100) * FROM DimStore
order by EmployeeCount asc;

-- EXEMPLO 1: SELECIONE AS 10 PRIMEIRAS LINHAS DA TABELA DIMPRODUCT E ORDENE DE ACORDO COM A UNITCOST

select * from DimProduct

SELECT
	top(10) ProductName,
	UnitCost,
	Weight
from
	DimProduct
Order By UnitCost Desc, Weight desc;

select * from DimProduct;

select top (1) UnitPrice from DimProduct
order by UnitPrice desc

-- QUANTOS PRODUTOS TEM UM PREÇO UNITÁRIO MAIOR QUE $1000,00

SELECT
	ProductName as "Produto",
	UnitPrice as "Preço"
from
	DimProduct
where UnitPrice >= 2000

-- select * from DimProduct
-- select distinct BrandName from DimProduct;
select * from DimProduct
where BrandName = 'Fabrikam'

select * from DimProduct
where ColorName = 'Black'

-- Quantos clientes nasceram após o dia 31/12/1970

select * from DimCustomer
where BirthDate >= '1970-12-31'
order by BirthDate Desc;

-- Usando Where e And

Select * from DimProduct

select *
from DimProduct
where BrandName = 'Fabrikam' and ColorName = 'Black';

select *
from DimProduct
Where BrandName = 'Contoso' or
	ColorName = 'White';

select *
from DimProduct
Where BrandName = 'Contoso' or
	BrandName = 'Fabrikam';

-- Operador Not

select * from DimEmployee
where not DepartmentName = 'Marketing';

-- Exercícios de fixação: And, Or e Not

-- 1. Selecione todas as linhas da tabela dimEmployee dos funcionários do seo feminino e do departamento de finanças.

select 
	* 
from 
	DimEmployee
where
	Gender = 'F' and
	DepartmentName = 'Finance';

-- 2. Selecione todas as linhas da tabela dimProduct de produtos da marca Contoso e da cor Vermelha e que tenham um UnitPrice maior ou igual a $100.

select 
	* 
from 
	DimProduct
where
	BrandName = 'Contoso' and
	ColorName = 'Red' and
	UnitPrice >= 100;

-- 3. Selecione todas as linhas da tabela dimProduct com produtos da marca Litware ou da marca Fabrikam ou da cor Preta

select
	*
from
	DimProduct
where
	BrandName = 'Litware' or
	BrandName = 'Fabrikam' or
	ColorName = 'Black';
-- 4. Selecione todas as linhas da tabela DimSalesTerritory onde o continente é a Europa mas o país não é igual a Itália

select
	*
from
	DimSalesTerritory
where
	SalesTerritoryGroup = 'Europe' and
	not SalesTerritoryCountry = 'Italy';

-- Cuidados ao utilizar o AND em conjunto com o OR

-- Exemplo: Selecione todas as linhas da tabela DimProduct onde a cor do Produto pode ser igual a Preto ou Vermelho, mas a marca deve ser obrigatoriamente igual a Fabrikam.

select * from DimProduct
where (ColorName = 'Black' or ColorName = 'Red') and BrandName = 'Fabrikam'

-- Trabalhando com a tabela de produtos

select * from DimProduct
where ColorName in ('Silver', 'Blue', 'White', 'Black')

-- Trabalhando com a tabela de empregados

select * from DimEmployee
where DepartmentName in ('Production', 'Marketing', 'Engineering')

-- Comando Like

select * from DimProduct
where ProductName like '%MP3 Player%' 

select * from DimProduct
where ProductDescription like 'Type%';

-- Usando o comando Between;

select * from DimProduct
where UnitPrice not between 50 and 100

select * from DimEmployee
where HireDate between '2000-01-01' and '2000-12-31'

-- Utilização do Not Null ou Is Null
select * from DimCustomer
where CompanyName is not null

select * from DimCustomer
where CompanyName is null
