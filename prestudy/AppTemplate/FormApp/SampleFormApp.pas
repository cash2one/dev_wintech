unit SampleFormApp;

interface

uses
  Forms,
  BaseForm,
  BaseWinFormApp;

type
  TSampleAppData = record
    MainForm: TfrmBase;
  end;
  
  TSampleApp = class(TBaseWinFormApp)
  protected
    fSampleAppData: TSampleAppData;
  public                
    constructor Create(AppClassId: AnsiString); override;
    function Initialize: Boolean; override;      
    procedure Run; override;
  end;

var
  GlobalApp: TSampleApp = nil;
    
implementation

{ TSampleApp }

uses
  FormSample;
                      
constructor TSampleApp.Create(AppClassId: AnsiString);
begin
  inherited;
  FillChar(fSampleAppData, SizeOf(fSampleAppData), 0);
end;

function TSampleApp.Initialize: Boolean;
begin
  Result := inherited Initialize;  
  Application.CreateForm(TfrmSample, fSampleAppData.MainForm);
end;

procedure TSampleApp.Run;
begin
  inherited Run;
end;

end.
