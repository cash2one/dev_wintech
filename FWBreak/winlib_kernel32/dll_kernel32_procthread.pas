unit dll_kernel32_procthread;

interface

uses
  atmcmbaseconst, winconst, wintype;
  
type
  PProcessInfo      = ^TProcessInfo;
  TProcessInfo      = record
    hProcess        : THandle;
    hThread         : THandle;
    dwProcessId     : DWORD;
    dwThreadId      : DWORD;
  end;
                                 
const                               
  PROCESS_TERMINATE         = $0001;
  PROCESS_CREATE_THREAD     = $0002;
  PROCESS_VM_OPERATION      = $0008;
  PROCESS_VM_READ           = $0010;
  PROCESS_VM_WRITE          = $0020;
  PROCESS_DUP_HANDLE        = $0040;
  PROCESS_CREATE_PROCESS    = $0080;
  PROCESS_SET_QUOTA         = $0100;
  PROCESS_SET_INFORMATION   = $0200;
  PROCESS_QUERY_INFORMATION = $0400;
  PROCESS_ALL_ACCESS        = (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or $FFF);
                                       
  DEBUG_PROCESS             = $00000001;
  DEBUG_ONLY_THIS_PROCESS   = $00000002;

  CREATE_SUSPENDED          = $00000004;

  DETACHED_PROCESS          = $00000008;
  CREATE_NEW_CONSOLE        = $00000010;

  // 这个进程没有特殊的任务调度要求
  NORMAL_PRIORITY_CLASS     = $00000020;

  // 指示这个进程的线程只有在系统空闲时才会运行并且可以被任何高优先级的任务打断
  IDLE_PRIORITY_CLASS       = $00000040;

  //指示这个进程将执行时间临界的任务，所以它必须被立即运行以保证正确。
  // 这个优先级的程序优先于正常优先级或空闲优先级的程序。
  // 一个例子是Windows任务列表，为了保证当用户调用时可以立刻响应，
  // 放弃了对系统负荷的考虑。确保在使用高优先级时应该足够谨慎，因为
  // 一个高优先级的CPU关联应用程序可以占用几乎全部的CPU可用时间
  HIGH_PRIORITY_CLASS       = $00000080;

  // 指示这个进程拥有可用的最高优先级。
  // 一个拥有实时优先级的进程的线程可以
  // 打断所有其他进程线程的执行，包括正
  // 在执行重要任务的系统进程。例如，一
  // 个执行时间稍长一点的实时进程可能导
  // 致磁盘缓存不足或鼠标反映迟钝
  REALTIME_PRIORITY_CLASS   = $00000100;

  // 新进程将使一个进程树的根进程。进程树中的全部进程都是根进程的子进程
  // CREATE_NEW_PROCESS_GROUP or NORMAL_PRIORITY_CLASS
  CREATE_NEW_PROCESS_GROUP  = $00000200;


  CREATE_UNICODE_ENVIRONMENT= $00000400;
  CREATE_SEPARATE_WOW_VDM   = $00000800;
  CREATE_SHARED_WOW_VDM     = $00001000;
  CREATE_FORCEDOS           = $00002000;
  CREATE_DEFAULT_ERROR_MODE = $04000000;

  // CREATE_NO_WINDOW 不为应用程序创建任何控制台窗口 ???
  // 控制台窗口 ???
  CREATE_NO_WINDOW          = $08000000;

    { Dual Mode API below this line. Dual Mode Structures also included. }
  STARTF_USESHOWWINDOW = 1;
  STARTF_USESIZE = 2;
  STARTF_USEPOSITION = 4;
  STARTF_USECOUNTCHARS = 8;
  STARTF_USEFILLATTRIBUTE = $10;
  STARTF_RUNFULLSCREEN = $20;  { ignored for non-x86 platforms }
  STARTF_FORCEONFEEDBACK = $40;
  STARTF_FORCEOFFFEEDBACK = $80;
  STARTF_USESTDHANDLES = $100;
  STARTF_USEHOTKEY = $200;
                                 
  STATUS_WAIT_0                   = $00000000;
  STATUS_ABANDONED_WAIT_0         = $00000080;
  STATUS_USER_APC                 = $000000C0;
  STATUS_TIMEOUT                  = $00000102;
  STATUS_PENDING                  = $00000103;
  STATUS_SEGMENT_NOTIFICATION     = $40000005;
  STATUS_GUARD_PAGE_VIOLATION     = DWORD($80000001);
  STATUS_DATATYPE_MISALIGNMENT    = DWORD($80000002);
  STATUS_BREAKPOINT               = DWORD($80000003);
  STATUS_SINGLE_STEP              = DWORD($80000004);
  STATUS_ACCESS_VIOLATION         = DWORD($C0000005);
  STATUS_IN_PAGE_ERROR            = DWORD($C0000006);
  STATUS_INVALID_HANDLE           = DWORD($C0000008);
  STATUS_NO_MEMORY                = DWORD($C0000017);
  STATUS_ILLEGAL_INSTRUCTION      = DWORD($C000001D);
  STATUS_NONCONTINUABLE_EXCEPTION = DWORD($C0000025);
  STATUS_INVALID_DISPOSITION      = DWORD($C0000026);
  STATUS_ARRAY_BOUNDS_EXCEEDED    = DWORD($C000008C);
  STATUS_FLOAT_DENORMAL_OPERAND   = DWORD($C000008D);
  STATUS_FLOAT_DIVIDE_BY_ZERO     = DWORD($C000008E);
  STATUS_FLOAT_INEXACT_RESULT     = DWORD($C000008F);
  STATUS_FLOAT_INVALID_OPERATION  = DWORD($C0000090);
  STATUS_FLOAT_OVERFLOW           = DWORD($C0000091);
  STATUS_FLOAT_STACK_CHECK        = DWORD($C0000092);
  STATUS_FLOAT_UNDERFLOW          = DWORD($C0000093);
  STATUS_INTEGER_DIVIDE_BY_ZERO   = DWORD($C0000094);
  STATUS_INTEGER_OVERFLOW         = DWORD($C0000095);
  STATUS_PRIVILEGED_INSTRUCTION   = DWORD($C0000096);
  STATUS_STACK_OVERFLOW           = DWORD($C00000FD);
  STATUS_CONTROL_C_EXIT           = DWORD($C000013A);
  STILL_ACTIVE = STATUS_PENDING;
  
  { *************** some thing abount process **************************** }
  function CreateProcessA(lpApplicationName: PAnsiChar; lpCommandLine: PAnsiChar;
    lpProcessAttributes, lpThreadAttributes: PSecurityAttributes;
    bInheritHandles: BOOL; dwCreationFlags: DWORD; lpEnvironment: Pointer;
    lpCurrentDirectory: PAnsiChar; const lpStartupInfo: TStartupInfoA;
    var lpProcessInfo: TProcessInfo): BOOL; stdcall; external kernel32 name 'CreateProcessA';
  function TerminateProcess(AProcess: THandle; uExitCode: UINT): BOOL; stdcall; external kernel32 name 'TerminateProcess';
  function GetCurrentProcess: THandle; stdcall; external kernel32 name 'GetCurrentProcess';
  function GetCurrentProcessId: DWORD; stdcall; external kernel32 name 'GetCurrentProcessId';
  function OpenProcess(dwDesiredAccess: DWORD; bInheritHandle: BOOL; dwProcessId: DWORD): THandle; stdcall; external kernel32 name 'OpenProcess';
  function ReadProcessMemory(AProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
    nSize: DWORD; var lpNumberOfBytesRead: DWORD): BOOL; stdcall; external kernel32 name 'ReadProcessMemory';
  function WriteProcessMemory(AProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
    nSize: DWORD; var lpNumberOfBytesWritten: DWORD): BOOL; stdcall; external kernel32 name 'WriteProcessMemory';

  function GetProcessHeap: THandle; stdcall; external kernel32 name 'GetProcessHeap';
  function GetProcessHeaps(NumberOfHeaps: DWORD; var ProcessHeaps: THandle): DWORD; stdcall; external kernel32 name 'GetProcessHeaps';
  function GetProcessTimes(AProcess: THandle; var lpCreationTime,
      lpExitTime, lpKernelTime, lpUserTime: TFileTime): BOOL; stdcall; external kernel32 name 'GetProcessTimes';
  function GetProcessVersion(AProcessId: DWORD): DWORD; stdcall; external kernel32 name 'GetProcessVersion';
  function GetProcessWorkingSetSize(AProcess: THandle; var lpMinimumWorkingSetSize,
      lpMaximumWorkingSetSize: DWORD): BOOL; stdcall; external kernel32 name 'GetProcessWorkingSetSize';

  function SetProcessWorkingSetSize(AProcess: THandle; dwMinimumWorkingSetSize,
      dwMaximumWorkingSetSize: DWORD): BOOL; stdcall; external kernel32 name 'SetProcessWorkingSetSize';
  function GetModuleFileNameA(AModule: HINST; lpFilename: PAnsiChar; nSize: DWORD): DWORD; stdcall; external kernel32 name 'GetModuleFileNameA';
  { *************** some thing abount thread **************************** }
  function CreateThread(lpThreadAttributes: Pointer;
    dwStackSize: DWORD; lpStartAddress: TFNThreadStartRoutine;
    lpParameter: Pointer; dwCreationFlags: DWORD; var lpThreadId: DWORD): THandle; stdcall; external kernel32 name 'CreateThread';
  function SuspendThread(AThread: THandle): DWORD; stdcall; external kernel32 name 'SuspendThread';
  function ResumeThread(AThread: THandle): DWORD; stdcall; external kernel32 name 'ResumeThread';
  function TerminateThread(AThread: THandle; dwExitCode: DWORD): BOOL; stdcall; external kernel32 name 'TerminateThread';
  procedure ExitThread(dwExitCode: DWORD); stdcall; external kernel32 name 'ExitThread';
  function GetCurrentThread: THandle; stdcall; external kernel32 name 'GetCurrentThread';
  function GetCurrentThreadId: DWORD; stdcall; external kernel32 name 'GetCurrentThreadId';

  { http://www.cnblogs.com/kex1n/archive/2011/05/09/2040924.html
    http://blog.csdn.net/solstice/article/details/5196544
    多核时代不宜再用 x86 的 RDTSC 指令测试指令周期和时间
自从 Intel Pentium 加入 RDTSC 指令以来，这条指令是 micro-benchmarking
的利器，可以以极小的代价获得高精度的 CPU 时钟周期数（Time Stamp Counter），
不少介绍优化的文章[1]和书籍用它来比较两段代码的快慢。甚至有的代码用 RDTSC
指令来计时，以替换 gettimeofday() 之类的系统调用。在多核时代，RDTSC 指令的
准确度大大削弱了，原因有三：
    1.不能保证同一块主板上每个核的 TSC 是同步的
    2.CPU 的时钟频率可能变化，例如笔记本电脑的节能功能
    3.乱序执行导致 RDTSC 测得的周期数不准，这个问题从 Pentium Pro 时代就存在

    虽然 RDTSC 废掉了，性能测试用的高精度计时还是有办法的 [2]，
    在 Windows 用 QueryPerformanceCounter 和 QueryPerformanceFrequency，
    Linux 下用 POSIX 的 clock_gettime 函数，以 CLOCK_MONOTONIC 参数调用。

    QueryPerformanceCounter() 错误的情况我们也碰见过，用 SetThreadAffinityMask() 解决
    SetThreadAffinityMask(GetCurrentThread(), 1);
    //timeConsuming();
    QueryPerformanceFrequency(&freq);

    dwThreadAffinityMask必须是进程的亲缘性屏蔽的相应子集
    返回值是线程的前一个亲缘性屏蔽
    若要将3个线程限制到CPU1、2和3上去运行，可以这样操作
    SetThreadAffinityMask(hThread0, 0x00000001);
    SetThreadAffinityMask(hThread1, 0x0000000E);   1110
    SetThreadAffinityMask(hThread2, 0x0000000E);
    SetThreadAffinityMask(hThread3, 0x0000000E);
  }

  { GetProcessAffinityMask 得到进程可运行处理器掩码描述字。（返回2个值，一个是当前进程可运行的，一个是系统拥有的CPU
  }
  function GetProcessAffinityMask(hProcess: THandle; var lpProcessAffinityMask, lpSystemAffinityMask: DWORD): BOOL; stdcall; external kernel32 name 'GetProcessAffinityMask';
  function SetProcessAffinityMask(hProcess: THandle; dwProcessAffinityMask: DWORD): BOOL; stdcall; external kernel32 name 'SetProcessAffinityMask';

  function SetThreadAffinityMask(AThread: THandle; dwThreadAffinityMask: DWORD): DWORD; stdcall; external kernel32 name 'SetThreadAffinityMask';

  { GetSystemInfo(&SystemInfo);
    SystemInfo.dwNumberOfProcessors, SystemInfo.dwActiveProcessorMask
  }
  function SetThreadIdealProcessor(AThread: THandle; dwIdealProcessor: DWORD): BOOL; stdcall; external kernel32 name 'SetThreadIdealProcessor';

  { 获取一个已中断进程的退出代码 }
  function GetExitCodeProcess(AProcess: THandle; var lpExitCode: DWORD): BOOL; stdcall; external kernel32 name 'GetExitCodeProcess';
  { 获取一个已中止线程的退出代码 线程尚未中断，则设为常数STILL_ACTIVE }
  function GetExitCodeThread(AThread: THandle; var lpExitCode: DWORD): BOOL; stdcall; external kernel32 name 'GetExitCodeThread';

  { 动态提升线程优先级,允许或禁止系统提升一个进程中所有线程的优先级
    GetProcessPriorityBoost，GetThreadPriorityBoost,SetFileInformationByHandle }
  function SetProcessPriorityBoost(AhThread: THandle; DisablePriorityBoost: Bool): BOOL; stdcall; external kernel32 name 'SetProcessPriorityBoost';
  function GetProcessPriorityBoost(AThread: THandle; var DisablePriorityBoost: Bool): BOOL; stdcall; external kernel32 name 'GetProcessPriorityBoost';

  { 进程优先级，可以调用SetPriorityClass来改变进程优先级，也可以改变进程本身的 }
  function SetPriorityClass(hProcess: THandle; dwPriorityClass: DWORD): BOOL; stdcall; external kernel32 name 'SetPriorityClass';
  function GetPriorityClass(hProcess: THandle): DWORD; stdcall; external kernel32 name 'GetPriorityClass';
  {
  dwLevel [in]  进程关闭优先级（相对于系统中的其他进程的）.系统从高级别到低级别关闭进程.
  最高和最低的关闭优先级保留给系统组件用，用户的参数必须是以下：
  Value Meaning
    000–0FF	System reserved last shutdown range.
    100–1FF	Application reserved last shutdown range.
    200–2FF	Application reserved "in between" shutdown range.
    300–3FF	Application reserved first shutdown range.
    400–4FF	System reserved first shutdown range.
  dwFlags
    [in] Flags. This parameter can be the following value.
    Value	Meaning
      SHUTDOWN_NORETRY The system terminates the process without displaying a retry dialog box for the user.
  }
  function SetProcessShutdownParameters(dwLevel, dwFlags: DWORD): BOOL; stdcall; external kernel32 name 'SetProcessShutdownParameters';

  function GetThreadLocale: LCID; stdcall; external kernel32 name 'GetThreadLocale';
  function SetThreadLocale(ALocale: LCID): BOOL; stdcall; external kernel32 name 'SetThreadLocale';
  
  function GetThreadPriority(AThread: THandle): Integer; stdcall; external kernel32 name 'GetThreadPriority';
  function SetThreadPriority(AThread: THandle; nPriority: Integer): BOOL; stdcall; external kernel32 name 'SetThreadPriority';

  { 动态提升线程优先级，允许或禁止系统提升一个进程中所有线程的优先级SetProcessPriorityBoost。
    允许或禁止系统提升某个线程的优先级SetThreadPriorityBoost }
  function GetThreadPriorityBoost(AThread: THandle; var DisablePriorityBoost: Bool): BOOL; stdcall;
      external kernel32 name 'GetThreadPriorityBoost';
  function SetThreadPriorityBoost(AThread: THandle; DisablePriorityBoost: Bool): BOOL; stdcall; external kernel32 name 'SetThreadPriorityBoost';

  { Win32调试API原理  http://blog.csdn.net/b2b160/article/details/4242894
   1. ContinueDebugEvent
   2. DebugActiveProcess
   3. DebugActiveProcessStop
   4. DebugBreak
   5. DebugBreakProcess
   6. FatalExit
   7. FlushInstructionCache
   8. GetThreadContext
   9. GetThreadSelectorEntry 此函数返回指定选择器和线程的描述符表的入口地址
   10. IsDebuggerPresent
   11. OutputDebugString
   12. ReadProcessMemory
   13. SetThreadContext
   14. WaitForDebugEvent
   15. WriteProcessMemory
  }
  function GetThreadSelectorEntry(AThread: THandle; dwSelector: DWORD;
      var lpSelectorEntry: TLDTEntry): BOOL; stdcall; external kernel32 name 'GetThreadSelectorEntry';

  {
  hThread 其计时信息寻求的线程的句柄。该句柄必须具有的 THREAD_QUERY_INFORMATION 或 THREAD_QUERY_LIMITED_INFORMATION 访问权
  }
  function GetThreadTimes(hThread: THandle; var lpCreationTime, lpExitTime, lpKernelTime, lpUserTime:
      TFileTime): BOOL; stdcall; external kernel32 name 'GetThreadTimes';

  //调用其他线程
  // Sleep和SwitchToThread区别
  {
  两个都是放弃时间片，按照书中或者网上的一般说法，Sleep(0)将会在可调度的同等级或者高优先级的线程里面找，
  而SwitchToThread则是全系统范围，低优先级的也可能会被调用
  }
  function SwitchToThread: BOOL; stdcall; external kernel32 name 'SwitchToThread';

  (*
  当一个调试事件发生时，Windows暂停被调试进程，并保存其 进程上下文。
  由于进程被暂停运行，我们可以确信其进程上下文内容将保持不变。
  可以用GetThreadContext来获取进程上下文内容，并且也可以用GetThreadContext 来修改进程上下文内容
  *)
  function GetThreadContext(AThread: THandle; var lpContext: TContext): BOOL; stdcall; external kernel32 name 'GetThreadContext';
  function SetThreadContext(AThread: THandle; const lpContext: TContext): BOOL; stdcall; external kernel32 name 'SetThreadContext';
  function CreateRemoteThread(AProcess: THandle; lpThreadAttributes: Pointer;
    dwStackSize: DWORD; lpStartAddress: TFNThreadStartRoutine; lpParameter: Pointer;
    dwCreationFlags: DWORD; var lpThreadId: DWORD): THandle; stdcall; external kernel32 name 'CreateRemoteThread';

  { *************** some thing abount fiber **************************** }
  function CreateFiber(dwStackSize: DWORD; lpStartAddress: TFNFiberStartRoutine;
    lpParameter: Pointer): Pointer; stdcall; external kernel32 name 'CreateFiber';
  function DeleteFiber(lpFiber: Pointer): BOOL; stdcall; external kernel32 name 'DeleteFiber';
  function ConvertThreadToFiber(lpParameter: Pointer): BOOL; stdcall; external kernel32 name 'ConvertThreadToFiber';
  function SwitchToFiber(lpFiber: Pointer): BOOL; stdcall; external kernel32 name 'SwitchToFiber';
  
  // win2008/Vista support
  function QueryFullProcessImageNameA(AProcess: THandle; dwFlags: DWORD;
    lpExeName: PAnsiChar; var lpdwSize: DWORD): BOOL; stdcall; external kernel32 name 'QueryFullProcessImageNameA';

  {
    一个线程内部的各个函数调用都能访问、但其它线程不能访问的变量
    被称为static memory local to a thread 线程局部静态变量，
    就需要新的机制来实现。这就是TLS

    为当前线程动态分配一块内存区域（使用LocalAlloc()函数调用），然后把指向这块内存区域的指针放入TLS数组相应的槽中(使用TlsSetValue()函数调用)
  }
  function TlsAlloc: DWORD; stdcall; external kernel32 name 'TlsAlloc';

