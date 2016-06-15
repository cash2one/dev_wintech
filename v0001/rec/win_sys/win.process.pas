unit win.process;

interface

uses
  Windows;
               
type
  POwnedProcess   = ^TOwnedProcess;
  PExProcess      = ^TExProcess;
  PRunProcess     = ^TRunProcess;
  PCoreProcess    = ^TCoreProcess;
  
  TCoreProcess    = record
    ProcessHandle : THandle;
    ProcessId     : DWORD;  
    AppCmdWnd     : HWND;
  end;
  
  { 自身运行进程控制 }
  TOwnedProcess   = record
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

  procedure RunProcessA(AProcess: POwnedProcess; AExeFileUrl: AnsiString; ARunProcess: PRunProcess = nil);

implementation

procedure RunProcessA(AProcess: POwnedProcess; AExeFileUrl: AnsiString; ARunProcess: PRunProcess = nil);
var
  tmpIsOwnedRun: Boolean;
begin
  tmpIsOwnedRun := false;
  AProcess.Run := ARunProcess;
  if nil = AProcess.Run then
  begin
    tmpIsOwnedRun := true;
    AProcess.Run := System.New(PRunProcess);
    FillChar(AProcess.Run^, SizeOf(TRunProcess), 0);
    AProcess.Run.StartInfoA.cb := SizeOf(AProcess.Run.StartInfoA);
    AProcess.Run.StartInfoW.cb := SizeOf(AProcess.Run.StartInfoW);    
  end;
  if Windows.CreateProcessA(
      PAnsiChar(AExeFileUrl), //lpApplicationName: PAnsiChar;
      nil, //lpCommandLine: PAnsiChar;
      nil, //lpProcessAttributes,
      nil, //lpThreadAttributes: PSecurityAttributes;
      false, //bInheritHandles: BOOL;
      CREATE_SUSPENDED,//CREATE_NEW, //dwCreationFlags: DWORD;
      nil, //lpEnvironment: Pointer;
      nil, //lpCurrentDirectory: PAnsiChar;
      AProcess.Run.StartInfoA, //const lpStartupInfo: TStartupInfoA;
      AProcess.Run.ProcessInfo) //var lpProcessInformation: TProcessInformation
      then
  begin
    AProcess.Core.ProcessHandle := AProcess.Run.ProcessInfo.hProcess;
    AProcess.Core.ProcessId := AProcess.Run.ProcessInfo.dwProcessId;

    Windows.ResumeThread(AProcess.Run.ProcessInfo.hThread);
    Sleep(1);
  end;
  if tmpIsOwnedRun then
  begin
    FillChar(AProcess.Run^, SizeOf(TRunProcess), 0);
    FreeMem(AProcess.Run);
    AProcess.Run := nil;
  end;
end;

end.
