unit win.wnd_cmd;

interface
           
uses
  Windows,
  win.thread;
               
type
  PWndCmd           = ^TWndCmd;
  PCmdWndThread     = ^TCmdWndThread;
  TCmdWndThread     = record
    Thread          : TSysWinThread;
    Wnd             : PWndCmd;
  end;
  
  TWndCmd           = packed record
    CmdWndHandle    : HWND;
    //Style           : DWORD;
    //ExStyle         : DWORD;
    //**Parent          : PUIBaseWnd;
    WndThread       : TCmdWndThread;
    //WinThread       : PSysWinThread;
  end;

implementation

end.
