unit BaseWinThread;

interface

uses
  BaseRun,
  BaseThread,
  Windows;
  
type
  PSysWinThread       = ^TSysWinThread;
  TSysWinThread       = record
    Core              : TSysThread;
    RunStatus         : TThreadRunStatus;
  end;
  
implementation

end.
