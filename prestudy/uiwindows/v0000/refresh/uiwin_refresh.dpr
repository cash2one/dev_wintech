program uiwin_refresh;

uses
  Windows,
  BaseThread in '..\..\..\..\v0000\app_base\BaseThread.pas',
  BaseRun in '..\..\..\..\v0000\app_base\BaseRun.pas',
  win.thread in '..\..\..\..\v0000\win_system\win.thread.pas',
  win.wnd_ui in '..\..\..\..\v0000\win_ui\win.wnd_ui.pas',
  uiwindow_refresh in 'uiwindow_refresh.pas',
  uiwindow_wndproc_key in 'uiwindow_wndproc_key.pas',
  uiwindow_wndproc_paint in 'uiwindow_wndproc_paint.pas';

{$R *.res}

begin
  FillChar(UIWindow_Test1, SizeOf(UIWindow_Test1), 0);
  CreateUIWindow1(@UIWindow_Test1);
end.
