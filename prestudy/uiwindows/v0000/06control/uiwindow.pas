unit uiwindow;

interface
         
uses          
  Windows,
  Messages,
  uiwin.memdc,
  win.wnd_ui,
  UIView;

type
  PUIWindow         = ^TUIWindow;
  TUIWindow         = record
    BaseWnd         : TUIBaseWnd;
    WndClientRect   : TRect;
    MemDC           : TWinMemDC;
    TestUIView      : TUIView;
    WMLButtonDown_CursorPoint: TSmallPoint;
    WMMouseMove_CursorPoint: TSmallPoint;

    TestFocusUIView : PUIView;
    FocusMode: integer;  
    IsDragStarting  : Boolean;
    DragStartRect   : TRect;       
  end;
  
implementation

end.
