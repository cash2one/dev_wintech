unit uiwin.bitmap_draw;

interface

uses
  ui.color, ui.bitmap;
                
  procedure Bitmap32HorzLine(ABitmap32: PBitmap32; X1, Y, X2: Integer; Value: TColor32);  
  procedure Bitmap32VertLine(ABitmap32: PBitmap32; X, Y1, Y2: Integer; Value: TColor32);
  procedure Bitmap32FillRect(ABitmap32: PBitmap32; X1, Y1, X2, Y2: Integer; Value: TColor32);
  
implementation

uses
  ui.bitmap_pixel,
  win.memory;
  
procedure Bitmap32HorzLine(ABitmap32: PBitmap32; X1, Y, X2: Integer; Value: TColor32);
begin
  FillLongword(ABitmap32.Bits[X1 + Y * ABitmap32.Width], X2 - X1 + 1, Value);
end;

procedure Bitmap32VertLine(ABitmap32: PBitmap32; X, Y1, Y2: Integer; Value: TColor32);
var
  I, NH, NL: Integer;
  P: PColor32;
begin
  if Y2 < Y1 then
    Exit;
  P := Bitmap32GetPixelPtr(ABitmap32, X, Y1);
  I := Y2 - Y1 + 1;
  NH := I shr 2;
  NL := I and $03;
  for I := 0 to NH - 1 do
  begin
    P^ := Value; Inc(P, ABitmap32.Width);
    P^ := Value; Inc(P, ABitmap32.Width);
    P^ := Value; Inc(P, ABitmap32.Width);
    P^ := Value; Inc(P, ABitmap32.Width);
  end;
  for I := 0 to NL - 1 do
  begin
    P^ := Value; Inc(P, ABitmap32.Width);
  end;
end;

procedure Bitmap32FillRect(ABitmap32: PBitmap32; X1, Y1, X2, Y2: Integer; Value: TColor32);
var
  j: Integer;
  P: PColor32Array;
begin
  if Assigned(ABitmap32.Bits) then
  begin
    for j := Y1 to Y2 - 1 do
    begin
      P := Pointer(@ABitmap32.Bits[j * ABitmap32.Width]);
      FillLongword(P[X1], X2 - X1, Value);
    end;
  end;
end;

end.
