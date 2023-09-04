program d;
const
	dimF = 4;
type
	indice = 1..4;
	indice2 = -1..4;
	vector = array [indice] of integer;


procedure CargarVector (var v: vector; var dimL: indice2);
var
	num: integer;
begin
	dimL:= 0;
	writeln ('Ingrese un valor'); readln (num);
	while (dimL < dimF) and (num <> 0) do begin
		dimL:= dimL + 1;
		v[dimL]:= num;
		writeln ('Ingrese un valor'); readln (num);
	end;
end;

procedure BusquedaDicotomica(v: vector; ini, fin: indice2; dato: integer; var pos: indice2); //chat gpt xd
var
  medio: indice;
begin
  pos := -1;  // Inicializamos pos a -1 (no encontrado) por defecto

  while (ini <= fin) and (pos = -1) do
  begin
    medio := (ini + fin) div 2;  // Calcular el punto medio

    if v[medio] = dato then
      pos := medio  // Encontramos el dato, actualizamos pos
    else if v[medio] < dato then
      ini := medio + 1  // El dato está en la mitad derecha
    else
      fin := medio - 1;  // El dato está en la mitad izquierda
  end;
end;

var
	v: vector;
	dimL, pos: indice2;
	dato: integer;
begin
	CargarVector (v, dimL);
	writeln ('Ingrese un valor para buscar en el vector'); readln (dato);
	busquedaDicotomica(v, 1, dimL, dato, pos);

	if pos <> -1 then
    writeln('El dato ', dato, ' se encuentra en la posicion ', pos)
   else
    writeln('El dato ', dato, ' no se encuentra en el vector.');
end.

