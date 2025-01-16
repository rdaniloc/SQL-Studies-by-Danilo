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

-- 2) CAST: Fun��o para especificar o tipo de dados
-- int: inteiro, float: decimal, varchar: string/texto, datetime: data e hora

select SQL_VARIANT_PROPERTY(cast(21.45 as int), 'BaseType')

select CAST(21.45 as int)

select CAST(21.45 as float)

select CAST('15.6' as float)

select CAST('20/06/2021' as datetime)

-- EXERC�CIO 1: Crie uma consulta juntando o texto 'O pre�o do PASTEL �: ' com o valor 30.99

select 'O pre�o do pastel �: ' + cast(30.99 as varchar(50))

-- EXERC�CIO 2: Adicione 1 dia � data '20/06/2021'

select CAST('20/06/2021' as datetime) + 1

-- FORMAT: Fun��o para a formata��o de valores no SQL
-- a) Num�rico:
-- SELECT FORMAT(VALOR, FORMATO)
select FORMAT(1000, 'N')
select FORMAT(1000,'G')

-- b) Personalizados:
select FORMAT(123456789, '###-##-####')

-- c) Data:
select FORMAT(cast('21/03/2021' as datetime), 'dd/MMMM/yyyy')
select FORMAT(cast('21/03/2021' as datetime), 'ddd')


--- EXERC�CIO 3: CRIE UMA CONSULTA JUNTANDO O TEXTO 'A DATA DE VALIDADE DO PRODUTO �: ' COM A DATA 17/abr/2022. Obs: Voc� dever� usar o CAST para garantir que a data � entendida com tipo DATETIME.

select 'A data de validade do produto �: ' + FORMAT(CAST('17/04/2022' AS datetime), 'dd/MMM/yyyy')

-- Fun��es de arredondamento

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
DECLARANDO VARI�VEIS

1) O QUE � UMA VARI�VEL?
UMA VARI�VEL � UM OBJETO QUE ARMAZENA O VALOR DE UM DADO.

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


-- EXEMPLO 1: DECLARE UMA VARI�VEL CHAMADA 'IDADE' e armazene o valor 30

DECLARE @idade int
set @idade = 30
select @idade as 'Idade'

-- EXEMPLO 2: DECLARE UMA VARI�VEL CHAMADA PRECO E ARMAZENE O VALOR 10.89
DECLARE @preco float
set @preco = 10.89
select @preco as 'Pre�o Unit�rio'

-- EXEMPLO 3: DECLARE UMA VARI�VEL CHAMADA 'NOME' E ARMAZENE O VALOR 'MATEUS'

declare @nome varchar(50)
set @nome = 'Mateus'
select @nome as 'Nome'

-- EXEMPLO 4: DECLARE UMA VARI�VEL CHAMADA 'DATA' E ARMAZENE A DATA DE HOJE

declare @data datetime
set @data = '15/06/2021'
select @data as 'Data de hoje'

-- DECLARANDO MAIS DE UMA VARIAVEL

-- OP��O 1

declare @var1 int
declare @var2 int
declare @texto varchar(30)
declare @data DATETIME

set @var1 = 10
set @texto = 'um texto'
set @data = '18/02/2021'

select @data

-- OP��O 2

declare @var1 int,
		@texto varchar(30),
		@data DATETIME

set @var1 = 10
set @texto = 'um texto'
set @data = '18/02/2021'

-- OP��O 3

declare @var1 int = 10,
		@texto varchar(30) = 'UM TEXTO',
		@data DATETIME = '18/02/2021'

SELECT @var1, @texto, @data

-- EXERC�CIO 1: A SUA LOJA FEZ UMA VENDA DE 100 CAMISAS, CADA UMA CUSTANDO 89.99. FA�A UM SELECT PARA OBTER O RESULTADO DO FATURAMENTO (MULTIPLICA��O DA QUANTIDADE VEZES O PRE�O)

SELECT 100 * 89.99 AS 'FATURAMENTO'

-- EXERC�CIO 2: REFA�A O EXERC�CIO ANTERIOR UTILIZANDO VARI�VEIS PARA DEIXAR O C�LCULO MAIS OTIMIZADO

DECLARE @quantidade int
DECLARE @preco FLOAT

set @quantidade = 100
SET @preco = 89.99

select @preco * @quantidade AS FATURAMENTO

-- Utilizando uma vari�vel em uma consulta (Exemplos)
-- Exemplo 1: Aplique um desconto de 10% em todos os pre�os dos produtos. Sua consulta final deve conter as colunas ProductKey, ProductName, UnitPrice e Pre�o com desconto.

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
	UnitPrice as 'Pre�o Unit�rio',
	UnitPrice * (1 - @varDesconto) as 'Pre�o com Desconto'
from
	DimProduct

-- Utilizando uma vari�vel em uma consulta (Exemplo 2)
-- Crie uma vari�vel de data para otimizar a consulta abaixo.
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
	'Funcion�rio' as 'Tipo'
from
	DimEmployee
where BirthDate >= @varData
order by Nascimento


-- Armazenando o resultado de um select em uma vari�vel
-- Exemplo 1: Crie uma vari�vel para armazenar a quantidade total de funcion�rios da tabela DimEmployee.

Declare @varTotalFuncionarios int
set @varTotalFuncionarios = (select COUNT(*) from DimEmployee)
select @varTotalFuncionarios

-- Exemplo 2: Crie uma vari�vel para armazenar a quantidade total de lojas com Status off

Declare @varLojasOff int
set @varLojasOff = (Select COUNT(*) from DimStore where Status = 'Off')
select @varLojasOff

-- Utilizando o Print para mostrar o resultado de uma consulta



select * from DimProduct
Select COUNT(*) from DimProduct

-- Exemplo 1: Printe na tela a quantidade de lojas on e a quantidade de lojas off da tabela DimStore. Utilize vari�veis para isso.
set nocount on


Declare @varLojasOn int, @varLojasOff int
set @varLojasOn = (select COUNT(*) from DimStore where Status = 'On')
set @varLojasOff = (select COUNT(*) from DimStore where Status = 'Off')


Select @varLojasOn as 'Lojas Abertas', @varLojasOff as 'Lojas Fechadas'

print 'O total de lojas abertas � de ' + cast(@varLojasOn as varchar(30))
print 'O total de lojas fechadas � de ' + cast(@varLojasOff as varchar(30))

-- Armazenando em uma vari�vel um registro de uma consulta

select top(100) * from FactSales
order by SalesQuantity desc

-- Exemplo 1: Qual � o nome do produto que teve a maior quantidade vendida em uma �nica venda da tabela FactSales.

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


-- Acumulando valores em uma vari�vel
-- Exemplo: Printe na tela uma lista com os nomes das funcion�rias do departamento de Marketing.

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

-- Vari�veis Globais

select @@SERVERNAME

select @@VERSION

select * from DimProduct
select @@ROWCOUNT

use ContosoRetailDW