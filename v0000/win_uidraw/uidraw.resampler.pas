unit uidraw.resampler;

interface

uses
  ui.color, ui.bitmap, ui.space, BaseType;

type               
  TPixelAccessMode = (pamUnsafe, pamSafe, pamWrap, pamTransparentEdge);

  { TCustomResampler }
  { Base class for TCustomBitmap32 specific reamplers. }
  PBaseResampler      = ^TBaseResampler;
  TBaseResampler      = record
    ResamplerType     : integer;
    ResamplerWidth    : TFloat;
    PixelAccessMode   : TPixelAccessMode;
  end;
              
implementation

end.
