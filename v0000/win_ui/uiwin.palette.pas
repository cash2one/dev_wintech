unit uiwin.palette;

interface

uses
  Windows, ui.palette, ui.color;
                 
  function WinPalette(const P: TPalette32): HPALETTE;

implementation

function WinPalette(const P: TPalette32): HPALETTE;
var
  L: TMaxLogPalette;
  L0: LOGPALETTE absolute L;
  I: Cardinal;
  Cl: TColor32;
begin
  L.palVersion := $300;
  L.palNumEntries := 256;
  for I := 0 to $FF do
  begin
    Cl := P[I];
    // w ith L.palPalEntry[I] do
    begin
      L.palPalEntry[I].peFlags := 0;
      L.palPalEntry[I].peRed := RedComponent(Cl);
      L.palPalEntry[I].peGreen := GreenComponent(Cl);
      L.palPalEntry[I].peBlue := BlueComponent(Cl);
    end;
  end;
  Result := CreatePalette(l0);
end;

end.
