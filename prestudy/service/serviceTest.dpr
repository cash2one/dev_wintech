program serviceTest;

uses
  WinSvc,
  Windows,
  SysUtils,
  UtilsLog in '..\..\v0000\win_utils\UtilsLog.pas',
  win.service in 'win.service.pas',
  win.app in 'win.app.pas',
  win.app_exit in 'win.app_exit.pas',
  win.service_install in 'win.service_install.pas';

{$R *.res}
 
const
  C_ServiceName = 'testsrv';
  C_ServiceDisplayName = 'testsrv_display';
  C_ServiceStartName = 'testsrv_start';

var
  tmpWS: WideString;
  GlobalApp: TWinApp;
begin
  FillChar(GlobalApp, SizeOf(GlobalApp), 0);
  FillChar(GlobalService, SizeOf(GlobalService), 0);
  
  GlobalService.App := @GlobalApp;

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

  if FindCmdLineSwitch('INSTALL', ['-', '/'], True) then
  begin
    InstallWinService(@GlobalService);
    exit;
  end;
  if FindCmdLineSwitch('UNINSTALL', ['-', '/'], True) then
  begin
    UninstallWinService(@GlobalService);
    exit;
  end;
  RunWinService(@GlobalService);
end.
