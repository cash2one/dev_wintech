unit AppWindow;

interface

uses
  Windows, Messages, CmdWindow;
  
type
  PAppWindow      = ^TAppWindow;
  TAppWindow      = record
    CommandWindow : TCommandWindow;
  end;

  TProc = procedure;
  
  function AppWndProcA(AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;

var
  AppStartProc: TProc = nil;
    
implementation

uses
  Define_Message;
          
function AppWndProcA(AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := 0;
  case AMsg of
    WM_COPYDATA: begin

    end;
    WM_AppStart: begin
      if Assigned(AppStartProc) then
      begin
        AppStartProc;
      end;
    end
    else
      Result := DefWindowProcA(AWnd, AMsg, wParam, lParam);
  end;
end;
    
end.
