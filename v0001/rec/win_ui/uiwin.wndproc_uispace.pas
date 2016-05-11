unit uiwin.wndproc_uispace;

interface
              
uses                                                                       
  Windows, Messages, uiwin.wnd;
                                
  function WndProcW_WMNCCALCSIZE(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;  
  function WndProcW_WMSIZE(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;   
  function WndProcW_WMMOVE(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMWINDOWPOSCHANGING(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;   
  function WndProcW_WMWINDOWPOSCHANGED(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;

implementation

function WndProcW_WMNCCALCSIZE(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCCALCSIZE, wParam, lParam);
end;
                                   
function WndProcW_WMSIZE(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_SIZE, wParam, lParam);
end;
                                  
function WndProcW_WMMOVE(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_MOVE, wParam, lParam);                             
end;
                                  
function WndProcW_WMWINDOWPOSCHANGING(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_WINDOWPOSCHANGING, wParam, lParam);
end;
        
function WndProcW_WMWINDOWPOSCHANGED(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_WINDOWPOSCHANGED, wParam, lParam);
end;

end.
