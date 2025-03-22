program parcial;

const
     tope=100;z=10;

type
    st3=string[3];st12=string[12];stz=string[10];  //asumo que z es 10 para que funcione, por el error
    treg=record
      cod:st3;descrip:stz;imp:real;end;
    tvreg=array[1..tope]of treg;
    tregm=record
     apel:st12;categ:st3;cant:byte;prop:char; end;
    tmt=array[1..tope,1..6]of tregM;
    vpiso=array[1..tope]of byte;
    tregC=record
     apel:st12;
     piso:byte;
     end;
    tvc=array[1..tope]of tregC;

Procedure ArmarReg(var vreg:tvreg;var nreg:byte);
var
   arch:text; cod:st3;descrip:stz;imp:real;
   car:char;

begin
     nreg:=0; assign(arch,'categorias.txt');reset(arch);
     while not eof(arch) do
           begin
                nreg:=nreg+1;
                readln(arch,cod,car,descrip,imp);              //Falta aclarar en el parcial la longitud de la descripcion
                Writeln('Impuesto es',imp);
                vreg[nreg].cod:=cod;
                vreg[nreg].descrip:=descrip;
                vreg[nreg].imp:=imp;
           end;
     close(Arch);
end;

Procedure Inicializarmt(var mt:tmt;n:byte);

var
   i,j:byte;
begin
     for i:=1 to n do
         begin
              for j:=1 to 6 do
                  begin
                       mt[i,j].cant:=0;
                  end;
         end;

     for i:=1 to n do
         begin
              writeln();
         for j:=1 to 6 do
             write(mt[i,j].cant);

         end;
end;

Procedure armarmt(var mt:tmt;VAR n:byte);

var
   arch:text;i,piso,dep:byte;apel:st12; categ:st3;
   prop,car:char; cant:byte;
   j:byte;
begin
     assign(arch,'ocupantes.txt');reset(arch);
     readln(arch,n); inicializarmt(mt,n);
     writeln('N ES ',N);

     while not eof(arch) do
         begin
              readln(arch,piso,dep,car,apel,categ,cant,car,prop);  //Unicamete cuando hay un numero antes de un char o string uso el car
              mt[piso,dep].apel:=apel;            //Comprobar                         //Si hay un string despues de un string, no va el car
              mt[piso,dep].categ:=categ;
              mt[piso,dep].cant:=cant;
              mt[piso,dep].prop:=prop;
         end;




     writeln();
     writeln('Armar MT');
     for i:=1 to n do
         begin
              writeln();
         for j:=1 to 6 do
             write(mt[i,j].prop);

         end;
     close(Arch);
end;

Function InciA(mt:tmt;fila,col,max,cont:byte):byte;

begin
     if fila>0 then
        begin
             if cont<=3 then
                begin
                     if col>0 then
                        begin
                             if mt[fila,col].cant>0 then
                                begin
                                     cont:=cont+1;
                                end;
                             InciA:=InciA(mt,fila,col-1,max,cont);
                        end
                    else
                        inciA:=inciA(mt,fila-1,max,max,0)
                end
             else
                 InciA:=1+InciA(mt,fila-1,max,max,0);
        end
     else
         InciA:=0;
end;

{Function InciA(mt:tmt; fila, col, max, cont:byte):byte;
begin
    if fila = 0 then
    begin
        InciA := 0; // Caso base: cuando ya no quedan pisos
    end
    else
    begin
        if col = 0 then
        begin
            // Verificar si la cantidad de departamentos ocupados en el piso es más de la mitad
            if cont > (max div 2) then
            begin
                InciA := 1 + InciA(mt, fila - 1, max, max, 0); // Contar el piso y seguir con el anterior
            end
            else
                InciA := InciA(mt, fila - 1, max, max, 0); // Seguir con el anterior sin contar
        end
        else
        begin
            if mt[fila, col].cant > 0 then
            begin
                cont := cont + 1; // Incrementar el contador de departamentos ocupados
            end
            else

            InciA := InciA(mt, fila, col - 1, max, cont); // Continuar recorriendo los departamentos
        end;
    end;
end;   }


Function buscar(vreg:tvreg;nreg:byte;categ:st3):byte;

begin
     if categ=vreg[nreg].cod then
        buscar:=nreg
     else
         buscar:=buscar(vreg,nreg-1,categ);
end;

{function contar(mt:tmt;col:byte;pos:byte):byte;

begin
     if                   //Simplemente seria ir leyendo de forma recursiva la matriz, recorro cada piso, si categ es vreg[pos].categ entonces
     if col>0 then                 //Pregunta si mt[].prop es S, y ahi recien suma, un quilombo, Hay que ahcer de forma iterativa
        begin
             mt[]
        end;
end; }

Function InciB(mt:tmt;vreg:tvreg;nreg:byte;categ:st3):real;                 //Inci B esta bien solo el enunciado no esta claro que es lo que todos
                                                                     //Deben pagar, en realidad si esta claro, pero tengo que mirar las respuestas
var                                                          //para darme cuenta
   pos:byte;
begin
   pos:=buscar(vreg,nreg,categ);
   //writeln('CONTAR ES ',contar(mt,6,pos));
   InciB:=vreg[pos].imp*0.9;                   //contar(mt,6,pos)
end;

Procedure InciC(mt:tmt;n:byte; var vc:tvc; var nc:byte;dep:byte);

var
   i:byte;

begin
     nc:=0;
     for i:=1 to N do
         begin
               if mt[i,dep].prop='N' then
                  begin
                       nc:=nc+1;
                       vc[nc].piso:=i;
                       vc[nc].apel:=mt[i,dep].apel;
                  end;
         end;
end;

Procedure mostrar(vc:tvc;nc:byte);
var
   i:byte;
begin
     for i:=1 to nc do
         begin
              writeln(vc[i].piso);
              writeln(vc[i].apel);
              writeln();
         end;
end;

var
   vreg:tvreg;nreg,dep,n,nc:byte;
   mt:tmt; categ:st3; vc:tvc;

begin
     armarReg(vreg,nreg);
     armarMt(mt,N);
     writeln(nreg);
     writeln(InciA(mt,nreg,6,6,0),' cantidad de pisos');
     writeln('Ingrese La categoria'); readln(categ);
     writeln('Debe abonar',(InciB(mt,vreg,nreg,categ)):0:2);
     writeln('Ingrese el departamento');readln(dep);
     InciC(mt,n,vc,nc,dep);
     mostrar(vc,nc);

     readln();

end.


