/* Constraints 
*
*

Objetivo: Entender o que sã constraints e como trabalhar com elas na prática.
*/

-- I. Constraints
-- Constraints no SQL são regras (Restrições) que podemos definir para uma coluna de uma tabela abaixo.
-- Abaixo temos uma lista de restrições:

-- 1. Not Null
-- 2. UNIQUE
-- 3. Check
-- 4. Default
-- 5. Identity
-- 6. Primary Key
-- 7. Foreign Key

-- 1. Not Null
-- Essa constraint não premite que sejam adicionados valores nulos na coluna,

-- 2. Unique
-- Identifica uma coluna de forma única, sem permitir valores duplicados (mas, permite NULL).

-- 3. CHECK
-- Verifica se o valor adicionado na coluna atende a uma determinada condição.

-- 4. Default
-- Retorna um valor default caso a coluna não seja preenchida

-- 5. Identity
-- Permite que uma coluna siga uma auto numeração (usada em colunas de ID).

-- 6. Primary key
-- Uma chave primária (Primary Key) é uma coluna que identifica de forma única as linhas
-- de uma tabela. Nenhum dos valores de uma coluna de chave primária deve ser nulo ou se repetir.
-- Será através dessa coluna que críaremos relações entre as tabelas.

-- 7. Foreign Key
-- Uma chave estrangeira (Foreign Key) é uma coluna que será relacionada com a chave primária
-- de uma outra tabela.


-- Tabela 1: dCliente

-- A tabela dCliente deve conter as seguintes colunas:

-- Coluna 1: Id_cliente do tipo int					--> Chave Primária
-- Coluna 2: nome_Cliente do tipo VARCHAR			--> Não aceita valores nulo
-- Coluna 3: genero Varchar							--> Não aceita valores nulos e devem ser ('M', 'F', 'O', 'PND')
-- Coluna 4: data_nascimento date					--> Não aceita valores nulos
-- Coluna 5: cpf do tipo Varchar					--> Não aceita valores duplicados nem nulos 

create table dCliente(
	id_Cliente int identity(1, 1),
	Cliente Varchar(100) not null,
	Genero varchar (100) not null ,
	Data_de_Nascimento date not null,
	CPF varchar(100) not null,
	Constraint dcliente_id_cliente_pk primary key(id_Cliente),
	constraint dcliente_genero_ck check(Genero in ('M', 'F', 'O', 'PND')),
	constraint dcliente_cpf_un unique(CPF)
)

insert into dCliente(Cliente, Genero, Data_de_Nascimento, CPF)
values
	('Andre Martins', 'M' , '12/02/1989', '213.132.131-00'),
	('Bárbara Campos', 'F',	'07/05/1992', '556.554.658-00'),
	('Carol Freitas', 'F', '23/04/1985', '311.231.323-00'),
	('Diego Cardoso', 'M',	'11/10/1994', '656.431.654-00'),	
	('Eduardo Pereira', 'M', '09/11/1988', '645.664.635-00'),
	('Fabiana Silva', 'PND', '02/09/1989', '351.313.613-00'),
	('Gustavo Barbosa', 'O', '27/06/1993', '654.315.135-00'),
	('Helen Viana',	'PND', '11/02/1990', '564.654.613-00')
go

SELECT * FROM dCliente
-- Tabela 2: dGerente

-- A tabela dGerente deve conter as seguintes colunas:

-- Coluna 1: Id_gerente do tipo int					--> Chave Primária e auto incrementada
-- Coluna 2: nome_gerente do tipo VARCHAR			--> Não aceita valores nulos
-- Coluna 3: data_contratacao varchar				--> Não aceita valores nulos
-- Coluna 4: salário do tipo float					--> Não aceita valores nulos nem abaixo de zero 

create table dGerente(
	id_gerente int identity(1, 1),
	nome_gerente varchar(100) not null,
	data_contratacao varchar(100) not null,
	salario float not null,
	constraint dgerente_id_gerente_pk primary key(id_gerente),
	constraint dgerente_salario_ck check(salario > 0)
)
GO

