unit uiwindow_wndproc_key;

interface
          
uses
  Windows, 
  Messages,
  uiwindow_clip;
                    
  function UIWndProcA_Key(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;

implementation
               
function WndProcA_WMChar(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_Char, wParam, lParam);
end;
                       
function WndProcA_WMKeyDown(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_KEYDOWN, wParam, lParam);
end;
                                     
function WndProcA_WMKeyUp(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_KEYUP, wParam, lParam);
end;
                                     
function WndProcA_WMSysKeyDown(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_SYSKEYDOWN, wParam, lParam);
end;
                                    
function WndProcA_WMSysKeyUp(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_SYSKEYUP, wParam, lParam);
end;
                                   
function WndProcA_WMImeStartComposition(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_IME_STARTCOMPOSITION, wParam, lParam);
end;
                                
function WndProcA_WMImeEndComposition(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_IME_ENDCOMPOSITION, wParam, lParam);
end;
                               
function WndProcA_WMImeComposition(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_IME_COMPOSITION, wParam, lParam);
end;
                              
function WndProcA_WMImeSetContext(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_IME_SETCONTEXT, wParam, lParam);
end;
                             
function WndProcA_WMImeNotify(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_IME_NOTIFY, wParam, lParam);
end;

function UIWndProcA_Key(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean; 
begin
  Result := True;
  case AMsg of
    WM_Char: WndProcA_WMChar(AUIWindow, wParam, lParam);
    WM_KEYDOWN: WndProcA_WMKeyDown(AUIWindow, wParam, lParam);
    WM_KEYUP: WndProcA_WMKeyUp(AUIWindow, wParam, lParam);

    WM_SYSKEYDOWN: WndProcA_WMSysKeyDown(AUIWindow, wParam, lParam);
    WM_SYSKEYUP: WndProcA_WMSysKeyUp(AUIWindow, wParam, lParam);

    WM_IME_STARTCOMPOSITION: WndProcA_WMImeStartComposition(AUIWindow, wParam, lParam);
    WM_IME_ENDCOMPOSITION: WndProcA_WMImeEndComposition(AUIWindow, wParam, lParam);
    WM_IME_COMPOSITION: WndProcA_WMImeComposition(AUIWindow, wParam, lParam);

    WM_IME_SETCONTEXT: WndProcA_WMImeSetContext(AUIWindow, wParam, lParam);
    WM_IME_NOTIFY: WndProcA_WMImeNotify(AUIWindow, wParam, lParam);
  end;
end;
  
end.
