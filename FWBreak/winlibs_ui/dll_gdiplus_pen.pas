{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdiplus_pen;

interface
                 
uses
  atmcmbaseconst, winconst, wintype, dll_gdiplus;

const                           
  LineCapFlat             = 0;
  LineCapSquare           = 1;
  LineCapRound            = 2;
  LineCapTriangle         = 3;

  LineCapNoAnchor         = $10; // corresponds to flat cap
  LineCapSquareAnchor     = $11; // corresponds to square cap
  LineCapRoundAnchor      = $12; // corresponds to round cap
  LineCapDiamondAnchor    = $13; // corresponds to triangle cap
  LineCapArrowAnchor      = $14; // no correspondence

  LineCapCustom           = $ff; // custom cap

  LineCapAnchorMask       = $f0; // mask to check for anchor or not.

    
  DashCapFlat             = 0;
  DashCapRound            = 2;
  DashCapTriangle         = 3;

  PenTypeSolidColor       =  0;
  PenTypeHatchFill        =  1;
  PenTypeTextureFill      =  2;
  PenTypePathGradient     =  3;
  PenTypeLinearGradient   =  4;
  PenTypeUnknown          = -1;
type
  TGpLineCap         = Integer;
  TGpDashCap         = Integer;  
  TGPPENTYPE         = Integer;
   
  TGPLineJoin = (
    LineJoinMiter,
    LineJoinBevel,
    LineJoinRound,
    LineJoinMiterClipped
  );

  TGPPenAlignment = (
    PenAlignmentCenter,
    PenAlignmentInset
  );
  
  TGPDashStyle = (
    DashStyleSolid,          // 0
    DashStyleDash,           // 1
    DashStyleDot,            // 2
    DashStyleDashDot,        // 3
    DashStyleDashDotDot,     // 4
    DashStyleCustom          // 5
  );
//----------------------------------------------------------------------------
// Pen APIs
//----------------------------------------------------------------------------
  function GdipCreatePen1(color: DWORD; width: Single; unit_: TGPUNIT;
    out pen: TGPPEN): TGPSTATUS; stdcall; external gdiplus;

  function GdipCreatePen2(brush: TGPBRUSH; width: Single; unit_: TGPUNIT;
    out pen: TGPPEN): TGPSTATUS; stdcall; external gdiplus;

  function GdipClonePen(pen: TGPPEN; out clonepen: TGPPEN): TGPSTATUS; stdcall; external gdiplus;

  function GdipDeletePen(pen: TGPPEN): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenWidth(pen: TGPPEN; width: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenWidth(pen: TGPPEN; out width: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenUnit(pen: TGPPEN; unit_: TGPUNIT): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenUnit(pen: TGPPEN; var unit_: TGPUNIT): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenLineCap197819(pen: TGPPEN; startCap: TGPLINECAP;
    endCap: TGPLINECAP; dashCap: TGPDASHCAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenStartCap(pen: TGPPEN;
    startCap: TGPLINECAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenEndCap(pen: TGPPEN; endCap: TGPLINECAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenDashCap197819(pen: TGPPEN;
    dashCap: TGPDASHCAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenStartCap(pen: TGPPEN;
    out startCap: TGPLINECAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenEndCap(pen: TGPPEN;
    out endCap: TGPLINECAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenDashCap197819(pen: TGPPEN;
    out dashCap: TGPDASHCAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenLineJoin(pen: TGPPEN;
    lineJoin: TGPLINEJOIN): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenLineJoin(pen: TGPPEN;
    var lineJoin: TGPLINEJOIN): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenCustomStartCap(pen: TGPPEN;
    customCap: TGPCUSTOMLINECAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenCustomStartCap(pen: TGPPEN;
    out customCap: TGPCUSTOMLINECAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenCustomEndCap(pen: TGPPEN;
    customCap: TGPCUSTOMLINECAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenCustomEndCap(pen: TGPPEN;
    out customCap: TGPCUSTOMLINECAP): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenMiterLimit(pen: TGPPEN;
    miterLimit: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenMiterLimit(pen: TGPPEN;
    out miterLimit: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenMode(pen: TGPPEN;
    penMode: TGPPENALIGNMENT): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenMode(pen: TGPPEN;
    var penMode: TGPPENALIGNMENT): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenTransform(pen: TGPPEN;
    matrix: TGPMATRIX): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenTransform(pen: TGPPEN;
    matrix: TGPMATRIX): TGPSTATUS; stdcall; external gdiplus;

  function GdipResetPenTransform(pen: TGPPEN): TGPSTATUS; stdcall; external gdiplus;

  function GdipMultiplyPenTransform(pen: TGPPEN; matrix: TGPMATRIX;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;

  function GdipTranslatePenTransform(pen: TGPPEN; dx: Single; dy: Single;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;

  function GdipScalePenTransform(pen: TGPPEN; sx: Single; sy: Single;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;

  function GdipRotatePenTransform(pen: TGPPEN; angle: Single;
    order: TGPMATRIXORDER): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenColor(pen: TGPPEN; argb: ARGB): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenColor(pen: TGPPEN; out argb: ARGB): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenBrushFill(pen: TGPPEN; brush: TGPBRUSH): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenBrushFill(pen: TGPPEN;
    out brush: TGPBRUSH): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenFillType(pen: TGPPEN;
    out type_: TGPPENTYPE): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenDashStyle(pen: TGPPEN;
    out dashstyle: TGPDASHSTYLE): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenDashStyle(pen: TGPPEN;
    dashstyle: TGPDASHSTYLE): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenDashOffset(pen: TGPPEN;
    out offset: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenDashOffset(pen: TGPPEN; offset: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenDashCount(pen: TGPPEN;
    var count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenDashArray(pen: TGPPEN; dash: PSingle;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenDashArray(pen: TGPPEN; dash: PSingle;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenCompoundCount(pen: TGPPEN;
    out count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPenCompoundArray(pen: TGPPEN; dash: PSingle;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPenCompoundArray(pen: TGPPEN; dash: PSingle;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

implementation

end.
