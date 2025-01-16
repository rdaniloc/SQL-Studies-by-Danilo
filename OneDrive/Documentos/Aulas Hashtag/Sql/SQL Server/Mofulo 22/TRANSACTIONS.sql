-- Transactions

-- 1. O que é um transaction?
-- Uma transaction é uma ação realizada dentro do banco de dados. Essa ação pode ser uma atualização, inserção ou exclusão de dados do banco. Precisamos de transações quando estamos alterando o banco de dados de alguma forma, seja inserindo, atualizando ou excluindo dados.

-- Normalmente, não temos muit "controle" sobre transações, a menos que a gente explicite no nosso códio que queremos fazer isso. Assim, a ideia de uma transação é agrupar um conjunto de instruções a serem executadas no banco de dados, e ter a flexibilidade de:

-- a. Se algo der errado, desfazer aquela transação
-- b. Se tudo der certo, salvar aquela transação

-- O que podemos fazer com uma transaction?

-- BEGIN TRANSACTION			: iniciá-la
-- ROLLBACK TRANSACTION			: desfazê-la
-- COMMIT:						: salvá-la


select *
into cliente_aux
from dCliente

-- 1. Adicionamos novas linhas (registros) na tebela
insert into cliente_aux(Cliente, Genero, Data_de_Nascimento, CPF)
values
	('Danilo Caiena', 'M', '25/03/1998', '526.588.802-00')

-- 2. Atualizamos linhas (registros) da tabela
UPDATE cliente_aux
	set Cliente = LOWER(Cliente)

-- 3. Excluimos linhas (registros) da tabela
DELETE FROM dCliente
	where id_Cliente = 1
	
-- Quando executamos as ações acima, não temos controle sobre defazê-las ou salvá-las no banco, por exemplo. Mas, quando usamos transações, conseguimos controlar melhor essas ações por meio de commits e rollbacks,


-- COMMIT: Comando TCL para efetivar uma transação no banco
-- ROLLBACK: Comando TCL para desfazer uma transação no banco


-- Iniciando uma com transação com COMMIT:

SELECT * FROM cliente_aux

begin transaction
insert INto cliente_aux(Cliente, Genero, Data_de_Nascimento, CPF)
values
	('Maria Julia', 'F', '30/04/1995', '565.466.547-00')


rollback transaction

begin transaction
UPDATE cliente_aux
set CPF = '999.999.999-99'
WHERE id_Cliente = 1


commit transaction

-- Nomeando uma transação

Begin transaction T1
insert into cliente_aux(Cliente, Genero, Data_de_Nascimento, CPF) values
	('Danilo Caiena', 'M', '10/01/2022', '526.588.802-00')

-- Comitando uma transação
COMMIT TRANSACTION T1

-- 5. Commit e Rolback condicionais

-- Você deve inserir a cliente Ruth Campos no banco de dados. Se esse nonme já existir, desfaça a transação. Se não existir, salve a transação.

select * from cliente_aux

Declare @contador int

begin transaction T2
insert into cliente_aux(Cliente, Genero, Data_de_Nascimento, CPF) values
	('Ruth Campos', 'F', '23/03/1992', '526.588.802-00')

select @contador = COUNT(*) from cliente_aux where Cliente = 'Ruth Campos'

if @contador = 1
	Begin
		Commit transaction T2
		print 'Ruth Campos cadastrada com sucesso'
	end
else
	begin
		rollback transaction T2
		print 'Ruth Campos já foi cadastrada na tabela. Insert abortado.'
	end

-- 6. Tratamento de erros em transações.

Begin try
	Begin transaction T3

		UPDATE cliente_aux
		set Data_de_Nascimento = '15 de março de 1992'
		where id_Cliente = 4

	commit transaction T3
End try
Begin catch

	rollback transaction T3
	print 'Data cadastrada inválida'

End catch


-- 7. Transações aninhadas (Rollback e Commit)

Begin transaction T1

	Print @@Trancount

	Begin transaction T2

		Print @@trancount

	commit transaction T2

	print @@trancount

commit transaction T1

print @@trancount

rollback