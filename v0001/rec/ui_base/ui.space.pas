unit ui.space;

interface

uses
  Types, sys.datatype;
  
type
  TUIPoint      = Types.TPoint;
  PUIPoint      = ^TUIPoint;

  PUIPoints     = ^TUIPoints;
  TUIPoints     = array [0..0] of TUIPoint;
                                
  PUIFloatPoint = ^TUIFloatPoint;
  TUIFloatPoint = record
    X           : TFloat;
    Y           : TFloat;
  end;
  (*//
  PUIRect       = ^TUIRect;
  TUIRect       = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: Longint);
      1: (TopLeft, BottomRight: TPoint);
  end;
  //*)
  PUIRect       = Types.PRect;
  TUIRect       = Types.TRect;
          
  PUIFloatRect  = ^TUIFloatRect;
  TUIFloatRect  = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: TFloat);
      1: (TopLeft, BottomRight: TUIFloatPoint);
  end;
             
  PUIRects      = ^TUIRects;
  TUIRects      = array[0..Maxint div 32 - 1] of TUIRect;

const
  ZERO_RECT: TUIRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);

  function IsRectEmpty(const ARect: TUIRect): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  function IsRectEmpty(const ARect: TUIFloatRect): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}

  function EqualRect(const R1, R2: TUIRect): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  function EqualRect(const R1, R2: TUIFloatRect): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}

  // Some basic operations over rectangles
  function IntersectRect(out Dst: TUIRect; const R1, R2: TUIRect): Boolean; overload;
  function IntersectRect(out Dst: TUIFloatRect; const FR1, FR2: TUIFloatRect): Boolean; overload;
  function UnionRect(out Rect: TUIRect; const R1, R2: TUIRect): Boolean; overload;
  function UnionRect(out Rect: TUIFloatRect; const R1, R2: TUIFloatRect): Boolean; overload;
  procedure InflateRect(var R: TUIRect; Dx, Dy: Integer); overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  procedure InflateRect(var FR: TUIFloatRect; Dx, Dy: TFloat); overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  procedure OffsetRect(var R: TUIRect; Dx, Dy: Integer); overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  procedure OffsetRect(var FR: TUIFloatRect; Dx, Dy: TFloat); overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  function PtInRect(const R: TUIRect; const P: TUIPoint): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  function PtInRect(const R: TUIFloatRect; const P: TUIPoint): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  function PtInRect(const R: TUIRect; const P: TUIFloatPoint): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  function PtInRect(const R: TUIFloatRect; const P: TUIFloatPoint): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  function EqualRectSize(const R1, R2: TUIRect): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  function EqualRectSize(const R1, R2: TUIFloatRect): Boolean; overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  
implementation

uses
  Math,
  win.datamove,
  Sysutils;
  
function IsRectEmpty(const ARect: TUIRect): Boolean;
begin
  Result := (ARect.Right <= ARect.Left) or (ARect.Bottom <= ARect.Top);
end;

function IsRectEmpty(const ARect: TUIFloatRect): Boolean;
begin
  Result := (ARect.Right <= ARect.Left) or (ARect.Bottom <= ARect.Top);
end;

function EqualRect(const R1, R2: TRect): Boolean;
begin
  Result := Sysutils.CompareMem(@R1, @R2, SizeOf(TRect));
end;

function EqualRect(const R1, R2: TUIFloatRect): Boolean;
begin
  Result := Sysutils.CompareMem(@R1, @R2, SizeOf(TUIFloatRect));
end;

function IntersectRect(out Dst: TUIRect; const R1, R2: TUIRect): Boolean;
begin
  if R1.Left >= R2.Left then
    Dst.Left := R1.Left
  else
    Dst.Left := R2.Left;
  if R1.Right <= R2.Right then
    Dst.Right := R1.Right
  else
    Dst.Right := R2.Right;
  if R1.Top >= R2.Top then
    Dst.Top := R1.Top
  else
    Dst.Top := R2.Top;
  if R1.Bottom <= R2.Bottom then
  begin
    Dst.Bottom := R1.Bottom;
  end else
  begin
    Dst.Bottom := R2.Bottom;
  end;
  Result := (Dst.Right >= Dst.Left) and (Dst.Bottom >= Dst.Top);
  if not Result then
  begin
    Dst := ZERO_RECT;
  end;
end;

