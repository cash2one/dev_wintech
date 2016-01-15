{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32;

interface 
                 
uses
  atmcmbaseconst, winconst, wintype;

const                               
  IDC_ARROW_A     = PAnsiChar(32512);  
  IDC_ARROW_W     = PWideChar(32512);
  
  IDC_IBEAM_A     = PAnsiChar(32513);
  IDC_WAIT_A      = PAnsiChar(32514);
  IDC_CROSS_A     = PAnsiChar(32515);
  IDC_UPARROW_A   = PAnsiChar(32516);
  //==================================
  
  IDC_SIZE_A      = PAnsiChar(32640);
  IDC_ICON_A      = PAnsiChar(32641);
  IDC_SIZENWSE_A  = PAnsiChar(32642);
  IDC_SIZENESW_A  = PAnsiChar(32643);
  IDC_SIZEWE_A    = PAnsiChar(32644);
  IDC_SIZENS_A    = PAnsiChar(32645);
  IDC_SIZEALL_A   = PAnsiChar(32646);
  IDC_NO_A        = PAnsiChar(32648);
  IDC_HAND_A      = PAnsiChar(32649);
  IDC_APPSTARTING_A = PAnsiChar(32650);
  IDC_HELP_A      = PAnsiChar(32651);
  //==================================
  IDC_NODROP_A    = PAnsiChar(32767);
  IDC_DRAG_A      = PAnsiChar(32766);
  IDC_HSPLIT_A    = PAnsiChar(32765); // 这几个 是 delphi 自定义的 光标 在 res 里
  IDC_VSPLIT_A    = PAnsiChar(32764);
  IDC_MULTIDRAG_A = PAnsiChar(32763);
  IDC_SQLWAIT_A   = PAnsiChar(32762);
                                     
  IDC_NODROP_W    = PWideChar(32767);
  IDC_DRAG_W      = PWideChar(32766);
  IDC_HSPLIT_W    = PWideChar(32765);
  IDC_VSPLIT_W    = PWideChar(32764);
  IDC_MULTIDRAG_W = PWideChar(32763);
  IDC_SQLWAIT_W   = PWideChar(32762);

  { GetSystemMetrics() codes }
  SM_CXSCREEN = 0;
  SM_CYSCREEN = 1;
  SM_CXVSCROLL = 2;
  SM_CYHSCROLL = 3;
  SM_CYCAPTION = 4;
  SM_CXBORDER = 5;
  SM_CYBORDER = 6;
  SM_CXDLGFRAME = 7;
  SM_CYDLGFRAME = 8;
  SM_CYVTHUMB = 9;
  SM_CXHTHUMB = 10;
  SM_CXICON = 11;
  SM_CYICON = 12;
  SM_CXCURSOR = 13;
  SM_CYCURSOR = 14;
  SM_CYMENU = 15;
  SM_CXFULLSCREEN = $10;
  SM_CYFULLSCREEN = 17;
  SM_CYKANJIWINDOW = 18;
  SM_MOUSEPRESENT = 19;
  SM_CYVSCROLL = 20;
  SM_CXHSCROLL = 21;
  SM_DEBUG = 22;
  SM_SWAPBUTTON = 23;
  SM_RESERVED1 = 24;
  SM_RESERVED2 = 25;
  SM_RESERVED3 = 26;
  SM_RESERVED4 = 27;
  SM_CXMIN = 28;
  SM_CYMIN = 29;
  SM_CXSIZE = 30;
  SM_CYSIZE = 31;
  SM_CXFRAME = $20;
  SM_CYFRAME = 33;
  SM_CXMINTRACK = 34;
  SM_CYMINTRACK = 35;
  SM_CXDOUBLECLK = 36;
  SM_CYDOUBLECLK = 37;
  SM_CXICONSPACING = 38;
  SM_CYICONSPACING = 39;
  SM_MENUDROPALIGNMENT = 40;
  SM_PENWINDOWS = 41;
  SM_DBCSENABLED = 42;
  SM_CMOUSEBUTTONS = 43;

  SM_CXFIXEDFRAME = SM_CXDLGFRAME; { win40 name change }
  SM_CYFIXEDFRAME = SM_CYDLGFRAME; { win40 name change }
  SM_CXSIZEFRAME = SM_CXFRAME;     { win40 name change }
  SM_CYSIZEFRAME = SM_CYFRAME;     { win40 name change }

  SM_SECURE = 44;
  SM_CXEDGE = 45;
  SM_CYEDGE = 46;
  SM_CXMINSPACING = 47;
  SM_CYMINSPACING = 48;
  SM_CXSMICON = 49;
  SM_CYSMICON = 50;
  SM_CYSMCAPTION = 51;
  SM_CXSMSIZE = 52;
  SM_CYSMSIZE = 53;
  SM_CXMENUSIZE = 54;
  SM_CYMENUSIZE = 55;
  SM_ARRANGE = 56;
  SM_CXMINIMIZED = 57;
  SM_CYMINIMIZED = 58;
  SM_CXMAXTRACK = 59;
  SM_CYMAXTRACK = 60;
  SM_CXMAXIMIZED = 61;
  SM_CYMAXIMIZED = 62;
  SM_NETWORK = 63;
  SM_CLEANBOOT = 67;
  SM_CXDRAG         = 68;
  SM_CYDRAG         = 69;
  SM_SHOWSOUNDS     = 70;
  SM_CXMENUCHECK    = 71;     { Use instead of GetMenuCheckMarkDimensions()! }
  SM_CYMENUCHECK    = 72;
  SM_SLOWMACHINE    = 73;
  SM_MIDEASTENABLED = 74;
  SM_MOUSEWHEELPRESENT = 75;
  SM_CMETRICS       = 76;
  SM_REMOTESESSION  = $1000;
  SM_XVIRTUALSCREEN = 76;
  SM_YVIRTUALSCREEN = 77;
  SM_CXVIRTUALSCREEN = 78;
  SM_CYVIRTUALSCREEN = 79;
  SM_CMONITORS      = 80;
  SM_SAMEDISPLAYFORMAT = 81;
  SM_IMMENABLED     = 82;
  SM_CXFOCUSBORDER  = 83;
  SM_CYFOCUSBORDER  = 84;
                      
const                   
  { Desktop-specific access flags }
  DESKTOP_READOBJECTS = 1;
  DESKTOP_CREATEWINDOW = 2;
  DESKTOP_CREATEMENU = 4;
  DESKTOP_HOOKCONTROL = 8;
  DESKTOP_JOURNALRECORD = $10;
  DESKTOP_JOURNALPLAYBACK = $20;
  DESKTOP_ENUMERATE = $40;
  DESKTOP_WRITEOBJECTS = 128;
  DESKTOP_SWITCHDESKTOP = $100;
                                     
  DF_ALLOWOTHERACCOUNTHOOK = 1;

  DESKTOP_ALL = DESKTOP_READOBJECTS or DESKTOP_CREATEWINDOW or 
                DESKTOP_CREATEMENU or DESKTOP_HOOKCONTROL or 
                DESKTOP_JOURNALRECORD or DESKTOP_JOURNALPLAYBACK or 
                DESKTOP_ENUMERATE or DESKTOP_WRITEOBJECTS or DESKTOP_SWITCHDESKTOP;
                      
type
  PDeviceModeA      = ^TDeviceModeA;
  PDeviceMode       = PDeviceModeA;
  TDeviceModeA      = packed record
    dmDeviceName    : array[0..CCHDEVICENAME - 1] of AnsiChar;
    dmSpecVersion   : Word;
    dmDriverVersion : Word;
    dmSize: Word;
    dmDriverExtra: Word;
    dmFields: DWORD;
    dmOrientation   : SHORT;
    dmPaperSize: SHORT;
    dmPaperLength   : SHORT;
    dmPaperWidth    : SHORT;
    dmScale: SHORT;
    dmCopies        : SHORT;
    dmDefaultSource : SHORT;
    dmPrintQuality  : SHORT;
    dmColor: SHORT;
    dmDuplex        : SHORT;
    dmYResolution   : SHORT;
    dmTTOption      : SHORT;
    dmCollate       : SHORT;
    dmFormName      : array[0..CCHFORMNAME - 1] of AnsiChar;
    dmLogPixels     : Word;
    dmBitsPerPel    : DWORD;
    dmPelsWidth     : DWORD;
    dmPelsHeight    : DWORD;
    dmDisplayFlags  : DWORD;
    dmDisplayFrequency: DWORD;
    dmICMMethod     : DWORD;
    dmICMIntent     : DWORD;
    dmMediaType     : DWORD;
    dmDitherType    : DWORD;
    dmICCManufacturer: DWORD;
    dmICCModel      : DWORD;
    dmPanningWidth  : DWORD;
    dmPanningHeight : DWORD;
  end;

  PDevMode          = PDeviceMode;  {compatibility with Delphi 1.0}
  TDevMode          = TDeviceModeA;  {compatibility with Delphi 1.0}

  function GetDoubleClickTime: UINT; stdcall; external user32 name 'GetDoubleClickTime';
  function SetDoubleClickTime(Interval: UINT): BOOL; stdcall; external user32 name 'SetDoubleClickTime';
  function GetSystemMetrics(nIndex: Integer): Integer; stdcall; external user32 name 'GetSystemMetrics';

  function ClientToScreen(AWnd: HWND; var lpPoint: TPoint): BOOL; stdcall; external user32 name 'ClientToScreen';
  function ScreenToClient(AWnd: HWND; var lpPoint: TPoint): BOOL; stdcall; external user32 name 'ScreenToClient';

  function CreateDesktopA(lpszDesktop, lpszDevice: PAnsiChar; pDevmode: PDeviceMode;
      dwFlags: DWORD; dwDesiredAccess: DWORD; lpsa: PSecurityAttributes): HDESK; stdcall; external user32 name 'CreateDesktopA';
  function OpenDesktopA(lpszDesktop: PAnsiChar; dwFlags: DWORD; fInherit: BOOL; dwDesiredAccess: DWORD): HDESK; stdcall; external user32 name 'OpenDesktopA';
  function OpenInputDesktop(dwFlags: DWORD; fInherit: BOOL; dwDesiredAccess: DWORD): HDESK; stdcall; external user32 name 'OpenInputDesktop';
  function EnumDesktopsA(Awinsta: HWINSTA; lpEnumFunc: TFNDeskTopEnumProc; lParam: LPARAM): BOOL; stdcall; external user32 name 'EnumDesktopsA';
  function EnumDesktopWindows(ADesktop: HDESK; lpfn: TFNWndEnumProc; lParam: LPARAM): BOOL; stdcall; external user32 name 'EnumDesktopWindows';
  function SwitchDesktop(ADesktop: HDESK): BOOL; stdcall; external user32 name 'SwitchDesktop';
  function SetThreadDesktop(ADesktop: HDESK): BOOL; stdcall; external user32 name 'SetThreadDesktop';
  function CloseDesktop(ADesktop: HDESK): BOOL; stdcall; external user32 name 'CloseDesktop';
  function GetThreadDesktop(dwThreadId: DWORD): HDESK; stdcall; external user32 name 'GetThreadDesktop';


const
  { Parameter for SystemParametersInfo() }
  SPI_GETBEEP = 1;
  SPI_SETBEEP = 2;
  SPI_GETMOUSE = 3;
  SPI_SETMOUSE = 4;
  SPI_GETBORDER = 5;
  SPI_SETBORDER = 6;
  SPI_GETKEYBOARDSPEED = 10;
  SPI_SETKEYBOARDSPEED = 11;
  SPI_LANGDRIVER = 12;
  SPI_ICONHORIZONTALSPACING = 13;

  // 屏保的时间
  SPI_GETSCREENSAVETIMEOUT = 14;
  SPI_SETSCREENSAVETIMEOUT = 15;
  // 屏保是否有效
  SPI_GETSCREENSAVEACTIVE = $10;
  SPI_SETSCREENSAVEACTIVE = 17; 
  // win9x 来屏蔽CTRL+ALT+DEL
  // http://topic.csdn.net/t/20020911/22/1016232.html
  // NT/2000中交互式的登陆支持是由WinLogon调用GINA DLL实现的，
  // GINA   DLL提供了一个交互式的界面为用户登陆提供认证请求。
  // 在WinLogon初始化时，就向系统注册截获CTRL+ALT+DEL消息，所以其他程序就无法得到CTRL+ALT+DEL的消息

  //  WinLogon初始化时会创建3个桌面： 
  //(1)、winlogon桌面：主要显示window   安全等界面，如你按下CTRL+ALT+DEL,登陆的界面等
  //(2)、应用程序桌面：我们平时见到的那个有我的电脑的界面
  //(3)、屏幕保护桌面：屏幕保护显示界面。
  // 用户登陆以后，按下CTRL+ALT+DEL键的时候，WinLogon回调用GINA   DLL的输出函数：WlxLoggedOnSAS， 
  // 这时正处于winlogon桌面，我们只要直接将他转向应用程序桌面，系统就不会显示Windows安全那个界面，换一种说法
  // 也就是用户按下CTRL+ALT+DEL后，不会起什么作用。当是我们在切换桌面的时候会出现屏幕闪动

  // 我们要在自己的程序中调用hMutex   =   CreateMutex(NULL,   FALSE,   "_ac952_z_cn_CTRL_ALT_DEL ");就可屏蔽CTRL+ALT+DEL
  SPI_SCREENSAVERRUNNING = 97;
  // 得到 屏保 是否在运行
  SPI_GETSCREENSAVERRUNNING = 114;


  SPI_GETGRIDGRANULARITY = 18;
  SPI_SETGRIDGRANULARITY = 19;
  SPI_SETDESKWALLPAPER = 20;
  SPI_SETDESKPATTERN = 21;
  SPI_GETKEYBOARDDELAY = 22;
  SPI_SETKEYBOARDDELAY = 23;
  SPI_ICONVERTICALSPACING = 24;
  SPI_GETICONTITLEWRAP = 25;
  SPI_SETICONTITLEWRAP = 26;
  SPI_GETMENUDROPALIGNMENT = 27;
  SPI_SETMENUDROPALIGNMENT = 28;
  SPI_SETDOUBLECLKWIDTH = 29;
  SPI_SETDOUBLECLKHEIGHT = 30;
  SPI_GETICONTITLELOGFONT = 31;
  SPI_SETDOUBLECLICKTIME = $20;
  SPI_SETMOUSEBUTTONSWAP = 33;
  SPI_SETICONTITLELOGFONT = 34;
  SPI_GETFASTTASKSWITCH = 35;
  SPI_SETFASTTASKSWITCH = 36;
  SPI_SETDRAGFULLWINDOWS = 37;
  SPI_GETDRAGFULLWINDOWS = 38;
  SPI_GETNONCLIENTMETRICS = 41;
  SPI_SETNONCLIENTMETRICS = 42;
  SPI_GETMINIMIZEDMETRICS = 43;
  SPI_SETMINIMIZEDMETRICS = 44;
  SPI_GETICONMETRICS = 45;
  SPI_SETICONMETRICS = 46;
  SPI_SETWORKAREA = 47;
  SPI_GETWORKAREA = 48;
  SPI_SETPENWINDOWS = 49;

  SPI_GETHIGHCONTRAST = 66;
  SPI_SETHIGHCONTRAST = 67;
  SPI_GETKEYBOARDPREF = 68;
  SPI_SETKEYBOARDPREF = 69;
  SPI_GETSCREENREADER = 70;
  SPI_SETSCREENREADER = 71;
  SPI_GETANIMATION    = 72;
  SPI_SETANIMATION = 73;
  SPI_GETFONTSMOOTHING = 74;
  SPI_SETFONTSMOOTHING = 75;
  SPI_SETDRAGWIDTH = 76;
  SPI_SETDRAGHEIGHT = 77;
  SPI_SETHANDHELD = 78;
  SPI_GETLOWPOWERTIMEOUT  = 79;
  SPI_GETPOWEROFFTIMEOUT  = 80;
  SPI_SETLOWPOWERTIMEOUT  = 81;
  SPI_SETPOWEROFFTIMEOUT  = 82;
  SPI_GETLOWPOWERACTIVE   = 83;
  SPI_GETPOWEROFFACTIVE   = 84;
  SPI_SETLOWPOWERACTIVE = 85;
  SPI_SETPOWEROFFACTIVE = 86;
  SPI_SETCURSORS = 87;
  SPI_SETICONS = 88;
  SPI_GETDEFAULTINPUTLANG = 89;
  SPI_SETDEFAULTINPUTLANG = 90;
  SPI_SETLANGTOGGLE = 91;
  SPI_GETWINDOWSEXTENSION = 92;
  SPI_SETMOUSETRAILS = 93;
  SPI_GETMOUSETRAILS = 94;
  SPI_GETFILTERKEYS = 50;
  SPI_SETFILTERKEYS = 51;
  SPI_GETTOGGLEKEYS = 52;
  SPI_SETTOGGLEKEYS = 53;
  SPI_GETMOUSEKEYS = 54;
  SPI_SETMOUSEKEYS = 55;
  SPI_GETSHOWSOUNDS = 56;
  SPI_SETSHOWSOUNDS = 57;
  SPI_GETSTICKYKEYS = 58;
  SPI_SETSTICKYKEYS = 59;
  SPI_GETACCESSTIMEOUT = 60;
  SPI_SETACCESSTIMEOUT = 61;
  SPI_GETSERIALKEYS = 62;
  SPI_SETSERIALKEYS = 63;
  SPI_GETSOUNDSENTRY = 64;
  SPI_SETSOUNDSENTRY = 65;

  SPI_GETSNAPTODEFBUTTON = 95;
  SPI_SETSNAPTODEFBUTTON = 96;
  SPI_GETMOUSEHOVERWIDTH = 98;
  SPI_SETMOUSEHOVERWIDTH = 99;
  SPI_GETMOUSEHOVERHEIGHT = 100;
  SPI_SETMOUSEHOVERHEIGHT = 101;
  SPI_GETMOUSEHOVERTIME = 102;
  SPI_SETMOUSEHOVERTIME = 103;
  SPI_GETWHEELSCROLLLINES = 104;
  SPI_SETWHEELSCROLLLINES = 105;         // For Win95 and WinNT3.51,
                                         // Mswheel broadcasts the message
                                         // WM_SETTINGCHANGE (equivalent to
                                         // WM_WININICHANGE) when the scroll
                                         // lines has changed.  Applications
                                         // will receive the WM_SETTINGCHANGE
                                         // message with the wParam set to
                                         // SPI_SETWHEELSCROLLLINES.  When
                                         // this message is received the
                                         // application should query Mswheel for
                                         // the new setting.
  SPI_GETMENUSHOWDELAY = 106;
  SPI_SETMENUSHOWDELAY = 107;
  SPI_GETSHOWIMEUI = 110;
  SPI_SETSHOWIMEUI = 111;
  SPI_GETMOUSESPEED = 112;
  SPI_SETMOUSESPEED = 113;


  SPI_GETACTIVEWINDOWTRACKING = $1000;
  SPI_SETACTIVEWINDOWTRACKING = $1001;
  SPI_GETMENUANIMATION = $1002;
  SPI_SETMENUANIMATION = $1003;
  SPI_GETCOMBOBOXANIMATION = $1004;
  SPI_SETCOMBOBOXANIMATION = $1005;
  SPI_GETLISTBOXSMOOTHSCROLLING = $1006;
  SPI_SETLISTBOXSMOOTHSCROLLING = $1007;
  SPI_GETGRADIENTCAPTIONS = $1008;
  SPI_SETGRADIENTCAPTIONS = $1009;
  SPI_GETKEYBOARDCUES = $100A;
  SPI_SETKEYBOARDCUES = $100B;
  SPI_GETMENUUNDERLINES = SPI_GETKEYBOARDCUES;
  SPI_SETMENUUNDERLINES = SPI_SETKEYBOARDCUES;
  SPI_GETACTIVEWNDTRKZORDER = $100C;
  SPI_SETACTIVEWNDTRKZORDER = $100D;
  SPI_GETHOTTRACKING = $100E;
  SPI_SETHOTTRACKING = $100F;

  SPI_GETMENUFADE = $1012;
  SPI_SETMENUFADE = $1013;
  SPI_GETSELECTIONFADE = $1014;
  SPI_SETSELECTIONFADE = $1015;
  SPI_GETTOOLTIPANIMATION = $1016;
  SPI_SETTOOLTIPANIMATION = $1017;
  SPI_GETTOOLTIPFADE = $1018;
  SPI_SETTOOLTIPFADE = $1019;
  SPI_GETCURSORSHADOW = $101A;
  SPI_SETCURSORSHADOW = $101B;

  SPI_GETMOUSESONAR = $101C;
  SPI_SETMOUSESONAR = $101D;
  SPI_GETMOUSECLICKLOCK = $101E;
  SPI_SETMOUSECLICKLOCK = $101F;
  SPI_GETMOUSEVANISH = $1020;
  SPI_SETMOUSEVANISH = $1021;
  SPI_GETFLATMENU = $1022;
  SPI_SETFLATMENU = $1023;
  SPI_GETDROPSHADOW = $1024;
  SPI_SETDROPSHADOW = $1025;

  SPI_GETUIEFFECTS = $103E;
  SPI_SETUIEFFECTS = $103F;

  SPI_GETFOREGROUNDLOCKTIMEOUT = $2000;
  SPI_SETFOREGROUNDLOCKTIMEOUT = $2001;
  SPI_GETACTIVEWNDTRKTIMEOUT = $2002;
  SPI_SETACTIVEWNDTRKTIMEOUT = $2003;
  SPI_GETFOREGROUNDFLASHCOUNT = $2004;
  SPI_SETFOREGROUNDFLASHCOUNT = $2005;
  SPI_GETCARETWIDTH = $2006;
  SPI_SETCARETWIDTH = $2007;
  SPI_GETMOUSECLICKLOCKTIME = $2008;
  SPI_SETMOUSECLICKLOCKTIME = $2009;
  SPI_GETFONTSMOOTHINGTYPE = $200A;
  SPI_SETFONTSMOOTHINGTYPE = $200B;

  { constants for SPI_GETFONTSMOOTHINGTYPE and SPI_SETFONTSMOOTHINGTYPE: }
  FE_FONTSMOOTHINGSTANDARD = $0001;
  FE_FONTSMOOTHINGCLEARTYPE = $0002;
  FE_FONTSMOOTHINGDOCKING = $8000;

  SPI_GETFONTSMOOTHINGCONTRAST = $200C;
  SPI_SETFONTSMOOTHINGCONTRAST = $200D;
  SPI_GETFOCUSBORDERWIDTH = $200E;
  SPI_SETFOCUSBORDERWIDTH = $200F;
  SPI_GETFOCUSBORDERHEIGHT = $2010;
  SPI_SETFOCUSBORDERHEIGHT = $2011;

  { Flags }
  SPIF_UPDATEINIFILE = 1;
  SPIF_SENDWININICHANGE = 2;
  SPIF_SENDCHANGE = SPIF_SENDWININICHANGE;
    
  function SystemParametersInfoA(uiAction, uiParam: UINT; pvParam: Pointer; fWinIni: UINT): BOOL; stdcall; external user32 name 'SystemParametersInfoA';
  
type
  TwDLLUser32       = record    
    Handle          : HModule;
  end;

  PGUIThreadInfo = ^TGUIThreadInfo;
  TGUIThreadInfo = packed record
    cbSize: DWORD;
    flags: DWORD;
    hwndActive: HWND;
    hwndFocus: HWND;
    hwndCapture: HWND;
    hwndMenuOwner: HWND;
    hwndMoveSize: HWND;
    hwndCaret: HWND;
    rcCaret: TRect;
  end;

const
  GUI_CARETBLINKING  = $00000001;
  GUI_INMOVESIZE     = $00000002;
  GUI_INMENUMODE     = $00000004;
  GUI_SYSTEMMENUMODE = $00000008;
  GUI_POPUPMENUMODE  = $00000010;

  function GetGUIThreadInfo (idThread: DWORD; var pgui: TGUIThreadinfo): BOOL; stdcall; external user32 name 'GetGUIThreadInfo';

  function ChangeDisplaySettingsA(var lpDevMode: TDeviceModeA; dwFlags: DWORD): Longint; stdcall; external user32 name 'ChangeDisplaySettingsA';
  function ChangeDisplaySettingsExA(lpszDeviceName: PAnsiChar; var lpDevMode: TDeviceModeA;
        wnd: HWND; dwFlags: DWORD; lParam: Pointer): Longint; stdcall; external user32 name 'ChangeDisplaySettingsExA';
  function EnumDisplaySettingsA(lpszDeviceName: PAnsiChar; iModeNum: DWORD;
    var lpDevMode: TDeviceModeA): BOOL; stdcall; external user32 name 'EnumDisplaySettingsA';

type
  PDisplayDeviceA = ^TDisplayDeviceA;
  PDisplayDevice = PDisplayDeviceA;
  TDisplayDeviceA = packed record
    cb: DWORD;
    DeviceName: array[0..31] of AnsiChar;
    DeviceString: array[0..127] of AnsiChar;
    StateFlags: DWORD;
  end;

  function EnumDisplayDevices(Unused: Pointer; iDevNum: DWORD;
    var lpDisplayDevice: TDisplayDeviceA; dwFlags: DWORD): BOOL; stdcall; external user32 name 'EnumDisplayDevicesA';
    
  function LoadCursorA(hInstance: THandle{HINST}; lpCursorName: PAnsiChar): HCURSOR; stdcall; external user32 name 'LoadCursorA';
  function LoadCursorW(hInstance: HINST; lpCursorName: PWideChar): HCURSOR; stdcall; external user32 name 'LoadCursorW';  
  function LoadCursorFromFileA(lpFileName: PAnsiChar): HCURSOR; stdcall; external user32 name 'LoadCursorFromFileA';
  function CreateCursor(hInst: THandle{HINST}; xHotSpot, yHotSpot, nWidth, nHeight: Integer;
    pvANDPlaneter, pvXORPlane: Pointer): HCURSOR; stdcall; external user32 name 'CreateCursor';
  function DestroyCursor(hCursor: HICON): BOOL; stdcall; external user32 name 'DestroyCursor';
  function ShowCursor(bShow: BOOL): Integer; stdcall; external user32 name 'ShowCursor';
  function GetCursor: HCURSOR; stdcall; external user32 name 'GetCursor';
  function GetCursorPos(var lpPoint: TPoint): BOOL; stdcall; external user32 name 'GetCursorPos';

type
  { Information about the global cursor. }
  PCursorInfo = ^TCursorInfo;
  TCursorInfo = packed record
    cbSize: DWORD;
    flags: DWORD;
    hCursor: HCURSOR;
    ptScreenPos: TPoint;
  end;

const
  CURSOR_SHOWING = $00000001;

  function GetCursorInfo(var pci: TCursorInfo): BOOL; stdcall; external user32 name 'GetCursorInfo';

  function SetCursor(hCursor: HICON): HCURSOR; stdcall; external user32 name 'SetCursor';
  function SetCursorPos(X, Y: Integer): BOOL; stdcall; external user32 name 'SetCursorPos';
  function ClipCursor(lpRect: PRect): BOOL; stdcall; external user32 name 'ClipCursor';
  function GetClipCursor(var lpRect: TRect): BOOL; stdcall; external user32 name 'GetClipCursor';

  function OpenClipboard(hWndNewOwner: HWND): BOOL; stdcall; external user32 name 'OpenClipboard';
  function CloseClipboard: BOOL; stdcall; external user32 name 'CloseClipboard';

  function CallNextHookEx(hhk: HHOOK; nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; external user32 name 'CallNextHookEx';

const

  IDI_APPLICATION = PAnsiChar(32512);
  IDI_HAND = PAnsiChar(32513);
  IDI_QUESTION = PAnsiChar(32514);
  IDI_EXCLAMATION = PAnsiChar(32515);
  IDI_ASTERISK = PAnsiChar(32516);
  IDI_WINLOGO = PAnsiChar(32517);
  IDI_WARNING = IDI_EXCLAMATION;
  IDI_ERROR = IDI_HAND;
  IDI_INFORMATION = IDI_ASTERISK;

  function LoadIconA(AInstance: HINST; lpIconName: PAnsiChar): HICON; stdcall; external user32 name 'LoadIconA';
  
const
  CCHILDREN_SCROLLBAR          =   5;

type                
  { Scrollbar information }
  PScrollBarInfo = ^TScrollBarInfo;
  TScrollBarInfo = packed record
    cbSize: DWORD;
    rcScrollBar: TRect;
    dxyLineButton: Integer;
    xyThumbTop: Integer;
    xyThumbBottom: Integer;
    bogus: Integer;
    rgstate: array[0..CCHILDREN_SCROLLBAR] of DWORD;
  end;

  PScrollInfo = ^TScrollInfo;
  TScrollInfo = packed record
    cbSize: UINT;
    fMask: UINT;
    nMin: Integer;
    nMax: Integer;
    nPage: UINT;
    nPos: Integer;
    nTrackPos: Integer;
  end;

  Function GetScrollBarInfo(hwnd: HWND; idObject: Longint; var psbi: TScrollBarInfo): BOOL; stdcall; external user32 name 'GetScrollBarInfo';
  function GetScrollInfo(hWnd: HWND; BarFlag: Integer; var ScrollInfo: TScrollInfo): BOOL; stdcall; external user32 name 'GetScrollInfo';
  function SetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer; stdcall; external user32 name 'SetScrollInfo';
  function GetScrollPos(hWnd: HWND; nBar: Integer): Integer; stdcall; external user32 name 'GetScrollPos';
  function SetScrollPos(hWnd: HWND; nBar, nPos: Integer; bRedraw: BOOL): Integer; stdcall; external user32 name 'SetScrollPos';
  function GetScrollRange(hWnd: HWND; nBar: Integer; var lpMinPos, lpMaxPos: Integer): BOOL; stdcall; external user32 name 'GetScrollRange';
  function SetScrollRange(hWnd: HWND; nBar, nMinPos, nMaxPos: Integer; bRedraw: BOOL): BOOL; stdcall; external user32 name 'SetScrollRange';
  function ShowScrollBar(hWnd: HWND; wBar: Integer; bShow: BOOL): BOOL; stdcall; external user32 name 'ShowScrollBar';
  function EnableScrollBar(hWnd: HWND; wSBflags, wArrows: UINT): BOOL; stdcall; external user32 name 'EnableScrollBar';

type
  PAltTabInfo = ^TAltTabInfo;
  TAltTabInfo = packed record
    cbSize: DWORD;
    cItems: Integer;
    cColumns: Integer;
    cRows: Integer;
    iColFocus: Integer;
    iRowFocus: Integer;
    cxItem: Integer;
    cyItem: Integer;
    ptStart: TPoint;
  end;

  function GetAltTabInfo(Awnd: HWND; iItem: Integer; var pati: TAltTabInfo;
    pszItemText: PAnsiChar; cchItemText: UINT): BOOL; stdcall; external user32 name 'GetAltTabInfoA';     
  function GetSysColor(nIndex: Integer): DWORD; stdcall; external user32 name 'GetSysColor';
  function GetSysColorBrush(nIndex: Integer): HBRUSH; stdcall; external user32 name 'GetSysColorBrush';
  
  function AttachThreadInput(idAttach, idAttachTo: DWORD; fAttach: BOOL): BOOL; stdcall; external user32 name 'AttachThreadInput';

implementation

end.
