unit uiwindow_wndproc_key;

interface
          
uses
  Windows, 
  Messages,
  uiwindow;
                    
  function UIWndProcW_Key(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;

implementation
               
function WndProcW_WMChar(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_Char, wParam, lParam);
end;
                       
function WndProcW_WMKeyDown(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_KEYDOWN, wParam, lParam);
end;
                                     
function WndProcW_WMKeyUp(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_KEYUP, wParam, lParam);
end;
                                     
function WndProcW_WMSysKeyDown(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_SYSKEYDOWN, wParam, lParam);
end;
                                    
function WndProcW_WMSysKeyUp(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_SYSKEYUP, wParam, lParam);
end;
                                   
function WndProcW_WMImeStartComposition(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_IME_STARTCOMPOSITION, wParam, lParam);
end;
                                
function WndProcW_WMImeEndComposition(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_IME_ENDCOMPOSITION, wParam, lParam);
end;
                               
function WndProcW_WMImeComposition(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_IME_COMPOSITION, wParam, lParam);
end;
                              
function WndProcW_WMImeSetContext(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_IME_SETCONTEXT, wParam, lParam);
end;
                             
function WndProcW_WMImeNotify(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_IME_NOTIFY, wParam, lParam);
end;

function UIWndProcW_Key(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean; 
begin
  Result := True;
  case AMsg of
    WM_Char: WndProcW_WMChar(AUIWindow, wParam, lParam);
    WM_KEYDOWN: WndProcW_WMKeyDown(AUIWindow, wParam, lParam);
    WM_KEYUP: WndProcW_WMKeyUp(AUIWindow, wParam, lParam);

    WM_SYSKEYDOWN: WndProcW_WMSysKeyDown(AUIWindow, wParam, lParam);
    WM_SYSKEYUP: WndProcW_WMSysKeyUp(AUIWindow, wParam, lParam);

    WM_IME_STARTCOMPOSITION: WndProcW_WMImeStartComposition(AUIWindow, wParam, lParam);
    WM_IME_ENDCOMPOSITION: WndProcW_WMImeEndComposition(AUIWindow, wParam, lParam);
    WM_IME_COMPOSITION: WndProcW_WMImeComposition(AUIWindow, wParam, lParam);

    WM_IME_SETCONTEXT: WndProcW_WMImeSetContext(AUIWindow, wParam, lParam);
    WM_IME_NOTIFY: WndProcW_WMImeNotify(AUIWindow, wParam, lParam);
    else
      Result := false;
  end;
end;
  
end.
