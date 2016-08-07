unit BaseApp;

interface

uses
  BasePath;

const
  IsActiveStatus_Active = 1;      
  IsActiveStatus_RequestShutdown = 2;    
  IsActiveStatus_Shutdown = 3;
  
type
  PBaseAppData      = ^TBaseAppData;
  TBaseAppData      = packed record
    IsActiveStatus  : Byte;
    AppClassId  : AnsiString;
  end;

  TBaseAppPath = class;
  TBaseAppAgent = class;
  
  TBaseApp = class                 
  protected
    fBaseAppData: TBaseAppData; 
    function GetPath: TBaseAppPath; virtual;
    function GetBaseAppData: PBaseAppData;
  public
    constructor Create(AppClassId: AnsiString); virtual;
    destructor Destroy; override;

    function Initialize: Boolean; virtual;
    procedure Finalize; virtual;
    procedure Run; virtual;
    procedure Terminate; virtual;
    property BaseAppData: PBaseAppData read GetBaseAppData; 
    property IsActiveStatus: Byte read fBaseAppData.IsActiveStatus write fBaseAppData.IsActiveStatus;
    property Path: TBaseAppPath read GetPath;
  end;

  TBaseAppAgentData = record
    HostApp: TBaseApp;
  end;
  
  TBaseAppAgent = class
  protected
    fBaseAppAgentData: TBaseAppAgentData;
  public
    constructor Create(AHostApp: TBaseApp); virtual;
    function Initialize: Boolean; virtual;
    procedure Finalize; virtual;
    procedure Run; virtual;
  end;

  TBaseAppObjData = record
    App: TBaseApp;
  end;
  
  TBaseAppObj = class
  protected
    fBaseAppObjData: TBaseAppObjData;
  public
    constructor Create(App: TBaseApp); virtual;
  end;
           
  TBaseAppPathData = record
    App: TBaseApp;
  end;
  
  TBaseAppPath = class(TBasePath)
  protected     
    fBaseAppPathData: TBaseAppPathData;
  public          
    constructor Create(App: TBaseApp); virtual;
  end;
  
  TBaseAppClass = class of TBaseApp;
    
var
  GlobalBaseApp: TBaseApp = nil;

{
  RunApp(TzsHelperApp, 'zshelperApp', TBaseApp(GlobalApp));
}
  function RunApp(AppClass: TBaseAppClass; AppClassId: AnsiString; var AGlobalApp: TBaseApp): TBaseApp;

implementation

function RunApp(AppClass: TBaseAppClass; AppClassId: AnsiString; var AGlobalApp: TBaseApp): TBaseApp;
begin
  GlobalBaseApp := AppClass.Create(AppClassId);
  try    
    AGlobalApp := GlobalBaseApp;
    Result := GlobalBaseApp;
    if GlobalBaseApp.Initialize then
    begin
      GlobalBaseApp.Run;
    end;
    GlobalBaseApp.Finalize;
  finally
    GlobalBaseApp.Free;
  end;
end;
  
{ TBaseApp }
                         
constructor TBaseApp.Create(AppClassId: AnsiString);
begin
  GlobalBaseApp := Self;
  FillChar(fBaseAppData, SizeOf(fBaseAppData), 0);
  fBaseAppData.AppClassId := AppClassId; 
  fBaseAppData.IsActiveStatus := IsActiveStatus_Active;
end;

destructor TBaseApp.Destroy;
begin
  inherited;
end;

function TBaseApp.GetPath: TBaseAppPath;
begin
  Result := nil;
end;

function TBaseApp.Initialize: Boolean;
begin
  Result := true;
end;

procedure TBaseApp.Finalize;
begin
end;

function TBaseApp.GetBaseAppData: PBaseAppData;
begin
  Result := @fBaseAppData;
end;

procedure TBaseApp.Run;
begin
end;

procedure TBaseApp.Terminate;
begin
end;
{ TBaseAppObj }

constructor TBaseAppObj.Create(App: TBaseApp);
begin
  FillChar(fBaseAppObjData, SizeOf(fBaseAppObjData), 0);
  fBaseAppObjData.App := App;
end;

{ TBaseAppPath }

constructor TBaseAppPath.Create(App: TBaseApp);
begin
  FillChar(fBaseAppPathData, SizeOf(fBaseAppPathData), 0);
  fBaseAppPathData.App := App;
end;

{ TBaseAppAgent }

constructor TBaseAppAgent.Create(AHostApp: TBaseApp);
begin
  FillChar(fBaseAppAgentData, SizeOf(fBaseAppAgentData), 0);
  fBaseAppAgentData.HostApp := AHostApp;
end;

function TBaseAppAgent.Initialize: Boolean;
begin
  Result := True;
end;

procedure TBaseAppAgent.Finalize;
begin
end;

procedure TBaseAppAgent.Run;
begin
end;

end.
