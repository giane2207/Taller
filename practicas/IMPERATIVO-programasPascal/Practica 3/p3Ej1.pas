program ej1;
const
	fin = 0;
	aumento =1;
type
	rangoEdad = 0..100; //a menos q sea mirtha mas de 100 años no creos q tengan
	
	socio = record
		num: integer;
		nombre: string;
		edad: integer;
	end;
	
	arbol = ^nodo;
	nodo = record	
		dato: socio;
		HI: arbol;
		HD: arbol;
	end;
	
procedure Agregar (var a: arbol; s: socio);
begin
	if (a = nil) then begin
		new (a);
		a^.dato:= s;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else
		if (s.num <= a^.dato.num) then 
			Agregar(a^.HI,s)
		else Agregar (a^.HD, s);
end;

procedure LeerSocio (var s: socio);
begin
	writeln ('Ingrese numero de socio'); readln (s.num);
	if (s.num <> 0 ) then begin
		writeln ('Ingrese nombre de socio'); readln (s.nombre);
		writeln ('Ingrese edad de socio'); readln (s.edad);
	end;
	writeln ('');
end;

procedure CargarArbol (var a: arbol);
var
	s: socio;
begin
	LeerSocio (s);
	while (s.num <> 0) do begin
		Agregar(a, s);
		LeerSocio (s);
	end;
end;
//a
function Maximo (a: arbol): integer;
begin
	if (a <> nil) then begin
		if (a^.HD = nil) then 
			Maximo:= a^.dato.num
		else Maximo:= Maximo (a^.HD);
	end;	
end;
//b
function Minimo (a: arbol): integer;
begin
	if (a <> nil) then begin
		if (a^.HI = nil) then 
			Minimo:= a^.dato.num
		else Minimo:= Minimo (a^.HI);
	end;	
end;
//c
procedure MayorEdad (a: arbol; var max: integer; var maxNum: integer);
begin
	if (a <> nil) then begin
		if (a^.dato.edad > max) then begin
			max:= a^.dato.edad;
			maxNum:= a^.dato.num;
		end;
		MayorEdad(a^.HI, max, maxNum);
		MayorEdad(a^.HD, max, maxNum);
	end;
end;

//d
procedure AumentoEdad (a: arbol);
begin
	if (a <> nil) then begin
		a^.dato.edad:= a^.dato.edad + aumento; 
		AumentoEdad(a^.HI);
		AumentoEdad(a^.HD);
	end;	
end;
//e
function buscar (a: arbol; valor: integer): boolean;
begin
	if (a = nil) then buscar:= false // si el arbol llega vacio o no encuentra el valor
	else if (a^.dato.num = valor) then buscar:= true
	else if (valor > a^.dato.num) then 
		buscar:= buscar (a^.HD, valor)
	else buscar:= buscar (a^.HI, valor);
end;
//f
function buscar (a: arbol; valor: string): boolean;
begin
	if (a = nil) then buscar:= false
	else if (a^.dato.nombre = valor) then buscar:= true
	else if (valor > a^.dato.nombre) then 
		buscar:= buscar (a^.HD, valor)
	else buscar:= buscar (a^.HI, valor);
end;
//g
procedure CantSocios (a: arbol; var cant: integer);
begin
	if (a <> nil) then begin
		cant:= cant + 1;
		CantSocios(a^.HI, cant);
		CantSocios(a^.HD, cant);
	end;
end;
//h
procedure SumaEdades (a: arbol; var suma: integer);
begin
	if (a <> nil) then begin
		suma:= suma + a^.dato.edad;
		SumaEdades(a^.HI, suma);
		SumaEdades(a^.HD, suma);
	end;
end;
//i
function PromedioEdad (a: arbol): real;
var
	suma, cant: integer;
begin
	suma:= 0; cant:= 0;
	CantSocios(a, cant);
	SumaEdades(a, suma);
	PromedioEdad:= suma/cant;
end;

//j
procedure OrdenCreciente (a: arbol);
begin
	if (a<> nil) then begin
		OrdenCreciente(a^.HI);
		writeln ('numero de socio: ', a^.dato.num);
		OrdenCreciente(a^.HD);
	end;
end;

function EsPar (num: integer): boolean;
begin
	EsPar:= num MOD 2 = 0;
end;

//k
procedure OrdenDecrecientePares (a: arbol);
begin
	if (a <> nil) then begin
		if (EsPar(a^.dato.num)) then begin
			OrdenDecrecientePares(a^.HD);
			writeln ('numero de socio PAR: ', a^.dato.num);
			OrdenDecrecientePares(a^.HI);
		end;
	end;
end;

var
	a: arbol;
	maxEdad, maxNum, valor, cant: integer;
	nombre: string;
begin
	//esta horrible este pp pero ni ganas de dejarlo bonito
	a:= nil;
	CargarArbol(a);
	if a <> nil then begin
		writeln ('El numero de socio mas grande es: ', Maximo(a));
		writeln ('El numero de socio mas chico es: ', Minimo(a));
		maxEdad:= -1;
		MayorEdad(a, maxEdad, maxNum);
		writeln ('El numero de socio con mayor edad es: ', maxNum);
		AumentoEdad (a);
		randomize;
		valor:= random(999);
		if (buscar (a, valor)) then writeln ('Existe un socio con el numero: ', valor)
		else writeln ('No existe un socio con el numero: ', valor);
		writeln ('Ingrese un nombre a buscar entre los socios:'); readln (nombre);
		if (buscar (a, nombre)) then writeln ('Existe un socio con el nombre: ', nombre)
		else writeln ('No existe un socio con el nombre: ', nombre);
		cant:= 0; 
		CantSocios(a,cant);
		writeln ('El promedio de edad de los socios es: ', PromedioEdad(a):0:1);
		OrdenCreciente(a); // orden creciente
		OrdenDecrecientePares(a); //orden decreciente
	end;
end.
