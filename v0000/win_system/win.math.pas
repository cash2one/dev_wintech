unit win.math;

interface

uses
  BaseType;

  procedure SinCos(const Theta: TFloat; out Sin, Cos: TFloat); overload;
  procedure SinCos(const Theta, Radius: Single; out Sin, Cos: Single); overload;
  procedure SinCos(const Theta, ScaleX, ScaleY: TFloat; out Sin, Cos: Single); overload;
               
const
  CRad01      = Pi / 180;
  CRad30      = Pi / 6;
  CRad45      = Pi / 4;
  CRad60      = Pi / 3;
  CRad90      = Pi / 2;
  CRad180     = Pi;
  CRad270     = CRad90 * 3;
  CRad360     = CRad180 * 2;
  CDegToRad   = Pi / 180;
  CRadToDeg   = 180 / Pi;

implementation

procedure SinCos(const Theta: TFloat; out Sin, Cos: TFloat);
{$IFDEF NATIVE_SINCOS}
var
  S, C: Extended;
begin
  Math.SinCos(Theta, S, C);
  Sin := S;
  Cos := C;
{$ELSE}
{$IFDEF TARGET_x64}
var
  Temp: TFloat;
{$ENDIF}
asm
{$IFDEF TARGET_x86}
        FLD     Theta
        FSINCOS
        FSTP    DWORD PTR [EDX] // cosine
        FSTP    DWORD PTR [EAX] // sine
{$ENDIF}
{$IFDEF TARGET_x64}
        MOVD    Temp, Theta
        FLD     Temp
        FSINCOS
        FSTP    [Sin] // cosine
        FSTP    [Cos] // sine
{$ENDIF}
{$ENDIF}
end;

procedure SinCos(const Theta, Radius: TFloat; out Sin, Cos: TFloat);
{$IFDEF NATIVE_SINCOS}
var
  S, C: Extended;
begin
  Math.SinCos(Theta, S, C);
  Sin := S * Radius;
  Cos := C * Radius;
{$ELSE}
{$IFDEF TARGET_x64}
var
  Temp: TFloat;
{$ENDIF}
asm
{$IFDEF TARGET_x86}
        FLD     Theta
        FSINCOS
        FMUL    Radius
        FSTP    DWORD PTR [EDX] // cosine
        FMUL    Radius
        FSTP    DWORD PTR [EAX] // sine
{$ENDIF}
{$IFDEF TARGET_x64}
        MOVD    Temp, Theta
        FLD     Temp
        MOVD    Temp, Radius
        FSINCOS
        FMUL    Temp
        FSTP    [Cos]
        FMUL    Temp
        FSTP    [Sin]
{$ENDIF}
{$ENDIF}
end;

procedure SinCos(const Theta, ScaleX, ScaleY: TFloat; out Sin, Cos: Single); overload;
{$IFDEF NATIVE_SINCOS}
var
  S, C: Extended;
begin
  Math.SinCos(Theta, S, C);
  Sin := S * ScaleX;
  Cos := C * ScaleY;
{$ELSE}
{$IFDEF TARGET_x64}
var
  Temp: TFloat;
{$ENDIF}
asm
{$IFDEF TARGET_x86}
        FLD     Theta
        FSINCOS
        FMUL    ScaleX
        FSTP    DWORD PTR [EDX] // cosine
        FMUL    ScaleY
        FSTP    DWORD PTR [EAX] // sine
{$ENDIF}
{$IFDEF TARGET_x64}
        MOVD    Temp, Theta
        FLD     Temp
        FSINCOS
        MOVD    Temp, ScaleX
        FMUL    Temp
        FSTP    [Cos]
        MOVD    Temp, ScaleY
        FMUL    Temp
        FSTP    [Sin]
{$ENDIF}
{$ENDIF}
end;

end.
