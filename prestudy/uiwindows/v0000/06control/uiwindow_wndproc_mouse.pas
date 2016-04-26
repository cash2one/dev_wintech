unit uiwindow_wndproc_mouse;

interface

uses
  Windows,
  Messages,
  uiwindow;

  function UIWndProcW_Mouse(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;

implementation

uses
  uiview,
  uiview_space,
  uiwindow_wndproc_paint;
                        
var
  Cursor_SizeNS: HCURSOR = 0;
  Cursor_SizeWE: HCURSOR = 0;
  Cursor_SizeNWSE: HCURSOR = 0;
  Cursor_SizeNESW: HCURSOR = 0;
  Cursor_SizeAll: HCURSOR = 0;

procedure UpdateHitTestCursor(AHitTest: integer);
begin
  if (HTBOTTOM = AHitTest) or
     (HTTOP = AHitTest) then
  begin
    if 0 = Cursor_SizeNS then
      Cursor_SizeNS := LoadCursor(0, IDC_SIZENS);   
    if 0 <> Cursor_SizeNS then
      Windows.SetCursor(Cursor_SizeNS);
  end;
  if (HTLEFT = AHitTest) or
     (HTRIGHT = AHitTest) then
  begin
    if 0 = Cursor_SizeWE then
      Cursor_SizeWE := LoadCursor(0, IDC_SIZEWE);
    if 0 <> Cursor_SizeWE then
      Windows.SetCursor(Cursor_SizeWE);
  end;               
  if (HTTOPLEFT = AHitTest) or
     (HTBOTTOMRIGHT = AHitTest) then
  begin
    if 0 = Cursor_SizeNWSE then
      Cursor_SizeNWSE := LoadCursor(0, IDC_SIZENWSE);
    if 0 <> Cursor_SizeNWSE then
      Windows.SetCursor(Cursor_SizeNWSE);
  end;           
  if (HTTOPRIGHT = AHitTest) or
     (HTBOTTOMLEFT = AHitTest) then
  begin
    if 0 = Cursor_SizeNESW then
      Cursor_SizeNESW := LoadCursor(0, IDC_SIZENESW);
    if 0 <> Cursor_SizeNESW then
      Windows.SetCursor(Cursor_SizeNESW);
  end;
  if HTCLIENT = AHitTest then
  begin
    if 0 = Cursor_SizeAll then
      Cursor_SizeAll := LoadCursor(0, IDC_SIZEALL);
    if 0 <> Cursor_SizeAll then
      Windows.SetCursor(Cursor_SizeAll);
  end;
end;

function WndProcW_WMLButtonDown(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin 
  AUIWindow.WMLButtonDown_CursorPoint := TSmallPoint(lParam);
  AUIWindow.TestFocusUIView := nil;      
  AUIWindow.FocusMode := POINT_HITTEST(@AUIWindow.TestUIView.Space.Layout, AUIWindow.WMLButtonDown_CursorPoint);
  if HTNOWHERE <> AUIWindow.FocusMode then
  begin
    UpdateHitTestCursor(AUIWindow.FocusMode);
    AUIWindow.TestFocusUIView := @AUIWindow.TestUIView;   
    AUIWindow.DragStartRect.Left := AUIWindow.TestUIView.Space.Layout.Left;
    AUIWindow.DragStartRect.Top := AUIWindow.TestUIView.Space.Layout.Top;
    AUIWindow.DragStartRect.Right := AUIWindow.TestUIView.Space.Layout.Right;
    AUIWindow.DragStartRect.Bottom := AUIWindow.TestUIView.Space.Layout.Bottom;
  end;
  if nil = AUIWindow.TestFocusUIView then
  begin
    if 20 > TSmallPoint(lParam).y then
    begin
      SendMessageW(AUIWindow.BaseWnd.UIWndHandle, WM_SYSCOMMAND, SC_MOVE or HTCaption, 0);
      //SendMessageW(AUIWindow.BaseWnd.UIWndHandle, WM_NCLButtonDown, HTCaption, GetMessagePos);
      AUIWindow.IsDragStarting := False;
    end else
    begin
      AUIWindow.DragStartRect.Left := TSmallPoint(lParam).x;
      AUIWindow.DragStartRect.Top := TSmallPoint(lParam).y;      
      AUIWindow.IsDragStarting := True;
    end;
  end;  

  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_LBUTTONDOWN, wParam, lParam);
end;
          
function WndProcW_WMLButtonUp(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin                       
  if nil = AUIWindow.TestFocusUIView then
  begin
    if AUIWindow.IsDragStarting then
    begin
      AUIWindow.IsDragStarting := false;
      UIWindowPaint(AUIWindow);
    end;
  end else
  begin
    AUIWindow.TestFocusUIView := nil; 
    UIWindowPaint(AUIWindow);
  end;
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_LBUTTONUP, wParam, lParam);
end;

function WndProcW_WMLButtonDblClk(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_LBUTTONDBLCLK, wParam, lParam);
end;
              
function WndProcW_WMRButtonUp(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_RBUTTONUP, wParam, lParam);
end;

function WndProcW_WMRButtonDown(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_RBUTTONDOWN, wParam, lParam);
end;
            
function WndProcW_WMRButtonDblClk(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_RBUTTONDBLCLK, wParam, lParam);
end;
                    
function WndProcW_WMMButtonUp(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_MBUTTONUP, wParam, lParam);
end;

function WndProcW_WMMButtonDown(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_MBUTTONDOWN, wParam, lParam);
end;
            
function WndProcW_WMMButtonDblClk(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_MBUTTONDBLCLK, wParam, lParam);
end;

function WndProcW_WMMouseMove(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  tmpHitTest: integer;
begin
  AUIWindow.WMMouseMove_CursorPoint := TSmallPoint(lParam);
  if nil <> AUIWindow.TestFocusUIView then
  begin                                 
    if HTCLIENT = AUIWindow.FocusMode then
    begin
      AUIWindow.TestFocusUIView.Space.Layout.Left := AUIWindow.DragStartRect.Left + AUIWindow.WMMouseMove_CursorPoint.x - AUIWindow.WMLButtonDown_CursorPoint.x;
      AUIWindow.TestFocusUIView.Space.Layout.Right := AUIWindow.TestFocusUIView.Space.Layout.Left + AUIWindow.TestFocusUIView.Space.Shape.Width;
      AUIWindow.TestFocusUIView.Space.Layout.Top := AUIWindow.DragStartRect.Top + AUIWindow.WMMouseMove_CursorPoint.y - AUIWindow.WMLButtonDown_CursorPoint.y;
      AUIWindow.TestFocusUIView.Space.Layout.Bottom := AUIWindow.TestFocusUIView.Space.Layout.Top + AUIWindow.TestFocusUIView.Space.Shape.Height;
    end;
    if HTRIGHT = AUIWindow.FocusMode then
    begin
      UpdateUISpaceWidth(@AUIWindow.TestFocusUIView.Space, AUIWindow.DragStartRect.Right - AUIWindow.DragStartRect.Left +
          AUIWindow.WMMouseMove_CursorPoint.x - AUIWindow.WMLButtonDown_CursorPoint.x);
    end;  
    if HTLEFT = AUIWindow.FocusMode then
    begin       
      AUIWindow.TestFocusUIView.Space.Layout.LEFT := AUIWindow.DragStartRect.LEFT +
        AUIWindow.WMMouseMove_CursorPoint.x - AUIWindow.WMLButtonDown_CursorPoint.x;
      UpdateUISpaceWidth(@AUIWindow.TestFocusUIView.Space, AUIWindow.DragStartRect.Right -
        AUIWindow.TestFocusUIView.Space.Layout.Left);
    end;   
    if HTBOTTOM = AUIWindow.FocusMode then
    begin
      UpdateUISpaceHeight(@AUIWindow.TestFocusUIView.Space, AUIWindow.DragStartRect.Bottom - AUIWindow.DragStartRect.Top +
          AUIWindow.WMMouseMove_CursorPoint.y - AUIWindow.WMLButtonDown_CursorPoint.y);
    end;    
    if HTBOTTOMRIGHT = AUIWindow.FocusMode then
    begin                                    
      UpdateUISpaceWidth(@AUIWindow.TestFocusUIView.Space, AUIWindow.DragStartRect.Right - AUIWindow.DragStartRect.Left +
          AUIWindow.WMMouseMove_CursorPoint.x - AUIWindow.WMLButtonDown_CursorPoint.x);     
      
      UpdateUISpaceHeight(@AUIWindow.TestFocusUIView.Space, AUIWindow.DragStartRect.Bottom - AUIWindow.DragStartRect.Top +
          AUIWindow.WMMouseMove_CursorPoint.y - AUIWindow.WMLButtonDown_CursorPoint.y);
    end;   
    if HTTOP = AUIWindow.FocusMode then
    begin
      AUIWindow.TestFocusUIView.Space.Layout.Top := AUIWindow.DragStartRect.Top +
        AUIWindow.WMMouseMove_CursorPoint.y - AUIWindow.WMLButtonDown_CursorPoint.y;

      UpdateUISpaceHeight(@AUIWindow.TestFocusUIView.Space, AUIWindow.DragStartRect.Bottom - 
        AUIWindow.TestFocusUIView.Space.Layout.Top);
    end;    
    UpdateHitTestCursor(AUIWindow.FocusMode);
  end else
  begin
    tmpHitTest := POINT_HITTEST(@AUIWindow.TestUIView.Space.Layout, AUIWindow.WMMouseMove_CursorPoint);
    UpdateHitTestCursor(tmpHitTest);
  end;
  UIWindowPaint(AUIWindow);
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_MOUSEMOVE, wParam, lParam);
end;

function WndProcW_WMMouseWheel(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_MOUSEWHEEL, wParam, lParam);
end;

function WndProcW_WMSetCursor(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_SETCURSOR, wParam, lParam);
end;

function WndProcW_WMNCHitTest(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  //Result := HTCLIENT;  
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCHITTEST, wParam, lParam);
end;

function WndProcW_WMMouseHover(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_MOUSEHOVER, wParam, lParam);
end;

function WndProcW_WMMouseLeave(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_MOUSELEAVE, wParam, lParam);
end;
          
function WndProcW_WMNCMOUSEMOVE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin            
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCMOUSEMOVE, wParam, lParam);
end;

