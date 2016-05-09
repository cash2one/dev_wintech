program uiwin_edit;

uses
  Windows,
  base.run in '..\..\..\..\v0001\rec\app_base\base.run.pas',
  Base.Thread in '..\..\..\..\v0001\rec\app_base\Base.Thread.pas',
  win.thread in '..\..\..\..\v0001\rec\win_sys\win.thread.pas',
  ui.color in '..\..\..\..\v0000\uibase\ui.color.pas',
  win.wnd_ui in '..\..\..\..\v0000\win_ui\win.wnd_ui.pas',
  uiwin.memdc in '..\..\..\..\v0000\win_ui\uiwin.memdc.pas',
  uiwin.gdi in '..\..\..\..\v0000\win_ui\uiwin.gdi.pas',
  UtilsLog in '..\..\..\..\v0000\win_utils\UtilsLog.pas',
  uiwindow_edit in 'uiwindow_edit.pas',
  uiwindow_wndproc_key in 'uiwindow_wndproc_key.pas',
  uiwindow_wndproc_paint in 'uiwindow_wndproc_paint.pas',
  uiwindow_wndproc_mouse in 'uiwindow_wndproc_mouse.pas',
  uiwindow_wndproc in 'uiwindow_wndproc.pas',
  uiwindow_wndproc_startend in 'uiwindow_wndproc_startend.pas',
  uiwindow_wndproc_uispace in 'uiwindow_wndproc_uispace.pas',
  uiwindow in 'uiwindow.pas',
  uiview in 'uiview.pas',
  uiview_texture in 'uiview_texture.pas',
  uiview_space in 'uiview_space.pas',
  uicontrol_edit in 'uicontrol_edit.pas',
  uiview_shape in 'uiview_shape.pas',
  uicontrol_edit_paint in 'uicontrol_edit_paint.pas';

{$R *.res}

begin
  FillChar(UIWindow_Test1, SizeOf(UIWindow_Test1), 0);
  CreateUIWindow1(@UIWindow_Test1);
end.
