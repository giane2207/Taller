program e4p5;
const
	fin = -1;
type
	reclamo = record
		cod: integer;
		dni: integer;
		anio: integer;
		tipo: string;
	end;
	
	listaR = ^nodo;
	nodo = record
		dato: reclamo;
		sig: listaR;
	end;
	
	infoReclamos = record
		dni: integer;
		cant: integer;
		lista: listaR;
	end;
	
	arbol = ^nodo2;
	nodo2 = record
		dato: infoReclamos;
		HI: arbol;
		HD: arbol;
	end;
	
	listaC = ^nodo3;
	nodo3 = record
		dato: integer;
		sig: listaC;
	end;
	
//modulos

procedure Leer (var r: reclamo);
begin
	writeln ('Ingrese codigo (-1 para finalizar)'); readln (r.cod);
	if (r.cod <> fin) then begin
		r.dni:= random (10);
		r.anio:= random (10) + 2000;
		writeln ('Ingrese tipo de reclamo)'); readln (r.tipo);
	end;
end;

procedure AgregarAdelante (var pri: listaR; r: reclamo);
var
	nue: listaR;
begin
	new (nue);
	nue^.dato:= r;
	nue^.sig:= pri;
	pri:= nue;
end;

procedure Actualizar (var a: arbol; r: reclamo);
begin
	AgregarAdelante(a^.dato.lista,r);
	a^.dato.cant:= a^.dato.cant + 1;
end;

procedure Agregar (var a: arbol; r: reclamo);
begin
	if (a = nil) then begin
		new (a);
		a^.dato.dni:= r.dni;
		a^.dato.lista:= nil;
		AgregarAdelante (a^.dato.lista, r);
		a^.dato.cant:= 1;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else if (a^.dato.dni = r.dni) then
			Actualizar (a, r)
	else if (r.dni < a^.dato.dni) then 
			Agregar(a^.HI, r)
	else Agregar (a^.HD, r);
end;

procedure CargarArbol (var a: arbol);
var
	r: reclamo;
begin
	Leer (r);
	while (r.cod <> fin) do begin
		Agregar (a, r);
		Leer(r);
	end;
end;

procedure ImprimirLista (L: listaR);
begin
	while (L <> nil) do begin
		writeln ('codigo de reclamo: ', L^.dato.cod);
		writeln ('anio de reclamo: ', L^.dato.anio);
		writeln ('tipo de reclamo: ', L^.dato.tipo);
		L:= L^.sig;
	end;

end;

procedure ImprimirArbol (a: arbol);
begin
	if a<> nil then begin
	ImprimirArbol(a^.HI);
	writeln ('lista de reclamos con el dni: ', a^.dato.dni);
	ImprimirLista (a^.dato.lista);
	ImprimirArbol(a^.HD);
	end;
end;

function CantReclamos(a: arbol; dni: integer): integer;
begin
	if (a = nil) then CantReclamos:= 0
	else if (a^.dato.dni = dni) then CantReclamos:= a^.dato.cant
	else if (dni > a^.dato.dni) then
		CantReclamos:= CantReclamos(a^.HD, dni)
	else CantReclamos:= CantReclamos(a^.HI, dni);
end;

function Busqueda (a: arbol; inf, sup: integer): integer;
begin
	if (a <> nil) then begin
		if (a^.dato.dni > sup) then
			Busqueda:= Busqueda (a^.HI, inf, sup)
		else if (a^.dato.dni >= inf) and (a^.dato.dni <= sup) then
			Busqueda:= a^.dato.cant + Busqueda (a^.HD, inf, sup) + Busqueda (a^.HI, inf, sup)
		else Busqueda:= Busqueda (a^.HD, inf, sup);
	end
	else Busqueda:= 0;
end;

function CantEntreDos (a: arbol; valor1, valor2: integer): integer;
begin
	if (valor1 > valor1) then 
		CantEntreDos:= Busqueda (a, valor1, valor2)
	else CantEntreDos:= Busqueda (a, valor2, valor1);
end;

procedure AgregarAdelanteC (var pri: listaC; c: integer);
var
	nue: listaC;
begin
	new (nue);
	nue^.dato:= c;
	nue^.sig:= pri;
	pri:= nue;
end;

procedure RecorrerLista (L: listaR; var L2: listaC; anio: integer);
begin
	while (L <> nil) do begin
		if (L^.dato.anio = anio) then
			AgregarAdelanteC (L2, L^.dato.cod);
		L:= L^.sig;
	end;
end;

procedure GenerarLista (a: arbol; var L: listaC; anio: integer);
begin
	if (a <> nil) then begin
		RecorrerLista (a^.dato.lista, L, anio);
		GenerarLista(a^.HD, L, anio);
		GenerarLista(a^.HI, L, anio);
	end;
end;

procedure ImprimirListaC (L: listaC);
begin
	while (L<> nil) do begin
		writeln ('codigo: ', L^.dato);
		L:= L^.sig;
	end;
end;	

//pp

var
	a: arbol;
	dni, dni2, anio: integer;
	L: listaC;
begin
	a:= nil;
	CargarArbol (a);
	if (a <> nil) then begin
		ImprimirArbol (a);
		writeln ('Ingrese un dni para buscar cuantos reclamos hizo'); readln (dni);
		writeln ('La cantidad de reclamos que hizo el dni ', dni, ' fueron: ', CantReclamos(a,dni));
		
		writeln ('Ingrese 2 dni para decir la cantidad de reclamos comprendidos entre ellos'); readln (dni); readln (dni2);
		writeln ('La cantidad de reclamos es: ', CantEntreDos(a, dni, dni2));
		
		writeln ('Ingrese un anio para buscar los reclamos realidos ese anio'); readln (anio);
		L:= nil;
		GenerarLista(a,L, anio);
		ImprimirListaC (L);
		
	end
	else writeln ('No se han ingresado datos');
end.

















	
