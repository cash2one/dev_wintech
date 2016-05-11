unit uiwin.wndproc_paint;

interface
                
uses                                                                       
  Windows, Messages, uiwin.wnd;
     
  function WndProcW_WMPaint(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT; 
  function WndProcW_WMPaintIcon(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;    
  function WndProcW_WMNCPaint(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;    
  function WndProcW_WMEraseBkgnd(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;

implementation

function WndProcW_WMPaint(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  tmpDC: HDC;
  tmpPaintStruct: TPaintStruct;
begin
  Result := 0;   
  tmpDC := Windows.BeginPaint(AUIWnd.WndHandle, tmpPaintStruct);
  if 0 <> tmpDC then
  begin  
  end;
  EndPaint(AUIWnd.WndHandle, tmpPaintStruct);
end;

function WndProcW_WMPaintIcon(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_PAINTICON, wParam, lParam);
end;

function WndProcW_WMNCPaint(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_NCPAINT, wParam, lParam);
end;

function WndProcW_WMEraseBkgnd(AUIWnd: PWndUI; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWnd.WndHandle, WM_ERASEBKGND, wParam, lParam);
end;

end.
