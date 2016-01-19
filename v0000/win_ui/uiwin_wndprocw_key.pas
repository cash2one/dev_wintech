unit uiwin_wndprocw_key;

interface

uses
  Windows, Messages, UIBaseWin;
               
  function WndProcW_WMChar(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMKeyDown(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMKeyUp(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcW_WMSysKeyDown(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMSysKeyUp(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcW_WMImeStartComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMImeEndComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMImeComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcW_WMImeSetContext(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMImeNotify(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  
implementation

function WndProcW_WMChar(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMKeyDown(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMKeyUp(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMSysKeyDown(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMSysKeyUp(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMImeStartComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMImeEndComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMImeComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMImeSetContext(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMImeNotify(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

end.