type                     
  TwDLLKernel_ProcThread  = record
    { *************** some thing abount process **************************** }
    CreateProcessA: function (lpApplicationName: PAnsiChar; lpCommandLine: PAnsiChar;
      lpProcessAttributes, lpThreadAttributes: PSecurityAttributes;
      bInheritHandles: BOOL; dwCreationFlags: DWORD; lpEnvironment: Pointer;
      lpCurrentDirectory: PAnsiChar; const lpStartupInfo: TStartupInfoA;
      var lpProcessInfo: TProcessInfo): BOOL; stdcall;
    TerminateProcess: function (AProcess: THandle; uExitCode: UINT): BOOL; stdcall;
    GetCurrentProcess: function : THandle; stdcall;
    GetCurrentProcessId: function : DWORD; stdcall;
    OpenProcess: function (dwDesiredAccess: DWORD; bInheritHandle: BOOL; dwProcessId: DWORD): THandle; stdcall;
    ReadProcessMemory: function (AProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
      nSize: DWORD; var lpNumberOfBytesRead: DWORD): BOOL; stdcall;
    WriteProcessMemory: function (AProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
      nSize: DWORD; var lpNumberOfBytesWritten: DWORD): BOOL; stdcall;

    GetProcessHeap: function : THandle; stdcall;
    GetProcessHeaps: function (NumberOfHeaps: DWORD; var ProcessHeaps: THandle): DWORD; stdcall;
    GetProcessTimes: function (AProcess: THandle; var lpCreationTime,
        lpExitTime, lpKernelTime, lpUserTime: TFileTime): BOOL; stdcall;
    GetProcessVersion: function (AProcessId: DWORD): DWORD; stdcall;
    GetProcessWorkingSetSize: function (AProcess: THandle; var lpMinimumWorkingSetSize,
        lpMaximumWorkingSetSize: DWORD): BOOL; stdcall;

    SetProcessWorkingSetSize: function (AProcess: THandle; dwMinSize, dwMaxSize: DWORD): BOOL; stdcall;

    { *************** some thing abount thread **************************** }
    CreateThread: function (lpThreadAttributes: Pointer;
      dwStackSize: DWORD; lpStartAddress: TFNThreadStartRoutine;
      lpParameter: Pointer; dwCreationFlags: DWORD; var lpThreadId: DWORD): THandle; stdcall;
    SuspendThread: function (AThread: THandle): DWORD; stdcall;
    ResumeThread: function (AThread: THandle): DWORD; stdcall;
    TerminateThread: function (AThread: THandle; dwExitCode: DWORD): BOOL; stdcall;
    ExitThread: procedure (dwExitCode: DWORD); stdcall;
    GetCurrentThread: function : THandle; stdcall;
    GetCurrentThreadId: function : DWORD; stdcall;

    // 限制某一个线程只能运行在一组CPU上
    (*比如，现在有4个线程和4个可用的CPU，你想让线程1独占CPU 0，让其他3个线程只能运行在CPU 1、CPU 2、CPU 3上，可以如下编码：
    SetThreadAffinityMask(hThread0, 0x00000001);
    SetThreadAffinityMask(hThread1, 0x0000000E);
    SetThreadAffinityMask(hThread2, 0x0000000E);
    SetThreadAffinityMask(hThread3, 0x0000000E);
    *)
    SetThreadAffinityMask: function (AThread: THandle; dwThreadAffinityMask: DWORD): DWORD; stdcall;

    (*
    这个一定要试试
    该函数的第二个参数不是位屏蔽数据，而是一个0～31（32位系统）或0～63（64位系统）的整数。
    该数据指明首选的CPU。也可以传递MAXIMUM_PROCESSORS表明当前没有理想的CPU
    *)
    SetThreadIdealProcessor: function (AThread: THandle; dwIdealProcessor: DWORD): BOOL; stdcall;

    { 获取一个已中断进程的退出代码 }
    GetExitCodeProcess: function (AProcess: THandle; var lpExitCode: DWORD): BOOL; stdcall;
    { 获取一个已中止线程的退出代码 线程尚未中断，则设为常数STILL_ACTIVE }
    GetExitCodeThread: function (AThread: THandle; var lpExitCode: DWORD): BOOL; stdcall;

    // 可以调用GetProcessAffinityMask函数来取得一个进程亲缘性屏蔽信息
    GetProcessAffinityMask: function (AProcess: THandle; var lpProcessAffinityMask, lpSystemAffinityMask: DWORD): BOOL; stdcall;
    // 限制一个特定的进程只能运行在CPU的一个子集上
    // 我需要将我的线程绑定到cpu0，和cpu2，cpu3上，则可以这样：SetProcessAffinityMask(::GetCurrentProcrss( ) , 13L);
    SetProcessAffinityMask: function (AProcess: THandle; dwProcessAffinityMask: DWORD): BOOL; stdcall;


    SetProcessPriorityBoost: function (AThread: THandle; DisablePriorityBoost: Bool): BOOL; stdcall;
    GetProcessPriorityBoost: function (AThread: THandle; var DisablePriorityBoost: Bool): BOOL; stdcall;
    SetProcessShutdownParameters: function (dwLevel, dwFlags: DWORD): BOOL; stdcall;

    GetThreadLocale: function : LCID; stdcall;
    SetThreadLocale: function (Locale: LCID): BOOL; stdcall;

    GetThreadPriority: function (AThread: THandle): Integer; stdcall;
    SetThreadPriority: function (AThread: THandle; nPriority: Integer): BOOL; stdcall;

    GetThreadPriorityBoost: function (AThread: THandle; var DisablePriorityBoost: Bool): BOOL; stdcall;
    SetThreadPriorityBoost: function (AThread: THandle; DisablePriorityBoost: Bool): BOOL; stdcall;
    GetThreadSelectorEntry: function (AThread: THandle; dwSelector: DWORD; var lpSelectorEntry: TLDTEntry): BOOL; stdcall;
    GetThreadTimes: function (AThread: THandle; var lpCreationTime, lpExitTime, lpKernelTime, lpUserTime: TFileTime): BOOL; stdcall;

    //调用其他线程
    // Sleep和SwitchToThread区别
    SwitchToThread: function : BOOL; stdcall;

    (*
    当一个调试事件发生时，Windows暂停被调试进程，并保存其 进程上下文。
    由于进程被暂停运行，我们可以确信其进程上下文内容将保持不变。
    可以用GetThreadContext来获取进程上下文内容，并且也可以用GetThreadContext 来修改进程上下文内容
    *)
    GetThreadContext: function (AThread: THandle; var lpContext: TContext): BOOL; stdcall;
    SetThreadContext: function (AThread: THandle; const lpContext: TContext): BOOL; stdcall;
    CreateRemoteThread: function (AProcess: THandle; lpThreadAttributes: Pointer;
      dwStackSize: DWORD; lpStartAddress: TFNThreadStartRoutine; lpParameter: Pointer;
      dwCreationFlags: DWORD; var lpThreadId: DWORD): THandle; stdcall;

    { *************** some thing abount fiber **************************** }
    CreateFiber: function (dwStackSize: DWORD; lpStartAddress: TFNFiberStartRoutine;
      lpParameter: Pointer): Pointer; stdcall;
    DeleteFiber: function (lpFiber: Pointer): BOOL; stdcall;
    ConvertThreadToFiber: function (lpParameter: Pointer): BOOL; stdcall;
    SwitchToFiber: function (lpFiber: Pointer): BOOL; stdcall;
  end;
  
implementation

(*
  //CreateProcess CREATE_SUSPENDED 获得peb
  Context.ContextFlags := CONTEXT_FULL or CONTEXT_DEBUG_REGISTERS;
  function GetThreadContext(hThread: THandle; var lpContext: TContext): BOOL; stdcall;
  ResumeThread(lpProcessInfo.hThread) ;
*)
end.
