unit BaseWinThread;

interface

uses
  Windows;
  
type                    
  PSysWinThread     = ^TSysWinThread;
  TSysWinThread     = record
    ThreadHandle    : THandle;
    ThreadId        : DWORD;
  end;
  
implementation

end.
