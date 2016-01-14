unit Define_Message;

interface

//uses
//  Messages;
const                          
  WM_USER             = $0400;
  
  WM_CommonAppBase  = WM_USER + $100;
  WM_AppStart       = WM_CommonAppBase + 1;

  WM_AppRequestEnd  = WM_CommonAppBase + 21;
  WM_AppNotifyEnd   = WM_CommonAppBase + 22;

  // 进程监控
  WM_ProcMonitorBase  = WM_USER + $300;    
  WM_ProcMonitor_S2C_Notify = WM_ProcMonitorBase + 1;  
  WM_ProcMonitor_C2S_Notify = WM_ProcMonitorBase + 2;                                 

  WM_CustomAppBase    = WM_USER + $500;

  Cmd_SysBase         = 100;
  Cmd_AppBase         = 200;
  // 外部通知自身 关闭
  Cmd_S2C_ClientShutdown  = Cmd_AppBase + 1;
  // 外部通知自身 重启
  Cmd_S2C_ClientRestart   = Cmd_AppBase + 2;
                
  // client 状态正常通知
  Cmd_Monitor_C2S_StatusOK        = Cmd_AppBase + 101; 
  // client 将要关闭 请监控
  Cmd_Monitor_C2S_MonitorShutDown = Cmd_AppBase + 102;
  // client 将要重启 请监控
  Cmd_Monitor_C2S_MonitorRestart  = Cmd_AppBase + 103;
  
  Cmd_CustomAppBase   = 500;

{ VCL control message IDs }
const
  CM_BASE                   = $B000;
  CM_ACTIVATE               = CM_BASE + 0;
  CM_DEACTIVATE             = CM_BASE + 1;
  CM_GOTFOCUS               = CM_BASE + 2;
  CM_LOSTFOCUS              = CM_BASE + 3;
  CM_CANCELMODE             = CM_BASE + 4;
  CM_DIALOGKEY              = CM_BASE + 5;
  CM_DIALOGCHAR             = CM_BASE + 6;
  CM_FOCUSCHANGED           = CM_BASE + 7;
  CM_PARENTFONTCHANGED      = CM_BASE + 8;
  CM_PARENTCOLORCHANGED     = CM_BASE + 9;
  CM_HITTEST                = CM_BASE + 10;
  CM_VISIBLECHANGED         = CM_BASE + 11;
  CM_ENABLEDCHANGED         = CM_BASE + 12;
  CM_COLORCHANGED           = CM_BASE + 13;
  CM_FONTCHANGED            = CM_BASE + 14;
  CM_CURSORCHANGED          = CM_BASE + 15;
  CM_CTL3DCHANGED           = CM_BASE + 16;
  CM_PARENTCTL3DCHANGED     = CM_BASE + 17;
  CM_TEXTCHANGED            = CM_BASE + 18;
  CM_MOUSEENTER             = CM_BASE + 19;
  CM_MOUSELEAVE             = CM_BASE + 20;
  CM_MENUCHANGED            = CM_BASE + 21;
  CM_APPKEYDOWN             = CM_BASE + 22;
  CM_APPSYSCOMMAND          = CM_BASE + 23;
  CM_BUTTONPRESSED          = CM_BASE + 24;
  CM_SHOWINGCHANGED         = CM_BASE + 25;
  CM_ENTER                  = CM_BASE + 26;
  CM_EXIT                   = CM_BASE + 27;
  CM_DESIGNHITTEST          = CM_BASE + 28;
  CM_ICONCHANGED            = CM_BASE + 29;
  CM_WANTSPECIALKEY         = CM_BASE + 30;
  CM_INVOKEHELP             = CM_BASE + 31;
  CM_WINDOWHOOK             = CM_BASE + 32;
  CM_RELEASE                = CM_BASE + 33;
  CM_SHOWHINTCHANGED        = CM_BASE + 34;
  CM_PARENTSHOWHINTCHANGED  = CM_BASE + 35;
  CM_SYSCOLORCHANGE         = CM_BASE + 36;
  CM_WININICHANGE           = CM_BASE + 37;
  CM_FONTCHANGE             = CM_BASE + 38;
  CM_TIMECHANGE             = CM_BASE + 39;
  CM_TABSTOPCHANGED         = CM_BASE + 40;
  CM_UIACTIVATE             = CM_BASE + 41;
  CM_UIDEACTIVATE           = CM_BASE + 42;
  CM_DOCWINDOWACTIVATE      = CM_BASE + 43;
  CM_CONTROLLISTCHANGE      = CM_BASE + 44;
  CM_GETDATALINK            = CM_BASE + 45;
  CM_CHILDKEY               = CM_BASE + 46;
  CM_DRAG                   = CM_BASE + 47;
  CM_HINTSHOW               = CM_BASE + 48;
  CM_DIALOGHANDLE           = CM_BASE + 49;
  CM_ISTOOLCONTROL          = CM_BASE + 50;
  CM_RECREATEWND            = CM_BASE + 51;
  CM_INVALIDATE             = CM_BASE + 52;
  CM_SYSFONTCHANGED         = CM_BASE + 53;
  CM_CONTROLCHANGE          = CM_BASE + 54;
  CM_CHANGED                = CM_BASE + 55;
  CM_DOCKCLIENT             = CM_BASE + 56;
  CM_UNDOCKCLIENT           = CM_BASE + 57;
  CM_FLOAT                  = CM_BASE + 58;
  CM_BORDERCHANGED          = CM_BASE + 59;
  CM_BIDIMODECHANGED        = CM_BASE + 60;
  CM_PARENTBIDIMODECHANGED  = CM_BASE + 61;
  CM_ALLCHILDRENFLIPPED     = CM_BASE + 62;
  CM_ACTIONUPDATE           = CM_BASE + 63;
  CM_ACTIONEXECUTE          = CM_BASE + 64;
  CM_HINTSHOWPAUSE          = CM_BASE + 65;
  CM_DOCKNOTIFICATION       = CM_BASE + 66;
  CM_MOUSEWHEEL             = CM_BASE + 67;
  CM_ISSHORTCUT             = CM_BASE + 68;
{$IFDEF LINUX}
  CM_RAWX11EVENT            = CM_BASE + 69;
{$ENDIF}
  CM_INVALIDATEDOCKHOST     = CM_BASE + 70;
  CM_SETACTIVECONTROL       = CM_BASE + 71;
  CM_POPUPHWNDDESTROY       = CM_BASE + 72;
  CM_CREATEPOPUP            = CM_BASE + 73;
  CM_DESTROYHANDLE          = CM_BASE + 74;
  CM_MOUSEACTIVATE          = CM_BASE + 75;
  CM_CONTROLLISTCHANGING    = CM_BASE + 76;
  CM_BUFFEREDPRINTCLIENT    = CM_BASE + 77;
  CM_UNTHEMECONTROL         = CM_BASE + 78;
  
implementation

end.
