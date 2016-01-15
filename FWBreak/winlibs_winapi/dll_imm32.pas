(*
          EnumInputContext 由应用程序定义的，提供给ImmEnumInputContext函数用来处理输入环境的一个回调函
          EnumRegisterWordProc 由应用程序定义的，结合ImmEnumRegisterWord函数一起使用的一个回调函数
          1    0 0001426F CtfAImmActivate
          2    1 000142C4 CtfAImmDeactivate
          3    2 00013CE7 CtfAImmIsIME
          4    3 00013E9F CtfImmCoUninitialize
          5    4 00014304 CtfImmDispatchDefImeMessage
          6    5 000131F0 CtfImmEnterCoInitCountSkipMode
          7    6 0000A11B CtfImmGenerateMessage
          8    7 0001356B CtfImmGetGuidAtom
          9    8 00013511 CtfImmHideToolbarWnd
         10    9 00013773 CtfImmIsCiceroEnabled
         11    A 0001378E CtfImmIsCiceroStartedInThread
         12    B 000135F1 CtfImmIsGuidMapEnable
         13    C 000138A1 CtfImmIsTextFrameServiceDisabled
         14    D 0001418A CtfImmLastEnabledWndDestroy
         15    E 00013206 CtfImmLeaveCoInitCountSkipMode
         16    F 000134DA CtfImmRestoreToolbarWnd
         17   10 00013668 CtfImmSetAppCompatFlags
         18   11 000137A6 CtfImmSetCiceroStartInThread
         19   12 00013F0B CtfImmTIMActivate
         20   13 00009A21 GetKeyboardLayoutCP
         21   14 000077CD ImmActivateLayout
         22   15 00002378 ImmAssociateContext 建立指定输入环境与窗口之间的关联
         23   16 000036F4 ImmAssociateContextEx 更改指定输入环境与窗口（或其子窗口）之间的关联
         24   17 00012332 ImmCallImeConsoleIME
         25   18 000078B1 ImmConfigureIMEA  显示指定的输入现场标识符的配置对话框
         26   19 00007A7B ImmConfigureIMEW

         27   1A 00002975 ImmCreateContext  创建一个新的输入环境，并为它分配内存和初始化它
         28   1B 00009865 ImmCreateIMCC
         29   1C 0000DB3B ImmCreateSoftKeyboard
         30   1D 000036A8 ImmDestroyContext 销毁输入环境并释放和它关联的内存
         31   1E 00009889 ImmDestroyIMCC
         32   1F 0000DCC2 ImmDestroySoftKeyboard

         33   20 000023E8 ImmDisableIME  关闭一个线程或一个进程中所有线程的IME功能
         34   21 000023E8 ImmDisableIme
         35   22 000141A6 ImmDisableTextFrameService 关闭指定线程的文本服务框架（TSF）功能
                                      虽然这里把它列了出来，但建议程序员最好不要使用这个函数
         36   23 000037CA ImmEnumInputContext  获取指定线程的输入环境
         37   24 0000AB30 ImmEnumRegisterWordA 列举跟指定读入串、样式和注册串相匹配的注册串
         38   25 0000AC99 ImmEnumRegisterWordW
         39   26 00007C25 ImmEscapeA  对那些不能通过IME API函数来访问的特殊输入法程序提供兼容性支持的一个函数
         40   27 00007EA1 ImmEscapeW
         41   28 00006E43 ImmFreeLayout
         42   29 00009FC2 ImmGenerateMessage
         43   2A 00009D07 ImmGetAppCompatFlags
         44   2B 00005546 ImmGetCandidateListA  获取一个候选列表
         45   2C 00005510 ImmGetCandidateListCountA 获取候选列表的大小
         46   2D 0000552B ImmGetCandidateListCountW
         47   2E 00005567 ImmGetCandidateListW
         48   2F 00003B93 ImmGetCandidateWindow 获取有关候选列表窗口的信息
         49   30 00004791 ImmGetCompositionFontA  获取有关当前用来显示按键组合窗口中的字符的逻辑字体的信息
         50   31 00004829 ImmGetCompositionFontW
         51   32 00005B62 ImmGetCompositionStringA  获取有关组合字符串的信息
         52   33 0000548A ImmGetCompositionStringW
         53   34 00003B48 ImmGetCompositionWindow  获取有关按键组合窗口的信息
         54   35 000023A1 ImmGetContext  获取与指定窗口相关联的输入环境
         55   36 00004ADB ImmGetConversionListA 在不生成任何跟IME有关的消息的情况下，获取输入按键字符组合或输出文字的转换结果列表
         56   37 00004C26 ImmGetConversionListW
         57   38 00003A86 ImmGetConversionStatus 获取当前转换状态
         58   39 000097BE ImmGetDefaultIMEWnd  获取缺省IME类窗口的句柄
         59   3A 000089A2 ImmGetDescriptionA  复制IME的说明信息到指定的缓冲区中
         60   3B 000088F5 ImmGetDescriptionW
         61   3C 00005588 ImmGetGuideLineA  获取出错信息
         62   3D 000055A9 ImmGetGuideLineW
         63   3E 00006823 ImmGetHotKey
         64   3F 000098E0 ImmGetIMCCLockCount
         65   40 0000992C ImmGetIMCCSize
         66   41 00009F83 ImmGetIMCLockCount
         67   42 00008AF0 ImmGetIMEFileNameA  获取跟指定输入现场相关联的IME文件名
         68   43 00008A39 ImmGetIMEFileNameW
         69   44 00009C7F ImmGetImeInfoEx
         70   45 00012DB5 ImmGetImeMenuItemsA  获取注册在指定输入环境的IME菜单上的菜单项
         71   46 00012DDC ImmGetImeMenuItemsW
         72   47 00003AC3 ImmGetOpenStatus  检测IME是否打开
         73   48 00008B8E ImmGetProperty   获取跟指定输入现场相关联的IME的属性和功能
         74   49 0000A776 ImmGetRegisterWordStyleA  获取跟指定输入现场相关联的IME所支持的样式列表
         75   4A 0000A84D ImmGetRegisterWordStyleW
         76   4B 00003AF6 ImmGetStatusWindowPos  获取状态窗口的位置
         77   4C 0000A245 ImmGetVirtualKey  获取跟IME处理的键盘输入消息相关联的初始虚拟键值
         78   4D 0000E79D ImmIMPGetIMEA
         79   4E 0000E769 ImmIMPGetIMEW
         80   4F 0000E90C ImmIMPQueryIMEA
         81   50 0000E804 ImmIMPQueryIMEW
         82   51 0000EAB9 ImmIMPSetIMEA
         83   52 0000E995 ImmIMPSetIMEW
         84   53 000096DF ImmInstallIMEA  安装一个IME
         85   54 00009415 ImmInstallIMEW
         86   55 00008C54 ImmIsIME  检测指定的输入现场是否有和它相关的IME
         87   56 00009DCB ImmIsUIMessageA 检查IME窗口消息并发送那些消息到特定的窗口
         88   57 00009DEC ImmIsUIMessageW
         89   58 0000776F ImmLoadIME
         90   59 00008719 ImmLoadLayout
         91   5A 00009A8B ImmLockClientImc
         92   5B 00009F2D ImmLockIMC
         93   5C 000098A6 ImmLockIMCC
         94   5D 00009BAC ImmLockImeDpi
         95   5E 00006FD8 ImmNotifyIME   通知IME有关输入环境状态已改变的消息
         96   5F 000080B9 ImmPenAuxInput
         97   60 0000E0D3 ImmProcessKey
         98   61 00012E03 ImmPutImeMenuItemsIntoMappedFile
         99   62 00009906 ImmReSizeIMCC
        100   63 000022B3 ImmRegisterClient
        101   64 0000A290 ImmRegisterWordA  注册一个输出文字到跟指定输入现场相关联的IME的字典中去
        102   65 0000A3D6 ImmRegisterWordW
        103   66 000029D3 ImmReleaseContext  销毁输入环境并解除对跟它相关联的内存的锁定
        104   67 00006799 ImmRequestMessageA
        105   68 000067B7 ImmRequestMessageW
        106   69 0000EB4F ImmSendIMEMessageExA
        107   6A 0000EB34 ImmSendIMEMessageExW
        108   6B 00006FA3 ImmSendMessageToActiveDefImeWndW
        109   6C 000029DE ImmSetActiveContext
        110   6D 0001247B ImmSetActiveContextConsoleIME
        111   6E 00004E54 ImmSetCandidateWindow  设置有关候选列表窗口的信息
        112   6F 000048C1 ImmSetCompositionFontA  设置用来显示按键组合窗口中的字符的逻辑字体
        113   70 000049CE ImmSetCompositionFontW
        114   71 000067D5 ImmSetCompositionStringA 设置按键组合字符串的字符内容、属性和子串信息
        115   72 000067FC ImmSetCompositionStringW
        116   73 00004DD6 ImmSetCompositionWindow 设置按键组合窗口的位置
        117   74 000045F7 ImmSetConversionStatus  设置当前转换状态
        118   75          ImmSetHotKey (forwarded to USER32.CliImmSetHotKey)
        119   76 0000470B ImmSetOpenStatus   打开或关闭IME功能
        120   77 00004D6E ImmSetStatusWindowPos 设置状态窗口的位置
        121   78 0000DCD3 ImmShowSoftKeyboard
        122   79 00006C92 ImmSimulateHotKey  在指定的窗口中模拟一个特定的IME热键动作，以触发该窗口相应的响应动作
        123   7A 00009D74 ImmSystemHandler
        124   7B 0000DE65 ImmTranslateMessage
        125   7C 00009B22 ImmUnlockClientImc
        126   7D 00009F45 ImmUnlockIMC
        127   7E 000098C3 ImmUnlockIMCC
        128   7F 00009BFC ImmUnlockImeDpi
        129   80 0000A503 ImmUnregisterWordA  从跟指定输入环境相关联的IME的字典中注销一个输出文字
        130   81 0000A649 ImmUnregisterWordW
        131   82 0000E679 ImmWINNLSEnableIME
        132   83 0000E6A0 ImmWINNLSGetEnableStatus
        133   84 0000E478 ImmWINNLSGetIMEHotkey

IME命令

以下列出IME中用到的命令（控制消息）。
IMC_CLOSESTATUSWINDOW（隐藏状态窗口）
IMC_GETCANDIDATEPOS（获取候选窗口的位置）
IMC_GETCOMPOSITIONFONT（获取用来显示按键组合窗口中的文本的逻辑字体）
IMC_GETCOMPOSITIONWINDOW（获取按键组合窗口的位置）
IMC_GETSTATUSWINDOWPOS（获取状态窗口的位置）
IMC_OPENSTATUSWINDOW（显示状态窗口）
IMC_SETCANDIDATEPOS（设置候选窗口的位置）
IMC_SETCOMPOSITIONFONT（设置用来显示按键组合窗口中的文本的逻辑字体）
IMC_SETCOMPOSITIONWINDOW（设置按键组合窗口的样式）
IMC_SETSTATUSWINDOWPOS（设置状态窗口的位置）

IMN_CHANGECANDIDATE（IME通知应用程序：候选窗口中的内容将改变）
IMN_CLOSECANDIDATE（IME通知应用程序：候选窗口将关闭）
IMN_CLOSESTATUSWINDOW（IME通知应用程序：状态窗口将关闭）
IMN_GUIDELINE（IME通知应用程序：将显示一条出错或其他信息）
IMN_OPENCANDIDATE（IME通知应用程序：将打开候选窗口）
IMN_OPENSTATUSWINDOW（IME通知应用程序：将创建状态窗口）
IMN_SETCANDIDATEPOS（IME通知应用程序：已结束候选处理同时将移动候选窗口）
IMN_SETCOMPOSITIONFONT（IME通知应用程序：输入内容的字体已更改）
IMN_SETCOMPOSITIONWINDOW（IME通知应用程序：按键组合窗口的样式或位置已更改）
IMN_SETCONVERSIONMODE（IME通知应用程序：输入内容的转换模式已更改）
IMN_SETOPENSTATUS（IME通知应用程序：输入内容的状态已更改）
IMN_SETSENTENCEMODE（IME通知应用程序：输入内容的语句模式已更改）
IMN_SETSTATUSWINDOWPOS（IME通知应用程序：输入内容中的状态窗口的位置已更改）

IMR_CANDIDATEWINDOW（通知：选定的IME需要应用程序提供有关候选窗口的信息）
IMR_COMPOSITIONFONT（通知：选定的IME需要应用程序提供有关用在按键组合窗口中的字体的信息）
IMR_COMPOSITIONWINDOW（通知：选定的IME需要应用程序提供有关按键组合窗口的信息）
IMR_CONFIRMRECONVERTSTRING（通知：IME需要应用程序更改RECONVERTSTRING结构）
IMR_DOCUMENTFEED（通知：选定的IME需要从应用程序那里取得已转换的字符串）
IMR_QUERYCHARPOSITION（通知：选定的IME需要应用程序提供有关组合字符串中某个字符的位置信息）
IMR_RECONVERTSTRING（通知：选定的IME需要应用程序提供一个用于自动更正的字符串）

IME编程中需要用到的数据结构

这里列了所有在使用输入法编辑器函数和消息时需要用到的数据结构。

CANDIDATEFORM（描述候选窗口的位置信息）
CANDIDATELIST（描述有关候选列表的信息）
COMPOSITIONFORM（描述按键组合窗口的样式和位置信息）
IMECHARPOSITION（描述按键组合窗口中的字符的位置信息）
IMEMENUITEMINFO（描述IME菜单项的信息）
RECONVERTSTRING（定义用于IME自动更正功能的字符串）
REGISTERWORD（描述一个要注册的读入信息或文字内容）
STYLEBUF（描述样式的标识符和名称）
*)
unit dll_imm32;

