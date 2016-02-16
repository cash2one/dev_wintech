unit uiwin.bitmap_draw;

interface

uses
  ui.color, ui.bitmap, ui.space;
                
  procedure Bitmap32Line(ABitmap32: PBitmap32; X1, Y1, X2, Y2: Integer; Value: TColor32; L: Boolean = false);
  procedure Bitmap32HorzLine(ABitmap32: PBitmap32; X1, Y, X2: Integer; Value: TColor32);
  procedure Bitmap32VertLine(ABitmap32: PBitmap32; X, Y1, Y2: Integer; Value: TColor32);
  procedure Bitmap32FillRect(ABitmap32: PBitmap32; X1, Y1, X2, Y2: Integer; Value: TColor32);

  procedure Bitmap32ResetAlpha(ABitmap32: PBitmap32; const AlphaValue: Byte); overload;
  procedure Bitmap32ResetAlpha(ABitmap32: PBitmap32); overload;
  function Bitmap32Empty(ABitmap32: PBitmap32): Boolean;
                      
  procedure Bitmap32Clear(ABitmap32: PBitmap32); overload;
  procedure Bitmap32Clear(ABitmap32: PBitmap32; AFillColor: TColor32); overload;
  procedure Bitmap32Clear(ABitmap32: PBitmap32; ARect: TUIRect; AFillColor: TColor32); overload;

  procedure Bitmap32Draw(ADstBitmap32: PBitmap32;  ADstRect: TUIRect; ASrcBitmap32: PBitmap32; ASrcX, ASrcY: Integer);

implementation

uses
  BaseType,
  uiwin.color,
  ui.bitmap_pixel,
  Define_WinColor,
  win_data_move;
  
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

procedure Bitmap32ResetAlpha(ABitmap32: PBitmap32; const AlphaValue: Byte); overload;
var
  I: Integer;
  P: PBytes;
begin
  {$IFDEF FPC}
  P := Pointer(Bits);
  for I := 0 to ABitmap32.Width * ABitmap32.Height - 1 do
  begin
    P^[3] := AlphaValue;
    Inc(P, 4);
  end
  {$ELSE}
  P := Pointer(ABitmap32.Bits);
  Inc(P, 3); //shift the pointer to 'alpha' component of the first pixel

  I := ABitmap32.Width * ABitmap32.Height;

  if I > 16 then
  begin
    I := I * 4 - 64;
    Inc(P, I);

    //16x enrolled loop
    I := - I;
    repeat
      P^[I] := AlphaValue;
      P^[I +  4] := AlphaValue;
      P^[I +  8] := AlphaValue;
      P^[I + 12] := AlphaValue;
      P^[I + 16] := AlphaValue;
      P^[I + 20] := AlphaValue;
      P^[I + 24] := AlphaValue;
      P^[I + 28] := AlphaValue;
      P^[I + 32] := AlphaValue;
      P^[I + 36] := AlphaValue;
      P^[I + 40] := AlphaValue;
      P^[I + 44] := AlphaValue;
      P^[I + 48] := AlphaValue;
      P^[I + 52] := AlphaValue;
      P^[I + 56] := AlphaValue;
      P^[I + 60] := AlphaValue;
      Inc(I, 64)
    until I > 0;

    //eventually remaining bits
    Dec(I, 64);
    while I < 0 do
    begin
      P^[I + 64] := AlphaValue;
      Inc(I, 4);
    end;
  end else
  begin
    Dec(I);
    I := I * 4;
    while I >= 0 do
    begin
      P^[I] := AlphaValue;
      Dec(I, 4);
    end;
  end;
  {$ENDIF}
end;

procedure Bitmap32ResetAlpha(ABitmap32: PBitmap32); overload;
begin
  Bitmap32ResetAlpha(ABitmap32, $FF);
end;

function Bitmap32Empty(ABitmap32: PBitmap32): Boolean;
begin
  Result := (0 = ABitmap32.Width) or (0 = ABitmap32.Height);
end;
                
procedure Bitmap32Clear(ABitmap32: PBitmap32);
begin
  Bitmap32Clear(ABitmap32, clBlack32);
end;

procedure Bitmap32Clear(ABitmap32: PBitmap32; AFillColor: TColor32);
begin
  if Bitmap32Empty(ABitmap32) then
    Exit;
  win_data_move.FillLongword(ABitmap32.Bits[0], ABitmap32.Width * ABitmap32.Height, AFillColor);
end;

procedure Bitmap32Clear(ABitmap32: PBitmap32; ARect: TUIRect; AFillColor: TColor32);
begin
  Bitmap32FillRect(ABitmap32, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, AFillColor);
end;

procedure Bitmap32Draw(ADstBitmap32: PBitmap32;  ADstRect: TUIRect; ASrcBitmap32: PBitmap32; ASrcX, ASrcY: Integer);
var
  SrcP, DstP: PColor32;
  W, DstY: Integer;
begin
  { Internal routine }
  W := ADstRect.Right - ADstRect.Left;
  SrcP := Bitmap32GetPixelPtr(ASrcBitmap32, ASrcX, ASrcY);
  DstP := Bitmap32GetPixelPtr(ADstBitmap32, ADstRect.Left, ADstRect.Top);
  for DstY := ADstRect.Top to ADstRect.Bottom - 1 do
  begin
    //Move(SrcP^, DstP^, W shl 2); // for FastCode
    MoveLongWord(SrcP^, DstP^, W);
    Inc(SrcP, ASrcBitmap32.Width);
    Inc(DstP, ADstBitmap32.Width);
  end;
end;

end.
