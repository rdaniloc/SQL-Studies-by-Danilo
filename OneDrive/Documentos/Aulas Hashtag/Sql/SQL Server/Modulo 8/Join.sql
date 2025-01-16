-- Left (Anti) Join

select * from produtos;
select * from subcategoria;

select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from
	produtos
full join subcategoria
	on produtos.id_subcategoria = subcategoria.id_subcategoria
where id_produto is null or nome_subcategoria is null

-- EXEMPLO INNER JOIN, LEFT JOIN E RIGHT JOIN

select ProductKey, ProductName, ProductSubcategoryKey from DimProduct
select ProductSubcategoryKey, ProductSubcategoryName from DimProductSubcategory

select
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName
from
	DimProduct
right join DimProductSubcategory
	on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey


-- COMO ESCOLHER QUEM É A TABELA DA ESQUERDA E A TABELA DA DIREITA?

-- 1. LEFT JOIN PARA COMPLEMENTAR INFORMAÇÕES DA TABELA PRODUTOS (LEFT) DE ACORDO COM A TABELA CATEGORIA (RIGHT)

select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from 
	produtos
left join subcategoria
	on produtos.id_subcategoria = subcategoria.id_subcategoria


-- 2. Obtendo o Left Join do caso 1 usando um right join e invertendo as tabelas de lado

select
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
from
	subcategoria
right join produtos
	on subcategoria.id_subcategoria = produtos.id_subcategoria


-- crossjoin

select * from marcas
select * from subcategoria

select
	marca,
	nome_subcategoria
from
	marcas cross join subcategoria


create table marcas(
	id_marca int,
	marca varchar(30))

insert into marcas(id_marca, marca)
values
	(1, 'Apple'),
	(2, 'Samsung'),
	(3, 'Motorola')


-- multiplos joins

select ProductKey, ProductName, ProductSubcategoryKey from DimProduct
select ProductSubcategoryDescription, ProductSubcategoryName, ProductCategoryKey from DimProductSubcategory
select ProductCategoryKey, ProductCategoryName from DimProductCategory

select
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductCategoryName
from
	DimProduct
inner join DimProductSubcategory
	on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		inner join DimProductcategory
			on DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

-- UNION e UNION ALL
-- UNION

select
	*
from
	DimCustomer
where Gender = 'F'
union
select
	*
from
	DimCustomer
where Gender = 'M'

-- UNION ALL

select
	FirstName,
	BirthDate
from
	DimCustomer
where
	Gender = 'F'
union all
select
	FirstName,
	BirthDate
from
	DimCustomer
where
	Gender = 'M'