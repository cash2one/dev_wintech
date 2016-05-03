unit win.service;

interface
 
uses
  Types,
  Windows,
  WinSvc,  
  Messages,
  win.app;
  
type            
  TServiceType      = (stWin32, stDevice, stFileSystem);   
  TStartType        = (stBoot, stSystem, stAuto, stManual, stDisabled);
  TErrorSeverity    = (esIgnore, esNormal, esSevere, esCritical);
                            
  TCurrentStatus = (csStopped, csStartPending, csStopPending, csRunning,
    csContinuePending, csPausePending, csPaused);

  TServiceTableEntryArray = array[0..7] of TServiceTableEntryW;
                             
  TServiceController = procedure(CtrlCode: DWord); stdcall;
  
  TWinServiceStart  = record
    ThreadHandle    : THandle;
    ThreadId        : DWord;
    ServiceStartTableLen: integer;
    ServiceStartTable: TServiceTableEntryArray;
    ServiceStartErrorCode: integer;    
  end;

  PWinServiceProcW  = ^TWinServiceProcW;  
  PWinServiceAppW   = ^TWinServiceAppW;
  
  TWinServiceProcW  = record
    StatusHandle    : THandle;
    ThreadHandle    : THandle;   
    ServiceHandle   : THandle;
    ThreadId        : DWord;    
    TagID           : DWORD;
    LastError       : DWORD;     

    ServiceType     : TServiceType;
    Status          : TCurrentStatus;
    StartType       : TStartType;
    ErrorSeverity   : TErrorSeverity;
                                 
    IsAllowStop     : Boolean;
    IsAllowPause    : Boolean;
    IsInteractive   : Boolean;

    Controller      : TServiceController;
    ServiceApp      : PWinServiceAppW;
    Name            : array[0..32 - 1] of WideChar;
    DisplayName     : array[0..64 - 1] of WideChar;  
    Description     : array[0..256 - 1] of WideChar;
    Password        : WideString;
    LoadGroup       : WideString;
    ServiceStartName: WideString;
  end;

  TWinServiceAppW   = record
    App             : PWinApp;
    LastError       : DWORD;

    ServiceStart    : TWinServiceStart;
  end;
         
  function GetNTServiceType(AServiceProc: PWinServiceProcW): Integer;
  function GetNTStartType(AServiceProc: PWinServiceProcW): Integer;   
  function GetNTErrorSeverity(AServiceProc: PWinServiceProcW): Integer;  
  function GetNTDependenciesW(AServiceProc: PWinServiceProcW): WideString;  
  function GetNTControlsAccepted: Integer;
                                      
  procedure InstallWinService(AServiceApp: PWinServiceAppW; AServiceProc: PWinServiceProcW); overload;
  procedure InstallWinService(AServiceProc: PWinServiceProcW; ASvcMgr: Integer); overload;

  procedure UninstallWinService(AServiceApp: PWinServiceAppW); overload;
  procedure UninstallWinService(AServiceProc: PWinServiceProcW; ASvcMgr: Integer); overload;
   
  procedure RunWinService(AServiceApp: PWinServiceAppW);
  procedure ReportServiceStatus(AServiceProc: PWinServiceProcW);  

const
  CM_SERVICE_CONTROL_CODE = WM_USER + 1;
                        
var
  GlobalServiceApp: TWinServiceAppW;   
  GlobalService: TWinServiceProcW;

implementation

uses
  SysUtils,
  UtilsLog;
 
function GetNTServiceType(AServiceProc: PWinServiceProcW): Integer;
const
  NTServiceType: array[TServiceType] of Integer = (
    SERVICE_WIN32_OWN_PROCESS,
    SERVICE_KERNEL_DRIVER,
    SERVICE_FILE_SYSTEM_DRIVER);