interface

uses
  atmcmbaseconst, winconst, wintype, wintypeA;

const
  imm32 = 'imm32.dll';
  STYLE_DESCRIPTION_SIZE = 32;

type
  PCompositionForm  = ^TCompositionForm;
  TCompositionForm  = record
    dwStyle         : DWORD;
    ptCurrentPos    : TPOINT;
    rcArea          : TRECT;
  end;

  PCandidateForm  = ^TCandidateForm;
  TCandidateForm  = record
    dwIndex       : DWORD;
    dwStyle       : DWORD;
    ptCurrentPos  : TPOINT;
    rcArea        : TRECT;
  end;

  PCandidateList  = ^TCandidateList;
  TCandidateList  = record
    dwSize        : DWORD;
    dwStyle       : DWORD;
    dwCount       : DWORD;
    dwSelection   : DWORD;
    dwPageStart   : DWORD;
    dwPageSize    : DWORD;
    dwOffset      : array[1..1] of DWORD;
  end;

  PStyleBufA      = ^TStyleBufA;
  PStyleBuf       = PStyleBufA;
  TStyleBufA      = record
    dwStyle       : DWORD;
    szDescription : array[0..STYLE_DESCRIPTION_SIZE-1] of AnsiChar;
  end;
  TStyleBufW      = record
    dwStyle       : DWORD;
    szDescription : array[0..STYLE_DESCRIPTION_SIZE-1] of WideChar;
  end;

  TStyleBuf = TStyleBufA;

