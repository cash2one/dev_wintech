unit uiwin_wndprocw_mouse;

interface

uses
  Windows, Messages, UIBaseWin;

  function WndProcW_WMLButtonUp(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMLButtonDown(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMMouseMove(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMMouseWheel(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMSetCursor(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMNCHitTest(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcW_WMMouseHover(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMMouseLeave(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

implementation

function WndProcW_WMLButtonUp(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMLButtonDown(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMMouseMove(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMMouseWheel(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMSetCursor(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMNCHitTest(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMMouseHover(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcW_WMMouseLeave(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

end.
