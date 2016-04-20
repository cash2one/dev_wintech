unit BaseWinProcess;

interface
       
uses
  Windows, Sysutils;
  
type
  POwnProcess     = ^TOwnProcess;
  PExProcess      = ^TExProcess;
  PRunProcess     = ^TRunProcess;
  PCoreProcess    = ^TCoreProcess;
  
  TCoreProcess    = record
    ProcessHandle : THandle;
    ProcessId     : DWORD;
  end;
  
  { 自身运行进程控制 }
  TOwnProcess     = record
    Core          : TCoreProcess;
    Run           : PRunProcess;
  end;

  { 外部进程控制 }
  TExProcess      = record
    Core          : TCoreProcess;
  end;

  TRunProcess     = record
    ProcessInfo   : TProcessInformation;
    StartInfoA    : TStartupInfoA;
    StartInfoW    : TStartupInfoW;
  end;


  procedure RunProcessA(AProcess: POwnProcess; AExeFileUrl: AnsiString; ARunProcess: PRunProcess = nil); overload;
  //procedure RunProcessA(AProcess: POwnProcess; ARunProcess: PRunProcess = nil); overload;

  function CheckOutOwnProcess: POwnProcess;
  procedure CheckInOwnProcess(var AProcess: POwnProcess);

  function CheckOutRunProcess: PRunProcess;
  procedure CheckInRunProcess(var ARunProcess: PRunProcess);
                                                             
  function EnabledDebugPrivilege(const AIsEnabled: Boolean; AProcessHandle: THandle = 0):Boolean;
  function InjectDll(AExProcess: PExProcess; ADllUrl: AnsiString): Cardinal;
  function EjectDll(AExProcess: PExProcess; ADllUrl: AnsiString): Cardinal;

implementation

uses
  BaseMemory;
  
function CheckOutOwnProcess: POwnProcess;
begin
  Result := GetMemory(nil, SizeOf(TOwnProcess));
  if nil <> Result then
  begin
    FillChar(Result^, SizeOf(TOwnProcess), 0);
  end;
end;

procedure CheckInOwnProcess(var AProcess: POwnProcess);
begin                       
end;
                   
function CheckOutExProcess: PExProcess;
begin               
  Result := GetMemory(nil, SizeOf(TExProcess));
  if nil <> Result then
  begin
    FillChar(Result^, SizeOf(TExProcess), 0);
  end;
end;

procedure CheckInExProcess(var AProcess: PExProcess);
begin                       
end;

function CheckOutRunProcess: PRunProcess;
begin
  Result := System.New(PRunProcess);
  FillChar(Result^, SizeOf(TRunProcess), 0);
end;

procedure CheckInRunProcess(var ARunProcess: PRunProcess);
begin
end;

procedure RunProcessA(AProcess: POwnProcess; AExeFileUrl: AnsiString; ARunProcess: PRunProcess = nil);
begin
  AProcess.Run := ARunProcess;
  if nil = AProcess.Run then
  begin
    AProcess.Run := System.New(PRunProcess);
    FillChar(AProcess.Run^, SizeOf(TRunProcess), 0);
  end;
  if Windows.CreateProcessA(
      PAnsiChar(AExeFileUrl), //lpApplicationName: PAnsiChar;
      nil, //lpCommandLine: PAnsiChar;
      nil, //lpProcessAttributes,
      nil, //lpThreadAttributes: PSecurityAttributes;
      false, //bInheritHandles: BOOL;
      CREATE_NEW, //dwCreationFlags: DWORD;
      nil, //lpEnvironment: Pointer;
      nil, //lpCurrentDirectory: PAnsiChar;
      AProcess.Run.StartInfoA, //const lpStartupInfo: TStartupInfoA;
      AProcess.Run.ProcessInfo) //var lpProcessInformation: TProcessInformation
      then
  begin
    AProcess.Core.ProcessHandle := AProcess.Run.ProcessInfo.hProcess;
    AProcess.Core.ProcessId := AProcess.Run.ProcessInfo.dwProcessId;
  end;
end;

function EnabledDebugPrivilege(const AIsEnabled: Boolean; AProcessHandle: THandle = 0):Boolean;
var
  tmpProcessHandle: THandle;
  tmpToken: THandle;
  tmpTokenPrivileges: TOKEN_PRIVILEGES;
  tmpReturnLen: DWORD;
const
  SE_DEBUG_NAME = 'SeDebugPrivilege';                      
