unit BaseWinIocp;

interface

type
  PWinIocp          = ^TWinIocp;
  TWinIocp          = record
    IocpHandle      : THandle;
  end;

  function CheckOutWinIocp: PWinIocp;
  procedure CheckInWinIocp(var AWinIocp: PWinIocp);
  procedure InitializeWinIocp(AWinIocp: PWinIocp);
  procedure FinalizeWinIocp(AWinIocp: PWinIocp);

implementation

uses
  Windows, BaseMemory;
  
function CheckOutWinIocp: PWinIocp;
begin
  Result := GetMemory(nil, SizeOf(TWinIocp));
  if nil <> Result then
  begin
    FillChar(Result^, SizeOf(TWinIocp), 0);
  end;
end;

procedure CheckInWinIocp(var AWinIocp: PWinIocp);
begin
  if nil = AWinIocp then
    exit;
  FinalizeWinIocp(AWinIocp);
  FreeMem(AWinIocp);
end;

procedure InitializeWinIocp(AWinIocp: PWinIocp);
begin
  AWinIocp.IocpHandle := Windows.CreateIoCompletionPort(INVALID_HANDLE_VALUE, 0, 0, 0);
end;

procedure FinalizeWinIocp(AWinIocp: PWinIocp);
begin

end;

end.
