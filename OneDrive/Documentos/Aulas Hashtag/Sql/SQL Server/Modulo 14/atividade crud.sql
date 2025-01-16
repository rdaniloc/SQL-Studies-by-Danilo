-- ATIVIDADE CRUD
/*
1. a) Crie um banco de dados chamado BD_Teste.
b) Exclua o banco de dados criado no item anterior.
c) Crie um banco de dados chamado Exercicios.
*/

-- a)
CREATE DATABASE BD_Teste
go
-- b)
drop database BD_Teste
go
-- c)
create database BD_Exercicios
go

/*
2. No banco de dados criado no exercício anterior, crie 3 tabelas, cada uma contendo as seguintes
colunas:
Tabela 1: dCliente
- ID_Cliente
- Nome_Cliente
- Data_de _Nascimento
Tabela 2: dGerente
- ID_Gerente
- Nome_Gerente
- Data_de_Contratacao
- Salario
Tabela 3: fContratos
- ID_Contrato
- Data_de_Assinatura
- ID_Cliente
- ID_Gerente
- Valor_do_Contrato
Lembre-se dos seguintes pontos:
a) Garantir que o Banco de Dados Exercicios está selecionado.
b) Definir qual será o tipo de dados mais adequado para cada coluna das tabelas. Lembrando que
os tipos de dados mais comuns são: INT, FLOAT, VARCHAR e DATETIME.
Por fim, faça um SELECT para visualizar cada tabela.
*/
use BD_Exercicios

create table D_Clientes(
	ID_Cliente int,
	Nome_Cliente varchar(50),
	Data_de_Nascimento datetime
)
go

create table D_Gerente(
	ID_Gerente int,
	Nome_Gerente varchar(50),
	Data_De_Contratacao datetime,
	Salario float
)
go

create table D_Contratos(
	ID_Contrato int,
	Data_Assinatura datetime,
	ID_Gerente int,
	ID_Cliente int,
	Valor_Do_Contrato float
)
go
select * from D_Gerente
go
/*
3. Em cada uma das 3 tabelas, adicione os seguintes valores:
*/

insert into D_Clientes(ID_Cliente, Nome_Cliente, Data_de_Nascimento)
values
	(1,	'Andre Martins',	'12/02/1989'),
	(2,	'Bárbara Campos',	'07/05/1992'),
	(3,	'Carol Freitas',	'23/04/1985'),
	(4,	'Diego Cardoso',	'11/10/1994'),	
	(5,	'Eduardo Pereira',	'09/11/1988'),
	(6,	'Fabiana Silva',	'02/09/1989'),
	(7,	'Gustavo Barbosa',	'27/06/1993'),
	(8,	'Helen Viana',		'11/02/1990')
go
insert into D_Gerente(ID_Gerente, Nome_Gerente, Data_De_Contratacao, Salario)
values
	(1,	'Lucas Sampaio',	'21/03/2015', 6700),
	(2,	'Mariana Padilha',	'10/01/2011', 9900),
	(3,	'Nathália Santos',	'03/10/2018', 7200),
	(4,	'Otávio Costa',		'18/04/2017', 1100)
go
insert into D_Contratos(ID_Contrato, Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Do_Contrato)
values
	(1, '12/01/2019', 8, 1, 2300),
	(2, '10/02/2019', 3, 2, 15500),
	(3, '07/03/2019', 7, 2, 6500),
	(4,	'15/03/2019', 1, 3, 33000),
	(5,	'21/03/2019', 5, 4, 11100),
	(6,	'23/03/2019', 4, 2, 5500),
	(7,	'28/03/2019', 9, 3, 55000),
	(8,	'04/04/2019', 2, 1, 31000),
	(9,	'05/04/2019', 10, 4, 3400),
	(10,'05/04/2019', 6, 2, 8200)
go
select * from D_Contratos
go
select * from D_Clientes
go
select * from D_Gerente
go
/*
4. Novos dados deverão ser adicionados nas tabelas dCliente, dGerente e fContratos. Fique livre
para adicionar uma nova linha em cada tabela contendo, respectivamente,
(1) um novo cliente (id cliente, nome e data de nascimento)
(2) um novo gerente (id gerente, nome, data de contratação e salário)
(3) um novo contrato (id, data assinatura, id cliente, id gerente, valor do contrato)
*/
go
insert into D_Clientes(ID_Cliente, Nome_Cliente, Data_de_Nascimento)
values
	(9, 'Caio Reis', '21/03/1997')
go
insert into D_Gerente(ID_Gerente, Nome_Gerente, Data_De_Contratacao, Salario)
values
	(5, 'Lucas Santos', '25/03/2023', 6000)
go
insert into D_Contratos(ID_Contrato, Data_Assinatura, ID_Gerente, ID_Cliente, Valor_Do_Contrato)
values
	(11, '21/04/2023', 5, 9, 45000)
go
/*
5. O contrato de ID igual a 4 foi registrado com alguns erros na tabela fContratos. Faça uma
alteração na tabela atualizando os seguintes valores:
Data_de_Assinatura: 17/03/2019
ID_Gerente: 2
Valor_do_Contrato: 33500
*/

update D_Contratos
set Data_Assinatura = '17/03/2019', ID_Gerente = 2, Valor_Do_Contrato = 33500
where ID_Contrato = 4
go
/*
6. Delete a linha da tabela fContratos que você criou na questão 4.
*/

delete
from D_Contratos
where ID_Contrato = 11 
go