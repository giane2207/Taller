program parcialito;
const
	fin = 0;
	mes = 07;
	anio = 2022;
type
	compra = record
		cod: integer;
		dia: 1..31;
		cant: integer;
		monto: real;
	end; 
	
	compra2 = record
		dia: 1..31;
		cant: integer;
		monto: real;
	end;
	
	listaCompras = ^nodo;
	nodo = record
		dato: compra2;
		sig:listaCompras;
	end;
	
	infoCompra = record
		cod: integer;
		lista: listaCompras;
	end;
	
	arbol = ^nodo2;
	nodo2 = record
		dato: infoCompra;
		HI: arbol;
		HD: arbol;
	end;
	
//modulos
procedure Leer (var c: compra);
begin
	writeln ('Ingrese cantidad de productos (0 para finalizar)'); readln (c.cant);
	if (c.cant <> fin) then begin
		c.dia:= random (31)+1;
		c.cod:= random (5);
		//writeln ('Ingrese codigo'); readln (c.cod);
	//	writeln ('Ingrese monto'); readln (c.monto);
		c.monto:= random (3000);
	end;
end;

procedure AgregarAdelante(var pri: listaCompras; c: compra);
var
	nue: listaCompras;
begin
	new(nue);
	nue^.dato.dia:= c.dia;
	nue^.dato.cant:=c.cant;
	nue^.dato.monto:=c.monto;
	nue^.sig:= pri;
	pri:= nue;	
end;

procedure Agregar (var a: arbol; c: compra);
begin
	if (a = nil) then begin
		new (a);
		a^.dato.cod:= c.cod;
		a^.dato.lista:= nil;
		AgregarAdelante (a^.dato.lista, c);
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else if (c.cod = a^.dato.cod) then 
		AgregarAdelante (a^.dato.lista, c)
	else if (c.cod > a^.dato.cod) then
		Agregar(a^.HD, c)
	else Agregar (a^.HI, c);
end;

procedure CargarArbol (var a: arbol);
var
	c: compra;
begin
	Leer (c);
	while (c.cant <> fin) do begin
		Agregar (a, c);
		Leer(c);
	end;
end;


function BuscarNodo (a: arbol; cod: integer): arbol;
begin
	if (a = nil) then BuscarNodo:= nil
	else if (cod = a^.dato.cod) then
		BuscarNodo:= a
	else if (cod > a^.dato.cod) then
		BuscarNodo:= BuscarNodo (a^.HD, cod)
	else BuscarNodo:= BuscarNodo (a^.HI, cod);
end;

procedure BuscarCodigo (var L: listaCompras; a: arbol; cod: integer);
var
	n: arbol;
begin
	n:= BuscarNodo (a, cod);
	if (n <> nil) then
		L:= n^.dato.lista
	else L:= nil;
end;

procedure Max (L: listaCompras; var maxCant: integer; var Monto: real);
begin
	if (L <> nil) then begin
		if (L^.dato.cant > maxCant) then begin
			maxCant:= L^.dato.cant;
			Monto:= L^.dato.monto; 
		end;
		Max (L^.sig, maxCant, Monto);
	end;
end;

function MaximoMonto (L: listaCompras): real;
var
	maxCant: integer;
	maxMonto: real;
begin
	maxCant:= -1;
	Max (L, maxCant, maxMonto);
	MaximoMonto:= maxMonto;
end;

//pp
var
	L: listaCompras; 
	cod: integer;
	a: arbol;
begin
	randomize;
	a:= nil;
	CargarArbol(a);
	if (a = nil) then writeln ('No se han ingresado datos')
	else begin
		writeln ('Ingrese un codigo de cliente para buscar sus compras '); readln (cod);
		BuscarCodigo(L, a, cod);
		if (L = nil) then writeln('No hay compras con ese codigo de cliente')
		else writeln('El monto de la compra con mayor cantidad de productos del codigo de cliente ingresado es: ', MaximoMonto(L):0:1);
	end;
end.
	 
	
	
	
	
	
	
	
	
	
	
	
	
	
