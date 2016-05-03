unit BaseForm;

interface

uses
  Classes, Forms, Messages, SysUtils, Windows, 
  BaseApp;

type      
  TfrmBaseData = record
    App: TBaseApp;
  end;

  TfrmBase = class(TForm)
  protected
    fBaseFormData: TfrmBaseData;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Initialize(App: TBaseApp); virtual;  
    procedure SetData(ADataType: integer; AData: Pointer); virtual;
    function GetData(ADataType: integer; AParam: Pointer): Pointer; virtual;   
    procedure DoActivate; virtual;             
    procedure DoDeactivate; virtual;
    
    procedure SaveLayout; virtual;
    procedure RestoreLayout; virtual;
    property App: TBaseApp read fBaseFormData.App write fBaseFormData.App;    
  end;

  TBaseFormClass = class of TfrmBase;
  
implementation

{$R *.dfm}

{ TfrmBase }

constructor TfrmBase.Create(AOwner: TComponent);
begin
  inherited;
  FillChar(fBaseFormData, SizeOf(fBaseFormData), 0);
end;

procedure TfrmBase.Initialize(App: TBaseApp);
begin
  fBaseFormData.App := App;
end;

function TfrmBase.GetData(ADataType: integer; AParam: Pointer): Pointer;
begin
  Result := nil;
end;

procedure TfrmBase.SetData(ADataType: integer; AData: Pointer);
begin
end;

procedure TfrmBase.DoActivate;
begin
end;

procedure TfrmBase.DoDeactivate;
begin
end;
       
procedure TfrmBase.RestoreLayout;
begin
end;

procedure TfrmBase.SaveLayout;
begin
end;

end.
