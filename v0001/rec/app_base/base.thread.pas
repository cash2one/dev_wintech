unit base.thread;

interface

uses
  base.run;
               
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
