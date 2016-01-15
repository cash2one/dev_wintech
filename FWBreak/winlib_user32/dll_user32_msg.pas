{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_msg;

interface 

uses
  atmcmbaseconst, winconst, wintype;
  
  function GetMessage(var lpMsg: TMsg; AWnd: HWND;
    wMsgFilterMin, wMsgFilterMax: UINT): BOOL; stdcall; external user32 name 'GetMessageA';
  function TranslateMessage(const lpMsg: TMsg): BOOL; stdcall; external user32 name 'TranslateMessage';
  
const
  { PeekMessage() Options }
  PM_NOREMOVE = 0;
  PM_REMOVE = 1;
  PM_NOYIELD = 2;

  function PeekMessage(var lpMsg: TMsg; AWnd: HWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; stdcall; external user32 name 'PeekMessageA';
  function DispatchMessage(const lpMsg: TMsg): Longint; stdcall; external user32 name 'DispatchMessageA';
  function PostMessage(AWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall; external user32 name 'PostMessageA';
  procedure PostQuitMessage(nExitCode: Integer); stdcall; external user32 name 'PostQuitMessage';
  function PostThreadMessage(idThread: DWORD; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall; external user32 name 'PostThreadMessageA';
  function RegisterWindowMessage(lpStr: PAnsiChar): UINT; stdcall; external user32 name 'RegisterWindowMessageA';
  function SendNotifyMessage(AWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall; external user32 name 'SendNotifyMessageA';
  function SendMessage(AWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; external user32 name 'SendMessageA';

const
  { SendMessageTimeout values }
  SMTO_NORMAL = 0;
  SMTO_BLOCK = 1;
  SMTO_ABORTIFHUNG = 2;
  SMTO_NOTIMEOUTIFNOTHUNG = 8;

  function SendMessageTimeout(AWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM;
    fuFlags, uTimeout: UINT; var lpdwResult: DWORD): LRESULT; stdcall; external user32 name 'SendMessageTimeoutA';

  function WaitMessage: BOOL; stdcall; external user32 name 'WaitMessage';
  function ReplyMessage(lResult: LRESULT): BOOL; stdcall; external user32 name 'ReplyMessage';

  function WaitForInputIdle(hProcess: THandle; dwMilliseconds: DWORD): DWORD; stdcall; external user32 name 'WaitForInputIdle';

  function BroadcastSystemMessage(Flags: DWORD; Recipients: PDWORD;
    uiMessage: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall; external user32 name 'BroadcastSystemMessageA';
  function CallMsgFilter(var lpMsg: TMsg; nCode: Integer): BOOL; stdcall; external user32 name 'CallMsgFilterA';

type
  TFNSendAsyncProc = TFarProc;
    
  function SendMessageCallback(AWnd: HWND; Msg: UINT; wParam: WPARAM;
    lParam: LPARAM; lpResultCallBack: TFNSendAsyncProc; dwData: DWORD): BOOL; stdcall; external user32 name 'SendMessageCallbackA';

  // ChangeWindowMessageFilter(WM_COPYDATA, MSGFLT_ADD);
  (*
http://msdn.microsoft.com/zh-cn/ms632675  
Using the ChangeWindowMessageFilter function is not recommended, as it has process-wide scope. Instead, use the ChangeWindowMessageFilterEx function to control access to specific windows as needed. ChangeWindowMessageFilter may not be supported in future versions of Windows
Adds or removes a message from the User Interface Privilege Isolation (UIPI) message filter.
在vista以上的系统，有些程序需要管理员的权限，所以需要服务，这个函数可以解决低权和高权程序之间的沟通。


  ChangeWindowMessageFilter(WM_COPYDATA, MSGFLT_ADD);
  ChangeWindowMessageFilter(WM_MKFinder, MSGFLT_ADD);
  ChangeWindowMessageFilter(WM_MKNoteHost, MSGFLT_ADD);

  // windows 8, windows 7 下 拖动失效
  ChangeWindowMessageFilter(WM_DROPFILES, MSGFLT_ADD);
  // WM_COPYGLOBALDATA $0049
  ChangeWindowMessageFilter($0049, MSGFLT_ADD);
  *)
const
  MSGFLT_ADD      = 1;// Adds the message to the filter. This has the effect of allowing
                      // the message to be received.
  MSGFLT_REMOVE   = 2;// Removes the message from the filter. This has the effect of blocking the message.

  function ChangeWindowMessageFilter(Message: UINT; dwFlag: DWord): BOOL; stdcall; external user32 name 'ChangeWindowMessageFilter';

type
  PCHANGEFILTERSTRUCT = ^TCHANGEFILTERSTRUCT;
  TCHANGEFILTERSTRUCT = record
    cbSize: DWORD;
    ExtStatus: DWORD;
  end;

const
  MSGFLT_RESET = 0;
  MSGFLT_ALLOW = 1;
  MSGFLT_DISALLOW = 2;

  // ExtStatus
  MSGFLTINFO_NONE = 0;
  MSGFLTINFO_ALREADYALLOWED_FORWND = 1;
  MSGFLTINFO_ALREADYDISALLOWED_FORWND = 2;
  MSGFLTINFO_ALLOWED_HIGHER = 3;

  function ChangeWindowMessageFilterEx(AWnd: HWND; Message: UINT; dwAction: DWord;
    pChangeFilterStruct: PCHANGEFILTERSTRUCT): BOOL; stdcall; external user32 name 'ChangeWindowMessageFilterEx';

implementation

end.
