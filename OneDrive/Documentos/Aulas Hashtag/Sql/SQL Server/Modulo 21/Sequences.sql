-- V. SEQUENCES

/* O que é?
Uma sequência (Sequence) é um objeto que utilizamos para criação de números sequênciais automáticos.
São usados especialmente para gerar velores sequenciais únicos para as chaves primárias das tabelas.

Dessa forma, não precisamos ficar preenchendo a sequência de ids manualmente (como fizemos até então),
podemos gerar automaticamente por meio de uma sequence.

Sintaxe:

Create Sequence nome_sequencia
as tipo
start with n
increment by n
maxvalue n | no maxvalue
minvalue n | no minvalue
cycle | no cycle;  -- quando atinge o valor máximo, pode ou não voltar do começo
*/

-- Crie uma sequência para o id_cliente

create sequence clientes_seq
as int
start with 1
increment by 1
no maxvalue
no cycle

-- Próximo valor da sequência

select next value for clientes_seq


-- Excluir uma sequence
drop sequence clientes_seq


-- Crie uma sequência para o id_projeto

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
	(next value FOR projetos_seq, 'Planejamento Estratégico'),
	(next value FOR projetos_seq, 'Desenvolvimento de App'),
	(next value FOR projetos_seq, 'Plano de Negócios'),
	(next value FOR projetos_seq, 'Visualização 3D')


select * from dProjeto
