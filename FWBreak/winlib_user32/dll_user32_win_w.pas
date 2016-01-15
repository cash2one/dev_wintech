{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_win_w;

interface

uses
  atmcmbaseconst, winconst, wintype, wintypeW;

  function SetWindowLongW(hWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint; stdcall; external user32 name 'SetWindowLongW';
  function GetWindowLongW(hWnd: HWND; nIndex: Integer): Longint; stdcall; external user32 name 'GetWindowLongW';

  function DefWindowProcW(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; external user32 name 'DefWindowProcW';
  function CallWindowProcW(lpPrevWndFunc: TFNWndProc; hWnd: HWND; Msg: UINT; wParam: WPARAM;
    lParam: LPARAM): LRESULT; stdcall; external user32 name 'CallWindowProcW';

  function FindWindowW(lpClassName, lpWindowName: PWideChar): HWND; stdcall; external user32 name 'FindWindowW';
  function FindWindowExW(Parent, Child: HWND; ClassName, WindowName: PWideChar): HWND; stdcall; external user32 name 'FindWindowW';


  function CreateWindowExW(dwExStyle: DWORD; lpClassName: PWideChar;
    lpWindowName: PWideChar; dwStyle: DWORD; X, Y, nWidth, nHeight: Integer;
    hWndParent: HWND; hMenu: HMENU; hInstance: HINST; lpParam: Pointer): HWND; stdcall; external user32 name 'CreateWindowExW';

  function SetPropW(hWnd: HWND; lpStr: PWideChar; hData: THandle): BOOL; stdcall; external user32 name 'SetPropW';
  function MessageBoxW(hWnd: HWND; lpText, lpCaption: PWideChar; uType: UINT): Integer; stdcall; external user32 name 'MessageBoxW';

  function GetClassInfoW(hInstance: HINST; lpClassName: PWideChar; var lpWndClass: TWndClassW): BOOL; stdcall; external user32 name 'GetClassInfoW';
  function GetClassInfoExW(Instance: HINST; Classname: PWideChar; var WndClass: TWndClassExW): BOOL; stdcall; external user32 name 'GetClassInfoExW';
  function GetClassNameW(AWnd: HWND; lpClassName: PWideChar; nMaxCount: Integer): Integer; stdcall; external user32 name 'GetClassNameW';

  function RegisterClassW(const lpWndClass: TWndClassW): ATOM; stdcall; external user32 name 'RegisterClassW';
  function RegisterClassExW(const WndClass: TWndClassExW): ATOM; stdcall; external user32 name 'RegisterClassExW';
  function UnregisterClassW(lpClassName: PWideChar; hInstance: HINST): BOOL; stdcall; external user32 name 'UnregisterClassW';

  function GetWindowModuleFileNameW(hwnd: HWND; pszFileName: PWideChar; cchFileNameMax: UINT): UINT; stdcall; external user32 name 'GetWindowModuleFileNameW';

implementation

end.
