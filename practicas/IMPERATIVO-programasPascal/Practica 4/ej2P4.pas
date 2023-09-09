program ej2P4; //lo di todo en este programa AAA
const
	fin = -1;
	anio = 2021;
type
	rangoDia = 1..31;
	rangoMes = 1..12;
	
	Rfecha = record
		dia: rangoDia;
		mes: rangoMes;
	end;
	
	prestamo = record
		ISBN: integer;
		num: integer;
		fecha: Rfecha;
		cantDias: integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: prestamo;
		HI: arbol;
		HD: arbol;
	end;
	
	listaP = ^nodo2;
	nodo2 = record
		dato: prestamo;
		sig: listaP;
	end;
	
	prestamos = record
		ISBN: integer;
		lista: listaP;
	end;
	
	arbolISBN = ^nodo3;
	nodo3 = record
		dato: prestamos;
		HI: arbolISBN;
		HD: arbolISBN;
	end;
	
//modulos

procedure leerFecha (var f: Rfecha);
begin
	f.dia:= random (31)+1;
	f.mes:= random (12)+1;
end;


procedure Leer (var p: prestamo);
begin
	writeln ('Ingrese un numero de ISBN (-1 para finalizar)'); readln (p.ISBN);
	if (p.ISBN <> fin) then begin
		p.num:= random (3);
		p.cantDias:= random (90);
		leerFecha (p.fecha);
	end;
end;

procedure AgregarAlArbol (var a: arbol; p: prestamo);
begin
	if (a = nil) then begin
		new (a);
		a^.dato:= p;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else if ( p.ISBN >= a^.dato.ISBN) then
			AgregarAlArbol(a^.HD, p)
	else 
			AgregarAlArbol(a^.HI, P);
end;

procedure AgregarAdelante (var pri: listaP; p: prestamo);
var
	nue: listaP;
begin
	new (nue);
	nue^.dato:= p;
	nue^.sig:= pri;
	pri:= nue;
end;


procedure Agregar (var a: arbolISBN; p: prestamo);
begin
	if (a = nil) then begin //significa que el ISBN no estaba en el arbol o es el primero
		new(a);
		a^.dato.ISBN:= p.ISBN;
		a^.dato.lista:= nil; //inicializo cada vez q haya nuevo ISBN
		AgregarAdelante(a^.dato.lista, p);
		a^.HI:= nil;
		a^.HD:= nil;
	end
	
	else if (p.ISBN = a^.dato.ISBN) then 
		AgregarAdelante(a^.dato.lista, p)
		
	else if (p.ISBN > a^.dato.ISBN) then  //si el numero es mayor al actual entonces voy por derecha 
		Agregar(a^.HD, p)
		
	else Agregar(a^.HI, p);
end;

//a
procedure GenerarDosEstructuras (var a: arbol; var ar: arbolISBN);
var 
	p: prestamo;
begin
	leer (p);
	while (p.ISBN <> fin) do begin
		AgregarAlArbol (a, p);
		Agregar (ar, p);
		leer(p);
	end;
end;

procedure ImprimirLista (L: listaP);
begin
	while (L <> nil) do begin
		writeln ('numero de socio: ', L^.dato.num);
		writeln ('fecha: ', L^.dato.fecha.dia, '/', L^.dato.fecha.mes, '/', anio);
		writeln ('cantidad de dias prestados: ', L^.dato.cantDias);
		writeln ('');
		L:= L^.sig;
	end;
end;

procedure ImprimirArbol (a: arbolISBN);
begin
	if (a <> nil) then begin
		ImprimirArbol (a^.HI);
		writeln ('');
		writeln ('lista de socios que tuvieron el libro, ISBN: ', a^.dato.ISBN);
		writeln ('');
		ImprimirLista (a^.dato.lista);
		writeln ('-----');
		ImprimirArbol(a^.HD);
	end;
end;

//b
function Maximo (a: arbol): integer;
begin
	if (a <> nil) then begin
		if (a^.HD = nil) then
			Maximo:= a^.dato.ISBN
		else Maximo:= Maximo (a^.HD);
	end
	else Maximo:= -1;
end;

//c
function Minimo (a: arbolISBN): integer;
begin
	if (a <> nil) then begin
		if (a^.HI= nil) then
			Minimo:= a^.dato.ISBN
		else Minimo:= Minimo (a^.HI);
	end
	else Minimo:= -1;
end;

//d
procedure CantPrestamos (var cant: integer; a: arbol; numSocio: integer);
begin
	if (a <> nil) then begin
		if (a^.dato.num = numSocio) then 
			cant:= cant + 1;
		CantPrestamos(cant, a^.HI, numSocio);
		CantPrestamos(cant, a^.HD, numSocio);
	end;
end;

function incisoD (a: arbol; numSocio: integer): integer;
var
	cant: integer;
begin
	cant:= 0;
	CantPrestamos(cant, a, numSocio);
	incisoD:= cant;
end;

