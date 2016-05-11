unit uiwin.wndproc_key;

interface
                                      
uses
  Windows, Messages, uiwin.wnd;
  
  function WndProcW_WMChar(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT; overload;
  function WndProcW_WMKeyDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMKeyUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMSysKeyDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMSysKeyUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMImeStartComposition(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMImeEndComposition(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMImeComposition(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMImeSetContext(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMImeNotify(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  //function WndProcW_WMChar(AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; overload;
  
implementation
                
function WndProcW_WMChar(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := Windows.DefWindowProcW(AUIWnd.WndHandle, WM_Char, wParam, lParam);
end;

function WndProcW_WMKeyDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_KEYDOWN, wParam, lParam);
end;
                                     
function WndProcW_WMKeyUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_KEYUP, wParam, lParam);
end;
                                     
function WndProcW_WMSysKeyDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_SYSKEYDOWN, wParam, lParam);
end;
                                    
function WndProcW_WMSysKeyUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_SYSKEYUP, wParam, lParam);
end;
                                   
function WndProcW_WMImeStartComposition(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_IME_STARTCOMPOSITION, wParam, lParam);
end;
                                
function WndProcW_WMImeEndComposition(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_IME_ENDCOMPOSITION, wParam, lParam);
end;
                               
function WndProcW_WMImeComposition(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_IME_COMPOSITION, wParam, lParam);
end;
                              
function WndProcW_WMImeSetContext(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_IME_SETCONTEXT, wParam, lParam);
end;
                             
function WndProcW_WMImeNotify(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_IME_NOTIFY, wParam, lParam);
end;

end.
