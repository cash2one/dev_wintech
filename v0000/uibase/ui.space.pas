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

implementation

end.
