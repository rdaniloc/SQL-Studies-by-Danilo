-- LEN e DATALENGHT: Retorna a quantidade de caracteres de uma palavra
-- Descubra a quantidade de caracteres da palavra 'SQL Hashtag'

select LEN('SQL Hashtag   '),
	 DATALENGTH('SQL Hashtag   ')


-- CONCAT: Permite juntar mais de um texto em uma �nica palavra
-- Fa�a uma consulta � tabela DimCustomer onde seja poss�vel visualizar o nome completo de cada cliente

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
	UnitPrice as 'Pre�o',
	LEFT(StyleName, 7) as 'Cos_1',
	right(StyleName, 7) as 'Cod_2'
from DimProduct

-- REPLACE: Substitui um determinado texto por outro texto
-- No texto 'O Excel � o melhor', substitua 'Excel' por 'SQL'

select REPLACE('O Excel � o melhor', 'Excel', 'SQL')

-- Crie uma consulta a partir de DimCustomer onde voc� retorna o Nome Completo dos Clientes, a coluna de sexo (Abrev) e uma coluna de Sexo substituindo M por Masculino e F por Feminino

select 
	CONCAT(FirstName, ' ', LastName) as Nome,
	replace(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino')  -- Sempre tomar cuidado com a ordem
from DimCustomer

-- Translate e Stuff: Outras fun��es de substitui��o
-- Translate: Substitui cada caractere na ordem encontrada no texto

select TRANSLATE('10.241/444.124k23/11', './k', 'abc')
select TRANSLATE('ABCD-490123', 'ABCD', 'WXYZ')


-- STUFF: Substitui qualquer texto com uma quantidade de caracteres limitados, por um outro texto

select STUFF('VBA Impressionador', 1, 3, 'EXCEL')
select STUFF('SQL Impressionador', 1, 3, 'EXCEL')

-- UPPER ---> Transforma um texto em mai�scula
-- LOWER ---> Transforma um texto em mun�sculo

-- Fa�a uma consulta `a tabela DimCustomer e utilize as funr��es UPPER e LOWER na coluna de FirstName e LastName

select
	Upper(FirstName),
	LOWER(LastName)
from DimCustomer


-- FORMAT: Formata um valor de acordo com uma formata��o

-- 1. Formata��o de n�mero
-- 5123

-- Geral
select FORMAT(5123,'G')

-- N�mero
select FORMAT(5123, 'N')

-- Moeda
select FORMAT(5123, 'C')

-- 2. Formata��o de Data
-- 23/04/2020
-- dd/MM/yyyy
select FORMAT(cast('23/04/2020' as datetime), 'dd/MMM/yyyy', 'en-US')

-- dia
select FORMAT(cast('23/04/2023' as datetime), 'dd')

-- M�s
select FORMAT(cast('23-04-2020' as datetime), 'MMM')

-- Ano
select FORMAT(cast('23/04/2020' as datetime), 'yyyy')

-- 3. Formata��o Personalizada
-- 1234567 --> 12-34-567

select FORMAT(1234567, '##-##-###')

-- charindex: Descobre a posi��i de um determinado caractere dentro de um texto
-- Substring: Extrai alguns caracteres de dentro de um texto

select 'Raquel Moreno' as 'Nome'

-- Descubra a posi��o em que come�a o sobrenome da raquel utilizando a fun��o CHARINDEX
select CHARINDEX('Moreno', 'Raquel Moreno')

-- Extraia o sobrenome de Raquel utilizando a fun��o SUBSTRING
select SUBSTRING('Raquel Moreno', 8, 6) as Sobrenome

-- Combine as fun��es CHARINDEX e SUBSTRING para extrair de forma autom�tica qualquer sobrenome

Declare @varNome varchar(100)
set @varNome = 'Bernado Cavalcante'

select SUBSTRING(@varNome, CHARINDEX(' ', @varNome) + 1, 100) as Sobrenome

-- Fun��es para retirar espa�os adicionais dentro de um texto
-- Trim: Retira espa�os adicionais � esquerda e � direita do texto
-- Ltrim: Retira espa�os adicionais � esquerda do texto
-- Rtrim: Retira espa�os adicionais � direita do texto

-- Utiliza as fun��es acima no c�digo '    ABC123    '

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


-- Utilize as fun��es DAY, Month e YEAR para descobrir o dia, m�s e ano da data: 18/05/2020

-- Declare @varData datetime
-- set @varData = '18/05/2020'

select
	DAY(@varData) as Dia,
	MONTH(@varData) as Mes,
	YEAR(@varData) as Ano

-- Utilize a fun��o DATEFROMPARTS PARA OBTER UMA DATA A PARTIR DAS INFORMA��ES DE DIA, M�S, ANO

DECLARE @varDia INT, @varMes Int, @varAno int
set @varDia = 15
set @varMes = 6
set @varAno = 2017

select
	DATEFROMPARTS(@varAno, @varMes, @varDia) as Data

-- Getdate: Retorna a data/hora atual do sistema
-- Sysdatetime: Retorna a data/hora atual do sistema (mais preciso que a Getdate)
-- DateName e DatePart: Retorna informa��es (dia, m�s, ano, semana, etc) de uma data

select GETDATE()
select SYSDATETIME()

-- DateName

Declare @varData datetime
set @varData = GETDATE()

select 
	DATENAME(Day, @varData) as 'Dia',
	DATENAME(month, @varData) as 'M�s',
	DATENAME(YEAR, @varData) as 'Ano',
	DATENAME(DayofYear, @varData) as 'Dia do Ano'

-- DatePart

select 
	DATEPART(Day, @varData) as 'Dia',
	DATEPART(month, @varData) as 'M�s',
	DATEPART(YEAR, @varData) as 'Ano',
	DATEPART(DayofYear, @varData) as 'Dia do Ano'

SELECT 
	SQL_VARIANT_PROPERTY(DATENAME(Day, @varData), 'BaseType'),
	SQL_VARIANT_PROPERTY(DATEPART(Day, @varData), 'BaseType')

-- DateADD: Adiciona ou subtrai uma determinada quantidade de dias, meses ou anos a uma data
-- DateDiff: Calcula a diferen�a entre duas datas

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