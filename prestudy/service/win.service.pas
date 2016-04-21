unit win.service;

interface
 
uses
  Types,
  Windows,
  WinSvc,
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
  end;

  PWinServiceProcW  = ^TWinServiceProcW;
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
    Name            : WideString;
    DisplayName     : WideString;
    Password        : WideString;
    LoadGroup       : WideString;
    ServiceStartName: WideString;
  end;

  PWinServiceAppW   = ^TWinServiceAppW;
  TWinServiceAppW   = record
    App             : PWinApp;
    LastError       : DWORD;

    ServiceStart    : TWinServiceStart;
  end;
         
  function GetNTServiceType(AServiceProc: PWinServiceProcW): Integer;
  function GetNTStartType(AServiceProc: PWinServiceProcW): Integer;   
  function GetNTErrorSeverity(AServiceProc: PWinServiceProcW): Integer;  
  function GetNTDependenciesW(AServiceProc: PWinServiceProcW): WideString;
                                      
  procedure InstallWinService(AServiceApp: PWinServiceAppW; AServiceProc: PWinServiceProcW); overload;
  procedure InstallWinService(AServiceProc: PWinServiceProcW; ASvcMgr: Integer); overload;

  procedure UninstallWinService(AServiceApp: PWinServiceAppW); overload;
  procedure UninstallWinService(AServiceProc: PWinServiceProcW; ASvcMgr: Integer); overload;
   
  procedure RunWinService(AServiceApp: PWinServiceAppW);
  procedure ReportServiceStatus(AServiceProc: PWinServiceProcW);  

implementation
      
function GetNTServiceType(AServiceProc: PWinServiceProcW): Integer;
const
  NTServiceType: array[TServiceType] of Integer = ( SERVICE_WIN32_OWN_PROCESS,
    SERVICE_KERNEL_DRIVER, SERVICE_FILE_SYSTEM_DRIVER);
begin
  Result := NTServiceType[AServiceProc.ServiceType];
  if (AServiceProc.ServiceType = stWin32) and AServiceProc.IsInteractive then
    Result := Result or SERVICE_INTERACTIVE_PROCESS;
  if (AServiceProc.ServiceType = stWin32) {and (Application.ServiceCount > 1)} then
    Result := (Result xor SERVICE_WIN32_OWN_PROCESS) or SERVICE_WIN32_SHARE_PROCESS;
end;
                  
