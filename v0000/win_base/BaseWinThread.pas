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
    OleInitStatus     : Integer; // CoInitialize(nil);
    RunStatus         : TThreadRunStatus;
  end;
  
implementation

end.
