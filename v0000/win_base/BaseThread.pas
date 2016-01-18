unit BaseThread;

interface
             
type
  PSysThread          = ^TSysThread;
  TSysThread          = record
    ThreadHandle      : THandle;
    ThreadId          : Cardinal;
  end;
  
implementation

end.
