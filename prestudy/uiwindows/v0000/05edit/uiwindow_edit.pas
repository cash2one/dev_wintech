unit uiwindow_edit;

interface

uses
  Windows,
  Messages,
  uiwin.memdc,
  uiwindow,
  win.wnd_ui;

var
  UIWindow_Test1: TUIWindow;
    
  procedure CreateUIWindow1(AUIWindow: PUIWindow);

implementation

uses
  uiview_shape,
  uiview_space,
  uicontrol_edit,
  uiwindow_wndproc;
  
function UIWndProcW(AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := UIWindowProcW(@UIWindow_Test1, AWnd, AMsg, wParam, lParam);
end;

procedure CreateUIWindow1(AUIWindow: PUIWindow);
var
  tmpRegWndClass: TWndClassW;
  tmpCheckWndClass: TWndClassW;
  tmpIsRegistered: Boolean;
begin
  FillChar(tmpRegWndClass, SizeOf(tmpRegWndClass), 0);
  tmpRegWndClass.lpfnWndProc := @UIWndProcW;
  tmpRegWndClass.lpszClassName := 'UIWnd1';                   
  tmpRegWndClass.hCursor := LoadCursorA(0, IDC_ARROW);
  tmpRegWndClass.hbrBackground := GetStockObject(GRAY_BRUSH);
  tmpRegWndClass.hInstance := HInstance;
  
  tmpIsRegistered := GetClassInfoW(HInstance, tmpRegWndClass.lpszClassName, tmpCheckWndClass);
  if not tmpIsRegistered or (tmpCheckWndClass.lpfnWndProc <> tmpRegWndClass.lpfnWndProc) then
  begin
    if tmpIsRegistered then
      Windows.UnregisterClassW(tmpRegWndClass.lpszClassName, HInstance);
    Windows.RegisterClassW(tmpRegWndClass);
  end;

  AUIWindow.BaseWnd.ClientRect.Right := 600;
  AUIWindow.BaseWnd.ClientRect.Bottom := 500;

  UpdateMemDC(@AUIWindow.MemDC,
      AUIWindow.BaseWnd.ClientRect.Right,
      AUIWindow.BaseWnd.ClientRect.Bottom);
                                   
  InitUIEdit(@AUIWindow.TestUIEdit);  
  UpdateUISpaceLayout(@AUIWindow.TestUIEdit.Base.View.Space, 50, 50);   
  
  AUIWindow.BaseWnd.UIWndHandle := CreateWindowExW(
    //WS_EX_TOOLWINDOW
      //or WS_EX_TOPMOST
    WS_EX_OVERLAPPEDWINDOW
    ,
    tmpRegWndClass.lpszClassName,
    '',
    WS_POPUP {+ 0}
      or WS_OVERLAPPEDWINDOW
    ,
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
