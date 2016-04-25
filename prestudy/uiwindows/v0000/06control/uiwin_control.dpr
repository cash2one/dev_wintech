program uiwin_control;

uses
  Windows,
  BaseThread in '..\..\..\..\v0000\app_base\BaseThread.pas',
  BaseRun in '..\..\..\..\v0000\app_base\BaseRun.pas',
  ui.color in '..\..\..\..\v0000\uibase\ui.color.pas',
  win.thread in '..\..\..\..\v0000\win_system\win.thread.pas',
  win.wnd_ui in '..\..\..\..\v0000\win_ui\win.wnd_ui.pas',
  uiwin.memdc in '..\..\..\..\v0000\win_ui\uiwin.memdc.pas',
  uiwin.gdi in '..\..\..\..\v0000\win_ui\uiwin.gdi.pas',
  UtilsLog in '..\..\..\..\v0000\win_utils\UtilsLog.pas',
  uiwindow_control in 'uiwindow_control.pas',
  uiwindow_wndproc_key in 'uiwindow_wndproc_key.pas',
  uiwindow_wndproc_paint in 'uiwindow_wndproc_paint.pas',
  uiwindow_wndproc_mouse in 'uiwindow_wndproc_mouse.pas',
  uiwindow_wndproc in 'uiwindow_wndproc.pas',
  uiwindow_wndproc_startend in 'uiwindow_wndproc_startend.pas',
  uiwindow_wndproc_uispace in 'uiwindow_wndproc_uispace.pas',
  uiwindow in 'uiwindow.pas',
  uiview_texture in 'uiview_texture.pas',
  uicontrol in 'uicontrol.pas',
  uictrl_feature_select in 'uictrl_feature_select.pas',
  uiview_space in 'uiview_space.pas',
  uiview in 'uiview.pas';

{$R *.res}

begin
  FillChar(UIWindow_Test1, SizeOf(UIWindow_Test1), 0);
  CreateUIWindow1(@UIWindow_Test1);
end.
