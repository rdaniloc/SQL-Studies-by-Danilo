-- Atividade Constraints

/*
1. Voc� est� respons�vel por criar um Banco de Dados com algumas tabelas que v�o armazenar informa��es associadas ao aluguel de carros de uma locadora.
a) O primeiro passo � criar um banco de dados chamado AlugaFacil.
*/
create database AlugaFacil;
use AlugaFacil
/*
b) O seu banco de dados deve conter 3 tabelas e a descri��o de cada uma delas � mostrada abaixo:
Obs: voc� identificar� as restri��es das tabelas a partir de suas descri��es.
Tabela 1: Cliente
- id_cliente
- nome_cliente
- cnh
- cartao
A tabela Cliente possui 4 colunas.
A coluna id_cliente deve ser a chave prim�ria da tabela, al�m de ser autoincrementada de forma autom�tica.
As colunas nome_cliente, cnh e cartao n�o podem aceitar valores nulos, ou seja, para todo cliente estes campos devem necessariamente ser preenchidos.
Por fim, a coluna cnh n�o pode aceitar valores duplicados.
*/
create table Cliente(
	id_cliente int identity(1,1),
	nome_cliente varchar(100) not null,
	cnh_cliente char(9) not null,
	cartao_cliente varchar(20) not null
	constraint id_cliente_pk primary key(id_cliente),
	constraint nome_cliente_un unique(nome_cliente),
	constraint cnh_client_un unique(cnh_cliente),
	constraint cartao_cliente_un unique(cartao_cliente)
)
go
/*
Tabela 2: Carro
- id_carro
- placa
- modelo
- tipo
A tabela Carro possui 3 colunas.
A coluna id_carro deve ser a chave prim�ria da tabela, al�m de ser autoincrementada de forma autom�tica.
As colunas modelo, tipo e placa n�o podem aceitar valores nulos.
Os tipos de carros cadastrados devem ser: Hatch, Sedan, SUV.
Por fim, a coluna placa n�o pode aceitar valores duplicados.
*/
go
create table Carro(
	id_carro int identity(1,1),
	placa_carro char(7) not null,
	modelo_carro varchar(20) not null,
	tipo_carro varchar(20) not null,
	constraint id_carro_pk primary key(id_carro),
	constraint tipo_carro_ck check(tipo_carro in ('Hatch', 'Sedan', 'SUV')),
	constraint placa_carro_un unique(placa_carro)
)
go
/*
Tabela 3: Locacoes
- id_locacao
- data_locacao
- data_devolucao
- id_carro
- id_cliente
A tabela Locacoes possui 5 colunas.
A coluna id_locacao deve ser a chave prim�ria da tabela, al�m de ser autoincrementada de
forma autom�tica.
Nenhuma das demais colunas devem aceitar valores nulos.
As colunas id_carro e id_cliente s�o chaves estrangeiras que permitir�o a rela��o da tabela
Locacoes com as tabelas Carro e Cliente.
*/

create table Locacoes(
	id_locacao int identity(1,1),
	data_locacao date,
	data_devolucao date,
	id_carro int not null,
	id_cliente int not null,
	constraint id_locacao_pk primary key(id_locacao),
	constraint id_carro_fk foreign key(id_carro) references Carro(id_carro),
	constraint id_cliente_fk foreign key(id_cliente) references Cliente(id_cliente)
)
/*
2. Tente violar as constraints criadas para cada tabela. Este exerc�cio � livre.
Obs: Para fazer o exerc�cio de viola��o de constraints basta utilizar o comando INSERT INTO para
adicionar valores nas tabelas que n�o respeitem as restri��es (constraints) estabelecidas na
cria��o das tabelas.
Ao final, exclua o banco de dados criado.
*/


select * from Carro