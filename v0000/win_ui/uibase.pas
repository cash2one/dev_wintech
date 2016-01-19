unit uibase;

interface

type
  PUIBaseShape    = ^TUIBaseShape;
  TUIBaseShape    = record
    DataType      : integer;
    ShapeType     : integer;
  end;

  PUIBaseLayout   = ^TUIBaseLayout;
  TUIBaseLayout   = record  
    DataType      : integer; 
    LayoutType    : integer;
  end;

  PUIBaseTexture  = ^TUIBaseTexture;
  TUIBaseTexture  = record  
    DataType      : integer;  
    TextureType   : integer;
  end;

implementation

end.
