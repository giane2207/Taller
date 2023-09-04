program aaolooo;
const
	dimF= 8;
	fin= -1;
type
	//rangos
	rangoGeneros= 1..dimF;
	rango2 = 0..dimF;
	
	pelicula = record
		codpeli: integer;
		codg: rangoGeneros;
		puntaje: real;
	end;
	
	infoPeli= record
		codpeli: integer;
		puntaje: real;
	end;
	
	lista = ^ nodo;
	nodo = record
		dato: pelicula;
		sig: lista;
	end;
	
	vectorPelis = array [rangoGeneros] of lista;
	
	vector2 = array [rangoGeneros] of infoPeli;

//modulos


procedure inicializarListas (var v: vectorPelis);
var i: rangoGeneros;
begin
	for i:= 1 to dimF do 
		v[i]:= nil;
end;


procedure LeerPeli (var p: pelicula);
begin
	writeln ('ingrese codigo pelicula'); readln (p.codpeli);
	if p.codpeli <> fin then begin
		writeln ('ingrese codigo genero de 1 a 8 '); readln (p.codg);
		writeln ('ingrese puntaje promedio'); readln (p.puntaje);
	end;		
end;


procedure agregarAtras (var pri, ult: lista; p: pelicula);
var
	nue: lista;
begin
	new (nue);
	nue^.dato:= p;
	nue^.sig:= nil;
	if (pri = nil) then begin
		pri:= nue;
		ult:= nue;
	end
	else begin
		ult^.sig:= nue;
		ult:= nue;
	end;
end;

//inciso A
procedure CargarVector (var v: vectorPelis);
var
	p:pelicula;
	ult: lista;
begin
	LeerPeli(p);
	while p.codpeli <> fin do begin
		agregarAtras (v[p.codg],ult, p);
		LeerPeli (p);
	end;
end;

procedure BuscarMaxi (L: lista; var max: real; var cod: integer);
begin
	while L <> nil do begin
		if (L^.dato.puntaje > max) then begin
			max:= L^.dato.puntaje;
			cod:= L^.dato.codpeli;
		end;
		L:= L^.sig;
	end;
end;

//iniciso B
procedure CrearVector (var v2: vector2; var dl: rango2; v: vectorPelis);
var 
	i: rangoGeneros;
	max: real;
	cod: integer;
begin
	dl:= 0;
	for i:= 1 to dimF do begin
		max:= -1; //inicializo max cada vez q cambia de genero 
	    if v[i] <> nil then begin //me aseguro q tenga algun dato la lista antes de incrementar dl y buscar un maximo
			dl:= dl + 1;
			BuscarMaxi (v[i], max, cod);
			v2[dl].codpeli:= cod;
			v2[dl].puntaje:= max;
		end;
	end;
end;

//inciso C
procedure Seleccion (var v: vector2; dimL: rango2);
var
	i,j,pos: rangoGeneros;
	item: infoPeli;
begin
	for i:= 1 to dimL-1 do begin
		pos:= i;
		for j:= i+1 to dimL do
			if v[j].puntaje < v[pos].puntaje then
				pos:= j;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item
	end;
end;

//inciso D
procedure ImprimirMinYmax (v: vector2; dl: rango2);
begin
	//al estar ordenado de menor a mayor aprovecho q el vector es de acceso directo e imprimo solo el primer y ultimo valor
	writeln ('el mayor puntaje es para la peli: ', v[dl].codpeli, ' con ', v[dl].puntaje:0:1, ' puntaje promedio'); 
	writeln ('el menor puntaje es para la peli: ', v[1].codpeli, ' con ', v[1].puntaje:0:1, ' puntaje promedio');
end;


//programa principal
var
	dl: rango2;
	v: vectorPelis;
	v2: vector2;
begin
	CargarVector (v);
	CrearVector (v2, dl, v);
	Seleccion(v2, dl);
	ImprimirMinYmax (v2,dl);
end.




