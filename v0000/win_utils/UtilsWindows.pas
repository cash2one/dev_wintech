unit UtilsWindows;

interface

uses
  Windows, Sysutils;

  function GetWndClassName(AWnd: HWND): AnsiString;
  function GetWndTextName(AWnd: HWND): AnsiString;  
  procedure ForceBringFrontWindow(AWnd: HWND);       
  procedure SimulateKeyPress(AKeyCode: Byte; ASleep: Integer); 
  function ClickButtonWnd(AWnd: HWND): Boolean;
  function InputEditWnd(AWnd: HWND; AValue: AnsiString): Boolean;

implementation

uses
  UtilsApplication;
                                     
function InputEditWnd(AWnd: HWND; AValue: AnsiString): Boolean;
var
  i: integer;
  tmpValue: AnsiString;
  tmpKeyCode: Byte;
begin
  Result := false;
  if not IsWindow(AWnd) then
    exit;
  ForceBringFrontWindow(AWnd);
  SleepWait(20);
  for i := 1 to 8 do
  begin
    SimulateKeyPress(VK_BACK, 20);
    SimulateKeyPress(VK_DELETE, 20);
  end;
  tmpValue := UpperCase(AValue);
  for i := 1 to Length(tmpValue) do
  begin
    if '.' = tmpValue[i] then
    begin
      tmpKeyCode := VK_DECIMAL;
    end else
    begin
      tmpKeyCode := Byte(tmpValue[i]);
    end;
    SimulateKeyPress(tmpKeyCode, 20);
  end;      
  Result := true;
end;

procedure ForceBringFrontWindow(AWnd: HWND);
var
  wnd: HWND;
  processid: DWORD;
begin
  wnd := GetForegroundWindow;
  GetWindowThreadProcessId(wnd, processid);
  AttachThreadInput(processid, GetCurrentThreadId(), TRUE);
  if Windows.GetForegroundWindow <> AWnd then
  begin
    SetForegroundWindow(AWnd);
  end;
  if Windows.GetFocus <> AWnd then
  begin
    SetFocus(AWnd);
  end;
//  wnd := GetForegroundWindow;
//  GetWindowThreadProcessId(wnd, processid);
  AttachThreadInput(processid, GetCurrentThreadId(), FALSE);
end;

function GetWndClassName(AWnd: HWND): AnsiString;
var
  tmpAnsi: array[0..255] of AnsiChar;
begin
  FillChar(tmpAnsi, SizeOf(tmpAnsi), 0);
  GetClassNameA(AWnd, @tmpAnsi[0], Length(tmpAnsi));
  Result := lowercase(tmpAnsi);
end;

function GetWndTextName(AWnd: HWND): AnsiString;
var  
  tmpAnsi: array[0..255] of AnsiChar;
begin
  FillChar(tmpAnsi, SizeOf(tmpAnsi), 0);
  GetWindowTextA(AWnd, @tmpAnsi[0], Length(tmpAnsi));
  Result := lowercase(tmpAnsi);
end;

procedure SimulateKeyPress(AKeyCode: Byte; ASleep: Integer);
var
  tmpSleep: integer;
begin
  Windows.keybd_event(AKeyCode, MapVirtualKey(AKeyCode, 0), 0, 0) ;//#a¼üÎ»ÂëÊÇ86
  Windows.keybd_event(AKeyCode, MapVirtualKey(AKeyCode, 0), KEYEVENTF_KEYUP, 0);
  tmpSleep := ASleep;
  while 0 < tmpSleep do
  begin
    UtilsApplication.SleepWait(10);
    //Application.ProcessMessages;
    tmpSleep := tmpSleep - 10;
  end;
end;

function ClickButtonWnd(AWnd: HWND): Boolean;
var
  tmpRect: TRect;
begin
  Result := false;
  if IsWindow(AWnd) then
  begin
    ForceBringFrontWindow(AWnd);
    GetWindowRect(AWnd, tmpRect);
    Windows.SetCursorPos((tmpRect.Left + tmpRect.Right) div 2, (tmpRect.Top + tmpRect.Bottom) div 2);
    SleepWait(20);
    Windows.mouse_event(MOUSEEVENTF_LEFTDOWN or MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    SleepWait(20);
    Result := true;
  end;
end;

end.
