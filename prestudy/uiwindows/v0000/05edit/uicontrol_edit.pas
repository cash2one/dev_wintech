unit uicontrol_edit;

interface

uses
  uiview,
  uicontrol;
  
type
  PUIEdit         = ^TUIEdit;
  TUIEdit         = record
    Base          : TBaseUIControl;
    MainView      : TUIView;
    TextView      : PUIView;
    CaretView     : PUIView;
  end;

  procedure InitUIEdit(AEdit: PUIEdit);
  
implementation

uses
  uiview_shape;
  
procedure InitUIEdit(AEdit: PUIEdit);
begin
      
  AEdit.MainView.Space.BaseShape := @CheckOutShapeRect.BaseShape;

  AEdit.Base.View := @AEdit.MainView;   
  if nil <> AEdit.MainView.Space.BaseShape then
  begin
    AEdit.MainView.Space.BaseShape.Width := 100;
    AEdit.MainView.Space.BaseShape.Height := 20;
  end;

  AEdit.TextView := CheckOutUIView;
  AEdit.TextView.Space.BaseShape := @CheckOutShapeText.BaseShape;

  PUIViewShape_Text(AEdit.TextView.Space.BaseShape).UITextData := 'GOOD';
end;

end.
