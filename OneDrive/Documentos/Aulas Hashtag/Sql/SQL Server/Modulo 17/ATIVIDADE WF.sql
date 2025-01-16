-- Atividades de Windows Functions
go
CREATE VIEW vwProdutos AS
SELECT
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	COUNT(*) AS 'Quantidade_Vendida',
	ROUND(SUM(SalesAmount), 2) AS 'Receita_Total'
FROM 
	DimProduct
INNER JOIN FactSales
	ON DimProduct.ProductKey = FactSales.ProductKey
GROUP BY BrandName, ColorName
go
/*
1. Utilize a View vwProdutos para criar uma coluna extra calculando a quantidade total vendida
dos produtos.
*/
select 
	Marca,
	Cor,
	Quantidade_Vendida,
	Receita_Total,
	SUM(Quantidade_Vendida) over() as Qtd_Total
from vwProdutos


select 
	CONVERT(Date, DateKey) as Datas,
	SUM(SalesQuantity)
from FactSales
where DateKey > '31/12/2006' and DateKey < '01/02/2007'
group by CONVERT(Date, DateKey)
order by Datas Asc

/*
2. Crie mais uma coluna na consulta anterior, incluindo o total de produtos vendidos para cada
marca.
*/
select
	*,
	SUM(Quantidade_Vendida) Over() Total_Vendido,
	Sum(Quantidade_Vendida) Over(Partition by Marca) as Qtd_Por_Marca
from
	vwProdutos
/*
3. Calcule o % de participação do total de vendas de produtos por marca.
Ex: A marca A. Datum teve uma quantidade total de vendas de 199.041 de um total de 3.406.089
de vendas. Isso significa que a da marca A. Datum é 199.041/3.406.089 = 5,84%.
*/
select
	*,
	SUM(Quantidade_Vendida) Over() as Total_Vendido,
	SUM(Quantidade_Vendida) Over(Partition By Marca) as Qtd_Por_Marca,
	format(
		cast(
			SUM(Quantidade_Vendida) Over(Partition By Marca) as float
			)/
		cast(
			SUM(Quantidade_Vendida) Over() as float
			), 
			'0.00%'
		) as '%Participacao'
from
	vwProdutos
/*
4. Crie uma consulta à View vwProdutos, selecionando as colunas Marca, Cor,
Quantidade_Vendida e também criando uma coluna extra de Rank para descobrir a posição de
cada Marca/Cor. Você deve obter o resultado abaixo. Obs: Sua consulta deve ser filtrada para
que seja mostrada apenas a marca Contoso.
*/
select 
	Marca,
	Cor,
	Quantidade_Vendida,
	rank() over(partition by Marca order by Quantidade_Vendida desc) as 'Rank'
from vwProdutos
where Marca = 'Contoso'
go
/*
Exercício Desafio 1.
Para responder os próximos 2 exercícios, você precisará criar uma View auxiliar. Diferente do
que foi feito anteriormente, você não terá acesso ao código dessa view antes do gabarito.
A sua view deve se chamar vwHistoricoLojas e deve conter um histórico com a quantidade de
lojas abertas a cada Ano/Mês. Os desafios são:
(1) Criar uma coluna de ID para essa View
(2) Relacionar as tabelas DimDate e DimStore
Dicas:

1- A coluna de ID será criada a partir de uma função de janela. Você deverá se atentar a forma
como essa coluna deverá ser ordenada, pensando que queremos visualizar uma ordem de
Ano/Mês que seja: 2005/january, 2005/February... e não 2005/April, 2005/August...
2- As colunas Ano, Mês e Qtd_Lojas correspondem, respectivamente, às seguintes colunas:
CalendarYear e CalendarMonthLabel da tabela DimDate e uma contagem da coluna OpenDate
da tabela DimStore.
*/
create view vwAuxiliar as
select
	ROW_NUMBER() over(Order by CalendarMonth asc) as 'ID',
	CalendarYear,
	CalendarMonthLabel,
	COUNT(OpenDate) as Contage_Aberturas 
from 
	DimDate
Left join DimStore
	on DimDate.Datekey = DimStore.OpenDate 
group by CalendarYear, CalendarMonthLabel, CalendarMonth
go

select * from vwAuxiliar
go
/*
5. A partir da view criada no exercício anterior, você deverá fazer uma soma móvel
considerando sempre o mês atual + 2 meses para trás.
*/
select
*,
SUM(
	Contage_Aberturas
	) 
over(
	Order by 
		ID 
	rows between 2 
	preceding and 
	current row
	) as 'Soma Movel'
from 
vwAuxiliar
/*
6. Utilize a vwHistoricoLojas para calcular o acumulado de lojas abertas a cada ano/mês.
*/

select 
	*,
	SUM(Contage_Aberturas) Over(Order By ID rows between Unbounded preceding and current row) as 'Acumulado' 