function ImmInstallIMEA(lpszIMEFileName, lpszLayoutText: PAnsiChar): HKL; stdcall; external imm32 name 'ImmInstallIMEA';
function ImmGetDefaultIMEWnd(AWnd: HWND): HWND; stdcall; external imm32 name 'ImmGetDefaultIMEWnd';
function ImmGetDescriptionA(AKl: HKL; AChar: PAnsiChar; uBufLen: UINT): UINT; stdcall; external imm32 name 'ImmGetDescriptionA';
function ImmGetIMEFileNameA(AKl: HKL; AChar: PAnsiChar; uBufLen: UINT): UINT; stdcall; external imm32 name 'ImmGetIMEFileNameA';
function ImmGetProperty(AKl: HKL; dWord: DWORD): DWORD; stdcall; external imm32 name 'ImmGetProperty';
function ImmIsIME(AKl: HKL): Boolean; stdcall; external imm32 name 'ImmIsIME';
function ImmSimulateHotKey(AWnd: HWND; dWord: DWORD): Boolean; stdcall; external imm32 name 'ImmSimulateHotKey';
function ImmCreateContext: HIMC; stdcall; external imm32 name 'ImmCreateContext';
function ImmDestroyContext(AImc: HIMC): Boolean; stdcall; external imm32 name 'ImmDestroyContext';
function ImmGetContext(AWnd: HWND): HIMC; stdcall; external imm32 name 'ImmGetContext';
function ImmReleaseContext(AWnd: HWND; hImc: HIMC): Boolean; stdcall; external imm32 name 'ImmReleaseContext';
function ImmAssociateContext(AWnd: HWND; hImc: HIMC): HIMC; stdcall; external imm32 name 'ImmAssociateContext';

