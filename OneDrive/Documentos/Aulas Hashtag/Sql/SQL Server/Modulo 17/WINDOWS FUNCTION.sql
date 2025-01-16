/*CREATE DATABASE WF
go
USE WF
go
CREATE TABLE Lojas(
   ID_Loja INT,
   Nome_Loja VARCHAR(100),
   Regiao VARCHAR(100),
   Qtd_Vendida FLOAT
)
go
INSERT INTO LOJAS(ID_Loja, Nome_Loja, Regiao, Qtd_Vendida)
VALUES
   (1, 'Botafogo Praia&Mar', 'Sudeste', 1800),
   (2, 'Lojas Vitoria', 'Sudeste', 800),
   (3, 'Empórioi Mineirinho', 'Sudeste', 2300),
   (4, 'Central Paulista', 'Sudeste', 1800),
   (5, 'Rio 90 graus', 'Sudeste', 700),
   (6, 'Casa Flor & Anópolis', 'Sul', 2100),
   (7, 'Pampas & Co', 'Sul', 990),
   (8, 'Paraná Papéis', 'Sul', 2800),
   (9, 'Amazonas Prime', 'Norte', 4200),
   (10, 'Pará Bens', 'Norte', 3200),
   (11, 'Tintas Rio Branco', 'Norte', 1500),
   (12, 'Nordestemido Hall', 'Nordeste', 1910),
  (13, 'Cachoerinha Loft', 'Nordeste', 2380)
  go
*/

 -- Funções de Janela
 -- Funções de Agregação: Sum, Count, Avg, Min, Max
 -- Crie uma coluna contendo a soma total das vendas da tabela Lojas.

 select
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	SUM(Qtd_Vendida) Over() as Total_Vendido,
	format(Qtd_Vendida/SUM(Qtd_Vendida) over(), '0.00%') as '% do Total'
from Lojas
order by ID_Loja

-- b) Calcule o % de participação de cada loja em relação ao total de vendas de cada região.

 select
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	SUM(Qtd_Vendida) Over(Partition by Regiao) as 'Total Vendido',
	format(Qtd_Vendida/SUM(Qtd_Vendida) Over(Partition by Regiao), '0.00%') as '% por Região'
from Lojas
order by ID_Loja

-- Funções de janela
-- Funções de Classificação: Row_Number, Rank, Dense_Rank, Ntile

select
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	ROW_NUMBER() over(partition by Regiao Order by Qtd_Vendida Desc) as 'RowNUmber',
	Rank() Over(Partition by Regiao Order By Qtd_Vendida desc) as 'Rank',
	DENSE_RANK() Over(Partition by Regiao Order By Qtd_Vendida desc) as 'Dense',
	NTILE(2) Over(Partition By Regiao Order By Qtd_Vendida Desc) as 'ntile'
from Lojas
order by ID_Loja

-- Funções de janela
-- Funções de Classificação: Ranking com Group By
-- Crie uma tabela com o total de vendas por região e adicione uma coluna de ranking a essa tabela

select
	Regiao as 'Regiao',
	sum(Qtd_Vendida) as 'Total Vendido',
	RANK() Over(Order by sum(Qtd_Vendida) Desc) as 'Ranking'
from
	Lojas
group by Regiao
Order by SUM(Qtd_Vendida) desc

-- Funções de Janela
-- Cálculo de soma móvel e média móvel

create table Resultado(
	Data_Fechamento datetime,
	Mes_Ano varchar(100),
	Faturamento_MM float)

Insert into Resultado(Data_Fechamento, Mes_Ano, Faturamento_MM)
Values
	('01/01/2020', 'JAN-20', 8),
	('01/02/2020', 'FEV-20', 10),
	('01/03/2020', 'MAR-20', 6),
	('01/04/2020', 'ABR-20', 9),
	('01/05/2020', 'MAI-20', 5),
	('01/06/2020', 'JUN-20', 4),
	('01/07/2020', 'JUL-20', 7),
	('01/08/2020', 'AGO-20', 11),
	('01/09/2020', 'SET-20', 9),
	('01/10/2020', 'OUT-20', 12),
	('01/11/2020', 'NOV-20', 11),
	('01/12/2020', 'DEZ-20', 10)
GO

-- Soma móvel

SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	SUM(Faturamento_MM) Over(Order by Data_Fechamento rows between 1 preceding and current row) as 'SomaMovel',
	SUM(Faturamento_MM) Over(Order by Data_Fechamento rows between 1 preceding and 1 Following) as 'SomaMovel',
	SUM(Faturamento_MM) Over(Order by Data_Fechamento rows between Unbounded preceding and current row) as 'Acumulado'
FROM
	Resultado
go
-- Funções de Janela
-- Funções de OffSet (Deslocamento): Lag e Lead

SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	format((Faturamento_MM/nullif(LAG(Faturamento_MM, 1, 0) Over(Order By Data_Fechamento), 0))-1, '0.00%') as '%MoM',
	Lead(Faturamento_MM, 1,0) Over(Order BY Data_Fechamento) as 'Lead'
from Resultado

select NullIf(4,0)

-- Funções de Janela
-- Funções de OFFSET (Deslocamento): Firt_Value e Last_Value
-- Cálculo MoM

select
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	FIRST_VALUE(Faturamento_MM) Over(Order By Data_Fechamento) as 'Primeiro Valor',
	LAST_VALUE(Faturamento_MM) Over(Order BY Data_Fechamento) as 'Último Valor',
	LAST_VALUE(Faturamento_MM) Over(Order BY Data_Fechamento rows between unbounded preceding and unbounded following) as 'Último Valor'
from Resultado
Order By Data_Fechamento
