unit uiview_texture;

interface

type
  TUIViewTextureType = (
    texUnknown,
    texColor,         // base
    texBitmap,        // base
    texCustomDraw,    // base         
    texGradient       // extend À©Õ¹
  );
  
  PUIViewTexture  = ^TUIViewTexture;
  TUIViewTexture  = record
    TextureType   : TUIViewTextureType;
    IsVisible     : Boolean;
    AlphaValue    : Byte;           
  end;
  
implementation

end.
