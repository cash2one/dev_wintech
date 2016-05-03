program serviceTest;

uses
  WinSvc,
  Windows,
  SysUtils,
  UtilsLog in '..\..\v0000\win_utils\UtilsLog.pas',
  win.service in 'win.service.pas',
  win.app in 'win.app.pas',
  service.test in 'service.test.pas',
  win.app_exit in 'win.app_exit.pas',
  win.service_install in 'win.service_install.pas';

{$R *.res}

//  SvcMgr,

procedure CreateService();
begin
end;
               
const
  C_ServiceName = 'testsrv';
  C_ServiceDisplayName = 'testsrv_display';
  C_ServiceStartName = 'testsrv_start';

var
  tmpWS: WideString;               
begin   
  FillChar(GlobalApp, SizeOf(GlobalApp), 0);
  FillChar(GlobalServiceApp, SizeOf(GlobalServiceApp), 0);
  FillChar(GlobalService, SizeOf(GlobalService), 0);
  
  GlobalServiceApp.App := @GlobalApp;

  GlobalService.ServiceStartName := C_ServiceStartName;
  tmpWS := C_ServiceName;
  CopyMemory(@GlobalService.Name[0], @tmpWS[1], Length(tmpWS) * SizeOf(WideChar));
  
  //GlobalService.Name             := C_ServiceName;  
  tmpWS := C_ServiceDisplayName;
  CopyMemory(@GlobalService.DisplayName[0], @tmpWS[1], Length(tmpWS) * SizeOf(WideChar));
  
  GlobalService.ServiceType     := stWin32;
  GlobalService.StartType       := stAuto;
  GlobalService.ErrorSeverity   := esIgnore;
  GlobalService.ErrorSeverity   := esNormal;
  GlobalService.IsAllowPause := True;
  GlobalService.IsAllowStop := True;
  GlobalService.Controller := ServiceHandler_TestProc;
  GlobalService.ServiceApp := @GlobalServiceApp; 

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
