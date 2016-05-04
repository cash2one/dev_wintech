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

  TServiceTableEntryArray = array[0..1] of TServiceTableEntryW;
                             
  TServiceController = procedure(CtrlCode: DWord); stdcall;
  
  TWinServiceStart  = record
    ThreadHandle    : THandle;   
    ThreadId        : DWord;    
    ServiceStartTableLen: integer;
    ServiceStartTable: TServiceTableEntryArray;
    ServiceStartErrorCode: integer;    
  end;

  PWinServiceW  = ^TWinServiceW;
  TWinServiceW  = record
    StatusHandle    : THandle;
    ThreadHandle    : THandle;  
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
                                  
    App             : PWinApp;
    ServiceStart    : TWinServiceStart;
    Name            : array[0..32 - 1] of WideChar;
  end;

  function GetNTServiceType(AWinService: PWinServiceW): Integer;
  function GetNTStartType(AWinService: PWinServiceW): Integer;   
  function GetNTErrorSeverity(AWinService: PWinServiceW): Integer;  
  function GetNTDependenciesW(AWinService: PWinServiceW): WideString;  
  function GetNTControlsAccepted: Integer;
                                   
  procedure RunWinService(AWinService: PWinServiceW);
  procedure ReportServiceStatus(AWinService: PWinServiceW);  

const
  CM_SERVICE_CONTROL_CODE = WM_USER + 1;
                        
var
  GlobalService: TWinServiceW;

implementation

uses
  SysUtils,
  UtilsLog;
 
function GetNTServiceType(AWinService: PWinServiceW): Integer;
const
  NTServiceType: array[TServiceType] of Integer = (
    SERVICE_WIN32_OWN_PROCESS,
    SERVICE_KERNEL_DRIVER,
    SERVICE_FILE_SYSTEM_DRIVER);
begin
  Result := NTServiceType[AWinService.ServiceType];
  if (AWinService.ServiceType = stWin32) and AWinService.IsInteractive then
    Result := Result or SERVICE_INTERACTIVE_PROCESS;
//  if (AServiceProc.ServiceType = stWin32) {and (Application.ServiceCount > 1)} then
//    Result := (Result xor SERVICE_WIN32_OWN_PROCESS) or SERVICE_WIN32_SHARE_PROCESS;
end;
                  
function GetNTStartType(AWinService: PWinServiceW): Integer;
const
  NTStartType: array[TStartType] of Integer = (
    SERVICE_BOOT_START,
    SERVICE_SYSTEM_START,
    SERVICE_AUTO_START,
    SERVICE_DEMAND_START,
    SERVICE_DISABLED);
begin
  Result := NTStartType[AWinService.StartType];
  if (AWinService.StartType in [stBoot, stSystem]) and (AWinService.ServiceType <> stDevice) then
    Result := SERVICE_AUTO_START;
end;
                  
function GetNTErrorSeverity(AWinService: PWinServiceW): Integer;
const
  NTErrorSeverity: array[TErrorSeverity] of Integer = (SERVICE_ERROR_IGNORE,
    SERVICE_ERROR_NORMAL, SERVICE_ERROR_SEVERE, SERVICE_ERROR_CRITICAL);
begin
  Result := NTErrorSeverity[AWinService.ErrorSeverity];
end;
                  
function GetNTDependenciesW(AWinService: PWinServiceW): WideString;
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

function ServiceThreadProc(AWinService: PWinServiceW): HRESULT; stdcall; 
var
  tmpMsg: TMsg;
  tmpIsRet: Boolean;
