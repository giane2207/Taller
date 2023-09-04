program p2e1;

type
	vector = array [1..10] of char;
	lista= ^nodo;
	nodo = record
		dato: char;
		sig: lista;
	end;

//a y d
procedure LeerSecuencia (var v: vector; var dl: integer);
var
	c: char;
begin
	writeln ('ingrese un caracter') ;readln (c);
	if (c <> '.') then begin
		dl:= dl + 1;
		v[dl]:= c;
		LeerSecuencia(v, dl);
	end;
end;	

//b
procedure Imprimir (v: vector; dimL: integer);
var i: integer;
begin
	for i:= 1 to dimL do 
		writeln ('en la posicion ',i, ' esta el caracter:', v[i]);
end;

//c
procedure ImprimirRecursivo (v: vector; dimL: integer);
begin
	if (dimL > 0) then begin
		ImprimirRecursivo (v, dimL-1);
		writeln ('en la posicion ',dimL, ' esta el caracter:', v[dimL]);
	end;
end;

procedure agregarAdelante (var pri: lista; c: char);
var
	nue: lista;
begin
	new (nue);
	nue^.dato:= c;
	nue^.sig:= pri;
	pri:= nue;
end;

//e
procedure CargarLista (var L: lista);
var c: char;
begin
	writeln ('ingrese un caracter p/ lista') ;readln (c);
	if (c <> '.') then begin
		agregarAdelante (L, c);
		CargarLista (L^.sig);
	end;
end;

//f
procedure ImprimirListaMismoOrden(L: lista);
begin
	if L <> nil then begin
		writeln ('El caracter de la lista es: ', L^.dato);
		ImprimirListaMismoOrden(L^.sig)
	end;
end;

procedure ImprimirListaInverso(L: lista);
begin
	if L <> nil then begin
		ImprimirListaInverso(L^.sig);
		writeln ('El caracter de la lista es: ', L^.dato);
	end;
end;

var
	v: vector;
	dl: integer;
	L: lista;
begin
	{dl:= 0;
	LeerSecuencia (v, dL);
	writeln ('la cantidad de caracteres que se leyeron fueron: ', dL);
	Imprimir (v, dL);
	writeln ('');
	ImprimirRecursivo (v, dL);}
	
	L:= nil;
	CargarLista (L);
	ImprimirListaMismoOrden (L);
	writeln ('');
	ImprimirListaInverso (L);
	
	
end.
