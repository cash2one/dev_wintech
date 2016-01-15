unit BaseWinProcess;

interface
       
uses
  Windows;
  
type
  PProcess        = ^TProcess;
  PRunProcess     = ^TRunProcess;

  TProcess        = record
    ProcessHandle : THandle;
    ProcessId     : DWORD;
    Run           : PRunProcess;
  end;

  TRunProcess     = record
    ProcessInfo   : TProcessInformation;
    StartInfoA    : TStartupInfoA;
    StartInfoW    : TStartupInfoW;
  end;

  procedure RunProcessA(AProcess: PProcess; ARunProcess: PRunProcess = nil);

  function CheckOutProcess: PProcess; 
  procedure CheckInProcess(var AProcess: PProcess);

  function CheckOutRunProcess: PRunProcess;
  procedure CheckInRunProcess(var ARunProcess: PRunProcess);

implementation

function CheckOutProcess: PProcess;
begin
  Result := System.New(PProcess);
  FillChar(Result^, SizeOf(TProcess), 0);
end;

procedure CheckInProcess(var AProcess: PProcess);
begin

end;

function CheckOutRunProcess: PRunProcess;
begin
  Result := System.New(PRunProcess);
  FillChar(Result^, SizeOf(TRunProcess), 0);
end;

procedure CheckInRunProcess(var ARunProcess: PRunProcess);
begin

end;

procedure RunProcessA(AProcess: PProcess; ARunProcess: PRunProcess = nil);
begin
  if Windows.CreateProcessA(nil, nil, nil, nil, false, CREATE_NEW, nil, nil,
      AProcess.Run.StartInfoA, AProcess.Run.ProcessInfo) then
  begin
    AProcess.ProcessHandle := AProcess.Run.ProcessInfo.hProcess;
    AProcess.ProcessId := AProcess.Run.ProcessInfo.dwProcessId;
  end;
end;

end.
