unit BaseWinFormApp;

interface

uses
  Forms,
  BaseWinApp;

type               
  PBaseWinFormAppData = ^TBaseWinFormAppData;
  TBaseWinFormAppData = record

  end;
  
  TBaseWinFormApp = class(TBaseWinApp)
  protected
  public        
    function Initialize: Boolean; override;      
    procedure Run; override;
  end;
  
implementation

{ TBaseWinFormApp }

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
