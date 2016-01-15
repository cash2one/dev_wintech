{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_kernel32;

interface 
                 
uses
  atmcmbaseconst, winconst, wintype;

const
  DONT_RESOLVE_DLL_REFERENCES = 1;
  // 这是什么意思 load lib as data file ???
  LOAD_LIBRARY_AS_DATAFILE = 2;
  LOAD_WITH_ALTERED_SEARCH_PATH = 8;

  function LoadLibraryA(lpLibFileName: PAnsiChar): HMODULE; stdcall; external kernel32 name 'LoadLibraryA';
  function LoadLibraryExA(lpLibFileName: PAnsiChar; hFile: THandle; dwFlags: DWORD): HMODULE; stdcall; external kernel32 name 'LoadLibraryExA';
  
  function FreeLibrary(hLibModule: HMODULE): BOOL; stdcall; external kernel32 name 'FreeLibrary';
  procedure FreeLibraryAndExitThread(hLibModule: HMODULE; dwExitCode: DWORD); stdcall; external kernel32 name 'FreeLibraryAndExitThread';

  // 取消DLL_THREAD_ATTACH和DLL_THREAD_DETACH的通知消息
  // 这可减少某些应用程序的工作集空间
  // 当然在DLL中，我们不能调用GetModuleHandle(NULL)来获取DLL模块的句柄，
  // 因为这样获得的是当前使用该DLL的可执行程序映像的基地址，而不是DLL映像的
  // 对于一个拥有很多DLL的多线程应用程序而言，如果这些DLL频繁地创建和销毁线程，
  // 而且这些DLL不需要线程创建和销毁通知，则在DLL中使用DisableThreadLibraryCalls函数将能够起到优化应用程序的作用
  // http://hi.baidu.com/micfree/blog/item/ee3e83f5d8b07132bc31091a.html
  function DisableThreadLibraryCalls(hLibModule: HMODULE): BOOL; stdcall; external kernel32 name 'DisableThreadLibraryCalls';
                                                 
  function GetModuleHandleA(lpModuleName: PAnsiChar): HMODULE; stdcall; external kernel32 name 'GetModuleHandleA';
  
  function GetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall; external kernel32 name 'GetProcAddress';
  function CloseHandle(hObject: THandle): BOOL; stdcall; external kernel32 name 'CloseHandle';

  function GetLastError: Longword; stdcall; external kernel32 name 'GetLastError';

  function InterlockedIncrement(var Addend: Integer): Integer; stdcall; external kernel32 name 'InterlockedIncrement';
  function InterlockedDecrement(var Addend: Integer): Integer; stdcall; external kernel32 name 'InterlockedDecrement';
  function InterlockedCompareExchange(var Destination: Longint; Exchange: Longint; Comperand: Longint): Longint stdcall; external kernel32 name 'InterlockedCompareExchange';
  function InterlockedExchange(var Target: Integer; Value: Integer): Integer; stdcall; external kernel32 name 'InterlockedExchange';
//  function InterlockedExchangeAdd(Addend: PLongint; Value: Longint): Longint; external kernel32 name 'InterlockedExchangeAdd';
  function InterlockedExchangeAdd(var Addend: Longint; Value: Longint): Longint; external kernel32 name 'InterlockedExchangeAdd';

  function CreateIoCompletionPort(FileHandle, ExistingCompletionPort: THandle;
    CompletionKey, NumberOfConcurrentThreads: DWORD): THandle; stdcall; external kernel32 name 'CreateIoCompletionPort';
  // windows server 2008
  function GetQueuedCompletionStatusEx(CompletionPort: THandle;
    var lpOverlapped: POverlapped; ulCount: ULONG;
    var ulNumEntriesRemoved: PULONG; dwMilliseconds: DWORD; fAlertable: BOOL): BOOL; stdcall; external kernel32 name 'GetQueuedCompletionStatusEx';
  // windows xp
  function GetQueuedCompletionStatus(CompletionPort: THandle;
    var lpNumberOfBytesTransferred, lpCompletionKey: DWORD;
    var lpOverlapped: POverlapped; dwMilliseconds: DWORD): BOOL; stdcall; external kernel32 name 'GetQueuedCompletionStatus';
  function PostQueuedCompletionStatus(CompletionPort: THandle; dwNumberOfBytesTransferred: DWORD;
      dwCompletionKey: DWORD; lpOverlapped: POverlapped): BOOL; stdcall; external kernel32 name 'PostQueuedCompletionStatus';
  //缓存里的数据重写回主内存里去，让CPU重新加载新的指令，才能执行新的指令
  //http://blog.csdn.net/caimouse/archive/2007/12/06/1921570.aspx
  function FlushInstructionCache(hProcess: THandle;
      const lpBaseAddress: Pointer; dwSize: DWORD): BOOL; stdcall; external kernel32 name 'FlushInstructionCache';

  procedure OutputDebugStrA(lpOutputStr: PAnsiChar); stdcall; external kernel32 name 'OutputDebugStringA';
  procedure OutputDebugStrW(lpOutputStr: PWideChar); stdcall; external kernel32 name 'OutputDebugStringW';

  function GetComputerNameA(lpBuffer: PAnsiChar; var nSize: DWORD): BOOL; stdcall; external kernel32 name 'GetComputerNameA';
  function SetComputerNameA(lpComputerName: PAnsiChar): BOOL; stdcall; external kernel32 name 'SetComputerNameA';

  function GetLocaleInfoA(Locale: LCID; LCType: LCTYPE; lpLCData: PAnsiChar; cchData: Integer): Integer; stdcall; external kernel32 name 'GetLocaleInfoA';

  function GetUserDefaultLCID: LCID; stdcall; external kernel32 name 'GetUserDefaultLCID';
  function GetSystemDefaultLCID: LCID; stdcall; external kernel32 name 'GetSystemDefaultLCID';

  function GetUserDefaultLangID: LANGID; stdcall; external kernel32 name 'GetUserDefaultLangID';
  function GetSystemDefaultLangID: LANGID; stdcall; external kernel32 name 'GetSystemDefaultLangID';

type                           
  TwDLLKernelProc   = record
    LoadLibrary     : function(lpLibFileName: PAnsiChar): HMODULE; stdcall;
    FreeLibrary     : function(hLibModule: HMODULE): BOOL; stdcall;
    GetProcAddress  : function(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall;
    CloseHandle     : function(hObject: THandle): BOOL; stdcall;
    GetLastError    : function: Longword; stdcall; 
  end;
  
  TwDLLKernel       = record
    Handle          : HModule;
    Proc            : TwDLLKernelProc;
//    CharProc        : TwDLLKernel_Char;
//    MemProc         : TwDLLKernel_Mem;
//    TimeProc        : TwDLLKernel_Time;
//    SysObjProc      : TwDLLKernel_SysObj;
//    ProcThreadProc  : TwDLLKernel_ProcThread;
  end;

const
  LOCALE_IDEFAULTANSICODEPAGE     = $00001004;   { default ansi code page }

const
  SCS_32BIT_BINARY = 0;
  SCS_DOS_BINARY = 1;
  SCS_WOW_BINARY = 2;
  SCS_PIF_BINARY = 3;
  SCS_POSIX_BINARY = 4;
  SCS_OS216_BINARY = 5;

  // 如果 是 exe 文件 返回为 true
  // if GetBinaryType('E:\Collect\AlgorithmCourse.rar', BinaryType) then
  //   if BinaryType = SCS_32BIT_BINARY then

  function GetBinaryTypeA(lpApplicationName: PAnsiChar; var lpBinaryType: DWORD): BOOL; stdcall; external kernel32 name 'GetBinaryTypeA';
  function GetCommandLineA: PAnsiChar; stdcall; external kernel32 name 'GetCommandLineA';
  function GetEnvironmentVariableA(lpName: PAnsiChar; lpBuffer: PAnsiChar; nSize: DWORD): DWORD; stdcall;
    external kernel32 name 'GetEnvironmentVariableA';
  function SetEnvironmentVariable(lpName, lpValue: PAnsiChar): BOOL; stdcall; external kernel32 name 'SetEnvironmentVariableA';
  function ExpandEnvironmentStrsA(lpSrc: PAnsiChar; lpDst: PAnsiChar; nSize: DWORD): DWORD; stdcall; external kernel32 name 'ExpandEnvironmentStringsA';
  procedure GetStartupInfoA(var lpStartupInfo: TStartupInfoA); stdcall; external kernel32 name 'GetStartupInfoA';
  procedure FatalAppExitA(uAction: UINT; lpMessageText: PAnsiChar); stdcall; external kernel32 name 'FatalAppExitA';

  {
  FatalExit 功能立即退出应用程序不做任何清理工作各种对象依然保留在内存中调用该
  函数时通常会导致GPF 错误一般在调试应用程序时使用
  }
  procedure FatalExit(ExitCode: Integer); stdcall; external kernel32 name 'FatalExit';

  { Performance counter API's }
  // Windows下获取高精度时间注意事项 [转贴 AdamWu]
  // http://www.cnblogs.com/AnyDelphi/archive/2009/05/14/1456716.html
  // 1. RDTSC - 粒度: 纳秒级 不推荐 (不准确)
  // 2. QueryPerformanceCounter - 粒度: 1~100微秒级 不推荐
  //    系统采用节能模式的时候PerformanceCounter出来的结果老是偏慢很多，
  //    超频模式的时候又偏快，而且用电池和接电源的时候效果还不一样
  // 3. timeGetTime - 粒度: 毫秒级 推荐
  // winmm.timeGetTime
  //    A) 在NT系统上(据说)默认精度为10ms，但是可以用timeBeginPeriod来降低到1ms
  //    B) 返回的是一个32位整数，所以要注意大约每49.71天会出现归零(不像前两个是64位数，要几百年才会归零)。
  function QueryPerformanceCounter(var lpPerformanceCount: TLargeInteger): BOOL; stdcall; overload;
    external kernel32 name 'QueryPerformanceCounter';
  function QueryPerformanceCounter(var lpPerformanceCount: Int64): BOOL; stdcall; overload;
    external kernel32 name 'QueryPerformanceCounter';
  function QueryPerformanceFrequency(var lpFrequency: TLargeInteger): BOOL; stdcall; external kernel32 name 'QueryPerformanceFrequency';

implementation

end.
