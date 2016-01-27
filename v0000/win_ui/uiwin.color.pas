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

end.
