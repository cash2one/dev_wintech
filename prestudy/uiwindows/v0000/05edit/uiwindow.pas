unit uiwindow;

interface
         
uses          
  Windows,
  Messages,
  uiwin.memdc,
  win.wnd_ui,
  uiview;

type
  PUIWindow         = ^TUIWindow;    
  TUIWindow         = record
    BaseWnd         : TUIBaseWnd;
    WndClientRect   : TRect;
    MemDC           : TWinMemDC;
    TestUIEdit      : TUIView;

    WMSetCursor_CursorPoint: TPoint;
    WMLButtonDown_CursorPoint: TSmallPoint;
    WMMouseMove_CursorPoint: TSmallPoint;

    CursorHandle: HCURSOR;
    TestFocusUIView : PUIView;
    FocusMode: integer;  
  end;
  
implementation

end.
