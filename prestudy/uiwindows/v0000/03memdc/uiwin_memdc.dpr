program uiwin_memdc;

uses
  Windows,
  BaseThread in '..\..\..\..\v0000\app_base\BaseThread.pas',
  BaseRun in '..\..\..\..\v0000\app_base\BaseRun.pas',
  ui.color in '..\..\..\..\v0000\uibase\ui.color.pas',
  win.thread in '..\..\..\..\v0000\win_system\win.thread.pas',
  win.wnd_ui in '..\..\..\..\v0000\win_ui\win.wnd_ui.pas',
  uiwin.memdc in '..\..\..\..\v0000\win_ui\uiwin.memdc.pas',
  uiwin.gdi in '..\..\..\..\v0000\win_ui\uiwin.gdi.pas',
  uiwindow_memdc in 'uiwindow_memdc.pas',
  uiwindow_wndproc_key in 'uiwindow_wndproc_key.pas',
  uiwindow_wndproc_paint in 'uiwindow_wndproc_paint.pas';

{$R *.res}

begin
  FillChar(UIWindow_Test1, SizeOf(UIWindow_Test1), 0);
  CreateUIWindow1(@UIWindow_Test1);
end.
