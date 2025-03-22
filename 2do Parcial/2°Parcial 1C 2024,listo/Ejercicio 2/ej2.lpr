program ej2;
const
  maxElem = 100;

type
  TReg = record
    f, c : byte;
  end;

  TM = array[1..maxElem, 1..maxElem] of integer;

  TV = array[1..maxElem] of TReg;

procedure leerMatriz (var mat : TM; var n, m : byte);
var
  archE : text;
  i, j : byte;
begin
  assign(archE, 'Entrada.txt');
  reset(archE);
  readln(archE,n,m);
  for i := 1 to n do
  begin
      for j := 1 to m do
          read(archE, mat[i,j]);
      readln(archE);
  end;
  close(archE);
end;

(*
procedure generarVPosMin (mat : TM; i, j, m : byte; var VPosMin : TV; var k : byte; var sum, min : integer; var posMin : TReg);
begin
  if i > 0 then
     if j > 1 then
        begin
          generarVPosMin(mat,i,j - 1,m, VPosMin,k,sum,min,posMin);
          sum := sum + mat[i,j];
          if mat[i,j] < min then
          begin
            min := mat[i,j];
            with posMin do
            begin
                f := i;
                c := j;
            end;
          end;
        end
        else
            begin
                generarVPosMin(mat,i - 1, m, m, VPosMin,k,sum,min,posMin);
                if sum > 0 then
                begin
                     k := k + 1; VPosMin[k] := posMin;
                end;
                sum := mat[i,j]; min := mat[i,j];
                posMin.f := i; posMin.c := j;
            end;
end;

*)

function sumFila (mat : TM; i, j : byte):integer;
begin
  if j = 1 then
     sumFila := mat[i,j]
  else
    sumFila := mat[i,j] + sumFila(mat,i, j - 1);
end;

function posMinFila(mat : TM; i, j : byte):TReg;
var
  aux : TReg;
begin
  if j = 1 then
  begin
     posMinFila.f := i;
     posMinFila.c := j;
  end
  else
     begin
         aux := posMinFila(mat,i,j - 1);
         if mat[i,j] < mat[aux.f,aux.c] then
         begin
              posMinFila.f := i;
              posMinFila.c := j;
         end
         else
             posMinFila := aux;
     end;
end;

procedure generarVPosMin (mat : TM; i, j, m : byte; var VPosMin : TV; var k : byte);
var
  sum : integer;
begin
  if i > 0 then
  begin
     generarVPosMin(mat,i - 1,j,m,VPosMin, k);
     sum := sumFila(mat,i,m);
     if sum > 0 then
     begin
          k := k + 1;
          VPosMin[k] := posMinFila(mat,i,m);
     end;
  end
  else
      k := 0;
end;

procedure mostrarMatriz (mat : TM; n, m : byte);
var
  i, j : byte;
begin
  for i := 1 to n do
  begin
      for j := 1 to m do
          write(mat[i,j]:4);
      writeln();
  end;
end;

procedure mostrarVector(VPosMin : TV; k : byte);
var
  i : byte;
begin
  for i := 1 to k do
      writeln(VPosMin[i].f, ' ', VPosMin[i].c);
end;

var
  mat : TM; n, m, k : byte;
  VPosMin : TV; posMin : TReg; sum, min : integer;
begin
  leerMatriz(mat,n,m);
  mostrarMatriz(mat,n,m);
  generarVPosMin(mat,n,m,m,VPosMin,k);
  writeln();
  mostrarVector(VPosMin,k);
  readln();
end.
