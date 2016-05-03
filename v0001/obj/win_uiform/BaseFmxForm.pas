unit BaseFmxForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Forms, BaseApp;

type
  TfrmBaseData = record
    App: TBaseApp;
  end;

  TfrmBase = class(TForm)
  protected
    fBaseFormData: TfrmBaseData;
  public
    constructor Create(AOwner: TComponent); override;
    property App: TBaseApp read fBaseFormData.App write fBaseFormData.App;
  end;

implementation

{$R *.dfm}

{ TfrmBase }

constructor TfrmBase.Create(AOwner: TComponent);
begin
  inherited;
  FillChar(fBaseFormData, SizeOf(fBaseFormData), 0);
end;

end.
