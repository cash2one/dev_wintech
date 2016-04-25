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
  end;
  
implementation

end.