begin
  Result := NTServiceType[AServiceProc.ServiceType];
  if (AServiceProc.ServiceType = stWin32) and AServiceProc.IsInteractive then
    Result := Result or SERVICE_INTERACTIVE_PROCESS;
//  if (AServiceProc.ServiceType = stWin32) {and (Application.ServiceCount > 1)} then
//    Result := (Result xor SERVICE_WIN32_OWN_PROCESS) or SERVICE_WIN32_SHARE_PROCESS;
end;
                  
function GetNTStartType(AServiceProc: PWinServiceProcW): Integer;
const
  NTStartType: array[TStartType] of Integer = (
    SERVICE_BOOT_START,
    SERVICE_SYSTEM_START,
    SERVICE_AUTO_START,
    SERVICE_DEMAND_START,
    SERVICE_DISABLED);
begin
  Result := NTStartType[AServiceProc.StartType];
  if (AServiceProc.StartType in [stBoot, stSystem]) and (AServiceProc.ServiceType <> stDevice) then
    Result := SERVICE_AUTO_START;
end;
                  
function GetNTErrorSeverity(AServiceProc: PWinServiceProcW): Integer;
const
  NTErrorSeverity: array[TErrorSeverity] of Integer = (SERVICE_ERROR_IGNORE,
    SERVICE_ERROR_NORMAL, SERVICE_ERROR_SEVERE, SERVICE_ERROR_CRITICAL);
begin
  Result := NTErrorSeverity[AServiceProc.ErrorSeverity];
end;
                  
function GetNTDependenciesW(AServiceProc: PWinServiceProcW): WideString;
//var
//  i, Len: Integer;
//  P: PWideChar;
begin
  Result := '';
//  Len := 0;
//  for i := 0 to AWinService.Dependencies.Count - 1 do
//  begin
//    Inc(Len, Length(AWinService.Dependencies[i].Name) + 1); // For null-terminator
//    if AWinService.Dependencies[i].IsGroup then
//      Inc(Len);
//  end;
//  if Len <> 0 then
//  begin
//    Inc(Len); // For final null-terminator;
//    SetLength(Result, Len);
//    P := @Result[1];
//    for i := 0 to Dependencies.Count - 1 do
//    begin
//      if Dependencies[i].IsGroup then
//      begin
//        P^ := SC_GROUP_IDENTIFIER;
//        Inc(P);
//      end;
//      P := StrECopy(P, PChar(Dependencies[i].Name));
//      Inc(P);
//    end;
//    P^ := #0;
//  end;
end;

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

function ServiceThreadProc(AServiceProc: PWinServiceProcW): HRESULT; stdcall; 
var
  tmpMsg: TMsg;
  tmpIsRet: Boolean;
begin
  Result := 0;    
  Log('', 'ServiceThreadProc begin');
  Windows.PeekMessage(tmpMsg, 0, WM_USER, WM_USER, PM_NOREMOVE); { Create message queue }

  
  AServiceProc.Status := csStartPending;
  ReportServiceStatus(AServiceProc);
                                
  AServiceProc.Status := csRunning;  
  ReportServiceStatus(AServiceProc);
//  if Assigned(FService.OnExecute) then
//    FService.OnExecute(FService)
//  else
//    ProcessRequests(True);
  while True do
  begin
    tmpIsRet := GetMessage(tmpMsg, 0, 0, 0);
    if not tmpIsRet then
      Break;
    if tmpMsg.hwnd = 0 then { Thread message }
    begin
      if tmpMsg.message = CM_SERVICE_CONTROL_CODE then
      begin      
        Log('', 'ServiceThreadProc control code1:' + IntToStr(tmpMsg.wParam));
        case tmpMsg.wParam of
          SERVICE_CONTROL_STOP: begin
            //ActionOK := FService.DoStop;
            AServiceProc.Status := csStopPending; 
            ReportServiceStatus(AServiceProc);
            Break;
          end;
          SERVICE_CONTROL_PAUSE: begin
            //ActionOK := FService.DoPause;   
            AServiceProc.Status := csPaused;
          end;
          SERVICE_CONTROL_CONTINUE: begin
            //ActionOK := FService.DoContinue;  
            AServiceProc.Status := csRunning;
          end;
          SERVICE_CONTROL_SHUTDOWN: begin
            //FService.DoShutDown;        
            AServiceProc.Status := csStopPending;
          end;
          SERVICE_CONTROL_INTERROGATE: begin
            //FService.DoInterrogate;       
          end;
        end;
        ReportServiceStatus(AServiceProc);
      end else
        DispatchMessage(tmpMsg);
    end else
      DispatchMessage(tmpMsg);
  end;
