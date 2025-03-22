program parcial;

const
     TOP=100;

type
    tmt=array[1..top,1..top]of char;
    treg=record
      col:byte; porcen:real;
    end;

    tv=array[1..3]of treg;

Procedure almacenar(var mt:tmt;var n,m:byte);
var
   arch:text;
   i,j:byte;
   val:char;
   car:char;
begin
     assign(arch,'matriz.txt');reset(arch);
     readln(arch,n,m);
     writeln(n,' ',m);
     for i:=1 to N do
         begin
              for j:=1 to M do
                  begin
                       read(Arch,val,car);    //Recordar si leo una matriz de char, considerar el ñoqui
                       mt[i,j]:=val;
                  end;
              readln(Arch);
         end;

     for i:=1 to N do
     begin
         for j:=1 to M do
             begin
                  write(mt[i,j]);
                  write(' ');
             end;
         writeln();
     end;
     close(Arch);
end;

Function Cantidad(mt:tmt;n,maxN,j,cont:byte):real;
begin
     if n=0 then
        cantidad:=cont/maxN
     else
         begin
              if mt[n,j]=upcase(mt[n,j]) then
                 begin
                      cont:=cont+1;
                 end;
              cantidad:=cantidad(mt,n-1,maxn,j,cont);
         end;
end;
 {
Procedure Insertar(var vec:tv;k,j:byte;val:real);
begin
     if (k>0) and (val>vec[k].porcen) then      //Verif
        begin
             insertar(vec,k-1,j,val);
        end
     else
         begin
              if (k=0) then
                 k:=k+1;
              if val>vec[k].porcen then
                 begin
                 vec[k].col:=vec[k+1].col;
                 vec[k].porcen:=vec[k+1].porcen;                               //verif
                 vec[k].col:=j;
                 vec[k].porcen:=val;
                 writeln('Se inserto ',j);
                 writeln('EN k=', k);
                 end;
         end;
end;   }

Procedure Insertar(var vec: tv; var k: byte; j: byte; val: real);
begin
     // Si k es mayor que 0 y el valor es mayor que el porcentaje en vec[k]
     writeln('k=3 es ',vec[3].porcen:8:2);
     if (k > 0) and (val > vec[k].porcen) then
     begin
         // Llamada recursiva para seguir buscando la posición correcta
         vec[k+1]:=vec[k];
         k:=k-1;
         Insertar(vec, k, j, val);
     end
     else
     begin
         // Desplazamos los valores para hacer espacio al nuevo
         vec[k+1].col := j;                    //Hay que saber bien el caso iterativo, y ahi lo adaptamos al iterativo
         vec[k+1].porcen := val;                //El while se lo escribe como llamando a la funcion recursivamente
         writeln('Se insertó columna ', j, ' con porcentaje ', val:0:2, ' en la posición k=', k);
         writeln('v en k+1 es' , vec[k+1].porcen:8:2);
         end;
     end;



Procedure InciA(mt:tmt;var vec:tv; N,M:byte);

var
   j,k:byte;  //verif
   val:real;
begin
     //Inicializo el vector
     for j:=1 to 3 do
         begin
             vec[j].porcen:=0;
             vec[j].col:=0;
         end;
     for j:=1 to M do
         begin
              val:=cantidad(mt,n,n,j,0);
              writeln('val es ',val:8:2);
              writeln('Col es ',j);
              k:=3;
              Insertar(vec,k,j,val);
         end;
end;

Procedure Mostrar(vec:tv;i:byte);

begin
     if i=1 then
        begin
             write(vec[i].col);
             write(vec[i].porcen:8:2);
             writeln(' ');
        end
     else
         begin
              writeln('Iteracion');
              mostrar(vec,i-1);
              write(vec[i].col);
              write(vec[i].porcen:8:2);
              writeln(' ');
         end;
end;


var
   mt:tmt;vec:tv; n,m,i:byte;
begin
     almacenar(mt,n,m);

     InciA(mt,vec,n,m);
     i:=3;
     mostrar(vec,i);
     readln();
end.

