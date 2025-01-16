-- Atividade Loop

/*
1. Utilize o Loop While para criar um contador que comece em um valor inicial @ValorInicial e
termine em um valor final @ValorFinal. Você deverá printar na tela a seguinte frase:
“O valor do contador é: “ + ___
*/

Declare @varValorInicial int, @varValorFinal int
set @varValorInicial= 0
set @varValorFinal = 10

while @varValorInicial < @varValorFinal
begin
	set @varValorInicial += 1
	print 'O valor do contador é: ' + convert(varchar, @varValorInicial)
end
go

/*
2. Você deverá criar uma estrutura de repetição que printe na tela a quantidade de contratações
para cada ano, desde 1996 até 2003. A informação de data de contratação encontra-se na
coluna HireDate da tabela DimEmployee. Utilize o formato:
X contratações em 1996
Y contratações em 1997
Z contratações em 1998
...
...
N contratações em 2003
*/

Declare @varValorInicial int, @varValorFinal int, @varContratacao int
set @varValorInicial = (select min(Ano_Contratacao) from vwContratacoes)
set @varValorFinal = (select MAX(Ano_Contratacao) from vwContratacoes)


while @varValorInicial <= @varValorFinal
begin
set @varContratacao = (select Qtd_Contratacoes from vwContratacoes where Ano_Contratacao = @varValorInicial)
print convert(varchar, @varContratacao) + ' Contratações em ' + convert(varchar, @varValorInicial)
set @varValorInicial += 1
end
go


/*
3. Utilize um Loop While para criar uma tabela chamada Calendario, contendo uma coluna que
comece com a data 01/01/2021 e vá até 31/12/2021.
*/
declare @varData datetime
set @varData = '01/01/2021'

while @varData <= CONVERT(datetime, '31/12/2021')
begin
print format(@varData, 'dd/MM/yyyy')
insert into Calendario(PERIODO)
values
	(@varData)
set @varData += day(0)
end