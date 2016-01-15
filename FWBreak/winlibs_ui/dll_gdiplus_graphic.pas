{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdiplus_graphic;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype, dll_gdiplus;

type
  TGPCompositingMode = (
    CompositingModeSourceOver,    // 0
    CompositingModeSourceCopy     // 1
  );
                         
  TGPQualityMode = (
    QualityModeInvalid   = -1,
    QualityModeDefault   =  0,
    QualityModeLow       =  1, // Best performance
    QualityModeHigh      =  2  // Best rendering quality
  );
  
  TGPCompositingQuality = (
    CompositingQualityInvalid          = Ord(QualityModeInvalid),
    CompositingQualityDefault          = Ord(QualityModeDefault),
    CompositingQualityHighSpeed        = Ord(QualityModeLow),
    CompositingQualityHighQuality      = Ord(QualityModeHigh),
    CompositingQualityGammaCorrected,
    CompositingQualityAssumeLinear
  );

(*
SmoothingModeInvalid     = -1; {指定一个无效模式}
SmoothingModeDefault     = 0;  {指定不消除锯齿}
SmoothingModeHighSpeed   = 1;  {指定高速度、低质量呈现}
SmoothingModeHighQuality = 2;  {指定高质量、低速度呈现}
SmoothingModeNone        = 3;  {指定不消除锯齿}
SmoothingModeAntiAlias   = 4;  {指定消除锯齿的呈现}
*)

  TGPSmoothingMode = (
    SmoothingModeInvalid     = Ord(QualityModeInvalid),  // 指定不消除锯齿
    SmoothingModeDefault     = Ord(QualityModeDefault),
    SmoothingModeHighSpeed   = Ord(QualityModeLow), // 指定高速度、低质量呈现
    SmoothingModeHighQuality = Ord(QualityModeHigh),
    SmoothingModeNone,         // 指定不消除锯齿
    SmoothingModeAntiAlias,    // 指定消除锯齿的呈现
    SmoothingModeAntiAlias8x4 = SmoothingModeAntiAlias,
    SmoothingModeAntiAlias8x8 = 5
  );
                   
  TGPPixelOffsetMode = (
    PixelOffsetModeInvalid     = Ord(QualityModeInvalid),
    PixelOffsetModeDefault     = Ord(QualityModeDefault),
    PixelOffsetModeHighSpeed   = Ord(QualityModeLow),
    PixelOffsetModeHighQuality = Ord(QualityModeHigh),
    PixelOffsetModeNone,    // No pixel offset
    PixelOffsetModeHalf     // Offset by -0.5, -0.5 for fast anti-alias perf
  );
                    
  TGPInterpolationMode = (
    InterpolationModeInvalid          = Ord(QualityModeInvalid),
    InterpolationModeDefault          = Ord(QualityModeDefault),
    InterpolationModeLowQuality       = Ord(QualityModeLow),
    InterpolationModeHighQuality      = Ord(QualityModeHigh),
    InterpolationModeBilinear,
    InterpolationModeBicubic,
    InterpolationModeNearestNeighbor,
    InterpolationModeHighQualityBilinear,
    InterpolationModeHighQualityBicubic
  );
  
  TGPTextRenderingHint = (
    TextRenderingHintSystemDefault,                // Glyph with system default rendering hint
    TextRenderingHintSingleBitPerPixelGridFit,     // Glyph bitmap with hinting
    TextRenderingHintSingleBitPerPixel,            // Glyph bitmap without hinting
    TextRenderingHintAntiAliasGridFit,             // Glyph anti-alias bitmap with hinting
    TextRenderingHintAntiAlias,                    // Glyph anti-alias bitmap without hinting
    TextRenderingHintClearTypeGridFit              // Glyph CT bitmap with hinting
  );
                   
  TGPCoordinateSpace = (
    CoordinateSpaceWorld,     // 0
    CoordinateSpacePage,      // 1
    CoordinateSpaceDevice     // 2
  );

  GpCoordinateSpace = TGPCoordinateSpace;
     
  { GpGraphics }
  function GdipCreateFromHDC(ADC: HDC; out AGraphics: TGpGraphics): TGpStatus; stdcall; external gdiplus;
  function GdipCreateFromHDC2(ADC: HDC; hDevice: THandle; out AGraphics: TGpGraphics): TGpStatus; stdcall; external gdiplus;
  function GdipCreateFromHWND(AWnd: HWND; out AGraphics: TGpGraphics): TGpStatus; stdcall; external gdiplus;
  function GdipCreateFromHWNDICM(AWnd: HWND; out AGraphics: TGpGraphics): TGpStatus; stdcall; external gdiplus;

  function GdipFlush(AGraphics: TGpGraphics; intention: TGPFlushIntention): TGpStatus; stdcall; external gdiplus;
  function GdipDeleteGraphics(AGraphics: TGpGraphics): TGpStatus; stdcall; external gdiplus;
  function GdipGetDC(AGraphics: TGpGraphics; var ADC: HDC): TGpStatus; stdcall; external gdiplus;
  function GdipReleaseDC(AGraphics: TGpGraphics; ADC: HDC): TGpStatus; stdcall; external gdiplus;
  function GdipSetCompositingMode(AGraphics: TGpGraphics; compositingMode: TGPCompositingMode): TGpStatus; stdcall; external gdiplus;
  function GdipGetCompositingMode(AGraphics: TGpGraphics; var compositingMode: TGPCompositingMode): TGpStatus; stdcall; external gdiplus;
  function GdipSetRenderingOrigin(AGraphics: TGpGraphics; x: Integer; y: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipGetRenderingOrigin(AGraphics: TGpGraphics; var x: Integer; var y: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipSetCompositingQuality(AGraphics: TGpGraphics; compositingQuality: TGPCompositingQuality): TGpStatus; stdcall; external gdiplus;
  function GdipGetCompositingQuality(AGraphics: TGpGraphics; var compositingQuality: TGPCompositingQuality): TGpStatus; stdcall; external gdiplus;
  function GdipSetSmoothingMode(AGraphics: TGpGraphics; smoothingMode: TGPSmoothingMode): TGpStatus; stdcall; external gdiplus;
  function GdipGetSmoothingMode(AGraphics: TGpGraphics; var smoothingMode: TGPSmoothingMode): TGpStatus; stdcall; external gdiplus;
  function GdipSetPixelOffsetMode(AGraphics: TGpGraphics; pixelOffsetMode: TGPPixelOffsetMode): TGpStatus; stdcall; external gdiplus;
  function GdipGetPixelOffsetMode(AGraphics: TGpGraphics; var pixelOffsetMode: TGPPixelOffsetMode): TGpStatus; stdcall; external gdiplus;
  function GdipSetTextRenderingHint(AGraphics: TGpGraphics; mode: TGPTextRenderingHint): TGpStatus; stdcall; external gdiplus;
  function GdipGetTextRenderingHint(AGraphics: TGpGraphics; var mode: TGPTextRenderingHint): TGpStatus; stdcall; external gdiplus;
  function GdipSetTextContrast(AGraphics: TGpGraphics; contrast: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipGetTextContrast(AGraphics: TGpGraphics; var contrast: UINT): TGpStatus; stdcall; external gdiplus;
  function GdipSetInterpolationMode(AGraphics: TGpGraphics; interpolationMode: TGPInterpolationMode): TGpStatus; stdcall; external gdiplus;
  function GdipGetInterpolationMode(AGraphics: TGpGraphics; var interpolationMode: TGPInterpolationMode): TGpStatus; stdcall; external gdiplus;
  function GdipSetWorldTransform(AGraphics: TGpGraphics; matrix: TGPMATRIX): TGpStatus; stdcall; external gdiplus;
  function GdipResetWorldTransform(AGraphics: TGpGraphics): TGpStatus; stdcall; external gdiplus;
  function GdipMultiplyWorldTransform(AGraphics: TGpGraphics; matrix: TGPMATRIX; order: TGPMatrixOrder): TGpStatus; stdcall; external gdiplus;
  function GdipTranslateWorldTransform(AGraphics: TGpGraphics; dx: Single; dy: Single; order: TGPMatrixOrder): TGpStatus; stdcall; external gdiplus;
  function GdipScaleWorldTransform(AGraphics: TGpGraphics; sx: Single; sy: Single; order: TGPMatrixOrder): TGpStatus; stdcall; external gdiplus;
  function GdipRotateWorldTransform(AGraphics: TGpGraphics; angle: Single; order: TGPMatrixOrder): TGpStatus; stdcall; external gdiplus;
  function GdipGetWorldTransform(AGraphics: TGpGraphics; matrix: TGPMATRIX): TGpStatus; stdcall; external gdiplus;
  function GdipResetPageTransform(AGraphics: TGpGraphics): TGpStatus; stdcall; external gdiplus;
  function GdipGetPageUnit(AGraphics: TGpGraphics; var unit_: TGPUNIT): TGpStatus; stdcall; external gdiplus;
  function GdipGetPageScale(AGraphics: TGpGraphics; var scale: Single): TGpStatus; stdcall; external gdiplus;
  function GdipSetPageUnit(AGraphics: TGpGraphics; unit_: TGPUNIT): TGpStatus; stdcall; external gdiplus;
  function GdipSetPageScale(AGraphics: TGpGraphics; scale: Single): TGpStatus; stdcall; external gdiplus;
  function GdipGetDpiX(AGraphics: TGpGraphics; var dpi: Single): TGpStatus; stdcall; external gdiplus;
  function GdipGetDpiY(AGraphics: TGpGraphics; var dpi: Single): TGpStatus; stdcall; external gdiplus;
  function GdipTransformPoints(AGraphics: TGpGraphics; destSpace: GPCOORDINATESPACE; srcSpace: GPCOORDINATESPACE; points: PGPPOINTF; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipTransformPointsI(AGraphics: TGpGraphics; destSpace: GPCOORDINATESPACE; srcSpace: GPCOORDINATESPACE; points: PGPPOINT; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipGetNearestColor(AGraphics: TGpGraphics; argb: PGPColor): TGpStatus; stdcall; external gdiplus;
// Creates the Win9x Halftone Palette (even on NT) with correct Desktop colors
  function GdipCreateHalftonePalette: HPALETTE; stdcall; external gdiplus;

implementation

end.
