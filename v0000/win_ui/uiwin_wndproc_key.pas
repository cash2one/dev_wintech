unit uiwin_wndproc_key;

interface

uses
  Windows, Messages, UIBaseWin;
               
  function WndProcA_WMChar(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMKeyDown(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMKeyUp(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcA_WMSysKeyDown(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMSysKeyUp(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcA_WMImeStartComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMImeEndComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMImeComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcA_WMImeSetContext(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMImeNotify(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  
implementation

function WndProcA_WMChar(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMKeyDown(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMKeyUp(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMSysKeyDown(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMSysKeyUp(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMImeStartComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMImeEndComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMImeComposition(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMImeSetContext(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMImeNotify(AUIWindow: PUIBaseWnd; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

end.
