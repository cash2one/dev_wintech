unit DealServerAppStart;

interface

  procedure WMAppStart();
  
implementation

uses
  //SDLogutils,
  BaseDataIO,
  NetBaseObj,
  NetUdpServer,
  NetServerIocp,
  NetHttpClient,
  NetHttpClientProc,
  DealServerHttpProtocol,
  DealServerApp;

procedure TestTCPServer();
var
  tmpNetServer: PNetServerIocp;
begin
  tmpNetServer := GlobalApp.NetMgr.CheckOutNetServerIocp;
  if nil <> tmpNetServer then
  begin               
    //tmpNetServer.BaseServer.DataIO.DoDataIn := DealServerHttpProtocol.HttpServerDataIn;
    GlobalApp.NetMgr.ListenAndServeNetServer(tmpNetServer);
  end;
end;
               
procedure TestTCPClient();  
var
  tmpHttpClient: PNetHttpClient;
  tmpRet: AnsiString;
  tmpUrl: AnsiString;
begin
  tmpHttpClient := GlobalApp.NetMgr.CheckOutHttpClient;
  if nil <> tmpHttpClient then
  begin
    tmpUrl := 'http://market.finance.sina.com.cn/downxls.php?date=2015-12-03&symbol=sh600000';
    tmpRet := HttpGet(tmpHttpClient, tmpUrl);
  end;
end;
              
procedure StartDealAgentServer;
var
  tmpNetServer: PNetServerIocp;
begin
  tmpNetServer := GlobalApp.NetMgr.CheckOutNetServerIocp;
  if nil <> tmpNetServer then
  begin               
    tmpNetServer.BaseServer.ListenPort := 1080;
    GlobalApp.NetMgr.ListenAndServeNetServer(tmpNetServer);
  end;
end;

procedure WMAppStart();
begin
  //TestClient();
  //TestServer();
  StartDealAgentServer();  
  //NetUdpServer.TestUDPServer;
end;

end.
