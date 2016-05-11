unit uiwin.wndproc_wnd;

interface
                      
uses                                                                       
  Windows, Messages, uiwin.wnd;
                                
  function WndProcW_WMNCCreate(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;  
  function WndProcW_WMCreate(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;   
  function WndProcW_WMDestroy(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcW_WMSetFocus(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMKillFocus(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcW_WMActivate(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMActivateApp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
    
implementation

function WndProcW_WMNCCreate(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCCREATE, wParam, lParam);
end;

function WndProcW_WMCreate(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_CREATE, wParam, lParam);
end;

function WndProcW_WMDestroy(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_DESTROY, wParam, lParam);
end;

function WndProcW_WMSetFocus(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_SETFOCUS, wParam, lParam);
end;

function WndProcW_WMKillFocus(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_KillFOCUS, wParam, lParam);
end;
          
function WndProcW_WMActivate(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_ACTIVATE, wParam, lParam);
end;
               
function WndProcW_WMActivateApp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_ACTIVATEAPP, wParam, lParam);
end;

end.
