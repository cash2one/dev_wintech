unit uiwin.bitmap_draw;

interface

uses
  ui.color, ui.bitmap;
                
  procedure Bitmap32Line(ABitmap32: PBitmap32; X1, Y1, X2, Y2: Integer; Value: TColor32; L: Boolean = false);
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

procedure Bitmap32Line(ABitmap32: PBitmap32; X1, Y1, X2, Y2: Integer; Value: TColor32; L: Boolean);
var
  Dy, Dx, Sy, Sx, I, Delta: Integer;
  P: PColor32;
begin
  Dx := X2 - X1;
  Dy := Y2 - Y1; 
  if Dx > 0 then
  begin
    Sx := 1
  end else if Dx < 0 then
  begin
    Dx := -Dx;
    Sx := -1;
  end else // Dx = 0
  begin
    if Dy > 0 then
    begin
      Bitmap32VertLine(ABitmap32, X1, Y1, Y2 - 1, Value)
    end else if Dy < 0 then
    begin
      Bitmap32VertLine(ABitmap32, X1, Y2 + 1, Y1, Value);
    end;
    if L then
    begin
      Bitmap32SetPixel(ABitmap32, X2, Y2, Value);
    end;
    Exit;
  end;            
  if Dy > 0 then
  begin
    Sy := 1
  end else if Dy < 0 then
  begin
    Dy := -Dy;
    Sy := -1;                                        
  end else // Dy = 0                                 
  begin
    if X2 > X1 then
    begin
      Bitmap32HorzLine(ABitmap32, X1, Y1, X2 - 1, Value)
    end else
    begin
      Bitmap32HorzLine(ABitmap32, X2 + 1, Y1, X1, Value);
    end;
    if L then
      Bitmap32SetPixel(ABitmap32, X2, Y2, Value);
    Exit;
  end;

  P := Bitmap32GetPixelPtr(ABitmap32, X1, Y1);
  Sy := Sy * ABitmap32.Width;

  if Dx > Dy then
  begin
    Delta := Dx shr 1;
    for I := 0 to Dx - 1 do
    begin
      P^ := Value;
      Inc(P, Sx);
      Inc(Delta, Dy);
      if Delta >= Dx then
      begin
        Inc(P, Sy);
        Dec(Delta, Dx);
      end;
    end;
  end else // Dx < Dy
  begin
    Delta := Dy shr 1;
    for I := 0 to Dy - 1 do
    begin
      P^ := Value;
      Inc(P, Sy);
      Inc(Delta, Dx);
      if Delta >= Dy then
      begin
        Inc(P, Sx);
        Dec(Delta, Dy);
      end;
    end;
  end;
  if L then
    P^ := Value;
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
