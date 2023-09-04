program a;
const
	dimF = 4;
type
	vector = array [1..20] of integer;
	
//modulos

procedure CargarVector (var v: vector; var dimL: integer);
var 
	num: integer;
begin
	randomize;
	writeln ('Ingrese un valor'); readln (num);
	dimL:= dimL + 1;
	v[dimL]:= num;
	if (dimL < dimF) then CargarVector(v, dimL);
end;

procedure ImprimirVector (v: vector; dimL: integer);
var i: integer;
begin
	for i:= 1 to dimL do 
		writeln ('num:posicion: ', i , ' ',v[i]);
end;

procedure Maximo (v: vector; dimL: integer; var max: integer);
begin
	if (dimL <> 0) then begin
		if (v[dimL] > max )then 
			max:= v[dimL];
		Maximo(v, dimL - 1, max);
	end;
end;


procedure SumaElementos (v: vector; dimL: integer; var suma: integer);
begin
	if (dimL <> 0 ) then begin
		suma:= suma + v[dimL];
		sumaElementos (v, dimL - 1, suma);
	end;
end;


//pp
var
	dimL, max, suma: integer;
	v: vector;

begin
	dimL:= 0;
	CargarVector(v, dimL);
	ImprimirVector (v, dimL);
	max:= -1;
	Maximo (v, dimL, max);
	writeln ('El maximo es: ', max);
	suma:= 0;
	SumaElementos(v, dimL, suma);
	writeln ('la suma de elementos es: ', suma);
end.
