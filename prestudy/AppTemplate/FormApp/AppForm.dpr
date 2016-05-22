program AppForm;

uses
  Forms,
  BaseApp in '..\..\..\v0001\obj\app_base\BaseApp.pas',
  BasePath in '..\..\..\v0001\obj\app_base\BasePath.pas',
  BaseWinApp in '..\..\..\v0001\obj\win_app\BaseWinApp.pas',
  BaseWinFormApp in '..\..\..\v0001\obj\win_app\BaseWinFormApp.pas',
  BaseForm in '..\..\..\v0001\obj\win_uiform\BaseForm.pas' {frmBase},
  FormFunctionsTab in '..\..\..\v0001\obj\win_uiform\FormFunctionsTab.pas' {frmFunctionsTab},
  FormSample in 'FormSample.pas' {frmSample},
  SampleFormApp in 'SampleFormApp.pas';

{$R *.res}

begin    
  GlobalApp := TSampleApp.Create('');
  try
    if GlobalApp.Initialize then
    begin
      GlobalApp.Run;
    end;
    GlobalApp.Finalize;
  finally
    GlobalApp.Free;
  end;
end.
