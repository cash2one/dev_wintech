unit BaseWinFormApp;

interface

uses
  Forms,
  BaseApp,
  BaseForm,
  BaseWinApp;

type               
  PBaseWinFormAppData = ^TBaseWinFormAppData;
  TBaseWinFormAppData = record

  end;
  
  TBaseWinFormApp = class(TBaseWinApp)
  protected     
    fBaseWinFormAppData: TBaseWinFormAppData;  
  public                
    constructor Create(AppClassId: AnsiString); override;
    function Initialize: Boolean; override;      
    procedure Run; override;
  end;
               
  TWinFormAppClass = class of TBaseWinFormApp;
  
var
  GlobalBaseWinFormApp: TBaseWinFormApp = nil;
                   
  procedure SimpleRunWinFormApp(AFormClass: TBaseFormClass; AppClass: TWinFormAppClass = nil);

implementation
                  
procedure SimpleRunWinFormApp(AFormClass: TBaseFormClass; AppClass: TWinFormAppClass = nil);
var
  tmpForm: TfrmBase;
begin
  if nil = GlobalBaseWinFormApp then
  begin
    if nil = AppClass then
    begin
      GlobalBaseWinFormApp := TBaseWinFormApp.Create('');
    end else
    begin
      GlobalBaseWinFormApp := AppClass.Create('');
    end;
    try
      if GlobalBaseWinFormApp.Initialize then
      begin
        Application.CreateForm(AFormClass, tmpForm);
        tmpForm.Initialize(GlobalBaseWinFormApp);
        GlobalBaseWinFormApp.Run;
      end;
      GlobalBaseWinFormApp.IsActiveStatus := IsActiveStatus_RequestShutdown;
      GlobalBaseWinFormApp.Finalize;
    finally         
      GlobalBaseWinFormApp.IsActiveStatus := IsActiveStatus_Shutdown;
      GlobalBaseWinFormApp.Free;
    end;
  end;
end;

{ TBaseWinFormApp }
                   
constructor TBaseWinFormApp.Create(AppClassId: AnsiString);
begin
  inherited Create(AppClassId);
  FillChar(fBaseWinFormAppData, SizeOf(fBaseWinFormAppData), 0);
  GlobalBaseWinFormApp := Self;
end;

function TBaseWinFormApp.Initialize: Boolean;
begin
  Result := inherited Initialize;
  Application.Initialize;
  Application.MainFormOnTaskBar := true;
end;

procedure TBaseWinFormApp.Run;
begin
  Application.Run;
end;

end.
