unit uiwindow_wndproc_uispace;

interface
                  
uses
  Windows,
  Messages,
  uiwindow_clip;
  
  function UIWndProcA_UISpace(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;

implementation
                
function WndProcA_WMNCCALCSIZE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_NCCALCSIZE, wParam, lParam);
end;
                                   
function WndProcA_WMSIZE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_SIZE, wParam, lParam);
end;
                                  
function WndProcA_WMMOVE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_MOVE, wParam, lParam);
end;
                                  
function WndProcA_WMWINDOWPOSCHANGING(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_WINDOWPOSCHANGING, wParam, lParam);
end;
        
function WndProcA_WMWINDOWPOSCHANGED(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_WINDOWPOSCHANGED, wParam, lParam);
end;

function UIWndProcA_UISpace(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;
begin
  Result := true;
  case AMsg of
    WM_NCCALCSIZE: AWndProcResult := WndProcA_WMNCCALCSIZE(AUIWindow, wParam, lParam);   
    WM_SIZE: AWndProcResult := WndProcA_WMSIZE(AUIWindow, wParam, lParam);             
    WM_MOVE: AWndProcResult := WndProcA_WMMOVE(AUIWindow, wParam, lParam);
    WM_WINDOWPOSCHANGING: AWndProcResult := WndProcA_WMWINDOWPOSCHANGING(AUIWindow, wParam, lParam);
    WM_WINDOWPOSCHANGED: AWndProcResult := WndProcA_WMWINDOWPOSCHANGED(AUIWindow, wParam, lParam);
    else
      Result := false;
  end;     
end;

end.
