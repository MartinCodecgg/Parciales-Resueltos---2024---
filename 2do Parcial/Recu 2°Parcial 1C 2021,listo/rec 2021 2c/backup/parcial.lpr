program parcial;

const
     TOP=200;

type
    st4=string[4];st10=string[10];
    treg=record
      tipo:st10;pre:real;end;
    tvreg=array[1..top]of treg;
    tmt=array[1..top,1..top]of real;
    tvsurt=array[1..top]of st4;
    tregC=record
      surt:st4; tipo:st10; end;
    tvregC=array[1..TOP]of tregC;

Procedure Inicializar(var mt:tmt;nreg:byte);

var
   i,j:byte;

begin
     for i:=1 to Top do
         begin
              for j:=1 to nreg do
                  begin
                       mt[i,j]:=0;
                  end;
         end;
end;

Function Suma(mt:tmt;vreg:tvreg;n,nreg:byte):real;

begin
     if n=0 then
        suma:=0
     else
         begin
              suma:=mt[n,nreg]*vreg[nreg].pre+suma(mt,vreg,n-1,nreg);
         end;
end;

Function Buscar2(vreg:tvreg;nreg:byte;tipo:st10):byte;
var
  i:byte;

begin
     i:=1;
     while(i<nreg) and (vreg[i].tipo<>tipo) do
                   begin
                        i:=i+1;
                   end;
     buscar2:=i;
end;

Procedure ArmarReg(var vreg:tvreg;var nreg:byte);
var
   arch:text; tipo:st10; pre:real;
begin
     assign(arch,'combustible.txt');reset(arch);     //me olvide que en la primera linea venia N, asi que la borro del archivo
     nreg:=0;
     while not eof(Arch) do
           begin
                nreg:=nreg+1;
                readln(Arch,tipo,pre);
                vreg[nreg].tipo:=tipo;
                vreg[nreg].pre:=pre;
           end;
end;

Procedure LeerVentas(var mt:tmt;var vreg:tvreg;var vsurt:tvsurt;nreg:byte;var n:byte;var total:real);
var
   arch:text; surt:st4; i:byte; venta:real;
begin
     assign(arch,'ventas.txt');reset(arch); N:=0;

     While not eof(Arch) do
           begin
                n:=n+1;
                read(arch,surt); vsurt[n]:=surt;
                for i:=1 to nreg do
                    begin
                         read(Arch,venta);
                         mt[n,i]:=mt[n,i]+venta;
                         total:=total+venta*vreg[i].pre;
                    end;
                readln(arch);
           end;
end;

Function Buscar(c:st4;vsurt:tvsurt;n:byte):byte;
var
   i:byte;
begin
     i:=1;
     while (i<n) and (vsurt[i]<>C) do
           begin
                i:=i+1;
           end;
     if vsurt[i]=C then
        buscar:=i
     else
         buscar:=0;
end;

Function InciA(mt:tmt;vreg:tvreg;nreg,pos:byte):byte;
var
   temp:byte;
begin
     if nreg=1 then
        inciA:=1
     else
         begin
              temp:=InciA(mt,vreg,nreg-1,pos);
              if mt[pos,nreg]>temp then
                 InciA:=nreg
              else
                  InciA:=Temp;
         end;
end;

Procedure InciB(mt:tmt;n,nreg:byte;vreg:tvreg;total:real);

begin
        if nreg=1 then
           writeln('El porcentaje para el tipo ',vreg[nreg].tipo,' es ',(((suma(mt,vreg,n,nreg)*100)/total)):8:2)
        else
         begin
              InciB(mt,n,nreg-1,vreg,total);     //NO HACE FALTA SUMAR UNO A NREG AL LLAMAR A INCIB EN EL MAIN, PORQUE AUNQUE EN ESTA LINEA, EN LA
              writeln('El porcentaje para el tipo ',vreg[nreg].tipo,' es ',(((suma(mt,n,nreg))*100/total)):8:2);
         end;                                       //PRIMERA FUNCIO, NO ESCRIBA, TERMINA ESCRIBIENDO DESPUES, NUNCA HAY QUE SUMAR O RESTAR
end;                                                               //sIEMPRE QUE LO HAGO DA ERROR


// Función Suma para calcular la suma de una columna específica
{
Function Suma(mt: tmt; n, nreg: byte): real;
begin
    if n = 0 then
        Suma := 0
    else
    begin
        Suma := mt[n, nreg] + Suma(mt, n - 1, nreg);
    end;
end;

Procedure InciB(mt: tmt; n, nreg: byte; vreg: tvreg; total: real);
begin
    // Base de la recursión: cuando nreg = 1
    if nreg = 1 then
    begin
        writeln('El porcentaje para el tipo ', vreg[nreg].tipo, ' es ', (((Suma(mt, n, nreg)) / total))*100:0:2);
    end
    else
    begin
        InciB(mt, n, nreg - 1, vreg, total);
        writeln('El porcentaje para el tipo ', vreg[nreg].tipo, ' es ', (((Suma(mt, n, nreg)) / total))*100:0:2);
    end;
end;              }


Procedure InciC(mt:tmt;vreg:tvreg;n,nreg:byte;pos:byte;x:real;var vc:tvregC;var nc:byte;vsurt:tvsurt);
var
   i,j:byte; acum:real;
begin
     for i:=1 to n do                                           //De un tipo de combustible se referia a que supere en ventas a x en cuaquier tipo
         begin                                                     //no que debia ingresar el tipo
              acum:=0;                                              //En el parcial, estara claro, que es dato ingresado por teclado y que no
              for j:=1 to nreg do
                  begin
                       acum:=acum+mt[i,j];
                  end;
              if acum>x then
                 begin
                      nc:=nc+1;
                      vc[nc].surt:=vsurt[i];
                      vc[nc].tipo:=vreg[pos].tipo;
                 end;
         end;
end;

Procedure Mostrar(vc:tvregC;nc:byte);
var
   i:byte;
begin
     for i:=1 to nc do
         begin
              writeln(vc[i].surt,' ',vc[i].tipo);
         end;
end;



var
  vreg:tvreg;nreg,n:byte;
  mt:tmt;x:real;tipo:st10;total:real; vsurt:tvsurt;   c:st10;   pos:byte;   vc:tvregC; nc:byte;

begin
     total:=0;
     ArmarReg(vreg,nreg);
     leerVentas(mt,vreg,vsurt,nreg,n,total);
     writeln('Ingrese C');readln(c);
     Writeln('Inciso A');
     pos:=buscar(C,vsurt,n);
     if pos<>0 then
        writeln('El tipo fue ',Vreg[InciA(mt,vreg,nreg,pos)].tipo)
     else
         writeln('No existe');
     Writeln('Inciso B');
     Writeln('valores que le paso a inci B son ',n,nreg,total:8:2);
     InciB(mt,n,nreg,vreg,total);
     Writeln('Inciso C');
     writeln('Ingrese X,tipo');readln(x,tipo);
     pos:=buscar2(vreg,nreg,tipo);
     InciC(mt,vreg,n,nreg,pos,x,vc,nc,vsurt);
     mostrar(vc,nc);
     readln();
end.

