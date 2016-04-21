unit uiwindow_wndproc_paint;

interface
           
uses
  Windows, 
  Messages,
  uiwindow_refresh;
                 
  function UIWndProcA_Paint(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;

implementation

var
  tmpBrush: HBRUSH = 0;
                    
function WndProcA_WMPaint(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  tmpPS: TPaintStruct;
  tmpDC: HDC;
  tmpLogBrush: TLogBrush;
begin
  Result := 0;
  tmpDC := Windows.BeginPaint(AUIWindow.BaseWnd.UIWndHandle, tmpPS);

  if 0 = tmpBrush then
  begin
    tmpLogBrush.lbStyle := BS_SOLID;
    tmpLogBrush.lbColor := $EFEFEF;
    tmpLogBrush.lbHatch := 0;
    tmpBrush := CreateBrushIndirect(tmpLogBrush);
  end;
  FillRect(tmpDC, AUIWindow.BaseWnd.ClientRect, tmpBrush);

  EndPaint(AUIWindow.BaseWnd.UIWndHandle, tmpPS);
//  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_Paint, wParam, lParam);
end;

function WndProcA_WMPaintIcon(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_PAINTICON, wParam, lParam);
end;

function WndProcA_WMNCPaint(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_NCPAINT, wParam, lParam);
end;

function WndProcA_WMEraseBkgnd(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcA(AUIWindow.BaseWnd.UIWndHandle, WM_ERASEBKGND, wParam, lParam);
end;

function UIWndProcA_Paint(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;
begin
  Result := true;
  case AMsg of
    WM_PAINT: AWndProcResult := WndProcA_WMPaint(AUIWindow, wParam, lParam);
    WM_PAINTICON: AWndProcResult := WndProcA_WMPaintIcon(AUIWindow, wParam, lParam);
    WM_NCPAINT: AWndProcResult := WndProcA_WMNCPaint(AUIWindow, wParam, lParam);
    WM_ERASEBKGND: AWndProcResult := WndProcA_WMEraseBkgnd(AUIWindow, wParam, lParam);
    else
      Result := false;
  end;     
end;

end.
