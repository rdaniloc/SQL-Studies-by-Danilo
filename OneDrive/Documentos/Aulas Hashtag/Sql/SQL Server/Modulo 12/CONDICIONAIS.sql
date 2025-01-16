-- CASE: A fun��o CASE permite tratar condi��es no SQL

/* CASE
		when teste_logico then 'resultado1'
		else 'resultado2'
   END
*/

-- Determine a situa��o do aluno. M�dia >= 6: aprovado. Caso contr�rio: reprovado
DECLARE @varNota float
set @varNota = 5.5

select
	case
		when @varNota >= 6 then 'Aprovado'
		else 'Reprovado'
	end as 'situa��o'

-- A data de vencimento de um produto � no dia 10/02/2022. fa�a um teste l�gico para verificar se um produto passou da validade ou n�o

declare @varDataVencimento Datetime, @varDataAtual Datetime
set @varDataVencimento = '10/03/2022'
set @varDataAtual = '30/04/2020'

select
	case
		when @varDataAtual > @varDataVencimento then 'Produto Vencido'
		else 'Na validade'
	end


-- Fa�a um select das colunas CustomerKey, FirstName e Gender na tabela DimCustomer e utilizevo CASE para criar uma 4� coluna com a informa��o de 'Masculino' ou 'Feminino'.

select
	CustomerKey as 'ID Cliente',
	FirstName as Nome,
	Gender as Sexo,
	Case
		when Gender = 'M' then 'Masculino'
		Else 'Feminino'
	End as 'Sexo (Case)'
from
	DimCustomer

-- Case: A fun��o Case permite tratar condi��es no SQL
/* Case
		When teste_logico1 then 'resultado1'
		when teste_logico2 then 'resultado2'
		else 'resultado3'
	end

Exemplo:

Crie um c�digo para verificar a nota do aluno e determinar a situa��o:
- Aprovado: nota maior ou igual a 6
- Prova final: nota entre 4 e 6
- Reprovado: nota abaixo de 4

Declare @varNota FLOAT
set @ varNota = 1

select
case
	when @varNota >= 6 then 'Aprovado'
	when @varNota >= 4 then 'Prova Final'
	else 'Reprovado'
end
*/


-- Classifique o produto de acordo com o seu pre�o:
-- Pre�o >= 40000: Luxo
-- Pre�o >= 10000 e Pre�o < 40000: Econ�mico
-- Pre�o < 10000: B�sico

declare @varPreco float
set @varPreco = 50000

select
	case
		when @varPreco >= 40000 then 'Luxo'
		when @varPreco >= 10000 then 'Econ�mico'
		else 'B�sico'
	end

-- Crie uma coluna para substituir o 'M' por 'Masculino' e 'F' por 'Feminino'. Verifique se ser� necess�rio fazer alguma corre��o.

select
	CustomerKey,
	FirstName,
	Gender,
	case
		When Gender = 'M' then 'Masculino'
		when Gender = 'F' then 'Feminino'
		else 'Empresa'
	end as 'Case'
from DimCustomer

-- Case/and e case/or
-- Fa�a uma consulta � tabela DimProduct, e retorne as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna de pre�o com desconto.
-- a) Caso o produto seja da marca Contoso e da cor Red, o desconto do produto ser� de 10%. Caso contr�rio, n�o ter� nenhum desconto

Select
	ProductName,
	BrandName,
	ColorName,
	UnitPrice,
	Case
		when BrandName = 'Contoso' and ColorName = 'Red' then 0.1
		else 0 
	end as 'Pre�o com desconto'
from DimProduct

-- b) Caso o produto seja da marca Litware ou Fabrikam, ele receber� um desconto de 5%. caso contr�rio, n�o ter� desconto.

Select
	ProductName,
	BrandName,
	ColorName,
	UnitPrice,
	Case
		when BrandName = 'Litware' or BrandName = 'Fabrikam' then 0.05
		else 0 
	end as 'Pre�o com desconto'
from DimProduct

-- Case Aninhado
-- DimEmployee
select * from DimEmployee

-- 4 Cargos (Title)
-- Sales Group Manager
-- Sales Region Manager
-- Sales State Manager
-- Sales Store Manager

-- Assalariado (SalariedFlag)?
-- SalariedFlag = 0: N�o � Assalariado
-- SalariedFlag = 1: � assalariado

-- Situa��o: C�lculo do b�nus
-- Sales Group Manager: Se for assalariado, 30%; Se n�o, 20%.
-- Sales Region Manager: 15%
-- Sales State Manager: 7%
-- Sales Store Manager: 2%


Select
	FirstName,
	Title,
	SalariedFlag,
	Case
		When Title = 'Sales Group Manager' then
			case
				when SalariedFlag = 1 then 0.3
				else 0.2
			end
		when Title = 'Sales Region Manager' then 0.15
		when Title = 'Sales State Manager' then 0.07
		else 0.02
	End AS 'B�nus'
from
	DimEmployee


-- Case Aditivo
-- Os produtos da categoria 'TV and V�deo' ter�o um desconto de 10%
-- Se al�m de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receber� mais 5%. Total, 15%

select
	ProductKey,
	ProductName,
	ProductCategoryName,
	ProductSubcategoryName,
	UnitPrice,
		Case
			when ProductCategoryName = 'TV and Video' then 0.10
			else 0
		end
		+
		Case
			when ProductSubcategoryName = 'Televisions' then 0.05
			else 0
		end
from
	DimProduct
inner join DimProductSubcategory
	on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		inner join DimProductCategory
			on DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

-- Fun��o IIF: Alternativa ao CASE
-- Exemplo 1: Qual � a categoria de risco do projeto abaixo, de acordo com a sua nota:
-- Risco Alto: Classifica��o >= 5
-- Risco Baixo: Classifica��o < 5


Declare @varClassificacao int
set @varClassificacao = 9

select
	IIF(
		@varClassificacao >= 5,
		'Risco Alto',
		'Risco Baixo')

-- Exemplo 2: Crie uma coluna �nica de 'Cliente', contendo o nome do Cliente, seja ele uma pessoa ou empresa. Traga Tamb�m a coluna de CustomerKey e CustomerType

select * from DimCustomer

select
	CustomerKey,
	CustomerType,
	IIF(
		CustomerType = 'Person',
		FirstName,
		CompanyName) as 'Cliente'
from DimCustomer

-- IIF Composto

select * from DimProduct

-- Existe 3 tipos de estoque: High, Mid e Low. fa�a um SELECT contendo as colunas de ProductKey, ProductName, StocKTypeName e Nome do respons�vel pelo produto, de acordo com o tipo de estoque. A regra dever� ser a seguinte:
-- Jo�o � respons�vel pelo produtos High
-- Maria � respons�vel pelo produtos Mid
-- Luis � respons�vel pelo produtos Low

Select
	ProductKey,
	ProductName,
	StockTypeName,
	IIF(
		StockTypeName = 'High',
		'Jo�o',
		iif(
			StockTypeName = 'Mid',
			'Maria',
			'Luis')
			) as 'Respons�vel'
from 
	DimProduct

-- ISNULL: Tratando valores nulos

select * from DimGeography

select
	GeographyKey,
	ContinentName,
	CityName,
	ISNULL(CityName, 'Local Desconhecido')
from 
	DimGeography