function GetNTStartType(AServiceProc: PWinServiceProcW): Integer;
const
  NTStartType: array[TStartType] of Integer = (SERVICE_BOOT_START,
    SERVICE_SYSTEM_START, SERVICE_AUTO_START, SERVICE_DEMAND_START,
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
begin              
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

    AServiceProc.ServiceHandle := WinSvc.CreateServiceW(ASvcMgr,
          PWideChar(AServiceProc.Name),
          PWideChar(AServiceProc.DisplayName),
          SERVICE_ALL_ACCESS,
          GetNTServiceType(AServiceProc),
          GetNTStartType(AServiceProc),
          GetNTErrorSeverity(AServiceProc),
          PWideChar(tmpPath),
          PWideChar(AServiceProc.LoadGroup),
          tmpPTag,
          nil, //PWideChar(GetNTDependenciesW(AWinService)),
          tmpPSSN,
          nil //PWideChar(AServiceProc.Password)
          );
    if 0 = AServiceProc.ServiceHandle then
    begin
      AServiceProc.LastError := Windows.GetLastError;
      if 0 <> AServiceProc.LastError then
      begin
        if ERROR_INVALID_SERVICE_ACCOUNT = AServiceProc.LastError then// 1057
        begin
        end;
      end;
    end else
    begin
      WinSvc.CloseServiceHandle(AServiceProc.ServiceHandle);
    end;
end;

procedure InstallWinService(AServiceApp: PWinServiceAppW; AServiceProc: PWinServiceProcW);
var
  tmpSvcMgr: integer;
begin
  tmpSvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  try
    InstallWinService(AServiceProc, tmpSvcMgr);
  finally
    CloseServiceHandle(tmpSvcMgr);
  end;   
end;

procedure UninstallWinService(AServiceProc: PWinServiceProcW; ASvcMgr: Integer);
begin
  AServiceProc.ServiceHandle := OpenServiceW(ASvcMgr, PWideChar(AServiceProc.Name), SERVICE_ALL_ACCESS);
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
end;

procedure UninstallWinService(AServiceApp: PWinServiceAppW);
var
  tmpSvcMgr: Integer;
begin          
  tmpSvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  try
    UninstallWinService(nil, tmpSvcMgr);
  finally
    WinSvc.CloseServiceHandle(tmpSvcMgr);
  end;
end;                                                 
                     
procedure StartServiceProc(AServiceProc: PWinServiceProcW);
begin
  if nil <> @AServiceProc.Controller then
  begin
    AServiceProc.StatusHandle := WinSvc.RegisterServiceCtrlHandlerW(PWideChar(AServiceProc.Name), @AServiceProc.Controller);
    // DoStart
    AServiceProc.ThreadHandle := Windows.CreateThread(
      nil, //lpThreadAttributes: Pointer;
      0, //dwStackSize: DWORD;
      nil, //lpStartAddress: TFNThreadStartRoutine;
      AServiceProc, //lpParameter: Pointer;
      Create_Suspended, // dwCreationFlags: DWORD;
      AServiceProc.ThreadId); // var lpThreadId: DWORD);
    ResumeThread(AServiceProc.ThreadHandle);
  end;
end;

procedure ServiceMain(Argc: DWord; Argv: PLPSTR); stdcall;
var
  tmpServiceProc: PWinServiceProcW;  
  tmpServiceProcIndex: integer;
  tmpServiceProcCount: integer;
begin
  //Application.DispatchServiceMain(Argc, Argv);
  tmpServiceProc := nil;  
  tmpServiceProcCount := 0;
  for tmpServiceProcIndex := 0 to tmpServiceProcCount - 1 do
  begin
    StartServiceProc(tmpServiceProc);
  end;
end;

function ServiceStartThreadProc(AServiceApp: PWinServiceAppW): HResult; stdcall;
begin
  Result := 0;
  WinSvc.StartServiceCtrlDispatcherW(AServiceApp.ServiceStart.ServiceStartTable[0]);
  ExitThread(Result);
end;

procedure RunWinService(AServiceApp: PWinServiceAppW);
var
  i: integer;
begin
  //AWinService.
  //while not AWinService.IsTerminated do
  //StartThread: TServiceStartThread;
//  for i := Low(AWinServiceApp.ServiceStart.ServiceStartTable) to High(AWinServiceApp.ServiceStart.ServiceStartTable) do
//  begin
//    AWinServiceApp.ServiceStart.ServiceStartTable[i].lpServiceName := 'testsrv' + IntToStr();
//    AWinServiceApp.ServiceStart.ServiceStartTable[i].lpServiceProc := @ServiceMain;
//  end;
  AServiceApp.ServiceStart.ServiceStartTable[0].lpServiceName := 'testsrv_start0';
  AServiceApp.ServiceStart.ServiceStartTable[0].lpServiceProc := @ServiceMain;

  AServiceApp.ServiceStart.ThreadHandle := Windows.CreateThread(
    nil, //lpThreadAttributes: Pointer;
    0, //dwStackSize: DWORD;
    @ServiceStartThreadProc, // lpStartAddress: TFNThreadStartRoutine;
    AServiceApp, //lpParameter: Pointer;
    CREATE_SUSPENDED, //dwCreationFlags: DWORD;
    AServiceApp.ServiceStart.ThreadId); //var lpThreadId: DWORD);
  Windows.ResumeThread(AServiceApp.ServiceStart.ThreadHandle);
  begin
    if Windows.PeekMessage(AServiceApp.App.AppMsg, 0, 0, 0, PM_NOREMOVE) then
    begin
    end;
  end;
end;
                 
function GetNTControlsAccepted: Integer;
begin
  Result := SERVICE_ACCEPT_SHUTDOWN;
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
  //tmpServiceStatus.dwWaitHint := FWaitHint;
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
    tmpServiceStatus.dwWin32ExitCode := ERROR_SERVICE_SPECIFIC_ERROR;
      
  if not SetServiceStatus(AServiceProc.StatusHandle, tmpServiceStatus) then
  begin
  
  end;
end;

end.
