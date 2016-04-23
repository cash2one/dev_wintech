unit uiwindow_wndproc;

interface

uses
  Windows,
  Messages,
  uiwindow_clip;
               
  function UIWindowProcA(AWindow: PUIWindow; AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;

implementation
        
uses
  UtilsLog,
  Sysutils,
  uiwindow_wndproc_startend,
  uiwindow_wndproc_paint,
  uiwindow_wndproc_mouse,
  uiwindow_wndproc_key;

function UIWindowProcA(AWindow: PUIWindow; AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; 
begin
  SDLog('', 'Wnd Message:' + IntToStr(AMsg));         
  if UIWndProcA_Paint(AWindow, AMsg, wParam, lParam, Result) then
    exit;
  if UIWndProcA_Mouse(AWindow, AMsg, wParam, lParam, Result) then
    exit;
  if UIWndProcA_Key(AWindow, AMsg, wParam, lParam, Result) then
    exit;

  // start end 放最后处理
  if 0 = AWindow.BaseWnd.UIWndHandle then
    AWindow.BaseWnd.UIWndHandle := AWnd; 
  if UIWndProcA_StartEnd(AWindow, AMsg, wParam, lParam, Result) then
    exit;
  Result := DefWindowProcA(AWnd, AMsg, wParam, lParam);
end;

end.
