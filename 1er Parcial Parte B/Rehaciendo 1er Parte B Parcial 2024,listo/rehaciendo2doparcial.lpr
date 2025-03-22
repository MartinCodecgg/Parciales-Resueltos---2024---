program rehaciendo2doparcial;

const
     tope=256;
type
    st16=string[16];
    vt2=array[1..tope]of byte;
    vt3=array[1..tope]of real;

    Function Buscar(vlic:vt1; lic:st16; av:byte):byte;
    var
       i:byte;
    begin
         i:=av;
         while (i>0) and (lic<vlic[i]) do             //Como estara ordenado, hago la busqueda de la insercion ordenada
             begin
                  i:=i-1;
             end;
         if lic=vlic[i] then
            buscar:=i;
         else
            buscar:=0;
    end;

Procedure ArmarVec(var Vlic:vt2;var Vcant:vt2;var vdem,Vcosto:vt3; var av:byte; var Vdemora:vt1);
var
   arch:text; fecha:st16;
   lic,i,cant2024,pos:byte; car:char;
   demora:shortint; vdemora:vt3;
begin
     Assign(arch,'Viajes.txt'); reset(arch); av:=0;
     cant2024:=0;
     while not eof(arch) do
           begin
                read(arch,lic,car,fecha,demora);
                if demora>0 then
                   readln(arch,costo);
                else
                    readln(arch);
                pos:=buscar(vlic,lic,av);

                if pos=0 then
                   begin
                        av:=av+1;
                        vlic[pos]:=lic;
                        vcant[pos]:=1;
                        vcosto[pos]:=costo;
                        vdemora[pos]:=demora;
                   end;
                else
                    begin
                         vcant[pos]:=vcant[pos]+1;
                         vcosto[pos]:=vosto[pos]+costo;
                         vdemora[pos]:=vdemora[pos]+demora;
                    end;

                if copy(fecha,1,4)='2024' then
                   cant2024:=cant2024+1;

           end;
     close(arch);
end;

       //Para el ejercicio A simplemente vamos calculando el promedio por cada licencia en el momento, usando un comparador, y una variable
       //que almacene el string de la licencia con mayor demora







var
   Vlic:vt1; vcant:vt2; vdem,vcosto:vt3;
   av,L:byte;

begin
     ArmarVec(Vlic,Vcant,Vdem,Vcosto,av);
end.