from vwAuxiliar

/*
Exercício Desafio 2
Neste desafio, você terá que criar suas próprias tabelas e views para conseguir resolver os
exercícios 7 e 8. Os próximos exercícios envolverão análises de novos clientes. Para isso, será
necessário criar uma nova tabela e uma nova view.
Abaixo, temos um passo a passo para resolver o problema por partes.
PASSO 1: Crie um novo banco de dados chamado Desafio e selecione esse banco de dados
criado.
PASSO 2: Crie uma tabela de datas entre o dia 1 de janeiro do ano com a compra
(DateFirstPurchase) mais antiga e o dia 31 de dezembro do ano com a compra mais recente.
Obs1: Chame essa tabela de Calendario.
Obs2: A princípio, essa tabela deve conter apenas 1 coluna, chamada data e do tipo DATE.
PASSO 3: Crie colunas auxiliares na tabela Calendario chamadas: Ano, Mes, Dia, AnoMes e
NomeMes. Todas do tipo INT.
PASSO 4: Adicione na tabela os valores de Ano, Mês, Dia, AnoMes e NomeMes (nome do mês
em português). Dica: utilize a instrução CASE para verificar o mês e retornar o nome certo.
PASSO 5: Crie a View vwNovosClientes, que deve ter as colunas mostradas abaixo.
*/

declare @varDataant datetime = (select min(DateFirstPurchase) from ContosoRetailDW.dbo.DimCustomer) , 
		@varDatapro datetime = (select MAX(DateFirstPurchase) from ContosoRetailDW.dbo.DimCustomer)

declare @varDataini datetime = (select DATEFROMPARTS(year(@varDataant), '1', '1')),
		@varDatafin datetime = (select DATEFROMPARTS(year(@varDatapro), '12', '31'))

while @varDataini <= @varDatafin
begin
	insert into Calendario(Datas)
	values
		(@varDataini)
	set @varDataini += day(0)
end
GO

alter table Calendario
add Ano int, Mes int, Dia int, AnoMes int, NomeMes varchar (50)
GO

declare @varData datetime = (select MIN(Datas) from Calendario), 
		@varDataMax datetime = (select MAX(Datas) from Calendario) 

while @varData <= @varDataMax
begin

	update Calendario
	set Ano = YEAR(Datas),
	Mes = MONTH(Datas),
	Dia = DAY(Datas),
	AnoMes =  concat(CONVERT(varchar, year(Datas)), Convert(varchar, format(month(Datas), '00'))),
	NomeMes = DATENAME(month, Datas)
	where Datas = @varData

	set @varData += day(0)
end

select * from Calendario
go


create view vwNovosCliente as 
select
	ROW_NUMBER() over(Order by AnoMes) as ID,
	Ano,
	NomeMes,
	COUNT(DateFirstPurchase) as contagem
from Calendario
Left join ContosoRetailDW.dbo.DimCustomer
	on Calendario.Datas = ContosoRetailDW.dbo.DimCustomer.DateFirstPurchase
group by Ano, AnoMes, NomeMes
go
SELECT * FROM vwNovosCliente

/* 
7.
a) Faça um cálculo de soma móvel de novos clientes nos últimos 2 meses.
*/

select
	*,
	SUM(Contagem) over(Order By ID rows between 2 preceding and current row) as SomaMovel   
from vwNovosCliente
/*
b) Faça um cálculo de média móvel de novos clientes nos últimos 2 meses.
select 
*/
select
	*,
	avg(contagem) over(Order by ID rows between 2 preceding and current row) as MediaMovel
from vwNovosCliente
go
/*
c) Faça um cálculo de acumulado dos novos clientes ao longo do tempo.
*/

select
	*,
	SUM(contagem) over(Order by ID rows between unbounded preceding and current row) as Acumulado
from vwNovosCliente
go

/*
d) Faça um cálculo de acumulado intra-ano, ou seja, um acumulado que vai de janeiro a
dezembro de cada ano, e volta a fazer o cálculo de acumulado no ano seguinte.
*/

select 
	*,
	SUM(contagem) over(partition by Ano order by ID rows between unbounded preceding and current row) as AcumuladoAno
from vwNovosCliente

/*
8. Faça os cálculos de MoM e YoY para avaliar o percentual de crescimento de novos clientes,
entre o mês atual e o mês anterior, e entre um mês atual e o mesmo mês do ano anterior.
*/

select
	*,
	lag(contagem, 1) over(Order by ID ) as 'lead',
	format(1.0*contagem/nullif(LAG(contagem, 1) over(Order By ID),0)-1, '0.00%') as MoM,
	format(1.0*contagem/nullif(lag(contagem, 12) over(Order By ID),0)-1, '0.00%') as YoY
from
	vwNovosCliente

	select * from vwNovosCliente