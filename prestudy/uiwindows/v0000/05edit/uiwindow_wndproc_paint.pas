unit uiwindow_wndproc_paint;

interface
           
uses
  Windows, 
  Messages,
  uiwin.memdc,
  uiwindow;
                 
  function UIWndProcW_Paint(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;
  procedure UIWindowPaint(AUIWindow: PUIWindow; AMemDC: PWinMemDC); overload;
  procedure UIWindowPaint(AUIWindow: PUIWindow); overload;

implementation

uses
  uiwindow_wndproc_mouse;
  
var
  tmpBrush: HBRUSH = 0;
  tmpClearBrush: HBRUSH = 0;
  tmpRectBrush: HBRUSH = 0;
  tmpPen: HPEN = 0;

(*//                                   
procedure _DrawFocusRect(Canvas: TCanvas; ARect: TRect);
var
  AOldBrush: TBrush;
  AOldPen: TPen;
begin
  AOldBrush := TBrush.Create;
  AOldPen := TPen.Create;
  try
    AOldBrush.Assign(Canvas.Brush);
    AOldPen.Assign(Canvas.Pen);
    Canvas.Brush.Style := bsClear;
    Canvas.Rectangle(ARect);
  finally
    Canvas.Pen.Assign(AOldPen);
    Canvas.Brush.Assign(AOldBrush);
    AOldBrush.Free;
    AOldPen.Free;
  end;
end;
//*)


//  TPenStyle = (psSolid, psDash, psDot, psDashDot, psDashDotDot, psClear,
//    psInsideFrame, psUserStyle, psAlternate);
//const
//  PenStyles: array[TPenStyle] of Word =
//    (PS_SOLID, PS_DASH, PS_DOT, PS_DASHDOT, PS_DASHDOTDOT, PS_NULL,
//     PS_INSIDEFRAME, PS_USERSTYLE, PS_ALTERNATE);
               
//  TPenMode = (pmBlack, pmWhite, pmNop, pmNot, pmCopy, pmNotCopy,
//    pmMergePenNot, pmMaskPenNot, pmMergeNotPen, pmMaskNotPen, pmMerge,
//    pmNotMerge, pmMask, pmNotMask, pmXor, pmNotXor);
//const
//  PenModes: array[TPenMode] of Word =
//    (R2_BLACK, R2_WHITE, R2_NOP, R2_NOT, R2_COPYPEN, R2_NOTCOPYPEN, R2_MERGEPENNOT,
//     R2_MASKPENNOT, R2_MERGENOTPEN, R2_MASKNOTPEN, R2_MERGEPEN, R2_NOTMERGEPEN,
//     R2_MASKPEN, R2_NOTMASKPEN, R2_XORPEN, R2_NOTXORPEN);

procedure DrawFocusRect(AMemDC: PWinMemDC; ARect: TRect);
var
  tmpOldPen: HPEN;     
  tmpOldBrush: HBRUSH;
  tmpLogPen: TLogPen;
  tmpLogBrush: TLogBrush;
begin
  FrameRect(AMemDC.DCHandle, ARect, tmpRectBrush); 
  //RequiredState([csHandleValid, csBrushValid, csPenValid]);
  if 0 = tmpPen then
  begin
    tmpLogPen.lopnStyle := PS_DOT;
    tmpLogPen.lopnWidth.X := 1;
    tmpLogPen.lopnColor := 0;
    tmpPen := CreatePenIndirect(tmpLogPen);
    Windows.SetROP2(tmpPen, R2_NOT);
  end;
  if 0 = tmpClearBrush then
  begin
    tmpLogBrush.lbStyle := BS_HOLLOW;
    tmpLogBrush.lbColor := 0;
    tmpLogBrush.lbHatch := 0;
    tmpClearBrush := CreateBrushIndirect(tmpLogBrush);
  end;
  tmpOldPen := SelectObject(AMemDC.DCHandle, tmpPen);
  tmpOldBrush := SelectObject(AMemDC.DCHandle, tmpClearBrush);
  Windows.Rectangle(AMemDC.DCHandle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);                                   
  SelectObject(AMemDC.DCHandle, tmpOldPen);
  SelectObject(AMemDC.DCHandle, tmpOldBrush);
end;

procedure UIWindowPaint(AUIWindow: PUIWindow; AMemDC: PWinMemDC);
var   
  tmpLogBrush: TLogBrush;
  tmpRect: TRect;
begin          
  if 0 = tmpBrush then
  begin
    tmpLogBrush.lbStyle := BS_SOLID;
    tmpLogBrush.lbColor := $EFEFEF;
    tmpLogBrush.lbHatch := 0;
    tmpBrush := CreateBrushIndirect(tmpLogBrush);
  end;            
  if 0 = tmpRectBrush then
  begin
    tmpLogBrush.lbStyle := BS_SOLID;
    tmpLogBrush.lbColor := $0F0F0F;
    tmpLogBrush.lbHatch := 0;
    tmpRectBrush := CreateBrushIndirect(tmpLogBrush);
  end;

  FillRect(AMemDC.DCHandle, AUIWindow.BaseWnd.ClientRect, tmpBrush);

  tmpRect.Left := AUIWindow.TestUIEdit.Base.Layout.Left;
  tmpRect.Top := AUIWindow.TestUIEdit.Base.Layout.Top;
  tmpRect.Right := AUIWindow.TestUIEdit.Base.Layout.Right;
  tmpRect.Bottom := AUIWindow.TestUIEdit.Base.Layout.Bottom;

  FrameRect(AMemDC.DCHandle, tmpRect, tmpRectBrush);
end;

procedure UIWindowPaint(AUIWindow: PUIWindow);
var
  tmpDC: HDC;
begin   
  UIWindowPaint(AUIWindow, @AUIWindow.MemDC);

  tmpDC := GetDC(AUIWindow.BaseWnd.UIWndHandle);
  try
    Windows.BitBlt(tmpDC, 0, 0,
      AUIWindow.BaseWnd.ClientRect.Right,
      AUIWindow.BaseWnd.ClientRect.Bottom,
      AUIWindow.MemDC.DCHandle,
      0, 0, SRCCOPY
    );    
  finally
    ReleaseDC(AUIWindow.BaseWnd.UIWndHandle, tmpDC);
  end;
end;

function WndProcW_WMPaint(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  tmpPS: TPaintStruct;
  tmpDC: HDC;
begin
  Result := 0;  
  UIWindowPaint(AUIWindow, @AUIWindow.MemDC);
  
  tmpDC := Windows.BeginPaint(AUIWindow.BaseWnd.UIWndHandle, tmpPS);
  Windows.BitBlt(tmpDC, 0, 0,
    AUIWindow.BaseWnd.ClientRect.Right,
    AUIWindow.BaseWnd.ClientRect.Bottom,
    AUIWindow.MemDC.DCHandle,
    0, 0, SRCCOPY
  );
  EndPaint(AUIWindow.BaseWnd.UIWndHandle, tmpPS);
//  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_Paint, wParam, lParam);
end;

function WndProcW_WMPaintIcon(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_PAINTICON, wParam, lParam);
end;

function WndProcW_WMNCPaint(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_NCPAINT, wParam, lParam);
end;

function WndProcW_WMEraseBkgnd(AUIWindow: PUIWindow; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := DefWindowProcW(AUIWindow.BaseWnd.UIWndHandle, WM_ERASEBKGND, wParam, lParam);
end;

function UIWndProcW_Paint(AUIWindow: PUIWindow; AMsg: UINT; wParam: WPARAM; lParam: LPARAM; var AWndProcResult: LRESULT): Boolean;
begin
  Result := true;
  case AMsg of
    WM_PAINT: AWndProcResult := WndProcW_WMPaint(AUIWindow, wParam, lParam);
    WM_PAINTICON: AWndProcResult := WndProcW_WMPaintIcon(AUIWindow, wParam, lParam);
    WM_NCPAINT: AWndProcResult := WndProcW_WMNCPaint(AUIWindow, wParam, lParam);
    WM_ERASEBKGND: AWndProcResult := WndProcW_WMEraseBkgnd(AUIWindow, wParam, lParam);
    else
      Result := false;
  end;     
end;

end.
