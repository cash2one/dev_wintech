unit win.service_install;

interface

uses
  win.service;

type
  PWinServiceInstallW  = ^TWinServiceInstallW;
  TWinServiceInstallW  = record
    Service         : PWinServiceW;
    ServiceHandle   : THandle; 
    DisplayName     : array[0..64 - 1] of WideChar; 
    ServiceStartName: array[0..64 - 1] of WideChar; 
    Description     : array[0..256 - 1] of WideChar;   
    Password        : WideString;
    LoadGroup       : WideString;
  end;
  
  procedure InstallWinService(AWinServiceInstall: PWinServiceInstallW); overload;
  procedure InstallWinService(AWinServiceInstall: PWinServiceInstallW; ASvcMgr: Integer); overload;

  procedure UninstallWinService(AWinServiceInstall: PWinServiceInstallW); overload;
  procedure UninstallWinService(AWinServiceInstall: PWinServiceInstallW; ASvcMgr: Integer); overload;
   
implementation
            
uses
  WinSvc,
  Windows,
  SysUtils,
  UtilsLog;
                     
procedure InstallWinService(AWinServiceInstall: PWinServiceInstallW; ASvcMgr: Integer);
var
  tmpPath: WideString;
  tmpPSSN: PWideChar;  
  tmpTagID: Integer;
  tmpPTag: Pointer;
  tmpStartType: integer;
  tmpServiceType: integer;
  tmpErrorSeverity: integer;
begin                 
  Log('win.service.pas', 'InstallWinService begin:');
  tmpPath := ParamStr(0);
  if AWinServiceInstall.ServiceStartName = '' then
    tmpPSSN := nil
  else
    tmpPSSN := PWideChar(@AWinServiceInstall.ServiceStartName[0]);
                  
  tmpTagID := AWinServiceInstall.Service.TagID;
  if tmpTagID > 0 then
    tmpPTag := @tmpTagID
  else
    tmpPTag := nil;

  tmpServiceType := GetNTServiceType(AWinServiceInstall.Service);
  tmpStartType:= GetNTStartType(AWinServiceInstall.Service);
  tmpErrorSeverity := GetNTErrorSeverity(AWinServiceInstall.Service);

  AWinServiceInstall.ServiceHandle := WinSvc.CreateServiceW(ASvcMgr,
        PWideChar(@AWinServiceInstall.Service.Name[0]),
        PWideChar(@AWinServiceInstall.DisplayName[0]),
        SERVICE_ALL_ACCESS,
        tmpServiceType,
        tmpStartType,
        tmpErrorSeverity,
        PWideChar(tmpPath),
        nil,//PWideChar(AServiceProc.LoadGroup),
        tmpPTag,
        nil, //PWideChar(GetNTDependenciesW(AWinService)),
        tmpPSSN,
        nil //PWideChar(AServiceProc.Password)
        );
  if 0 = AWinServiceInstall.ServiceHandle then
  begin
    Log('', 'CreateServiceW Error');
    AWinServiceInstall.Service.LastError := Windows.GetLastError;
    if 0 <> AWinServiceInstall.Service.LastError then
    begin                   
      Log('', 'CreateServiceW Error Code:' + IntToStr(AWinServiceInstall.Service.LastError));
      if ERROR_ALREADY_EXISTS = AWinServiceInstall.Service.LastError  then // 183
      begin
      end;
      if ERROR_INVALID_SERVICE_ACCOUNT = AWinServiceInstall.Service.LastError then// 1057
      begin
      end;
    end else
    begin
      Log('', 'CreateServiceW Error Code 0');
    end;
  end else
  begin       
    Log('', 'CreateServiceW Succ');
    WinSvc.CloseServiceHandle(AWinServiceInstall.ServiceHandle);
  end;
  Log('win.service.pas', 'InstallWinService end');    
end;

procedure InstallWinService_Reg(AWinServiceInstall: PWinServiceInstallW);
begin
  // HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services
  //   DisplayName -- String
  // Description字符串值，对应服务描述
  // ImagePath 字符串值，对应该服务程序所在的路径
  // ObjectName 字符串值，值为"LocalSystem"，表示本地登录
  // ErrorControl Dword值，值为"1"
  // Start Dword值，值为2表示自动运行，值为3表示手动运行，值为4表示禁止
  // Type Dword值，应用程序对应10，其它对应20
end;

procedure InstallWinService(AWinServiceInstall: PWinServiceInstallW);
var
  tmpSvcMgr: integer;
begin                  
  Log('', 'InstallWinService begin');
  //windows 手动添加服务
  //方法一：修改注册表
  tmpSvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if 0 <> tmpSvcMgr then
  begin
    try
      InstallWinService(AWinServiceInstall, tmpSvcMgr);
    finally
      CloseServiceHandle(tmpSvcMgr);
    end;
  end;
  Log('', 'InstallWinService end');  
end;

procedure UninstallWinService(AWinServiceInstall: PWinServiceInstallW; ASvcMgr: Integer);
begin
  Log('', 'UninstallWinService begin');
  AWinServiceInstall.ServiceHandle := OpenServiceW(ASvcMgr, PWideChar(@AWinServiceInstall.Service.Name[0]), SERVICE_ALL_ACCESS);
  if 0 = AWinServiceInstall.ServiceHandle then
  begin
    //RaiseLastOSError;
  end;
  try
    if not WinSvc.DeleteService(AWinServiceInstall.ServiceHandle) then
    begin
      //RaiseLastOSError;
    end;
  finally
  end;    
  Log('', 'UninstallWinService end');
end;

procedure UninstallWinService(AWinServiceInstall: PWinServiceInstallW);
var
  tmpSvcMgr: Integer;
begin
  Log('', 'UninstallWinService begin');        
  tmpSvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  try
    UninstallWinService(nil, tmpSvcMgr);
  finally
    WinSvc.CloseServiceHandle(tmpSvcMgr);
  end;
  Log('', 'UninstallWinService end');  
end;                                                 

end.
