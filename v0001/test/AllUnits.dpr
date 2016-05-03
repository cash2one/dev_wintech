program AllUnits;

uses
  Windows,
  WinSock2 in '..\..\common\WinSock2.pas',
  sys.datatype in '..\sys.datatype.pas',
  base.run in '..\rec\app_base\base.run.pas',
  base.thread in '..\rec\app_base\base.thread.pas',
  base.netclient in '..\rec\base_net\base.netclient.pas',
  ui.space in '..\rec\ui_base\ui.space.pas',
  ui.texbitmap in '..\rec\ui_base\ui.texbitmap.pas',
  ui.texcolor in '..\rec\ui_base\ui.texcolor.pas',
  ui.texcolorblend in '..\rec\ui_base\ui.texcolorblend.pas',
  ui.texcolorpalette in '..\rec\ui_base\ui.texcolorpalette.pas',
  ui.texgamma in '..\rec\ui_base\ui.texgamma.pas',
  win.net in '..\rec\win_net\win.net.pas',
  win.clientsockettcp in '..\rec\win_netclient\win.clientsockettcp.pas',
  win.clientsocket in '..\rec\win_netclient\win.clientsocket.pas',
  win.serversocket in '..\rec\win_netserver\win.serversocket.pas',
  win.iocp in '..\rec\win_sys\win.iocp.pas',
  win.thread in '..\rec\win_sys\win.thread.pas',
  win.wnd_cmd in '..\rec\win_sys\win.wnd_cmd.pas',
  BasePath in '..\obj\app_base\BasePath.pas',
  BaseApp in '..\obj\app_base\BaseApp.pas',
  BaseThread in '..\obj\app_base\BaseThread.pas',
  BaseWnd in '..\obj\win_sys\BaseWnd.pas',
  BaseWinThread in '..\obj\win_sys\BaseWinThread.pas',
  WinIocp in '..\obj\win_sys\WinIocp.pas',
  sysdef_appcmd in '..\sysdef\sysdef_appcmd.pas',
  sysdef_string in '..\sysdef\sysdef_string.pas',
  sysdef_char in '..\sysdef\sysdef_char.pas',
  windef_msg in '..\windef\windef_msg.pas',
  windef_color in '..\windef\windef_color.pas',
  win.datamove in '..\winproc\win.datamove.pas';

{$R *.res}

begin
end.
