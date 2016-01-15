{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_win_a;

interface

uses
  atmcmbaseconst, winconst, wintype, wintypeW;

  function SetWindowLongA(hWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint; stdcall; external user32 name 'SetWindowLongA';
  function GetWindowLongA(hWnd: HWND; nIndex: Integer): Longint; stdcall; external user32 name 'GetWindowLongA';

  function DefWindowProcA(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; external user32 name 'DefWindowProcA';
  function CallWindowProcA(lpPrevWndFunc: TFNWndProc; hWnd: HWND; Msg: UINT; wParam: WPARAM;
    lParam: LPARAM): LRESULT; stdcall; external user32 name 'CallWindowProcA';
  function FindWindowA(lpClassName, lpWindowName: PAnsiChar): HWND; stdcall; external user32 name 'FindWindowA';
  function FindWindowExA(Parent, Child: HWND; ClassName, WindowName: PAnsiChar): HWND; stdcall; external user32 name 'FindWindowA';

  function CreateWindowExA(dwExStyle: DWORD; lpClassName: PAnsiChar;
    lpWindowName: PAnsiChar; dwStyle: DWORD; X, Y, nWidth, nHeight: Integer;
    hWndParent: HWND; hMenu: HMENU; hInstance: HINST; lpParam: Pointer): HWND; stdcall; external user32 name 'CreateWindowExA';
  function CreateWindowExW(dwExStyle: DWORD; lpClassName: PWideChar;
    lpWindowName: PWideChar; dwStyle: DWORD; X, Y, nWidth, nHeight: Integer;
    hWndParent: HWND; hMenu: HMENU; hInstance: HINST; lpParam: Pointer): HWND; stdcall; external user32 name 'CreateWindowExW';

  function SetPropA(AWnd: HWND; lpStr: PAnsiChar; hData: THandle): BOOL; stdcall; external user32 name 'SetPropA';

  function MessageBoxA(AWnd: HWND; lpText, lpCaption: PAnsiChar; uType: UINT): Integer; stdcall; external user32 name 'MessageBoxA';

  function GetClassInfoA(AInstance: HINST; lpClassName: PAnsiChar; var lpWndClass: TWndClass): BOOL; stdcall; external user32 name 'GetClassInfoA';
  function GetClassInfoExA(AInstance: HINST; Classname: PAnsiChar; var WndClass: TWndClassEx): BOOL; stdcall; external user32 name 'GetClassInfoExA';
  function GetClassNameA(AWnd: HWND; lpClassName: PAnsiChar; nMaxCount: Integer): Integer; stdcall; external user32 name 'GetClassNameA';
  function RegisterClassA(const lpWndClass: TWndClass): ATOM; stdcall; external user32 name 'RegisterClassA';
  function RegisterClassExA(const WndClass: TWndClassEx): ATOM; stdcall; external user32 name 'RegisterClassExA';
  function UnregisterClassA(lpClassName: PAnsiChar; hInstance: HINST): BOOL; stdcall; external user32 name 'UnregisterClassA';

  function GetWindowModuleFileNameA(AWnd: HWND; pszFileName: PAnsiChar; cchFileNameMax: UINT): UINT; stdcall; external user32 name 'GetWindowModuleFileNameA';

 
implementation

end.
