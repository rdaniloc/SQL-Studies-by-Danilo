-- Atividade Loop

/*
1. Utilize o Loop While para criar um contador que comece em um valor inicial @ValorInicial e
termine em um valor final @ValorFinal. Voc� dever� printar na tela a seguinte frase:
�O valor do contador �: � + ___
*/

Declare @varValorInicial int, @varValorFinal int
set @varValorInicial= 0
set @varValorFinal = 10

while @varValorInicial < @varValorFinal
begin
	set @varValorInicial += 1
	print 'O valor do contador �: ' + convert(varchar, @varValorInicial)
end
go

/*
2. Voc� dever� criar uma estrutura de repeti��o que printe na tela a quantidade de contrata��es
para cada ano, desde 1996 at� 2003. A informa��o de data de contrata��o encontra-se na
coluna HireDate da tabela DimEmployee. Utilize o formato:
X contrata��es em 1996
Y contrata��es em 1997
Z contrata��es em 1998
...
...
N contrata��es em 2003
*/

Declare @varValorInicial int, @varValorFinal int, @varContratacao int
set @varValorInicial = (select min(Ano_Contratacao) from vwContratacoes)
set @varValorFinal = (select MAX(Ano_Contratacao) from vwContratacoes)


while @varValorInicial <= @varValorFinal
begin
set @varContratacao = (select Qtd_Contratacoes from vwContratacoes where Ano_Contratacao = @varValorInicial)
print convert(varchar, @varContratacao) + ' Contrata��es em ' + convert(varchar, @varValorInicial)
set @varValorInicial += 1
end
go


/*
3. Utilize um Loop While para criar uma tabela chamada Calendario, contendo uma coluna que
comece com a data 01/01/2021 e v� at� 31/12/2021.
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