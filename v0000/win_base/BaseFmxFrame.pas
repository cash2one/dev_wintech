unit BaseFmxFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Forms, BaseApp;

type
  TfmeBaseData = record
    App: TBaseApp;
  end;

  TfmeBase = class(TFrame)
  protected
    fBaseFrameData: TfmeBaseData;
  public
    constructor Create(AOwner: TComponent); override;
    property App: TBaseApp read fBaseFrameData.App write fBaseFrameData.App;
  end;

implementation

{$R *.dfm}

{ TfmeBase }

constructor TfmeBase.Create(AOwner: TComponent);
begin
  inherited;
  FillChar(fBaseFrameData, SizeOf(fBaseFrameData), 0);
end;

end.
