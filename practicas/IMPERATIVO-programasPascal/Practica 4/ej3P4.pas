program ej3p4;
const
	aprobada = 4;
	nota = 10;
	materias = 5;
	fin = -1;
type
	rangoNotas = -1..nota;
	rangoAprobadas = aprobada..nota;
	rangoMaterias = 1..30;
	
	vectorAprobadas = array [rangoMaterias] of rangoAprobadas;
	
	alumno = record
		cod: integer;
		nota: vectorAprobadas;
	end;
	
	alumno2 = record
		cod: integer;
		nota: rangoNotas;
	end;
	
	finaal = record
		cod: integer;
		codMateria: rangoMaterias;
		nota: rangoNotas;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: alumno;
		HI: arbol;
		HD: arbol;
	end;
	
	lista = ^nodo2;
	nodo2 = record
		dato: alumno2;
		sig: lista;
	end;
	
	vectorMaterias = array [rangoMaterias] of lista;
	
	infoB = record
		promedio: real;
		cod: integer;
	end;
	
	listaB = ^nodo3;
	nodo3 = record
		dato: infoB;
		sig: listaB;
	end;
	
//modulos

procedure InicializarVector (var v: vectorAprobadas);
var
	i: rangoMaterias;
begin
	for i:= 1 to materias do begin
		v[i]:= 0;
	end;
end;

procedure InicializarListas (var v: vectorMaterias);
var
	i: integer;
begin
	for i:= 1 to materias do 
		v[i]:= nil;
end;

procedure Leer (var f: finaal );
begin
	writeln ('Ingrese nota del final (finaliza con -1)'); readln (f.nota);
	if (f.nota <> fin) then begin
		f.cod:= random(100);
		f.codMateria:= random (materias)+1; // sin incliuir el 0
	end;
end;

procedure CargarEstructura (var L: lista; f: finaal);
var 
	nue: lista;
begin
	new (nue);
	nue^.dato.cod:= f.cod;
	nue^.dato.nota:= f.nota;
	nue^.sig:= L;
	L:= nue;
end;

procedure Actualizar (var v: vectorAprobadas; f: finaal);
begin
	v[f.codMateria]:= f.nota;
end;

procedure Agregar (var a: arbol; f: finaal);
begin
	if (a = nil) then begin
		new(a);
		a^.dato.cod:= f.cod;
		InicializarVector (a^.dato.nota);
		a^.dato.nota[f.codMateria]:= f.nota;
		a^.HD:=nil;
		a^.HI:= nil;
	end
	else if (f.cod = a^.dato.cod) then
			Actualizar (a^.dato.nota, f)
	else if (f.cod > a^.dato.cod) then
			Agregar(a^.HD, f)
	else Agregar(a^.HI, f);
end;

procedure GenerarDosEstructuras (var a: arbol; var v: vectorMaterias);
var
	f: finaal;
begin
	Leer (f);
	InicializarListas(v);
	while (f.nota <> fin) do begin
		if (f.nota >= aprobada) then 
			Agregar (a,f);
		CargarEstructura (v[f.codMateria], f);// agregarAdelante pero inicializar todo el vector de listas antes 
		Leer (f);
	end;
end;

procedure ImprimirVector (v: vectorAprobadas);
var
	i: integer;
begin
	for i:= 1 to materias do 
		writeln ('En la materia ', i, ' el pibe se saco un: ', v[i]);
end;

procedure ImprimirArbol (a: arbol);
begin
	if (a <> nil) then begin
		ImprimirArbol(a^.HI);
		writeln ('codigo de alumno: ', a^.dato.cod);
		writeln ('notas del pibe: ');
		ImprimirVector (a^.dato.nota);
		ImprimirArbol(a^.HD);
	end;

end;

procedure ImprimirLista (L: lista);
begin
	while (L <> nil) do begin
		writeln ('codigo de alumno: ', L^.dato.cod, ' se saco un ', L^.dato.nota);
		L:= L^.sig;
	end;
end;

procedure ImprimirVector (v: vectorMaterias);
var
	i: integer;
begin
	for i:= 1 to materias do begin
		if (v[i] <> nil) then begin
			writeln ('En la materia ', i, ' rindieron estos pibes');
			ImprimirLista(v[i]);
		end;
	end;
end;

function promedio (v: vectorAprobadas): real;
var
	cant: integer;
	i: rangoMaterias;
	suma: real;
	
begin
	cant:= 0;
	suma:= 0;
	for i:= 1 to materias do begin
		if (v[i] > 0) then begin
			cant:= cant + 1;
			suma:= suma + v[i];
		end;
	end;
	if (cant <> 0) then 
		Promedio:= suma/cant
	else Promedio:= 0;
			
end;

procedure AgregarAdelante (var pri: listaB; cod: integer; promedio: real);
var
	nue: listaB;
begin
	new(nue);
	nue^.dato.cod:= cod;
	nue^.dato.promedio:= promedio;
	nue^.sig:= pri;
	pri:= nue;
end;	

procedure CargarLista (a: arbol;var L: listaB; cod: integer);
begin
	if (a <> nil) then begin
		if (a^.dato.cod > cod) then
			AgregarAdelante (L, a^.dato.cod, promedio(a^.dato.nota));
		CargarLista(a^.HI, L, cod);
		CargarLista(a^.HD, L, cod);
	end;
end;


function IncisoB (a: arbol; cod: integer): listaB;
var
	L: listaB;
begin
	L:= nil;
	CargarLista (a, L, cod);
	IncisoB:= L;	
end;

procedure Imprimir (L: listaB);
begin
	while (L <> nil) do begin
		writeln ('promedio ', L^.dato.promedio:0:1);
		writeln ('codigo de alumno: ', L^.dato.cod);
		L:= L^.sig;
	end;
		
end;
//pp

var
	a: arbol;
	v: vectorMaterias;
	cod: integer;
	L: listaB;
begin
	randomize;
	GenerarDosEstructuras(a, v);
	writeln ('ARBOL CON ALUMNOS: ');
	ImprimirArbol (a);
	
	writeln ('VECTOR CON MATERIAS Y SUS ALUMNOS: ');
	ImprimirVector (v);
	
	writeln ('Ingrese un codigo de alumno'); readln (cod);
	writeln ('Lista de alumnos con su codigo mayor a: ', cod);
	L:= IncisoB(a, cod);
	Imprimir (L);
	//queda pendiente el c
end.
