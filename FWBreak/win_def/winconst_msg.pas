{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit winconst_msg;

interface
                           
{ Window Messages }
const
  WM_NULL             = $0000;
  WM_CREATE           = $0001;
  WM_DESTROY          = $0002;
  WM_MOVE             = $0003;
  WM_SIZE             = $0005;

  // 一个窗口被激活或失去激活状态
  // If an application processes this message, it should return zero
  // http://msdn.microsoft.com/en-us/library/ms646274(VS.85).aspx
  WM_ACTIVATE         = $0006;
  { WM_ACTIVATE state values }
    WA_INACTIVE = 0;
    WA_ACTIVE = 1;
    WA_CLICKACTIVE = 2;


  WM_SETFOCUS         = $0007;

  // An application should return zero if it processes this message.
  // http://msdn.microsoft.com/en-us/library/ms646282(v=VS.85).aspx
  WM_KILLFOCUS        = $0008;
  
  WM_ENABLE           = $000A;
  // 设置窗口是否能重画 ??
  WM_SETREDRAW        = $000B;
  WM_SETTEXT          = $000C;
  WM_GETTEXT          = $000D;
  WM_GETTEXTLENGTH    = $000E;
  WM_PAINT            = $000F;
//WM_DESTROY 是关闭程序的
//WM_CLOSE 是关闭窗口的
//WM_QUIT 是关闭消息环的  
  WM_CLOSE            = $0010;
  // WM_QUERYENDSESSION return 0;
  //此处返回0则不能关机，返回1就能关机
  // ExitWindowsEx(EWX_POWEROFF|EWX_FORCE,0); 强制关机
  // 调用ExitWindowsEx，系统不会发出WM_QUERYENDSESSION消息
  WM_QUERYENDSESSION  = $0011;

  //用来结束程序运行或当程序调用postquitmessage函数
  WM_QUIT             = $0012;

  //当用户窗口恢复以前的大小位置时，把此消息发送给某个图标
  WM_QUERYOPEN        = $0013;

  //当窗口背景必须被擦除时（例在窗口改变大小时）
  // WM_ERASEBKGND消息的后面一定是WM_PAINT
  WM_ERASEBKGND       = $0014;

  //当系统颜色改变时，发送此消息给所有顶级窗口
  WM_SYSCOLORCHANGE   = $0015;
  WM_ENDSESSION       = $0016;
  WM_SYSTEMERROR      = $0017;
  WM_SHOWWINDOW       = $0018;
  WM_CTLCOLOR         = $0019;
  WM_WININICHANGE     = $001A;
  WM_SETTINGCHANGE = WM_WININICHANGE;
  WM_DEVMODECHANGE    = $001B;

  //发此消息给应用程序哪个窗口是激活的，哪个是非激活的
  // http://msdn.microsoft.com/en-us/library/ms632614(VS.85).aspx
  // If an application processes this message, it should return zero
  WM_ACTIVATEAPP      = $001C;
  WM_FONTCHANGE       = $001D;

  //当系统的时间变化时发送此消息给所有顶级窗口
  WM_TIMECHANGE       = $001E;

  //发送此消息来取消某种正在进行的摸态（操作）
  // http://www.cnblogs.com/del/archive/2008/10/29/1322205.html
  WM_CANCELMODE       = $001F;

  //如果鼠标引起光标在某个窗口中移动
  //且鼠标输入没有被捕获时，就发消息给某个窗口
  (*鼠标移动OnMouseMOve就会自动发送 WM_SETCURSOR从而触发OnSetCursor，因此在设计改变鼠标指针的程序时，
    一般不要在OnMouseMOve事件中调用SetCursor，容易引起指针闪烁。设置鼠标指针形状合理的方法是：
    在OnMouseMove中使用一个变量记住各矩形crect中的鼠标形状，然后在OnSetCursor调用SetCursor设置鼠标*)
  WM_SETCURSOR        = $0020;

  //当光标在某个非激活的窗口中而用户正按着鼠标
  //的某个键发送此消息给当前窗口
  WM_MOUSEACTIVATE    = $0021;    
    MA_ACTIVATE = 1; // 激活窗体，但不删除鼠标消息
    MA_ACTIVATEANDEAT = 2; // 不激活窗体，也不删除鼠标消息
    MA_NOACTIVATE = 3; // 激活窗体，删除鼠标消息
    MA_NOACTIVATEANDEAT = 4; // 不激活窗体，但删除鼠标消息
  WM_CHILDACTIVATE    = $0022;

  //此消息由基于计算机的训练程序发送，
  //通过WH_JOURNALPALYBACK的hook程序分离出用户输入消息
  WM_QUEUESYNC        = $0023;

  //此消息发送给窗口当它将要改变大小或位置
  WM_GETMINMAXINFO    = $0024;

  //发送给最小化窗口当它图标将要被重画
  WM_PAINTICON        = $0026;

  //此消息发送给某个最小化窗口，仅当它在画图标前它的背景必须被重画
  WM_ICONERASEBKGND   = $0027;

  //发送此消息给一个对话框程序去更改焦点位置
  WM_NEXTDLGCTL       = $0028;
  
  //每当打印管理列队增加或减少一条作业时发出此消息
  WM_SPOOLERSTATUS    = $002A;

  //当button，combobox，listbox，menu的可视外观改变时发送
  //此消息给这些空件的所有者
  WM_DRAWITEM         = $002B;
  WM_MEASUREITEM      = $002C;
  WM_DELETEITEM       = $002D;
  WM_VKEYTOITEM       = $002E;
  WM_CHARTOITEM       = $002F;
  WM_SETFONT          = $0030;
  WM_GETFONT          = $0031;

  //应用程序发送此消息让一个窗口与一个热键相关连
  WM_SETHOTKEY        = $0032;
  //应用程序发送此消息来判断热键与某个窗口是否有关联
  WM_GETHOTKEY        = $0033;

  //此消息发送给最小化窗口，当此窗口将要被拖放而它的
  //类中没有定义图标，应用程序能返回一个图标或光标的句柄，
  //当用户拖放图标时系统显示这个图标或光标
  WM_QUERYDRAGICON    = $0037;
  WM_COMPAREITEM      = $0039;
  WM_GETOBJECT        = $003D;

  //显示内存已经很少了
  WM_COMPACTING       = $0041;

  WM_COMMNOTIFY       = $0044;    { obsolete in Win32}

  //发送此消息给那个窗口的大小和位置将要被改变时
  //来调用setwindowpos函数或其它窗口管理函数
  WM_WindowPosChanging = $0046;

  //发送此消息给那个窗口的大小和位置已经被改变时
  //来调用setwindowpos函数或其它窗口管理函数
  WM_WindowPosChanged = $0047;
  WM_POWER            = $0048;

(*
  // windows 8, windows 7 下 拖动失效
  http://www.xiangwangfeng.com/tag/uipi/
  http://www.xiangwangfeng.com/2010/10/20/uac%E7%9A%84%E5%89%8D%E4%B8%96%E4%BB%8A%E7%94%9F/
  
  ChangeWindowMessageFilter(WM_DROPFILES, MSGFLT_ADD);
  // WM_COPYGLOBALDATA $0049
  ChangeWindowMessageFilter($0049, MSGFLT_ADD);

  Vista/Win7系统中，由于UAC和UIPI的存在，低权限的进程是无法向高权限的进程发送
  任何高于WM_USER的消息，而低于WM_USER的消息一部分也会因为安全原因被禁止

 解决这个问题的方法大致有两种：
    a.如果进程一定需要高权限做一些操作，可以考虑将UI相关的部分设定为普通用户权限，
      而一些需要特殊权限的事情全丢到另外一个管理员权限的进程中进行，两个进程通过
      除消息之外的其他方式进行通信，比如管道，共享内存等等。(这种方法实在太蛋疼，
      除非有很多类型的消息或者特殊事件需要处理，否则不推荐)
    b.调用ChangeWindowMessageFilter这个API进行消息过滤。
  MSDN上并不推荐使用这个方法，因为这个方法杀伤范围太大，影响的是当前整个进程，
  更推荐使用ChangeWindowMessageFilterEx，对某个特地窗口进行消息过滤：这样减少
  了filter对程序的影响，保证了安全又不至于无法实现某些特定功能。
*)
  WM_COPYGLOBALDATA   = $0049;
  
  WM_COPYDATA         = $004A;

  //当某个用户取消程序日志激活状态，提交此消息给程序
  WM_CANCELJOURNAL    = $004B;

  //当某个控件的某个事件已经发生或这个控件需要得到一
  //些信息时，发送此消息给它的父窗口
  WM_NOTIFY           = $004E;

  //当用户选择某种输入语言，或输入语言的热键改变
  WM_INPUTLANGCHANGEREQUEST = $0050;

  //当平台现场已经被改变后发送此消息给受影响的最顶级窗口
  WM_INPUTLANGCHANGE  = $0051;

  //当程序已经初始化windows帮助例程时发送此消息给应用程序
  WM_TCARD            = $0052;

  //此消息显示用户按下了F1，如果某个菜单是激活的，
  //就发送此消息个此窗口关联的菜单，否则就
  //发送给有焦点的窗口，如果当前都没有焦点，
  //就把此消息发送给当前激活的窗口
  WM_HELP             = $0053;

  //当用户已经登入或退出后发送此消息给所有的窗口
  //当用户登入或退出时系统更新用户的具体
  //设置信息，在用户更新设置时系统马上发送此消息
  WM_USERCHANGED      = $0054;


  NFR_ANSI    = 1;
  NFR_UNICODE = 2;
  NF_QUERY    = 3;
  NF_REQUERY  = 4;
  // ListView 及其 Column Header 实际上都是 Windows 通用控件(Comctl32.dll)
  //公用控件，自定义控件和他们的父窗口通过此消息
  //来判断控件是使用ANSI还是UNICODE结构
  WM_NOTIFYFORMAT     = $0055;

  //当用户某个窗口中点击了一下右键就发送此消息给这个窗口
  WM_CONTEXTMENU      = $007B;

  //当调用SETWINDOWLONG函数将要改变一个或多个
  //窗口的风格时发送此消息给那个窗口
  WM_STYLECHANGING    = $007C;
  WM_STYLECHANGED     = $007D;

  //当显示器的分辨率改变后发送此消息给所有的窗口
  WM_DISPLAYCHANGE        = $007E;
  WM_GETICON              = $007F;
  WM_SETICON              = $0080;


  { WM_NCHITTEST and MOUSEHOOKSTRUCT Mouse Position Codes }
  HTERROR                 = -2;
  HTTRANSPARENT           = -1;
  HTNOWHERE               = 0;
  HTCLIENT                = 1;
  HTCAPTION               = 2;
  HTSYSMENU               = 3;
  HTGROWBOX               = 4;
  HTSIZE                  = HTGROWBOX;
  HTMENU                  = 5;
  HTHSCROLL               = 6;
  HTVSCROLL               = 7;
  HTMINBUTTON             = 8;
  HTMAXBUTTON             = 9;
  HTLEFT                  = 10;
  HTRIGHT                 = 11;
  HTTOP                   = 12;
  HTTOPLEFT               = 13;
  HTTOPRIGHT              = 14;
  HTBOTTOM                = 15;
  HTBOTTOMLEFT            = $10;
  HTBOTTOMRIGHT           = 17;
  HTBORDER                = 18;
  HTREDUCE                = HTMINBUTTON;
  HTZOOM                  = HTMAXBUTTON;
  HTSIZEFIRST             = HTLEFT;
  HTSIZELAST              = HTBOTTOMRIGHT;
  HTOBJECT                = 19;
  HTCLOSE                 = 20;
  HTHELP                  = 21;

  //当某个窗口第一次被创建时，此消息在WM_CREATE消息发送前发送
  WM_NCCREATE             = $0081;
  WM_NCDESTROY            = $0082;

  // http://blog.csdn.net/qq867346668/article/details/6278234
  // http://www.cnblogs.com/SkylineSoft/archive/2010/04/30/1724735.html
  WM_NCCALCSIZE           = $0083;
  // WVR_REDRAW
  // WM_NCCALCSIZE消息在需要计算窗口客户区的大小和位置时发送。
  // 通过处理这个消息，应用程序可以在窗口大小或位置改变时控制客户区的内容
  
  WM_NCHitTest            = $0084;
  WM_NCPAINT              = $0085;

  // http://msdn.microsoft.com/en-us/library/ms632633(VS.85).aspx
  // When the wParam parameter is FALSE, an application should return TRUE to
  // indicate that the system should proceed with the default processing,
  // or it should return FALSE to prevent the change. When wParam is TRUE, the return value is ignored.
  WM_NCACTIVATE           = $0086;

  { Windows 将 WM_GETDLGCODE 消息发送到的控件在对话框中或在 IsDialogMessage
    函数处理键盘输入的位置窗口中。 通常，应用程序处理 WM_GETDLGCODE 消息以防
    止 Windows 执行默认处理键盘消息的响应。WM_KEYDOWN、 WM_SYSCHAR 和 WM_CHAR
    消息是键盘消息的示例 }
  WM_GETDLGCODE           = $0087;
  WM_NCMOUSEMOVE          = $00A0;
  WM_NCLBUTTONDOWN        = $00A1;
  WM_NCLBUTTONUP          = $00A2;
  WM_NCLBUTTONDBLCLK      = $00A3;
  WM_NCRBUTTONDOWN        = $00A4;
  WM_NCRBUTTONUP          = $00A5;
  WM_NCRBUTTONDBLCLK      = $00A6;
  WM_NCMBUTTONDOWN        = $00A7;
  WM_NCMBUTTONUP          = $00A8;
  WM_NCMBUTTONDBLCLK      = $00A9;

  WM_NCXBUTTONDOWN        = $00AB;
  WM_NCXBUTTONUP          = $00AC;
  WM_NCXBUTTONDBLCLK      = $00AD;
  WM_INPUT                = $00FF;

  WM_KEYFIRST             = $0100;
  WM_KEYDOWN              = $0100;
  WM_KEYUP                = $0101;
  WM_CHAR                 = $0102;
  WM_DEADCHAR             = $0103;
  WM_SYSKEYDOWN           = $0104;
  WM_SYSKEYUP             = $0105;
  WM_SYSCHAR              = $0106;
  WM_SYSDEADCHAR          = $0107;
  WM_UNICHAR              = $0109;
  WM_KEYLAST              = $0109;

  WM_INITDIALOG           = $0110;
  WM_COMMAND              = $0111;
  WM_SYSCOMMAND           = $0112;
  WM_TIMER                = $0113;
  WM_HSCROLL              = $0114;
  WM_VSCROLL              = $0115;
  WM_INITMENU             = $0116;
  WM_INITMENUPOPUP        = $0117;
  WM_MENUSELECT           = $011F;
  WM_MENUCHAR             = $0120;
  WM_ENTERIDLE            = $0121;

  WM_MENURBUTTONUP        = $0122;
  WM_MENUDRAG             = $0123;
  WM_MENUGETOBJECT        = $0124;
  WM_UNINITMENUPOPUP      = $0125;
  WM_MENUCOMMAND          = $0126;

  WM_CHANGEUISTATE        = $0127;
  WM_UPDATEUISTATE        = $0128;
  WM_QUERYUISTATE         = $0129;

  WM_CTLCOLORMSGBOX       = $0132;
  WM_CTLCOLOREDIT         = $0133;
  WM_CTLCOLORLISTBOX      = $0134;
  WM_CTLCOLORBTN          = $0135;
  WM_CTLCOLORDLG          = $0136;
  WM_CTLCOLORSCROLLBAR    = $0137;
  WM_CTLCOLORSTATIC       = $0138;

  WM_MOUSEFIRST           = $0200;
  WM_MOUSEMOVE            = $0200;
  WM_LBUTTONDOWN          = $0201;
  WM_LBUTTONUP            = $0202;
  WM_LBUTTONDBLCLK        = $0203;
  WM_RBUTTONDOWN          = $0204;
  WM_RBUTTONUP            = $0205;
  WM_RBUTTONDBLCLK        = $0206;
  WM_MBUTTONDOWN          = $0207;
  WM_MBUTTONUP            = $0208;
  WM_MBUTTONDBLCLK        = $0209;
  WM_MOUSEWHEEL           = $020A;
  WM_MOUSELAST            = $020A;

  WM_PARENTNOTIFY         = $0210;
  WM_ENTERMENULOOP        = $0211;
  WM_EXITMENULOOP         = $0212;
  WM_NEXTMENU             = $0213;

  WM_SIZING               = 532;
  WM_CAPTURECHANGED       = 533;
  WM_MOVING               = 534;
  WM_POWERBROADCAST       = 536;
  WM_DEVICECHANGE         = 537;

  WM_IME_STARTCOMPOSITION = $010D;
  WM_IME_ENDCOMPOSITION   = $010E;

  WM_IME_COMPOSITION      = $010F;
  // http://topic.csdn.net/t/20040715/14/3177575.html
  // 当用户改变了编码状态时，发送此消息WM_IME_COMPOSITION

  WM_IME_KEYLAST          = $010F;

  // WM_IME_SETCONTEXT lparam
  ISC_SHOWUICANDIDATEWINDOW      = $00000001;
  ISC_SHOWUICOMPOSITIONWINDOW    = $80000000;
  ISC_SHOWUIGUIDELINE            = $40000000;
  ISC_SHOWUIALLCANDIDATEWINDOW   = $0000000F;
  ISC_SHOWUIALL           = $C000000F;
  WM_IME_SETCONTEXT       = $0281;
  
  WM_IME_NOTIFY           = $0282;

{ wParam for WM_IME_CONTROL to the soft keyboard }
{ dwAction for ImmNotifyIME }
  NI_OPENCANDIDATE               = $0010;
  NI_CLOSECANDIDATE              = $0011;
  NI_SELECTCANDIDATESTR          = $0012;
  NI_CHANGECANDIDATELIST         = $0013;
  NI_FINALIZECONVERSIONRESULT    = $0014;
  NI_COMPOSITIONSTR              = $0015;
  NI_SETCANDIDATE_PAGESTART      = $0016;
  NI_SETCANDIDATE_PAGESIZE       = $0017;

  WM_IME_CONTROL          = $0283;
  WM_IME_COMPOSITIONFULL  = $0284;
  WM_IME_SELECT           = $0285;
  WM_IME_CHAR             = $0286;
  WM_IME_REQUEST          = $0288;

  WM_IME_KEYDOWN          = $0290;
  WM_IME_KEYUP            = $0291;

  WM_MDICREATE            = $0220;
  WM_MDIDESTROY           = $0221;
  WM_MDIACTIVATE          = $0222;
  WM_MDIRESTORE           = $0223;
  WM_MDINEXT              = $0224;
  WM_MDIMAXIMIZE          = $0225;
  WM_MDITILE              = $0226;
  WM_MDICASCADE           = $0227;
  WM_MDIICONARRANGE       = $0228;
  WM_MDIGETACTIVE         = $0229;
  WM_MDISETMENU           = $0230;

  WM_ENTERSIZEMOVE        = $0231;
  WM_EXITSIZEMOVE         = $0232;

  // 拖放文件 放下的时候
  // Hdrop := message.WParam
  // Count := DragQueryfile(hdrop, maxdword, Pfilename, max_path - 1);
  WM_DROPFILES            = $0233;
  
  WM_MDIREFRESHMENU       = $0234;

  WM_MOUSEHOVER           = $02A1;
  WM_MOUSELEAVE           = $02A3;

  WM_NCMOUSEHOVER         = $02A0;
  WM_NCMOUSELEAVE         = $02A2;
  WM_WTSSESSION_CHANGE    = $02B1;

  WM_TABLET_FIRST         = $02C0;
  WM_TABLET_LAST          = $02DF;

  WM_CUT                  = $0300;
  WM_COPY                 = $0301;
  WM_PASTE                = $0302;
  WM_CLEAR                = $0303;
  WM_UNDO                 = $0304;
  WM_RENDERFORMAT         = $0305;
  WM_RENDERALLFORMATS     = $0306;
  WM_DESTROYCLIPBOARD     = $0307;
  WM_DRAWCLIPBOARD        = $0308;
  WM_PAINTCLIPBOARD       = $0309;
  WM_VSCROLLCLIPBOARD     = $030A;
  WM_SIZECLIPBOARD        = $030B;
  WM_ASKCBFORMATNAME      = $030C;
  WM_CHANGECBCHAIN        = $030D;
  WM_HSCROLLCLIPBOARD     = $030E;
  WM_QUERYNEWPALETTE      = $030F;
  WM_PALETTEISCHANGING    = $0310;
  WM_PALETTECHANGED       = $0311;
  WM_HOTKEY               = $0312;

  WM_PRINT                = 791;
  WM_PRINTCLIENT          = 792;
  WM_APPCOMMAND           = $0319;
  WM_THEMECHANGED         = $031A;

  WM_HANDHELDFIRST        = 856;
  WM_HANDHELDLAST         = 863;

  WM_PENWINFIRST          = $0380;
  WM_PENWINLAST           = $038F;

  WM_COALESCE_FIRST       = $0390;
  WM_COALESCE_LAST        = $039F;

  WM_DDE_FIRST            = $03E0;
  WM_DDE_INITIATE         = WM_DDE_FIRST + 0;
  WM_DDE_TERMINATE        = WM_DDE_FIRST + 1;
  WM_DDE_ADVISE           = WM_DDE_FIRST + 2;
  WM_DDE_UNADVISE         = WM_DDE_FIRST + 3;
  WM_DDE_ACK              = WM_DDE_FIRST + 4;
  WM_DDE_DATA             = WM_DDE_FIRST + 5;
  WM_DDE_REQUEST          = WM_DDE_FIRST + 6;
  WM_DDE_POKE             = WM_DDE_FIRST + 7;
  WM_DDE_EXECUTE          = WM_DDE_FIRST + 8;
  WM_DDE_LAST             = WM_DDE_FIRST + 8;

  WM_DWMCOMPOSITIONCHANGED        = $031E; 
  WM_DWMNCRENDERINGCHANGED        = $031F;
  WM_DWMCOLORIZATIONCOLORCHANGED  = $0320;
  WM_DWMWINDOWMAXIMIZEDCHANGE     = $0321;

  WM_APP                  = $8000;

{ NOTE: All Message Numbers below 0x0400 are RESERVED }

{ Private Window Messages Start Here }

  WM_USER                 = $0400;

{ Button Notification Codes }

const
  BN_CLICKED              = 0;
  BN_PAINT                = 1;
  BN_HILITE               = 2;
  BN_UNHILITE             = 3;
  BN_DISABLE              = 4;
  BN_DOUBLECLICKED        = 5;
  BN_PUSHED               = BN_HILITE;
  BN_UNPUSHED             = BN_UNHILITE;
  BN_DBLCLK               = BN_DOUBLECLICKED;
  BN_SETFOCUS             = 6;
  BN_KILLFOCUS            = 7;

{ Button Control Messages }
const
  BM_GETCHECK             = $00F0;
  BM_SETCHECK             = $00F1;
  BM_GETSTATE             = $00F2;
  BM_SETSTATE             = $00F3;
  BM_SETSTYLE             = $00F4;
  BM_CLICK                = $00F5;
  BM_GETIMAGE             = $00F6;
  BM_SETIMAGE             = $00F7;

{ Listbox Notification Codes }

const
  LBN_ERRSPACE            = (-2);
  LBN_SELCHANGE           = 1;
  LBN_DBLCLK              = 2;
  LBN_SELCANCEL           = 3;
  LBN_SETFOCUS            = 4;
  LBN_KILLFOCUS           = 5;

{ Listbox messages }

const
  LB_ADDSTR               = $0180;
  LB_INSERTSTR            = $0181;
  LB_DELETESTR            = $0182;
  LB_SELITEMRANGEEX       = $0183;
  LB_RESETCONTENT         = $0184;
  LB_SETSEL               = $0185;
  LB_SETCURSEL            = $0186;
  LB_GETSEL               = $0187;
  LB_GETCURSEL            = $0188;
  LB_GETTEXT              = $0189;
  LB_GETTEXTLEN           = $018A;
  LB_GETCOUNT             = $018B;
  LB_SELECTSTR            = $018C;
  LB_DIR                  = $018D;
  LB_GETTOPINDEX          = $018E;
  LB_FINDSTR              = $018F;
  LB_GETSELCOUNT          = $0190;
  LB_GETSELITEMS          = $0191;
  LB_SETTABSTOPS          = $0192;
  LB_GETHORIZONTALEXTENT  = $0193;
  LB_SETHORIZONTALEXTENT  = $0194;
  LB_SETCOLUMNWIDTH       = $0195;
  LB_ADDFILE              = $0196;
  LB_SETTOPINDEX          = $0197;
  LB_GETITEMRECT          = $0198;
  LB_GETITEMDATA          = $0199;
  LB_SETITEMDATA          = $019A;
  LB_SELITEMRANGE         = $019B;
  LB_SETANCHORINDEX       = $019C;
  LB_GETANCHORINDEX       = $019D;
  LB_SETCARETINDEX        = $019E;
  LB_GETCARETINDEX        = $019F;
  LB_SETITEMHEIGHT        = $01A0;
  LB_GETITEMHEIGHT        = $01A1;
  LB_FINDSTREXACT         = $01A2;
  LB_SETLOCALE            = $01A5;
  LB_GETLOCALE            = $01A6;
  LB_SETCOUNT             = $01A7;
  LB_INITSTORAGE          = $01A8;
  LB_ITEMFROMPOINT        = $01A9;
  LB_MSGMAX               = 432;

{ Combo Box Notification Codes }

const
  CBN_ERRSPACE            = (-1);
  CBN_SELCHANGE           = 1;
  CBN_DBLCLK              = 2;
  CBN_SETFOCUS            = 3;
  CBN_KILLFOCUS           = 4;
  CBN_EDITCHANGE          = 5;
  CBN_EDITUPDATE          = 6;
  CBN_DROPDOWN            = 7;
  CBN_CLOSEUP             = 8;
  CBN_SELENDOK            = 9;
  CBN_SELENDCANCEL        = 10;

{ Combo Box messages }

  CB_GETEDITSEL           = $0140;
  CB_LIMITTEXT            = $0141;
  CB_SETEDITSEL           = $0142;
  CB_ADDSTR               = $0143;
  CB_DELETESTR            = $0144;
  CB_DIR                  = $0145;
  CB_GETCOUNT             = $0146;
  CB_GETCURSEL            = $0147;
  CB_GETLBTEXT            = $0148;
  CB_GETLBTEXTLEN         = $0149;
  CB_INSERTSTR            = $014A;
  CB_RESETCONTENT         = $014B;
  CB_FINDSTR              = $014C;
  CB_SELECTSTR            = $014D;
  CB_SETCURSEL            = $014E;
  CB_SHOWDROPDOWN         = $014F;
  CB_GETITEMDATA          = $0150;
  CB_SETITEMDATA          = $0151;
  CB_GETDROPPEDCONTROLRECT= $0152;
  CB_SETITEMHEIGHT        = $0153;
  CB_GETITEMHEIGHT        = $0154;
  CB_SETEXTENDEDUI        = $0155;
  CB_GETEXTENDEDUI        = $0156;
  CB_GETDROPPEDSTATE      = $0157;
  CB_FINDSTREXACT         = $0158;
  CB_SETLOCALE            = 345;
  CB_GETLOCALE            = 346;
  CB_GETTOPINDEX          = 347;
  CB_SETTOPINDEX          = 348;
  CB_GETHORIZONTALEXTENT  = 349;
  CB_SETHORIZONTALEXTENT  = 350;
  CB_GETDROPPEDWIDTH      = 351;
  CB_SETDROPPEDWIDTH      = 352;
  CB_INITSTORAGE          = 353;
  CB_MSGMAX               = 354;

{ Edit Control Notification Codes }

const
  EN_SETFOCUS             = $0100;
  EN_KILLFOCUS            = $0200;
  EN_CHANGE               = $0300;
  EN_UPDATE               = $0400;
  EN_ERRSPACE             = $0500;
  EN_MAXTEXT              = $0501;
  EN_HSCROLL              = $0601;
  EN_VSCROLL              = $0602;

{ Edit Control Messages }

const
  EM_GETSEL               = $00B0;
  EM_SETSEL               = $00B1;
  EM_GETRECT              = $00B2;
  EM_SETRECT              = $00B3;
  EM_SETRECTNP            = $00B4;
  EM_SCROLL               = $00B5;
  EM_LINESCROLL           = $00B6;
  EM_SCROLLCARET          = $00B7;
  EM_GETMODIFY            = $00B8;
  EM_SETMODIFY            = $00B9;
  EM_GETLINECOUNT         = $00BA;
  EM_LINEINDEX            = $00BB;
  EM_SETHANDLE            = $00BC;
  EM_GETHANDLE            = $00BD;
  EM_GETTHUMB             = $00BE;
  EM_LINELENGTH           = $00C1;
  EM_REPLACESEL           = $00C2;
  EM_GETLINE              = $00C4;
  EM_LIMITTEXT            = $00C5;
  EM_CANUNDO              = $00C6;
  EM_UNDO                 = $00C7;
  EM_FMTLINES             = $00C8;
  EM_LINEFROMCHAR         = $00C9;
  EM_SETTABSTOPS          = $00CB;
  EM_SETPASSWORDCHAR      = $00CC;
  EM_EMPTYUNDOBUFFER      = $00CD;
  EM_GETFIRSTVISIBLELINE  = $00CE;
  EM_SETREADONLY          = $00CF;
  EM_SETWORDBREAKPROC     = $00D0;
  EM_GETWORDBREAKPROC     = $00D1;
  EM_GETPASSWORDCHAR      = $00D2;
  EM_SETMARGINS           = 211;
  EM_GETMARGINS           = 212;
  EM_SETLIMITTEXT         = EM_LIMITTEXT;    //win40 Name change
  EM_GETLIMITTEXT         = 213;
  EM_POSFROMCHAR          = 214;
  EM_CHARFROMPOS          = 215;
  EM_SETIMESTATUS         = 216;
  EM_GETIMESTATUS         = 217;

const
  { Scroll bar messages }
  SBM_SETPOS              = 224;             { not in win3.1  }
  SBM_GETPOS              = 225;             { not in win3.1  }
  SBM_SETRANGE            = 226;           { not in win3.1  }
  SBM_SETRANGEREDRAW      = 230;     { not in win3.1  }
  SBM_GETRANGE            = 227;           { not in win3.1  }
  SBM_ENABLE_ARROWS       = 228;      { not in win3.1  }
  SBM_SETSCROLLINFO       = 233;
  SBM_GETSCROLLINFO       = 234;

{ Dialog messages }

  DM_GETDEFID             = (WM_USER+0);
  DM_SETDEFID             = (WM_USER+1);
  DM_REPOSITION           = (WM_USER+2);

  PSM_PAGEINFO            = (WM_USER+100);
  PSM_SHEETINFO           = (WM_USER+101);

implementation

end.
