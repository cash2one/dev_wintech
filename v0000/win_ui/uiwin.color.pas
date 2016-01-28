unit uiwin.color;

interface

uses
  Types;
  
type             
  PColor32          = ^TColor32;
  TColor32          = type Cardinal;

  PColor32Array     = ^TColor32Array;
  TColor32Array     = array [0..0] of TColor32;
  TArrayOfColor32   = array of TColor32;
                 
{$IFNDEF RGBA_FORMAT}
  TColor32Component = (ccBlue, ccGreen, ccRed, ccAlpha);
{$ELSE}
  TColor32Component = (ccRed, ccGreen, ccBlue, ccAlpha);
{$ENDIF}
  TColor32Components = set of TColor32Component;

  PColor32Entry     = ^TColor32Entry;
  TColor32Entry     = packed record
    case Integer of
{$IFNDEF RGBA_FORMAT}
      0: (B, G, R, A: Byte);
{$ELSE}
      0: (R, G, B, A: Byte);
{$ENDIF}
      1: (ARGB: TColor32);
      2: (Planes: array[0..3] of Byte);
      3: (Components: array[TColor32Component] of Byte);
  end;

  PColor32EntryArray = ^TColor32EntryArray;
  TColor32EntryArray = array [0..0] of TColor32Entry;
  TArrayOfColor32Entry = array of TColor32Entry;
                      
  PColor = ^TColor;   
  TColor = -$7FFFFFFF-1..$7FFFFFFF;
                        
  COLORREF = DWORD;
  TColorRef = DWORD;

  PRGBTriple = ^TRGBTriple;
  TRGBTriple = packed record
    rgbtBlue: Byte;
    rgbtGreen: Byte;
    rgbtRed: Byte;
  end;
                  
  TRGBLine = array[Word] of TRGBTriple;
  pRGBLine = ^TRGBLine;

  PRGBPixel = ^TRGBPixel;
  TRGBPixel = packed record
    B: Byte;
    G: Byte;
    R: Byte;
  end;
                  
  PRGBQuad = ^TRGBQuad;
  TRGBQuad = packed record
    rgbBlue: Byte;
    rgbGreen: Byte;
    rgbRed: Byte;
    rgbReserved: Byte;
  end;

  function GetRValue(rgb: DWORD): Byte; inline;
  function GetGValue(rgb: DWORD): Byte; inline;
  function GetBValue(rgb: DWORD): Byte; inline;
  function RGB(r, g, b: Byte): COLORREF; inline;
  function CMYK(c, m, y, k: Byte): COLORREF; inline;
                                            
  function Color32(R, G, B: Byte; A: Byte = $FF): TColor32; overload;   
  function Gray32(Intensity: Byte; Alpha: Byte = $FF): TColor32;
                                                                
  procedure Color32ToRGB(AColor32: TColor32; var R, G, B: Byte);
  procedure Color32ToRGBA(AColor32: TColor32; var R, G, B, A: Byte);

  function Color32Components(R, G, B, A: Boolean): TColor32Components;
  function RedComponent(AColor32: TColor32): Integer; {$IFDEF USEINLINING} inline; {$ENDIF}
  function GreenComponent(AColor32: TColor32): Integer; {$IFDEF USEINLINING} inline; {$ENDIF}
  function BlueComponent(AColor32: TColor32): Integer; {$IFDEF USEINLINING} inline; {$ENDIF}
  function AlphaComponent(AColor32: TColor32): Integer; {$IFDEF USEINLINING} inline; {$ENDIF}

  function Intensity(AColor32: TColor32): Integer; {$IFDEF USEINLINING} inline; {$ENDIF}
  function InvertColor(AColor32: TColor32): TColor32; {$IFDEF USEINLINING} inline; {$ENDIF}
                                                            
  function SetAlpha(AColor32: TColor32; NewAlpha: Integer): TColor32; {$IFDEF USEINLINING} inline; {$ENDIF}

implementation

function GetRValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb);
end;

function GetGValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 8);
end;

function GetBValue(rgb: DWORD): Byte;
begin
  Result := Byte(rgb shr 16);
end;

function CMYK(c, m, y, k: Byte): COLORREF;
begin
  Result := (k or (y shl 8) or (m shl 16) or (c shl 24));
end;

function RGB(r, g, b: Byte): COLORREF;
begin
  Result := (r or (g shl 8) or (b shl 16));
end;

function Color32(R, G, B: Byte; A: Byte = $FF): TColor32; overload;
{$IFDEF USENATIVECODE}
begin
  Result := (A shl 24) or (R shl 16) or (G shl  8) or B;
{$ELSE}
asm
        MOV     AH, A
        SHL     EAX, 16
        MOV     AH, DL
        MOV     AL, CL
{$ENDIF}
end;

function Gray32(Intensity: Byte; Alpha: Byte = $FF): TColor32;
begin
  Result := TColor32(Alpha) shl 24 + TColor32(Intensity) shl 16 + TColor32(Intensity) shl 8 + TColor32(Intensity);
end;

procedure Color32ToRGB(AColor32: TColor32; var R, G, B: Byte);
begin
  R := (AColor32 and $00FF0000) shr 16;
  G := (AColor32 and $0000FF00) shr 8;
  B := AColor32 and $000000FF;
end;

procedure Color32ToRGBA(AColor32: TColor32; var R, G, B, A: Byte);
begin
  A := AColor32 shr 24;
  R := (AColor32 and $00FF0000) shr 16;
  G := (AColor32 and $0000FF00) shr 8;
  B := AColor32 and $000000FF;
end;

function Color32Components(R, G, B, A: Boolean): TColor32Components;
const
  ccR : array[Boolean] of TColor32Components = ([], [ccRed]);
  ccG : array[Boolean] of TColor32Components = ([], [ccGreen]);
  ccB : array[Boolean] of TColor32Components = ([], [ccBlue]);
  ccA : array[Boolean] of TColor32Components = ([], [ccAlpha]);
begin
  Result := ccR[R] + ccG[G] + ccB[B] + ccA[A];
end;

function RedComponent(AColor32: TColor32): Integer;
begin
  Result := (AColor32 and $00FF0000) shr 16;
end;

function GreenComponent(AColor32: TColor32): Integer;
begin
  Result := (AColor32 and $0000FF00) shr 8;
end;

function BlueComponent(AColor32: TColor32): Integer;
begin
  Result := AColor32 and $000000FF;
end;

function AlphaComponent(AColor32: TColor32): Integer;
begin
  Result := AColor32 shr 24;
end;

function Intensity(AColor32: TColor32): Integer;
begin
// (R * 61 + G * 174 + B * 21) / 256
  Result := (
    (AColor32 and $00FF0000) shr 16 * 61 +
    (AColor32 and $0000FF00) shr 8 * 174 +
    (AColor32 and $000000FF) * 21
    ) shr 8;
end;

function InvertColor(AColor32: TColor32): TColor32;
begin
  TColor32Entry(Result).R := $FF - TColor32Entry(AColor32).R;
  TColor32Entry(Result).G := $FF - TColor32Entry(AColor32).G;
  TColor32Entry(Result).B := $FF - TColor32Entry(AColor32).B;
  TColor32Entry(Result).A := TColor32Entry(AColor32).A;
end;

function SetAlpha(AColor32: TColor32; NewAlpha: Integer): TColor32;
begin
  if NewAlpha < 0 then NewAlpha := 0
  else if NewAlpha > $FF then NewAlpha := $FF;
  Result := (AColor32 and $00FFFFFF) or (TColor32(NewAlpha) shl 24);
end;

end.
