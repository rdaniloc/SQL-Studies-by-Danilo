-- Functions

-- 1. O que � uma Function?

-- Uma function � um conjunto de comandos que executam a��es e retorna um valor escalar. As Functions ajudam a simplificar um c�digo. Por exemplo, se voc� tem um c�lculo complexo que aparece diversas vezes no seu c�digo, em vez de repetir v�rias vezes aquela s�rie de comandos, voc� pode simplesmente criar uma fun��o e reaproveita-la sempre que quiser.

-- O pr�prio SQL tem diversas fun��es prontas e at� agora, j� vimos v�rios exemplos de fun��es deste tipo, como fun��es de data, texto, e assim vai.

-- Podemos visualizar as fun��es do sistema na pasta Programa��o > Fun��es > Fun��es do Sistema


-- 2. Como criar e utilizar uma Function
-- Imagine que voc� queira fazer uma formata��o diferenciada na coluna data_de_nascimento, utilizando a gun��o DATENAME.

select * from dCliente

select
	nome_cliente,
	data_de_nascimento,
	dbo.fnDataCompleta(data_de_nascimento)
from
	dCliente

-- Criando uma fu���o para formata��o de data usando a DATENAME

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
					'(1� Sesmetre)'
				else
					'(2� Semestre)'
			end

end

-- 4. Criando fun��es complexas

-- Crie uma fun��o para retornar o primeiro nome de cada gerente

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