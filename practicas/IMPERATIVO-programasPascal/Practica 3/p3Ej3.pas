program ej3;
const
	fin = 0;
	finMaterias = -1;
	notas = 10;
type
	rangoNotas = 0..notas;
	rangoIngreso = 2000..2050;
	
	InfoFinal = record
		cod: integer;
		nota: rangoNotas;
	end;
	
	listaFinales = ^nodo1;
	nodo1 = record
		dato: InfoFinal;
		sig: listaFinales;
	end;
	
	infoAlu = record
		dni: integer;
		ingreso: integer;
	end;
	
	listaAlumnos = ^nodo2;
	nodo2 = record
		dato: infoAlu;
		sig: listaAlumnos;
	end;
	
	alumno = record
		dni: integer;
		legajo: integer;
		ingreso: integer;
		finales: listaFinales;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: alumno;
		HI: arbol;
		HD: arbol;
	end;
	
//modulos

procedure LeerF (var f: infoFinal);
begin
	writeln ('Ingrese un codigo de materia (-1 para finalizar)'); readln (f.cod);
	if (f.cod <> -1) then
		f.nota:= random (11); //entre 0 y 10
end;

procedure AgregarAdelante (var pri: listaFinales; f: InfoFinal);
var
	nue: listaFinales;
begin
	new (nue);
	nue^.dato:= f;
	nue^.sig:= pri;
	pri:= nue;
end;

procedure Cargafinales (var L: listaFinales);
var
	f: infoFinal;
begin
	LeerF (f);
	while (f.cod <> finMaterias) do begin
		AgregarAdelante (L, f);
		LeerF (f);
	end;
end;

procedure Leer(var a: alumno);
begin
	randomize;
	writeln ('Ingrese un numero de legajo (0 para finalizar)'); readln (a.legajo);
	if (a.legajo <> fin) then begin
		a.ingreso:= random (2000) + 1050;
		a.dni:= random(4000);
		a.finales:= nil;
		CargaFinales (a.finales);
	end;
end;

procedure Agregar (var a: arbol; alu: alumno);
begin
	if (a = nil) then begin
		new(a);
		a^.dato:=alu;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else 
		if (alu.legajo >= a^.dato.legajo) then
			Agregar (a^.HD, alu)
		else Agregar (a^.HI, alu);		
end;

procedure CargarArbol (var a: arbol);
var 
	alu: alumno;
begin
	Leer (alu);
	while (alu.legajo <> fin)do begin
		Agregar (a,alu);
		Leer(alu);
	end;
end;

procedure AgregarAdelanteB (var pri: listaAlumnos; a: alumno);
var
	nue: listaAlumnos;
begin
	new(nue);
	nue^.dato.dni:= a.dni;
	nue^.dato.ingreso:= a.ingreso;
	nue^.sig:= pri;
	pri:= nue;
end;

//b
procedure incisoB(a: arbol; var l: listaAlumnos; valor: integer);
begin 
    if (a<> nil) then begin
        incisoB(a^.HI, l, valor);
        if (a^.dato.legajo < valor)then begin
			agregarAdelanteB(l, a^.dato);
		end;
        incisoB(a^.HD, l, valor);
    end;
end;

procedure ImprimirLista (L: listaAlumnos);
begin
	while L<> nil do begin
		writeln ('dni: ', L^.dato.dni);
		writeln ('anio de ingreso: ', L^.dato.ingreso);
		L:= L^.sig;
	end;
end;

function MaximoLegajo (a: arbol): integer;
begin
	if (a <> nil) then begin
		if (a^.HD = nil) then 
			MaximoLegajo:= a^.dato.legajo
		else MaximoLegajo:= MaximoLegajo(a^.HD);
	end
	else MaximoLegajo:= -1;
end;

procedure dniMax (a: arbol; var max: integer);
begin
	if (a<> nil) then begin
		if (a^.dato.dni > max) then 
			max:= a^.dato.dni;
		dniMax (a^.HI, max);//debo reccorer todo el arbol xq no esta ordenado por dni
		dniMax (a^.HD, max);
	end;
end;

function EsPar (num: integer): boolean;
begin
	EsPar:= num MOD 2 = 0;
end;

procedure legajosImpares (a: arbol; var cant: integer);
begin
	if (a <> nil) then begin
		if (NOT(EsPar(a^.dato.legajo))) then //si no es par, o sea si es impar
			cant:= cant + 1;
		legajosImpares (a^.HI, cant);
		legajosImpares (a^.HD, cant);
	end;
end;

function PromAlumno (L: listaFinales): real;
var
	cant: integer;
	suma: real;
begin
	cant:= 0;
	suma:= 0;
	while (L <> nil) do begin
		cant:= cant + 1;
		suma:= suma + L^.dato.nota;
		L:= L^.sig;
	end;
	if (cant > 0) then 
		PromAlumno:= suma/cant
	else PromAlumno:= 0;
end;

procedure MejorPromedio (a: arbol; var maxProm: real; var legajo: integer);
var
	promedio: real;
begin
	if (a <> nil) then begin
		promedio:= PromAlumno(a^.dato.finales);
		if (promedio > maxProm) then begin
			maxProm:= promedio;
			legajo:= a^.dato.legajo;
		end;
		MejorPromedio(a^.HI, maxProm, legajo);
		MejorPromedio(a^.HD, maxProm, legajo);
	end;	
end;

procedure PromediosSuperan (a: arbol; valor: real);
var
	promedio: real;
begin
	if (a <> nil) then begin
		promedio:= PromAlumno(a^.dato.finales);
		if (promedio > valor) then begin
			writeln ('legajo: ', a^.dato.legajo);
			writeln ('promedio: ', promedio:0:1);
		end;
		PromediosSuperan(a^.HI, valor);
		PromediosSuperan(a^.HD, valor);
	end;
end;



//pp

var
	a: arbol;
	L: listaAlumnos;
	legajo, max, maxLegajo, cant: integer;
	maxProm, valor: real;
begin
	a:= nil;
	CargarArbol(a);
	if a <> nil then begin
		writeln ('Ingrese un numero de legajo para buscar los menores a el: '); readln (legajo);
		L:= NIL;
		incisoB(a, L, legajo);
		writeln ('Alumnos cuyo legajo es menor a: ', legajo, ' son:');
		ImprimirLista(L);
		writeln ('El mayor numero de legajo es: ', MaximoLegajo(a));
		max:= -1;
		dniMax(a, max);
		writeln ('El dni mas grande es: ', max);
		cant:= 0;
		legajosImpares(a, cant);
		writeln ('La cantidad de legajos impares es: ', cant);
		maxProm:= 0;
		MejorPromedio(a, maxProm, maxLegajo);
		writeln ('El alumno con mejor promedio es el nro legajo: ', maxLegajo, ' con un promedio de: ', maxProm:0:1);
		writeln ('Ingrese un valor entre 0 y 10: '); readln (valor);
		PromediosSuperan(a, valor);
	end
	else writeln ('No se han ingresado datos');
end.
