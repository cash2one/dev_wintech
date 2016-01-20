unit HostWnd_chromium;

interface

uses
  Windows,
  UIBaseWin;
  
type
  PHostWndChromium = ^THostWndChromium;
  THostWndChromium = record
    BaseWnd: TUIBaseWnd;
  end;

  procedure CreateHostWndChromium(AHostWnd: PHostWndChromium);
  
implementation

uses
  UIBaseWndProc;

var
  HostWnd: PUIBaseWnd = nil;
                
function HostWndProcA(AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): HRESULT; stdcall;
begin
  Result := UIWndProcA(HostWnd, AWnd, AMsg, wParam, lParam);
end;

procedure CreateHostWndChromium(AHostWnd: PHostWndChromium);
begin
  HostWnd := @AHostWnd.BaseWnd;
  CreateUIWndA(HostWnd, @HostWndProcA);
end;

end.
