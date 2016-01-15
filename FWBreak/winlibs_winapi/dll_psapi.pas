(*
          1    0 00002239 EmptyWorkingSet
          2    1 0000163B EnumDeviceDrivers
          3    2 00004150 EnumPageFilesA
          4    3 00003FE1 EnumPageFilesW
          5    4 00001EF4 EnumProcessModules
          6    5 00003A76 EnumProcesses
          7    6 0000147A GetDeviceDriverBaseNameA
          8    7 00001D9C GetDeviceDriverBaseNameW
          9    8 00001CC5 GetDeviceDriverFileNameA
         10    9 00001D40 GetDeviceDriverFileNameW
         11    A 00001E90 GetMappedFileNameA
         12    B 00001DF8 GetMappedFileNameW
         13    C 00002132 GetModuleBaseNameA
         14    D 000020B5 GetModuleBaseNameW
         15    E 0000204D GetModuleFileNameExA
         16    F 0000176A GetModuleFileNameExW
         17   10 0000219A GetModuleInformation
         18   11 00003E41 GetPerformanceInfo
         19   12 00003DBD GetProcessImageFileNameA
         20   13 00003D2F GetProcessImageFileNameW
         21   14 00003BBD GetProcessMemoryInfo
         22   15 00003CF5 GetWsChanges
         23   16 00003CB1 InitializeProcessForWsWatch
         24   17 000022A4 QueryWorkingSet
*)
unit dll_psapi;

interface

uses
  atmcmbaseconst, wintype;
  
const
  psapi = 'psapi.dll';

type
  TMODULEINFO = packed record
    lpBaseOfDll: Pointer;
    SizeOfImage: DWORD;
    EntryPoint: Pointer;
  end;
  PMODULEINFO = ^TMODULEINFO;
                               
  TPROCESS_MEMORY_COUNTERS = packed record
    cb: DWORD;
    PageFaultCount: DWORD;
    PeakWorkingSetSize: DWORD;
    WorkingSetSize: DWORD;
    QuotaPeakPagedPoolUsage: DWORD;
    QuotaPagedPoolUsage: DWORD;
    QuotaPeakNonPagedPoolUsage: DWORD;
    QuotaNonPagedPoolUsage: DWORD;
    PagefileUsage: DWORD;
    PeakPagefileUsage: DWORD;
  end;
  PPROCESS_MEMORY_COUNTERS = ^TPROCESS_MEMORY_COUNTERS;

  function EnumProcesses(lpidProcess: LPDWORD; cb: DWORD; var cbNeeded: DWORD): BOOL stdcall; external psapi name 'EnumProcesses';
  function EnumProcessModules(hProcess: THandle; lphModule: LPDWORD; cb: DWORD;
    var lpcbNeeded: DWORD): BOOL stdcall; external psapi name 'EnumProcessModules';
  function EnumDeviceDrivers(lpImageBase: PPointer; cb: DWORD;
    var lpcbNeeded: DWORD): BOOL stdcall; external psapi name 'EnumDeviceDrivers';
  
  function GetModuleBaseNameA(hProcess: THandle; hModule: HMODULE;
    lpBaseName: PAnsiChar; nSize: DWORD): DWORD stdcall; external psapi name  'GetModuleBaseNameA';
    
  function GetModuleInformation(hProcess: THandle; hModule: HMODULE;
    lpmodinfo: PMODULEINFO; cb: DWORD): BOOL stdcall; external psapi name 'GetModuleInformation';

  function GetModuleFileNameEx(hProcess: THandle; hModule: HMODULE;
    lpFilename: PAnsiChar; nSize: DWORD): DWORD stdcall; external psapi name 'GetModuleFileNameExA';

  function GetMappedFileName(hProcess: THandle; lpv: Pointer;
  lpFilename: PAnsiChar; nSize: DWORD): DWORD stdcall; external psapi name 'GetMappedFileNameA';
  function GetDeviceDriverBaseName(ImageBase: Pointer; lpBaseName: PAnsiChar;
    nSize: DWORD): DWORD stdcall; external psapi name 'GetDeviceDriverBaseNameA';
  function GetDeviceDriverFileName(ImageBase: Pointer; lpFileName: PAnsiChar;
    nSize: DWORD): DWORD stdcall; external psapi name 'GetDeviceDriverFileNameA';

  function GetProcessMemoryInfo(Process: THandle;
    ppsmemCounters: PPROCESS_MEMORY_COUNTERS; cb: DWORD): BOOL stdcall; external psapi name 'GetProcessMemoryInfo';

  function EmptyWorkingSet(hProcess: THandle): BOOL stdcall; external psapi name 'EmptyWorkingSet';
  function QueryWorkingSet(hProcess: THandle; pv: Pointer; cb: DWORD): BOOL stdcall; external psapi name 'QueryWorkingSet';
  
implementation

end.
