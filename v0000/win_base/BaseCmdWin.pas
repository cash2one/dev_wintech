unit BaseCmdWin;

interface

uses
  Windows,
  BaseApp,
  BaseWinThread;

type
  PBaseCmdWnd       = ^TBaseCmdWnd;
  TBaseCmdWnd       = packed record
    CmdWndHandle    : HWND;         
    Style           : DWORD;
    ExStyle         : DWORD;
    WinThread       : PSysWinThread;
  end;
                    
  function CreateCmdWndA(ABaseApp: TBaseApp; ACmdWnd: PBaseCmdWnd; AWndProc: TFNWndProc): Boolean; overload;
  function CreateCmdWndA(AWndClassName: AnsiString; ACmdWnd: PBaseCmdWnd; AWndProc: TFNWndProc): Boolean; overload;
  
implementation

function CreateCmdWndA(AWndClassName: AnsiString; ACmdWnd: PBaseCmdWnd; AWndProc: TFNWndProc): Boolean; overload;
var
  tmpRegWndClass: TWndClassA;
  tmpCheckWndClass: TWndClassA;
  tmpIsRegistered: Boolean;
begin
  Result := False;
  if not Assigned(AWndProc) then
    exit;
  FillChar(tmpRegWndClass, SizeOf(tmpRegWndClass), 0);
  FillChar(tmpCheckWndClass, SizeOf(tmpCheckWndClass), 0);
                                       
  tmpRegWndClass.lpszClassName := PAnsiChar(AWndClassName);
    
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
    tmpRegWndClass.lpfnWndProc := AWndProc;
    //tmpRegWndAtom: ATOM;
    if 0 = Windows.RegisterClassA(tmpRegWndClass) then
      exit;
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
  if Result then
  begin
    SetParent(ACmdWnd.CmdWndHandle, HWND_MESSAGE);
  end;
end;

 
function CreateCmdWndA(ABaseApp: TBaseApp; ACmdWnd: PBaseCmdWnd; AWndProc: TFNWndProc): Boolean;
begin
  Result := CreateCmdWndA(ABaseApp.ClassName, ACmdWnd, AWndProc);
end;

end.
