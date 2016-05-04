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
  tmpServiceInstall: TWinServiceInstallW;
begin
  FillChar(GlobalApp, SizeOf(GlobalApp), 0);
  FillChar(GlobalService, SizeOf(GlobalService), 0);
  
  GlobalService.App := @GlobalApp;

  tmpWS := C_ServiceName;
  CopyMemory(@GlobalService.Name[0], @tmpWS[1], Length(tmpWS) * SizeOf(WideChar));
  
  //GlobalService.Name             := C_ServiceName;  
  
  GlobalService.ServiceType     := stWin32;
  GlobalService.StartType       := stAuto;
  GlobalService.ErrorSeverity   := esIgnore;
  GlobalService.ErrorSeverity   := esNormal;
  GlobalService.IsAllowPause := True;
  GlobalService.IsAllowStop := True;

  if FindCmdLineSwitch('INSTALL', ['-', '/'], True) then
  begin
    FillChar(tmpServiceInstall, SizeOf(tmpServiceInstall), 0);
                     
    tmpWS := C_ServiceStartName;
    CopyMemory(@tmpServiceInstall.ServiceStartName[0], @tmpWS[1], Length(tmpWS) * SizeOf(WideChar));

    tmpWS := C_ServiceDisplayName;
    CopyMemory(@tmpServiceInstall.DisplayName[0], @tmpWS[1], Length(tmpWS) * SizeOf(WideChar));
      
    tmpServiceInstall.Service := @GlobalService;
    InstallWinService(@tmpServiceInstall);
    exit;
  end;
  if FindCmdLineSwitch('UNINSTALL', ['-', '/'], True) then
  begin
    FillChar(tmpServiceInstall, SizeOf(tmpServiceInstall), 0);                               
    tmpServiceInstall.Service := @GlobalService;
    UninstallWinService(@tmpServiceInstall);
    exit;
  end;
  RunWinService(@GlobalService);
end.
