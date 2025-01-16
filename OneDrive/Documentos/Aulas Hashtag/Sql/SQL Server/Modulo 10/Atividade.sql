-- 1. Declare 4 variáveis inteiras. Atribua os seguintes valores a elas:
-- valor1 = 10
-- valor2 = 5
-- valor3 = 34
-- valor4 = 7
declare @varValor1 float, @varValor2 float, @varValor3 float, @varValor4 float 
set @varValor1 = 10
set @varValor2 = 5
set @varValor3 = 34
set @varValor4 = 7
-- a) Crie uma nova variável para armazenar o resultado da soma entre valor1 e valor2. Chame essa variável de soma.
Declare @varSoma int
set @varSoma = @varValor1 + @varValor2
Select @varSoma
-- b) Crie uma nova variável para armazenar o resultado da subtração entre valor3 e valor 4. Chame essa variável de subtracao.
Declare @varSubtracao int
set @varSubtracao = @varValor3 - @varValor2
select @varSubtracao
-- c) Crie uma nova variável para armazenar o resultado da multiplicação entre o valor 1 e o valor4. Chame essa variável de multiplicacao.
Declare @varMultiplicacao int
set @varMultiplicacao = @varValor1 * @varValor4
select @varMultiplicacao
-- d) Crie uma nova variável para armazenar o resultado da divisão do valor3 pelo valor4. Chame essa variável de divisao. Obs: O resultado deverá estar em decimal, e não em inteiro.
Declare @varDivisao FLOAT
set @varDivisao = @varValor3/@varValor4
select @varDivisao as Divisao
-- e) Arredonde o resultado da letra para 2 casas decimais.
select round(@varDivisao, 2)

-- 2. Para cada declaração das variáveis abaixo, atenção em relação ao tipo de dado que deverá ser especificado.
-- a) Declare uma variável chamada ‘produto’ e atribua o valor de ‘Celular’.
-- b) Declare uma variável chamada ‘quantidade’ e atribua o valor de 12.
-- c) Declare uma variável chamada ‘preco’ e atribua o valor 9.99.
-- d) Declare uma variável chamada ‘faturamento’ e atribua o resultado da multiplicação entre ‘quantidade’ e ‘preco’.
-- e) Visualize o resultado dessas 4 variáveis em uma única consulta, por meio do SELECT.

declare @varProduto varchar(50), @varQuantidade int, @varPreco float, @varFaturamento float
set @varProduto = 'Celular'
set @varQuantidade = 12
set @varPreco = 9.99
set @varFaturamento = @varQuantidade * @varPreco

select @varProduto, @varQuantidade, @varPreco, @varFaturamento

/*3. Você é responsável por gerenciar um banco de dados onde são recebidos dados externos de usuários. Em resumo, esses dados são:
- Nome do usuário
- Data de nascimento
- Quantidade de pets que aquele usuário possui
Você precisará criar um código em SQL capaz de juntar as informações fornecidas por este usuário. Para simular estes dados, crie 3 variáveis, chamadas: nome, data_nascimento e num_pets. Você deverá armazenar os valores ‘André’, ‘10/02/1998’ e 2, respectivamente.
O resultado final a ser alcançado é mostrado no print abaixo:
Dica: você precisará utilizar as funções CAST e FORMAT para chegar no resultado.
*/

declare @varNome varchar(50), @varDataNascimento DateTime, @varNumPets int
set @varNome = 'Andre'
set @varDataNascimento = '10/02/1998'
set @varNumPets = 2

select 'Meu nome é ' + @varNome + ', nasci em ' + FORMAT(@varDataNascimento, 'dd/MM/yyyy') + ' e tenho ' + cast(@varNumPets as varchar(2)) + ' pets.'

/* 4. Você acabou de ser promovido e o seu papel será realizar um controle de qualidade sobre as lojas da empresa.
A primeira informação que é passada a você é que o ano de 2008 foi bem complicado para a empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio é descobrir o nome dessas lojas que fecharam no ano de 2008, para que você possa entender o motivo e mapear planos de ação para evitar que outras lojas importantes tomem o mesmo caminho.
O seu resultado deverá estar estruturado em uma frase, com a seguinte estrutura:
‘As lojas fechadas no ano de 2008 foram: ’ + nome_das_lojas
Obs: utilize o comando PRINT (e não o SELECT!) para mostrar o resultado. */

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

-- 5. Você precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria específica: ‘Lamps’.
-- Utilize o conceito de variáveis para chegar neste resultado.

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