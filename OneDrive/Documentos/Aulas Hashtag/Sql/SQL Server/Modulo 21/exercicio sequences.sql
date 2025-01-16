/*
0. Crie o Banco de Dados AlugaFacil, onde serão criadas as sequences e tabelas dos exercícios.
*/
create database AlugaFacil
/*
1. Vamos criar Sequences que serão utilizadas nas tabelas: Carro, Cliente e Locacoes.
Essas sequences serão chamadas de: cliente_seq, carro_seq e locaçoes_seq.
Todas essas sequences devem começar pelo número 1, incrementar de 1 em 1 e não terem
valor máximo.
*/
create sequence cliente_seq
as int
start with 1
increment by 1
no maxvalue
no cycle

create sequence carro_seq
as int
start with 1
increment by 1
no maxvalue
no cycle

create sequence locacoes_seq
as int
start with 1
increment by 1
no maxvalue
no cycle


drop table Locacoes
drop table Carro
drop table Cliente

/*
2. Utilize as sequences nas 3 tabelas: Carro, Cliente e Locacoes. Você deve excluir as tabelas
existentes e recriá-las. Lembre-se que não é necessário utilizar a constraint IDENTITY nas
colunas de chave primária uma vez que nelas serão usadas as Sequences.
Tabela 1: Cliente
- id_cliente
- nome_cliente
- cnh
- cartao
A tabela Cliente possui 4 colunas.
A coluna id_cliente deve ser a chave primária da tabela.
As colunas nome_cliente, cnh e cartao não podem aceitar valores nulos, ou seja, para todo
cliente estes campos devem necessariamente ser preenchidos.
Por fim, a coluna cnh não pode aceitar valores duplicados.
*/
create table Cliente(
	id_cliente int,
	nome_cliente varchar(100) not null,
	cnh_cliente char(9) not null,
	cartao_cliente varchar(20) not null
	constraint id_cliente_pk primary key(id_cliente),
	constraint nome_cliente_un unique(nome_cliente),
	constraint cnh_client_un unique(cnh_cliente),
	constraint cartao_cliente_un unique(cartao_cliente)
)
select * from Cliente
insert into Cliente(id_cliente, nome_cliente, cnh_cliente, cartao_cliente) 
values
	(next value for cliente_seq, 'Danilo', '536846248', '4654213135446546'),
	(next value for cliente_seq, 'Diego', '534546248', '4655646466546545')
/*
Tabela 2: Carro
- id_carro
- placa
- modelo
- tipo
A tabela Carro possui 3 colunas.
A coluna id_carro deve ser a chave primária da tabela.
As colunas modelo, tipo e placa não podem aceitar valores nulos.
Os tipos de carros cadastrados devem ser: Hatch, Sedan, SUV.
Por fim, a coluna placa não pode aceitar valores duplicados.
*/
create table Carro(
	id_carro int,
	placa_carro char(7) not null,
	modelo_carro varchar(20) not null,
	tipo_carro varchar(20) not null,
	constraint id_carro_pk primary key(id_carro),
	constraint tipo_carro_ck check(tipo_carro in ('Hatch', 'Sedan', 'SUV')),
	constraint placa_carro_un unique(placa_carro)
)

insert into Carro(id_carro, placa_carro, modelo_carro, tipo_carro)
values
	(next value for carro_seq, '5542dsf', 'sds2454655', 'Hatch'),
	(next value for carro_seq, '4554666', '6546464646', 'Sedan')

/*
Tabela 3: Locacoes
- id_locacao
- data_locacao
- data_devolucao
- id_carro
- id_cliente
A tabela Locacoes possui 5 colunas.
A coluna id_locacao deve ser a chave primária da tabela.
Nenhuma das demais colunas devem aceitar valores nulos.
As colunas id_carro e id_cliente são chaves estrangeiras que permitirão a relação da tabela
Locacoes com as tabelas Carro e Cliente.
*/
create table Locacoes(
	id_locacao int,
	data_locacao date,
	data_devolucao date,
	id_carro int not null,
	id_cliente int not null,
	constraint id_locacao_pk primary key(id_locacao),
	constraint id_carro_fk foreign key(id_carro) references Carro(id_carro),
	constraint id_cliente_fk foreign key(id_cliente) references Cliente(id_cliente)
)

insert into Locacoes(id_locacao, data_locacao, data_devolucao, id_carro, id_cliente)
values
	(next value for locacoes_seq, '26/05/2023', '27/05/2023', 1, 1),
	(next value for locacoes_seq, '28/05/2023', '29/05/2023', 2, 2)

select * from Locacoes

/*
3. Exclua as sequences criadas.*/

drop sequence locacoes_seq
drop sequence carro_seq
drop sequence cliente_seq