program e3p2;
const
	base = 0;
type
	lista = ^nodo;
	nodo = record
		dato: integer;
		sig: lista;
	end;
	
//modulos
procedure agregarAdelante (var pri: lista; c: integer);
var
	nue: lista;
begin
	new (nue);
	nue^.dato:= c;
	nue^.sig:= pri;
	pri:= nue;
end;	

procedure GenerarLista (var L: lista);
var
	num: integer;
begin
	randomize;
	writeln ('Ingrese un valor'); readln (num);
	if (num <> base) then begin
		agregarAdelante(L, num);
		GenerarLista(L^.sig);
	end;
end;


procedure Minimo (L: lista; var min : integer);
begin
	if L <> nil then begin
		if(L^.dato < min) then
			min:=  L^.dato;
		Minimo(L^.sig, min);
	end;
end;

procedure Maximo (L: lista; var max: integer);
begin
	if L <> nil then begin
		if(L^.dato > max) then
			max:=  L^.dato;
		Maximo(L^.sig, max);
	end;
end;

function Encontre (L: lista; valor: integer): boolean;
begin
	if (L <> nil) then begin
		if (L^.dato = valor) then
			Encontre:= true
		else
			Encontre := Encontre(L^.sig, valor);
	end
	else  
		Encontre:= false;
end;

procedure ImprimirLista (L: lista);
begin
	while L <> nil do begin
		writeln ('num: ', L^.dato);
		L:= L^.sig;
	end;
end;



var
	L:lista;
	valor, min, max: integer;
begin
	L:= nil;
	GenerarLista(L);
	ImprimirLista(L);
	min:= 9999;
	max:= -1;
	Minimo(L, min);
	writeln ('El valor minimo de la lista es: ', min);
	Maximo(L, max);
	writeln ('El valor maximo de la lista es: ', max);
	writeln ('Ingrese un valor a buscar en la lista'); readln (valor);
	if (Encontre(L, valor)) then 
		writeln ('Se ha encontrado el valor en la lista')
	else
		writeln ('No se ha encontrado el valor en la lista');
end.
