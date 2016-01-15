{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_win;

interface

uses
  atmcmbaseconst, winconst, wintype, wintypeA;

const
  SW_HIDE           = 0;
  SW_NORMAL         = 1;
  SW_SHOWMINIMIZED  = 2;
  SW_MAXIMIZE       = 3;
  SW_SHOWNOACTIVATE = 4;
  SW_SHOW           = 5;
  SW_MINIMIZE       = 6;
  SW_SHOWMINNOACTIVE= 7;
  SW_SHOWNA         = 8;
  SW_RESTORE        = 9;
  SW_SHOWDEFAULT    = 10;
  SW_MAX            = 10;

  { Old ShowWindow() Commands }
  {$EXTERNALSYM HIDE_WINDOW}
  HIDE_WINDOW       = 0;
  SHOW_OPENWINDOW   = 1;
  SHOW_ICONWINDOW   = 2;
  SHOW_FULLSCREEN   = 3;
  SHOW_OPENNOACTIVATE = 4;

  { Identifiers for the WM_SHOWWINDOW message }
  SW_PARENTCLOSING  = 1;
  SW_OTHERZOOM      = 2;
  SW_PARENTOPENING  = 3;
  SW_OTHERUNZOOM    = 4;
                   
  SWP_NOSIZE = 1;
  SWP_NOMOVE = 2;
  SWP_NOZORDER = 4;
  SWP_NOREDRAW = 8;
  SWP_NOACTIVATE = $10;
  SWP_FRAMECHANGED = $20;    { The frame changed: send WM_NCCALCSIZE }
  SWP_SHOWWINDOW = $40;
  SWP_HIDEWINDOW = $80;
  SWP_NOCOPYBITS = $100;
  SWP_NOOWNERZORDER = $200;  { Don't do owner Z ordering }
  SWP_NOSENDCHANGING = $400;  { Don't send WM_WINDOWPOSCHANGING }
  SWP_DRAWFRAME = SWP_FRAMECHANGED;
  SWP_NOREPOSITION = SWP_NOOWNERZORDER;
  SWP_DEFERERASE = $2000;
  SWP_ASYNCWINDOWPOS = $4000;
                          
  { Window Styles }
  WS_OVERLAPPED = 0;
  WS_POPUP = DWORD($80000000);

  // 创建一个子窗口。不能与WS_POPUP风格一起使用
  WS_CHILD = $40000000;
  WS_MINIMIZE = $20000000;
  WS_VISIBLE = $10000000;
  WS_DISABLED = $8000000;

  // 剪裁相关的子窗口，这意味着，当一个特定的子窗口接收到重绘消息时，
  // WS_CLIPSIBLINGS风格将在子窗口要重画的区域中去掉与其它子窗口重叠的部分。
  // （如果没有指定WS_CLIPSIBLINGS风格，并且子窗口有重叠，当你在一个子窗口的客户区绘图时，
  // 它可能会画在相邻的子窗口的客户区中。）只与WS_CHILD风格一起使用

  // http://blog.csdn.net/klarclm/article/details/7493126
  // WS_CLIPSIBLINGS实际上还需要和控件的叠放顺序（z order）配合使用,才能看出明显的效果
  WS_CLIPSIBLINGS = $4000000;
  // 裁减兄弟窗口
  // 子窗口间相互裁减。也就是说当两个窗口相互重叠时，
  // 设置了WS_CLIPSIBLINGS样式的子窗口重绘时不能绘制
  // 被重叠的部分。反之没有设置WS_CLIPSIBLINGS样式的
  // 子窗口重绘时是不考虑重叠不重叠，统统重绘
  // 当你在父窗口中绘图时，除去子窗口所占的区域。在创建父窗口的时候使用

  //** 这两个属性很重要 不设置容易引起 闪烁
  WS_CLIPCHILDREN = $2000000;
  // 裁减子窗口
  // WS_CLIPCHILDREN样式主要是用于父窗口，也就是说当在父窗口绘制的时候，
  // 父窗口上还有一个子窗口，那么设置了这个样式的话，子窗口区域父窗口就不负责绘制


  WS_MAXIMIZE = $1000000;
  WS_CAPTION = $C00000;      { WS_BORDER or WS_DLGFRAME  }
  WS_BORDER = $800000;
  WS_DLGFRAME = $400000;
  WS_VSCROLL = $200000;
  WS_HSCROLL = $100000;
  WS_SYSMENU = $80000;
  WS_THICKFRAME = $40000;

  // WS_TABSTOP&WS_GROUP
  WS_GROUP = $20000;
  WS_TABSTOP = $10000;

  WS_MINIMIZEBOX = $20000;
  WS_MAXIMIZEBOX = $10000;

  WS_TILED = WS_OVERLAPPED;
  WS_ICONIC = WS_MINIMIZE;
  WS_SIZEBOX = WS_THICKFRAME;

  { Common Window Styles }
  WS_OVERLAPPEDWINDOW = (WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_THICKFRAME or WS_MINIMIZEBOX or WS_MAXIMIZEBOX);
  WS_TILEDWINDOW = WS_OVERLAPPEDWINDOW;
  WS_POPUPWINDOW = (WS_POPUP or WS_BORDER or WS_SYSMENU);
  WS_CHILDWINDOW = (WS_CHILD);

  { Extended Window Styles }
  // 创建一个带双边框的窗口，该窗口可以在
  // dwStyle 中指定 WS_CAPTION 风格来创建一个标题栏
  WS_EX_DLGMODALFRAME = 1;

  // 指明以这个风格创建的子窗口在被创建和销毁时不向父窗口发送 WM_PARENTNOTIFY 消息
  WS_EX_NOPARENTNOTIFY = 4;

  // 指明以该风格创建的窗口应始终放置在所有非最顶层窗口的上面，
  // 即使窗口未被激活。可使用 SetWindowPos 函数来设置和移去这个风格
  WS_EX_TOPMOST = 8;
  // 该风格的窗口可以接受一个拖拽文件
  WS_EX_ACCEPTFILES = $10;

  // 指定以这个风格创建的窗口在窗口下的同属窗口已重画时，
  // 该窗口才可以重画。由于其下的同属富口已被重画，所以该窗口是透明的
  WS_EX_TRANSPARENT = $20;
  
  // 创建一个 MDI 子窗口
  WS_EX_MDICHILD = $40;

  // 创建一个工具窗口，即窗口是一个浮动的工具条。工具窗口的标题栏比一般窗口的标题栏短，
  // 并且窗口标题栏以小字体显示。工具窗口不在任务栏里显示，当用户按下 ALT+TAB 键时工具
  // 窗口不在对话框里显示。如果工具窗口有一个系统菜单，它的图标也不会显示在标题栏里，
  // 但是，可以通过点击鼠标右键或使用 ALT+SPACE 键来显示菜单。
  WS_EX_TOOLWINDOW = $80;

  // 指定窗口具有凸起的边框
  WS_EX_WINDOWEDGE = $100;

  // 指定窗口有一个带阴影的边界
  WS_EX_CLIENTEDGE = $200;

  // 在窗口的标题栏包含一个问号标志
  // WS_EX_CONTEXTHELP不能与WS_MAXIMIZEBOX和WS_MINIMIZEBOX同时使用
  WS_EX_CONTEXTHELP = $400;

  WS_EX_RIGHT = $1000;
  WS_EX_LEFT = 0;
  WS_EX_RTLREADING = $2000;
  WS_EX_LTRREADING = 0;
  // 外壳语言是如 Hebrew、Arabic或其他支持 reading order alignment 的语言，
  // 则标题栏（如果存在）在客户区的左部分。若是其他语言，该风格被忽略
  WS_EX_LEFTSCROLLBAR = $4000;
  WS_EX_RIGHTSCROLLBAR = 0;

  // 允许用户使用 Tab 键等在窗口的子窗口间搜索
  WS_EX_CONTROLPARENT = $10000;
  WS_EX_STATICEDGE = $20000;
  WS_EX_APPWINDOW = $40000; // 当窗口可见时，将一个顶层窗口放置到任务栏上
  WS_EX_OVERLAPPEDWINDOW = (WS_EX_WINDOWEDGE or WS_EX_CLIENTEDGE);
  WS_EX_PALETTEWINDOW = (WS_EX_WINDOWEDGE or WS_EX_TOOLWINDOW or WS_EX_TOPMOST);

  // Windows 2000/XP：创建一个层窗口（layered window），该样式不能应用于子窗口，
  // 并且不能用于拥有CS_OWNDC 或 CS_CLASSDC 风格的窗口
  WS_EX_LAYERED = $00080000;

  // Windows 2000/XP： 使用该风格创建的窗口不会将窗口布局传递到子窗口
  WS_EX_NOINHERITLAYOUT = $00100000; // Disable inheritence of mirroring by children
  // Windows 2000/XP： 窗口水平坐标原点在窗口右边界，水平坐标从右向左递增
  WS_EX_LAYOUTRTL = $00400000; // Right to left mirroring

  // Windows XP：使用双缓冲区绘制所有子窗口
  // 当窗口含有 CS_OWNDC 或 CS_CLASSDC 样式时不能指定该样式
  WS_EX_COMPOSITED = $02000000;

  // Windows 2000/XP：对于使用该样式创建的始终在最顶层的窗口，
  // 当用户单击它时不会将其设为前台窗口，并且在用户将现有的前台窗口最小化或关闭时，
  // 也不会将该窗口设为前台窗口。要激活该窗口，可使用 SetActiveWindow 或 SetForegroundWindow 函数。
  // 默认情况下窗口不会在任务栏上出现，要使窗口在任务栏上显示，可指定 WS_EX_APPWINDOW 风格
  WS_EX_NOACTIVATE = $08000000;

type
  PWindowPlacement = ^TWindowPlacement;
  TWindowPlacement = packed record
    length: UINT;
    flags: UINT;
    showCmd: UINT;
    ptMinPosition: TPoint;
    ptMaxPosition: TPoint;
    rcNormalPosition: TRect;
  end;

  PWindowInfo = ^TWindowInfo;
  TWindowInfo = packed record
    cbSize: DWORD;
    rcWindow: TRect;
    rcClient: TRect;
    dwStyle: DWORD;
    dwExStyle: DWORD;
    dwOtherStuff: DWORD;
    cxWindowBorders: UINT;
    cyWindowBorders: UINT;
    atomWindowType: TAtom;
    wCreatorVersion: WORD;
  end;

  TWNDPROC = function (AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
  
const
  GWL_WNDPROC = -4;
  GWL_HINSTANCE = -6;
  GWL_HWNDPARENT = -8;
  GWL_STYLE = -16;
  GWL_EXSTYLE = -20;
  GWL_USERDATA = -21;
  GWL_ID = -12;

  function GetWindowInfo(AWnd: HWND; var pwi: TWindowInfo): BOOL; stdcall; external user32 name 'GetWindowInfo';

  function SetWindowLongA(AWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint; stdcall; external user32 name 'SetWindowLongA';
  function GetWindowLongA(AWnd: HWND; nIndex: Integer): Longint; stdcall; external user32 name 'GetWindowLongA';

  function IsHungAppWindow(Awnd : HWND): boolean; stdcall; external user32 name 'IsHungAppWindow';

  procedure NotifyWinEvent(event: DWORD; hwnd: HWND; idObject, idChild: Cardinal); stdcall; external user32 name 'NotifyWinEvent';
  function DefWindowProcA(AWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; external user32 name 'DefWindowProcA';
  function CallWindowProcA(lpPrevWndFunc: TFNWndProc; AWnd: HWND; Msg: UINT; wParam: WPARAM;
    lParam: LPARAM): LRESULT; stdcall; external user32 name 'CallWindowProcA';
  
  { //uCmd 可选值:       
  GW_HWNDFIRST = 0;
  GW_HWNDLAST = 1;
  GW_HWNDNEXT = 2;  //同级别 Z 序之下
  GW_HWNDPREV = 3; //同级别 Z 序之上
  GW_OWNER = 4;
  GW_CHILD = 5;
  }
  function GetWindow(AWnd: HWND; uCmd: UINT): HWND; stdcall; external user32 name 'GetWindow';
  // 获取指定窗口的子窗口中最顶层的窗口句柄
  function GetTopWindow(AWnd: HWND): HWND; stdcall; external user32 name 'GetTopWindow';
  function FindWindowA(lpClassName, lpWindowName: PAnsiChar): HWND; stdcall; external user32 name 'FindWindowA';
  function FindWindowExA(AParent, AChild: HWND; AClassName, AWindowName: PAnsiChar): HWND; stdcall; external user32 name 'FindWindowExA';
//  function GetWindowThreadProcessId(AWnd: HWND; var dwProcessId: DWORD): DWORD; stdcall; overload; external user32 name 'GetWindowThreadProcessId';
  function GetWindowThreadProcessId(AWnd: HWND; lpdwProcessId: Pointer): DWORD; stdcall; overload; external user32 name 'GetWindowThreadProcessId';
  
  function ShowWindow(AWnd: HWND; nCmdShow: Integer): BOOL; stdcall; external user32 name 'ShowWindow';
  function UpdateWindow(AWnd: HWND): BOOL; stdcall; external user32 name 'UpdateWindow';
  function ExitWindowsEx(uFlags: UINT; dwReserved: DWORD): BOOL; stdcall; external user32 name 'ExitWindowsEx';
                                
  function CreateWindowExA(dwExStyle: DWORD; lpClassName: PAnsiChar;
    lpWindowName: PAnsiChar; dwStyle: DWORD; X, Y, nWidth, nHeight: Integer;
    AWndParent: HWND; AMenu: HMENU; hInstance: HINST; lpParam: Pointer): HWND; stdcall; external user32 name 'CreateWindowExA';
  function CreateWindowExW(dwExStyle: DWORD; lpClassName: PWideChar;
    lpWindowName: PWideChar; dwStyle: DWORD; X, Y, nWidth, nHeight: Integer;
    AWndParent: HWND; AMenu: HMENU; hInstance: HINST; lpParam: Pointer): HWND; stdcall; external user32 name 'CreateWindowExW';

  function GetDesktopWindow: HWND; stdcall; external user32 name 'GetDesktopWindow';

  function SetParent(AWndChild, AWndNewParent: HWND): HWND; stdcall; external user32 name 'SetParent';
  function SwitchToThisWindow(AWnd: hwnd; fAltTab: boolean): boolean; stdcall; external user32;
  function IsWindow(AWnd: HWND): BOOL; stdcall; external user32 name 'IsWindow';
  function DestroyWindow(AWnd: HWND): BOOL; stdcall; external user32 name 'DestroyWindow';
  function SetPropA(AWnd: HWND; lpStr: PAnsiChar; hData: THandle): BOOL; stdcall; external user32 name 'SetPropA';
  function SetTimer(AWnd: HWND; nIDEvent, uElapse: UINT; lpTimerFunc: TFNTimerProc): UINT; stdcall; external user32 name 'SetTimer';
  function KillTimer(AWnd: HWND; uIDEvent: UINT): BOOL; stdcall; external user32 name 'KillTimer';

  function InvalidateRect(AWnd: HWND; lpRect: PRect; bErase: BOOL): BOOL; stdcall; external user32 name 'InvalidateRect';

  {
    Invalidate()是强制系统进行重画，但是不一定就马上进行重画。因为Invalidate()只是通知系统，
        此时的窗口已经变为无效。强制系统调用WM_PAINT，而这个消息只是Post就是将该消息放入消息队列。
        当执行到WM_PAINT消息时才会对敞口进行重绘。
    UpdateWindow只向窗体发送WM_PAINT消息，在发送之前判断GetUpdateRect(hWnd,NULL,TRUE)看有无可绘制的客户区域，
        如果没有，则不发送WM_PAINT。
    RedrawWindow()则是具有Invalidate()和UpdateWindow()的双特性。声明窗口的状态为无效，并立即更新窗口，立即调用WM_PAINT消息处理。

    InvalidateRect(hctrl,null,true) ;
    UpdateWindow(hctrl); 这两个函数组合起来是什么意思呢？
    InvalidateRect是会触发WM_PAINT事件，但是不是立即就触发，一般都会等当前操作的过程结束才触发， 如果需要立即触发，
    那么配合UpdateWindow()使用就可以了。先执行InvalidateRect，再执行UpdateWindow().
    
    flag 　
      RDW_INVALIDATE or RDW_VALIDATE or RDW_FRAME
      RDW_ERASENOW
      RDW_UPDATENOW 
      RDW_ERASE 重画前，先清除重画区域的背景。也必须指定RDW_INVALIDATE
      RDW_NOERASE  禁止删除重画区域的背景
      RDW_NOFRAME  禁止非客户区域重画
  }
  function RedrawWindow(AWnd: HWND; lprcUpdate: PRect; hrgnUpdate: HRGN; flags: UINT): BOOL; stdcall; external user32 name 'RedrawWindow';
  function MessageBoxA(AWnd: HWND; lpText, lpCaption: PAnsiChar; uType: UINT): Integer; stdcall; external user32 name 'MessageBoxA';

(*
    禁止截屏PrintScreen
    FormCreate
    RegisterHotKey(Handle, IDHOT_SNAPDESKTOP, 0, VK_SNAPSHOT);
    FormClose
    UnregisterHotKey(Handle, IDHOT_SNAPDESKTOP);
    FormActivate
    RegisterHotKey (Handle, IDHOT_SNAPWINDOW, MOD_ALT, VK_SNAPSHOT);
    FormDeactivate
    UnregisterHotKey(Handle, IDHOT_SNAPWINDOW);
*)
const
  IDHOT_SNAPWINDOW = -1;    { SHIFT-PRINTSCRN  }
  IDHOT_SNAPDESKTOP = -2;   { PRINTSCRN        }

  function RegisterHotKey(AWnd: HWND; id: Integer; fsModifiers, vk: UINT): BOOL; stdcall; external user32 name 'RegisterHotKey';
  function UnregisterHotKey(AWnd: HWND; id: Integer): BOOL; stdcall; external user32 name 'UnregisterHotKey';
                                 
  function GetCapture: HWND; stdcall; external user32 name 'GetCapture';
  
  { setCapture捕获以下鼠标事件：
       onmousedown、
       onmouseup、
       onmousemove、
       onclick、
       ondblclick、
       onmouseover和
       onmouseout,
       
    SetCapture会引起失去鼠标捕获的窗口接收一个WM_CAPTURECHANGED消息
    该函数在属于当前线程的指定窗口里设置鼠标捕获。一旦窗口捕获了鼠标，
    所有鼠标输入都针对该窗口，无论光标是否在窗口的边界内。同一时刻只能
    有一个窗口捕获鼠标。如果鼠标光标在另一个线程创建的窗口上，只有当鼠
    标键按下时系统才将鼠标输入指向指定的窗口

    此函数不能被用来捕获另一进程的鼠标输入

    TSplitter 需要调用这个函数

    Mouseup ReleaseCapture
  }
  function SetCapture(AWnd: HWND): HWND; stdcall; external user32 name 'SetCapture';
  function ReleaseCapture: BOOL; stdcall; external user32 name 'ReleaseCapture';

  function GetClassInfoA(AInstance: HINST; lpClassName: PAnsiChar; var lpWndClass: TWndClassA): BOOL; stdcall; external user32 name 'GetClassInfoA';
  function GetClassInfoExA(AInstance: HINST; Classname: PAnsiChar; var WndClass: TWndClassExA): BOOL; stdcall; external user32 name 'GetClassInfoExA';
  function GetClassNameA(AWnd: HWND; lpClassName: PAnsiChar; nMaxCount: Integer): Integer; stdcall; external user32 name 'GetClassNameA';
  
const
  { Class styles }
  CS_VREDRAW = DWORD(1);
  CS_HREDRAW = DWORD(2);
  CS_KEYCVTWINDOW = 4;
  CS_DBLCLKS = 8;
  CS_OWNDC = $20;
  CS_CLASSDC = $40;
  CS_PARENTDC = $80;
  CS_NOKEYCVT = $100;

  // 则窗口上的关闭按钮和系统菜单上的关闭命令失效
  CS_NOCLOSE = $200;

  // 菜单，对话框，下拉框都拥有CS_SAVEBITS标志。当窗口使用这个标志时，
  // 系统用位图形式保存一份被窗口遮盖（或灰隐）的屏幕图象
  CS_SAVEBITS = $800;
  CS_BYTEALIGNCLIENT = $1000;
  CS_BYTEALIGNWINDOW = $2000;


  // http://blog.csdn.net/nskevin/article/details/2939857
   
  // window系统提供了三种类型的窗口类
  // 系统全局类（System global classes）
  // 应用程序全局类（Application global classes）
  //     CS_GLOBALCLASS
  //     应用程序全局类只是在进程内部的“全局”而已。这是什么意思呢？一个DLL或.EXE可以注册一个类，
  //     这个类可以让在相同的进程空间里其他.EXE和DLL使用。如果一个DLL注册了一个非应用程序全局类的窗口类，
  //     那么，只有该DLL可以使用该类，同样的，.EXE里注册的非应用程序全局类也适用这个规则，即该类只在该.EXE里有效
  //     作为这个特性的扩展，win32有一项技术，允许一个第三方窗口控件在DLL里实现，然后把这个DLL载入和初始化到每个
  //     Win32进程空间里。这项技术的细节是，把DLL的名字写入注册表的指定键值里：
  //  HKEY_LOCAL_MACHINE/Software/Microsoft/Windows NT/CurrentVersion/Windows/APPINIT_DLLS
  //  这样当任意一个win32应用程序加载的时候，系统也同时将该dll加载到进程空间里（这可能有点过于奢侈，
  //  因为很多win32程序不一定会使用该控件）。DLL在初始化的时候注册应用程序全局类，这样的窗口类就可以
  //  在每个进程空间的.EXE或DLL里使用了。这个技术基于win32系统的这个特性：允许在每个进程空间里自动的
  //  （也是强制的）加载特定的DLL（事实上，这也是打破进程边界，把你的代码切入到其他进程里的一种办法）
  // 应用程序局部类（Application local classes）

  // windows 本身注册了几个系统全局类供全部的应用程序使用，这些类包括了以下的常用标准窗口控件
  // Listbox , ComboBox , ScrollBar , Edit , Button , Static
  // 所有的win32应用程序都可以使用系统全局类，但不能增加或删除一个这样的类 

  // 应用程序局部类是由应用程序注册的并由它自己专用的窗口类，
  // 尽管应用程序可以注册任意数目的局部类，但绝大多数应用程序只注册一个，
  // 这个窗口类支持应用程序主窗口的窗口过程。
  // 注册应用程序局部类与注册一个应用程序全局类差不多，
  // 只是WNDCLASSEX结构的style成员没有设置成CS_GLOBALCLASS风格。
  // windows系统销毁一个局部类是在注册它的应用程序关闭时，
  // 应用程序也可用函数UnregisterClass来删除一个局部类并释放与之相关的内存空间。  
  CS_GLOBALCLASS = $4000;

  CS_IME = $10000;
  CS_DROPSHADOW = $20000;

  function RegisterClassA(const lpWndClass: TWndClassA): ATOM; stdcall; external user32 name 'RegisterClassA';
  function RegisterClassExA(const WndClass: TWndClassExA): ATOM; stdcall; external user32 name 'RegisterClassExA';
  function UnregisterClassA(lpClassName: PAnsiChar; hInstance: HINST): BOOL; stdcall; external user32 name 'UnregisterClassA';

  function OpenIcon(AWnd: HWND): BOOL; stdcall; external user32 name 'OpenIcon';
  function CloseWindow(AWnd: HWND): BOOL; stdcall; external user32 name 'CloseWindow';
  function MoveWindow(AWnd: HWND; X, Y, nWidth, nHeight: Integer; bRepaint: BOOL): BOOL; stdcall; external user32 name 'MoveWindow';

  {
    // hWndInsertAfter: HWND_BOTTOM, HWND_NOTOPMOST, HWND_TOP, HWND_TOPMOST
    // 设置窗体 ZOrder
    // SWP_NOACTIVATE
    hWndInsertAfter 在z序中的位于被置位的窗口前的窗口句柄
    hWndInsertAfter 置于 hWnd 之前 
    // SetWindowPos(FHandle, Pos, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
  }
  function SetWindowPos(AWnd: HWND; hWndInsertAfter: HWND; X, Y, cx, cy: Integer; uFlags: UINT): BOOL; stdcall; external user32 name 'SetWindowPos';
  function GetWindowPlacement(AWnd: HWND; WindowPlacement: PWindowPlacement): BOOL; stdcall; external user32 name 'GetWindowPlacement';
  function SetWindowPlacement(AWnd: HWND; WindowPlacement: PWindowPlacement): BOOL; stdcall; external user32 name 'SetWindowPlacement';
  function GetWindowModuleFileName(Awnd: HWND; pszFileName: PAnsiChar; cchFileNameMax: UINT): UINT; stdcall; external user32 name 'GetWindowModuleFileNameA';
  function BringWindowToTop(AWnd: HWND): BOOL; stdcall; external user32 name 'BringWindowToTop';
  function IsZoomed(AWnd: HWND): BOOL; stdcall; external user32 name 'IsZoomed';
  function GetClientRect(AWnd: HWND; var lpRect: TRect): BOOL; stdcall; external user32 name 'GetClientRect';
  function GetWindowRect(AWnd: HWND; var lpRect: TRect): BOOL; stdcall; external user32 name 'GetWindowRect';

  function GetUpdateRgn(AWnd: HWND; hRgn: HRGN; bErase: BOOL): Integer; stdcall; external user32 name 'GetUpdateRgn';
  function SetWindowRgn(AWnd: HWND; hRgn: HRGN; bRedraw: BOOL): Integer; stdcall; external user32 name 'SetWindowRgn';
  function GetWindowRgn(AWnd: HWND; hRgn: HRGN): Integer; stdcall; external user32 name 'GetWindowRgn';

  function GetUpdateRect(AWnd: HWND; lpRect: PRect; bErase: BOOL): BOOL; stdcall; external user32 name 'GetUpdateRect';
  function ExcludeUpdateRgn(ADC: HDC; hWnd: HWND): Integer; stdcall; external user32 name 'ExcludeUpdateRgn';
  
  function WindowFromPoint(APoint: TPoint): HWND; stdcall; external user32 name 'WindowFromPoint';
  function ChildWindowFromPoint(AWndParent: HWND; Point: TPoint): HWND; stdcall; external user32 name 'ChildWindowFromPoint';

  (*
    http://blog.sina.com.cn/s/blog_48f93b530100jonm.html
    多层次窗口调整大小
      如果窗口包含很多子窗口，当我们调整窗口大小时，可能要同时调整子窗口的位置和大小。
      此时若使用 MoveWindow() 或 SetWindowPos() 等函数进行调整，由于这些函数会等窗口
      刷新完才返回，因此当有大量子窗口时，这个过程肯定会引起闪烁。
      这时我们可以应用 BeginDeferWindowPos(), DeferWindowPos() 和 EndDeferWindowPos()
      三个函数解决。首先调用 BeginDeferWindowPos()，设定需要调整的窗口个数；然后用
      DeferWindowPos() 移动窗口（并非立即移动窗口）；最后调用 EndDeferWindowPos()
      一次性完成所有窗口的调整
  *)

type
  HDWP = THandle;
    
  function BeginDeferWindowPos(nNumWindows: Integer): HDWP; stdcall; external user32 name 'BeginDeferWindowPos';
  function DeferWindowPos(AWinPosInfo: HDWP; AWnd: HWND; AWndInsertAfter: HWND;
    x, y, cx, cy: Integer; uFlags: UINT): HDWP; stdcall; external user32 name 'DeferWindowPos';
  function EndDeferWindowPos(AWinPosInfo: HDWP): BOOL; stdcall; external user32 name 'EndDeferWindowPos';

const
  CWP_ALL = 0;
  CWP_SKIPINVISIBLE = 1;
  CWP_SKIPDISABLED = 2;
  CWP_SKIPTRANSPARENT = 4;

  function ChildWindowFromPointEx(AWnd: HWND; Point: TPoint; Flags: UINT): HWND; stdcall; external user32 name 'ChildWindowFromPointEx';
  function IsWindowVisible(AWnd: HWND): BOOL; stdcall; external user32 name 'IsWindowVisible';
  function SetFocus(AWnd: HWND): HWND; stdcall; external user32 name 'SetFocus';
  function GetActiveWindow: HWND; stdcall; external user32 name 'GetActiveWindow';
  function GetFocus: HWND; stdcall; external user32 name 'GetFocus';
  function GetForegroundWindow: HWND; stdcall; external user32 name 'GetForegroundWindow';
  function SetForegroundWindow(AWnd: HWND): BOOL; stdcall; external user32 name 'SetForegroundWindow';

type
  PTrackMouseEvent = ^TTrackMouseEvent;
  TTrackMouseEvent = record
    cbSize: DWORD;
    dwFlags: DWORD;
    hwndTrack: HWND;
    dwHoverTime: DWORD;
  end;

const
  { Key State Masks for Mouse Messages }
  MK_LBUTTON = 1;
  MK_RBUTTON = 2;
  MK_SHIFT = 4;
  MK_CONTROL = 8;
  MK_MBUTTON = $10;

  TME_HOVER           = $00000001;
  TME_LEAVE           = $00000002;
  TME_QUERY           = $40000000;
  TME_CANCEL          = DWORD($80000000);
  HOVER_DEFAULT       = DWORD($FFFFFFFF);

function TrackMouseEvent(var EventTrack: TTrackMouseEvent): BOOL; stdcall; external user32 name 'TrackMouseEvent';
  
implementation

end.
