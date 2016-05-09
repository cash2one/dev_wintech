unit uiview;

interface

uses
  uiview_texture,
  uiview_space;
  
type
  PUIView = ^TUIView;
  TUIView = record
    Space : TUIViewSpace;
    Texture: TUIViewTexture;
  end;

  function CheckOutUIView: PUIView;

implementation

function CheckOutUIView: PUIView;
begin
  Result := System.New(PUIView);
  FillChar(Result^, SizeOf(TUIView), 0);
end;

end.
