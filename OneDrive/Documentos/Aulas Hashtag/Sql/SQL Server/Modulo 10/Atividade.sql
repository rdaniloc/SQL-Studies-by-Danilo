-- 1. Declare 4 vari�veis inteiras. Atribua os seguintes valores a elas:
-- valor1 = 10
-- valor2 = 5
-- valor3 = 34
-- valor4 = 7
declare @varValor1 float, @varValor2 float, @varValor3 float, @varValor4 float 
set @varValor1 = 10
set @varValor2 = 5
set @varValor3 = 34
set @varValor4 = 7
-- a) Crie uma nova vari�vel para armazenar o resultado da soma entre valor1 e valor2. Chame essa vari�vel de soma.
Declare @varSoma int
set @varSoma = @varValor1 + @varValor2
Select @varSoma
-- b) Crie uma nova vari�vel para armazenar o resultado da subtra��o entre valor3 e valor 4. Chame essa vari�vel de subtracao.
Declare @varSubtracao int
set @varSubtracao = @varValor3 - @varValor2
select @varSubtracao
-- c) Crie uma nova vari�vel para armazenar o resultado da multiplica��o entre o valor 1 e o valor4. Chame essa vari�vel de multiplicacao.
Declare @varMultiplicacao int
set @varMultiplicacao = @varValor1 * @varValor4
select @varMultiplicacao
-- d) Crie uma nova vari�vel para armazenar o resultado da divis�o do valor3 pelo valor4. Chame essa vari�vel de divisao. Obs: O resultado dever� estar em decimal, e n�o em inteiro.
Declare @varDivisao FLOAT
set @varDivisao = @varValor3/@varValor4
select @varDivisao as Divisao
-- e) Arredonde o resultado da letra para 2 casas decimais.
select round(@varDivisao, 2)

-- 2. Para cada declara��o das vari�veis abaixo, aten��o em rela��o ao tipo de dado que dever� ser especificado.
-- a) Declare uma vari�vel chamada �produto� e atribua o valor de �Celular�.
-- b) Declare uma vari�vel chamada �quantidade� e atribua o valor de 12.
-- c) Declare uma vari�vel chamada �preco� e atribua o valor 9.99.
-- d) Declare uma vari�vel chamada �faturamento� e atribua o resultado da multiplica��o entre �quantidade� e �preco�.
-- e) Visualize o resultado dessas 4 vari�veis em uma �nica consulta, por meio do SELECT.

declare @varProduto varchar(50), @varQuantidade int, @varPreco float, @varFaturamento float
set @varProduto = 'Celular'
set @varQuantidade = 12
set @varPreco = 9.99
set @varFaturamento = @varQuantidade * @varPreco

select @varProduto, @varQuantidade, @varPreco, @varFaturamento

/*3. Voc� � respons�vel por gerenciar um banco de dados onde s�o recebidos dados externos de usu�rios. Em resumo, esses dados s�o:
- Nome do usu�rio
- Data de nascimento
- Quantidade de pets que aquele usu�rio possui
Voc� precisar� criar um c�digo em SQL capaz de juntar as informa��es fornecidas por este usu�rio. Para simular estes dados, crie 3 vari�veis, chamadas: nome, data_nascimento e num_pets. Voc� dever� armazenar os valores �Andr�, �10/02/1998� e 2, respectivamente.
O resultado final a ser alcan�ado � mostrado no print abaixo:
Dica: voc� precisar� utilizar as fun��es CAST e FORMAT para chegar no resultado.
*/

declare @varNome varchar(50), @varDataNascimento DateTime, @varNumPets int
set @varNome = 'Andre'
set @varDataNascimento = '10/02/1998'
set @varNumPets = 2

select 'Meu nome � ' + @varNome + ', nasci em ' + FORMAT(@varDataNascimento, 'dd/MM/yyyy') + ' e tenho ' + cast(@varNumPets as varchar(2)) + ' pets.'

/* 4. Voc� acabou de ser promovido e o seu papel ser� realizar um controle de qualidade sobre as lojas da empresa.
A primeira informa��o que � passada a voc� � que o ano de 2008 foi bem complicado para a empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio � descobrir o nome dessas lojas que fecharam no ano de 2008, para que voc� possa entender o motivo e mapear planos de a��o para evitar que outras lojas importantes tomem o mesmo caminho.
O seu resultado dever� estar estruturado em uma frase, com a seguinte estrutura:
�As lojas fechadas no ano de 2008 foram: � + nome_das_lojas
Obs: utilize o comando PRINT (e n�o o SELECT!) para mostrar o resultado. */

select 
	* 
from 
	DimStore

Declare @varListaNomes varchar(50)
set @varListaNomes = ' '

select
	@varListaNomes = @varListaNomes + StoreName + ',' + ' '
from DimStore
where YEAR(CloseDate) = 2008

print 'As lojas fechadas no ano de 2008 foram:' + @varListaNomes

-- 5. Voc� precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria espec�fica: �Lamps�.
-- Utilize o conceito de vari�veis para chegar neste resultado.

select * from DimProduct
select * from DimProductSubcategory

Declare @varSubCategoria varchar(50)
set @varSubCategoria = 'Lamps'

select
	ProductName,
	ProductSubcategoryName
from 
	DimProduct
inner join DimProductSubcategory
	on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
where ProductSubcategoryName = @varSubCategoria