unit ui.bitmap_pixel;

interface

uses
  ui.color,
  ui.bitmap;
                
  function Bitmap32GetPixelPtr(ABitmap32: PBitmap32; X, Y: Integer): PColor32; 
  function Bitmap32GetScanLine(ABitmap32: PBitmap32; Y: Integer): PColor32Array;
                           
  function  Bitmap32GetPixel(ABitmap32: PBitmap32; X, Y: Integer): TColor32; {$IFDEF USEINLINING} inline; {$ENDIF}
  procedure Bitmap32SetPixel(ABitmap32: PBitmap32; X, Y: Integer; Value: TColor32); {$IFDEF USEINLINING} inline; {$ENDIF}

implementation

function Bitmap32GetPixelPtr(ABitmap32: PBitmap32; X, Y: Integer): PColor32;
begin
  Result := @ABitmap32.Bits[X + Y * ABitmap32.Width];
end;
             
function Bitmap32GetScanLine(ABitmap32: PBitmap32; Y: Integer): PColor32Array;
begin
  Result := @ABitmap32.Bits[Y * ABitmap32.Width];
end;
       
function Bitmap32GetPixel(ABitmap32: PBitmap32; X, Y: Integer): TColor32;
begin
  Result := ABitmap32.Bits[X + Y * ABitmap32.Width];
end;

procedure Bitmap32SetPixel(ABitmap32: PBitmap32; X, Y: Integer; Value: TColor32);
begin
  ABitmap32.Bits[X + Y * ABitmap32.Width] := Value;
end;

end.