//    ProcessRequests(False);  
  //if (csStopped <> AServiceProc.Status) and
  //   (csStopPending <> AServiceProc.Status)then
  begin
    while True do
    begin                      
      Log('', 'ServiceThreadProc PeekMessage 2');  
      tmpIsRet := PeekMessage(tmpMsg, 0, 0, 0, PM_REMOVE);
      if not tmpIsRet then
        Break;
      Log('', 'ServiceThreadProc PeekMessage 2.1');        
      if tmpMsg.hwnd = 0 then { Thread message }
      begin                
        if tmpMsg.message = CM_SERVICE_CONTROL_CODE then
        begin                   
          Log('', 'ServiceThreadProc control code2:' + IntToStr(tmpMsg.wParam));   
          case tmpMsg.wParam of
            SERVICE_CONTROL_STOP: begin
              //ActionOK := FService.DoStop;
              AServiceProc.Status := csStopPending;
            end;
            SERVICE_CONTROL_PAUSE: begin
              //ActionOK := FService.DoPause;   
              AServiceProc.Status := csPaused;
            end;
            SERVICE_CONTROL_CONTINUE: begin
              //ActionOK := FService.DoContinue;  
              AServiceProc.Status := csRunning;
            end;
            SERVICE_CONTROL_SHUTDOWN: begin
              //FService.DoShutDown;        
              AServiceProc.Status := csStopPending;
            end;
            SERVICE_CONTROL_INTERROGATE: begin
              //FService.DoInterrogate;       
            end;
          end;
          ReportServiceStatus(AServiceProc);
        end else
          DispatchMessage(tmpMsg);
      end else
        DispatchMessage(tmpMsg);
    end;
  end;                     
  Log('', 'ServiceThreadProc end');   
  ExitThread(Result);
end;

procedure StartServiceProc(AServiceProc: PWinServiceProcW);
var
  WaitThread: array[0..1] of THandle;
begin                           
  Log('win.service.pas', 'StartServiceProc begin');
  if nil <> @AServiceProc.Controller then
  begin                                       
    Log('win.service.pas', 'StartServiceProc run');
    AServiceProc.StatusHandle := WinSvc.RegisterServiceCtrlHandlerW(PWideChar(@AServiceProc.Name[0]), @AServiceProc.Controller);
    // DoStart
    AServiceProc.ThreadHandle := Windows.CreateThread(
      nil, //lpThreadAttributes: Pointer;
      0, //dwStackSize: DWORD;
      @ServiceThreadProc, //lpStartAddress: TFNThreadStartRoutine;
      AServiceProc, //lpParameter: Pointer;
      Create_Suspended, // dwCreationFlags: DWORD;
      AServiceProc.ThreadId); // var lpThreadId: DWORD);
    ResumeThread(AServiceProc.ThreadHandle);

    WaitThread[0] := AServiceProc.ThreadHandle;
    WaitThread[1] := 0;
    Windows.WaitForSingleObject(WaitThread[0], INFINITE);  

    Windows.Sleep(100);
    Windows.CloseHandle(AServiceProc.ThreadHandle);
    
    AServiceProc.Status := csStopped;
    ReportServiceStatus(AServiceProc);    
  end;
  // exit application
  //PostQuitMessage(0);
  Sleep(100);
  Log('win.service.pas', 'StartServiceProc end'); 
  if nil <> AServiceProc.ServiceApp then
  begin
    if nil <> AServiceProc.ServiceApp.App then
    begin
      AServiceProc.ServiceApp.App.IsTerminated := True;
    end;
  end;
  Windows.TerminateProcess(GetCurrentProcess, 0);
