unit uiwindow_wndproc_key;

interface
          
uses
  Windows, 
  Messages,
  uiwindow_memdc;
                    
  function UIWndProcA_Key(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;

implementation

function UIWndProcA_Key(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean; 
begin
  Result := False;
//  case AMsg of
//    WM_Char: WndProcA_WMChar(AUIWindow, AWnd, wParam, lParam);
//    WM_KEYDOWN: WndProcA_WMKeyDown(AUIWindow, AWnd, wParam, lParam);
//    WM_KEYUP: WndProcA_WMKeyUp(AUIWindow, AWnd, wParam, lParam);
//
//    WM_SYSKEYDOWN: WndProcA_WMSysKeyDown(AUIWindow, AWnd, wParam, lParam);
//    WM_SYSKEYUP: WndProcA_WMSysKeyUp(AUIWindow, AWnd, wParam, lParam);
//
//    WM_IME_STARTCOMPOSITION: WndProcA_WMImeStartComposition(AUIWindow, AWnd, wParam, lParam);
//    WM_IME_ENDCOMPOSITION: WndProcA_WMImeEndComposition(AUIWindow, AWnd, wParam, lParam);
//    WM_IME_COMPOSITION: WndProcA_WMImeComposition(AUIWindow, AWnd, wParam, lParam);
//
//    WM_IME_SETCONTEXT: WndProcA_WMImeSetContext(AUIWindow, AWnd, wParam, lParam);
//    WM_IME_NOTIFY: WndProcA_WMImeNotify(AUIWindow, AWnd, wParam, lParam);
//  end;
end;
  
end.
