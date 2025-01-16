-- group by + join
--1.a) crie um agrupamento mostrando o total de vendas (SalesQuantity) por ano (CalendarYear).
--1.b) Considere apenas o mês (CalendarMonthLabel) de 'January'.
--1.c) Na tabela resultante, mostre apenas os anos com um total de vendas maior ou igual a de 1200000
use ContosoRetailDW
select top(100) * from FactSales
select * from DimDate

select
	CalendarYear as 'Ano',
	Sum(SalesQuantity) as Total_Vendido
from
	FactSales
inner join DimDate
	on FactSales.DateKey = DimDate.Datekey
where CalendarMonthLabel = 'January'	
group By CalendarYear
having SUM(SalesQuantity) >= 1200000
Order By SUM(SalesQuantity) Desc

