{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdiplus_brush;

interface
                 
uses
  atmcmbaseconst, winconst, wintype, dll_gdiplus;

//----------------------------------------------------------------------------
// Brush APIs
//----------------------------------------------------------------------------
type
  TGPBrushType = (
   BrushTypeSolidColor,
   BrushTypeHatchFill,
   BrushTypeTextureFill,
   BrushTypePathGradient,
   BrushTypeLinearGradient
  );

  function GdipCloneBrush(brush: TGPBRUSH;
    out cloneBrush: TGPBRUSH): TGPSTATUS; stdcall; external gdiplus;
  function GdipDeleteBrush(brush: TGPBRUSH): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetBrushType(brush: TGPBRUSH; out type_: TGPBRUSHTYPE): TGPSTATUS; stdcall; external gdiplus;
                        
//----------------------------------------------------------------------------
// HatchBrush APIs
//----------------------------------------------------------------------------

type
  TGPHATCHSTYLE = (
    HatchStyleHorizontal,                  // = 0,
    HatchStyleVertical,                    // = 1,
    HatchStyleForwardDiagonal,             // = 2,
    HatchStyleBackwardDiagonal,            // = 3,
    HatchStyleCross,                       // = 4,
    HatchStyleDiagonalCross,               // = 5,
    HatchStyle05Percent,                   // = 6,
    HatchStyle10Percent,                   // = 7,
    HatchStyle20Percent,                   // = 8,
    HatchStyle25Percent,                   // = 9,
    HatchStyle30Percent,                   // = 10,
    HatchStyle40Percent,                   // = 11,
    HatchStyle50Percent,                   // = 12,
    HatchStyle60Percent,                   // = 13,
    HatchStyle70Percent,                   // = 14,
    HatchStyle75Percent,                   // = 15,
    HatchStyle80Percent,                   // = 16,
    HatchStyle90Percent,                   // = 17,
    HatchStyleLightDownwardDiagonal,       // = 18,
    HatchStyleLightUpwardDiagonal,         // = 19,
    HatchStyleDarkDownwardDiagonal,        // = 20,
    HatchStyleDarkUpwardDiagonal,          // = 21,
    HatchStyleWideDownwardDiagonal,        // = 22,
    HatchStyleWideUpwardDiagonal,          // = 23,
    HatchStyleLightVertical,               // = 24,
    HatchStyleLightHorizontal,             // = 25,
    HatchStyleNarrowVertical,              // = 26,
    HatchStyleNarrowHorizontal,            // = 27,
    HatchStyleDarkVertical,                // = 28,
    HatchStyleDarkHorizontal,              // = 29,
    HatchStyleDashedDownwardDiagonal,      // = 30,
    HatchStyleDashedUpwardDiagonal,        // = 31,
    HatchStyleDashedHorizontal,            // = 32,
    HatchStyleDashedVertical,              // = 33,
    HatchStyleSmallConfetti,               // = 34,
    HatchStyleLargeConfetti,               // = 35,
    HatchStyleZigZag,                      // = 36,
    HatchStyleWave,                        // = 37,
    HatchStyleDiagonalBrick,               // = 38,
    HatchStyleHorizontalBrick,             // = 39,
    HatchStyleWeave,                       // = 40,
    HatchStylePlaid,                       // = 41,
    HatchStyleDivot,                       // = 42,
    HatchStyleDottedGrid,                  // = 43,
    HatchStyleDottedDiamond,               // = 44,
    HatchStyleShingle,                     // = 45,
    HatchStyleTrellis,                     // = 46,
    HatchStyleSphere,                      // = 47,
    HatchStyleSmallGrid,                   // = 48,
    HatchStyleSmallCheckerBoard,           // = 49,
    HatchStyleLargeCheckerBoard,           // = 50,
    HatchStyleOutlinedDiamond,             // = 51,
    HatchStyleSolidDiamond,                // = 52,
    HatchStyleTotal                        // = 53,
  );

  function GdipCreateHatchBrush(hatchstyle: Integer; forecol: ARGB;
    backcol: ARGB; out brush: TGPHATCH): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetHatchStyle(brush: TGPHATCH; out hatchstyle: TGPHATCHSTYLE): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetHatchForegroundColor(brush: TGPHATCH; out forecol: ARGB): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetHatchBackgroundColor(brush: TGPHATCH; out backcol: ARGB): TGPSTATUS; stdcall; external gdiplus;

//----------------------------------------------------------------------------
// TextureBrush APIs
//----------------------------------------------------------------------------
  function GdipCreateTexture(image: TGPIMAGE; wrapmode: TGPWRAPMODE; var texture: TGPTEXTURE): TGPSTATUS; stdcall; external gdiplus;
  function GdipCreateTexture2(image: TGPIMAGE; wrapmode: TGPWRAPMODE; x: Single; y: Single; width: Single; height: Single;
    out texture: TGPTEXTURE): TGPSTATUS; stdcall; external gdiplus;
  function GdipCreateTextureIA(image: TGPIMAGE;
    imageAttributes: TGPIMAGEATTRIBUTES; x: Single; y: Single; width: Single;
    height: Single; out texture: TGPTEXTURE): TGPSTATUS; stdcall; external gdiplus;
  function GdipCreateTexture2I(image: TGPIMAGE; wrapmode: TGPWRAPMODE; x: Integer;
    y: Integer; width: Integer; height: Integer;
    out texture: TGPTEXTURE): TGPSTATUS; stdcall; external gdiplus;
  function GdipCreateTextureIAI(image: TGPIMAGE;
    imageAttributes: TGPIMAGEATTRIBUTES; x: Integer; y: Integer; width: Integer;
    height: Integer; out texture: TGPTEXTURE): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetTextureTransform(brush: TGPTEXTURE;
    matrix: TGPMATRIX): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetTextureTransform(brush: TGPTEXTURE;
    matrix: TGPMATRIX): TGPSTATUS; stdcall; external gdiplus;
  function GdipResetTextureTransform(brush: TGPTEXTURE): TGPSTATUS; stdcall; external gdiplus;
  function GdipMultiplyTextureTransform(brush: TGPTEXTURE; matrix: TGPMATRIX;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;
  function GdipTranslateTextureTransform(brush: TGPTEXTURE; dx: Single;
    dy: Single; order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;
  function GdipScaleTextureTransform(brush: TGPTEXTURE; sx: Single; sy: Single;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;
  function GdipRotateTextureTransform(brush: TGPTEXTURE; angle: Single;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetTextureWrapMode(brush: TGPTEXTURE; wrapmode: TGPWRAPMODE): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetTextureWrapMode(brush: TGPTEXTURE; var wrapmode: TGPWRAPMODE): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetTextureImage(brush: TGPTEXTURE; out image: TGPIMAGE): TGPSTATUS; stdcall; external gdiplus;
//----------------------------------------------------------------------------
// SolidBrush APIs
//----------------------------------------------------------------------------

  function GdipCreateSolidFill(color: ARGB; out brush: TGPSOLIDFILL): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetSolidFillColor(brush: TGPSOLIDFILL; color: ARGB): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetSolidFillColor(brush: TGPSOLIDFILL; out color: ARGB): TGPSTATUS; stdcall; external gdiplus;

//----------------------------------------------------------------------------
// LineBrush APIs
//----------------------------------------------------------------------------

type
  TLinearGradientMode = (
    LinearGradientModeHorizontal,         // 0
    LinearGradientModeVertical,           // 1
    LinearGradientModeForwardDiagonal,    // 2
    LinearGradientModeBackwardDiagonal    // 3
  );

  function GdipCreateLineBrush(point1: PGPPOINTF; point2: PGPPOINTF; color1: DWORD;
    color2: DWORD; wrapMode: TGPWRAPMODE;
    out lineGradient: TGPLINEGRADIENT): TGPSTATUS; stdcall; external gdiplus name 'GdipCreateLineBrush';
  function GdipCreateLineBrushI(point1: PGPPOINT; point2: PGPPOINT; color1: DWORD;
    color2: DWORD; wrapMode: TGPWRAPMODE;
    out lineGradient: TGPLINEGRADIENT): TGPSTATUS; stdcall; external gdiplus name 'GdipCreateLineBrushI';
  function GdipCreateLineBrushFromRect(rect: PGPRECTF; color1: DWORD;
    color2: DWORD; mode: TLINEARGRADIENTMODE; wrapMode: TGPWRAPMODE;
    out lineGradient: TGPLINEGRADIENT): TGPSTATUS; stdcall; external gdiplus name 'GdipCreateLineBrushFromRect';
  function GdipCreateLineBrushFromRectI(rect: PGPRECT; color1: DWORD;
    color2: DWORD; mode: TLINEARGRADIENTMODE; wrapMode: TGPWRAPMODE;
    out lineGradient: TGPLINEGRADIENT): TGPSTATUS; stdcall; external gdiplus name 'GdipCreateLineBrushFromRectI';
  function GdipCreateLineBrushFromRectWithAngle(rect: PGPRECTF; color1: DWORD;
    color2: DWORD; angle: Single; isAngleScalable: Bool; wrapMode: TGPWRAPMODE;
    out lineGradient: TGPLINEGRADIENT): TGPSTATUS; stdcall; external gdiplus name 'GdipCreateLineBrushFromRectWithAngle';
  function GdipCreateLineBrushFromRectWithAngleI(rect: PGPRECT; color1: DWORD;
    color2: DWORD; angle: Single; isAngleScalable: Bool; wrapMode: TGPWRAPMODE;
    out lineGradient: TGPLINEGRADIENT): TGPSTATUS; stdcall; external gdiplus name 'GdipCreateLineBrushFromRectWithAngleI';

    
  function GdipSetLineColors(brush: TGPLINEGRADIENT; color1: DWORD;
    color2: DWORD): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLineColors(brush: TGPLINEGRADIENT;
    colors: PARGB): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLineRect(brush: TGPLINEGRADIENT;
    rect: TGPRECTF): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLineRectI(brush: TGPLINEGRADIENT;
    rect: TGPRECT): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetLineGammaCorrection(brush: TGPLINEGRADIENT;
    useGammaCorrection: Bool): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLineGammaCorrection(brush: TGPLINEGRADIENT;
    out useGammaCorrection: Bool): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLineBlendCount(brush: TGPLINEGRADIENT;
    out count: Integer): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLineBlend(brush: TGPLINEGRADIENT; blend: PSingle;
    positions: PSingle; count: Integer): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetLineBlend(brush: TGPLINEGRADIENT; blend: PSingle;
    positions: PSingle; count: Integer): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLinePresetBlendCount(brush: TGPLINEGRADIENT;
    out count: Integer): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLinePresetBlend(brush: TGPLINEGRADIENT; blend: PARGB;
    positions: PSingle; count: Integer): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetLinePresetBlend(brush: TGPLINEGRADIENT; blend: PARGB;
    positions: PSingle; count: Integer): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetLineSigmaBlend(brush: TGPLINEGRADIENT; focus: Single;
    scale: Single): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetLineLinearBlend(brush: TGPLINEGRADIENT; focus: Single;
    scale: Single): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetLineWrapMode(brush: TGPLINEGRADIENT;
    wrapmode: TGPWRAPMODE): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLineWrapMode(brush: TGPLINEGRADIENT;
    out wrapmode: TGPWRAPMODE): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetLineTransform(brush: TGPLINEGRADIENT;
    matrix: TGPMATRIX): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetLineTransform(brush: TGPLINEGRADIENT;
    matrix: TGPMATRIX): TGPSTATUS; stdcall; external gdiplus;
  function GdipResetLineTransform(brush: TGPLINEGRADIENT): TGPSTATUS; stdcall; external gdiplus;
  function GdipMultiplyLineTransform(brush: TGPLINEGRADIENT; matrix: TGPMATRIX;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;
  function GdipTranslateLineTransform(brush: TGPLINEGRADIENT; dx: Single;
    dy: Single; order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;
  function GdipScaleLineTransform(brush: TGPLINEGRADIENT; sx: Single; sy: Single;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;
  function GdipRotateLineTransform(brush: TGPLINEGRADIENT; angle: Single;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;


implementation

end.
