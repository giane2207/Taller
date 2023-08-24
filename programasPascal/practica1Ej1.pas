program prac1ej1;
const
	materias= 36;
type
	cadena20= string [20];
	rangoMaterias= 1..materias;
	rangoNota= 4..10;
	
	vectorNotas= array [rangoMaterias] of rangoNota;
	
	Ralumno= record
		ape: cadena20;
		num: integer;
		anio: integer;
		cantMaterias: rangoMaterias;
		nota: vectorNotas;
	end;

	lista= ^nodo;
	nodo= record
		dato: Ralumno;
		sig: lista;
	end;
	
//modulos

procedure LeerNotas (var v: vectorNotas; cant: rangoMaterias);
var
	i: rangoMaterias;
begin
	for i:= 1 to cant do begin
		writeln ('ingrese nota obtenida');
		readln (v[i]);
	end;
end;

procedure LeerAlumno (var a: Ralumno);
begin
	writeln ('ingrese apellido');
	readln (a.ape);
	writeln ('ingrese numero de alumno');
	readln (a.num);
	writeln ('ingrese anio de ingreso');
	readln (a.anio);
	writeln ('ingrese cantidad de materias aprobadas');
	readln (a.cantMaterias);
	LeerNotas (a.nota, a.cantMaterias);
end;

procedure AgregarAdelante (var L: lista; a: Ralumno);
var
	nue: lista;
begin
	new (nue);
	nue^.dato:= a;
	nue^.sig:= L;
	L:=nue;
end;

procedure CargarLista (var L: lista);
var
	a: Ralumno;
begin
	repeat
		LeerAlumno (a);
		AgregarAdelante (L, a);
	until (a.num = 11111);
end;

function promedio (nota: vectorNotas; cant: rangoMaterias): real;
var
	i: rangoMaterias;
	suma: integer;
begin
	suma:= 0;
	for i:= 1 to cant do begin
	    if (nota[i] > 4) then 
			suma:= suma + nota[i];
	end;
	promedio:= suma/cant;
end;

procedure InformarB (L: lista);
begin
	while L <> nil do begin
		writeln ('El alumno numero ', L^.dato.num, ' tiene promedio de: ', promedio(L^.dato.nota, L^.dato.cantMaterias):0:1);
		L:= L^.sig;
	end;
end;

var
	L:lista;

//programa principal
begin
	L:= nil;
	CargarLista (L);
	InformarB (L);
end.
