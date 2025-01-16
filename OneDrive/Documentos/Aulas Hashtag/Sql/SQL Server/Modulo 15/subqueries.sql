-- SUBQUERIES

/*
1. O QUE � UMA SUBQUERY?

UMA SUBQUERY (OU SUBCONSULTA OU SUBSELECT) NADA MAIS � DO QUE UMA CONSULTA DENTRO DE OUTRA CONSULTA. OU SEJA, COM UMA SUBQUERY
CONSEGUIMO UTILIZAR O RESULTADO DE UMA QUERY (CONSULTA OU SELECT) DENTRO DE OUTRA CONSULTA/SELECT.

EM RESUMO, UMA SUBQUERY � UM SELECT DENTRO DE OUTRO SELECT

2. ONDE UTILIZAMOS UMA SUBQUERY?

SUBQUERIES PODEM SER UTILIZADAS EM 3 SITUA��ES POSS�VEIS

1. JUNTO COM O WHERE, FUCIONANDO COMO UM FILTRO VARI�VEL
2. JUNTO COM O SELECT, COMO UMA NOVA COLUNA NA TABELA
3. JUNTO COM O FROM, COMO UMA NOVA TABELA


EX:
IMAGINA QUE EU QEURO SELECIONAR OS PRODUTOS COM O PRE�O MAIOR DO QUE A MEDIA.

1� PASSO: DESCOBRIR A M�DIA

SELECT AVG(UNITPRICE) FROM DIMPRODUCT

2� PASSO: FILTRAR A NOSSA TABELA UTILIZANDO O WHERE

SELECT
	*
FROM
	DIMPRODUCT
WHERE UNITPRICE > (SELECT AVG(UNITPRICE) FROM DIMPRODUCT)


3. ALGUNS EXEMPLOS...

EM 4 SITUA��ES POSS�VEIS:
1-SUBQUERY JUNTO COM UM WHERE, COMO UM FILTRO DIN�MICO E ESCALAR (VALOR �NICO)
SELECT
	COLUNA 1,
	COLUNA 2
FROM
	TABELA
WHERE COLUNA 1 = (SELECT)

2 - SUBQUERY JUNTO COM UM WHERE, COMO UM FILTRO DIN�MICO E EM LISTA (V�RIOS VALORES)
SELECT
	COLUNA 1,
	COLUNA 2
FROM
	TABELA
WHERE COLUNA 1 IN (SELECT)

3 - SUBQUERY JUNTO COM UM SELECT, COMO UMA NOVA COLUNA

SELECT
	COLUNA1,
	COLUNA2,
	(SELECT)
FROM 
	TABELA

4 - SUBQUERY JUNTO COM UM FROM, COMO UMA NOVA TABELA

SELECT
	COLUNA1,
	COLUNA2,
FROM
	(SELECT) AS TABELAAUXILIAR


PARA ENTENDER A IDEIA POR TR�S DAS SUBQUERIES, VAMOS COME�AR FAZENDO 3 EXEMPLOS COM A APLICA��O WHERE.

NO EXEMPLO 1, IMAGINE QUE VOC� QUEIRA FAZER UMA CONSULTA � TABELA DIMPRODUCT E CONSIDERAR APENAS OS PRODUTOS COM CUSTOS ACIMA DA
M�DIA. COMO PODER�AMOS FAZER ISSO?
*/

select AVG(UnitCost) from DimProduct

select
	*
from
	DimProduct
where UnitCost >= (select AVG(UnitCost) from DimProduct)

/*
Para entender a ideia por tr�s da subqueries, vamos come�ar fazendo 3 exemplos com a aplica��o where.

No exemplo 2, queremos filtrar nossa tabela DimProduct e retornar os produtos da categoria 'Televisions'. Por�m, n�o temos a
informa��o de nome da subcategoria na tabela DimProduct. Dessa froma, precisaremos criar um select que descubra o ID da categoria
'Televisions', e passar esse resultado como o valor que queremos filtrar dentro do where.
*/

select * from DimProduct
where ProductSubcategoryKey =
	(select ProductSubcategoryKey from DimProductSubcategory
		where ProductSubcategoryName = 'Televisions')

/*
Para entender a ideia por tr�s das subqueries, vamos come�ar fazendo 3 exemplos com a aplica��o where.

No exemplo 3, queremos filtrar nossa tabela FactSales e mostrar apenas as vendas referentes �s lojas com 100 ou mais 
funcion�rios.
*/

select
	StoreKey
from
	DimStore
where EmployeeCount >= 100

select
	* 
from 
	FactSales
where 
	StoreKey in (
		select
			StoreKey
		from
			DimStore
		where EmployeeCount >= 100)
go
-- Any, Some e All

select * from funcionarios

-- Selecione os funcion�rios do sexo masculino(Mas, utilizando a coluna idade para isso)

