program parcial;

const
     tope=20;                       Z=100;
type
    st3=string[3];st10=string[10]; stz=string[Z];
    tvcanal=array[1..tope]of st3;
    treg=record
      codigo:byte;
      descrip:st10;end;
    tvreg=array[1..tope]of treg;
    tmt=array[1..tope,1..tope]of word;
    tregC=record
      cadena:st3;descrip:st10;end;
    tvc=array[1..tope]of TregC;

Procedure
         armarVcanal(var vcanal:tvcanal;var ncanal:byte);
var
   arch:text; canal:st3;

begin
     assign(arch,'cadnoticias.txt');reset(arch);
     ncanal:=0;
     while not eof(arch) do
           begin
                ncanal:=ncanal+1;  readln(arch,canal);
                vcanal[ncanal]:=canal;
           end;
           close(arch);
end;

Procedure ArmarReg(var vreg:tvreg;var nreg:byte);

var
   arch:text; codigo:byte; descrip:st10; cad:char;

begin
     assign(Arch,'tiponoticias.txt');reset(arch);
     nreg:=0;
     while not eof(arch) do
           begin
                nreg:=nreg+1;
                readln(arch,codigo,cad,descrip);
                vreg[codigo].codigo:=codigo;
                vreg[codigo].descrip:=descrip;
           end;
           close(arch);
end;

Procedure InicializarMt(var mt:tmt;ncanal,nreg:byte);

var
   i,j:byte;

begin
     for i:=1 to nreg do
         begin
              for j:=1 to ncanal do
                  begin
                       mt[i,j]:=0;
                  end;
         end;
end;

Function Buscar(vcanal:tvcanal;ncanal:byte;canal:st3):byte;
var
   i:byte;
begin
     i:=1;
     while canal<>vcanal[i] do
           begin
                i:=i+1;
           end;
     buscar:=i;
end;

Procedure ArmarMat(var mt:tmt; fila,col,max:byte;vcanal:tvcanal; vreg:tvreg; ncanal:byte);

var
   arch:text; canal:st3; codigo:byte; nota:word;
   cad:char; pos:byte;

begin
     assign(arch,'coberturas.txt'); reset(arch);
     while not eof(arch) do
           begin
                readln(arch,canal,cad,codigo,nota);
                pos:=buscar(vcanal,ncanal,canal);
                mt[pos,codigo]:=mt[pos,codigo]+nota;
           end;
               close(arch);
end;

Procedure InciA(mt:tmt;fila,col:byte;var cadena:st3;var descrip:st10;max:word; nreg:byte;vreg:tvreg;vcanal:tvcanal);
                   //Preguntar porque sin var no funciona, deberia funcionar igual
begin
     if mt[fila,col]>max then                              //Se debe validar las filas y columnas
        begin
             max:=mt[fila,col];descrip:=vreg[col].descrip;
             cadena:=vcanal[fila];
             //writeln(cadena);
             //writeln(descrip);
        end;
     if fila>0 then
        begin
             if col>1 then
                begin
                     InciA(mt,fila,col-1,cadena,descrip,max,nreg,vreg,vcanal);
                end
             else
            InciA(mt,fila-1,nreg,cadena,descrip,max,nreg,vreg,vcanal);
        end
end;


{Procedure InciA(var mt:tmt;fila,col:byte; cadena:st3; descrip:st10;var max:word; nreg:byte;vreg:tvreg;vcanal:tvcanal);
begin
     if mt[fila,col] > max then
        begin
             max := mt[fila,col];
             descrip := vreg[col].descrip;
             cadena := vcanal[fila];
               writeln(cadena);
             writeln(descrip);
        end;

     if fila > 0 then
        begin
             if col > 0 then
                begin
                     InciA(mt, fila, col-1, cadena, descrip, max, nreg, vreg, vcanal);
                end
             else
                InciA(mt, fila-1, nreg, cadena, descrip, max, nreg, vreg, vcanal);
        end;
end;  }

function suma(mt:tmt;pos,nreg:byte):word;

begin
     if nreg>0 then
     suma:=mt[pos,nreg]+suma(mt,pos,nreg-1);
end;

function Buscar2(vcanal:tvcanal;ncanal:byte;x:st3):byte;

begin
     if x=vcanal[ncanal] then
        begin
             buscar2:=ncanal;
        end
     else
            buscar2:=buscar2(vcanal,ncanal-1,x);
end;

Function InciB(pos:byte;mt:tmt;nreg:byte):real;

begin
     InciB:=(mt[pos,3]*100)/suma(mt,pos,nreg);
end;

Procedure InciC(mt:tmt;vcanal:tvcanal;vreg:tvreg;vc:tvc;nvc:byte;ncanal,nreg:byte);

var
   i,j:byte;
begin
     for i:=1 to ncanal do
         begin
              for j:=1 to nreg do
                  begin
                       if mt[i,j]=0 then
                          begin
                               nvc:=nvc+1;
                               vc[nvc].cadena:=vcanal[i];
                               vc[nvc].descrip:=vreg[j].descrip;
                          end;
                  end;
         end;
     for i:=1 to nvc do
         begin
                       writeln(vc[i].cadena);
                       writeln(vc[i].descrip);
         end;
end;

var
   vcanal:tvcanal;vreg:tvreg; mt:tmt;
   ncanal,nreg,pos,nvc:byte; vc:tvc;
   cadena:st3; descrip:st10; max:word;
   x:st3;

begin
     armarVcanal(vcanal,ncanal);
     armarreg(vreg,nreg);inicializarMt(mt,ncanal,nreg);
     ArmarMat(mt,ncanal,nreg,nreg,vcanal,vreg,ncanal);

     max:=0;
     InciA(mt, ncanal, nreg, cadena, descrip, max, nreg, vreg, vcanal);

     writeln(cadena);writeln(descrip);


     writeln('Ingrese X'); Readln(x); pos:=Buscar2(Vcanal,ncanal,x);
     writeln('El porcentaje fue',InciB(pos,mt,nreg):0:2);
     InciC(mt,vcanal,vreg,vc,nvc,ncanal,nreg);
     readln();
end.


begin
end.

