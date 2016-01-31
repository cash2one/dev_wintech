unit ui.space;

interface

uses
  Types, BaseType;
  
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
         
  PUIRect       = Types.PRect;
  TUIRect       = Types.TRect;
          
  PUIFloatRect  = ^TUIFloatRect;
  TUIFloatRect  = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: TFloat);
      1: (TopLeft, BottomRight: TUIFloatPoint);
  end;
          
const
  ZERO_RECT: TUIRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);

implementation

end.
