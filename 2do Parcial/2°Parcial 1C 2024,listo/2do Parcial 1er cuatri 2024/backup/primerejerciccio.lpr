program primerejerciccio;

const
     rubros=256;
type
    St5=string[5];
    tvdias=array[1..7]of real;
    treg=record
      nom:st5;
      vdias:tvdias;
    end;
    tvreg=array[1..rubros]of treg;
    tregB=record
      nom:st5;
      monto:real;
    end;
    tvregB=array[1..rubros]of tregB;

    function buscar(rubro:st5;nrub:byte;vreg:tvreg):byte;
    var
       i:byte;
    begin
         i:=1;
         while vreg[i].nom<>rubro do
               begin
                    i:=i+1;
               end;
         if vreg[i].nom=rubro then
            buscar:=i;

    end;

    Procedure InicializarDias(var vreg:tvreg;nrub:byte);
    var
       i,j:byte;
    begin
         for i:=1 to nrub do
             begin
                  for j:=1 to 7 do
                      begin
                           vreg[i].vdias[j]:=0;
                      end;
             end;
    end;


  Procedure ArmarVec(var vreg:tvreg;var nrub:byte);

  var
     arch1,arch2:text; rubro:st5; dia,pos:byte;
     monto:real;

  begin
       assign(arch1,'Rubros.txt'); reset(arch1);
       assign(Arch2,'Ventas.txt'); reset(arch2);
       nrub:=0;

       while not eof(arch1) do
             begin
                  nrub:=nrub+1;
                  readln(arch1,rubro);
                  vreg[nrub].nom:=rubro;

             end;
       InicializarDias(vreg,nrub);
       while not eof(arch2) do
             begin
                  readln(arch2,rubro,dia,monto);
                  pos:=buscar(rubro,nrub,vreg);                 //Recorda para las funciones hay que llamar y asignar
                  vreg[pos].vdias[dia]:=vreg[pos].vdias[dia]+monto;
             end;
       close(arch1);close(arch2);
  end;

Function InciA(vreg:tvreg;nrub:byte):st5;

var
   i,j:byte; comp,prom,acum:real;
begin
     comp:=9999;
     for i:=1 to nrub do
         begin
              acum:=0;
              for j:=1 to 5 do
                  begin
                       acum:=vreg[i].vdias[j]+acum;
                  end;
              prom:=(acum/5);
              if prom<comp then
                 begin
                      comp:=prom;
                      InciA:=vreg[i].nom;
                 end;
         end;

end;

Procedure InciB(vreg:tvreg;nrub:byte;var vregB:tvregB; var nv2:byte; x:real);
var
   i,j:byte; acum,acum2:real;

begin
     nv2:=0;
     for i:=1 to nrub do
         begin
              acum:=0; acum2:=0;
              for j:=1 to 7 do
                  begin
                       acum:=acum+vreg[i].vdias[j];
                       if (j=6) or (j=7) then
                          begin
                               acum2:=acum2+vreg[i].vdias[j];
                          end;
                  end;
              if acum>x then
                 begin
                      nv2:=nv2+1;
                      vregB[nv2].nom:=vreg[i].nom;
                      vregB[nv2].monto:=acum2;
                 end;
         end;

     for i:=1 to nv2 do
         begin
              write(vregb[i].nom,' ',(vregB[i].monto):0:2);
              writeln();
         end;
end;

var
   vreg:tvreg; x:real; vregB:tvregB;
   nrub,nv2:byte;
begin
     ArmarVec(vreg,nrub);

     writeln('El rubro como menos venta promedio es ',InciA(vreg,nrub));
     Writeln('Ingrese X');readln(x);
     InciB(vreg,nrub,vregB,nv2,x);
     readln();

end.