procedure BuscarEnLaLista (L: listaP; numSocio: integer; var cant: integer);
begin
	while (L <> nil) do begin
		if (L^.dato.num = numSocio) then
			cant:= cant + 1;
		L:= L^.sig;
	end;
end;


procedure Buscar (a: arbolISBN; num: integer; var cant: integer);
begin
	if (a <> nil) then begin
		BuscarEnLaLista(a^.dato.lista, num, cant);
		Buscar (a^.HI, num, cant);
		Buscar (a^.HD, num, cant);
	end;
end;

function IncisoE (a: arbolISBN; numSocio: integer): integer;
var
	cant: integer;
begin
	cant:= 0;
	Buscar(a, numSocio, cant);
	IncisoE:= cant;
end;

procedure Inicializar (var a: arbol; var ar: arbolISBN);
begin
	a:= nil;
	ar:= nil;
end;

function ContarPrestamosEnLista(L: listaP): integer;
var
	cant: integer;
begin
	cant:= 0;
	while (L <> nil) do begin
		cant:= cant + 1;
		L:= L^.sig;
	end;
	ContarPrestamosEnLista:= cant;
end;

function BusquedaAcotadaii (a: arbolISBN; inf, sup: integer): integer; // con inclusion
begin
	if (a <> nil) then begin
		if (a^.dato.ISBN > sup) then
			BusquedaAcotadaii:= BusquedaAcotadaii(a^.HI, inf, sup)
		else if (a^.dato.ISBN >= inf) and (a^.dato.ISBN <= sup) then 
			BusquedaAcotadaii:= ContarPrestamosEnLista(a^.dato.lista) + BusquedaAcotadaii(a^.HI, inf, sup) + BusquedaAcotadaii (a^.HD, inf, sup)
		else if (a^.dato.ISBN < inf) then 
			BusquedaAcotadaii:= BusquedaAcotadaii(a^.HD, inf, sup);
	end
	else BusquedaAcotadaii:= 0;
end;

function Busquedaii (a: arbolISBN; valor1, valor2: integer): integer;
begin
	if valor2 > valor1 then 
		Busquedaii:= BusquedaAcotadaii(a, valor1, valor2)
	else Busquedaii:= BusquedaAcotadaii(a, valor2, valor1);
end;

function BusquedaAcotadai (a: arbol; inf, sup: integer): integer; //con inclusion
begin
	if (a <> nil) then begin
		if (a^.dato.ISBN > sup) then
			BusquedaAcotadai:= BusquedaAcotadai(a^.HI, inf, sup)
		else if (a^.dato.ISBN >= inf) and (a^.dato.ISBN <= sup) then 
			BusquedaAcotadai:= 1 + BusquedaAcotadai(a^.HI, inf, sup) + BusquedaAcotadai (a^.HD, inf, sup)
		else if (a^.dato.ISBN < inf) then 
			BusquedaAcotadai:= BusquedaAcotadai(a^.HD, inf, sup);
	end
	else BusquedaAcotadai:= 0;
end;

function Busquedai (a: arbol; valor1, valor2: integer): integer;
begin
	if valor2 > valor1 then 
		Busquedai:= BusquedaAcotadai(a, valor1, valor2)
	else Busquedai:= BusquedaAcotadai(a, valor2, valor1);
end;

//pp
var
	a: arbol;
	ar: arbolISBN;
	numSocio, valor1 , valor2: integer;
begin
	randomize;
	Inicializar (a, ar);
	GenerarDosEstructuras(a, ar); //a
	
	if (a = nil) then writeln ('No se han realizado prestamos :(')
	else begin
		ImprimirArbol (ar); //vericando q esta bien armado el arbol
		
		writeln ('El ISBN mas grande es: ', Maximo (a)); //b
		writeln ('El ISBN mas chico es: ', Minimo (ar)); //c
		
		writeln ('ARBOL DONDE CADA NODO ES UN PRESTAMO:');
		writeln ('Ingrese un numero de socio para buscar cuantos prestamos hizo: '); read (numSocio);
		writeln ('La cantidad de prestamos que realizo el socio numero ', numSocio ,' es: ', incisoD(a, numSocio)); //d
		
		writeln ('ARBOL DONDE SE SEPARA POR ISBN:');
		writeln ('Ingrese un numero de socio para buscar cuantos prestamos hizo: '); read (numSocio);
		writeln ('La cantidad de prestamos que realizo el socio numero ', numSocio ,' es: ', incisoE(ar, numSocio)); //e
		
		//quedan pendientes f, g y h
		
		writeln ('Ingrese 2 numeros de ISBN : '); readln (valor1); readln (valor2); 
		writeln ('La cantidad de prestamos comprendidos entre los valores ingresados son: ', Busquedai(a, valor1, valor2)); //i
		
		writeln ('Ingrese 2 numeros de ISBN : '); readln (valor1); readln (valor2); 
		writeln ('La cantidad de prestamos comprendidos entre los valores ingresados son: ', Busquedaii(ar, valor1, valor2)); //j
	end;
end.
