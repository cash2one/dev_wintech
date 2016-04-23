unit uiwindow;

interface
         
uses          
  Windows,
  Messages,
  uiwin.memdc,
  win.wnd_ui;

type
  PUIWindow     = ^TUIWindow;    
  TUIWindow     = record
    BaseWnd     : TUIBaseWnd;
    MemDC       : TWinMemDC;
  end;
  
implementation

end.
