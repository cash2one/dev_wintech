unit uiwindow_wndproc;

interface

uses
  Windows,
  Messages,
  uiwindow;
               
  function UIWindowProcW(AWindow: PUIWindow; AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;

implementation
        
uses
  UtilsLog,
  Sysutils,
  uiwindow_wndproc_startend,
  uiwindow_wndproc_uispace,
  uiwindow_wndproc_paint,
  uiwindow_wndproc_mouse,
  uiwindow_wndproc_key;

function UIWindowProcW(AWindow: PUIWindow; AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; 
begin
  //SDLog('', 'Wnd Message:' + IntToStr(AMsg));         
  if UIWndProcW_Paint(AWindow, AMsg, wParam, lParam, Result) then
    exit;
  if UIWndProcW_Mouse(AWindow, AMsg, wParam, lParam, Result) then
    exit;    
  if UIWndProcW_UISpace(AWindow, AMsg, wParam, lParam, Result) then
  begin
    exit;
  end;
  if UIWndProcW_Key(AWindow, AMsg, wParam, lParam, Result) then
    exit;
  // start end 放最后处理
  if 0 = AWindow.BaseWnd.UIWndHandle then
    AWindow.BaseWnd.UIWndHandle := AWnd; 
  if UIWndProcW_StartEnd(AWindow, AMsg, wParam, lParam, Result) then
    exit;
  Result := DefWindowProcW(AWnd, AMsg, wParam, lParam);
end;

end.
