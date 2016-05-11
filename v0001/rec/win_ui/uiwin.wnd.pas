unit uiwin.wnd;

interface
              
uses
  Windows,
  win.thread;
                
type
  PWndUI            = ^TWndUI;
  PWndThread        = ^TWndThread;    
  TWndThread        = record
    Thread          : TSysWinThread;
    Wnd             : PWndUI;
  end;
  
  TWndUI            = packed record
    WndHandle       : HWND;
    WndParent       : HWND;
    WndMsg          : Windows.TMsg;
    Style           : DWORD;
    ExStyle         : DWORD;
    WindowRect      : TRect;
    ClientRect      : TRect;
    //Parent          : PWndUI;
    WndThread       : TWndThread;
    //WinThread       : PSysWinThread;
    WMMOUSEMOVE_LParam    : DWORD;
    WMLBUTTONDOWN_LParam  : DWORD;
    WMLBUTTONUP_LParam    : DWORD;

    WMSetCursor_CursorPoint: TPoint;
    //WMLButtonDown_CursorPoint: TSmallPoint;
    //WMMouseMove_CursorPoint: TSmallPoint;    
  end;

implementation

end.
