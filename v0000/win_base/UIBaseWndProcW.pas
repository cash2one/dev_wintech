unit UIBaseWndProcW;

interface

uses
  Windows, Messages, UIBaseWin;

  function UIWndProcW(AWindow: PUIBaseWnd; AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): HRESULT;

implementation

function UIWndProcW(AWindow: PUIBaseWnd; AWnd: HWND; AMsg: UINT; wParam: WPARAM; lParam: LPARAM): HRESULT;
begin
  case AMsg of
    WM_WINDOWPOSCHANGING: begin

    end;
    WM_WINDOWPOSCHANGED: begin
      if ((PWindowPos(LParam).flags and SWP_NOMOVE) = 0) then
      begin
        AWindow.WindowRect.Left := PWindowPos(LParam).x;
        AWindow.WindowRect.Top := PWindowPos(LParam).y;
        AWindow.WindowRect.Right := AWindow.WindowRect.Left + AWindow.ClientRect.Right;
        AWindow.WindowRect.Bottom := AWindow.WindowRect.Top + AWindow.ClientRect.Bottom;
      end;
      if ((PWindowPos(LParam).flags and SWP_NOSIZE) = 0) then
      begin
        AWindow.ClientRect.Right := PWindowPos(LParam).cx;
        AWindow.ClientRect.Bottom := PWindowPos(LParam).cy;
        AWindow.WindowRect.Right := AWindow.WindowRect.Left + AWindow.ClientRect.Right;
        AWindow.WindowRect.Bottom := AWindow.WindowRect.Top + AWindow.ClientRect.Bottom;
      end;
    end;
  end;
  Result := DefWindowProcW(AWnd, AMsg, wParam, lParam);
end;

end.