insert into dGerente(Nome_Gerente, Data_Contratacao, Salario)
values
	('Lucas Sampaio',	'21/03/2015', 6700),
	('Mariana Padilha',	'10/01/2011', 9900),
	('Nathália Santos',	'03/10/2018', 7200),
	('Otávio Costa',		'18/04/2017', 1100)
GO
-- Tabela 3: fContratos

-- A tabela dContratos deve conter as seguintes colunas:

-- Coluna 1: Id_contrato do tipo int				--> Chave Primária e auto incrementada
-- Coluna 2: data_assinatura do tipo Date			--> Valor Padrão (GETDATE) caso não seja preenchida
-- Coluna 3: id_Cliente do tipo int 				--> Chave Estrangeira
-- Coluna 4: id_Gerente do tipo int					--> Chave Estrangeira 
-- Coluna 5: valor_contrato do tipo FLOAT			--> Não aceita valores nulos e deve ser maior que zero

create table fContratos(
	id_contrato int identity(1, 1),
	data_assinatura date default getdate(),
	id_cliente int,
	id_gerente int,
	valor_contrato float,
	constraint fcontratos_id_contrato_pk primary key(id_contrato),
	constraint fcontratos_id_cliente_fk foreign key(id_cliente) references dcliente(id_cliente),
	constraint fcontratos_id_gerente_fk foreign key(id_gerente) references dgerente(id_gerente),
	constraint fcontratos_valor_contrato_ck check(valor_contrato > 0)
)

insert into fContratos(Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Contrato)
values
	('12/01/2019', 8, 1, 2300),
	('10/02/2019', 3, 2, 15500),
	('07/03/2019', 7, 2, 6500),
	('15/03/2019', 1, 3, 33000),
	('21/03/2019', 5, 4, 11100),
	('23/03/2019', 4, 2, 5500),
	('28/03/2019', 5, 3, 55000),
	('04/04/2019', 2, 1, 31000),
	('05/04/2019', 8, 4, 3400),
	('05/04/2019', 6, 2, 8200)


-- Violação de constraints
select * from dCliente

-- Exemplo 1: Violação Not Null e Check

insert into dCliente(Cliente, Genero, Data_de_Nascimento, CPF) values
	('Katia Lopes', 'F', '10/01/1989', '123.234.812-20')

select * from dCliente

insert into dCliente(Cliente, Genero, Data_de_Nascimento, CPF) values
	('Mathaeuac', 'Feminino', '10/01/1989', '123.234.812-25')


-- Exemplo 2: Violação Unique

select * from dCliente

insert into dCliente(Cliente, Genero, Data_de_Nascimento, CPF) values
	('Mathaeuac', 'F', '10/01/1989', '311.231.323-00')

-- Exemplo 3: Violação de FK e PK

select * from dCliente
select * from dGerente
select * from fContratos

insert into fContratos(data_assinatura, id_cliente, id_gerente, valor_contrato) values
	('12/01/2023', 4, 10, 15000)


-- III. Gerenciamento de Constraints

-- 1. Adicionar constraints
-- 2. Renomear constraints
-- 3. Remover constraints

-- Remova a constraint PK da tabela fContratos.
alter table fContratos
drop constraint fcontratos_id_contrato_pk

-- Remova a constraint FK cliente da tabela FContratos.
alter table fContratos
drop constraint fcontratos_id_cliente_fk

-- Adicione a constraint pk id_Cliente na tabela fcontratos.
alter table fContratos
Add constraint fcontratos_id_contrato_pk Primary key(id_contrato)

-- Adicione a constraint pk id_Cliente na tabela fcontratos.
alter table fContratos
Add constraint fcontratos_id_cliente_fk foreign key(id_cliente) references dCliente(id_cliente)


-- Alterar o nome de uma constraint criada.