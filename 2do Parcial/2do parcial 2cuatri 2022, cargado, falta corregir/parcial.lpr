program parcial;

const
     tope=100;
type
    st2=string[2];st30=string[30]; st8=string[8];
    treg=record
      cod:st2;nom:st30;dis:real;
    end;
    tvreg=array[1..tope]of treg;
    tmt=array[1..tope,1..10]of st8;
    tregC=record
      prov:st30;ran:byte;
    end;
    tvc=array[1..tope] of tregc;

Procedure ArmarVprov(var vprov:tvreg;var nprov:byte);
var
      arch:text; cod:st2; nom:st30; dis:real;
      car,car2:char;
begin
         assign(arch,'provincias.txt');reset(arch);
         nprov:=0;
         while not eof(Arch) do
               begin
                    nprov:=nprov+1;
                    readln(arch,cod,car,nom,car2,dis);
                    vprov[nprov].cod:=cod;
                    vprov[nprov].nom:=nom;
                    vprov[nprov].dis:=dis;
               end;
         close(arch);

end;

function Buscar(vprov:tvreg;nprov:byte;cod:st2):byte;
var
   i:byte;
begin
     i:=1;
     while (i<nprov) and (vprov[i].cod<>cod) do
           begin
                i:=i+1;
           end;
     if vprov[i].cod=cod then
        begin
             buscar:=i;
        end
     else
         buscar:=0;
end;

Procedure InicializarMt(var mt:tmt;nprov:byte);

var
   i,j:byte;
begin
     for i:=1 to nprov do
             for j:=1 to 10 do
                   mt[i,j]:='0';
end;

Procedure ArmarMt(var mt:tmt;vprov:tvreg; nprov:byte);
var
   arch:text; cod:st2; edad:byte; dni:st8;
   car,car2:char; pos:byte;
begin
     inicializarMt(mt,nprov);
     while not eof(arch) do
           begin
                readln(Dni,car,edad,car2,cod);
                pos:=buscar(vprov,nprov,cod);
                mt[pos,edad div 10]:=dni;
           end;
           close(arch);
end;

Function InciA(mt:tmt;col:byte;pos:byte):byte;

begin
     if mt[pos,col]='0' then
        begin
             InciA:=1+InciA(mt,col-1,pos);
        end;
end;

Function InciB(mt:tmt;vprov:tvreg;nprov,r,t:byte):st30;
var
   min:word; acum:word;
   i,j:byte;
begin
     min:=65000;
     for i:=1 to nprov do
         begin
              acum:=0;
              for j:=(r div 10) to (t div 10) do
                  begin
                       if mt[i,j]='0' then
                       acum:=acum+1;
                  end;
              if acum<min then
                 begin
                      min:=acum;
                      InciB:=vprov[i].nom;
                 end;
         end;
end;

function Suma(mt:tmt;nprov,col,max:byte):word;
begin
     if nprov>0 then
        begin
             if col>0 then
                begin
                     if mt[nprov,col]<>'0' then
                     suma:=1+suma(mt,nprov,col-1,max);
                end;
        end
     else
         begin
              if mt[nprov,col]<>'0' then
              suma:=1+suma(mt,nprov-1,max,max);
         end;
end;
{
Procedure InciC(mt:tmt;vprov:tvreg;nprov:byte;var nc:byte;var Vc:tvc;porcen:real;col,max:byte);

begin
     if nprov>0 then
        begin
             if col>0 then
                begin
                     if mt[nprov,col]>porcen then
                        begin
                             nc:=nc+1;
                             vc[nc]:=prov:=vprov[nprov].nom;
                             vc[nc].ran:=col;                  //MAL ALMACENADOS, DEBERIA GUARDAR EN CADA CELDA DE LA MATRIZ, UN Registro QUE CONTENGA LA CANTIDAD DE INSCRIPTOS
                        end;                                       //Y UN VECTOR QUE CONTENGA LOS DNI, LA CANTIDAD DE INSCRIPTOS COINCIDE CON EL AMIGO DEL VECTOR
                    InciC(mt,vprov,nprov-1,nc,v,porcen,max,max);
                end;                                                        //SI POR QUE SINO CADA ALUMNO, QUE VIENE EN LA MISMA PROVIENCIA Y RANGO DE EDAD, PISARIA AL ANTERIOR
        end;
end;

      }

var
      vprov:tvreg;vc:tvc;         mt:tmt;
      nprov,pos,r,t:byte; porcen:real;              x:st2; nreg:byte;
begin
     armarVprov(vprov,nprov);
     armarMt(mt,vprov,nprov);
     writeln('Ingrese X');readln(x); pos:=buscar(vprov,nreg,x);
     if pos<>0 then
        begin
             writeln('La cantidad es ',inciA(mt,10,pos));
        end
     else
         writeln('No se encontro');
     writeln('Ingrese R y T');readln(r,t);
     writeln('La provincia es ',InciB(mt,vprov,nprov,r,t));
     porcen:=suma(mt,nprov,10,10);
     //InciC(mt,vprov,nprov,0,vc,porcen,10,10);
     readln();
end.

