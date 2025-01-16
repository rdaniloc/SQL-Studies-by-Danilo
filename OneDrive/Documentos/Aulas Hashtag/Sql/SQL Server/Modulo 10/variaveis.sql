-- Tipos de dados

-- 1) SQL_VARIANT_ PROPERTY

select 10 as 'Numero'
select 40.50 as 'Decimal'
select 'Marcus' as 'Nome'
select '26/06/2011' as 'Data'

select SQL_VARIANT_PROPERTY(10, 'BaseType')
select SQL_VARIANT_PROPERTY(40.50, 'BaseType')
select SQL_VARIANT_PROPERTY('Marcus', 'BaseType')
select SQL_VARIANT_PROPERTY('26/06/2021', 'BaseType')

-- 2) CAST: Função para especificar o tipo de dados
-- int: inteiro, float: decimal, varchar: string/texto, datetime: data e hora

select SQL_VARIANT_PROPERTY(cast(21.45 as int), 'BaseType')

select CAST(21.45 as int)

select CAST(21.45 as float)

select CAST('15.6' as float)

select CAST('20/06/2021' as datetime)

-- EXERCÍCIO 1: Crie uma consulta juntando o texto 'O preço do PASTEL é: ' com o valor 30.99

select 'O preço do pastel é: ' + cast(30.99 as varchar(50))

-- EXERCÍCIO 2: Adicione 1 dia à data '20/06/2021'

select CAST('20/06/2021' as datetime) + 1

-- FORMAT: Função para a formatação de valores no SQL
-- a) Numérico:
-- SELECT FORMAT(VALOR, FORMATO)
select FORMAT(1000, 'N')
select FORMAT(1000,'G')

-- b) Personalizados:
select FORMAT(123456789, '###-##-####')

-- c) Data:
select FORMAT(cast('21/03/2021' as datetime), 'dd/MMMM/yyyy')
select FORMAT(cast('21/03/2021' as datetime), 'ddd')


--- EXERCÍCIO 3: CRIE UMA CONSULTA JUNTANDO O TEXTO 'A DATA DE VALIDADE DO PRODUTO É: ' COM A DATA 17/abr/2022. Obs: Você deverá usar o CAST para garantir que a data é entendida com tipo DATETIME.

select 'A data de validade do produto é: ' + FORMAT(CAST('17/04/2022' AS datetime), 'dd/MMM/yyyy')

-- Funções de arredondamento

select 10+20
select 20-5
select 31*40
select 431.0/23

-- ROUND
SELECT ROUND(18.739130, 2)


-- ROUND(TRUNCAR)
SELECT ROUND(18.739130, 2, 2)


