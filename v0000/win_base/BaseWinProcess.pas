unit BaseWinProcess;

interface
       
uses
  Windows, BaseMemory;
  
type
  POwnProcess     = ^TOwnProcess;
  PExProcess      = ^TExProcess;
  PRunProcess     = ^TRunProcess;
  PCoreProcess    = ^TCoreProcess;
  
  TCoreProcess    = record
    ProcessHandle : THandle;
    ProcessId     : DWORD;
  end;
  
  { 自身运行进程控制 }
  TOwnProcess     = record
    Core          : TCoreProcess;
    Run           : PRunProcess;
  end;

  { 外部进程控制 }
  TExProcess      = record
    Core          : TCoreProcess;
  end;

  TRunProcess     = record
    ProcessInfo   : TProcessInformation;
    StartInfoA    : TStartupInfoA;
    StartInfoW    : TStartupInfoW;
  end;

  procedure RunProcessA(AProcess: POwnProcess; ARunProcess: PRunProcess = nil);

  function CheckOutOwnProcess: POwnProcess;
  procedure CheckInOwnProcess(var AProcess: POwnProcess);

  function CheckOutRunProcess: PRunProcess;
  procedure CheckInRunProcess(var ARunProcess: PRunProcess);

implementation

function CheckOutOwnProcess: POwnProcess;
begin
  Result := GetMemory(nil, SizeOf(TOwnProcess));
  if nil <> Result then
  begin
    FillChar(Result^, SizeOf(TOwnProcess), 0);
  end;
end;

procedure CheckInOwnProcess(var AProcess: POwnProcess);
begin                       
end;
                   
function CheckOutExProcess: PExProcess;
begin               
  Result := GetMemory(nil, SizeOf(TExProcess));
  if nil <> Result then
  begin
    FillChar(Result^, SizeOf(TExProcess), 0);
  end;
end;

procedure CheckInExProcess(var AProcess: PExProcess);
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

procedure RunProcessA(AProcess: POwnProcess; ARunProcess: PRunProcess = nil);
begin
  if Windows.CreateProcessA(nil, nil, nil, nil, false, CREATE_NEW, nil, nil,
      AProcess.Run.StartInfoA, AProcess.Run.ProcessInfo) then
  begin
    AProcess.Core.ProcessHandle := AProcess.Run.ProcessInfo.hProcess;
    AProcess.Core.ProcessId := AProcess.Run.ProcessInfo.dwProcessId;
  end;
end;

end.
