unit uiwindow_wndproc_startend;

interface
            
uses
  Windows,
  Messages,
  uiwindow;
       
  function UIWndProcW_StartEnd(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;

implementation
                        
function WndProcW_WMNCCREATE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCCREATE, wParam, lParam);
end;
                            
function WndProcW_WMCREATE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_CREATE, wParam, lParam);
end;
                        
function WndProcW_WMACTIVATEAPP(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_ACTIVATEAPP, wParam, lParam);
end;
                        
function WndProcW_WMNCACTIVATE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCACTIVATE, wParam, lParam);
end;    
                        
function WndProcW_WMACTIVATE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_ACTIVATE, wParam, lParam);
end;
                       
function WndProcW_WMCLOSE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_CLOSE, wParam, lParam);
end;
                       
function WndProcW_WMDESTROY(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_DESTROY, wParam, lParam);
end;
                       
function WndProcW_WMNCDESTROY(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  PostQuitMessage(0);
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCDESTROY, wParam, lParam);
end;

function UIWndProcW_StartEnd(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean; 
begin
  Result := true;
  case AMsg of
    WM_NCCREATE {129 $0081}: AWndProcResult := WndProcW_WMNCCREATE(AUIWindow, wParam, lParam);
    //WM_NCCALCSIZE {131}: ;
    WM_CREATE {1}: AWndProcResult := WndProcW_WMCREATE(AUIWindow, wParam, lParam);
//    WM_SIZE {5}: ;
//    WM_MOVE {3}: ;
//    WM_SHOWWINDOW {24 $0018}: ;
//    WM_WINDOWPOSCHANGING {70 $0046}: ;
    WM_ACTIVATEAPP {28 $001C}: AWndProcResult := WndProcW_WMACTIVATEAPP(AUIWindow, wParam, lParam); 
    WM_NCACTIVATE {134 $0086}: AWndProcResult := WndProcW_WMNCACTIVATE(AUIWindow, wParam, lParam);
    WM_ACTIVATE {6}: AWndProcResult := WndProcW_WMACTIVATE(AUIWindow, wParam, lParam);
//    WM_IME_SETCONTEXT{641 $0281} : ;
//    WM_IME_NOTIFY{642}: ;
//    WM_SETFOCUS{7}: ;
//    WM_NCPAINT{133}: ;
//    WM_ERASEBKGND{20 $0014}: ;
//    WM_WINDOWPOSCHANGED{71}: ;
//    WM_PAINT{15}: ;
//    WM_NCHITTEST{132}: ;
//    WM_SETCURSOR{32}: ;
//    WM_MOUSEMOVE{512}: ;
//    WM_SYSKEYDOWN{260}: begin
      // Alt + F4
//    end;
//    WM_SYSCOMMAND{274}: begin
//    end;
    WM_CLOSE{16}: AWndProcResult := WndProcW_WMCLOSE(AUIWindow, wParam, lParam);
//    144{144 $0090}: begin
//    end;
//    WM_KILLFOCUS{8 $8}: ;
    WM_DESTROY{2}: AWndProcResult := WndProcW_WMDESTROY(AUIWindow, wParam, lParam);
    WM_NCDESTROY{130 $0082}: AWndProcResult := WndProcW_WMNCDESTROY(AUIWindow, wParam, lParam);
    else
      Result := false;
  end;     
end;

end.