begin
  Result := 0;    
  Log('', 'ServiceThreadProc begin');
  Windows.PeekMessage(tmpMsg, 0, WM_USER, WM_USER, PM_NOREMOVE); { Create message queue }

  
  AWinService.Status := csStartPending;
  ReportServiceStatus(AWinService);
                                
  AWinService.Status := csRunning;  
  ReportServiceStatus(AWinService);
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
            AWinService.Status := csStopPending; 
            ReportServiceStatus(AWinService);
            Break;
          end;
          SERVICE_CONTROL_PAUSE: begin
            //ActionOK := FService.DoPause;   
            AWinService.Status := csPaused;
          end;
          SERVICE_CONTROL_CONTINUE: begin
            //ActionOK := FService.DoContinue;  
            AWinService.Status := csRunning;
          end;
          SERVICE_CONTROL_SHUTDOWN: begin
            //FService.DoShutDown;        
            AWinService.Status := csStopPending;
          end;
          SERVICE_CONTROL_INTERROGATE: begin
            //FService.DoInterrogate;       
          end;
        end;
        ReportServiceStatus(AWinService);
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
              AWinService.Status := csStopPending;
            end;
            SERVICE_CONTROL_PAUSE: begin
              //ActionOK := FService.DoPause;   
              AWinService.Status := csPaused;
            end;
            SERVICE_CONTROL_CONTINUE: begin
              //ActionOK := FService.DoContinue;  
              AWinService.Status := csRunning;
            end;
            SERVICE_CONTROL_SHUTDOWN: begin
              //FService.DoShutDown;        
              AWinService.Status := csStopPending;
            end;
            SERVICE_CONTROL_INTERROGATE: begin
              //FService.DoInterrogate;       
            end;
          end;
          ReportServiceStatus(AWinService);
        end else
          DispatchMessage(tmpMsg);
      end else
        DispatchMessage(tmpMsg);
    end;
  end;                     
  Log('', 'ServiceThreadProc end');   
  ExitThread(Result);
end;

procedure ServiceControllerProc(CtrlCode: DWORD); stdcall;
begin
  PostThreadMessage(GlobalService.ThreadID, CM_SERVICE_CONTROL_CODE, CtrlCode, 0);
end;

procedure StartServiceProc(AWinService: PWinServiceW);
var
  WaitThread: array[0..1] of THandle;
begin
  Log('win.service.pas', 'StartServiceProc begin');
                                      
  Log('win.service.pas', 'StartServiceProc run');
  AWinService.StatusHandle := WinSvc.RegisterServiceCtrlHandlerW(PWideChar(@AWinService.Name[0]), @ServiceControllerProc);
  // DoStart
  AWinService.ThreadHandle := Windows.CreateThread(
    nil, //lpThreadAttributes: Pointer;
    0, //dwStackSize: DWORD;
    @ServiceThreadProc, //lpStartAddress: TFNThreadStartRoutine;
    AWinService, //lpParameter: Pointer;
    Create_Suspended, // dwCreationFlags: DWORD;
    AWinService.ThreadId); // var lpThreadId: DWORD);
  ResumeThread(AWinService.ThreadHandle);

  WaitThread[0] := AWinService.ThreadHandle;
  WaitThread[1] := 0;
  Windows.WaitForSingleObject(WaitThread[0], INFINITE);  

  Windows.Sleep(100);
  Windows.CloseHandle(AWinService.ThreadHandle);
    
  AWinService.Status := csStopped;
  ReportServiceStatus(AWinService);    
  // exit application
  //PostQuitMessage(0);
  Sleep(100);
  Log('win.service.pas', 'StartServiceProc end'); 
  if nil <> AWinService.App then
  begin
    AWinService.App.IsTerminated := True;
  end;
  Windows.TerminateProcess(GetCurrentProcess, 0);  
end;

procedure ServiceMain(Argc: DWord; Argv: PLPSTR); stdcall;
begin                   
  Log('win.service.pas', 'ServiceMain begin' + IntToStr(Argc));
  //Application.DispatchServiceMain(Argc, Argv);
  StartServiceProc(@GlobalService);
  Log('win.service.pas', 'ServiceMain end');  
end;

function ServiceStartThreadProc(AWinService: PWinServiceW): HResult; stdcall;
begin
  Result := 0;       
  Log('win.service.pas', 'ServiceStartThreadProc begin');
  if WinSvc.StartServiceCtrlDispatcherW(AWinService.ServiceStart.ServiceStartTable[0]) then
  begin
    AWinService.ServiceStart.ServiceStartErrorCode := 0;
  end else
  begin
    AWinService.ServiceStart.ServiceStartErrorCode := GetLastError;     
    Log('win.service.pas', 'ServiceStartThreadProc last error:' + IntToStr(AWinService.ServiceStart.ServiceStartErrorCode));
  end;
  ExitThread(Result);                
  Log('win.service.pas', 'ServiceStartThreadProc end');
