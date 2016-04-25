unit uiwindow_wndproc_uispace;

interface
                  
uses
  Windows,
  Messages,
  uiwindow;
  
  function UIWndProcW_UISpace(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;

implementation
                
function WndProcW_WMNCCALCSIZE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCCALCSIZE, wParam, lParam);
end;
                                   
function WndProcW_WMSIZE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_SIZE, wParam, lParam);
end;
                                  
function WndProcW_WMMOVE(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_MOVE, wParam, lParam);
end;
                                  
function WndProcW_WMWINDOWPOSCHANGING(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_WINDOWPOSCHANGING, wParam, lParam);
end;
        
function WndProcW_WMWINDOWPOSCHANGED(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_WINDOWPOSCHANGED, wParam, lParam);
end;

function UIWndProcW_UISpace(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;
begin
  Result := true;
  case AMsg of
    WM_NCCALCSIZE: begin
      AWndProcResult := WndProcW_WMNCCALCSIZE(AUIWindow, wParam, lParam);
      //CalcValidRects: BOOL;
      //CalcSize_Params: PNCCalcSizeParams;
      if nil <> PNCCalcSizeParams(lParam) then
      begin
        // 
        if 0 = PNCCalcSizeParams(lParam).rgrc[0].Left then
        begin        
        end;
      end;
    end;
    WM_SIZE: begin
      AWndProcResult := WndProcW_WMSIZE(AUIWindow, wParam, lParam);
      Windows.GetClientRect(AUIWindow.BaseWnd.UIWndHandle, AUIWindow.WndClientRect);
    end;
    WM_MOVE: AWndProcResult := WndProcW_WMMOVE(AUIWindow, wParam, lParam);
    WM_WINDOWPOSCHANGING: AWndProcResult := WndProcW_WMWINDOWPOSCHANGING(AUIWindow, wParam, lParam);
    WM_WINDOWPOSCHANGED: AWndProcResult := WndProcW_WMWINDOWPOSCHANGED(AUIWindow, wParam, lParam);
    else
      Result := false;
  end;     
end;

end.
