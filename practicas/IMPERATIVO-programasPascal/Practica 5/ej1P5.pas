program ej1P5;
const
	fin = -1;
	dimF = 300;
type
	rangoOficinas = 1..dimF;
	rango = 0..dimF;
	
	oficina = record
		cod: integer;
		dni: integer;
		valor: real;
	end;
	
	vector = array [rangoOficinas] of oficina;
	
//modulos

procedure Leer (var o: oficina);
begin
	writeln ('Ingrese un codigo de oficina (-1 para finalizar)'); readln (o.cod);
	if (o.cod <> fin) then begin
		o.dni:= random (2300);
		o.valor:= random (10000);
	end;
end;

//a
procedure CargarVector (var v: vector; var dimL: rango);
var
	o: oficina;
begin
	dimL:= 0;
	Leer (o);
	while (o.cod <> fin) and (dimL < dimF) do begin
		dimL:= dimL + 1;
		v[dimL]:= O;
		Leer (o);
	end;
end;

//b
procedure Ordenar (var v: vector; dimL: rango);
var 
	i, j, pos: rangoOficinas; 
	item: oficina;
begin
	if dimL >= 1 then begin //me aseguro que el vector tenga algun dato porq sino se rompe todo
		for i:= 1 to dimL - 1 do begin
			pos:= 1;
			for j:= i + 1 to dimL do 
				if ( v[j].cod < v[pos].cod ) then
					pos:= j;
			item:= v[pos];
			v[pos]:= v[i];
			v[i]:= item;
		end;
	end;
end;

function Dicotomica (v: vector; dimL: rango; cod: integer): rango;
var
	pri, ult, medio, pos: rango;
begin
	pos:= 0;
	pri:= 1; ult:= dimL;  medio:= (pri + ult) DIV 2;
	while (pri <= ult) and (cod <> v[medio].cod) do begin
		if (cod < v[medio].cod) then 
			ult:= medio -1
		else 
			pri:= medio + 1;
		medio:= (pri + ult) DIV 2;
	end;
	if (pri <= ult) and (cod = v[medio].cod) then
		pos:= medio;
	Dicotomica:= pos;
end;

function MontoTotal (v: vector; dimL: rango): real;
begin
	if (dimL <> 0) then 
		MontoTotal:= v[dimL].valor + MontoTotal(v, dimL - 1)
	else MontoTotal:= 0;
end;





//pp
var
	v: vector;
	dimL, pos: rango;
	cod: integer;
begin
	randomize;
	CargarVector(v, dimL);
	Ordenar (v, dimL);
	if (dimL > 0) then begin
		writeln ('Ingrese un codigo de oficina para buscarlo '); readln (cod);
		pos:= Dicotomica(v, dimL, cod);
		if (pos <> 0) then 
			writeln ('El dni del propietario de la oficina es: ', v[pos].dni)
		else writeln ('No se encontro la oficina');
		writeln ('El monto total de las expensas es: ', MontoTotal(v, dimL):0:1);
	end
	else writeln ('No se ingresaron datos');
end.





