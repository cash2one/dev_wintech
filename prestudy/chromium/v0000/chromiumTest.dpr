program chromiumTest;

uses
  Windows,
  cef_apilib in '..\..\..\v0000\ex_chromium\cef_apilib.pas',
  cef_api in '..\..\..\v0000\ex_chromium\cef_api.pas',
  cef_type in '..\..\..\v0000\ex_chromium\cef_type.pas',
  cef_app in '..\..\..\v0000\ex_chromium\cef_app.pas',
  BaseApp in '..\..\..\v0000\win_base\BaseApp.pas',
  BasePath in '..\..\..\v0000\win_base\BasePath.pas',
  BaseThread in '..\..\..\v0000\win_base\BaseThread.pas',
  BaseWinApp in '..\..\..\v0000\win_base\BaseWinApp.pas',
  UIBaseWin in '..\..\..\v0000\win_base\UIBaseWin.pas',
  BaseWinThread in '..\..\..\v0000\win_base\BaseWinThread.pas',
  BaseRun in '..\..\..\v0000\win_base\BaseRun.pas',
  HostWnd_chromium in 'HostWnd_chromium.pas';

{$R *.res}

type
  TChromiumTestApp = class(TBaseWinApp)
  protected
  public
    procedure Run; override;    
  end;
  
{ TChromiumTestApp }

procedure TChromiumTestApp.Run;
begin
  inherited;
  RunAppMsgLoop;
end;

var
  GlobalApp: TChromiumTestApp;
begin
  RunApp(TChromiumTestApp, '', TBaseApp(GlobalApp));
end.
