program ejerc2;

const
     N=2;M=3;
type
    tmt=array[1..N,1..M]of byte;
    tvec=array[1..N]of byte;

const
     Mat:tmt=((1,2,3),(4,5,6));
     Vec:tvec=(1,2);

Function  Cumple(mat:tmt;vec:tvec;N,M:byte;cond:boolean):boolean;

begin
     if (M=0) and cond then
        cumple:=true
     else
         begin
              if cond then
                 begin
                      if (mat[N,M] mod vec[N])<>0 then
                         begin
                              cond:=false;
                         end;
                      cumple:=cumple(mat,vec,n,m-1,cond);
                 end
              else
                  cumple:=false;
         end;
end;

Function Contar(mat:tmt;vec:tvec;n,m:byte):byte;

begin
     if n=0 then
        contar:=0
     else
         begin
              if cumple(mat,vec,n,m,true) then
                 begin
                      contar:=1+contar(mat,vec,n-1,m);
                 end
              else                                   //Importante el else aqui, pq si no a la vuelta llamara inncesariamente
                  contar:=contar(mat,vec,n-1,m);
         end;
end;

begin
     writeln(contar(mat,vec,n,m),' filas cumplen');
     readln();
end.