end;

procedure ServiceMain(Argc: DWord; Argv: PLPSTR); stdcall;
var
  tmpServiceProc: PWinServiceProcW;  
  tmpServiceProcIndex: integer;
  tmpServiceProcCount: integer;
begin                   
  Log('win.service.pas', 'ServiceMain begin' + IntToStr(Argc));
  //Application.DispatchServiceMain(Argc, Argv);
  tmpServiceProc := @GlobalService;  
  tmpServiceProcCount := 1;
  for tmpServiceProcIndex := 0 to tmpServiceProcCount - 1 do
  begin
    StartServiceProc(tmpServiceProc);
  end;
  Log('win.service.pas', 'ServiceMain end');  
end;

function ServiceStartThreadProc(AServiceApp: PWinServiceAppW): HResult; stdcall;
begin
  Result := 0;       
  Log('win.service.pas', 'ServiceStartThreadProc begin');
  if WinSvc.StartServiceCtrlDispatcherW(AServiceApp.ServiceStart.ServiceStartTable[0]) then
  begin
    AServiceApp.ServiceStart.ServiceStartErrorCode := 0;
  end else
  begin
    AServiceApp.ServiceStart.ServiceStartErrorCode := GetLastError;     
    Log('win.service.pas', 'ServiceStartThreadProc last error:' + IntToStr(AServiceApp.ServiceStart.ServiceStartErrorCode));
  end;
  ExitThread(Result);                
  Log('win.service.pas', 'ServiceStartThreadProc end');
end;

procedure RunWinService(AServiceApp: PWinServiceAppW);
var
//  i: integer;
  tmpIsUnicode: Boolean;
  tmpIsMsgExists: Boolean;
begin
  //AWinService.
  Log('win.service.pas', 'RunWinService:');
  //while not AWinService.IsTerminated do
  //StartThread: TServiceStartThread;
//  for i := Low(AWinServiceApp.ServiceStart.ServiceStartTable) to High(AWinServiceApp.ServiceStart.ServiceStartTable) do
//  begin
//    AWinServiceApp.ServiceStart.ServiceStartTable[i].lpServiceName := 'testsrv' + IntToStr();
//    AWinServiceApp.ServiceStart.ServiceStartTable[i].lpServiceProc := @ServiceMain;
//  end;
  //AServiceApp.ServiceStart.ServiceStartTable[0].lpServiceName := 'testsrv_start0';
  //AServiceApp.ServiceStart.ServiceStartTable[0].lpServiceName := AServiceApp.ServiceStart.ServiceStartTable[0].lpServiceName;   
  AServiceApp.ServiceStart.ServiceStartTable[0].lpServiceName := @GlobalService.Name[0];
  AServiceApp.ServiceStart.ServiceStartTable[0].lpServiceProc := @ServiceMain;

  AServiceApp.ServiceStart.ThreadHandle := Windows.CreateThread(
    nil, //lpThreadAttributes: Pointer;
    0, //dwStackSize: DWORD;
    @ServiceStartThreadProc, // lpStartAddress: TFNThreadStartRoutine;
    AServiceApp, //lpParameter: Pointer;
    CREATE_SUSPENDED, //dwCreationFlags: DWORD;
    AServiceApp.ServiceStart.ThreadId); //var lpThreadId: DWORD);
  Windows.ResumeThread(AServiceApp.ServiceStart.ThreadHandle);
  
  // App Run
  AServiceApp.App.IsTerminated := false;
  while not AServiceApp.App.IsTerminated do
  begin
    // ProcessMessage
    if Windows.PeekMessage(AServiceApp.App.AppMsg, 0, 0, 0, PM_NOREMOVE) then
    begin                 
      tmpIsUnicode := (AServiceApp.App.AppMsg.hwnd <> 0) and IsWindowUnicode(AServiceApp.App.AppMsg.hwnd);
      if tmpIsUnicode then
        tmpIsMsgExists := PeekMessageW(AServiceApp.App.AppMsg, 0, 0, 0, PM_REMOVE)
      else
        tmpIsMsgExists := PeekMessage(AServiceApp.App.AppMsg, 0, 0, 0, PM_REMOVE);
      if tmpIsMsgExists then
      begin
        if AServiceApp.App.AppMsg.Message <> Messages.WM_QUIT then
        begin
          TranslateMessage(AServiceApp.App.AppMsg);
          if tmpIsUnicode then
            DispatchMessageW(AServiceApp.App.AppMsg)
          else
            DispatchMessageA(AServiceApp.App.AppMsg);
        end else
        begin
          AServiceApp.App.IsTerminated := True;
        end;
      end else
      begin
        Windows.WaitMessage;
      end;
    end else
    begin
      Windows.WaitMessage;
    end;
  end;
