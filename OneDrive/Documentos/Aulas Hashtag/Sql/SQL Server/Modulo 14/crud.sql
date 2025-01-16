-- Craindo e deletando nosso primeiro Banco de Dados

CREATE DATABASE BDIMPRESSIONADOR
GO
USE BDIMPRESSIONADOR
GO

-- Criando a primeira Tabela.
-- Crie uma tabela chamada 'Produtos'
-- Essa tabela deve conter 4 colunas: id_produto, data_validade e preco_produto.
-- Certifique-se de que o tipo das colunas está correto.

Create Table Produtos(
	Id_produto int,
	Nome_produto varchar(200),
	Data_validade datetime,
	Preco_produto float
)

select * from Produtos

insert into Produtos(Id_produto, Nome_produto, Data_validade, Preco_produto)
select
	ProductKey,
	ProductName,
	AvailableForSaleDate,
	UnitPrice
from
	ContosoRetailDW.dbo.DimProduct

select * from Produtos

insert into Produtos(Id_produto, Nome_produto, Data_validade, Preco_produto)
values
	(1, 'Arroz', '31/12/2021', 25.20),
	(2, 'Feijão', '20/11/2020', 8.99)


update Produtos
set Nome_produto = 'Açai'
where Id_produto = 2

delete
from Produtos
where Id_produto = 2

drop table Produtos


-- Usar o códifo abaixo para as demais aulas:
create table Funcionarios(
	id_Funcionario int,
	nome_Fucionario varchar(100),
	salario float,
	data_Nascimento datetime
)
go
insert into Funcionarios(id_Funcionario, nome_Fucionario, salario, data_Nascimento)
values
	(1, 'Lucas', 1500, '20/03/1990'),
	(2,	'Andresa', 2300, '07/12/1988'),
	(3,	'Felipe', 4000, '13/02/1993'),
	(4,	'Marcelo', 7100, '10/04/1993'),
	(5,	'Carla', 3200, '02/09/1996'),
	(6,	'Juliana', 5500, '21/01/1989'),
	(7,	'Mateus', 1900,	'02/11/1993'),
	(8, 'Sandra', 3900, '09/05/1990'),
	(9,	'Andre', 1000, '13/03/1994'),
	(10, 'Julio', 4700, '05/07/1992')
go
select * from Funcionarios
go

-- ALTER TABLE: Adicionar colunas, alterar tipo de dados de uma coluna e deletar coluna
-- Utilize a tabela funcionários mostrada na aula anterior.

select * from Funcionarios
go
-- adicionar coluna:
Alter Table Funcionarios
add cargo varchar(100), bonus Float
go

update Funcionarios
set cargo = 'Analista', bonus = 0.15
where id_Funcionario = 1
go

-- Alterar tipo de dados de uma coluna

alter table Funcionarios
alter column salario int
go
-- Deletar coluna

alter table Funcionarios
drop column cargo, bonus