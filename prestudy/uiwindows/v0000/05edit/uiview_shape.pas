unit uiview_shape;

interface

uses
  uiview_space;

type
  PUIViewShape_Rect = ^TUIViewShape_Rect;
  TUIViewShape_Rect = record
    BaseShape       : TUIViewShape;
  end;

  PUIViewShape_Text = ^TUIViewShape_Text;
  TUIViewShape_Text = record
    BaseShape       : TUIViewShape;
  end;

  function CheckOutShapeRect: PUIViewShape_Rect;   
  function CheckOutShapeText: PUIViewShape_Text;


implementation

function CheckOutShapeRect: PUIViewShape_Rect;
begin
  Result := System.New(PUIViewShape_Rect);
  FillChar(Result^, SizeOf(TUIViewShape_Rect), 0);
end;

function CheckOutShapeText: PUIViewShape_Text;
begin
  Result := System.New(PUIViewShape_Text);
  FillChar(Result^, SizeOf(TUIViewShape_Text), 0);
end;

end.
