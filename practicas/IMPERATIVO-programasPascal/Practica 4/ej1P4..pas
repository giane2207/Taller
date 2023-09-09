program ej1p4;
const
	fin = -1;
type
	venta = record
		codVenta: integer;
		codProducto: integer;
		cant: integer;
		precio: real;
	end;
	
	producto = record
		cod: integer;
		cant: integer;
		montoTotal: real;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: producto;
		HI: arbol;
		HD: arbol;
	end;
	
//modulos

procedure LeerVenta (var v: venta);
begin
	writeln ('Ingrese codigo de venta (-1 para finalizar)'); readln (v.codVenta);
	if (v.codVenta <> fin) then begin
		writeln ('Ingrese codigo de producto '); readln (v.codProducto);
		v.cant:= random (50);
		v.precio:= random (1000);	
	end;
end;

procedure Actualizar (var a: arbol; v: venta);
begin
	a^.dato.cant:= a^.dato.cant + v.cant; 
	a^.dato.montoTotal:= a^.dato.montoTotal + (v.cant * v.precio);
end;

procedure Agregar (var a: arbol; v: venta);
begin
	if (a = nil) then begin // el primer producto con este codigo entonces creo un nuevo nodo
		new (a);
		a^.dato.cod:= v.codProducto;
		a^.dato.cant:= v.cant; // no se pisa porq despues si llega a haber otro se actualizara
		a^.dato.montoTotal:= v.cant * v.precio;
	end
	else if (v.codProducto = a^.dato.cod) then 
			Actualizar (a, v)
	else if (v.codProducto > a^.dato.cod) then 
			Agregar(a^.HD, v)
	else Agregar(a^.HI, v);
end;

//a
procedure CargarArbol (var a: arbol);
var
	v: venta;
begin
	LeerVenta (v);
	while (v.codVenta <> fin) do begin
		Agregar (a, v);
		LeerVenta (v);
	end;
end;

//b
procedure Imprimir (a : arbol);
begin
	if (a <> nil) then begin
		Imprimir (a^.HI);
		writeln ('');
		writeln ('Codigo de producto: ', a^.dato.cod);
		writeln ('cantidad de productos vendidos: ', a^.dato.cant);
		writeln ('Monto total: ', a^.dato.montoTotal:0:1);
		Imprimir (a^.HD);
		
	end;
end;

procedure MayorCant (a: arbol; var maxCant, maxCod: integer);
begin 
	if (a <> nil) then begin
		if (a^.dato.cant > maxCant) then begin
			maxCant:= a^.dato.cant;
			maxCod:= a^.dato.cod;
		end;
		MayorCant (a^.HI, maxCant, maxCod);
		MayorCant (a^.HD, maxCant, maxCod);
	end;
end;

procedure incisoD (a: arbol; var cant: integer ; valor: integer);
begin 
    if (a<> nil) then begin
        incisoD(a^.HI, cant, valor);
        if (a^.dato.cod < valor)then begin
			cant:= cant + 1;
		end;
        incisoD(a^.HD, cant, valor);
    end;
end;

function CantMenores (a: arbol; valor: integer): integer;
var
	cant: integer;
begin
	cant:= 0;
	incisoD(a,cant, valor);
	CantMenores:= cant;
end;

function BusquedaAcotada(a:arbol; inf, sup:integer): real;
begin
	if (a <> nil) then begin
		if (a^.dato.cod >= sup) then
			BusquedaAcotada:= BusquedaAcotada(a^.HI,inf,sup)
		else
			if (a^.dato.cod > inf) and (a^.dato.cod < sup) then 
				BusquedaAcotada:= a^.dato.montoTotal + BusquedaAcotada(a^.HI,inf,sup) + BusquedaAcotada(a^.HD,inf,sup)
			else if (a^.dato.cod <= inf) then
					BusquedaAcotada:= BusquedaAcotada(a^.HD, inf,sup);
	end
	else
		BusquedaAcotada:=0;
end;

function MontoTotal (a: arbol; num1, num2: integer): real;
begin
	if (num2 > num1) then 	
		MontoTotal:= MontoTotal(a, num1, num2)
	else MontoTotal:= MontoTotal(a, num2, num1)
end;

//pp
var
	a: arbol;
	maxCant, maxCod, valor, valor2: integer;
	
begin
	randomize;
	a:= nil;
	CargarArbol (a);
	if a <> nil then begin
		Imprimir (a);
		maxCant:= -1;
		MayorCant (a, maxCant, maxCod);
		writeln ('El codigo con mayor cantidad de unidades vendidas es: ', maxCod, ' con ', maxCant, ' unidades');
		writeln ('');
		writeln ('Ingrese codigo de producto para buscar menores a el '); readln (valor);
		writeln ('');
		writeln ('La cantidad de codigos menores a ', valor, ' son: ', CantMenores(a, valor));
		writeln ('');
		writeln ('Ingrese 2 valores de codigo de producto para retornar el monto total entre esos valores '); readln (valor);readln (valor2);
		writeln ('El monto total entre ', valor, ' y ', valor2, ' es: ', BusquedaAcotada(a, valor, valor2):0:1);
	end
	else writeln ('No se han ingresado datos :)');
end.
