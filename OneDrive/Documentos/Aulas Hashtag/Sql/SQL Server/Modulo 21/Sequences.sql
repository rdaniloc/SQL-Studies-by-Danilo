-- V. SEQUENCES

/* O que �?
Uma sequ�ncia (Sequence) � um objeto que utilizamos para cria��o de n�meros sequ�nciais autom�ticos.
S�o usados especialmente para gerar velores sequenciais �nicos para as chaves prim�rias das tabelas.

Dessa forma, n�o precisamos ficar preenchendo a sequ�ncia de ids manualmente (como fizemos at� ent�o),
podemos gerar automaticamente por meio de uma sequence.

Sintaxe:

Create Sequence nome_sequencia
as tipo
start with n
increment by n
maxvalue n | no maxvalue
minvalue n | no minvalue
cycle | no cycle;  -- quando atinge o valor m�ximo, pode ou n�o voltar do come�o
*/

-- Crie uma sequ�ncia para o id_cliente

create sequence clientes_seq
as int
start with 1
increment by 1
no maxvalue
no cycle

-- Pr�ximo valor da sequ�ncia

select next value for clientes_seq


-- Excluir uma sequence
drop sequence clientes_seq


-- Crie uma sequ�ncia para o id_projeto

create sequence projetos_seq
as int
start with 1
increment by 1
no maxvalue
no cycle

create table dProjeto(
	id_projeto int,
	nome_projeto varchar(100) not null,
	constraint dareas_id_area_pk primary key (id_projeto)
)

insert into dProjeto(id_projeto, nome_projeto) values
	(next value FOR projetos_seq, 'Planejamento Estrat�gico'),
	(next value FOR projetos_seq, 'Desenvolvimento de App'),
	(next value FOR projetos_seq, 'Plano de Neg�cios'),
	(next value FOR projetos_seq, 'Visualiza��o 3D')


select * from dProjeto
