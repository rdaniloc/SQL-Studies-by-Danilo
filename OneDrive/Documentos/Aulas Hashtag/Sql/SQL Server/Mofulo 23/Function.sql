-- Functions

-- 1. O que é uma Function?

-- Uma function é um conjunto de comandos que executam ações e retorna um valor escalar. As Functions ajudam a simplificar um código. Por exemplo, se você tem um cálculo complexo que aparece diversas vezes no seu código, em vez de repetir várias vezes aquela série de comandos, você pode simplesmente criar uma função e reaproveita-la sempre que quiser.

-- O próprio SQL tem diversas funções prontas e até agora, já vimos vários exemplos de funções deste tipo, como funções de data, texto, e assim vai.

-- Podemos visualizar as funções do sistema na pasta Programação > Funções > Funções do Sistema


-- 2. Como criar e utilizar uma Function
-- Imagine que você queira fazer uma formatação diferenciada na coluna data_de_nascimento, utilizando a gunção DATENAME.

select * from dCliente

select
	nome_cliente,
	data_de_nascimento,
	dbo.fnDataCompleta(data_de_nascimento)
from
	dCliente

-- Criando uma fuñção para formatação de data usando a DATENAME

drop function fnDataCompleta

create or alter function fnDataCompleta(@data as date)
returns VARCHAR(MAX)
as
begin

	return 	DATENAME(DW, @data) + ', ' +
			DATENAME(D, @data) + ' de ' +
			DATENAME(M, @data) + ' de ' +
			DATENAME(Y, @data) + ' - ' +
			case
				when month(@data) <= 6 then
					'(1º Sesmetre)'
				else
					'(2º Semestre)'
			end

end

-- 4. Criando funções complexas

-- Crie uma função para retornar o primeiro nome de cada gerente

select * from dGerente

insert into dGerente(nome_gerente, data_contratacao, salario) values
	('Joao', '10/01/2019', 3100)

select
	nome_gerente,
	dbo.fnPrinemeiroNome(nome_gerente) as primeiro_nome
from dGerente


create or alter function fnPrinemeiroNome(@nomeCompleto as varchar(max))
returns varchar(max)
as
begin
	Declare @posicaoEspaco as int
	declare @resposta as varchar(max)

	set @posicaoEspaco = CHARINDEX(' ', @nomeCompleto)

	if @posicaoEspaco = 0
		set @resposta = @nomeCompleto
	else
		set @resposta = LEFT(@nomeCompleto, CHARINDEX(' ', @nomeCompleto) - 1)
	return @resposta
end