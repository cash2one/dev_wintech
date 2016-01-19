unit uiwin.gdi;

interface

(*
    uiwin.gdi
    用 . 代表对象
    uiwin_drag
    用 _ 代表处理过程 功能支持
*)
uses
  Windows;

  
type               
  PWinBitmap          = ^TWinBitmap;
  TWinBitmap          = packed record
    BitmapHandle      : HBitmap;
    BitmapInfo        : Windows.TBitmapInfo;
    Width             : integer;
    Height            : integer;
    //BitsData          : PColor32Array;
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

implementation

end.
