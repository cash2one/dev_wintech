unit dll_gdiplus_path;

interface

uses
  dll_gdiplus;

  function GdipCreatePath(brushMode: TGPFILLMODE;
    out path: TGPPATH): TGPSTATUS; stdcall; external gdiplus; 

  function GdipCreatePath2(v1: PGPPOINTF; v2: PBYTE; v3: Integer; v4: TGPFILLMODE;
    out path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipCreatePath2I(v1: PGPPOINT; v2: PBYTE; v3: Integer; v4: TGPFILLMODE;
    out path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipClonePath(path: TGPPATH;
    out clonePath: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipDeletePath(path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipResetPath(path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPointCount(path: TGPPATH;
    out count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPathTypes(path: TGPPATH; types: PBYTE;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPathPoints(v1: TGPPATH; points: PGPPOINTF;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPathPointsI(v1: TGPPATH; points: PGPPOINT;
             count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPathFillMode(path: TGPPATH;
    var fillmode: TGPFILLMODE): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPathFillMode(path: TGPPATH;
    fillmode: TGPFILLMODE): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPathData(path: TGPPATH;
    pathData: Pointer): TGPSTATUS; stdcall; external gdiplus;

  function GdipStartPathFigure(path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipClosePathFigure(path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipClosePathFigures(path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipSetPathMarker(path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipClearPathMarkers(path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipReversePath(path: TGPPATH): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPathLastPoint(path: TGPPATH;
    lastPoint: PGPPOINTF): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathLine(path: TGPPATH;
    x1, y1, x2, y2: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathLine2(path: TGPPATH; points: PGPPOINTF;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathArc(path: TGPPATH; x, y, width, height, startAngle,
    sweepAngle: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathBezier(path: TGPPATH;
    x1, y1, x2, y2, x3, y3, x4, y4: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathBeziers(path: TGPPATH; points: PGPPOINTF;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathCurve(path: TGPPATH; points: PGPPOINTF;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathCurve2(path: TGPPATH; points: PGPPOINTF; count: Integer;
    tension: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathCurve3(path: TGPPATH; points: PGPPOINTF; count: Integer;
    offset: Integer; numberOfSegments: Integer;
    tension: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathClosedCurve(path: TGPPATH; points: PGPPOINTF;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathClosedCurve2(path: TGPPATH; points: PGPPOINTF;
    count: Integer; tension: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathRectangle(path: TGPPATH; x: Single; y: Single;
    width: Single; height: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathRectangles(path: TGPPATH; rects: TGPRECTF;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathEllipse(path: TGPPATH;  x: Single; y: Single;
    width: Single; height: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathPie(path: TGPPATH; x: Single; y: Single; width: Single;
    height: Single; startAngle: Single; sweepAngle: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathPolygon(path: TGPPATH; points: PGPPOINTF;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathPath(path: TGPPATH; addingPath: TGPPATH;
    connect: LongBool): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathString(path: TGPPATH; string_: PWideChar; length: Integer;
    family: TGPFONTFAMILY; style: Integer; emSize: Single; layoutRect: PGPRectF;
    format: TGPSTRINGFORMAT): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathStringI(path: TGPPATH; string_: PWideChar; length: Integer;
    family: TGPFONTFAMILY; style: Integer; emSize: Single; layoutRect: PGPRect;
    format: TGPSTRINGFORMAT): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathLineI(path: TGPPATH; x1: Integer; y1: Integer; x2: Integer;
    y2: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathLine2I(path: TGPPATH; points: PGPPOINT;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathArcI(path: TGPPATH; x: Integer; y: Integer; width: Integer;
    height: Integer; startAngle: Single; sweepAngle: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathBezierI(path: TGPPATH; x1: Integer; y1: Integer;
    x2: Integer; y2: Integer; x3: Integer; y3: Integer; x4: Integer;
    y4: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathBeziersI(path: TGPPATH; points: PGPPOINT;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathCurveI(path: TGPPATH; points: PGPPOINT;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathCurve2I(path: TGPPATH; points: PGPPOINT; count: Integer;
    tension: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathCurve3I(path: TGPPATH; points: PGPPOINT; count: Integer;
    offset: Integer; numberOfSegments: Integer;
    tension: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathClosedCurveI(path: TGPPATH; points: PGPPOINT;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathClosedCurve2I(path: TGPPATH; points: PGPPOINT;
    count: Integer; tension: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathRectangleI(path: TGPPATH; x: Integer; y: Integer;
    width: Integer; height: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathRectanglesI(path: TGPPATH; rects: TGPRECT;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathEllipseI(path: TGPPATH; x: Integer; y: Integer;
    width: Integer; height: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathPieI(path: TGPPATH; x: Integer; y: Integer; width: Integer;
    height: Integer; startAngle: Single; sweepAngle: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipAddPathPolygonI(path: TGPPATH; points: PGPPOINT;
    count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipFlattenPath(path: TGPPATH; matrix: TGPMATRIX;
    flatness: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipWindingModeOutline(path: TGPPATH; matrix: TGPMATRIX;
    flatness: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipWidenPath(nativePath: TGPPATH; pen: TGPPEN; matrix: TGPMATRIX;
    flatness: Single): TGPSTATUS; stdcall; external gdiplus;
                          
type
  TWarpMode = (
    WarpModePerspective,    // 0
    WarpModeBilinear        // 1
  );

  function GdipWarpPath(path: TGPPATH; matrix: TGPMATRIX; points: PGPPOINTF;
    count: Integer; srcx: Single; srcy: Single; srcwidth: Single;
    srcheight: Single; warpMode: TWARPMODE; flatness: Single): TGPSTATUS; stdcall; external gdiplus;

  function GdipTransformPath(path: TGPPATH; matrix: TGPMATRIX): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPathWorldBounds(path: TGPPATH; bounds: TGPRECTF;
    matrix: TGPMATRIX; pen: TGPPEN): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPathWorldBoundsI(path: TGPPATH; bounds: TGPRECT;
    matrix: TGPMATRIX; pen: TGPPEN): TGPSTATUS; stdcall; external gdiplus;

  function GdipIsVisiblePathPoint(path: TGPPATH; x: Single; y: Single;
    graphics: TGPGRAPHICS; out result: LongBool): TGPSTATUS; stdcall; external gdiplus;

  function GdipIsVisiblePathPointI(path: TGPPATH; x: Integer; y: Integer;
    graphics: TGPGRAPHICS; out result: LongBool): TGPSTATUS; stdcall; external gdiplus;

  function GdipIsOutlineVisiblePathPoint(path: TGPPATH; x: Single; y: Single;
    pen: TGPPEN; graphics: TGPGRAPHICS; out result: LongBool): TGPSTATUS; stdcall; external gdiplus;

  function GdipIsOutlineVisiblePathPointI(path: TGPPATH; x: Integer; y: Integer;
    pen: TGPPEN; graphics: TGPGRAPHICS; out result: LongBool): TGPSTATUS; stdcall; external gdiplus;

  function GdipCreatePathGradientFromPath(path: TGPPATH;
    out polyGradient: TGpPathGradient): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetPathGradientCenterColor(brush: TGpPathGradient;
    out colors: ARGB): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetPathGradientCenterColor(brush: TGpPathGradient;
    colors: ARGB): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetPathGradientSurroundColorsWithCount(brush: TGpPathGradient;
    color: PARGB; var count: Integer): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetPathGradientSurroundColorsWithCount(brush: TGpPathGradient;
    color: PARGB; var count: Integer): TGPSTATUS; stdcall; external gdiplus;

  function GdipGetPathGradientCenterPoint(brush: TGpPathGradient;
    points: PGPPOINTF): TGPSTATUS; stdcall; external gdiplus;
  function GdipGetPathGradientCenterPointI(brush: TGpPathGradient;
    points: PGPPOINT): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetPathGradientCenterPoint(brush: TGpPathGradient;
    points: PGPPOINTF): TGPSTATUS; stdcall; external gdiplus;
  function GdipSetPathGradientCenterPointI(brush: TGpPathGradient;
    points: PGPPOINT): TGPSTATUS; stdcall; external gdiplus;

implementation

end.
