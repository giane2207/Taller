program ej4p1;
const
	dimF = 8;
	dimF2 = 30;
	fin = 0;
	rubro = 3;
type
	rango1 = 1..dimF;
	rango2 = 1..dimF2;
	rango3 = 0..dimF2;
	
	producto = record
		cod: string; // por probar
		rubro: rango1;
		precio: real;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: producto;
		sig: lista;
	end;
	
	vectorP = array [rango1] of lista;
		
	vector2= array [rango2] of producto;
	
procedure LeerProducto (var p: producto);
begin
	randomize;
	writeln ('ingrese precio del producto'); readln (p.precio);
	if p.precio <> fin then begin
		writeln ('ingrese codigo del producto'); readln (p.cod);
		writeln ('ingrese rubro del producto'); readln (p.rubro);
	//	p.rubro:= random (8) + 1;
		
	end;
end;

procedure InsertarOrdenado (var pri: lista; p: producto);
var
	nue, act, ant: lista;
begin
	new (nue);
	nue^.dato:= p;
	nue^.sig:= nil;
	if (pri = nil) then pri:= nue
	else begin
		act:= pri;
		while (act <> nil) and (act^.dato.cod < nue^.dato.cod) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if act = pri then begin
			nue^.sig:= pri;
			pri:= nue;
		end
		else begin
			ant^.sig:= nue;
			nue^.sig:= act;
		end;
	end;
end;

procedure CargarVector (var v: vectorP);
var
	p: producto;
begin
	LeerProducto(p);
	while p.precio <> fin do begin
		InsertarOrdenado(v[p.rubro], p);
		LeerProducto(p);
	end;
end;

procedure imprimirListas (L: lista);
begin
	if (L = nil) then writeln ('no hay productos de este rubro');
	while (L <> nil ) do begin
		writeln ('codigo: ', L^.dato.cod);
		L:= L^.sig;
	end;
end;

procedure imprimirxRubro (v: vectorP);
var
	i: rango1;
begin
	for i:= 1 to dimF do begin
		writeln ('productos del rubro: ', i, ':');
		imprimirListas (v[i]);
	end;
end;

procedure GenerarVector (var v2: vector2; var dL: rango3 ; v: vectorP);
var
	L: lista;
begin
	L:= v[rubro];
	dL:= 0;
	while (L <> nil) and (dl < dimF2) do begin
		dL:= dL + 1;
		v2[dl]:= L^.dato;
		L:= L^.sig;
	end;
end;

function Promedio (suma: real; cant: rango3): real;
begin
	Promedio:= suma/cant;
end;

procedure ImprimirPrecios (v: vector2; dl: rango3; var p: real);
var
	i: rango2;
	sumaPrecios: real;
begin
	sumaPrecios:= 0;
	for i:= 1 to dL do begin
		writeln ('el precio del producto: ', v[i].cod, ' es de $', v[i].precio:0:1);
		sumaPrecios:= sumaPrecios + v[i].precio;
	end;
	if dl <> 0  then
		p:=Promedio (sumaPrecios,dL);
end;


procedure Ordenar (var v: vector2; dimL: rango3);
var
	i,j,pos: rango2;
	item: producto;
begin
	for i:= 1 to dimL-1 do begin
		pos:= i;
		for j:= i+1 to dimL do
			if v[j].precio < v[pos].precio then
				pos:= j;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item
	end;
end;
procedure ImprimirVector (v: vector2; dl: rango3);
var i: rango2;
begin
	for i:= 1 to dl do begin
		writeln ('vector 2:');
		writeln ('codigo pro:', v[i].cod);
		writeln ('precio prod:', v[i].precio:0:1);
		writeln ('rubro deberia ser 3', v[i].rubro);
	end;
end;

var
	v: vectorP;
	v2: vector2;
	dl:rango3;
	p: real;
begin
	CargarVector(v);
	ImprimirxRubro (v);
	GenerarVector (v2, dl, v);
	Ordenar (v2, dl);
	writeln (' ');
	ImprimirVector (v2, dl);
	writeln ('');
	ImprimirPrecios (v2, dl, p); //q haga aca directo el promedio asi no recorre todo de nuevo
	writeln ('');
	writeln ('el promedio es: ', p:0:1);
	//este programa de mierda no anda cuando no ingreso nada en el rubro 3 q paja chau
end.

