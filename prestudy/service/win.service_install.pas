unit win.service_install;

interface

uses
  win.service;
                    
  procedure InstallWinService(AServiceApp: PWinServiceAppW; AServiceProc: PWinServiceProcW); overload;
  procedure InstallWinService(AServiceProc: PWinServiceProcW; ASvcMgr: Integer); overload;

  procedure UninstallWinService(AServiceApp: PWinServiceAppW); overload;
  procedure UninstallWinService(AServiceProc: PWinServiceProcW; ASvcMgr: Integer); overload;
   
implementation
            
uses
  WinSvc,
  Windows,
  SysUtils,
  UtilsLog;
                     
procedure InstallWinService(AServiceProc: PWinServiceProcW; ASvcMgr: Integer);
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
  if AServiceProc.ServiceStartName = '' then
    tmpPSSN := nil
  else
    tmpPSSN := PWideChar(AServiceProc.ServiceStartName);
                  
  tmpTagID := AServiceProc.TagID;
  if tmpTagID > 0 then
    tmpPTag := @tmpTagID
  else
    tmpPTag := nil;

  tmpServiceType := GetNTServiceType(AServiceProc);
  tmpStartType:= GetNTStartType(AServiceProc);
  tmpErrorSeverity := GetNTErrorSeverity(AServiceProc);

  AServiceProc.ServiceHandle := WinSvc.CreateServiceW(ASvcMgr,
        PWideChar(@AServiceProc.Name[0]),
        PWideChar(@AServiceProc.DisplayName[0]),
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
  if 0 = AServiceProc.ServiceHandle then
  begin
    Log('', 'CreateServiceW Error');
    AServiceProc.LastError := Windows.GetLastError;
    if 0 <> AServiceProc.LastError then
    begin                   
      Log('', 'CreateServiceW Error Code:' + IntToStr(AServiceProc.LastError));
      if ERROR_ALREADY_EXISTS = AServiceProc.LastError  then // 183
      begin
      end;
      if ERROR_INVALID_SERVICE_ACCOUNT = AServiceProc.LastError then// 1057
      begin
      end;
    end else
    begin
      Log('', 'CreateServiceW Error Code 0');
    end;
  end else
  begin       
    Log('', 'CreateServiceW Succ');
    WinSvc.CloseServiceHandle(AServiceProc.ServiceHandle);
  end;
  Log('win.service.pas', 'InstallWinService end');    
end;

procedure InstallWinService_Reg(AServiceApp: PWinServiceAppW; AServiceProc: PWinServiceProcW);
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

procedure InstallWinService(AServiceApp: PWinServiceAppW; AServiceProc: PWinServiceProcW);
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
      InstallWinService(AServiceProc, tmpSvcMgr);
    finally
      CloseServiceHandle(tmpSvcMgr);
    end;
  end;
  Log('', 'InstallWinService end');  
end;

procedure UninstallWinService(AServiceProc: PWinServiceProcW; ASvcMgr: Integer);
begin
  Log('', 'UninstallWinService begin');
  AServiceProc.ServiceHandle := OpenServiceW(ASvcMgr, PWideChar(@AServiceProc.Name[0]), SERVICE_ALL_ACCESS);
  if 0 = AServiceProc.ServiceHandle then
  begin
    //RaiseLastOSError;
  end;
  try
    if not WinSvc.DeleteService(AServiceProc.ServiceHandle) then
    begin
      //RaiseLastOSError;
    end;
  finally
  end;    
  Log('', 'UninstallWinService end');
end;

procedure UninstallWinService(AServiceApp: PWinServiceAppW);
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