// 获取新的编码状态
const
  CFS_DEFAULT                    = $0000;
  CFS_RECT                       = $0001;
  CFS_POINT                      = $0002;
  CFS_SCREEN                     = $0004;	{ removed in 4.0 SDK }
  CFS_FORCE_POSITION             = $0020;
  CFS_CANDIDATEPOS               = $0040;
  CFS_EXCLUDE                    = $0080;

  GCR_ERRORSTR       = 0; //修正错误
  GCR_INFORMATIONSTR = 0; //修正信息串

  GCS_COMPREADSTR    = $0001;//修正读入串。
  GCS_COMPREADATTR   = $0002; //修正读入串的属性
  GCS_COMPREADCLAUSE = $0004;  //修正读入串的属性.
  GCS_COMPSTR        = $0008;//修正当前的编码

  GCS_COMPATTR       = $0010;//修正编码串属性.
  GCS_COMPCLAUSE     = $0020;//修正编码信息.
  GCS_CURSORPOS      = $0080;//修正当前编码的光标位置.
  GCS_DELTASTART     = $0100;//修正当前编码的开始位置
  GCS_RESULTREADSTR  = $0200; //修正读入串.
  GCS_RESULTREADCLAUSE = $0400;  //修正读入串的信息.
  GCS_RESULTSTR      = $0800;//修正编码结果串.
  GCS_RESULTCLAUSE   = $1000;//修正结果串的信息.
  CS_INSERTCHAR      = $2000;//在当前位置插入一个字符
  CS_NOMOVECARET     = $4000;//替换结果串

