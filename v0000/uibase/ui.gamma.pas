unit ui.gamma;

interface

type
  PGammaTable = ^TGammaTable;
  TGammaTable = record
    Gamma: Single;
    Value: array [Byte] of Byte;
  end;
  
var
  GAMMA_TABLE: TGammaTable;

  procedure SetGamma(AGamma: Single = 1.6);

implementation

uses
  Math;
  
const
  COne255th = 1 / $FF;

procedure SetGamma(AGamma: Single);
var
  i: Integer;
begin
  GAMMA_TABLE.Gamma := AGamma;
  for i := 0 to $FF do
  begin
    GAMMA_TABLE.Value[i] := Round($FF * Power(i * COne255th, AGamma));
  end;
end;

initialization
  SetGamma;

end.