-- FLOOR ( ARREDONDA PARA BAIXO
SELECT FLOOR(18.739130) 

-- CEILING
SELECT CEILING(18.739130) 


/*
DECLARANDO VARIÁVEIS

1) O QUE É UMA VARIÁVEL?
UMA VARIÁVEL É UM OBJETO QUE ARMAZENA O VALOR DE UM DADO.

2) ESTRUTURA

DECLARE @var int
SET @var = 10
SELECT @var

3) EXEMPLO:

EM VEZ DE...

SELECT 1000
SELECT 1000 * 1000
SELECT FORMAT(1000*1000, 'N')

Seria melhor...

Declare @numero float
set @numero = 1000

select @numero
select @umero * @numero
select format(@numero * @numero, 'N')

*/


-- EXEMPLO 1: DECLARE UMA VARIÁVEL CHAMADA 'IDADE' e armazene o valor 30

DECLARE @idade int
set @idade = 30
select @idade as 'Idade'

-- EXEMPLO 2: DECLARE UMA VARIÁVEL CHAMADA PRECO E ARMAZENE O VALOR 10.89
DECLARE @preco float
set @preco = 10.89
select @preco as 'Preço Unitário'

-- EXEMPLO 3: DECLARE UMA VARIÁVEL CHAMADA 'NOME' E ARMAZENE O VALOR 'MATEUS'

declare @nome varchar(50)
set @nome = 'Mateus'
select @nome as 'Nome'

-- EXEMPLO 4: DECLARE UMA VARIÁVEL CHAMADA 'DATA' E ARMAZENE A DATA DE HOJE

declare @data datetime
set @data = '15/06/2021'
select @data as 'Data de hoje'

-- DECLARANDO MAIS DE UMA VARIAVEL

-- OPÇÃO 1

declare @var1 int
declare @var2 int
declare @texto varchar(30)
declare @data DATETIME

set @var1 = 10
set @texto = 'um texto'
set @data = '18/02/2021'

select @data

-- OPÇÃO 2

declare @var1 int,
		@texto varchar(30),
		@data DATETIME

set @var1 = 10
set @texto = 'um texto'
set @data = '18/02/2021'

-- OPÇÃO 3

declare @var1 int = 10,
		@texto varchar(30) = 'UM TEXTO',
		@data DATETIME = '18/02/2021'

SELECT @var1, @texto, @data

-- EXERCÍCIO 1: A SUA LOJA FEZ UMA VENDA DE 100 CAMISAS, CADA UMA CUSTANDO 89.99. FAÇA UM SELECT PARA OBTER O RESULTADO DO FATURAMENTO (MULTIPLICAÇÃO DA QUANTIDADE VEZES O PREÇO)

SELECT 100 * 89.99 AS 'FATURAMENTO'

-- EXERCÍCIO 2: REFAÇA O EXERCÍCIO ANTERIOR UTILIZANDO VARIÁVEIS PARA DEIXAR O CÁLCULO MAIS OTIMIZADO

DECLARE @quantidade int
DECLARE @preco FLOAT

set @quantidade = 100
SET @preco = 89.99

select @preco * @quantidade AS FATURAMENTO

-- Utilizando uma variável em uma consulta (Exemplos)
-- Exemplo 1: Aplique um desconto de 10% em todos os preços dos produtos. Sua consulta final deve conter as colunas ProductKey, ProductName, UnitPrice e Preço com desconto.

preco = 100
desconto = 0.10
valor_do_desconto = 100 * 0.10 = 10
preco_com_desconto = 100 - 100 * 0.10 = 90
preco_com_desconto = 100 * (1 - 0.10) = 90
preco_com_desconto = 100 * (1 - desconto) = 90


declare @varDesconto Float
set @varDesconto = 0.10

select
	ProductKey as 'ID',
	ProductName as 'Nome do Produto',
	UnitPrice as 'Preço Unitário',
	UnitPrice * (1 - @varDesconto) as 'Preço com Desconto'
from
	DimProduct

-- Utilizando uma variável em uma consulta (Exemplo 2)
-- Crie uma variável de data para otimizar a consulta abaixo.
Declare @varData DATETIME
SET @varData = '01/01/1980'

select
	FirstName as 'Name',
	LastName as 'Sobrenome',
	BirthDate as 'Nascimento',
	'Cliente' as 'Tipo'
from
	DimCustomer
where BirthDate >= @varData

union

select
	FirstName as 'Name',
	LastName as 'Sobrenome',
	BirthDate as 'Nascimento',
	'Funcionário' as 'Tipo'
from
	DimEmployee
where BirthDate >= @varData
order by Nascimento


-- Armazenando o resultado de um select em uma variável
-- Exemplo 1: Crie uma variável para armazenar a quantidade total de funcionários da tabela DimEmployee.

Declare @varTotalFuncionarios int
set @varTotalFuncionarios = (select COUNT(*) from DimEmployee)
select @varTotalFuncionarios

-- Exemplo 2: Crie uma variável para armazenar a quantidade total de lojas com Status off

Declare @varLojasOff int
set @varLojasOff = (Select COUNT(*) from DimStore where Status = 'Off')
select @varLojasOff

-- Utilizando o Print para mostrar o resultado de uma consulta



select * from DimProduct
Select COUNT(*) from DimProduct

-- Exemplo 1: Printe na tela a quantidade de lojas on e a quantidade de lojas off da tabela DimStore. Utilize variáveis para isso.
set nocount on


Declare @varLojasOn int, @varLojasOff int
set @varLojasOn = (select COUNT(*) from DimStore where Status = 'On')
set @varLojasOff = (select COUNT(*) from DimStore where Status = 'Off')


Select @varLojasOn as 'Lojas Abertas', @varLojasOff as 'Lojas Fechadas'

print 'O total de lojas abertas é de ' + cast(@varLojasOn as varchar(30))
print 'O total de lojas fechadas é de ' + cast(@varLojasOff as varchar(30))

-- Armazenando em uma variável um registro de uma consulta

select top(100) * from FactSales
order by SalesQuantity desc

-- Exemplo 1: Qual é o nome do produto que teve a maior quantidade vendida em uma única venda da tabela FactSales.

Declare @varProdutoMaisVendido int
Declare @varTotalMAisVendido int

Select top(1)
	@varProdutoMaisVendido = ProductKey,
	@varTotalMAisVendido = SalesQuantity
from
	FactSales
Order by SalesQuantity Desc

print @varProdutoMaisVendido
print @varTotalMaisVendido

Select
	ProductKey,
	ProductName
from
	DimProduct
Where ProductKey = @varProdutoMaisVendido


-- Acumulando valores em uma variável
-- Exemplo: Printe na tela uma lista com os nomes das funcionárias do departamento de Marketing.

Declare @varDepartamento varchar(30), @varGenero char(1)
set @varDepartamento = 'Marketing'
set	@varGenero = 'F'

Select
	FirstName,
	DepartmentName
from
	DimEmployee
where DepartmentName = @varDepartamento and Gender = @varGenero


declare @varListaNomes Varchar(50)
set @varListaNomes = ''

select 
	@varListaNomes = @varListaNomes + FirstName + ', ' + CHAR(10)
from
	DimEmployee
where DepartmentName = 'Marketing' and Gender = 'F'

print left(@varListaNomes, DATALENGTH(@varListaNomes) - 3)

-- Variáveis Globais

select @@SERVERNAME

select @@VERSION

select * from DimProduct
select @@ROWCOUNT

use ContosoRetailDW