unit uiview_texture;

interface

type
  TUIViewTextureType = (
    texUnknown,
    texColor,
    texGradient,
    texBitmap
  );
  
  PUIViewTexture  = ^TUIViewTexture;
  TUIViewTexture  = record
    TextureType   : TUIViewTextureType;
    IsVisible     : Boolean;
    AlphaValue    : Byte;           
  end;
  
implementation

end.
