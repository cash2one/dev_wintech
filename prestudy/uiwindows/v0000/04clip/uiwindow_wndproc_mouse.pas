unit uiwindow_wndproc_mouse;

interface

uses
  Windows,
  Messages,
  uiwindow_clip;

var                            
  IsDragStarting: Boolean = False;
  DragStartPoint: TSmallPoint;
  WMMouseMove_CursorPoint: TSmallPoint;

  function UIWndProcA_Mouse(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;

implementation

uses
  uiwindow_wndproc_paint;
  
function WndProcA_WMLButtonUp(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  IsDragStarting := false;    
  UIWindowPaint(AUIWindow);
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_LBUTTONUP, wParam, lParam);
end;

function WndProcA_WMLButtonDown(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin            
  if 20 > TSmallPoint(lParam).y then
  begin
    SendMessage(AUIWindow.BaseWnd.UIWndHandle, WM_SYSCOMMAND, HTCaption or SC_MOVE, 0);
//    SendMessage(AUIWindow.BaseWnd.UIWndHandle, WM_NCLButtonDown, HTCaption, GetMessagePos);
    IsDragStarting := False;
  end else
  begin
    DragStartPoint := TSmallPoint(lParam);
    IsDragStarting := True;
  end;
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_LBUTTONDOWN, wParam, lParam);
end;

function WndProcA_WMMouseMove(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  WMMouseMove_CursorPoint := TSmallPoint(lParam);
  UIWindowPaint(AUIWindow);
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_MOUSEMOVE, wParam, lParam);
end;

function WndProcA_WMMouseWheel(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_MOUSEWHEEL, wParam, lParam);
end;

function WndProcA_WMSetCursor(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_SETCURSOR, wParam, lParam);
end;

function WndProcA_WMNCHitTest(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := HTCLIENT;
end;

function WndProcA_WMMouseHover(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_MOUSEHOVER, wParam, lParam);
end;

function WndProcA_WMMouseLeave(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_MOUSELEAVE, wParam, lParam);
end;

function UIWndProcA_Mouse(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean; 
begin
  Result := true;
  case AMsg of
    WM_LButtonUp: AWndProcResult := WndProcA_WMLButtonUp(AUIWindow, wParam, lParam);
    WM_LButtonDown: AWndProcResult := WndProcA_WMLButtonDown(AUIWindow, wParam, lParam);
    WM_MouseMove: AWndProcResult := WndProcA_WMMouseMove(AUIWindow, wParam, lParam);
    WM_MOUSEWHEEL: AWndProcResult := WndProcA_WMMouseWheel(AUIWindow, wParam, lParam);
    WM_SETCURSOR: AWndProcResult := WndProcA_WMSetCursor(AUIWindow, wParam, lParam);
    WM_NCHITTEST: AWndProcResult := WndProcA_WMNCHitTest(AUIWindow, wParam, lParam);
    WM_MOUSEHOVER: AWndProcResult := WndProcA_WMMouseHover(AUIWindow, wParam, lParam);
    WM_MOUSELEAVE: AWndProcResult := WndProcA_WMMouseLeave(AUIWindow, wParam, lParam);
    else
      Result := false;
  end;     
end;
       
end.
