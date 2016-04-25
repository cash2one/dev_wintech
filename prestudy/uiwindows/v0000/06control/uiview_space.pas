unit uiview_space;

interface

type
  TUIViewShapeType = (
    shapeUnknown,
    shapePoint,
    shapeLine, // 直线
    shapeCurve, // 曲线
    shapeTriangle, // 三角形
    shapeRect,     // 封闭区域 -- 方形
    shapePolygon   // 封闭区域 -- 多边形
  );
  
  PUIViewShape  = ^TUIViewShape; 
  PUIViewLayout = ^TUIViewLayout;
  PUIViewSpace  = ^TUIViewSpace;
  
  TUIViewShape  = record
    ShapeType   : TUIViewShapeType;
    OffsetX     : integer;
    OffsetY     : integer;
    Width       : integer;
    Height      : integer;
  end;

  TUIViewLayout = record
    Parent      : PUIViewSpace;
    FirstChild  : PUIViewSpace;
    LastChild   : PUIViewSpace;
    PrevSibling : PUIViewSpace;
    NextSibling : PUIViewSpace;  
    Left        : integer;
    Top         : integer;
    Right       : integer;
    Bottom      : integer;
    //Space       : PUIViewSpace;  
  end;

  TUIViewSpace  = record
    Layout      : TUIViewLayout;
    Shape       : TUIViewShape;
  end;
  
implementation

end.
