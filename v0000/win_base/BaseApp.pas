unit BaseApp;

interface

uses
  BasePath;
  
type
  // LogicSessionStep
  PProcStep     = ^TProcStep;
  TProcStep     = record
    MainStep    : integer;
    ChildStep   : integer;
    StepIParam  : integer;
    StepPParam  : Pointer;
  end;

  // application has many sessions at same time
  PLogicSession = ^TLogicSession;
  TLogicSession = record
    CurrentStep : PProcStep;
  end;

  PLogicBaseStep  = ^TLogicBaseStep;
  TLogicBaseStep  = record
    StepType    : Integer;
  end;

  PLogicStep1   = ^TLogicStep1;
  TLogicStep1   = record
    Base        : TLogicBaseStep;
    NextStep    : PLogicBaseStep;
  end;
  
  PLogicStep2   = ^TLogicStep2;
  TLogicStep2   = record
    Base        : TLogicBaseStep;
    NextStep1   : PLogicBaseStep;
    NextStep2   : PLogicBaseStep;    
  end;
  // logic model
  PLogicModel   = ^TLogicModel;
  TLogicModel  = record
    // Èë¿Ú
    FirstStep   : PLogicBaseStep;
  end;

  PBaseAppData      = ^TBaseAppData;
  TBaseAppData      = packed record
    IsActiveStatus  : Byte;
    AppClassId  : AnsiString;
  end;

  TBaseAppPath = class;
  
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
    property BaseAppData: PBaseAppData read GetBaseAppData; 
    property IsActiveStatus: Byte read fBaseAppData.IsActiveStatus write fBaseAppData.IsActiveStatus;
    property Path: TBaseAppPath read GetPath;
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
  fBaseAppData.IsActiveStatus := 1;
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

end.
