/* COLLATION
O que �? 
O Collation nos permite configurar se teremos diferencia��o entre mai�scula e mmin�scula, ou entre palavras acentuadas.

O COLLATION pode ser definido em n�veis diferentes no SQL Server. Abaixo est�o os tr�s n�veis:

1. A n�vel SQL Server
2. A n�vel Banco de Dados
3. A n�vel tabelas/colunas

1. A n�vel SQL Server

O COLLATION a princ�pio � definido durante a instala��o do programa
Por padr�o, o COLLATION, padr�o � o seguinte:
Latin1_General_CI_AS
Onde CI significa Case Insensitive (N�o diferencia mi�scula de min�scula) e AS significa Accent Sensitive (Sens�vel ao Sotaque).
Para descobrir o COLLATION configurado, podemos utilizar o comando abaixo: */

SELECT SERVERPROPERTY('collation')

/* 2. A n�vel de Banco de dados

Por padr�o, todos os bancos de dados v�o herdar a configura��o do COLLATION do SQL Server feito durante a instala��o.
Em propriedades, conseguimos visualizar o COLLATION configurado.

N�s podemos tamb�m especificar o COLLATION do banco de dados no momento da sua cria��o */

CREATE DATABASE BD_Collation
collate Latin1_General_CS_AS

/* Podemos alterar o COLLATE AP�S CRIAR UM BANCO DE DADOS. NESTE CASO, USAMOS O COMANDO ABAIXO*/

ALTER DATABASE BD_Collation COLLATE Latin1_General_CI_AS

/* PARA SABER O COLLATION DE UM BANCO DE DADOS ESPEC�FICO, PODEMOS USAR O COMANDO ABAIXO*/

SELECT DATABASEPROPERTYEX('BD_Collation','collation')

/* 3. A N�VEL DE COLUNA/TABELA

POR PADR�O, UMA NOVA COLUNA DE TIPO VARCHAR HERDA O COLLATION DO BANCO DE DADOS, A MENOS QUE VOC� ESPECIFIQUE O COLLATION EXPLICITAMENTE AO CRIAR A TABELA.
PARA CRIAR UMA COLUNA COM UM COLLATION DIFERENTE, VOC� PODE ESPECIFICAR O AGRUPAMENTO USANDO O COMANDO COLLATE SQL. */

CREATE TABLE Tabela(
ID INT,
Nome varchar(100) COLLATE Latin1_General_CS_AS)

/* Podemos ver o COLLATION DE CADA COLUNA DA TABELA USANDO O COMANDO ABAIXO: */

sp_help Names

/* Exemplo*/

drop table Tabela

INSERT INTO Tabela(ID, Nome)
values
	(1, 'Matheus'),
	(2, 'Marcela'),
	(3, 'marcos'),
	(4, 'MAuricio'),
	(5, 'Marta'),
	(6, 'Miranda'),
	(7, 'Melissa'),
	(8, 'Lucas'),
	(9, 'luisa'),
	(10, 'Pedro')

select * from Tabela

Select
	ID,
	Nome
from Tabela
Where Nome COLLATE Latin1_General_Ci_AS = 'marcela'

-- Case Sensitive (diferenciando mai�scula de min�scula)
-- LIKE PADR�O COMO APRENDEMOS AT� AGORA

SELECT *
FROM Tabela
where Nome like 'mar%'

-- retorna as linha onde a primeira letra seja 'm', a segunda seja 'a' e a terceira seja 'r'

SELECT *
FROM Tabela
where Nome like '[m][a][r]%'

-- retorna as linhas onde a primeira letra seja [M], a segunda seja 'a' e a terceira 'r'

select *
from Tabela
where Nome like '[M][a][r]%'

-- retorna as linhas onde a primeira letra seja 'M' ou 'm', e a segunda seja 'A' ou 'a'

select *
from Tabela
where Nome like '[Mm][Aa]%'

-- like: filtrando os primeiros caracteres + case sensitive

Create table Textos(
ID INT,
Texto varchar(100) COLLATE Latin1_General_CS_AS)

insert into Textos(ID, Texto)
Values
	(1,'Marcos'),
	(2, 'Excel'),
	(3,'leandro'),
	(4,'K'),
	(5,'X7'),
	(6,'l9'),
	(7,'#M'),
	(8,'@9'),
	(9,'M'),
	(10,'RT')

select * from Textos

-- retornando nome que come�am com a letra 'M', 'E' ou 'K'.

select *
from Textos
where Texto like '[MEK]%'

-- RETORNANDO NOMES QUE POSSUEN AOENAS 1 CARACTERE

select *
from Textos
where Texto like '[A-z]'

-- retornando nomes que possuem apenas 2 caracteres

select *
from Textos
where Texto like '[A-z][A-z]'

-- retornando nomes que possuem apenas 2 caracteres: O primerio uma letra, o segundo um n�mero

select *
from Textos
where Texto like '[A-z][0-9]'

/* Retornando os nomes que:
1. CoME�AM COM A LETRA 'M' OU 'm'
2. O segundo caractere pode ser qualquer coisa ('_' � um curinga)
3. O terceiro caractere pode ser a letra R ou a letra r
4. Possui uma quantidade qualquer de caractere depois do terceiro (por conta do '%')
*/
select *
from Tabela
where Nome like '[Mm]_[Rr]%'

-- Retorna nomes que n�o come�a com as letras 'L' ou 'l'

select *
from Tabela
where Nome like '[^Ll]%'

-- Retorna nomes que come�am com qualquer caractere (caracteres curinga) e a segunda letra n�o � um 'E' ou 'e'

select *
from Tabela
where Nome like '_[^Ee]%'

-- identificando caracteres especiais

select *
from Textos
where Texto like '%[^a-z0-9]%'

create table Numeros(
Numero Decimal(20,2))

insert into Numeros(Numero)
values
	(50),
	(30.23),
	(9),
	(100.54),
	(15.9),
	(6.5),
	(10),
	(501.76),
	(1000.56),
	(31)

-- Retornando os n�meros que possuem 2 d�gitos na parte inteira

select *
from Numeros
Where Numero like '[0-9][0-9].[0][0]'

-- Retornando linhas que:
/* 1. Possuem 3 d�gitos na parte inteira, sendo o primeiro d�gito igual a 5
2. O primeiro n�mero da parte decimal seja 7
3. O segundo n�mero da parte decimal seja um n�mero entre 0 e 9
*/

select *
from Numeros
where Numero like '[5]__.[7][0-9]'