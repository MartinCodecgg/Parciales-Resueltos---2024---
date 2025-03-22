program parcial;
const
     TOP=100;

type
    st5=string[5];
    treg=record
      cod:st5;gen:byte;prem:char;end;             //1) En record se usa dos puntos no igual
    tvreg=array[1..top]of treg;
    tmt=array[1..top,1..top]of word;
    tregB=record
      cod:st5;gen:byte;  end;    //2) y 3)
      tvregB=array[1..top]of tregB;
      tvc=array[1..6]of byte;

Procedure Almacenar(var mt:tmt;var vreg:tvreg;var n,nreg:byte);

var
   arch:text;cod:st5;gen,i:byte;can:word;
   car,prem:char;

   j:byte;
begin
     assign(arch,'ranking.txt');reset(arch);
     readln(arch,N); nreg:=0;
     while not eof(arch) do
           begin
                nreg:=nreg+1;
                read(arch,cod,gen);
                vreg[nreg].cod:=cod;              //Falto cargar el vector de registros
                vreg[nreg].gen:=gen;
                for i:=1 to N do
                    begin
                         read(Arch,can);
                         mt[nreg,i]:=can;
                    end;
                readln(arch,car,prem);
                if prem='N' then
                   nreg:=nreg-1;
           end;
               for i:=1 to nreg do
                   begin
                        for j:=1 to n do
                            begin
                                 write(mt[i,j],'  ');
                            end;
                        writeln();
                   end;
               close(arch);
end;

Function InciA(mt:tmt;N,nreg:byte;T:word):byte;
var
   cond:boolean; i,j,cont:byte;
begin
     cont:=0;
     for i:=1 to nreg do
         begin
              j:=1;
              cond:=true;
              writeln(n,nreg);
              while (j<N) and (mt[i,j]>T) do        //3) error garrafal es j<n no j<=n
                    begin
                         j:=j+1;
                         writeln('iteracion primer while');
                    end;
              if mt[i,j]<T then
                 begin
                      cond:=false;
                      writeln('Se puso en false');
                 end;
              if cond then
                 begin
                      cont:=cont+1;
                 end;
         end;
     InciA:=cont;
end;

Function Promedio(mt:tmt;n,nreg:byte):real;
var
   i,j:byte; acum:word;
begin
     for i:=1 to Nreg do
         begin
              for j:=1 to N do
                  begin
                       acum:=acum+mt[i,j];
                  end;
         end;
     Promedio:=acum/(n*nreg);
end;

Function MayorDur(mt:tmt;i,n:byte):word;

var
   max:word; j:byte;
begin
     max:=0;
     for j:=1 to N do
         begin
              if mt[i,j]>max then
                 begin
                      max:=mt[i,j]
                 end;
         end;
     mayorDur:=max;
end;

Procedure InciB(mt:tmt; vreg:tvreg; n,nreg:byte; var vb:tvregB;
                        var nb:byte);
var
   prom:real; i:byte; mayor:word;
begin                             nb:=0;
     prom:=promedio(mt,n,nreg);
     writeln('prom es',prom:8:2);
     for i:=1 to nreg do
         begin
              mayor:=mayorDur(mt,i,n);
              writeln('mayor es ',mayor);
              if mayor>prom then
                 begin
                      writeln('ITERO WHILE');
                      nb:=nb+1;
                      vb[nb].cod:=vreg[i].cod;
                      vb[nb].gen:=vreg[i].gen;
                 end;
         end;
end;

Procedure MostrarVb(vb:tvregb;nb:byte);
var
   i:byte;
begin
     for i:=1 to nb do
         begin
              write(vb[i].cod,' ',vb[i].gen);
              writeln();
         end;
end;

Procedure InicializarVc(vc:tvc);
var
   i:byte;
begin
     for i:=1 to 6 do
         vc[i]:=0;
end;

Procedure  InciC(mt:tmt;vreg:tvreg;n,nreg:byte;var vc:tvc);
var
    i,gen:byte;
begin
     InicializarVc(vc);
     writeln(n,' ',nreg);                                //Recordar si armo un vector temporal pero quiero mostrarlo en otro procedimiento
     for i:=1 to nreg do                                   //Lo debo pasar por var
         begin
              gen:=vreg[i].gen;
              writeln('gen del vreg es',vreg[i].gen);
              vc[gen]:=vc[gen]+N;
         end;
end;

Procedure MostrarC(vc:tvc);
var
   i:byte;
begin
     for i:=1 to 6 do
         begin
              writeln('Hay ',vc[i],' canciones del ',i,' genero');
         end;
end;

//MAIN
var
   vreg:tvreg;mt:tmt;t:word;   n,nreg,nb:byte;   vb:tvregb;   vc:tvc;

begin
     almacenar(mt,vreg,n,nreg);

     writeln('Inciso A');
     writeln(n,' ',nreg);
     writeln('Ingrese T');readln(T);
     writeln(InciA(mt,n,nreg,T),' Interpretes');

     writeln('Inciso B');
     InciB(mt,vreg,n,nreg,vb,nb);
     writeln('se muestra vb');
     mostrarvB(vb,nb);
     writeln('ejercicio C');
     InciC(mt,vreg,n,nreg,vc);
     mostrarC(vc);
     readln();
end.
