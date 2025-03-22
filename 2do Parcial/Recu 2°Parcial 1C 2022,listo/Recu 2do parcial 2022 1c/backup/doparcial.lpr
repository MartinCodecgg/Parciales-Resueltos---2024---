program doparcial;

const
     TOPE=50;
type
    st8=string[8];
    TregRub=record
      rub:st8;imp:real;
    end;
    tvrub=array[1..tope]of tregRub;
    tvimp=array[1..tope]of real;
    tregmt=record
      total:real;av:byte;vimp:tvimp;
    end;
    tmt=array[1..tope,1..tope]of tregmt;

Procedure InicializarMT(var mt:tmt;n,m:byte);
var
   i,j,k:byte;
begin
     for i:=1 to N do
         begin
              for j:=1 to N do
                  begin
                       for k:=1 to tope do
                           begin
                                mt[i,j].vimp[k]:=0;

                           end;
                       mt[i,j].total:=0;
                       mt[i,j].av:=0;
                  end;
         end;
end;

Procedure Almacenar(var mt:tmt;var n,m:byte; var vrub:tvrub    );
var
  arch:text; rub:st8; imp:real;
  cod,i,j:byte;
begin
     assign(arch,'datos.txt');reset(Arch);
     readln(arch,n,m);         Inicializarmt(mt,n,m);

     for i:=1 to M do
         begin
              readln(arch,rub,imp);
              vrub[i].rub:=rub;
              vrub[i].imp:=imp;
         end;
     for i:=1 to N do
         begin
              read(arch,cod,imp);                  //CUESTION, para evitarnos este error siempre que tengamos la condicion de corte en la linea, y no que llegue al fin
              while (cod<>0) or (imp<>0) do     //De archivo, debemos poner un read antes del while, y uno al final dentro del while,
                    begin                           //Y otro que cuando salga, saltee la linea
                                                //Incluso si el archivo es aun mas diferente, probar mentalmente que funciona
                         mt[i,cod].total:=mt[i,cod].total+imp;
                         mt[i,cod].av:=mt[i,cod].av+1;
                         mt[i,cod].vimp[mt[i,cod].av]:=mt[i,cod].vimp[mt[i,cod].av]+imp;
                         read(arch,cod,imp);

                    end;
              readln(arch);
         end;
             for i:=1 to N do
                 begin
                      for j:=1 to M do
                          begin
                          write(mt[i,j].total:8:0);
                          write(' ');
                          end;
                      writeln();
                 end;
              close(Arch);
end;

Function Validar(mt:tmt;i,j,av:byte;x:real;cond:boolean):boolean;

begin
     if (av=0) then             //En lo posible poner la condicion base al principio y un Else, asi queda claro y limpio
         validar:=cond
     else                                  //Codigo EFICIENTE
        begin
             if mt[i,j].vimp[av]>x then
                begin
                     validar:=false;                        //El codigo es ANTERIOIR ES ineficiente, la parte de and cond then es al dope
                end
             else                                           //Cuando cond es false directamente no llama mas asigna a validar false
             validar:=validar(mt,i,j,av-1,x,cond);
        end
end;

Procedure Completar(var R:st8);

begin
while length(r)<8 do
      begin
           writeln('entro 2do while');
           r:=r+' ';
      end;
end;

Function Buscar(vrub:tvrub;M:byte;R:st8):byte;

begin
     if M=0 then
        buscar:=0
     Else
         Begin
              if vrub[M].rub=R then
                 buscar:=M
              else
                  Buscar:=Buscar(vrub,M-1,r);
         end;
end;

Function InciA(mt:tmt;n,cont:byte;acum:real;pos:byte):real;

begin
     if n=0 then
        inciA:=(acum/cont)
     else
         begin
              cont:=cont+1;       //Por ello es vital la prueba de escritorio, es cont+1 no hay que sumar el av aqui
              acum:=acum+mt[n,pos].total;
              InciA:=InciA(mt,n-1,cont,acum,pos);
         end;
end;

Procedure InciB(mt:tmt;vrub:tvrub;m,caja:byte;var max:real; var rubro:st8);

begin

     if mt[caja,m].total>max then
        begin
             max:=mt[caja,m].total;
             rubro:=vrub[m].rub;
        end;
        if m>1 then
     InciB(mt,vrub,m-1,caja,max,rubro);
end;

Function InciC(mt:tmt;i,j,n:byte;cond:boolean;x:real):byte;

begin
    if j=0 then
       InciC:=0
    else
    begin
     if cond then
        begin
             if i>0 then
                begin                                               //Preguntar Eficiencia del codigo
                     writeln(mt[i,j].av);
                     if validar(mt,i,j,mt[i,j].av,x,true) then
                        begin
                             writeln('Se encontro un cero, la columna no es valida');
                             cond:=false;
                        end;
                     InciC:=InciC(mt,i-1,j,n,cond,x);
                end
             else                                     //No se puede añadir condiciones de if j>1, porque si da false y esta en la primera columna
                 InciC:=1+InciC(mt,n,j-1,n,true,x);          //no conta esa columna como valida
        end
     else
         begin
              InciC:=inciC(mt,n,j-1,n,true,x);
         end;
    end;
end;
{
Function Validar(mt:tmt; i, j, av: byte; x: real; var cond: boolean): boolean;
begin
    if (av > 0) and cond then
    begin
        if mt[i, j].vimp[av] > x then
            cond := false;
        Validar := Validar(mt, i, j, av-1, x, cond);
    end
    else
        Validar := cond;
end;    }
 {
Function InciC(mt:tmt; i, j, m: byte; cond: boolean; x: real): byte;
begin
    if i = 0 then
        InciC := 0
    else if j = 0 then
        InciC := InciC(mt, i-1, m, m, true, x)  // Pasar a la siguiente fila
    else if cond then
    begin
        if Validar(mt, i, j, mt[i,j].av, x, true) then
        begin
            writeln('Resulto true validar');
            cond := false;
        end;
        InciC := InciC(mt, i, j-1, m, cond, x);
    end
    else
    begin
        InciC := 1 + InciC(mt, i-1, m, m, true, x);
    end;
end; }

Var
  mt:tmt;vrub:tvrub; r:st8;
  n,m,pos,caja:byte;   x:real; max:real;
begin
     almacenar(mt,n,m,vrub);
     writeln('Salio almacenar');
     writeln('Ingrese Rubro');readln(R);
     Completar(r);
     pos:=buscar(vrub,m,r);
     if pos=0 then
        writeln('El rubro no existe')
     else
         begin
         writeln('n es ',n);
         writeln('pos es ',pos);
         writeln('Su promedio es ',(InciA(mt,n,0,0,pos)):8:2);
         end;
     writeln('Ingrese caja');readln(caja);
     max:=0;
     InciB(mt,vrub,m,caja,max,R);
     writeln('El rubro es',vrub[pos].rub,' La ganancia fue ',max:8:2);
     writeln('Ingrese x'); Readln(x);
     Writeln(InciC(mt,n,m,m,true,x),' rubros');
     readln();
end.



begin
end.