go
select * from funcionarios
where idade in (select idade from funcionarios where sexo = 'M')
go

-- ANY(Valor 1, Valor2, Valor3):
-- Equivalente ao in, retorna as linhas da tabela que seja iguais ao valor 1, ou valor 2, ou valor 3

select * from funcionarios
where idade = any (select idade from funcionarios where sexo = 'M')

select * from funcionarios
where idade > some (select idade from funcionarios where sexo = 'M')

-- any e some s�o equivalentes

select * from funcionarios
where idade > all (select idade from funcionarios where sexo = 'M')

-- all(Valor 1, Valor2, Valor3):
-- retorna as linhas da tabela valores menos que o valor 1, e valor 2, e valor 3

-- Exists 
-- Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) que possuem alguma venda no dia 01/01/20027

select COUNT(*) from DimProduct

select top(100) * from FactSales

select
	ProductKey,
	ProductName
from
	DimProduct
where exists(
	select
		distinct ProductKey
	from
		FactSales
	where 
		DateKey = '01/01/2007'
		and FactSales.ProductKey = DimProduct.ProductKey
	)

-- Pode ser escrito assim tamb�m

select
	ProductKey,
	ProductName
from
	DimProduct
where ProductKey = any (
	select
		distinct ProductKey
	from
		FactSales
	where 
		DateKey = '01/01/2007'
	)

-- Subqueries: SELECT
-- Retorna uma tabela com todos os produtos (UD Produto e Nome Produto) e tamb�m o total de vendas para cada produto

select
	ProductKey,
	ProductName,
	(select COUNT(ProductKey) from FactSales where FactSales.ProductKey = DimProduct.ProductKey) as Qtd_Vendas
from 
	DimProduct

-- Subqueries: From
-- Retorna a quantidade total de produtos da marca Contoso

select
	COUNT(*)
from
	DimProduct
where BrandName = 'Contoso'


select
	COUNT(*)
from
	(select * from DimProduct where BrandName = 'Contoso') as TabelaAuxiliar

-- subqueries aninhadas
-- Descubra os nomes dos clientes que ganham o segundo maior sal�rio

select 
	*
from
	DimCustomer
where CustomerType = 'Person'
order by YearlyIncome desc


select
	distinct top(2) YearlyIncome
from DimCustomer
where CustomerType = 'Person'
order by YearlyIncome desc

select
	CustomerKey,
	FirstName,
	LastName,
	YearlyIncome
from DimCustomer
where YearlyIncome = (
			select
				MAX(YearlyIncome)
			from
				DimCustomer
			where YearlyIncome < (
					select
						MAX(Yearlyincome)
					from
						DimCustomer
					where CustomerType = 'Person'
			))

-- CTE: Common Table Expression
-- Criee uma CTE para armazenar o resultado de uma consulta que contenha: ProductKey, ProductName, BrandName, ColorName e UnitPrice,
-- apenas para a marca Contoso

with cte as (
select
	ProductKey,
	ProductName,
	BrandName,
	ColorName,
	UnitPrice
from
	DimProduct
where BrandName = 'Contoso'
)

select COUNT(*) from cte

-- CTE: Calculando Agrega��es
-- Crie uma CTE que seja o resultado do agrupamento de total de produtos por marca. Fa�a uma m�dia de produtos por marca.

with cte as(
select
	BrandName,
	COUNT(*) as Total
from
	DimProduct
group by BrandName
)

select AVG(Total) from cte

-- tambpem

with cte(Marca, Total) as(
select
	BrandName,
	COUNT(*)
from
	DimProduct
group by BrandName
)

select AVG(Total) from cte


-- CRIANDO M�LTIPLAS CTE'S
-- CRIE 2 CTE'S
-- 1. A PRIMEIRA, CHAMADA PRODUTOS_CONTOSO, DEVE CONTER AS SEGUINTES COLUNAS (DIMPRODUCT): PRODUCTKEY, PRODUCTNAME, BRANDNAME
-- 2. A SEGUNDA, CHAMADA VENDAS_TOP100, DEVE SER UM TOP 100 VENDAS MAIS RECENTES, CONSIDERANDO AS SEGUINTES COLUNAS (FACTSALES):
-- SALESKEY, PRODUCTKEY, DATEKEY, SALESQUANTITY

-- POR FIM, FA�A UM INNER JOIN DESSAS TABELAS
go
with produtos_contoso as(
select
	ProductKey,
	ProductName,
	BrandName
from
	DimProduct
where BrandName = 'Contoso'
),
vendas_top100 as(
SELECT TOP(100)
	SalesKey,
	ProductKey,
	Datekey,
	SalesQuantity
from 
	FactSales
order by DateKey desc
)

SELECT * from vendas_top100
inner join produtos_contoso
	on vendas_top100.ProductKey = produtos_contoso.ProductKey