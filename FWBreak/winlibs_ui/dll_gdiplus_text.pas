{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdiplus_text;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype, wintypeA, dll_gdiplus;
                             
type                    
  TGPStrAlignment = (
    // Left edge for left-to-right text,
    // right for right-to-left text,
    // and top for vertical
    StrAlignmentNear,
    StrAlignmentCenter,
    StrAlignmentFar
  );
          
  TGPStrTrimming = (
    StrTrimmingNone,
    StrTrimmingCharacter,
    StrTrimmingWord,
    StrTrimmingEllipsisCharacter,
    StrTrimmingEllipsisWord,
    StrTrimmingEllipsisPath
  );
           
  TGPStrDigitSubstitute = (
    StrDigitSubstituteUser,          // As NLS setting
    StrDigitSubstituteNone,
    StrDigitSubstituteNational,
    StrDigitSubstituteTraditional
  );
             
  PGPStrDigitSubstitute = ^TGPStrDigitSubstitute;
  PGPCharacterRange = ^TGPCharacterRange;
  TGPCharacterRange = packed record
    First  : Integer;
    Length : Integer;
  end;
  
  function GdipCreateFontFamilyFromName(name: PWCHAR;
      fontCollection: TGPFONTCOLLECTION;
      out FontFamily: TGPFONTFAMILY): TGpStatus; stdcall; external gdiplus;
  function GdipDeleteFontFamily(FontFamily: TGPFONTFAMILY): TGpStatus; stdcall; external gdiplus;
  function GdipCloneFontFamily(FontFamily: TGPFONTFAMILY;
    out clonedFontFamily: TGPFONTFAMILY): TGpStatus; stdcall; external gdiplus;
  function GdipGetGenericFontFamilySansSerif(
    out nativeFamily: TGPFONTFAMILY): TGpStatus; stdcall; external gdiplus;

  function GdipGetGenericFontFamilySerif(
    out nativeFamily: TGPFONTFAMILY): TGpStatus; stdcall; external gdiplus;

  function GdipGetGenericFontFamilyMonospace(
    out nativeFamily: TGPFONTFAMILY): TGpStatus; stdcall; external gdiplus;

  function GdipGetFamilyName(family: TGPFONTFAMILY; name: PWideChar;
    language: LANGID): TGpStatus; stdcall; external gdiplus;

  function GdipIsStyleAvailable(family: TGPFONTFAMILY; style: Integer;
    var IsStyleAvailable: Bool): TGpStatus; stdcall; external gdiplus;

  function GdipFontCollectionEnumerable(fontCollection: TGPFONTCOLLECTION;
    graphics: TGpGraphics; var numFound: Integer): TGpStatus; stdcall; external gdiplus;

  function GdipFontCollectionEnumerate(fontCollection: TGPFONTCOLLECTION;
    numSought: Integer; gpfamilies: array of TGPFONTFAMILY;
    var numFound: Integer; graphics: TGpGraphics): TGpStatus; stdcall; external gdiplus;

  function GdipGetEmHeight(family: TGPFONTFAMILY; style: Integer;
    out EmHeight: UINT16): TGpStatus; stdcall; external gdiplus;

  function GdipGetCellAscent(family: TGPFONTFAMILY; style: Integer;
    var CellAscent: UINT16): TGpStatus; stdcall; external gdiplus;

  function GdipGetCellDescent(family: TGPFONTFAMILY; style: Integer;
    var CellDescent: UINT16): TGpStatus; stdcall; external gdiplus;

  function GdipGetLineSpacing(family: TGPFONTFAMILY; style: Integer;
    var LineSpacing: UINT16): TGpStatus; stdcall; external gdiplus;


  function GdipCreateFontFromDC(hdc: HDC; out font: TGPFONT): TGpStatus; stdcall; external gdiplus;

  function GdipCreateFontFromLogfontA(hdc: HDC; logfont: PLOGFONTA;
    out font: TGPFONT): TGpStatus; stdcall; external gdiplus;

//  function GdipCreateFontFromLogfontW(hdc: HDC; logfont: PLOGFONTW;
//    out font: TGPFONT): TGpStatus; stdcall; external gdiplus;

  function GdipCreateFont(fontFamily: TGPFONTFAMILY; emSize: Single;
    style: Integer; unit_: Integer; out font: TGPFONT): TGpStatus; stdcall; external gdiplus;

  function GdipCloneFont(font: TGPFONT;
    out cloneFont: TGPFONT): TGpStatus; stdcall; external gdiplus;

  function GdipDeleteFont(font: TGPFONT): TGpStatus; stdcall; external gdiplus;

  function GdipGetFamily(font: TGPFONT;
    out family: TGPFONTFAMILY): TGpStatus; stdcall; external gdiplus;

  function GdipGetFontStyle(font: TGPFONT;
    var style: Integer): TGpStatus; stdcall; external gdiplus;

  function GdipGetFontSize(font: TGPFONT; var size: Single): TGpStatus; stdcall; external gdiplus;
  function GdipGetFontUnit(font: TGPFONT; var unit_: TGPUnit): TGpStatus; stdcall; external gdiplus;

  function GdipGetFontHeight(font: TGPFONT; graphics: TGpGraphics;
    var height: Single): TGpStatus; stdcall; external gdiplus;

  function GdipGetFontHeightGivenDPI(font: TGPFONT; dpi: Single;
    var height: Single): TGpStatus; stdcall; external gdiplus;

  function GdipGetLogFontA(font: TGPFONT; graphics: TGpGraphics;
    var logfontA: TLOGFONTA): TGpStatus; stdcall; external gdiplus;

//  function GdipGetLogFontW(font: TGPFONT; graphics: TGpGraphics;
//    var logfontW: LOGFONTW): TGpStatus; stdcall; external gdiplus;

  function GdipNewInstalledFontCollection(
    out fontCollection: TGPFONTCOLLECTION): TGpStatus; stdcall; external gdiplus;

  function GdipNewPrivateFontCollection(
    out fontCollection: TGPFONTCOLLECTION): TGpStatus; stdcall; external gdiplus;

  function GdipDeletePrivateFontCollection(
    out fontCollection: TGPFONTCOLLECTION): TGpStatus; stdcall; external gdiplus;

  function GdipGetFontCollectionFamilyCount(fontCollection: TGPFONTCOLLECTION;
    var numFound: Integer): TGpStatus; stdcall; external gdiplus;

  function GdipGetFontCollectionFamilyList(fontCollection: TGPFONTCOLLECTION;
    numSought: Integer; gpfamilies: TGPFONTFAMILY;
    var numFound: Integer): TGpStatus; stdcall; external gdiplus;

  function GdipPrivateAddFontFile(fontCollection: TGPFONTCOLLECTION;
    filename: PWCHAR): TGpStatus; stdcall; external gdiplus;

  function GdipPrivateAddMemoryFont(fontCollection: TGPFONTCOLLECTION;
    memory: Pointer; length: Integer): TGpStatus; stdcall; external gdiplus;


  function GdipDrawStr(graphics: TGpGraphics; string_: PWCHAR;
    length: Integer; font: TGPFONT; layoutRect: PGPRectF;
    strFormat: TGpStrFormat; brush: TGPBRUSH): TGpStatus; stdcall; external gdiplus name 'GdipDrawString';

  function GdipMeasureStr(graphics: TGpGraphics; string_: PWCHAR;
    length: Integer; font: TGPFONT; layoutRect: PGPRectF;
    strFormat: TGpStrFormat; boundingBox: PGPRectF;
    codepointsFitted: PInteger; linesFilled: PInteger): TGpStatus; stdcall; external gdiplus name 'GdipMeasureString';

  function GdipMeasureCharacterRanges(graphics: TGpGraphics; string_: PWCHAR;
    length: Integer; font: TGPFONT; layoutRect: PGPRectF;
    strFormat: TGpStrFormat; regionCount: Integer;
    const regions: TGpRegion): TGpStatus; stdcall; external gdiplus;

  function GdipDrawDriverStr(graphics: TGpGraphics; const text: PUINT16;
    length: Integer; const font: TGPFONT; const brush: TGPBRUSH;
    const positions: PGPPointF; flags: Integer;
    const matrix: TGPMATRIX): TGpStatus; stdcall; external gdiplus name 'GdipDrawDriverString';

  function GdipMeasureDriverStr(graphics: TGpGraphics; text: PUINT16;
    length: Integer; font: TGPFONT; positions: PGPPointF; flags: Integer;
    matrix: TGPMATRIX; boundingBox: PGPRectF): TGpStatus; stdcall; external gdiplus name 'GdipMeasureDriverString';
    
{ str format }

  function GdipCreateStrFormat(formatAttributes: Integer; language: LANGID;
    out format: TGpStrFormat): TGpStatus; stdcall; external gdiplus name 'GdipCreateStringFormat';

  function GdipStrFormatGetGenericDefault(
    out format: TGpStrFormat): TGpStatus; stdcall; external gdiplus name 'GdipStringFormatGetGenericDefault';

  function GdipStrFormatGetGenericTypographic(
    out format: TGpStrFormat): TGpStatus; stdcall; external gdiplus name 'GdipStringFormatGetGenericTypographic';

  function GdipDeleteStrFormat(format: TGpStrFormat): TGpStatus; stdcall; external gdiplus name 'GdipDeleteStringFormat';

  function GdipCloneStrFormat(format: TGpStrFormat;
    out newFormat: TGpStrFormat): TGpStatus; stdcall; external gdiplus name 'GdipCloneStringFormat';

  function GdipSetStrFormatFlags(format: TGpStrFormat;
    flags: Integer): TGpStatus; stdcall; external gdiplus name 'GdipSetStringFormatFlags';

  function GdipGetStrFormatFlags(format: TGpStrFormat;
    out flags: Integer): TGpStatus; stdcall; external gdiplus name 'GdipGetStringFormatFlags';

  function GdipSetStrFormatAlign(format: TGpStrFormat;
    align: TGPStrAlignment): TGpStatus; stdcall; external gdiplus name 'GdipSetStringFormatAlign';

  function GdipGetStrFormatAlign(format: TGpStrFormat;
    out align: TGPStrAlignment): TGpStatus; stdcall; external gdiplus name 'GdipGetStringFormatAlign';

  function GdipSetStrFormatLineAlign(format: TGpStrFormat;
    align: TGPStrAlignment): TGpStatus; stdcall; external gdiplus name 'GdipSetStringFormatLineAlign';

  function GdipGetStrFormatLineAlign(format: TGpStrFormat;
    out align: TGPStrAlignment): TGpStatus; stdcall; external gdiplus name 'GdipGetStringFormatLineAlign';

  function GdipSetStrFormatTrimming(format: TGpStrFormat;
    trimming: TGPStrTrimming): TGpStatus; stdcall; external gdiplus name 'GdipSetStringFormatTrimming';

  function GdipGetStrFormatTrimming(format: TGpStrFormat;
    out trimming: TGPStrTrimming): TGpStatus; stdcall; external gdiplus name 'GdipGetStringFormatTrimming';

  function GdipSetStrFormatHotkeyPrefix(format: TGpStrFormat;
    hotkeyPrefix: Integer): TGpStatus; stdcall; external gdiplus name 'GdipSetStringFormatHotkeyPrefix';

  function GdipGetStrFormatHotkeyPrefix(format: TGpStrFormat;
    out hotkeyPrefix: Integer): TGpStatus; stdcall; external gdiplus name 'GdipGetStringFormatHotkeyPrefix';

  function GdipSetStrFormatTabStops(format: TGpStrFormat;
    firstTabOffset: Single; count: Integer;
    tabStops: PSingle): TGpStatus; stdcall; external gdiplus name 'GdipSetStringFormatTabStops';

  function GdipGetStrFormatTabStops(format: TGpStrFormat;
    count: Integer; firstTabOffset: PSingle;
    tabStops: PSingle): TGpStatus; stdcall; external gdiplus name 'GdipGetStringFormatTabStops';

  function GdipGetStrFormatTabStopCount(format: TGpStrFormat;
    out count: Integer): TGpStatus; stdcall; external gdiplus name 'GdipGetStringFormatTabStopCount';

  function GdipSetStrFormatDigitSubstitution(format: TGpStrFormat;
    language: LANGID;
    substitute: TGPStrDigitSubstitute): TGpStatus; stdcall; external gdiplus name 'GdipSetStringFormatDigitSubstitution';

  function GdipGetStrFormatDigitSubstitution(format: TGpStrFormat;
    language: PUINT; substitute: PGPStrDigitSubstitute): TGpStatus; stdcall; external gdiplus name 'GdipGetStringFormatDigitSubstitution';

  function GdipGetStrFormatMeasurableCharacterRangeCount(format: TGpStrFormat;
    out count: Integer): TGpStatus; stdcall; external gdiplus name 'GdipGetStringFormatMeasurableCharacterRangeCount';

  function GdipSetStrFormatMeasurableCharacterRanges(format: TGpStrFormat; rangeCount: Integer;
    ranges: PGPCharacterRange): TGpStatus; stdcall; external gdiplus name 'GdipSetStringFormatMeasurableCharacterRanges';

implementation

end.
