program DealAgentServer;

uses
  WinSock2 in '..\..\..\..\common\WinSock2.pas',
  BaseThread in '..\..\..\..\v0000\app_base\BaseThread.pas',
  BaseRun in '..\..\..\..\v0000\app_base\BaseRun.pas',
  BaseApp in '..\..\..\..\v0000\app_base\BaseApp.pas',
  BasePath in '..\..\..\..\v0000\app_base\BasePath.pas',
  BaseWinApp in '..\..\..\..\v0000\win_base\BaseWinApp.pas',
  Define_Message in '..\..\..\..\v0000\win_basedefine\Define_Message.pas',
  win.diskfile in '..\..\..\..\v0000\win_system\win.diskfile.pas',
  win.cpu in '..\..\..\..\v0000\win_system\win.cpu.pas',
  win.iocp in '..\..\..\..\v0000\win_system\win.iocp.pas',
  win.thread in '..\..\..\..\v0000\win_system\win.thread.pas',
  AppWindow in 'common\AppWindow.pas',
  CmdWindow in 'common\CmdWindow.pas',
  DataChain in 'common\DataChain.pas',
  NetBase in 'net\NetBase.pas',
  NetMgr in 'net\NetMgr.pas',
  NetObjClient in 'net\NetObjClient.pas',
  NetBaseObj in 'net\NetBaseObj.pas',
  NetHttpClient in 'net\NetHttpClient.pas',
  NetSrvClientIocp in 'net\NetSrvClientIocp.pas',
  NetObjClientProc in 'net\NetObjClientProc.pas',
  NetHttpClientProc in 'net\NetHttpClientProc.pas',
  NetServerIocp in 'net\NetServerIocp.pas',
  BaseDataIO in 'net\BaseDataIO.pas',
  NetUdpServer in 'net\NetUdpServer.pas',
  DealServerApp in 'net\DealServerApp.pas',
  DealServerHttpProtocol in 'appdealsrv\DealServerHttpProtocol.pas',
  DealServerAppStart in 'appdealsrv\DealServerAppStart.pas',
  HttpResCache in 'http\HttpResCache.pas';

{$R *.res}

begin
  GlobalApp := TDealAgentServerApp.Create('dealAgentServer');
  try
    if GlobalApp.Initialize then
    begin
      GlobalApp.Run;
    end;
    GlobalApp.Finalize;
  finally
    GlobalApp.Free;
  end;
end.
