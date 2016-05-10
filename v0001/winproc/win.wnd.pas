unit win.wnd;

interface

uses
  Windows;
  
  function CreateCommandWndA(AWndProc: TFNWndProc; AWndClassName: AnsiString): HWND;

implementation

function CreateCommandWndA(AWndProc: TFNWndProc; AWndClassName: AnsiString): HWND;
var
  tmpIsRegistered: Boolean;
  tmpCheckWndClass: TWndClassA;     
  tmpRegWndClass: TWndClassA;
begin                    
  //SDLogutils.Log(logtag, 'InternalCreateInjectWindow begin');
  Result := 0;
  if nil = AWndProc then
    Exit;
  FillChar(tmpRegWndClass, SizeOf(tmpRegWndClass), 0);
  tmpRegWndClass.hInstance := HInstance;
    //tmpRegWndClass.lpfnWndProc := @AppWndProcA;
  tmpRegWndClass.lpfnWndProc := AWndProc;
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
  Result := Windows.CreateWindowExA(
    WS_EX_TOOLWINDOW,
    tmpRegWndClass.lpszClassName,
    '',
    WS_POPUP {+ 0}, 0, 0, 0, 0, HWND_MESSAGE, 0, HInstance, nil);
  if IsWindow(Result) then
  begin
    SetParent(Result, HWND_MESSAGE);
  end else
    Result := 0;
end;

end.
