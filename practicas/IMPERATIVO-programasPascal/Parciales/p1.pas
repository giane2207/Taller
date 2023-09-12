program parcialitoviejo;
const 
	fin= 0;
	solista = 1;
type
	cadena20 = string [20]; 
	cadena30 = string [30];
	
	banda = record 
		nombre: cadena30;
		estilo: cadena20;
		cant: integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: banda;
		HI: arbol;
		HD: arbol;
	end;
	
	Rsolista = record 
		nombre: cadena30;
		estilo: cadena20;
	end;
	
	listaSolistas = ^nodo2;
	nodo2 = record
		dato: Rsolista;
		sig: listaSolistas;
	end;
	

//modulos

procedure Leer (var b: banda);
begin
	//b.cant:=  random (5);
	writeln ('Ingrese cant de la bandita (0 para finalizar)'); readln (b.cant);
	if (b.cant <> fin) then begin
		writeln ('Ingrese nombre de la bandita'); readln (b.nombre);
		writeln ('Ingrese su estilo'); readln (b.estilo);
	end;
end;

procedure AgregarAlArbol (var a: arbol; b: banda);
begin
	if (a = nil) then begin
		new (a);
		a^.dato:= b;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else if (b.cant >= a^.dato.cant) then 
		AgregarAlArbol (a^.HD, b)
		
	else if (b.cant < a^.dato.cant) then
		AgregarAlArbol (a^.HI, b);
end;

procedure CargarArbol (var a:arbol);
var
	b: banda;
begin
	Leer (b);
	while (b.cant <>  fin) do begin
		AgregarAlArbol(a, b);
		Leer(b);
	end;
end;

procedure InsertarOrdenado (var pri: listaSolistas; b: banda);
var
	nue, act, ant: listaSolistas;
begin
	new (nue);
	nue^.dato.nombre:= b.nombre;
	nue^.dato.estilo := b.estilo;
	nue^.sig:= nil;
	if (pri = nil) then pri:= nue
	else begin
		act:= pri;
		while (act <> nil) and (act^.dato.estilo < nue^.dato.estilo) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if (act = pri) then begin
			nue^.sig:= pri;
			pri:= nue;
		end
		else begin
			ant^.sig:= nue;
			nue^.sig:= act;
		end;
	end;
end;

procedure GenerarNuevaEstructura (a: arbol; var L: listaSolistas);
begin
	if (a <> nil) then begin
		if (a^.dato.cant = 1) then  //solista = 1
			InsertarOrdenado (L, a^.dato);
		GenerarNuevaEstructura (a^.HI, L);
		GenerarNuevaEstructura (a^.HD, L);
	end;
end;

procedure Maximo (a: arbol; var max: integer; var maxNombre: cadena30);
begin
	if(a <> nil) then begin
		if (a^.dato.cant > max) then begin
			max:= a^.dato.cant;
			maxNombre:= a^.dato.nombre;
		end;
		Maximo (a^.HI, max, maxNombre);
		Maximo (a^.HD, max, maxNombre);
	end;
end;

function maxIntegrantes (a: arbol): cadena30;
var
	max: integer;
	maxNombre: cadena30;
begin
	max:= -1;
	Maximo (a, max, maxNombre);
	maxIntegrantes:= maxNombre;
end;


procedure ImprimirLista (L: listaSolistas);
begin
	 writeln ('las bandas solistas son: ');
	while (L <> nil) do begin
		writeln ('nombre: ', L^.dato.nombre);
		writeln ('estilo: ', L^.dato.estilo);
		L:= L^.sig;
	end;
end;

//pp

var
	a: arbol;
	L:listaSolistas;

begin
	randomize;
	a:= nil;
	L:= nil;
	CargarArbol(a);
	if (a = nil) then writeln ('No se han ingresado datos')
	else begin
		GenerarNuevaEstructura(a, L);
		ImprimirLista(L); //verificando q este biem	
		writeln ('El nombre de la banda con mas integrantes es: ', maxIntegrantes(a));
	end;
	
end.













