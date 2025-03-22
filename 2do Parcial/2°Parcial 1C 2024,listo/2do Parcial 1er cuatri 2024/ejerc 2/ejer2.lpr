program ejer2;

const n=2;m=4;max=256;

type
    tmt=array[1..N,1..m]of shortint;
    tregmin=record
      x:byte;
      y:byte; end; tvmin=array[1..max]of tregmin;
const
     mt:tmt=((3,1,2,-5),(1,8,-5,83));

procedure HallarMin(mt:tmt;fila,col,m:byte; vmin:tvmin; acum:real; min:shortint;posx,posy:byte);    //Preguntar porque funciona sin var
                                                                                                    //Funciona sin var porque va pasando copias del vector,
var                                                                                                // y lo imprime al final
                                                                                            //Preguntar usar Var o no?, si este fuese el parcial
  i:byte;
begin
     if fila>0 then
        begin
             if (col>0) then
                begin
                     //hallarMin(mt,fila,col-1,m,vmin,acum,min,posx,posy);
                     acum:=acum+mt[fila,col];
                     if mt[fila,col]<min then
                        begin
                             min:=mt[fila,col]; posx:=fila;  posy:=col;
                        end;
                    hallarMin(mt,fila,col-1,m,vmin,acum,min,posx,posy);
                end
             else
                 begin
                      if acum>0 then
                         begin
                              vmin[fila].x:=posx;
                              vmin[fila].y:=posy;
                         end;
                 acum:=0;
                 min:=99;
                 hallarmin(mt,fila-1,m,m,vmin,acum,min,posx,posy);
                 end;
        end
     else
     begin
     for i:=1 to 2 do
     begin
         writeln(vmin[i].x);
         writeln(vmin[i].y);
         writeln();
     end;
     end;
end;

var
   vmin:tvmin;
   acum:real;
   min:shortint;
   posx,posy:byte;

begin
     acum:=0;
     min:=99;
     hallarMIn(mt,n,m,m,vmin,acum,min,posx,posy);
     readln();

end.

