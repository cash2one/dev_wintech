unit uicontrol_edit;

interface

uses
  uiview,
  uicontrol;
  
type
  PUIEdit         = ^TUIEdit;
  TUIEdit         = record
    Base          : TBaseUIControl;
    View          : TUIView;
  end;

  procedure InitUIEdit(AEdit: PUIEdit);

implementation

uses
  uiview_shape;
  
procedure InitUIEdit(AEdit: PUIEdit);
begin
      
  AEdit.View.Space.BaseShape := @CheckOutShapeRect.BaseShape;

  AEdit.Base.Layout := @AEdit.View.Space.Layout;   
  if nil <> AEdit.View.Space.BaseShape then
  begin
    AEdit.View.Space.BaseShape.Width := 100;
    AEdit.View.Space.BaseShape.Height := 20;
  end;
end;

end.
