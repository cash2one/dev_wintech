unit BaseThread;

interface

uses
  BaseRun;
               
type
  PSysThread          = ^TSysThread;
  TSysThread          = record
    ThreadHandle      : THandle;
    ThreadId          : Cardinal;
    IsActiveStatus    : Integer; 
    RunStatus         : TThreadRunStatus;
  end;
  
implementation

end.
