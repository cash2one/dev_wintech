unit win.thread;

interface

uses
  BaseThread;

type
  PSysWinThread       = ^TSysWinThread;
  TSysWinThread       = record
    Core              : TSysThread;        
    OleInitStatus     : Integer; // CoInitialize(nil);
  end;
(*//
  Sleep(0)：时间片只能让给优先级相同或更高的线程； 
  SwitchToThread()：只要有可调度线程，即便优先级较低，也会让其调度
//*)

implementation

end.