begin
  Result:=False;
  tmpProcessHandle := AProcessHandle;
  if 0 = tmpProcessHandle then
    tmpProcessHandle := GetCurrentProcess();
  if (Windows.OpenProcessToken(tmpProcessHandle, TOKEN_ADJUST_PRIVILEGES, tmpToken)) then
  begin
    tmpTokenPrivileges.PrivilegeCount :=1;
    Windows.LookupPrivilegeValue(nil,SE_DEBUG_NAME ,tmpTokenPrivileges.Privileges[0].Luid);
    if AIsEnabled then
      tmpTokenPrivileges.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
    else
      tmpTokenPrivileges.Privileges[0].Attributes := 0;
    tmpReturnLen := 0;
    Windows.AdjustTokenPrivileges(tmpToken,
        False,
        tmpTokenPrivileges,
        SizeOf(tmpTokenPrivileges),
        nil,
        tmpReturnLen);
    Result:= Windows.GetLastError = ERROR_SUCCESS;
    Windows.CloseHandle(tmpToken);
  end;
end;

function InjectDll(AExProcess: PExProcess; ADllUrl: AnsiString): Cardinal;
var
  tmpDllPath: PWideChar;
  tmpRemoteMemory: Pointer;
  tmpSize: Cardinal;
  tmpThreadID: Cardinal;
  tmpBytesWrite: Cardinal;
begin
  result := 0;                                
  if nil = AExProcess then
    exit;
  if (0 = AExProcess.Core.ProcessID) and
     (0 = AExProcess.Core.ProcessHandle) then
    exit;
  if 0 = AExProcess.Core.ProcessHandle then
    AExProcess.Core.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, false, AExProcess.Core.ProcessID);
  if 0 <> AExProcess.Core.ProcessHandle then
  begin
    // 提升自己的权限        
    EnabledDebugPrivilege(true);//AExProcess.Core.ProcessHandle);

    tmpSize:= Length(ADllUrl) * 2 + 21;
    GetMem(tmpDllPath, tmpSize);
    try                       
      FillChar(tmpDllPath^, tmpSize, 0);   
      StringToWideChar(ADllUrl, tmpDllPath, tmpSize);

      tmpRemoteMemory := VirtualAllocEx(AExProcess.Core.ProcessHandle, nil, tmpSize, MEM_COMMIT, PAGE_READWRITE);
      tmpBytesWrite := 0;
      if WriteProcessMemory(AExProcess.Core.ProcessHandle, tmpRemoteMemory, tmpDllPath, tmpSize, tmpBytesWrite) then
      begin
        tmpThreadID := 0;
        Result := CreateRemoteThread(AExProcess.Core.ProcessHandle, nil, 0,
            GetProcAddress(GetModuleHandle('Kernel32'), 'LoadLibraryW'),
            tmpRemoteMemory,
            0,
            tmpThreadID);  
      end;
    finally
      CloseHandle(AExProcess.Core.ProcessHandle);
      AExProcess.Core.ProcessHandle := 0;
      FreeMem(tmpDllPath);
    end;
  end;
end;
                 
var
  AsmBuf: array [0..20] of Byte = ($B8,$00,$00,$00,$00,$68,$00,$00,$00,$00,$FF,$D0,$B8,$00,$00,$00,00,$6A,$00,$FF,$D0);

function EjectDll(AExProcess: PExProcess; ADllUrl: AnsiString): Cardinal;
type
  PDebugModule        = ^TDebugModule;
  TDebugModule        = packed record
    Reserved          : array [0..1] of Cardinal;
    Base              : Cardinal;
    Size              : Cardinal;
    Flags             : Cardinal;
    Index             : Word;
    Unknown           : Word;
    LoadCount         : Word;
    ModuleNameOffset  : Word;
    ImageName         : array [0..$FF] of AnsiChar;
  end;

  PDebugModuleInformation = ^TDebugModuleInformation;
  TDebugModuleInformation = record
    Count             : Cardinal;
    Modules           : array [0..0] of TDebugModule;
  end;

  PDebugBuffer        = ^TDebugBuffer;
  TDebugBuffer        = record
    SectionHandle     : THandle;
    SectionBase       : Pointer;
    RemoteSectionBase : Pointer;
    SectionBaseDelta  : Cardinal;
    EventPairHandle   : THandle;
    Unknown           : array [0..1] of Cardinal;
    RemoteThreadHandle: THandle;
    InfoClassMask     : Cardinal;
    SizeOfInfo        : Cardinal;
    AllocatedSize     : Cardinal;
    SectionSize       : Cardinal;
    ModuleInformation : PDebugModuleInformation;
    BackTraceInformation: Pointer;
    HeapInformation   : Pointer;
    LockInformation   : Pointer;
    Reserved          : array [0..7] of Pointer;
  end;
  
  TFNRtlCreateQueryDebugBuffer = function(Size: Cardinal;EventPair: Boolean): PDebugBuffer;stdcall;
  TFNRtlQueryProcessDebugInformation = function(ProcessId, DebugInfoClassMask: Cardinal; var DebugBuffer: TDebugBuffer): Integer;stdcall;
  TFNRtlDestroyQueryDebugBuffer = function(DebugBuffer: PDebugBuffer): Integer;stdcall;
