unit UIBaseWin;

interface

uses
  Windows,
  BaseWinThread;
                
type
  PUIBaseWnd        = ^TUIBaseWnd;
  TUIBaseWnd        = packed record
    UIWndHandle     : HWND;
    UIWndParent     : HWND;
    Style           : DWORD;
    ExStyle         : DWORD;
    WindowRect      : TRect;
    ClientRect      : TRect;
    WinThread       : PSysWinThread;
  end;

  function CreateUIWnd(AUIWnd: PUIBaseWnd; AWndProc: TFNWndProc): Boolean;
  
implementation

function CreateUIWnd(AUIWnd: PUIBaseWnd; AWndProc: TFNWndProc): Boolean;
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

  AUIWnd.UIWndHandle := Windows.CreateWindowExA(
    AUIWnd.ExStyle,
    tmpRegWndClass.lpszClassName,
    '',
    AUIWnd.Style {+ 0},
    AUIWnd.WindowRect.Left,
    AUIWnd.WindowRect.Top,
    AUIWnd.ClientRect.Right,
    AUIWnd.ClientRect.Bottom, 0, 0, HInstance, nil);
  Result := IsWindow(AUIWnd.UIWndHandle);  
end;

end.
