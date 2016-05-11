unit uiview_space;

interface

uses
  Types;
  
type
  TUIViewShapeType = (
    shapeUnknown,
    shapePoint,
    shapeLine,     // 直线
    shapeCurve,    // 曲线
    shapeTriangle, // 三角形
    shapeRect,     // 封闭区域 -- 方形
    shapePolygon,  // 封闭区域 -- 多边形
    shapeText      // Text 和 Font 相关
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
    BaseShape   : PUIViewShape;
  end;

const
  { WM_NCHITTEST and MOUSEHOOKSTRUCT Mouse Position Codes }
  HTERROR = -2;
  HTTRANSPARENT = -1;
  HTNOWHERE = 0;
  HTCLIENT = 1;
  HTCAPTION = 2;
  HTSYSMENU = 3;
  HTGROWBOX = 4;
  HTSIZE = HTGROWBOX;
  HTMENU = 5;
  HTHSCROLL = 6;
  HTVSCROLL = 7;
  HTMINBUTTON = 8;
  HTMAXBUTTON = 9;
  HTLEFT = 10;
  HTRIGHT = 11;
  HTTOP = 12;
  HTTOPLEFT = 13;
  HTTOPRIGHT = 14;
  HTBOTTOM = 15;
  HTBOTTOMLEFT = $10;
  HTBOTTOMRIGHT = 17;
  HTBORDER = 18;
  HTREDUCE = HTMINBUTTON;
  HTZOOM = HTMAXBUTTON;
  HTSIZEFIRST = HTLEFT;
  HTSIZELAST = HTBOTTOMRIGHT;
  HTOBJECT = 19;
  HTCLOSE = 20;
  HTHELP = 21;
                   
  function POINT_HITTEST(AUILayout: PUIViewLayout; APoint: TSmallPoint; ABorder: Integer = 3): Integer; overload;
  function POINT_HITTEST(AUILayout: PUIViewLayout; APoint: TPoint; ABorder: Integer = 3): Integer; overload;

  procedure UpdateUISpaceWidth(AUISpace: PUIViewSpace; AWidth: integer);
  procedure UpdateUISpaceHeight(AUISpace: PUIViewSpace; AHeight: integer);
  procedure UpdateUILayout(AUILayout: PUIViewLayout; ALeft: Integer; ATop: Integer);
  procedure UpdateUISpaceLayout(AUISpace: PUIViewSpace; ALeft: Integer; ATop: Integer);

implementation

function POINT_HITTEST(AUILayout: PUIViewLayout; APoint: TSmallPoint; ABorder: Integer = 3): Integer;
begin
  Result := HTNOWHERE;  
  if APoint.x < (AUILayout.Left - ABorder) then
    exit;
  if APoint.x > (AUILayout.Right + ABorder) then
    exit;
  if APoint.y < (AUILayout.Top - ABorder) then
    exit;
  if (APoint.y > AUILayout.Bottom + ABorder) then
    exit;
  Result := HTCLIENT;    
  if APoint.x < (AUILayout.Left + ABorder) then
  begin                    
    Result := HTLEFT;   
    if APoint.y < (AUILayout.Top + ABorder) then
    begin
      Result := HTTOPLEFT; 
      exit;
    end;          
    if APoint.y > (AUILayout.Bottom - ABorder) then
      Result := HTBOTTOMLEFT;
    exit;
  end;            
  if APoint.x > (AUILayout.Right - ABorder) then
  begin                    
    Result := HTRIGHT;   
    if APoint.y < (AUILayout.Top + ABorder) then
    begin
      Result := HTTOPRIGHT; 
      exit;
    end;          
    if APoint.y > (AUILayout.Bottom - ABorder) then
      Result := HTBOTTOMRIGHT;
    exit;
  end;            
  if APoint.y < (AUILayout.Top + ABorder) then
  begin                    
    Result := HTTOP;    
    exit;
  end;
  if APoint.y > (AUILayout.Bottom - ABorder) then
  begin
    Result := HTBOTTOM;
    exit;
  end;
end;

function POINT_HITTEST(AUILayout: PUIViewLayout; APoint: TPoint; ABorder: Integer = 3): Integer;
begin
  Result := HTNOWHERE;  
  if APoint.x < (AUILayout.Left - ABorder) then
    exit;
  if APoint.x > (AUILayout.Right + ABorder) then
    exit;
  if APoint.y < (AUILayout.Top - ABorder) then
    exit;
  if (APoint.y > AUILayout.Bottom + ABorder) then
    exit;
  Result := HTCLIENT;    
  if APoint.x < (AUILayout.Left + ABorder) then
  begin                    
    Result := HTLEFT;   
    if APoint.y < (AUILayout.Top + ABorder) then
    begin
      Result := HTTOPLEFT; 
      exit;
    end;          
    if APoint.y > (AUILayout.Bottom - ABorder) then
      Result := HTBOTTOMLEFT;
    exit;
  end;            
  if APoint.x > (AUILayout.Right - ABorder) then
  begin                    
    Result := HTRIGHT;   
    if APoint.y < (AUILayout.Top + ABorder) then
    begin
      Result := HTTOPRIGHT; 
      exit;
    end;          
    if APoint.y > (AUILayout.Bottom - ABorder) then
      Result := HTBOTTOMRIGHT;
    exit;
  end;            
  if APoint.y < (AUILayout.Top + ABorder) then
  begin                    
    Result := HTTOP;    
    exit;
  end;
  if APoint.y > (AUILayout.Bottom - ABorder) then
  begin
    Result := HTBOTTOM;
    exit;
  end;
end;

procedure UpdateUISpaceWidth(AUISpace: PUIViewSpace; AWidth: integer);
begin
  if nil <> AUISpace.BaseShape then
  begin
    AUISpace.BaseShape.Width := AWidth;
  end;
  AUISpace.Layout.Right := AUISpace.Layout.Left + AWidth;
end;

procedure UpdateUISpaceHeight(AUISpace: PUIViewSpace; AHeight: integer);
begin
  if nil <> AUISpace.BaseShape then
  begin
    AUISpace.BaseShape.Height := AHeight;
  end;
  AUISpace.Layout.Bottom := AUISpace.Layout.Top + AHeight;
end;
    
procedure UpdateUILayout(AUILayout: PUIViewLayout; ALeft: Integer; ATop: Integer);
begin
  AUILayout.Left := ALeft;
  AUILayout.Top := ATop; 
end;

procedure UpdateUISpaceLayout(AUISpace: PUIViewSpace; ALeft: Integer; ATop: Integer);
begin
  UpdateUILayout(@AUISpace.Layout, ALeft, ATop);   
  AUISpace.Layout.Right := AUISpace.Layout.Left + AUISpace.BaseShape.Width;
  AUISpace.Layout.Bottom := AUISpace.Layout.Top + AUISpace.BaseShape.Height;
end;

end.
