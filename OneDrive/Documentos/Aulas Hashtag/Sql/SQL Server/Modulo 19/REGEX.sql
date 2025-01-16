/* COLLATION
O que é? 
O Collation nos permite configurar se teremos diferenciação entre maiúscula e mminúscula, ou entre palavras acentuadas.

O COLLATION pode ser definido em níveis diferentes no SQL Server. Abaixo estão os três níveis:

1. A nível SQL Server
2. A nível Banco de Dados
3. A nível tabelas/colunas

1. A nível SQL Server

O COLLATION a princípio é definido durante a instalação do programa
Por padrão, o COLLATION, padrão é o seguinte:
Latin1_General_CI_AS
Onde CI significa Case Insensitive (Nâo diferencia miúscula de minúscula) e AS significa Accent Sensitive (Sensível ao Sotaque).
Para descobrir o COLLATION configurado, podemos utilizar o comando abaixo: */

SELECT SERVERPROPERTY('collation')

/* 2. A nível de Banco de dados

Por padrão, todos os bancos de dados vão herdar a configuração do COLLATION do SQL Server feito durante a instalação.
Em propriedades, conseguimos visualizar o COLLATION configurado.

Nós podemos também especificar o COLLATION do banco de dados no momento da sua criação */

CREATE DATABASE BD_Collation
collate Latin1_General_CS_AS

/* Podemos alterar o COLLATE APÓS CRIAR UM BANCO DE DADOS. NESTE CASO, USAMOS O COMANDO ABAIXO*/

ALTER DATABASE BD_Collation COLLATE Latin1_General_CI_AS

/* PARA SABER O COLLATION DE UM BANCO DE DADOS ESPECÍFICO, PODEMOS USAR O COMANDO ABAIXO*/

SELECT DATABASEPROPERTYEX('BD_Collation','collation')

/* 3. A NÍVEL DE COLUNA/TABELA

POR PADRÃO, UMA NOVA COLUNA DE TIPO VARCHAR HERDA O COLLATION DO BANCO DE DADOS, A MENOS QUE VOCÊ ESPECIFIQUE O COLLATION EXPLICITAMENTE AO CRIAR A TABELA.
PARA CRIAR UMA COLUNA COM UM COLLATION DIFERENTE, VOCÊ PODE ESPECIFICAR O AGRUPAMENTO USANDO O COMANDO COLLATE SQL. */

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

-- Case Sensitive (diferenciando maiúscula de minúscula)
-- LIKE PADRÃO COMO APRENDEMOS ATÉ AGORA

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

-- retornando nome que começam com a letra 'M', 'E' ou 'K'.

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

-- retornando nomes que possuem apenas 2 caracteres: O primerio uma letra, o segundo um número

select *
from Textos
where Texto like '[A-z][0-9]'

/* Retornando os nomes que:
1. CoMEÇAM COM A LETRA 'M' OU 'm'
2. O segundo caractere pode ser qualquer coisa ('_' é um curinga)
3. O terceiro caractere pode ser a letra R ou a letra r
4. Possui uma quantidade qualquer de caractere depois do terceiro (por conta do '%')
*/
select *
from Tabela
where Nome like '[Mm]_[Rr]%'

-- Retorna nomes que não começa com as letras 'L' ou 'l'

select *
from Tabela
where Nome like '[^Ll]%'

-- Retorna nomes que começam com qualquer caractere (caracteres curinga) e a segunda letra não é um 'E' ou 'e'

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

-- Retornando os números que possuem 2 dígitos na parte inteira

select *
from Numeros
Where Numero like '[0-9][0-9].[0][0]'

-- Retornando linhas que:
/* 1. Possuem 3 dígitos na parte inteira, sendo o primeiro dígito igual a 5
2. O primeiro número da parte decimal seja 7
3. O segundo número da parte decimal seja um número entre 0 e 9
*/

select *
from Numeros
where Numero like '[5]__.[7][0-9]'