unit ui.palette;

interface

uses
  ui.color;
  
type                     
  PPaletteEntry = ^TPaletteEntry;
  TPaletteEntry = packed record
    peRed: Byte;
    peGreen: Byte;
    peBlue: Byte;
    peFlags: Byte;
  end;
  
  PMaxLogPalette = ^TMaxLogPalette; // not in Windows Headers
  TMaxLogPalette = packed record
    palVersion: Word;
    palNumEntries: Word;
    palPalEntry: array [Byte] of TPaletteEntry;
  end;
             
  PPalette32 = ^TPalette32;
  TPalette32 = array [Byte] of TColor32;
                                        
  function Color32(AIndex: Byte; APalette: TPalette32): TColor32; 

implementation

function Color32(AIndex: Byte; APalette: TPalette32): TColor32; 
begin
  Result := APalette[AIndex];
end;

end.
