-- LEN e DATALENGHT: Retorna a quantidade de caracteres de uma palavra
-- Descubra a quantidade de caracteres da palavra 'SQL Hashtag'

select LEN('SQL Hashtag   '),
	 DATALENGTH('SQL Hashtag   ')


-- CONCAT: Permite juntar mais de um texto em uma única palavra
-- Faça uma consulta à tabela DimCustomer onde seja possível visualizar o nome completo de cada cliente

select
	FirstName as Nome,
	LastName as Sobrenome,
	CONCAT(FirstName, ' ', LastName) as 'Nome Comleto'
from DimCustomer


-- Left --> Extrai uma determinada quantidade de caracteres de um texto, da esquerda para a direita
-- Right ---> Extrai uma determinada quantidade de caracteres de um texto, da direita para a esquerda

select * from DimProduct

select LEFT('Product0101001', 7)
select RIGHT('Product0101001', 7)


select
	ProductName as 'Produto',
	UnitPrice as 'Preço',
	LEFT(StyleName, 7) as 'Cos_1',
	right(StyleName, 7) as 'Cod_2'
from DimProduct

-- REPLACE: Substitui um determinado texto por outro texto
-- No texto 'O Excel é o melhor', substitua 'Excel' por 'SQL'

select REPLACE('O Excel é o melhor', 'Excel', 'SQL')

-- Crie uma consulta a partir de DimCustomer onde você retorna o Nome Completo dos Clientes, a coluna de sexo (Abrev) e uma coluna de Sexo substituindo M por Masculino e F por Feminino

select 
	CONCAT(FirstName, ' ', LastName) as Nome,
	replace(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino')  -- Sempre tomar cuidado com a ordem
from DimCustomer

-- Translate e Stuff: Outras funções de substituição
-- Translate: Substitui cada caractere na ordem encontrada no texto

select TRANSLATE('10.241/444.124k23/11', './k', 'abc')
select TRANSLATE('ABCD-490123', 'ABCD', 'WXYZ')


-- STUFF: Substitui qualquer texto com uma quantidade de caracteres limitados, por um outro texto

select STUFF('VBA Impressionador', 1, 3, 'EXCEL')
select STUFF('SQL Impressionador', 1, 3, 'EXCEL')

-- UPPER ---> Transforma um texto em maiúscula
-- LOWER ---> Transforma um texto em munúsculo

-- Faça uma consulta `a tabela DimCustomer e utilize as funrções UPPER e LOWER na coluna de FirstName e LastName

select
	Upper(FirstName),
	LOWER(LastName)
from DimCustomer


-- FORMAT: Formata um valor de acordo com uma formatação

-- 1. Formatação de número
-- 5123

-- Geral
select FORMAT(5123,'G')

-- Número
select FORMAT(5123, 'N')

-- Moeda
select FORMAT(5123, 'C')

-- 2. Formatação de Data
-- 23/04/2020
-- dd/MM/yyyy
select FORMAT(cast('23/04/2020' as datetime), 'dd/MMM/yyyy', 'en-US')

-- dia
select FORMAT(cast('23/04/2023' as datetime), 'dd')

-- Mês
select FORMAT(cast('23-04-2020' as datetime), 'MMM')

-- Ano
select FORMAT(cast('23/04/2020' as datetime), 'yyyy')

-- 3. Formatação Personalizada
-- 1234567 --> 12-34-567

select FORMAT(1234567, '##-##-###')

-- charindex: Descobre a posiçãi de um determinado caractere dentro de um texto
-- Substring: Extrai alguns caracteres de dentro de um texto

select 'Raquel Moreno' as 'Nome'

-- Descubra a posição em que começa o sobrenome da raquel utilizando a função CHARINDEX
select CHARINDEX('Moreno', 'Raquel Moreno')

-- Extraia o sobrenome de Raquel utilizando a função SUBSTRING
select SUBSTRING('Raquel Moreno', 8, 6) as Sobrenome

-- Combine as funções CHARINDEX e SUBSTRING para extrair de forma automática qualquer sobrenome

Declare @varNome varchar(100)
set @varNome = 'Bernado Cavalcante'

select SUBSTRING(@varNome, CHARINDEX(' ', @varNome) + 1, 100) as Sobrenome

-- Funções para retirar espaços adicionais dentro de um texto
-- Trim: Retira espaços adicionais à esquerda e à direita do texto
-- Ltrim: Retira espaços adicionais à esquerda do texto
-- Rtrim: Retira espaços adicionais à direita do texto

-- Utiliza as funções acima no código '    ABC123    '

DECLARE @varCodigo VARCHAR(50)
set @varCodigo = '  ABC123       '

select
	TRIM(@varCodigo) as 'Trim',
	Ltrim(@varCodigo) as 'Ltrim',
	Rtrim(@varCOdigo) as 'Rtrim'


select
	datalength(TRIM(@varCodigo)) as 'Trim',
	datalength(Ltrim(@varCodigo)) as 'Ltrim',
	datalength(Rtrim(@varCOdigo)) as 'Rtrim'


-- Utilize as funções DAY, Month e YEAR para descobrir o dia, mês e ano da data: 18/05/2020

-- Declare @varData datetime
-- set @varData = '18/05/2020'

select
	DAY(@varData) as Dia,
	MONTH(@varData) as Mes,
	YEAR(@varData) as Ano

-- Utilize a função DATEFROMPARTS PARA OBTER UMA DATA A PARTIR DAS INFORMAÇÕES DE DIA, MÊS, ANO

DECLARE @varDia INT, @varMes Int, @varAno int
set @varDia = 15
set @varMes = 6
set @varAno = 2017

select
	DATEFROMPARTS(@varAno, @varMes, @varDia) as Data

-- Getdate: Retorna a data/hora atual do sistema
-- Sysdatetime: Retorna a data/hora atual do sistema (mais preciso que a Getdate)
-- DateName e DatePart: Retorna informações (dia, mês, ano, semana, etc) de uma data

select GETDATE()
select SYSDATETIME()

-- DateName

Declare @varData datetime
set @varData = GETDATE()

select 
	DATENAME(Day, @varData) as 'Dia',
	DATENAME(month, @varData) as 'Mês',
	DATENAME(YEAR, @varData) as 'Ano',
	DATENAME(DayofYear, @varData) as 'Dia do Ano'

-- DatePart

select 
	DATEPART(Day, @varData) as 'Dia',
	DATEPART(month, @varData) as 'Mês',
	DATEPART(YEAR, @varData) as 'Ano',
	DATEPART(DayofYear, @varData) as 'Dia do Ano'

SELECT 
	SQL_VARIANT_PROPERTY(DATENAME(Day, @varData), 'BaseType'),
	SQL_VARIANT_PROPERTY(DATEPART(Day, @varData), 'BaseType')

-- DateADD: Adiciona ou subtrai uma determinada quantidade de dias, meses ou anos a uma data
-- DateDiff: Calcula a diferença entre duas datas

declare @varData1 datetime, @varData2 datetime, @varData3 datetime
set @varData1 = '10/07/2020'
set @varData2 = '05/03/2020'
set @varData3 = '14/11/2021'

-- Dateadd
select 
	DATEADD(DAY, 30, @varData1)

-- DateDiff
select
	Datediff(Day, @varData2, @varData3)