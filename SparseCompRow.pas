unit SparseCompRow;

interface

uses
  Array2D;

function SparseCompRow_num_flops(N, nz, num_iterations : integer) : double;
procedure SparseCompRow_matmult(M : integer; const y, val : TArrayOf<double>;
    const row, col : TArrayOf<integer>; const x : TArrayOf<double>; NUM_ITERATIONS : integer);

implementation

function SparseCompRow_num_flops(N, nz, num_iterations : integer) : double;
var
  actual_nz : integer;
begin
  actual_nz := (nz div N) * N;
  result := actual_nz * 2 * num_iterations;
end;

procedure SparseCompRow_matmult(M : integer; const y, val : TArrayOf<double>;
    const row, col : TArrayOf<integer>; const x : TArrayOf<double>; NUM_ITERATIONS : integer);
var
  reps, r, i : integer;
  sum : double;
  rowR, rowRp1 : integer;
begin

  for reps := 0 to NUM_ITERATIONS - 1 do
    for r := 0 to M - 1 do
    begin
      sum := 0.0;
      rowR := row[r];
      rowRp1 := row[r + 1];
      for i := rowR to rowRp1 - 1 do
        sum := sum + x[ col[i] ] * val[i];

      y[r] := sum;
    end;

end;

end.
