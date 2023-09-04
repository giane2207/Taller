program DecimalABinario;

// Módulo recursivo para convertir un número decimal a binario
procedure DecimalABinario(decimal: integer);
begin
	if decimal < 2 then
    write(decimal)
  else
  begin
    DecimalABinario(decimal div 2);
    write(decimal mod 2);
  end;
end;

var
  numeroDecimal: integer;
begin
	repeat
		write('Ingrese un número decimal (0 para salir): ');
		readln(numeroDecimal);
		write('El equivalente en binario es: ');
		
		DecimalABinario(numeroDecimal);
		writeln ('');
	until numeroDecimal = 0
end.
