unit uiwin_wndproc_mouse;

interface

uses
  Windows, Messages, UIBaseWin;

  function WndProcA_WMLButtonUp(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMLButtonDown(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMMouseMove(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMMouseWheel(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMSetCursor(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMNCHitTest(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcA_WMMouseHover(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcA_WMMouseLeave(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;

implementation

function WndProcA_WMLButtonUp(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMLButtonDown(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMMouseMove(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMMouseWheel(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMSetCursor(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMNCHitTest(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMMouseHover(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

function WndProcA_WMMouseLeave(AUIWindow: PUIWin_Main; AWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := 0;
end;

end.