{ error code of ImmGetCompositionString }
  IMM_ERROR_NODATA               = -1;
  IMM_ERROR_GENERAL              = -2;

function ImmGetCompositionStrA(AImc: HIMC; dWord1: DWORD; lpBuf: pointer; dwBufLen: DWORD): Longint; stdcall;
    external imm32 name 'ImmGetCompositionStringA';

function ImmSetCompositionStrA(AImc: HIMC; dwIndex: DWORD; lpComp: pointer; dwCompLen: DWORD;
    lpRead: pointer; dwReadLen: DWORD):Boolean; stdcall; external imm32 name 'ImmSetCompositionStringA';
function ImmGetCandidateListCountA(AImc: HIMC; var ListCount: DWORD): DWORD; stdcall; external imm32 name 'ImmGetCandidateListCountA';
function ImmGetCandidateListA(AImc: HIMC; deIndex: DWORD; lpCandidateList: PCANDIDATELIST;
    dwBufLen: DWORD): DWORD; stdcall; external imm32 name 'ImmGetCandidateListA';
function ImmGetGuideLineA(AImc: HIMC; dwIndex: DWORD; lpBuf: PAnsiChar; dwBufLen: DWORD): DWORD; stdcall; external imm32 name 'ImmGetGuideLineA';
function ImmGetConversionStatus(AImc: HIMC; var Conversion, Sentence: DWORD): Boolean; stdcall; external imm32 name 'ImmGetConversionStatus';
function ImmSetConversionStatus(AImc: HIMC; Conversion, Sentence: DWORD): Boolean; stdcall; external imm32 name 'ImmSetConversionStatus';
function ImmGetOpenStatus(AImc: HIMC): Boolean; stdcall; external imm32 name 'ImmGetOpenStatus';
function ImmSetOpenStatus(AImc: HIMC; fOpen: Boolean): Boolean; stdcall; external imm32 name 'ImmSetOpenStatus';
function ImmGetCompositionFontA(AImc: HIMC; lpLogfont: PLOGFONTA): Boolean; stdcall; external imm32 name 'ImmGetCompositionFontA';
function ImmSetCompositionFontA(AImc: HIMC; lpLogfont: PLOGFONTA): Boolean; stdcall; external imm32 name 'ImmSetCompositionFontA';
function ImmConfigureIMEA(AKl: HKL; AWnd: HWND; dwMode: DWORD; lpData: pointer): Boolean; stdcall; external imm32 name 'ImmConfigureIMEA';
function ImmEscapeA(AKl: HKL; hImc: HIMC; uEscape: UINT; lpData: pointer): LRESULT; stdcall; external imm32 name 'ImmEscapeA';
function ImmGetConversionListA(AKl: HKL; AImc: HIMC; lpSrc: PAnsiChar; lpDst: PCANDIDATELIST;
    dwBufLen: DWORD; uFlag: UINT ): DWORD; stdcall; external imm32 name 'ImmGetConversionListA';

