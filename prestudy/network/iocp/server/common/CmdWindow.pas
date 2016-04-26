unit CmdWindow;

interface

uses
  Windows, win.Thread;
  
type
  PCommandWindow    = ^TCommandWindow;
  TCommandWindow    = record
    WindowHandle    : HWND;
    WindowMsgThread : TSysWinThread;
    Msg             : Windows.TMsg;
    Style           : DWORD;
    ExStyle         : DWORD;
  end;

  function CreateCommandWindow(AWindow: PCommandWindow; AWndProc: TFNWndProc; AWndClassName: AnsiString):Boolean;   
  procedure DestroyCommandWindow(AWindow: PCommandWindow);  
  
implementation
         
function CreateCommandWindow(AWindow: PCommandWindow; AWndProc: TFNWndProc; AWndClassName: AnsiString): Boolean;
var
  tmpIsRegistered: Boolean;
  tmpCheckWndClass: TWndClassA;     
  tmpRegWndClass: TWndClassA;
begin                    
  //SDLogutils.Log(logtag, 'InternalCreateInjectWindow begin');
  FillChar(tmpRegWndClass, SizeOf(tmpRegWndClass), 0);
  tmpRegWndClass.hInstance := HInstance;
  if nil = AWndProc then
  begin
    Result := false;
    Exit;                              
    //tmpRegWndClass.lpfnWndProc := @AppWndProcA;
  end else
  begin                                        
    tmpRegWndClass.lpfnWndProc := AWndProc;
  end;
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
    Windows.RegisterClassA(tmpRegWndClass);
  end;
  AWindow.WindowHandle := Windows.CreateWindowExA(
    WS_EX_TOOLWINDOW,
    tmpRegWndClass.lpszClassName,
    '',
    WS_POPUP {+ 0}, 0, 0, 0, 0, HWND_MESSAGE, 0, HInstance, nil);
  SetParent(AWindow.WindowHandle, HWND_MESSAGE);
  Result := IsWindow(AWindow.WindowHandle);
end;

procedure DestroyCommandWindow(AWindow: PCommandWindow);
begin

end;

end.
