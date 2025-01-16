-- Loop
-- Crie um contador de 1 a 10 usando a função While

declare @varContador int
set @varContador = 1

while @varContador <= 10
begin
	print 'O valor do contador é ' + convert(varchar, @varContador)
	set @varContador = @varContador + 1
end

-- while break
go
declare @varContador int
set @varContador = 1

while @varContador <= 100
begin
	if @varContador = 15
		break
		print 'O valor do contador é ' + convert(varchar, @varContador)
		set @varContador += 1
end
go
-- loop while: CONTINUE
-- Faça um contador de 1 a 10. Obs: Os números 3 e 6 não podem ser printados na tela

declare @varContador int
set @varContador = 0

while @varContador < 10
begin
	set @varContador += 1
	if @varContador = 3 or @varContador = 6
		continue
	print 'O valor do contador é ' + convert(varchar, @varContador)	
end