unit BaseWinThread;

interface

uses
  BaseRun,
  Windows;
  
type
  PSysWinThread       = ^TSysWinThread;
  TSysWinThread       = record
    ThreadHandle      : THandle;
    ThreadId          : DWORD;
    RunStatus         : TThreadRunStatus;
  end;
  
implementation

end.
