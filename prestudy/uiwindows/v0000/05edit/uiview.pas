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
  
implementation

end.