function WndProcW_WMNCLBUTTONUP(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCLBUTTONUP, wParam, lParam);
end;
                      
function WndProcW_WMNCLBUTTONDOWN(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCLBUTTONDOWN, wParam, lParam);
end;
                                   
function WndProcW_WMNCLBUTTONDBLCLK(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCLBUTTONDBLCLK, wParam, lParam);
end;
                      
function WndProcW_WMNCRBUTTONUP(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCRBUTTONUP, wParam, lParam);
end;
                      
function WndProcW_WMNCRBUTTONDOWN(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCRBUTTONDOWN, wParam, lParam);
end;
                                   
function WndProcW_WMNCRBUTTONDBLCLK(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCRBUTTONDBLCLK, wParam, lParam);
end;

function WndProcW_WMNCMBUTTONUP(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCMBUTTONUP, wParam, lParam);
end;
                      
function WndProcW_WMNCMBUTTONDOWN(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCMBUTTONDOWN, wParam, lParam);
end;
                                   
function WndProcW_WMNCMBUTTONDBLCLK(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCMBUTTONDBLCLK, wParam, lParam);
end;

function UIWndProcW_Mouse(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean; 
begin
  Result := true;
  case AMsg of
    WM_LButtonUp: AWndProcResult := WndProcW_WMLButtonUp(AUIWindow, wParam, lParam);
    WM_LButtonDown: AWndProcResult := WndProcW_WMLButtonDown(AUIWindow, wParam, lParam);
    WM_LBUTTONDBLCLK: AWndProcResult := WndProcW_WMLButtonDblClk(AUIWindow, wParam, lParam);

    WM_RButtonUp: AWndProcResult := WndProcW_WMRButtonUp(AUIWindow, wParam, lParam);
    WM_RButtonDown: AWndProcResult := WndProcW_WMRButtonDown(AUIWindow, wParam, lParam);
    WM_RBUTTONDBLCLK: AWndProcResult := WndProcW_WMRButtonDblClk(AUIWindow, wParam, lParam);

    WM_MButtonUp: AWndProcResult := WndProcW_WMMButtonUp(AUIWindow, wParam, lParam);
    WM_MButtonDown: AWndProcResult := WndProcW_WMMButtonDown(AUIWindow, wParam, lParam);
    WM_MBUTTONDBLCLK: AWndProcResult := WndProcW_WMMButtonDblClk(AUIWindow, wParam, lParam);

    WM_MouseMove: AWndProcResult := WndProcW_WMMouseMove(AUIWindow, wParam, lParam);
    WM_MOUSEWHEEL: AWndProcResult := WndProcW_WMMouseWheel(AUIWindow, wParam, lParam);
    WM_SETCURSOR: AWndProcResult := WndProcW_WMSetCursor(AUIWindow, wParam, lParam);
    WM_NCHITTEST: AWndProcResult := WndProcW_WMNCHitTest(AUIWindow, wParam, lParam);
    WM_MOUSEHOVER: AWndProcResult := WndProcW_WMMouseHover(AUIWindow, wParam, lParam);
    WM_MOUSELEAVE: AWndProcResult := WndProcW_WMMouseLeave(AUIWindow, wParam, lParam);

    WM_NCMOUSEMOVE: AWndProcResult := WndProcW_WMNCMOUSEMOVE(AUIWindow, wParam, lParam);
    WM_NCLBUTTONUP: AWndProcResult := WndProcW_WMNCLBUTTONUP(AUIWindow, wParam, lParam);
    WM_NCLBUTTONDOWN: AWndProcResult := WndProcW_WMNCLBUTTONDOWN(AUIWindow, wParam, lParam);
    WM_NCLBUTTONDBLCLK: AWndProcResult := WndProcW_WMNCLBUTTONDBLCLK(AUIWindow, wParam, lParam);    

    WM_NCRBUTTONUP: AWndProcResult := WndProcW_WMNCRBUTTONUP(AUIWindow, wParam, lParam);
    WM_NCRBUTTONDOWN: AWndProcResult := WndProcW_WMNCRBUTTONDOWN(AUIWindow, wParam, lParam);
    WM_NCRBUTTONDBLCLK: AWndProcResult := WndProcW_WMNCRBUTTONDBLCLK(AUIWindow, wParam, lParam);

    WM_NCMBUTTONUP: AWndProcResult := WndProcW_WMNCMBUTTONUP(AUIWindow, wParam, lParam);
    WM_NCMBUTTONDOWN: AWndProcResult := WndProcW_WMNCMBUTTONDOWN(AUIWindow, wParam, lParam);
    WM_NCMBUTTONDBLCLK: AWndProcResult := WndProcW_WMNCMBUTTONDBLCLK(AUIWindow, wParam, lParam);
    else
      Result := false;
  end;     
end;
       
end.
