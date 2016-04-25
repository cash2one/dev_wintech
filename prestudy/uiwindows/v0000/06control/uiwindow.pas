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
  end;
  
implementation

end.
