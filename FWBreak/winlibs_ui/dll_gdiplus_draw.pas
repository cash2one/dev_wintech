{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdiplus_draw;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype, dll_gdiplus;

  function GdipDrawLine(graphics: TGpGraphics; pen: TGPPEN; x1: Single;
      y1: Single; x2: Single; y2: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawLineI(graphics: TGpGraphics; pen: TGPPEN; x1: Integer;
      y1: Integer; x2: Integer; y2: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawLines(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINTF;
      count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawLinesI(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINT;
      count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawArc(graphics: TGpGraphics; pen: TGPPEN; x: Single; y: Single;
      width: Single; height: Single; startAngle: Single;
      sweepAngle: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawArcI(graphics: TGpGraphics; pen: TGPPEN; x: Integer;
      y: Integer; width: Integer; height: Integer; startAngle: Single;
      sweepAngle: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawBezier(graphics: TGpGraphics; pen: TGPPEN; x1: Single;
      y1: Single; x2: Single; y2: Single; x3: Single; y3: Single; x4: Single;
      y4: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawBezierI(graphics: TGpGraphics; pen: TGPPEN; x1: Integer;
      y1: Integer; x2: Integer; y2: Integer; x3: Integer; y3: Integer;
      x4: Integer; y4: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawBeziers(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINTF;
      count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawBeziersI(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINT;
      count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawRectangle(graphics: TGpGraphics; pen: TGPPEN; x: Single;
      y: Single; width: Single; height: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawRectangleI(graphics: TGpGraphics; pen: TGPPEN; x: Integer;
      y: Integer; width: Integer; height: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawEllipse(graphics: TGpGraphics; pen: TGPPEN; x: Single;
      y: Single; width: Single; height: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawEllipseI(graphics: TGpGraphics; pen: TGPPEN; x: Integer;
      y: Integer; width: Integer; height: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawPie(graphics: TGpGraphics; pen: TGPPEN; x: Single; y: Single;
      width: Single;  height: Single; startAngle: Single;
      sweepAngle: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawPieI(graphics: TGpGraphics; pen: TGPPEN; x: Integer;
      y: Integer; width: Integer; height: Integer; startAngle: Single;
      sweepAngle: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawPolygon(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINTF;
      count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawPolygonI(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINT;
      count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawPath(graphics: TGpGraphics; pen: TGPPEN;
      path: TGPPATH): TGpStatus; stdcall; external gdiplus;
  function GdipDrawCurve(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINTF;
      count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawCurveI(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINT;
      count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawCurve2(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINTF;
      count: Integer; tension: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawCurve2I(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINT;
      count: Integer; tension: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawCurve3(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINTF;
      count: Integer; offset: Integer; numberOfSegments: Integer;
      tension: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawCurve3I(graphics: TGpGraphics; pen: TGPPEN; points: PGPPOINT;
      count: Integer; offset: Integer; numberOfSegments: Integer;
      tension: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawClosedCurve(graphics: TGpGraphics; pen: TGPPEN;
      points: PGPPOINTF; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawClosedCurveI(graphics: TGpGraphics; pen: TGPPEN;
      points: PGPPOINT; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipDrawClosedCurve2(graphics: TGpGraphics; pen: TGPPEN;
      points: PGPPOINTF; count: Integer; tension: Single): TGpStatus; stdcall; external gdiplus;
  function GdipDrawClosedCurve2I(graphics: TGpGraphics; pen: TGPPEN;
      points: PGPPOINT; count: Integer; tension: Single): TGpStatus; stdcall; external gdiplus;
  function GdipGraphicsClear(graphics: TGpGraphics;
      color: TGPColor): TGpStatus; stdcall; external gdiplus;
  function GdipFillRectangle(graphics: TGpGraphics; brush: TGPBRUSH; x: Single;
    y: Single; width: Single; height: Single): TGpStatus; stdcall; external gdiplus;
  function GdipFillRectangleI(graphics: TGpGraphics; brush: TGPBRUSH; x: Integer;
    y: Integer; width: Integer; height: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipFillRectangles(graphics: TGpGraphics; brush: TGPBRUSH;
    rects: TGPRECTF; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipFillRectanglesI(graphics: TGpGraphics; brush: TGPBRUSH;
    rects: TGPRECT; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipFillPolygon(graphics: TGpGraphics; brush: TGPBRUSH;
    points: PGPPOINTF; count: Integer; fillMode: TGPFILLMODE): TGpStatus; stdcall; external gdiplus;
  function GdipFillPolygonI(graphics: TGpGraphics; brush: TGPBRUSH;
    points: PGPPOINT; count: Integer; fillMode: TGPFILLMODE): TGpStatus; stdcall; external gdiplus;
  function GdipFillPolygon2(graphics: TGpGraphics; brush: TGPBRUSH;
    points: PGPPOINTF; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipFillPolygon2I(graphics: TGpGraphics; brush: TGPBRUSH;
    points: PGPPOINT; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipFillEllipse(graphics: TGpGraphics; brush: TGPBRUSH; x: Single;
    y: Single; width: Single; height: Single): TGpStatus; stdcall; external gdiplus;
  function GdipFillEllipseI(graphics: TGpGraphics; brush: TGPBRUSH; x: Integer;
    y: Integer; width: Integer; height: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipFillPie(graphics: TGpGraphics; brush: TGPBRUSH; x: Single;
    y: Single; width: Single; height: Single; startAngle: Single;
    sweepAngle: Single): TGpStatus; stdcall; external gdiplus;
  function GdipFillPieI(graphics: TGpGraphics; brush: TGPBRUSH; x: Integer;
    y: Integer; width: Integer; height: Integer; startAngle: Single;
    sweepAngle: Single): TGpStatus; stdcall; external gdiplus;
  function GdipFillPath(graphics: TGpGraphics; brush: TGPBRUSH;
    path: TGPPATH): TGpStatus; stdcall; external gdiplus;
  function GdipFillClosedCurve(graphics: TGpGraphics; brush: TGPBRUSH;
    points: PGPPOINTF; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipFillClosedCurveI(graphics: TGpGraphics; brush: TGPBRUSH;
    points: PGPPOINT; count: Integer): TGpStatus; stdcall; external gdiplus;
  function GdipFillClosedCurve2(graphics: TGpGraphics; brush: TGPBRUSH;
    points: PGPPOINTF; count: Integer; tension: Single;
    fillMode: TGPFILLMODE): TGpStatus; stdcall; external gdiplus;
  function GdipFillClosedCurve2I(graphics: TGpGraphics; brush: TGPBRUSH;
    points: PGPPOINT; count: Integer; tension: Single;
    fillMode: TGPFILLMODE): TGpStatus; stdcall; external gdiplus;
  function GdipFillRegion(graphics: TGpGraphics; brush: TGPBRUSH;
    region: TGpRegion): TGpStatus; stdcall; external gdiplus;

implementation

end.