unit uiwindow_memdc;

interface

uses
  Windows,
  Messages,
  uiwin.memdc,
  win.wnd_ui;

type
  PUIWindow     = ^TUIWindow;    
  TUIWindow     = record
    BaseWnd     : TUIBaseWnd;
    MemDC       : TWinMemDC;
  end;

var
  UIWindow_Test1: TUIWindow;
    
  procedure CreateUIWindow1(AUIWindow: PUIWindow);

implementation

uses
  uiwindow_wndproc_paint,
  uiwindow_wndproc_mouse,
  uiwindow_wndproc_key;

function UIWindowProcA(AWindow: PUIWindow; AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; 
begin                
  if UIWndProcA_Paint(AWindow, AMsg, wParam, lParam, Result) then
    exit;
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

  UpdateMemDC(@AUIWindow.MemDC,
      AUIWindow.BaseWnd.ClientRect.Right,
      AUIWindow.BaseWnd.ClientRect.Bottom);

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