const
  PDI_MODULES = $01;
  ntdll = 'ntdll.dll';
var
  tmpModule_NTDLL: HMODULE;
  RtlCreateQueryDebugBuffer: TFNRtlCreateQueryDebugBuffer;
  RtlQueryProcessDebugInformation: TFNRtlQueryProcessDebugInformation;
  RtlDestroyQueryDebugBuffer: TFNRtlDestroyQueryDebugBuffer;

  function LoadRtlQueryDebug: LongBool;
  begin
    tmpModule_NTDLL := LoadLibrary(ntdll);
    if tmpModule_NTDLL <> 0 then
    begin
      RtlCreateQueryDebugBuffer := GetProcAddress(tmpModule_NTDLL, 'RtlCreateQueryDebugBuffer');
      RtlQueryProcessDebugInformation := GetProcAddress(tmpModule_NTDLL, 'RtlQueryProcessDebugInformation');
      RtlDestroyQueryDebugBuffer := GetProcAddress(tmpModule_NTDLL, 'RtlDestroyQueryDebugBuffer');
    end;
    Result :=
      Assigned(RtlCreateQueryDebugBuffer) and
      Assigned(RtlQueryProcessDebugInformation) and
      Assigned(RtlQueryProcessDebugInformation);
  end;

  function ReleaseRtlQueryDebug: LongBool;
  begin
    result := FreeLibrary(tmpModule_NTDLL);
  end;

var
  tmpProcessHandle: Cardinal;
  tmpBaseModuleAddress: Cardinal;
  tmpThreadID: Cardinal;
  tmpBytesWrite: Cardinal;
  tmpDebugBuffer: PDebugBuffer;
  i: integer;
  tmpLoadCount: integer;
  tmpRemoteFuncProc: Pointer;
  tmpAddress: Cardinal;   
  pd: PDWORD;
begin
  result := 0;
  if nil = AExProcess then
    exit;
  if 0 = AExProcess.Core.ProcessId then
    exit;
  // 提升自身权限
  EnabledDebugPrivilege(true);
  LoadRtlQueryDebug;
  tmpLoadCount := 0;
  tmpDebugBuffer := RtlCreateQueryDebugBuffer(0, False);
  tmpBaseModuleAddress := 0;
  if Assigned(tmpDebugBuffer) then
  begin
    try
      if RtlQueryProcessDebugInformation(AExProcess.core.ProcessID, PDI_MODULES, tmpDebugBuffer^) >= 0 then
      begin
        for i:=0 to tmpDebugBuffer.ModuleInformation.Count-1 do
        begin
          if UpperCase(tmpDebugBuffer.ModuleInformation.Modules[i].ImageName) = UpperCase(ADllUrl) then
          begin
            tmpBaseModuleAddress := tmpDebugBuffer.ModuleInformation.Modules[i].Base;
            tmpLoadCount := tmpDebugBuffer.ModuleInformation.Modules[i].LoadCount;
            Break;
          end;
        end;
      end;
    finally
      RtlDestroyQueryDebugBuffer(tmpDebugBuffer);
      ReleaseRtlQueryDebug;
    end;
  end;
  tmpProcessHandle := OpenProcess(PROCESS_ALL_ACCESS, false, AExProcess.Core.ProcessID);
  try
    tmpAddress := DWORD(GetProcAddress(GetModuleHandle('Kernel32'),'FreeLibrary'));
    pd := @AsmBuf[1];
    pd^ := tmpAddress;

    pd:=@AsmBuf[6];
    pd^ := tmpBaseModuleAddress;

    tmpAddress:=DWORD(GetProcAddress(GetModuleHandle('Kernel32'),'ExitThread'));
    pd:=@AsmBuf[13];
    pd^:=tmpAddress;
    
    tmpRemoteFuncProc := Windows.VirtualAllocEx(tmpProcessHandle, nil, 21, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    if WriteProcessMemory(tmpProcessHandle, tmpRemoteFuncProc, @AsmBuf[0], 21, tmpBytesWrite) then
    for i:=0 to tmpLoadCount - 1 do
    begin
      tmpThreadID := 0;
      Result := CreateRemoteThread(tmpProcessHandle, nil, 0, tmpRemoteFuncProc, nil, 0, tmpThreadID);
    end;
  finally
    CloseHandle(tmpProcessHandle);
  end;
end;
          
end.
