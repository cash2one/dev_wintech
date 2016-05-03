program AllUnits;

uses
  Windows,
  WinSock2 in '..\..\common\WinSock2.pas',
  base.run in '..\rec\app_base\base.run.pas',
  base.thread in '..\rec\app_base\base.thread.pas',
  base.netclient in '..\rec\base_net\base.netclient.pas',
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
  WinIocp in '..\obj\win_sys\WinIocp.pas';

{$R *.res}

begin
end.