end;

procedure RunWinService(AWinService: PWinServiceW);
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
  AWinService.ServiceStart.ServiceStartTable[0].lpServiceName := @GlobalService.Name[0];
  AWinService.ServiceStart.ServiceStartTable[0].lpServiceProc := @ServiceMain;

  AWinService.ServiceStart.ThreadHandle := Windows.CreateThread(
    nil, //lpThreadAttributes: Pointer;
    0, //dwStackSize: DWORD;
    @ServiceStartThreadProc, // lpStartAddress: TFNThreadStartRoutine;
    AWinService, //lpParameter: Pointer;
    CREATE_SUSPENDED, //dwCreationFlags: DWORD;
    AWinService.ServiceStart.ThreadId); //var lpThreadId: DWORD);
  Windows.ResumeThread(AWinService.ServiceStart.ThreadHandle);
  
  // App Run
  AWinService.App.IsTerminated := false;
  while not AWinService.App.IsTerminated do
  begin
    // ProcessMessage
    if Windows.PeekMessage(AWinService.App.AppMsg, 0, 0, 0, PM_NOREMOVE) then
    begin                 
      tmpIsUnicode := (AWinService.App.AppMsg.hwnd <> 0) and IsWindowUnicode(AWinService.App.AppMsg.hwnd);
      if tmpIsUnicode then
        tmpIsMsgExists := PeekMessageW(AWinService.App.AppMsg, 0, 0, 0, PM_REMOVE)
      else
        tmpIsMsgExists := PeekMessage(AWinService.App.AppMsg, 0, 0, 0, PM_REMOVE);
      if tmpIsMsgExists then
      begin
        if AWinService.App.AppMsg.Message <> Messages.WM_QUIT then
        begin
          TranslateMessage(AWinService.App.AppMsg);
          if tmpIsUnicode then
            DispatchMessageW(AWinService.App.AppMsg)
          else
            DispatchMessageA(AWinService.App.AppMsg);
        end else
        begin
          AWinService.App.IsTerminated := True;
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

procedure ReportServiceStatus(AWinService: PWinServiceW);
const
  NTServiceStatus: array[TCurrentStatus] of Integer = (SERVICE_STOPPED,
    SERVICE_START_PENDING, SERVICE_STOP_PENDING, SERVICE_RUNNING,
    SERVICE_CONTINUE_PENDING, SERVICE_PAUSE_PENDING, SERVICE_PAUSED);
  PendingStatus: set of TCurrentStatus = [csStartPending, csStopPending,
    csContinuePending, csPausePending];  
var
  tmpServiceStatus: TServiceStatus;
begin          
  Log('win.service.pas', 'ReportServiceStatus:' + IntToStr(Integer(AWinService.Status)));
  //tmpServiceStatus.dwWaitHint := FWaitHint;
  FillChar(tmpServiceStatus, SizeOf(tmpServiceStatus), 0);
  tmpServiceStatus.dwServiceType := GetNTServiceType(AWinService);
  if csStartPending = AWinService.Status then
    tmpServiceStatus.dwControlsAccepted := 0
  else
    tmpServiceStatus.dwControlsAccepted := GetNTControlsAccepted;
  if (AWinService.Status in PendingStatus) {and (AServiceProc.Status = LastStatus)} then
    Inc(tmpServiceStatus.dwCheckPoint)
  else
    tmpServiceStatus.dwCheckPoint := 0;

  //LastStatus := AServiceProc.Status;
  tmpServiceStatus.dwCurrentState := NTServiceStatus[AWinService.Status];
  //tmpServiceStatus.dwWin32ExitCode := Win32ErrCode;
  //tmpServiceStatus.dwServiceSpecificExitCode := ErrCode;
  //if ErrCode <> 0 then
    tmpServiceStatus.dwWin32ExitCode := 0;//ERROR_SERVICE_SPECIFIC_ERROR;
      
  if not SetServiceStatus(AWinService.StatusHandle, tmpServiceStatus) then
  begin
    Log('win.service.pas', 'ReportServiceStatus fail');
  end else
  begin
    Log('win.service.pas', 'ReportServiceStatus succ');
  end;
end;

end.
