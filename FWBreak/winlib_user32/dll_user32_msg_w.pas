{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_msg_w;

interface 

uses
  atmcmbaseconst, winconst, wintype;
  
  function GetMessageW(var lpMsg: TMsg; AWnd: HWND;
    wMsgFilterMin, wMsgFilterMax: UINT): BOOL; stdcall; external user32 name 'GetMessageW';

  function PeekMessageW(var lpMsg: TMsg; AWnd: HWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; stdcall; external user32 name 'PeekMessageW';
  function DispatchMessageW(const lpMsg: TMsg): Longint; stdcall; external user32 name 'DispatchMessageW';
  function PostMessageW(AWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall; external user32 name 'PostMessageW';
  function PostThreadMessageW(idThread: DWORD; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall; external user32 name 'PostThreadMessageW';
  function RegisterWindowMessageW(lpStr: PAnsiChar): UINT; stdcall; external user32 name 'RegisterWindowMessageA';
  function SendNotifyMessageW(AWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall; external user32 name 'SendNotifyMessageW';
  function SendMessageW(AWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; external user32 name 'SendMessageW';

  function SendMessageTimeoutW(AWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM;
    fuFlags, uTimeout: UINT; var lpdwResult: DWORD): LRESULT; stdcall; external user32 name 'SendMessageTimeoutW';

  function BroadcastSystemMessageW(Flags: DWORD; Recipients: PDWORD;
    uiMessage: UINT; wParam: WPARAM; lParam: LPARAM): Longint; stdcall; external user32 name 'BroadcastSystemMessageW';
  function CallMsgFilterW(var lpMsg: TMsg; nCode: Integer): BOOL; stdcall; external user32 name 'CallMsgFilterW';

type
  TFNSendAsyncProc = TFarProc;
    
  function SendMessageCallbackW(AWnd: HWND; Msg: UINT; wParam: WPARAM;
    lParam: LPARAM; lpResultCallBack: TFNSendAsyncProc; dwData: DWORD): BOOL; stdcall; external user32 name 'SendMessageCallbackW';

implementation

end.
