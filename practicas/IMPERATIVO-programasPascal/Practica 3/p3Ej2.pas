program ej2;
const
	fin = 0;
type
	producto = record
		cod: integer;
		cant: integer;
	end;
	
	Rfecha = record
		dia: 1..31;
		mes: 1..12;
		anio: integer;
	end;
	
	venta = record
		cod: integer;
		fecha: Rfecha;
		cant: integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: venta;
		HI: arbol;
		HD: arbol;
	end;
	
	arbol2 = ^nodo2;
	nodo2 = record
		dato: producto;
		HI: arbol2;
		HD:arbol2;
	end;
	
//modulos

procedure LeerF (var f: Rfecha);
begin
	f.dia:= random(31)+1;
	f.mes:= random (12) +1;
	f.anio:= random (2000) + 50;
end;

procedure Leer (var v: venta);
begin
	randomize;
	writeln ('Ingrese un codigo (0 para finalizar)'); readln (v.cod);
	if (v.cod <> fin) then begin
		v.cant:= random (50);
		LeerF(v.fecha);
	end;
end;

procedure Agregar (var a: arbol; v: venta);
begin
	if (a = nil) then begin
		new(a);
		a^.dato:= v;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else
		if (v.cod >= a^.dato.cod) then 
			Agregar(a^.HD, v)
		else Agregar(a^.HI, v);
end;

procedure CargarArbol (var a: arbol);
var
	v: venta;
begin
	Leer(v);
	while (v.cod <> fin) do begin
		Agregar(a, v);
		Leer(v);
	end;
end;

procedure AgregarA2 (var a: arbol2; v: venta);
begin
	if (a = nil) then begin
		new (a);
		a^.dato.cod:= v.cod;
		a^.dato.cant:= v.cant;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else begin
		if (v.cod > a^.dato.cod) then 
			AgregarA2(a^.HD, v)
			
		else if (v.cod < a^.dato.cod) then 
			AgregarA2(a^.HI, v)
			
		else if (v.cod = a^.dato.cod)then
			a^.dato.cant:= a^.dato.cant + v.cant; // aumento la cantidad de productos q se vendieron
	end;
end;

procedure GenerarArbol2 (a: arbol; var a2: arbol2);
begin
	if (a <> nil )then begin
		GenerarArbol2(a^.HI, a2);
		AgregarA2(a2, a^.dato);
		GenerarArbol2(a^.HD, a2);
	end;
end;

procedure Buscar1(a: arbol; cod: integer; var cant: integer);
begin
	if (a <> nil) then begin
		if (a^.dato.cod = cod) then 
			cant:= cant + a^.dato.cant;
		Buscar1(a^.HI, cod, cant);
		Buscar1(a^.HD, cod, cant);
	end;		
end;

function Buscar2 (a: arbol2; cod: integer): integer;
begin
	if (a <> nil )then begin
		if (cod = a^.dato.cod) then 
			Buscar2:= a^.dato.cant
			
		else if (cod > a^.dato.cod) then 
			Buscar2:= Buscar2(a^.HD, cod)
			
		else Buscar2:= Buscar2(a^.HI, cod);
	end
	else Buscar2:= 0;
end;

//pp
var
	a: arbol;
	a2: arbol2;
	cod, cant: integer;
begin
	a:= nil;
	a2:= nil;
	cant:= 0;
	CargarArbol(a);
	GenerarArbol2(a, a2);
	if (a <> nil) then begin
		writeln ('Ingrese un codigo a buscar '); readln (cod);
		Buscar1 (a, cod, cant);
		writeln ('La cantidad de productos vendido con ese codigo es: ', cant);
		cant:= Buscar2(a2, cod);
		writeln ('La cantidad de productos vendido con ese codigo es(arbol 2): ', cant);
	end
	else writeln ('No se han ingresado datos');
end.
		
