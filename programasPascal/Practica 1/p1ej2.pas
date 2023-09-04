program p1ej2;
const
	dimF= 300;
	fin= -1;
type
	rango= 1..dimF;
	rango2= 0..dimF;
	
	oficina = record
		cod: integer;
		dni: integer;
		valor: real;
	end;
	
	
	vectorOficinas= array [rango] of oficina;

//modulos

procedure Leer (var o: oficina);
begin
	randomize; //randomizo todo fue
	writeln ('ingrese codigo'); readln (o.cod);
	if (o.cod <> -1) then begin
		o.dni:= random (4939);
		o.valor:= random (2400);
	end;
end;

procedure CargarVector (var v: vectorOficinas; var dL: rango2);
var
	o:oficina;
begin
	Leer (o);
	dL:= 0;
	while (o.cod <> fin) and dl < df do begin
		dL:= Dl + 1;
		v[dL]:= o;
		Leer(o);
	end;
end;

procedure Insercion (var v: vectorOficinas; dL: rango2);
var 
	i,j: rango2; 
	actual: oficina;
begin
	for i:= 2 to dL do begin
		actual:= v[i];
		j:= i-1;
		while (j > 0) and (v[j].cod > actual.cod) do begin
			v[j+1]:= v[j];
			j:= j-1;
		end;
		v[j+1]:= actual;
	end;
end;

procedure Seleccion (var v: vectorOficinas; dL: rango2);
var
	i,j,pos: rango2;
	item: oficina;
begin
	for i:= 1 to dL-1 do begin
		pos:= i;
		for j:= i+1 to dL do
			if v[j].cod < v[pos].cod then
				pos:= j;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item
	end;
end;

procedure Imprimir (v: vectorOficinas; dL: rango2);
var i: rango2;
begin
	for i:= 1 to dL do begin
		writeln ('Codigo: ', v[i].cod);
		writeln ('dni: ', v[i].dni);
		writeln ('valor: ', v[i].valor:0:1);
	end;
end;

var
	v: vectorOficinas;
	dimL: rango2;
begin
	cargarVector (v, dimL);
	Insercion (v, dimL);
	writeln (' ');
	Imprimir (v, dimL);
	Seleccion (v, dimL);
	writeln (' ');
	Imprimir (v, dimL);
end.
