unit BaseWinThread;

interface

uses
  BaseThread,
  Windows;
  
type
  PSysWinThread       = ^TSysWinThread;
  TSysWinThread       = record
    Core              : TSysThread;        
    OleInitStatus     : Integer; // CoInitialize(nil);
  end;
  
implementation

end.
