{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdiplus_matrix;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype, dll_gdiplus;

  function GdipCreateMatrix(out matrix: TGPMatrix): TGPStatus; stdcall; external gdiplus;
  function GdipCreateMatrix2(m11: Single; m12: Single; m21: Single; m22: Single;
    dx: Single; dy: Single; out matrix: TGPMatrix): TGPStatus; stdcall; external gdiplus;
  function GdipCreateMatrix3(rect: PGPRECTF; dstplg: PGPPointF;
    out matrix: TGPMatrix): TGPStatus; stdcall; external gdiplus;
  function GdipCreateMatrix3I(rect: PGPRect; dstplg: PGPPoint; out matrix: TGPMatrix): TGPStatus; stdcall; external gdiplus;
  function GdipCloneMatrix(matrix: TGPMatrix; out cloneMatrix: TGPMatrix): TGPStatus; stdcall; external gdiplus;
  function GdipDeleteMatrix(matrix: TGPMatrix): TGPStatus; stdcall; external gdiplus;
  function GdipSetMatrixElements(matrix: TGPMatrix; m11: Single; m12: Single;
    m21: Single; m22: Single; dx: Single; dy: Single): TGPStatus; stdcall; external gdiplus;
  function GdipMultiplyMatrix(matrix: TGPMatrix; matrix2: TGPMatrix;
    order: TGPMatrixORDER): TGPStatus; stdcall; external gdiplus;
  function GdipTranslateMatrix(matrix: TGPMatrix; offsetX: Single;
    offsetY: Single; order: TGPMatrixORDER): TGPStatus; stdcall; external gdiplus;
  function GdipScaleMatrix(matrix: TGPMatrix; scaleX: Single; scaleY: Single;
    order: TGPMatrixORDER): TGPStatus; stdcall; external gdiplus;
  function GdipRotateMatrix(matrix: TGPMatrix; angle: Single;
    order: TGPMatrixORDER): TGPStatus; stdcall; external gdiplus;
  function GdipShearMatrix(matrix: TGPMatrix; shearX: Single; shearY: Single;
    order: TGPMatrixORDER): TGPStatus; stdcall; external gdiplus;
  function GdipInvertMatrix(matrix: TGPMatrix): TGPStatus; stdcall; external gdiplus;
  function GdipTransformMatrixPoints(matrix: TGPMatrix; pts: PGPPointF;
    count: Integer): TGPStatus; stdcall; external gdiplus;
  function GdipTransformMatrixPointsI(matrix: TGPMatrix; pts: PGPPoint;
    count: Integer): TGPStatus; stdcall; external gdiplus;
  function GdipVectorTransformMatrixPoints(matrix: TGPMatrix; pts: PGPPointF;
    count: Integer): TGPStatus; stdcall; external gdiplus;
  function GdipVectorTransformMatrixPointsI(matrix: TGPMatrix; pts: PGPPoint;
    count: Integer): TGPStatus; stdcall; external gdiplus;
  function GdipGetMatrixElements(matrix: TGPMatrix;
    matrixOut: PSingle): TGPStatus; stdcall; external gdiplus;
  function GdipIsMatrixInvertible(matrix: TGPMatrix;
    out result: Bool): TGPStatus; stdcall; external gdiplus;
  function GdipIsMatrixIdentity(matrix: TGPMatrix;
    out result: Bool): TGPStatus; stdcall; external gdiplus;
  function GdipIsMatrixEqual(matrix: TGPMatrix; matrix2: TGPMatrix;
    out result: Bool): TGPStatus; stdcall; external gdiplus;

implementation

end.
