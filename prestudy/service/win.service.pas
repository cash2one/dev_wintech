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
    ThreadId        : DWord;
    Name            : WideString;
  end;

  PWinServiceAppW   = ^TWinServiceAppW;
  TWinServiceAppW   = record
    ServiceHandle   : THandle;
    TagID           : DWord;
    App             : PWinApp;

    ServiceStart    : TWinServiceStart;
        
    ServiceType     : TServiceType;
    StartType       : TStartType;
    ErrorSeverity   : TErrorSeverity;
    Interactive     : Boolean;
    Name            : WideString;
    DisplayName     : WideString;
    Password        : WideString;
    LoadGroup       : WideString;
    ServiceStartName: WideString;
  end;
         
  function GetNTServiceType(AWinService: PWinServiceAppW): Integer;    
  function GetNTStartType(AWinService: PWinServiceAppW): Integer;   
  function GetNTErrorSeverity(AWinService: PWinServiceAppW): Integer;  
  function GetNTDependenciesW(AWinService: PWinServiceAppW): WideString;
                                      
  procedure InstallWinService(AWinService: PWinServiceAppW);   
  procedure UninstallWinService(AWinService: PWinServiceAppW);    
  procedure RunWinService(AWinService: PWinServiceAppW);  

implementation
      
function GetNTServiceType(AWinService: PWinServiceAppW): Integer;
const
  NTServiceType: array[TServiceType] of Integer = ( SERVICE_WIN32_OWN_PROCESS,
    SERVICE_KERNEL_DRIVER, SERVICE_FILE_SYSTEM_DRIVER);
begin
  Result := NTServiceType[AWinService.ServiceType];
  if (AWinService.ServiceType = stWin32) and AWinService.Interactive then
    Result := Result or SERVICE_INTERACTIVE_PROCESS;
  if (AWinService.ServiceType = stWin32) {and (Application.ServiceCount > 1)} then
    Result := (Result xor SERVICE_WIN32_OWN_PROCESS) or SERVICE_WIN32_SHARE_PROCESS;
end;
                  
function GetNTStartType(AWinService: PWinServiceAppW): Integer;
const
  NTStartType: array[TStartType] of Integer = (SERVICE_BOOT_START,
    SERVICE_SYSTEM_START, SERVICE_AUTO_START, SERVICE_DEMAND_START,
    SERVICE_DISABLED);
begin
  Result := NTStartType[AWinService.StartType];
  if (AWinService.StartType in [stBoot, stSystem]) and (AWinService.ServiceType <> stDevice) then
    Result := SERVICE_AUTO_START;
end;
                  
function GetNTErrorSeverity(AWinService: PWinServiceAppW): Integer;
const
  NTErrorSeverity: array[TErrorSeverity] of Integer = (SERVICE_ERROR_IGNORE,
    SERVICE_ERROR_NORMAL, SERVICE_ERROR_SEVERE, SERVICE_ERROR_CRITICAL);
begin
  Result := NTErrorSeverity[AWinService.ErrorSeverity];
end;
                  
function GetNTDependenciesW(AWinService: PWinServiceAppW): WideString;
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

procedure InstallWinService(AWinService: PWinServiceAppW);
var
  SvcMgr: Integer;
  tmpPath: WideString;
  tmpPSSN: PWideChar;  
  tmpTagID: Integer;
  tmpPTag: Pointer;
begin              
  tmpPath := ParamStr(0);
  SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);   
  if AWinService.ServiceStartName = '' then
    tmpPSSN := nil
  else
    tmpPSSN := PWideChar(AWinService.ServiceStartName);
                  
  tmpTagID := AWinService.TagID;
  if tmpTagID > 0 then
    tmpPTag := @tmpTagID
  else
    tmpPTag := nil;

  AWinService.ServiceHandle := WinSvc.CreateServiceW(SvcMgr,
        PWideChar(AWinService.Name),
        PWideChar(AWinService.DisplayName),
        SERVICE_ALL_ACCESS,
        GetNTServiceType(AWinService),
        GetNTStartType(AWinService),
        GetNTErrorSeverity(AWinService),
        PWideChar(tmpPath),
        PWideChar(AWinService.LoadGroup),
        tmpPTag,
        PWideChar(GetNTDependenciesW(AWinService)),
        tmpPSSN,
        PWideChar(AWinService.Password));

end;

procedure UninstallWinService(AWinService: PWinServiceAppW);   
var
  SvcMgr: Integer;
begin          
  SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  AWinService.ServiceHandle := OpenServiceW(SvcMgr, PWideChar(AWinService.Name), SERVICE_ALL_ACCESS);
  if 0 = AWinService.ServiceHandle then
  begin
    //RaiseLastOSError;
  end;
  try
    if not WinSvc.DeleteService(AWinService.ServiceHandle) then
    begin
      //RaiseLastOSError;
    end;
  finally
    WinSvc.CloseServiceHandle(AWinService.ServiceHandle);
  end;
end;                                                 
                     
procedure StartServiceProc(AServiceProc: PWinServiceProcW);
var
  tmpController: TServiceController;
begin
  tmpController := nil;
  if nil <> @tmpController then
  begin
    AServiceProc.StatusHandle := WinSvc.RegisterServiceCtrlHandlerW(PWideChar(AServiceProc.Name), @tmpController);
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

function ServiceStartThreadProc(AWinService: PWinServiceAppW): HResult; stdcall;
begin
  Result := 0;
  WinSvc.StartServiceCtrlDispatcherW(AWinService.ServiceStart.ServiceStartTable[0]);
  ExitThread(Result);
end;

procedure RunWinService(AWinService: PWinServiceAppW);
var
  i: integer;
begin
  //AWinService.
  //while not AWinService.IsTerminated do
  //StartThread: TServiceStartThread;
  for i := Low(AWinService.ServiceStart.ServiceStartTable) to High(AWinService.ServiceStart.ServiceStartTable) do
  begin
    AWinService.ServiceStart.ServiceStartTable[i].lpServiceName := '';
    AWinService.ServiceStart.ServiceStartTable[i].lpServiceProc := @ServiceMain;
  end;

  AWinService.ServiceStart.ThreadHandle := Windows.CreateThread(
    nil, //lpThreadAttributes: Pointer;
    0, //dwStackSize: DWORD;
    @ServiceStartThreadProc, // lpStartAddress: TFNThreadStartRoutine;
    AWinService, //lpParameter: Pointer;
    CREATE_SUSPENDED, //dwCreationFlags: DWORD;
    AWinService.ServiceStart.ThreadId); //var lpThreadId: DWORD);
  Windows.ResumeThread(AWinService.ServiceStart.ThreadHandle);
  begin
    if Windows.PeekMessage(AWinService.App.AppMsg, 0, 0, 0, PM_NOREMOVE) then
    begin
    
    end;
  end;
end;

end.
