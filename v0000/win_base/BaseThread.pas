unit BaseThread;

interface
             
type
  PSysThread          = ^TSysThread;
  TSysThread          = record
    ThreadHandle      : THandle;
    ThreadId          : Cardinal;
    IsActiveStatus    : Integer;
  end;
  
implementation

end.
