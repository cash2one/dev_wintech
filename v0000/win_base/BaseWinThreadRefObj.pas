unit BaseWinThreadRefObj;

interface

uses
  Windows;

type           
(*
  用事件（Event）来同步线程是最具弹性的了。一个事件有两种状态：
  激发状态和未激发状态。也称有信号状态和无信号状态。事件又分两种类型：
  手动重置事件和自­动重置事件。手动重置事件被设置为激发状态后，会唤醒
  所有等待的线程，而且一直保持为激发状态，直到程序重新把它设置为未激发
  状态。自动重置事件被设置为激发状­态后，会唤醒“一个”等待中的线程，
  然后自动恢复为未激发状态。所以用自动重置事件来同步两个线程比较理想
*)
  PEvent      = ^TEvent;
  TEvent      = record
    Status    : Integer;
    Handle    : THandle;
  end;

(*
  使用临界区域的第一个忠告就是不要长时间锁住一份资源。这里的长时间是相对的，
  视不同程序而定。对一些控制软件来说，可能是数毫秒，但是对另外一些程序来说，
  可­以长达数分钟。但进入临界区后必须尽快地离开，释放资源
*)
  PWinLock    = ^TWinLock;
  TWinLock    = record
    Status    : Integer;
    Handle    : TRTLCriticalSection;
  end;

(*
  互斥器的功能和临界区域很相似。区别是：
      Mutex所花费的时间比Critical Section多的多，
      但是Mutex是核心对象(Event、Semaphore也是)，
      可以跨进程使用，而且等待一个被锁住的Mutex可以设定TIMEO­UT，
      不会像CriticalSection那样无法得知临界区域的情况，而一直死等
*)
  PMutex      = ^TMutex;
  TMutex      = record  
    Status    : Integer;
    Handle    : THandle;
  end;

(*
  信号量（Semaphores）
    信号量对象对线程的同步方式与前面几种方法不同，信号允许多个线程同时使用共享资源，
    这与操作系统中的PV操作相同。它指出了同时访问共享资源的线程最大数目。它允许多个
    线程在同一时刻访问同一资源，但是需要限制在同一时刻访问此资源的最大线程数目。
    在用CreateSemaphore（）创建信号量时即要同时指出允许的最大资源计数和当前可用资源
    计数。一般是将当前可用资源计数设置为最大资源计数，每增加一个线程对共享资源的访问，
    当前可用资源计数就会减1，只要当前可用资源计数是大于0的，就可以发出信号量信号。
    但是当前可用计数减小到0时则说明当前占用资源的线程数已经达到了所允许的最大数目，
    不能在允许其他线程的进入，此时的信号量信号将无法发出。线程在处理完共享资源后，
    应在离开的同时通过ReleaseSemaphore（）函数将当前可用资源计数加1。在任何时候当前
    可用资源计数决不可能大于最大资源计数。 信号量是通过计数来对线程访问资源进行控制
    的，而实际上信号量确实也被称作Dijkstra计数器
    信号量是最具历史的同步机制。信号量是解决producer/consumer问题的关键要素
*)
  PSemaphore  = ^TSemaphore;
  TSemaphore  = record
    Status    : Integer;
    Handle    : THandle;
  end;
  
  function CheckOutWinLock: PWinLock;
  procedure CheckInWinLock(var AWinLock: PWinLock);
  procedure InitializeWinLock(AWinLock: PWinLock);
  procedure FinalizeWinLock(AWinLock: PWinLock);
  procedure LockWinLock(AWinLock: PWinLock);
  procedure UnLockWinLock(AWinLock: PWinLock);

  function CheckOutMutex: PMutex;
  procedure CheckInMutex(var AMutex: PMutex);
  procedure InitializeMutex(AMutex: PMutex);
  procedure FinalizeMutex(AMutex: PMutex);
  procedure WaitMutex(AMutex: PMutex);

  function CheckOutEvent: PEvent;
  procedure CheckInEvent(var AEvent: PEvent);
  procedure InitializeEvent(AEvent: PEvent);
  procedure FinalizeEvent(AEvent: PEvent);

  function CheckOutSemaphore: PSemaphore;  
  procedure CheckInSemaphore(var ASemaphore: PSemaphore);
  procedure InitializeSemaphore(ASemaphore: PSemaphore);
  procedure FinalizeSemaphore(ASemaphore: PSemaphore);
  procedure WaitSemaphore(ASemaphore: PSemaphore);

implementation

function CheckOutWinLock: PWinLock;
begin
  Result := System.New(PWinLock);
  FillChar(Result^, SizeOf(TWinLock), 0);
end;

procedure CheckInWinLock(var AWinLock: PWinLock);
begin
  if nil = AWinLock then
    exit;
  FinalizeWinLock(AWinLock);
  FreeMem(AWinLock);
  AWinLock := nil;
end;

procedure InitializeWinLock(AWinLock: PWinLock);
begin
  InitializeCriticalSection(AWinLock.Handle);
end;

procedure FinalizeWinLock(AWinLock: PWinLock);
begin
  DeleteCriticalSection(AWinLock.Handle);
end;
              
procedure LockWinLock(AWinLock: PWinLock);
begin
  EnterCriticalSection(AWinLock.Handle);
end;

procedure UnLockWinLock(AWinLock: PWinLock);
begin
  LeaveCriticalSection(AWinLock.Handle);
end;

function CheckOutMutex: PMutex;
begin
  Result := System.New(PMutex);
  FillChar(Result^, SizeOf(TMutex), 0);
end;

procedure CheckInMutex(var AMutex: PMutex);
begin

end;

procedure InitializeMutex(AMutex: PMutex);
begin
  AMutex.Handle := Windows.CreateMutexA(nil, False, '');    
  AMutex.Handle := Windows.OpenMutexA(0, False, '');
end;

procedure FinalizeMutex(AMutex: PMutex);
begin
  ReleaseMutex(AMutex.Handle);
end;

procedure WaitMutex(AMutex: PMutex);
begin
  WaitForSingleObject(AMutex.Handle, INFINITE);
  //WaitForMultipleObjects();  
end;

function CheckOutEvent: PEvent;
begin
  Result := System.New(PEvent);
  FillChar(Result^, SizeOf(TEvent), 0);
end;

procedure CheckInEvent(var AEvent: PEvent);
begin
end;

procedure InitializeEvent(AEvent: PEvent);
begin         
  AEvent.Handle := Windows.CreateEventA(nil, false, false, '');    
  AEvent.Handle := Windows.OpenEventA(0, false, '');
end;

procedure FinalizeEvent(AEvent: PEvent);
begin

end;

function CheckOutSemaphore: PSemaphore;
begin
  Result := System.New(PSemaphore);
  FillChar(Result^, SizeOf(TSemaphore), 0);
end;

procedure CheckInSemaphore(var ASemaphore: PSemaphore);
begin
  FinalizeSemaphore(ASemaphore);
  FreeMem(ASemaphore);
  ASemaphore := nil;
end;

procedure InitializeSemaphore(ASemaphore: PSemaphore);
begin
  ASemaphore.Handle := Windows.CreateSemaphore(nil, 0, 0, '');
  ASemaphore.Handle := Windows.OpenSemaphore(0, False, '');  
end;

procedure FinalizeSemaphore(ASemaphore: PSemaphore);
begin
  Windows.ReleaseSemaphore(ASemaphore.Handle, 0, nil);
end;

procedure WaitSemaphore(ASemaphore: PSemaphore);
begin
  WaitForSingleObject(ASemaphore.Handle, INFINITE);
end;

end.
