program ej1p1;
const
	dimF= 50;
type
	rangoDia= 0..31;
	rangoCod= 1..15;
	rangoUnidades= 1..99;
	rangoVentas = 1..dimF;
	rango= 0..dimF;
	
	venta = record
		dia: rangoDia;
		cod: rangoCod;
		cant: rangoUnidades;
	end;
	
	vector = array [rangoVentas] of venta;
	
	lista = ^nodo;
	nodo = record
		dato: venta;
		sig: lista;
	end;

//modulos
procedure LeerVenta (var ve: venta);
begin 
	randomize;
	writeln ('Ingrese dia de venta'); readln(ve.dia);
	if (ve.dia <> 0) then begin
		writeln ('Ingrese cantidad'); readln(ve.cant);
		ve.cod:= random(15)+1;
	end;
end;

//inciso A
procedure CargarVector (var v: vector; var dimL: rango);
var
	ve: venta;
begin
	dimL:= 0;
	LeerVenta(ve);
	while (ve.dia <> 0) and (dimL < dimF) do begin
		dimL:= dimL + 1;
		v[dimL]:= ve;
		LeerVenta(ve);
	end;
end;

//inciso B
procedure ImprimirVector (v: vector; dimL: rango);
var i: integer;
begin
	for i:= 1 to dimL do begin
		writeln ('Dia de venta: ', v[i].dia);
		writeln ('codigo de venta: ', v[i].cod);
		writeln ('cantidad: ', v[i].cant);
	end;
end;

//inciso C
Procedure Ordenar (var v: vector; dimLog: rango);
var 
	i, j, pos: rango; 
	item : venta;	
begin
 for i:=1 to dimLog-1 do begin {busca el mínimo y guarda en pos la posición}
          pos := i;
          for j := i+1 to dimLog do
             if v[j].cod < v[pos].cod then pos:=j;

         {intercambia v[i] y v[p]}
         item := v[ pos ];   
         v[ pos ] := v[ i ];   
         v[ i ] := item;
      end;
end;

procedure Eliminar (); //iniciso e: no pude :(
begin
end;

procedure AgregarAdelante (var L: lista; v: venta);
var
	nue: lista;
begin
	new (nue);
	nue^.dato:= v;
	nue^.sig:= L;
	L:= nue;
end;

function EsPar (num: rangoCod): boolean;
begin
	EsPar:= num MOD 2 = 0;
end;

//inciso G
procedure GenerarLista (var L: lista; dl: rango; vec: vector);
var
	i: rangoVentas;
begin
	for i:= 1 to dl do begin
		if (EsPar(vec[i].cod)) then 
			AgregarAdelante(L, vec[i]);
	end;			
end;

//inciso H
procedure ImprimirLista (L: lista);
begin
	while L <> nil do begin
		writeln ('El producto con codigo par: ', L^.dato.cod, ' se vendio un total de: ', L^.dato.cant, ' veces');
		L:= L^.sig;
	end;
end;

var
	v: vector; dimL: rango;
	L: lista;
begin 
	CargarVector(v,dimL); //a
	ImprimirVector (v, dimL); //b
	Ordenar (v,dimL);//c
	ImprimirVector (v,dimL); //d
	L:= nil;
	GenerarLista(L, dimL, v);//G
	ImprimirLista(L); //h
end.
