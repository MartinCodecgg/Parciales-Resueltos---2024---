program ejerc1;

uses
    sysutils;

const
     TOP=100;DOLAR=360;IMP=25;TOTAL=100;DESC=0.95;

Type
    st10=string[10];
    treg=record
      tipo:st10;pre:real;end;
    tvreg=array[1..TOP]of treg;
    Tmt=array[1..TOP,1..10]of word;
    tvsilo=array[1..10]of real;
    tregB=record
      silo:byte;imp:real;end;
    tvregB=array[1..10]of tregB;

function Buscar(vreg:tvreg;tipo:st10;nreg:byte):byte;

var
  j:byte;

begin
     j:=1;
     while (j<nreg) and (tipo<>vreg[j].tipo) do
           begin
                j:=j+1;
           end;
     if tipo=vreg[j].tipo then
        buscar:=j
     else
         buscar:=0;
end;

Procedure InicializarMt(var mt:tmt;nreg:byte);
var
  i,j:byte;
begin
     for i:=1 to nreg do
         begin
              for j:=1 to 10 do
                  begin
                       mt[i,j]:=0;
                  end;
         end;
end;

Procedure InicializarSilo(var vsilo:tvsilo);
var
  i:byte;
begin
     for i:=1 to 10 do
              Vsilo[i]:=0;


end;

Procedure ArmarVreg(var vreg:tvreg; var nreg:byte);

var
   arch:text; pre:real; tipo:st10;
begin
     assign(arch,'cereales.txt');reset(arch); nreg:=0;

     while not eof(arch) do
           begin
                nreg:=nreg+1;
                readln(arch,tipo,pre);
                tipo:=trim(tipo);
                vreg[nreg].tipo:=tipo;
                vreg[nreg].pre:=pre;
           end;
     close(arch);
end;


Procedure ArmarMt(var mt:tmt; var vreg:tvreg;nreg:byte;var vsilo:tvsilo);
var
   arch:text; silo:byte; tipo:st10;ton:word;    pos:byte;  car:char;

   i,j:byte;
begin
     assign(arch,'exportaciones.txt');reset(arch);
     InicializarSilo(vsilo); InicializarMT(mt,nreg);

     while not eof(arch) do
           begin
                readln(arch,silo,car,car,tipo,ton);
                tipo:=trim(tipo);
                pos:=buscar(vreg,tipo,nreg);
                mt[pos,silo]:=mt[pos,silo]+ton;
                vsilo[silo]:=vsilo[silo]+ton;
           end;
for i:=1 to nreg do
         begin
         for j:=1 to 10 do
             write(mt[i,j],' ');
         writeln();
         end;
     close(arch);
end;

Function InciA(mt:tmt;vreg:tvreg;nreg:byte;c:st10):byte;
var
   cont,i,pos:byte;
begin
     pos:=buscar(vreg,c,nreg);
     writeln('Pos es ',pos);
     cont:=0;
     for i:=1 to 10 do
         begin
              if mt[pos,i]<>0 then
                 cont:=cont+1;
         end;
     InciA:=cont;
end;

Function Precio(mt:tmt;vreg:tvreg;nreg,j:byte):real;
var
  acum:real;   i:byte;
begin
     acum:=0;
     for i:=1 to nreg do
         begin
              acum:=acum+mt[i,j] *vreg[i].pre;
         end;
     Precio:=acum*DOLAR;
end;

Procedure InciB(mt:tmt;nreg:byte;vsilo:tvsilo;var vb:tvregB;var nb:byte; z:word; vreg:tvreg);

var
   pesos:real;  j:byte;
begin
     for j:=1 to 10 do
         begin
              if vsilo[j]>z then
                 begin
                      nb:=nb+1;
                      vb[nb].silo:=j;
                      pesos:=PRECIO(mt,vreg,nreg,j);
                      if pesos >total then
                         pesos:=pesos*1.25
                      else
                          pesos:=pesos*0.95;
                      vb[nb].imp:=pesos;
                 end;
         end;
end;

Procedure Listar(vb:tvregB;nb:byte);
var
   I:byte;
begin
     for i:=1 to nb do
         begin
              writeln(vb[i].silo,' ',vb[i].imp:8:2);
         end;
end;




var
  mt:tmt;vreg:tvreg;c:st10;z:word;
  vsilo:tvsilo; vb:tvregB;nb,nreg,A:byte;

begin
     armarVreg(vreg,nreg);
     writeln('nreg es',nreg);
     armarMt(mt,vreg,nreg,vsilo);
     writeln('Ingrese C');readln(C);
     A:=InciA(mt,vreg,nreg,c);
     if A<>0 then
        writeln('Se guarda en ',A,' silos')
     else
         writeln('No se guarda en ningun silo');
     writeln('Ingrese Z');readln(Z);
     InciB(mt,nreg,vsilo,vb,nb,z,vreg);
     Listar(vb,nb);
     readln();
end.

