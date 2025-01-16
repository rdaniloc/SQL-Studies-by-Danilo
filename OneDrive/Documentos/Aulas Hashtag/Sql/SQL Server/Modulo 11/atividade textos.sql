/*1. Quando estamos manipulando tabelas, � importante pensar em como os dados ser�o
apresentados em um relat�rio. Imagine os nomes dos produtos da tabela DimProduct. Os
textos s�o bem grandes e pode ser que mostrar os nomes completos dos produtos n�o seja a
op��o mais interessante, pois provavelmente n�o v�o caber em um gr�fico e a visualiza��o
ficar� ruim.*/
/*a) Seu gestor te pede para listar todos os produtos para que seja criado um gr�fico para ser
apresentado na reuni�o di�ria de equipe. Fa�a uma consulta � tabela DimProduct que
retorne (1) o nome do produto e (2) a quantidade de caracteres que cada produto tem,
e ordene essa tabela do produto com a maior quantidade de caracteres para a menor.*/

select
	ProductName,
	LEN(ProductName) as QTD_Carac
from DimProduct
order by QTD_Carac desc

/*b) Qual � a m�dia de caracteres dos nomes dos produtos?*/
select
	AVG(len(ProductName))
from DimProduct

/*c) Analise a estrutura dos nomes dos produtos e verifique se seria poss�vel reduzir o tamanho
do nome dos produtos. (Dica: existem informa��es redundantes nos nomes dos produtos?
Seria poss�vel substitu�-las?)*/
select * from DimProduct
select * from DimProductSubcategory

select 
	ProductName,
	BrandName,
	replace(replace(ProductName, BrandName, ' '), ColorName, ' ')
from DimProduct

/*d) Qual � a m�dia de caracteres nesse novo cen�rio?*/

select
	AVG(len(replace(replace(ProductName, BrandName, ' '), ColorName, ' ')))
from DimProduct

-- 2. A coluna StyleName da tabela DimProduct possui alguns c�digos identificados por n�meros distintos, 
-- que v�o de 0 at� 9, como pode ser visto no exemplo abaixo.
-- Por�m, o setor de controle decidiu alterar a identifica��o do StyleName, e em vez de usar n�meros, 
-- a ideia agora � passar a usar letras para substituir os n�meros, conforme exemplo abaixo:
-- 0 -> A, 1 -> B, 2 -> C, 3 -> D, 4 -> E, 5 -> F, 6 -> G, 7 -> H, 8 -> I, 9 - J 
-- � de sua responsabilidade alterar os n�meros por letras na coluna StyleName da tabela DimProduct.
-- Utilize uma fun��o que permita fazer essas substitui��es de forma pr�tica e r�pida.

select
	ProductName,
	translate(StyleName, '0123456789', 'ABCDEFGHIJ')
from DimProduct


-- 3. O setor de TI est� criando um sistema para acompanhamento individual de cada funcion�rio da empresa Contoso. 
-- Cada funcion�rio receber� um login e senha. O login de cada funcion�rio ser� o ID do e-mail, como no exemplo abaixo:
-- J� a senha ser� o FirtName + o dia do ano em que o funcion�rio nasceu, em MAI�SCULA. Por exemplo, 
-- o funcion�rio com E-mail: mark0@contoso.com e data de nascimento 15/01/1990 dever� ter a seguinte senha:
-- O respons�vel pelo TI pediu a sua ajuda para retornar uma tabela contendo as seguintes colunas da 
-- tabela DimEmployee: Nome completo (FirstName + LastName), E-mail, ID do e-mail e Senha.
-- Portanto, fa�a uma consulta � tabela DimProduct e retorne esse resultado.

SELECT * FROM DimEmployee

select
	CONCAT(FirstName, ' ',LastName) as Nome,
	EmailAddress,
	left(EmailAddress, CHARINDEX('@', EmailAddress)-1) as ID_Email,
	CONCAT(UPPER(FirstName), Datepart(DAYOFYEAR, BirthDate)) as Senha 
from DimEmployee

-- 4. A tabela DimCustomer possui o primeiro registro de vendas no ano de 2001. Como forma de reconhecer os clientes que compraram nesse ano, 
-- o setor de Marketing solicitou a voc� que retornasse uma tabela com todos os clientes que fizeram a sua primeira compra neste ano para que seja 
-- enviado uma encomenda com um presente para cada um.
-- Para fazer esse filtro, voc� pode utilizar a coluna DateFirstPurchase, que cont�m a informa��o da data da primeira compra de cada cliente 
-- na tabela DimCustomer.
-- Voc� dever� retornar as colunas de FirstName, EmailAddress, AddressLine1 e DateFirstPurchase da tabela DimCustomer, considerando apenas os 
-- clientes que fizeram a primeira compra no ano de 2001.


select 
	FirstName,
	EmailAddress,
	AddressLine1,
	DateFirstPurchase 
from DimCustomer
Where year(DateFirstPurchase) = 2001


/*
5. A tabela DimEmployee possui uma informa��o de data de contrata��o (HireDate). A �rea de RH, no entanto, precisa das informa��es dessas datas de 
forma separada em dia, m�s e ano, pois ser� feita uma automatiza��o para cria��o de um relat�rio de RH, e facilitaria muito se essas informa��es
estivessem separadas em uma tabela.
Voc� dever� realizar uma consulta � tabela DimEmployee e retornar uma tabela contendo as seguintes informa��es: FirstName, EmailAddress, HireDate, al�m 
das colunas de Dia, M�s e Ano de contrata��o.
Obs1: A coluna de M�s deve conter o nome do m�s por extenso, e n�o o n�mero do m�s.
Obs2: Lembre-se de nomear cada uma dessas colunas em sua consulta para garantir que o entendimento de cada informa��o ficar� 100% claro.
*/

select 
	FirstName as Primeiro_Nome,
	EmailAddress as Email,
	HireDate as 'Data_Contrata��o',
	FORMAT(HireDate, 'dd') as Dia,
	FORMAT(HireDate, 'MMMM') as 'M�s',
	FORMAT(Hiredate, 'yyyy') as Ano
from DimEmployee

/*
6. Descubra qual � a loja que possui o maior tempo de atividade (em dias).
Voc� dever� fazer essa consulta na tabela DimStore, e considerar a coluna OpenDate como refer�ncia para esse c�lculo.
*/

select top(1)
	StoreName as Loja_Nome,
	DateDiff(day, OpenDate, GETDATE()) as Tempo_Atividade
from DimStore
where CloseDate is null
order by Tempo_Atividade desc


