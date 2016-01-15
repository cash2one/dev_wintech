unit dll_kernel32_mem;

interface 
                                         
uses
  atmcmbaseconst, winconst, wintype;

type                      
  PMemoryBasicInfo    = ^TMemoryBasicInfo;
  TMemoryBasicInfo    = record
    BaseAddress       : Pointer;
    AllocationBase    : Pointer;
    AllocationProtect : DWORD;
    RegionSize        : DWORD;
    State             : DWORD;
    Protect           : DWORD;
    Type_9            : DWORD;
  end;

  {
    如果堆中没有充足的自由空间去满足我们的需求，LocalAlloc返回NULL。因为NULL被使用去表明一个错误，虚拟地址zero从不被分配。因此，很容易去检测NULL指针的使用
    如果函数成功的话，它至少会分配我们指定大小的内存。如果分配给我们的数量多于我们指定的话，这个进程能使用整个数量的内存
    使用LocalSize函数去检测被分配的字节数
  }
  function LocalAlloc(uFlags, uBytes: UINT): HLOCAL; stdcall; external kernel32 name 'LocalAlloc';

  function LocalLock(AMem: HLOCAL): Pointer; stdcall; external kernel32 name 'LocalLock';
  function LocalReAlloc(AMem: HLOCAL; uBytes, uFlags: UINT): HLOCAL; stdcall; external kernel32 name 'LocalReAlloc';
  function LocalUnlock(AMem: HLOCAL): BOOL; stdcall; external kernel32 name 'LocalUnlock';
  function LocalSize(AMem: HLOCAL): UINT; stdcall; external kernel32 name 'LocalSize'; 
  function LocalFree(AMem: HLOCAL): HLOCAL; stdcall; external kernel32 name 'LocalFree';
  function LocalCompact(uMinFree: UINT): UINT; stdcall; external kernel32 name 'LocalCompact';
  function LocalShrink(AMem: HLOCAL; cbNewSize: UINT): UINT; stdcall; external kernel32 name 'LocalShrink';
  function LocalFlags(AMem: HLOCAL): UINT; stdcall; external kernel32 name 'LocalFlags';
  
  function VirtualProtect(lpAddress: Pointer; dwSize, flNewProtect: DWORD;
    lpflOldProtect: Pointer): BOOL; stdcall; overload; external kernel32 name 'VirtualProtect';
  function VirtualProtect(lpAddress: Pointer; dwSize, flNewProtect: DWORD;
    var OldProtect: DWORD): BOOL; stdcall; overload; external kernel32 name 'VirtualProtect';
  function VirtualProtectEx(hProcess: THandle; lpAddress: Pointer;
    dwSize, flNewProtect: DWORD; lpflOldProtect: Pointer): BOOL; stdcall; overload;
    external kernel32 name 'VirtualProtectEx';
  function VirtualProtectEx(hProcess: THandle; lpAddress: Pointer;
    dwSize, flNewProtect: DWORD; var OldProtect: DWORD): BOOL; stdcall; overload;
    external kernel32 name 'VirtualProtectEx';

  function VirtualLock(lpAddress: Pointer; dwSize: DWORD): BOOL; stdcall; external kernel32 name 'VirtualLock';
  function VirtualUnlock(lpAddress: Pointer; dwSize: DWORD): BOOL; stdcall; external kernel32 name 'VirtualUnlock';

  { VirtualAlloc 该函数的功能是在调用进程的虚地址空间,预定或者提交一部分页
　　如果用于内存分配的话,并且分配类型未指定MEM_RESET,则系统将自动设置为0;
    flAllocationType:
    MEM_COMMIT 在内存或者指定的磁盘页文件(虚拟内存文件)中分配一物理存储区域 函数初始化这个区域为0
　　MEM_PHYSICAL 该类型必须和MEM_RESERVE一起使用 分配一块具有读写功能的物理内存区
　　MEM_RESERVE 保留虚拟地址空间以便以后提交。
　　MEM_RESET
　　MEM_TOP_DOWN 告诉系统从最高可允许的虚拟地址开始映射应用程序。
　　MEM_WRITE_WATCH
    访问类型
　　PAGE_READONLY 该区域为只读。如果应用程序试图访问区域中的页的时候，将会被拒绝访问PAGE_READWRITE 区域可被应用程序读写
　　PAGE_EXECUTE 区域包含可被系统执行的代码。试图读写该区域的操作将被拒绝。
　　PAGE_EXECUTE_READ 区域包含可执行代码，应用程序可以读该区域。
　　PAGE_EXECUTE_READWRITE 区域包含可执行代码，应用程序可以读写该区域。
　　PAGE_GUARD 区域第一次被访问时进入一个STATUS_GUARD_PAGE异常，这个标志要和其他保护标志合并使用，表明区域被第一次访问的权限
　　PAGE_NOACCESS 任何访问该区域的操作将被拒绝
　　PAGE_NOCACHE RAM中的页映射到该区域时将不会被微处理器缓存（cached)
    注:PAGE_GUARD和PAGE_NOCHACHE标志可以和其他标志合并使用以进一步指定页的特征。
       PAGE_GUARD标志指定了一个防护页（guard page），即当一个页被提交时会因第一
       次被访问而产生一个one-shot异常，接着取得指定的访问权限。PAGE_NOCACHE防止
       当它映射到虚拟页的时候被微处理器缓存。这个标志方便设备驱动使用直接内存访
       问方式（DMA）来共享内存块
  }
  function VirtualAlloc(lpvAddress: Pointer; dwSize, flAllocationType, flProtect: DWORD): Pointer; stdcall; external kernel32 name 'VirtualAlloc';
  function VirtualAllocEx(hProcess: THandle; lpAddress: Pointer;
    dwSize, flAllocationType: DWORD; flProtect: DWORD): Pointer; stdcall; external kernel32 name 'VirtualAllocEx';

  function VirtualFree(lpAddress: Pointer; dwSize, dwFreeType: DWORD): BOOL; stdcall; external kernel32 name 'VirtualFree';
  function VirtualFreeEx(hProcess: THandle; lpAddress: Pointer;
    dwSize, dwFreeType: DWORD): Pointer; stdcall; external kernel32 name 'VirtualFreeEx';

  function VirtualQuery(lpAddress: Pointer; var lpBuffer: TMemoryBasicInfo; dwLength: DWORD): DWORD; stdcall; external kernel32 name 'VirtualQuery';
  function VirtualQueryEx(hProcess: THandle; lpAddress: Pointer;
    var lpBuffer: TMemoryBasicInfo; dwLength: DWORD): DWORD; stdcall; external kernel32 name 'VirtualQueryEx';

  {该函数从堆中分配一定数目的字节数.Win32内存管理器并不提供
   相互分开的局部和全局堆.提供这个函数只是为了与16位的Windows相兼容}
  function GlobalAlloc(uFlags: UINT; dwBytes: DWORD): HGLOBAL; stdcall; external kernel32 name 'GlobalAlloc';
  function GlobalReAlloc(AMem: HGLOBAL; dwBytes: DWORD; uFlags: UINT): HGLOBAL; stdcall; external kernel32 name 'GlobalReAlloc';
  function GlobalLock(AMem: HGLOBAL): Pointer; stdcall; external kernel32 name 'GlobalLock';
  function GlobalSize(AMem: HGLOBAL): DWORD; stdcall; external kernel32 name 'GlobalSize';
  function GlobalHandle(AMem: Pointer): HGLOBAL; stdcall; external kernel32 name 'GlobalHandle';
  function GlobalUnlock(AMem: HGLOBAL): BOOL; stdcall; external kernel32 name 'GlobalUnlock';
  function GlobalFree(AMem: HGLOBAL): HGLOBAL; stdcall; external kernel32 name 'GlobalFree';
  function GlobalCompact(dwMinFree: DWORD): UINT; stdcall; external kernel32 name 'GlobalCompact';
  procedure GlobalFix(AMem: HGLOBAL); stdcall; external kernel32 name 'GlobalFix';
  procedure GlobalUnfix(AMem: HGLOBAL); stdcall; external kernel32 name 'GlobalUnfix';

  // Not necessary and has no effect.
  function GlobalWire(AMem: HGLOBAL): Pointer; stdcall; external kernel32 name 'GlobalWire';
  function GlobalUnWire(AMem: HGLOBAL): BOOL; stdcall; external kernel32 name 'GlobalUnWire';

  { Heap Functions }
  function GetProcessHeap: THandle;stdcall; external kernel32 name 'GetProcessHeap';
  function GetProcessHeaps(NumberOfHeaps: DWORD; ProcessHeaps: PHandle): DWORD;stdcall; external kernel32 name 'GetProcessHeaps';
  function HeapQueryInformation(HeapHandle: THANDLE; HeapInformationClass: Pointer): BOOL;stdcall; external kernel32 name 'HeapQueryInformation';
  function HeapSetInformation(HeapHandle: THANDLE; HeapInformationClass: Pointer): BOOL;stdcall; external kernel32 name 'HeapSetInformation';

  function HeapCreate(flOptions, dwInitialSize, dwMaximumSize: DWORD): THandle; stdcall; external kernel32 name 'HeapCreate';
  function HeapDestroy(AHeap: THandle): BOOL; stdcall; external kernel32 name 'HeapDestroy';
  function HeapAlloc(AHeap: THandle; dwFlags, dwBytes: DWORD): Pointer; stdcall; external kernel32 name 'HeapAlloc';
  function HeapReAlloc(AHeap: THandle; dwFlags: DWORD; lpMem: Pointer; dwBytes: DWORD): Pointer; stdcall; external kernel32 name 'HeapReAlloc';
  function HeapFree(AHeap: THandle; dwFlags: DWORD; lpMem: Pointer): BOOL; stdcall; external kernel32 name 'HeapFree';
  function HeapSize(AHeap: THandle; dwFlags: DWORD; lpMem: Pointer): DWORD; stdcall; external kernel32 name 'HeapSize';
  function HeapValidate(AHeap: THandle; dwFlags: DWORD; lpMem: Pointer): BOOL; stdcall; external kernel32 name 'HeapValidate';
  function HeapCompact(AHeap: THandle; dwFlags: DWORD): UINT; stdcall; external kernel32 name 'HeapCompact';
  function HeapLock(AHeap: THandle): BOOL; stdcall; external kernel32 name 'HeapLock';
  function HeapUnlock(AHeap: THandle): BOOL; stdcall; external kernel32 name 'HeapUnlock';
  function HeapWalk(AHeap: THandle; var lpEntry: TProcessHeapEntry): BOOL; stdcall; external kernel32 name 'HeapWalk';

  {
  一般的程序都是在运行前已经编译好的，因此修改指令的机会比较少，但在软件的防确解里，
  倒是使用很多。当修改指令之后，怎么样才能让CPU去执行新的指令呢？这样就需要使用函数
  FlushInstructionCache来把缓存里的数据重写回主内存里去，让CPU重新加载新的指令，才能执行新的指令
  }
  function FlushInstructionCache(hProcess: THandle; const lpBaseAddress: Pointer; dwSize: DWORD): BOOL; stdcall; external kernel32 name 'FlushInstructionCache';

  function ReadProcessMemory(hProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
    nSize: DWORD; var lpNumberOfBytesRead: DWORD): BOOL; stdcall; external kernel32 name 'ReadProcessMemory';
  function WriteProcessMemory(hProcess: THandle; const lpBaseAddress: Pointer; lpBuffer: Pointer;
    nSize: DWORD; var lpNumberOfBytesWritten: DWORD): BOOL; stdcall; external kernel32 name 'WriteProcessMemory';

  { http://msdn.microsoft.com/en-us/library/windows/desktop/aa366781(v=vs.85).aspx#awe_functions }
  { AWE Functions }
  function AllocateUserPhysicalPages(AProcess: THandle; NumberOfPages: Pointer; UserPfnArray: Pointer): BOOL; stdcall;
      external kernel32 name 'AllocateUserPhysicalPages';
  function FreeUserPhysicalPages(AProcess: THandle; NumberOfPages: Pointer; UserPfnArray: Pointer): BOOL; stdcall;
      external kernel32 name 'FreeUserPhysicalPages';
  function MapUserPhysicalPages(lpAddress: Pointer; NumberOfPages: Pointer; UserPfnArray: Pointer): BOOL; stdcall;
      external kernel32 name 'MapUserPhysicalPages';
  { 64-bit Windows on Itanium-based systems:  Due to the difference in page sizes,
    MapUserPhysicalPagesScatter is not supported for 32-bit applications. }
  function MapUserPhysicalPagesScatter(VirtualAddresses: Pointer; NumberOfPages: Pointer; PageArray: Pointer): BOOL; stdcall;
      external kernel32 name 'MapUserPhysicalPagesScatter';

type
  TwDLLKernel_Mem  = record
    LocalAlloc: function (uFlags, uBytes: UINT): HLOCAL; stdcall;
    LocalLock: function (hMem: HLOCAL): Pointer; stdcall;
    LocalReAlloc: function (hMem: HLOCAL; uBytes, uFlags: UINT): HLOCAL; stdcall;
    LocalUnlock: function (hMem: HLOCAL): BOOL; stdcall;
    LocalFree: function (hMem: HLOCAL): HLOCAL; stdcall;
    LocalCompact: function (uMinFree: UINT): UINT; stdcall;

    VirtualProtect: function (lpAddress: Pointer; dwSize, flNewProtect: DWORD; lpflOldProtect: Pointer): BOOL; stdcall;
  //  VirtualProtect: function (lpAddress: Pointer; dwSize, flNewProtect: DWORD; var OldProtect: DWORD): BOOL; stdcall; overload;
    VirtualProtectEx: function (hProcess: THandle; lpAddress: Pointer; dwSize, flNewProtect: DWORD; lpflOldProtect: Pointer): BOOL; stdcall; 
  //  VirtualProtectEx: function (hProcess: THandle; lpAddress: Pointer; dwSize, flNewProtect: DWORD; var OldProtect: DWORD): BOOL; stdcall; overload;

    VirtualLock: function (lpAddress: Pointer; dwSize: DWORD): BOOL; stdcall;
    VirtualUnlock: function (lpAddress: Pointer; dwSize: DWORD): BOOL; stdcall;

    VirtualAlloc: function (lpvAddress: Pointer; dwSize, flAllocationType, flProtect: DWORD): Pointer; stdcall;
    VirtualAllocEx: function (hProcess: THandle; lpAddress: Pointer; dwSize, flAllocationType: DWORD; flProtect: DWORD): Pointer; stdcall;
    VirtualFree: function (lpAddress: Pointer; dwSize, dwFreeType: DWORD): BOOL; stdcall;
    VirtualFreeEx: function (hProcess: THandle; lpAddress: Pointer; dwSize, dwFreeType: DWORD): Pointer; stdcall;

    VirtualQuery: function (lpAddress: Pointer; var lpBuffer: TMemoryBasicInfo; dwLength: DWORD): DWORD; stdcall;
    VirtualQueryEx: function (hProcess: THandle; lpAddress: Pointer; var lpBuffer: TMemoryBasicInfo; dwLength: DWORD): DWORD; stdcall;

    GlobalAlloc: function (uFlags: UINT; dwBytes: DWORD): HGLOBAL; stdcall;
    GlobalReAlloc: function (hMem: HGLOBAL; dwBytes: DWORD; uFlags: UINT): HGLOBAL; stdcall;
    GlobalLock: function (hMem: HGLOBAL): Pointer; stdcall;
    GlobalHandle: function (Mem: Pointer): HGLOBAL; stdcall;
    GlobalUnlock: function (hMem: HGLOBAL): BOOL; stdcall;
    GlobalFree: function (hMem: HGLOBAL): HGLOBAL; stdcall;
    GlobalCompact: function (dwMinFree: DWORD): UINT; stdcall;
    GlobalFix: procedure (hMem: HGLOBAL); stdcall;
    GlobalUnfix: procedure (hMem: HGLOBAL); stdcall;


    HeapCreate: function (flOptions, dwInitialSize, dwMaximumSize: DWORD): THandle; stdcall;
    HeapDestroy: function (hHeap: THandle): BOOL; stdcall;
    HeapAlloc: function (hHeap: THandle; dwFlags, dwBytes: DWORD): Pointer; stdcall;
    HeapReAlloc: function (hHeap: THandle; dwFlags: DWORD; lpMem: Pointer; dwBytes: DWORD): Pointer; stdcall;
    HeapFree: function (hHeap: THandle; dwFlags: DWORD; lpMem: Pointer): BOOL; stdcall;
    HeapSize: function (hHeap: THandle; dwFlags: DWORD; lpMem: Pointer): DWORD; stdcall;
    HeapValidate: function (hHeap: THandle; dwFlags: DWORD; lpMem: Pointer): BOOL; stdcall;
    HeapCompact: function (hHeap: THandle; dwFlags: DWORD): UINT; stdcall;
    HeapLock: function (hHeap: THandle): BOOL; stdcall;
    HeapUnlock: function (hHeap: THandle): BOOL; stdcall;
    HeapWalk: function (hHeap: THandle; var lpEntry: TProcessHeapEntry): BOOL; stdcall;
  end;


const
  { Global Memory Flags }
  GMEM_FIXED        = 0;
  GMEM_MOVEABLE     = 2;
  GMEM_NOCOMPACT    = $10;
  GMEM_NODISCARD    = $20;
  GMEM_ZEROINIT     = $40;
  GMEM_MODIFY       = $80;
  GMEM_DISCARDABLE  = $100;
  GMEM_NOT_BANKED   = $1000;
  GMEM_SHARE        = $2000;
  GMEM_DDESHARE     = $2000;
  GMEM_NOTIFY       = $4000;
  GMEM_LOWER        = GMEM_NOT_BANKED;
  GMEM_VALID_FLAGS  = 32626;
  GMEM_INVALID_HANDLE = $8000;

  GHND = GMEM_MOVEABLE or GMEM_ZEROINIT;
  GPTR = GMEM_FIXED or GMEM_ZEROINIT;

implementation

end.
