program ejerc2;

const
     n=3;
type
    tmt=array[1..N,1..N]of byte;

const
     mt:tmt=((1,2,3),(4,5,6),(7,8,9));


function mayor(mt:tmt;n,m:byte;cond:boolean;prom:real):boolean;

begin
     if (n=0)and cond then
        mayor:=false
     else
         begin
              if cond then
                 begin
                      if mt[n,m]>prom then
                         begin
                              cond:=false;
                         end;
                      mayor:=mayor(mt,n-1,M,cond,prom);
                 end
              else
                  mayor:=true;
         end;
end;


Function Promedio(mt:tmt;n,m,max:byte;acum:word):real;

begin
     if N=0 then
        promedio:=acum/((max*max-max)/2)
     else
         begin
              if M>0 then
                 begin
                      if N>M then
                         begin
                              acum:=acum+mt[n,m];
                         end;
                      promedio:=promedio(mt,n,m-1,max,acum);
                 end
              else
                  promedio:=promedio(mt,n-1,max,max,acum);
         end;
end;

Function cantidad(mt:tmt;n,M,cont:byte;prom:real):byte;

begin
     if M=0 then
        cantidad:=cont
     else
         begin
              if mayor(mt,n,m,false,prom) then
                 begin
                      cont:=cont+1;
                 end;
              cantidad:=cantidad(mt,n,M-1,cont,prom);
         end;
end;

var
   prom:real;

begin
     prom:=promedio(mt,n,n,n,0);
     writeln('La cantidad es ',cantidad(mt,n,n,0,prom));
     readln();
end.

