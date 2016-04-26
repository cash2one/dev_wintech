unit DealServerApp;

interface

uses
  Windows, BaseApp, BaseWinApp, AppWindow, NetMgr;
  
type
  TDealAgentServerAppData = record
    AppWindow: TAppWindow;
    NetMgr: TNetMgr;
  end;
  
  TDealAgentServerApp = Class(TBaseWinApp)
  protected
    fSrvAppData: TDealAgentServerAppData;
  public
    constructor Create(AppClassId: AnsiString); override;
    destructor Destroy; override;        
    function Initialize: Boolean; override;
    procedure Finalize; override;
    procedure Run; override;     
    property NetMgr: TNetMgr read fSrvAppData.NetMgr;
  end;

var
  GlobalApp: TDealAgentServerApp = nil;
    
implementation

uses
  CmdWindow, Define_Message, Sysutils, DealServerAppStart;
  
{ THttpApiSrvApp }

constructor TDealAgentServerApp.Create(AppClassId: AnsiString);
begin
  inherited;
  FillChar(fSrvAppData, SizeOf(fSrvAppData), 0);
end;

destructor TDealAgentServerApp.Destroy;
begin
  inherited;
end;

procedure TDealAgentServerApp.Finalize;
begin
  DestroyCommandWindow(@fSrvAppData.AppWindow.CommandWindow);
  FreeAndNIl(fSrvAppData.NetMgr);
end;

function TDealAgentServerApp.Initialize: Boolean;
begin
  Result := CreateCommandWindow(@fSrvAppData.AppWindow.CommandWindow, @AppWndProcA, 'dealAgentServerWindow');
  if not Result then
    exit;
  fSrvAppData.NetMgr := TNetMgr.Create(Self);
end;

procedure TDealAgentServerApp.Run;
begin
  AppStartProc := DealServerAppStart.WMAppStart;
  PostMessage(fSrvAppData.AppWindow.CommandWindow.WindowHandle, WM_AppStart, 0, 0);
  RunAppMsgLoop;
end;

end.
