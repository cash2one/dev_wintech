unit uicontrol_edit_paint;

interface

uses
  Windows,
  uiwin.dc,
  uicontrol_edit;
                 
  procedure PaintView_UIEdit(AEdit: PUIEdit; AMemDC: PWinDC);

implementation

uses
  uiview_shape;
  
var
  tmpRectBrush: HBRUSH = 0;

procedure PaintView_UIEdit(AEdit: PUIEdit; AMemDC: PWinDC);
var
  tmpRect: TRect;
  tmpLogBrush: TLogBrush;
begin
  tmpRect.Left := AEdit.Base.View.Space.Layout.Left;
  tmpRect.Top := AEdit.Base.View.Space.Layout.Top;
  tmpRect.Right := AEdit.Base.View.Space.Layout.Right;
  tmpRect.Bottom := AEdit.Base.View.Space.Layout.Bottom;

  if 0 = tmpRectBrush then
  begin
    tmpLogBrush.lbStyle := BS_SOLID;
    tmpLogBrush.lbColor := $0F0F0F;
    tmpLogBrush.lbHatch := 0;
    tmpRectBrush := CreateBrushIndirect(tmpLogBrush);
  end;
  FrameRect(AMemDC.DCHandle, tmpRect, tmpRectBrush);

  SetBkMode(AMemDC.DCHandle, TRANSPARENT);
  
  if nil <> AEdit.TextView then
  begin
    if nil <> AEdit.TextView.Space.BaseShape then
    begin
      Windows.TextOutW(AMemDC.DCHandle, tmpRect.Left, tmpRect.Top,
        @PUIViewShape_Text(AEdit.TextView.Space.BaseShape).UITextData[1],
        Length(PUIViewShape_Text(AEdit.TextView.Space.BaseShape).UITextData)
        );
    end;
  end;
end;

end.
