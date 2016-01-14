unit UIWinColor;

interface

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
  
implementation

end.