{ dwIndex for ImmNotifyIME/NI_COMPOSITIONSTR }    
const
  CPS_COMPLETE                   = $0001;
  CPS_CONVERT                    = $0002;
  CPS_REVERT                     = $0003;
  CPS_CANCEL                     = $0004;

function ImmNotifyIME(AImc: HIMC; dwAction, dwIndex, dwValue: DWORD): Boolean; stdcall; external imm32 name 'ImmNotifyIME';

function ImmGetStatusWindowPos(AImc: HIMC; var lpPoint : TPoint): Boolean; stdcall; external imm32 name 'ImmGetStatusWindowPos';
function ImmSetStatusWindowPos(AImc: HIMC; lpPoint: PPOINT): Boolean; stdcall; external imm32 name 'ImmSetStatusWindowPos';
function ImmGetCompositionWindow(AImc: HIMC; lpCompForm: PCOMPOSITIONFORM): Boolean; stdcall; external imm32 name 'ImmGetCompositionWindow';
function ImmSetCompositionWindow(AImc: HIMC; lpCompForm: PCOMPOSITIONFORM): Boolean; stdcall; external imm32 name 'ImmSetCompositionWindow';
function ImmGetCandidateWindow(AImc: HIMC; dwBufLen: DWORD; lpCandidate: PCANDIDATEFORM): Boolean; stdcall; external imm32 name 'ImmGetCandidateWindow';
function ImmSetCandidateWindow(AImc: HIMC; lpCandidate: PCANDIDATEFORM): Boolean; stdcall; external imm32 name 'ImmSetCandidateWindow';
function ImmIsUIMessageA(AWnd: HWND; msg: UINT; wParam: WPARAM; lParam: LPARAM): Boolean; stdcall; external imm32 name 'ImmIsUIMessageA';
function ImmGetVirtualKey(AWnd: HWND): UINT; stdcall; external imm32 name 'ImmGetVirtualKey';
function ImmRegisterWordA(AKl: HKL; lpszReading: PAnsiChar; dwStyle: DWORD; lpszRegister: PAnsiChar): Boolean; stdcall; external imm32 name 'ImmRegisterWordA';
function ImmUnregisterWordA(AKl: HKL; lpszReading: PAnsiChar; dwStyle: DWORD; lpszUnregister: PAnsiChar): Boolean; stdcall; external imm32 name 'ImmUnregisterWordA';
function ImmGetRegisterWordStyleA(AKl: HKL; nItem: UINT; lpStyleBuf: PSTYLEBUF): UINT; stdcall; external imm32 name 'ImmGetRegisterWordStyleA';

