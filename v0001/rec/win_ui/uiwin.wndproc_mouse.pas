unit uiwin.wndproc_mouse;

interface
                   
uses
  Windows, Messages, uiwin.wnd;
                    
  function WndProcW_WMLButtonDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMLButtonUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMLButtonDblClk(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcW_WMRButtonDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMRButtonUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMRButtonDblClk(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcW_WMMButtonDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMMButtonUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMMButtonDblClk(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;

  function WndProcW_WMMouseMove(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMMouseWheel(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMSetCursor(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMNCHitTest(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMMouseHover(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMMouseLeave(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMNCMOUSEMOVE(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  
  function WndProcW_WMNCLBUTTONDOWN(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMNCLBUTTONUP(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
  function WndProcW_WMNCLBUTTONDBLCLK(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;

implementation
                  
function WndProcW_WMLButtonDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := Windows.DefWindowProcW(AUIWnd.WndHandle, WM_LButtonDown, wParam, lParam);
end;

function WndProcW_WMLButtonUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_LBUTTONUP, wParam, lParam);
end;

function WndProcW_WMLButtonDblClk(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_LBUTTONDBLCLK, wParam, lParam);
end;

function WndProcW_WMRButtonDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_RBUTTONDOWN, wParam, lParam);
end;
            
function WndProcW_WMRButtonUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_RBUTTONUP, wParam, lParam);
end;

function WndProcW_WMRButtonDblClk(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_RBUTTONDBLCLK, wParam, lParam);
end;
                        
function WndProcW_WMMButtonDown(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_MBUTTONDOWN, wParam, lParam);
end;

function WndProcW_WMMButtonUp(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_MBUTTONUP, wParam, lParam);
end;

function WndProcW_WMMButtonDblClk(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_MBUTTONDBLCLK, wParam, lParam);
end;

function WndProcW_WMMouseMove(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
//var
//  tmpHitTest: integer;
begin
  AUIWnd.WMMOUSEMOVE_LParam := lParam; //TSmallPoint(lParam);
//  UIWindowPaint(AUIWindow);
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_MOUSEMOVE, wParam, lParam);
end;

function WndProcW_WMMouseWheel(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_MOUSEWHEEL, wParam, lParam);
end;

function WndProcW_WMSetCursor(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
//var
//  tmpHitTest: integer;
begin
//  Result := 0;
//  if Windows.GetCursorPos(AUIWindow.WMSetCursor_CursorPoint) then
//  begin
//    if Windows.ScreenToClient(AUIWnd.WndHandle, AUIWindow.WMSetCursor_CursorPoint) then
//    begin
//      tmpHitTest := POINT_HITTEST(@AUIWindow.TestUIEdit.Base.View.Space.Layout, AUIWindow.WMMouseMove_CursorPoint);
//      if UpdateHitTestCursor(AUIWindow, tmpHitTest) then
//      begin
//        Exit;
//      end;
//    end;
//  end; 
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_SETCURSOR, wParam, lParam);
end;

function WndProcW_WMNCHitTest(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  //Result := HTCLIENT;  
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCHITTEST, wParam, lParam);
end;

function WndProcW_WMMouseHover(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_MOUSEHOVER, wParam, lParam);
end;

function WndProcW_WMMouseLeave(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_MOUSELEAVE, wParam, lParam);
end;
          
function WndProcW_WMNCMOUSEMOVE(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCMOUSEMOVE, wParam, lParam);
end;
                       
function WndProcW_WMNCLBUTTONDOWN(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCLBUTTONDOWN, wParam, lParam);
end;

function WndProcW_WMNCLBUTTONUP(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCLBUTTONUP, wParam, lParam);
end;

function WndProcW_WMNCLBUTTONDBLCLK(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCLBUTTONDBLCLK, wParam, lParam);
end;

function WndProcW_WMNCRBUTTONDOWN(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCRBUTTONDOWN, wParam, lParam);
end;
                                           
function WndProcW_WMNCRBUTTONUP(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCRBUTTONUP, wParam, lParam);
end;

function WndProcW_WMNCRBUTTONDBLCLK(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCRBUTTONDBLCLK, wParam, lParam);
end;
                       
function WndProcW_WMNCMBUTTONDOWN(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCMBUTTONDOWN, wParam, lParam);
end;
                       
function WndProcW_WMNCMBUTTONUP(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCMBUTTONUP, wParam, lParam);
end;

function WndProcW_WMNCMBUTTONDBLCLK(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCMBUTTONDBLCLK, wParam, lParam);
end;

end.
