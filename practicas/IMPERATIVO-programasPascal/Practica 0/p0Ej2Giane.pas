program p0ej2;
const
	maxZona= 5;
	fin= -1;
type
	rangoZona= 1..maxZona;
	
	propiedad = record
		zona: rangoZona;
		cod: integer;
		tipoP: string;
		cantM: integer;
		precioM: real;
	end;
	
	infoPropiedad = record
		cod: integer;
		tipo: string;
		total: real;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: infoPropiedad;
		sig: lista;
	end;
	
	vectorPropiedades = array [rangoZona] of lista;
	
//modulos

procedure Leer (var p: propiedad);
begin
	writeln ('Ingrese precio por metro cuadrado de la propiedad '); readln (p.precioM);
	if (p.precioM <> fin) then begin
		writeln ('Ingrese zona de la propiedad '); readln (p.zona);
		writeln ('Ingrese codigo de la propiedad '); readln (p.cod);
		writeln ('Ingrese tipo de la propiedad '); readln (p.tipoP);
		writeln ('Ingrese cantidad de metros cuadrados de la propiedad '); readln (p.cantM);	
	end;
end;

procedure InsertarOrdenado (var L: lista; p: infoPropiedad);
var
	nue, act, ant: lista;
begin
	new (nue);
	nue^.dato:= p;
	nue^.sig:= nil;
	if (L = nil) then L:= nue
	else begin
		act:= L;
		while (act <> nil ) and (act^.dato.tipo < nue^.dato.tipo) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if (act = L) then begin
			nue^.sig:= L;
			L:= nue;
		end
		else begin
			ant^.sig:= nue;
			nue^.sig:= act;
		end;
	end;
end;

procedure InicializarListas (var v: vectorPropiedades);
var
	i: rangoZona;
begin
	for i:= 1 to maxZona do 
		v[i]:= nil
end;

procedure GenerarPropiedad (var p: infoPropiedad; propi: propiedad);
begin
	p.cod:= propi.cod;
	p.tipo:= propi.tipoP;
	p.total:= propi.cantM * propi.precioM;
end;

//inciso A
procedure CargarVector (var v: vectorPropiedades);
var
	propi: propiedad;
	p: infoPropiedad;
begin
	Leer(propi);
	while propi.precioM <> fin do begin
		GenerarPropiedad (p, propi);
		InsertarOrdenado (v[propi.zona], p);
		Leer (propi);
	end;
end;

//inciso B
procedure buscarPropiedades (L: lista; tipoBuscado: string);
var
	aux: integer;
begin
	aux:= 0;
	while (L <> nil) do begin
		if (L^.dato.tipo = tipoBuscado) then begin
			writeln ('Propiedad encontrada, codigo: ' , L^.dato.cod);
			aux:= aux + 1;
		end;
		L:= L^.sig;
	end;
	if (aux = 0) then 
		writeln ('No se han encontrado propiedades que coincidan con lo buscado');
end;

var
	v: vectorPropiedades;
	numZona: rangoZona;
	tipoPropi: string;
begin
	InicializarListas (v);
	CargarVector (v);
	writeln ('Ingrese una zona de propiedad para buscar');
	readln (numZona);
	writeln ('Ingrese un tipo de propiedad para buscar');
	readln (tipoPropi);
	buscarPropiedades ( v[numZona], tipoPropi);
end.
