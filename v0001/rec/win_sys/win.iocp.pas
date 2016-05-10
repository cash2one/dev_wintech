unit win.iocp;

interface

uses
  Windows;
  
type
  PWinIocp    = ^TWinIocp;    
  TWinIocp    = record
    Handle    : THandle;
  end;

  function InitWinIocp(AIocp: PWinIocp): Boolean;
  function IsValidWinIocp(AIocp: PWinIocp): Boolean;

implementation

function InitWinIocp(AIocp: PWinIocp): Boolean;
begin
  if 0 = AIocp.Handle then
  begin
    AIocp.Handle := CreateIoCompletionPort(INVALID_HANDLE_VALUE, 0, 0, 0);
  end;   
  Result := IsValidWinIocp(AIocp);
end;

function IsValidWinIocp(AIocp: PWinIocp): Boolean;
begin
  Result := not ((0 = AIocp.Handle) or (INVALID_HANDLE_VALUE = AIocp.Handle));
end;

end.