end;
                 
function GetNTControlsAccepted: Integer;
begin
  Result := SERVICE_ACCEPT_SHUTDOWN or SERVICE_ACCEPT_STOP or SERVICE_ACCEPT_PAUSE_CONTINUE;
//  if AllowStop then Result := Result or SERVICE_ACCEPT_STOP;
//  if AllowPause then Result := Result or SERVICE_ACCEPT_PAUSE_CONTINUE;
end;

procedure ReportServiceStatus(AServiceProc: PWinServiceProcW);
const
  NTServiceStatus: array[TCurrentStatus] of Integer = (SERVICE_STOPPED,
    SERVICE_START_PENDING, SERVICE_STOP_PENDING, SERVICE_RUNNING,
    SERVICE_CONTINUE_PENDING, SERVICE_PAUSE_PENDING, SERVICE_PAUSED);
  PendingStatus: set of TCurrentStatus = [csStartPending, csStopPending,
    csContinuePending, csPausePending];  
var
  tmpServiceStatus: TServiceStatus;
begin          
  Log('win.service.pas', 'ReportServiceStatus:' + IntToStr(Integer(AServiceProc.Status)));
  //tmpServiceStatus.dwWaitHint := FWaitHint;
  FillChar(tmpServiceStatus, SizeOf(tmpServiceStatus), 0);
  tmpServiceStatus.dwServiceType := GetNTServiceType(AServiceProc);
  if csStartPending = AServiceProc.Status then
    tmpServiceStatus.dwControlsAccepted := 0
  else
    tmpServiceStatus.dwControlsAccepted := GetNTControlsAccepted;
  if (AServiceProc.Status in PendingStatus) {and (AServiceProc.Status = LastStatus)} then
    Inc(tmpServiceStatus.dwCheckPoint)
  else
    tmpServiceStatus.dwCheckPoint := 0;

  //LastStatus := AServiceProc.Status;
  tmpServiceStatus.dwCurrentState := NTServiceStatus[AServiceProc.Status];
  //tmpServiceStatus.dwWin32ExitCode := Win32ErrCode;
  //tmpServiceStatus.dwServiceSpecificExitCode := ErrCode;
  //if ErrCode <> 0 then
    tmpServiceStatus.dwWin32ExitCode := 0;//ERROR_SERVICE_SPECIFIC_ERROR;
      
  if not SetServiceStatus(AServiceProc.StatusHandle, tmpServiceStatus) then
  begin
    Log('win.service.pas', 'ReportServiceStatus fail');
  end else
  begin
    Log('win.service.pas', 'ReportServiceStatus succ');
  end;
end;

end.
