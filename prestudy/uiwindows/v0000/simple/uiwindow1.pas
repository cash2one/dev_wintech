unit uiwindow1;

interface

uses
  Windows,
  Messages,
  win.wnd_ui;

type
  PUIWindow     = ^TUIWindow;    
  TUIWindow     = record
    BaseWnd     : TUIBaseWnd;
  end;

var
  UIWindow_Test1: TUIWindow;
    
  procedure CreateUIWindow1(AUIWindow: PUIWindow);

implementation
                  
function WndProcA_WMLButtonUp(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_LBUTTONUP, wParam, lParam);
end;

function WndProcA_WMLButtonDown(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  SendMessage(AUIWindow.BaseWnd.UIWndHandle, WM_NCLButtonDown, HTCaption, GetMessagePos);
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_LBUTTONDOWN, wParam, lParam);
end;

function WndProcA_WMMouseMove(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
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
  //Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_NCHITTEST, wParam, lParam);
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
  
function UIWindowProcA(AWindow: PUIWindow; AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; 
begin
  if UIWndProcA_Mouse(AWindow, AMsg, wParam, lParam, Result) then
    exit;
  if UIWndProcA_Key(AWindow, AMsg, wParam, lParam, Result) then
    exit;
  Result := DefWindowProcA(AWnd, AMsg, wParam, lParam);
end;

function UIWndProcA(AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := UIWindowProcA(@UIWindow_Test1, AWnd, AMsg, wParam, lParam);
end;

procedure CreateUIWindow1(AUIWindow: PUIWindow);
var
  tmpRegWndClass: TWndClassA;  
  tmpCheckWndClass: TWndClassA;
  tmpIsRegistered: Boolean;
begin
  FillChar(tmpRegWndClass, SizeOf(tmpRegWndClass), 0);
  tmpRegWndClass.lpfnWndProc := @UIWndProcA;
  tmpRegWndClass.lpszClassName := 'UIWnd1';                   
  tmpRegWndClass.hCursor := LoadCursorA(0, IDC_ARROW);
  tmpRegWndClass.hbrBackground := GetStockObject(GRAY_BRUSH);
  tmpRegWndClass.hInstance := HInstance;
  
  tmpIsRegistered := GetClassInfo(HInstance, tmpRegWndClass.lpszClassName, tmpCheckWndClass);
  if not tmpIsRegistered or (tmpCheckWndClass.lpfnWndProc <> tmpRegWndClass.lpfnWndProc) then
  begin
    if tmpIsRegistered then
      Windows.UnregisterClass(tmpRegWndClass.lpszClassName, HInstance);
    Windows.RegisterClass(tmpRegWndClass);
  end;

  AUIWindow.BaseWnd.ClientRect.Right := 600;
  AUIWindow.BaseWnd.ClientRect.Bottom := 500;

  AUIWindow.BaseWnd.UIWndHandle := CreateWindowExA(
    WS_EX_TOOLWINDOW
      or WS_EX_TOPMOST
    ,
    tmpRegWndClass.lpszClassName,
    '',
    WS_POPUP {+ 0},
    AUIWindow.BaseWnd.WindowRect.Left,
    AUIWindow.BaseWnd.WindowRect.Top,
    AUIWindow.BaseWnd.ClientRect.Right,
    AUIWindow.BaseWnd.ClientRect.Bottom,
    0,
    0, HInstance, nil);
  if IsWindow(AUIWindow.BaseWnd.UIWndHandle) then
  begin
    ShowWindow(AUIWindow.BaseWnd.UIWndHandle, SW_SHOW);
    UpdateWindow(AUIWindow.BaseWnd.UIWndHandle);
    while GetMessage(AUIWindow.BaseWnd.WndMsg, 0, 0, 0) do
    begin
      TranslateMessage(AUIWindow.BaseWnd.WndMsg);
      DispatchMessage(AUIWindow.BaseWnd.WndMsg);
    end;
  end;
end;

end.
