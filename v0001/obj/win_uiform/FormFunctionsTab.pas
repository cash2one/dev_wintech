unit FormFunctionsTab;

interface

uses
  Forms, Classes, Tabs, BaseForm, Controls;

type
  PFunctionTab  = ^TFunctionTab;
  TFunctionTab  = record
    FormClass   : TBaseFormClass;
    Form        : TfrmBase;
    TabName     : AnsiString;
  end;
  
  TfrmFunctionsTab = class(TfrmBase)
    ts1: TTabSet;
    procedure ts1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
  protected
    FActiveFunctionTab: PFunctionTab;
  public              
    constructor Create(AOwner: TComponent); override;
    function AddFunctionTab(ATabName: AnsiString; AFormClass: TBaseFormClass): PFunctionTab;
  end;

implementation

{$R *.dfm}

(*//
type
  TZhiApp = class(TBaseWinFormApp)
  protected
    fFunctionsTabForm: TfrmBase;
  public           
    function Initialize: Boolean; override;  
  end;

var
  GlobalZhiApp: TZhiApp = nil;
  
uses
  FormConsole,
  FormFunctionsTab;
  
function TZhiApp.Initialize: Boolean;
begin
  Result := inherited Initialize;
  Application.CreateForm(TfrmFunctionsTab, fFunctionsTabForm);
  fFunctionsTabForm.Initialize(Self);

  TfrmFunctionsTab(fFunctionsTabForm).AddFunctionTab('¿ØÖÆÌ¨', TfrmConsole);
end;
//*)
{ TfrmFunctionsTab }

function TfrmFunctionsTab.AddFunctionTab(ATabName: AnsiString; AFormClass: TBaseFormClass): PFunctionTab;
begin
  Result := System.New(PFunctionTab);
  FillChar(Result^, SizeOf(TFunctionTab), 0);
  Result.FormClass := AFormClass;
  Result.TabName := ATabName;
  ts1.Tabs.AddObject(ATabName, TObject(Result));
  if 0 > ts1.TabIndex  then
    ts1.TabIndex := 0;
end;

constructor TfrmFunctionsTab.Create(AOwner: TComponent);
begin
  inherited;
  FActiveFunctionTab := nil;
end;

procedure TfrmFunctionsTab.ts1Change(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
var
  tmpFunctionTab: PFunctionTab;
begin
  tmpFunctionTab := PFunctionTab(ts1.Tabs.Objects[NewTab]);
  if nil <> tmpFunctionTab then
  begin
    if nil = tmpFunctionTab.Form then
    begin
      if nil <> tmpFunctionTab.FormClass then
      begin
        if nil <> App then
        begin
          tmpFunctionTab.Form := tmpFunctionTab.FormClass.Create(Application);
          tmpFunctionTab.Form.Parent := Self;
          tmpFunctionTab.Form.BorderStyle := bsNone;
          tmpFunctionTab.Form.Align := alClient;
          tmpFunctionTab.Form.Initialize(App);
        end;
      end;
    end;
    if nil <> FActiveFunctionTab then
    begin
      if nil <> FActiveFunctionTab.Form then
      begin
        FActiveFunctionTab.Form.Visible := false;
      end;
    end;
    FActiveFunctionTab := tmpFunctionTab;
    FActiveFunctionTab.Form.Show;
  end;
end;

end.
