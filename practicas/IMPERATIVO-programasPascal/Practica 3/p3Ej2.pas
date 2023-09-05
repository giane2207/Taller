program ej2;
const
	fin = 0;
type
	InfoV = record
		cod: integer;
		cant: integer;
	end;
	
	Rfecha = record
		dia: 1.31;
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
	
	arbol1 = ^nodo1;
	nodo1 = record
		dato: InfoV;
		HI: arbol1;
		HD:arbol1;
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
		Agregar(a);
		Leer(v);
	end;
end;

//pp
var
	a: arbol;

begin
	a:= nil;
	CargarArbol(a);

end.
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
