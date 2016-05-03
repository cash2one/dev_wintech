program serviceTest;

uses
  WinSvc,
  Windows,
  SysUtils,
  UtilsLog in '..\..\v0000\win_utils\UtilsLog.pas',
  win.service in 'win.service.pas',
  win.app in 'win.app.pas',
  service.test in 'service.test.pas',
  win.app_exit in 'win.app_exit.pas';

{$R *.res}

procedure CreateService();
begin
end;

begin   
  FillChar(GlobalApp, SizeOf(GlobalApp), 0);
  FillChar(GlobalServiceApp, SizeOf(GlobalServiceApp), 0);
  FillChar(GlobalService, SizeOf(GlobalService), 0);
  
  GlobalServiceApp.App := @GlobalApp;

  GlobalService.ServiceStartName := 'testsrv_start';
  GlobalService.Name             := 'testsrv_name';
  GlobalService.DisplayName      := 'testsrv_display';
  GlobalService.ServiceType     := stWin32;
  GlobalService.StartType       := stAuto;
  GlobalService.ErrorSeverity   := esIgnore;
  GlobalService.ErrorSeverity   := esNormal;
  GlobalService.IsAllowPause := True;
  GlobalService.IsAllowStop := True;

  if FindCmdLineSwitch('INSTALL', ['-', '/'], True) then
  begin
    InstallWinService(@GlobalServiceApp, @GlobalService);
    exit;
  end;
  if FindCmdLineSwitch('UNINSTALL', ['-', '/'], True) then
  begin
    UninstallWinService(@GlobalServiceApp);
    exit;
  end;
  RunWinService(@GlobalServiceApp);
end.
