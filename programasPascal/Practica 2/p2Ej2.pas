program ej2p2;
type
	lista = ^nodo;
	nodo = record
		dato: integer;
		sig: lista;
	end;
	
procedure agregarAdelante (var pri: lista; c: integer);
var
	nue: lista;
begin
	new (nue);
	nue^.dato:= c;
	nue^.sig:= pri;
	pri:= nue;
end;	
	
procedure CargarLista (var L: lista);
var
	num: integer;
begin
	writeln ('Ingrese un numero '); readln (num);
	while num <> 0 do begin
		agregarAdelante(L, num);
		writeln ('Ingrese un numero '); readln (num);
	end;
end;
	
procedure ImprimirNum (num: integer);
begin
	if (num <> 0) then begin
		ImprimirNum (num DIV 10);
		writeln(num MOD 10);
	end;
end;

procedure ImprimirLista (L: lista);
begin
	while L <> nil do begin
		writeln ('num: ', L^.dato);
		ImprimirNum (L^.dato);
		L:= L^.sig;
	end;
end;


var

	L: lista;
begin
	L:= nil;
	cargarLista (L);
	ImprimirLista(L);
end.
