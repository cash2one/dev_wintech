unit BaseCmdWin;

interface

uses
  Windows,
  BaseWinThread;

type
  PBaseCmdWnd       = ^TBaseCmdWnd;
  TBaseCmdWnd       = packed record
    CmdWndHandle    : HWND;         
    Style           : DWORD;
    ExStyle         : DWORD;
    WinThread       : PSysWinThread;
  end;
                    
  function CreateCmdWnd(ACmdWnd: PBaseCmdWnd; AWndProc: TFNWndProc): Boolean;

implementation

function CreateCmdWnd(ACmdWnd: PBaseCmdWnd; AWndProc: TFNWndProc): Boolean;
var
  tmpRegWndClass: TWndClassA;
  tmpCheckWndClass: TWndClassA;
  tmpIsRegistered: Boolean;
begin
  tmpIsRegistered := Windows.GetClassInfoA(HInstance, tmpRegWndClass.lpszClassName, tmpCheckWndClass);
  if tmpIsRegistered then
  begin
    if tmpCheckWndClass.lpfnWndProc <> AWndProc then
    begin
      Windows.UnregisterClass(tmpRegWndClass.lpszClassName, HInstance);
      tmpIsRegistered := false;
    end;
  end;
  if not tmpIsRegistered then
  begin
    Windows.RegisterClassA(tmpRegWndClass);
  end;

  ACmdWnd.CmdWndHandle := Windows.CreateWindowExA(
    ACmdWnd.ExStyle,
    tmpRegWndClass.lpszClassName,
    '',
    ACmdWnd.Style {+ 0},
    0,
    0,
    0,
    0, 0, 0, HInstance, nil);
  Result := IsWindow(ACmdWnd.CmdWndHandle);  
end;

end.
