unit uiwin.gdi;

interface

(*
    uiwin.gdi
    用 . 代表对象
    uiwin_drag
    用 _ 代表处理过程 功能支持
*)
uses
  Windows,
  ui.color;
  
type               
  PWinBitmap          = ^TWinBitmap;
  TWinBitmap          = packed record
    BitmapHandle      : HBitmap;
    BitmapInfo        : Windows.TBitmapInfo;   
    Width             : integer;
    Height            : integer;
    BitsData          : PColor32Array;
  end;

  PWinFont            = ^TWinFont;
  TWinFont            = packed record
    FontHandle        : HFont;
  end;
                    
  PWinBrush           = ^TWinBrush;
  TWinBrush           = packed record
    BrushHandle       : HBrush;
  end;

  PWinPen             = ^TWinPen;
  TWinPen             = packed record
    PenHandle         : HPen;
  end;
                  
  PWinCursor          = ^TWinCursor;
  TWinCursor          = packed record
    CursorHandle      : HCursor;
  end;

  function WinMemBitmapGetPixelPtr(ABitmap: PWinBitmap; X, Y: Integer): PColor32; inline; 
  function WinMemBitmapGetPixel(ABitmap: PWinBitmap; X, Y: Integer): TColor32; inline;
  procedure WinMemBitmapSetPixel(ABitmap: PWinBitmap; X, Y: Integer; Value: TColor32); inline;
                              
  procedure OpenWinFont(AFont: PWinFont);   
  procedure OpenWinBrush(ABrush: PWinBrush);
  procedure OpenWinPen(APen: PWinPen);

implementation

function WinMemBitmapGetPixelPtr(ABitmap: PWinBitmap; X, Y: Integer): PColor32;
begin
  Result := @ABitmap.BitsData[X + Y * ABitmap.Width];
end;

function WinMemBitmapGetPixel(ABitmap: PWinBitmap; X, Y: Integer): TColor32;
begin
  Result := ABitmap.BitsData[X + Y * ABitmap.Width];
end;

procedure WinMemBitmapSetPixel(ABitmap: PWinBitmap; X, Y: Integer; Value: TColor32);
begin
  ABitmap.BitsData[X + Y * ABitmap.Width] := Value;
end;

procedure OpenWinFont(AFont: PWinFont);
var
  tmpLogFont: Windows.TLogFontW;
begin
  AFont.FontHandle := Windows.CreateFontIndirectW(tmpLogFont);
end;

procedure OpenWinBrush(ABrush: PWinBrush);
var
  tmpLogBrush: Windows.TLogBrush;
begin
  ABrush.BrushHandle := Windows.CreateBrushIndirect(tmpLogBrush);
end;

procedure OpenWinPen(APen: PWinPen);
var
  tmpLogPen: Windows.TLogPen;
begin
  APen.PenHandle := Windows.CreatePenIndirect(tmpLogPen);
end;
  
end.