function IntersectRect(out Dst: TUIFloatRect; const FR1, FR2: TUIFloatRect): Boolean;
begin
  Dst.Left   := Math.Max(FR1.Left,   FR2.Left);
  Dst.Right  := Math.Min(FR1.Right,  FR2.Right);
  Dst.Top    := Math.Max(FR1.Top,    FR2.Top);
  Dst.Bottom := Math.Min(FR1.Bottom, FR2.Bottom);
  Result := (Dst.Right >= Dst.Left) and (Dst.Bottom >= Dst.Top);
  if not Result then
  begin
    FillLongword(Dst, 4, 0);
  end;
end;

function UnionRect(out Rect: TRect; const R1, R2: TRect): Boolean;
begin
  Rect := R1;
  if not IsRectEmpty(R2) then
  begin
    if R2.Left < R1.Left then
      Rect.Left := R2.Left;
    if R2.Top < R1.Top then
      Rect.Top := R2.Top;
    if R2.Right > R1.Right then
      Rect.Right := R2.Right;
    if R2.Bottom > R1.Bottom then
      Rect.Bottom := R2.Bottom;
  end;
  Result := not IsRectEmpty(Rect);
  if not Result then
  begin
    Rect := ZERO_RECT;
  end;
end;

function UnionRect(out Rect: TUIFloatRect; const R1, R2: TUIFloatRect): Boolean;
begin
  Rect := R1;
  if not IsRectEmpty(R2) then
  begin
    if R2.Left < R1.Left then
      Rect.Left := R2.Left;
    if R2.Top < R1.Top then
      Rect.Top := R2.Top;
    if R2.Right > R1.Right then
      Rect.Right := R2.Right;
    if R2.Bottom > R1.Bottom then
      Rect.Bottom := R2.Bottom;
  end;
  Result := not IsRectEmpty(Rect);
  if not Result then
  begin
    FillLongword(Rect, 4, 0);
  end;
end;

procedure InflateRect(var R: TUIRect; Dx, Dy: Integer);
begin
  Dec(R.Left, Dx); Dec(R.Top, Dy);
  Inc(R.Right, Dx); Inc(R.Bottom, Dy);
end;

procedure InflateRect(var FR: TUIFloatRect; Dx, Dy: TFloat);
begin
  // w ith FR do
  begin
    FR.Left := FR.Left - Dx;
    FR.Top := FR.Top - Dy;
    FR.Right := FR.Right + Dx;
    FR.Bottom := FR.Bottom + Dy;
  end;
end;

procedure OffsetRect(var R: TUIRect; Dx, Dy: Integer);
begin
  Inc(R.Left, Dx); Inc(R.Top, Dy);
  Inc(R.Right, Dx); Inc(R.Bottom, Dy);
end;

procedure OffsetRect(var FR: TUIFloatRect; Dx, Dy: TFloat);
begin
  // w ith FR do
  begin
    FR.Left := FR.Left + Dx;
    FR.Top := FR.Top + Dy;
    FR.Right := FR.Right + Dx;
    FR.Bottom := FR.Bottom + Dy;
  end;
end;

function PtInRect(const R: TUIRect; const P: TUIPoint): Boolean;
begin
  Result := (P.X >= R.Left) and (P.X < R.Right) and
    (P.Y >= R.Top) and (P.Y < R.Bottom);
end;

function PtInRect(const R: TUIFloatRect; const P: TUIPoint): Boolean;
begin
  Result := (P.X >= R.Left) and (P.X < R.Right) and
    (P.Y >= R.Top) and (P.Y < R.Bottom);
end;

function PtInRect(const R: TUIRect; const P: TUIFloatPoint): Boolean;
begin
  Result := (P.X >= R.Left) and (P.X < R.Right) and
    (P.Y >= R.Top) and (P.Y < R.Bottom);
end;

function PtInRect(const R: TUIFloatRect; const P: TUIFloatPoint): Boolean;
begin
  Result := (P.X >= R.Left) and (P.X < R.Right) and
    (P.Y >= R.Top) and (P.Y < R.Bottom);
end;

function EqualRectSize(const R1, R2: TUIRect): Boolean;
begin
  Result := ((R1.Right - R1.Left) = (R2.Right - R2.Left)) and
    ((R1.Bottom - R1.Top) = (R2.Bottom - R2.Top));
end;

function EqualRectSize(const R1, R2: TUIFloatRect): Boolean;
begin
  Result := ((R1.Right - R1.Left) = (R2.Right - R2.Left)) and
    ((R1.Bottom - R1.Top) = (R2.Bottom - R2.Top));
end;

end.
