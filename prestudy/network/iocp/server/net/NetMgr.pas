unit NetMgr;

interface

uses
  BaseApp,
  NetBase,
  NetObjClient,    
  NetHttpClient,
  NetServerIocp,
  NetBaseObj;
  
type
  TNetMgrData = record
    NetBase: TNetBase;
  end;

  TNetMgr = class(TBaseAppObj)
  protected
    fNetMgrData: TNetMgrData;
  public
    constructor Create(App: TBaseApp); override;
    destructor Destroy; override;
    function CheckOutNetClient: PNetClient;
    function CheckOutHttpClient: PNetHttpClient;
    function CheckOutNetServer: PNetServer;
    function CheckOutNetServerIocp: PNetServerIocp;
    procedure ListenAndServeNetServer(AServer: PNetServerIocp);
  end;
  
implementation

uses
  Windows;
  
{ TNetMgr }
constructor TNetMgr.Create(App: TBaseApp);
begin
  inherited;
  FillChar(fNetMgrData, SizeOf(fNetMgrData), 0);
  InitializeNet(@fNetMgrData.NetBase);
end;

destructor TNetMgr.Destroy;
begin
  inherited;
end;

function TNetMgr.CheckOutNetServer: PNetServer;
begin
  Result := System.New(PNetServer);
  FillChar(Result^, SizeOf(TNetServer), 0);
end;

function TNetMgr.CheckOutNetServerIocp: PNetServerIocp;
begin
  Result := System.New(PNetServerIocp);
  FillChar(Result^, SizeOf(TNetServerIocp), 0);
  //Windows.InitializeCriticalSection(Result.BaseServer.ClientPool.Lock);
end;

function TNetMgr.CheckOutNetClient: PNetClient;
begin
  Result := System.New(PNetClient);
  FillChar(Result^, SizeOf(TNetClient), 0);
  Result.TimeOutConnect := 10 * 1000; //Á¬½Ó³¬Ê±
  Result.TimeOutRead := 30 * 1000;
end;
           
function TNetMgr.CheckOutHttpClient: PNetHttpClient;
begin
  Result := System.New(PNetHttpClient);
  FillChar(Result^, SizeOf(TNetHttpClient), 0);
  Result.NetClient := CheckOutNetClient;
end;

procedure TNetMgr.ListenAndServeNetServer(AServer: PNetServerIocp);
begin
  if nil = AServer then
    exit;
  NetServerIocp.OpenIOCPNetServer(AServer);
end;

end.
