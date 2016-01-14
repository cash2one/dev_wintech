unit BaseWinFmxApp;

interface
         
uses
  Vcl.Forms,
  BaseWinApp;

type
  PBaseWinFmxAppData = ^TBaseWinFmxAppData;
  TBaseWinFmxAppData = record

  end;

  TBaseWinFmxApp = class(TBaseWinApp)
  protected
  public
    function Initialize: Boolean; override;
  end;

implementation

{ TBaseWinFmxApp }

function TBaseWinFmxApp.Initialize: Boolean;
begin
  Result := inherited Initialize;
  Application.Initialize;
end;

end.
