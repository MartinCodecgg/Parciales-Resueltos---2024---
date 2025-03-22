program parcial;

const
     N=5;M=3;TOP=256;

type
    tmtA=array[1..5,1..3]of byte;
    tmtH=array[1..5,1..3]of REAL;
    Treg=record
      Niv:byte; Tot:byte; timE:real;
    end;
    Tvreg=array[1..TOP]of treg;

const
    Mta: tmta = (
        (4,5,15),
        (1,0,3),
        (10,3,9),
        (6,8,7),
        (2,1,3)
    );

    Mth: TmtH = (
        (9.5,15,20),
        (0,6,24),
        (15.3,10.5,9),
        (12,11,14),
        (4,1,6.5)
    );


Procedure InicializarVec(var vniv:tvreg;N:byte);
var
  i:byte;

begin
     for i:=1 to N do
         begin
              vniv[i].tot:=0;
              vniv[i].time:=0;
         end;
end;

Procedure InciA(mta:tmtA;mth:tmth;var vniv:tvreg; var a:byte;M:byte);

var
   i,j:byte;
begin
     a:=0;
     InicializarVec(vniv,N);
     for i:=1 to N do
         begin
              j:=1;
              a:=a+1;
              vniv[a].niv:=i;  //Esta va afuera
              While (mtA[i,j]<>0) and (J<=M) do    //En el de busqueda, solo es J<M ya que cuando j=M ya no debe seguir pasando pq llego al final
                    begin                              //En este caso necesitamos que entre a la tercer columna, asi que lo incluimos
                         writeln('entro while en nivel ',i);                     //J es la variable de control
                                //Las variables acum y cont son ineccesarias, sumar al vector directamente los valors de mt y mh en i,j


                         vniv[a].tot:=vniv[a].tot+mtA[i,j];
                         vniv[a].time:=vniv[a].time+mtH[i,j];
                         j:=j+1; //Recordar asignar esta varaible a lo ultimo, si me llega a tocar algo asi
                    end;                 //Siempre empieza en 1(afuera del while) y se pone a lo ultimo esta
              if mtA[i,j]=0 then
                 a:=a-1;


         end;

end;

Procedure Mostrar(vniv:tvreg;a:byte);
var
   i:byte;

begin
     for i:=1 to a do
         begin
              Writeln(vniv[i].niv,'  ',vniv[i].tot,'  ',vniv[i].time:8:2);
         end;
end;

Function InciB(mtA:tmtA;x,n,col,m:byte;cond:boolean):byte;

begin
     if cond and (col>0) then
        begin
             if mtA[N,COL]> x then
                begin
                     InciB:=1+InciB(mtA,x,n,col-1,m,false);
                end
             else
                 InciB:=InciB(mtA,x,n,col-1,M,true);
        end
     else
         begin
              if n>1 then
                 InciB:=InciB(mtA,x,n-1,m,m,true);
         end;
end;



var
  vniv:tvreg;
  x,a:byte;

begin
     InciA(mtA,mtH,vniv,a,M); Mostrar(vniv,a);
     Writeln('Ingrese X');readln(x);
     writeln('Inci B es ',InciB(mtA,x,n,m,m,true));
     readln();
end.