type
  RegisterWordEnumProcA = Function(lpReading: PAnsiChar; dwStyle: DWORD; lpszStr: PAnsiChar; lpData: pointer): integer;
  RegisterWordEnumProc = RegisterWordEnumProcA;

function ImmEnumRegisterWordA(AKl: HKL; lpfnEnumProc: REGISTERWORDENUMPROC; lpszReading: PAnsiChar;
    dwStyle: DWORD; lpszRegister: PAnsiChar; lpData : pointer): UINT; stdcall; external imm32 name 'ImmEnumRegisterWordA';

const
{ the modifiers of hot key }    
  MOD_ALT                        = $0001;
  MOD_CONTROL                    = $0002;
  MOD_SHIFT                      = $0004;

  MOD_LEFT                       = $8000;
  MOD_RIGHT                      = $4000;

  MOD_ON_KEYUP                   = $0800;
  MOD_IGNORE_ALL_MODIFIER        = $0400;

function ImmAssociateContextEx(AWnd: HWND; AImc: HIMC; dwFlag: DWORD): HIMC; stdcall;
  external imm32 name 'ImmAssociateContextEx';

function ImmCreateSoftKeyboard( //产生一个软键盘
    uType: UINT; //软件盘上的键码含义的定义方式
    //=SOFTKEYBOARD_TYPE_T1
    //=SOFTKEYBOARD_TYPE_C1
    AOwner: UINT; //该输入法的UI窗口
    x, y: int32
    ): HWND; stdcall; external imm32 name 'ImmCreateSoftKeyboard';//定位坐标

function ImmDestroySoftKeyboard( //销毁软键盘
    hSoftKbdWnd: HWND): BOOL; stdcall;  external imm32 name 'ImmDestroySoftKeyboard';

function ImmShowSoftKeyboard( //显示或隐藏软键盘
    hSoftKbdWnd: HWND; //软年盘窗口句柄
    nCmdShow: int32 //窗口状态=SW_HIDE 表示隐藏，=SW_SHOWNOACTIVATE表示显示
    ): BOOL; stdcall;  external imm32 name 'ImmShowSoftKeyboard';

function ImmDisableIME(idThread: DWORD): BOOL; stdcall;  external imm32 name 'ImmDisableIME';

implementation

(*


自己改改：

SetIMEMode(HWND hWnd, DWORD dwNewConvMode, DWORD dwNewSentMode, BOOL fFlag)
{
	HIMC	hImc;
	DWORD	dwConvMode, dwSentMode;
	BOOL	fRet;

	// Get input context
	hImc = ImmGetContext(hWnd);
	if (hImc)
	{
		// Get current IME status
		ImmGetConversionStatus(hImc, &dwConvMode, &dwSentMode);

		// Change IME status using passed option
		if (fFlag)
		{
			fRet = ImmSetConversionStatus(hImc, dwConvMode | dwNewConvMode, dwSentMode | dwNewSentMode);
			if ((m_IMEEdit.m_nLanguage == JAPANESE) && (dwNewConvMode & IME_CMODE_NATIVE))
				ImmSetOpenStatus(hImc, fFlag);

		}
		else
		{
			ImmSetConversionStatus(hImc, dwConvMode & ~dwNewConvMode, dwSentMode & ~dwNewSentMode);
			if ((m_IMEEdit.m_nLanguage == JAPANESE) && (dwNewConvMode & IME_CMODE_NATIVE))
				ImmSetOpenStatus(hImc, fFlag);
		}

		// Release input context
		ImmReleaseContext(hWnd, hImc);
	}
}
Top

*)
end.
