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
  
implementation

end.
