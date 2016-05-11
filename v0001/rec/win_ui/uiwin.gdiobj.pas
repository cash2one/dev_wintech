unit uiwin.gdiobj;

interface
              
uses
  Windows,
  win.thread,
  ui.texcolor,
  uiwin.wnd;
                
type
  PWinFont            = ^TWinFont;
  TWinFont            = packed record
    FontHandle        : HFONT;
  end;

  PWinBrush           = ^TWinBrush;
  TWinBrush           = packed record
    BrushHandle       : HBRUSH;
  end;

  PWinPen             = ^TWinPen;
  TWinPen             = packed record
    PenHandle         : HPEN;
  end;
  
  PWinBitmap          = ^TWinBitmap;
  TWinBitmap          = packed record
    BitmapHandle      : HBITMAP;
    BitmapInfo        : Windows.TBitmapInfo;   
    Width             : integer;
    Height            : integer;
    BitsData          : PColor32Array;
  end;
  
implementation

end.
