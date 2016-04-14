unit win.wnd_ui;

interface
              
uses
  Windows,
  win.thread;
                
type
  PUIBaseWnd        = ^TUIBaseWnd;
  PUIBaseWndThread  = ^TUIBaseWndThread;    
  TUIBaseWndThread  = record
    Thread          : TSysWinThread;
    Wnd             : PUIBaseWnd;
  end;
  
  TUIBaseWnd        = packed record
    UIWndHandle     : HWND;
    UIWndParent     : HWND;
    Style           : DWORD;
    ExStyle         : DWORD;
    WindowRect      : TRect;
    ClientRect      : TRect;
    //**Parent          : PUIBaseWnd;
    WndThread       : TUIBaseWndThread;
    //WinThread       : PSysWinThread;
  end;

implementation

end.
