unit BaseWinIocp;

interface

uses
  Windows,
  BaseWinThread;
  
type
  PWinIocp          = ^TWinIocp;

  PIocpWorkThread   = ^TIocpWorkThread;
  TIocpWorkThread   = record
    SysThread       : TSysWinThread;
    Iocp            : PWinIocp;
  end;

  TWinIocp          = record
    IocpHandle      : THandle;
    IocpWorkThread  : array[0..255] of TIocpWorkThread;
  end;

  PIocpSession      = ^TIocpSession;
  TIocpSession      = record
    BytesTransfer   : Cardinal;
    CompleteKey     : DWORD;
    Overlap         : POverlapped;
  end;
  
  function CheckOutWinIocp: PWinIocp;
  procedure CheckInWinIocp(var AWinIocp: PWinIocp);
  procedure InitializeWinIocp(AWinIocp: PWinIocp);
  procedure FinalizeWinIocp(AWinIocp: PWinIocp);
                                                 
  procedure OpenIocpWorkThread(AWorkThread: PIocpWorkThread);
  procedure CloseIocpWorkThread(AWorkThread: PIocpWorkThread);

const
  CompleteKey_Close = 1;
    
implementation

uses
  BaseMemory;
  
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

function ThreadProc_IocpWorkThread(AWorkThread: PIocpWorkThread): HResult; stdcall;
var
  tmpIocpSession: TIocpSession;
  tmpIocpHandle: THandle;
begin
  Result := 0;
  if nil <> AWorkThread then
  begin
    if nil <> AWorkThread.Iocp then
    begin
      tmpIocpHandle := AWorkThread.Iocp.IocpHandle;
      while (1 = AWorkThread.SysThread.Core.IsActiveStatus) do
      begin
        Windows.Sleep(1);
        if not GetQueuedCompletionStatus(tmpIocpHandle,
            tmpIocpSession.BytesTransfer,
            tmpIocpSession.CompleteKey,
            POverlapped(tmpIocpSession.Overlap), INFINITE) then
        begin  
          if nil <> tmpIocpSession.Overlap then
          begin
          end;
        end else
        begin
        end;
      end;
    end;
  end;
  Windows.ExitThread(Result);
end;

procedure OpenIocpWorkThread(AWorkThread: PIocpWorkThread);
begin
  AWorkThread.SysThread.Core.ThreadHandle := Windows.CreateThread(nil, 0,
      @ThreadProc_IocpWorkThread, AWorkThread,
      CREATE_SUSPENDED, AWorkThread.SysThread.Core.ThreadID);
  Windows.ResumeThread(AWorkThread.SysThread.Core.ThreadHandle);
end;

procedure CloseIocpWorkThread(AWorkThread: PIocpWorkThread);
begin
  if nil = AWorkThread then
    exit;
  if nil = AWorkThread.Iocp then
    exit;
  if PostQueuedCompletionStatus(AWorkThread.Iocp.IocpHandle, 0, CompleteKey_Close, nil) then
  begin  
  end;
end;

(*//
  GetOverlappedResult
  WSAGetOverlappedResult
//*)
end.
