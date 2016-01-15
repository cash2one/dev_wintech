{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdi32_text;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype;

type                      
  PFontSignature      = ^TFontSignature;
  TFontSignature    = packed record
    fsUsb             : array[0..3] of DWORD;
    fsCsb             : array[0..1] of DWORD;
  end;
                           
  PTextMetricA        = ^TTextMetricA;
  TTextMetricA        = record
    tmHeight          : Longint;
    tmAscent          : Longint;
    tmDescent         : Longint;
    tmInternalLeading : Longint;
    tmExternalLeading : Longint;
    tmAveCharWidth    : Longint;
    tmMaxCharWidth    : Longint;
    tmWeight          : Longint;
    tmOverhang        : Longint;
    tmDigitizedAspectX: Longint;
    tmDigitizedAspectY: Longint;
    tmFirstChar       : AnsiChar;
    tmLastChar        : AnsiChar;
    tmDefaultChar     : AnsiChar;
    tmBreakChar       : AnsiChar;
    tmItalic          : Byte;
    tmUnderlined      : Byte;
    tmStruckOut       : Byte;
    tmPitchAndFamily  : Byte;
    tmCharSet         : Byte;
  end;                                           
                                                      
  function SetTextColor(ADC: HDC; AColor: COLORREF): COLORREF; stdcall; external gdi32 name 'SetTextColor';

  function TextOutA(ADC: HDC; X, Y: Integer; AStr: PAnsiChar; Count: Integer): BOOL; stdcall; external gdi32 name 'TextOutA';

  (*
  DrawText, TextOut内部也是也是通过调用ExtTextOut来实现的， ExtTextOut里ETO_GLYPH_INDEX的情况
  貌似只有通过Hook GetCharacterPlacement 来做了，
  看别人也有同样的问题http://www.ms-news.net/f3599/exttextout-eto_glyph_index-2056428.html

  用GDI32!ExtTextOutW画的，但它用了ETO_GLYPH_INDEX标志，传入的不是文字字符串，而是Glyph indexing of TrueType fonts

  从文字转到Graph Index可以用API GetCharacterPlacement 或 GetGlyphIndices， 但是转回去好像没有对应的API


  EllipsisSingle := '你';
//  EllipsisSingle := 'A';
//  GetGlyphIndicesW(Canvas.Handle, @EllipsisSingle, 1, @GlyphIndex, GS_8BIT_INDICES);
  GetGlyphIndicesW(Canvas.Handle, @EllipsisSingle, 1, @GlyphIndex, GGI_MARK_NONEXISTING_GLYPHS);
  if GlyphIndex = $FFFF then
  else
    ExtTextOutW(Canvas.Handle, 10, 30, ETO_GLYPH_INDEX, nil, @GlyphIndex, 1, nil);
  *)
  function ExtTextOutA(ADC: HDC; X, Y: Integer; AOptions: Longint; Rect: PRect; Str: PAnsiChar;
    Count: Longint; Dx: PInteger): BOOL; stdcall; external gdi32 name 'ExtTextOutA';
  function ExtTextOutW(ADC: HDC; X, Y: Integer; AOptions: Longint;
    Rect: PRect; Str: PWideChar; ACount: Longint; Dx: PInteger): BOOL; stdcall; external gdi32 name 'ExtTextOutW';

  function PolyTextOutA(ADC: HDC; const PolyTextArray; Strings: Integer): BOOL; stdcall; external gdi32 name 'PolyTextOutA';

  function EnumFontFamiliesExA(ADC: HDC; var p2: TLogFontA;
    p3: TFNFontEnumProc; p4: LPARAM; p5: DWORD): BOOL; stdcall; external gdi32 name 'EnumFontFamiliesExA';

  function GetTextAlign(ADC: HDC): UINT; stdcall; external gdi32 name 'GetTextAlign';
  function GetTextCharacterExtra(ADC: HDC): Integer; stdcall; external gdi32 name 'GetTextCharacterExtra';
  function GetTextCharset(Adc: HDC): Integer; stdcall; external gdi32 name 'GetTextCharset';
  function GetTextCharsetInfo(hdc: HDC; lpSig: PFontSignature; dwFlags: DWORD): BOOL; stdcall; external gdi32 name 'GetTextCharsetInfo';
  function GetTextColor(ADC: HDC): COLORREF; stdcall; external gdi32 name 'GetTextColor';
  function GetTextExtentPoint32A(DC: HDC; Str: PAnsiChar; Count: Integer;
      var Size: TSize): BOOL; stdcall; external gdi32 name 'GetTextExtentPoint32A';
  function GetTextExtentPointA(ADC: HDC; Str: PAnsiChar; Count: Integer;
      var Size: TSize): BOOL; stdcall; external gdi32 name 'GetTextExtentPointA';
  function GetTextFaceA(ADC: HDC; Count: Integer; Buffer: PAnsiChar): Integer; stdcall; external gdi32 name 'GetTextFaceA';
  function GetTextMetricsA(ADC: HDC; var TM: TTextMetricA): BOOL; stdcall; external gdi32 name 'GetTextMetricsA';

type
  PLogFontA         = ^TLogFontA;
  TLogFontA         = packed record
    lfHeight        : Longint;
    lfWidth         : Longint;
    lfEscapement    : Longint; // 旋转角度 输出方向与当前坐标系 X 轴之间的以十分之一度为单位的角度
    lfOrientation   : Longint; // 指定每个字符与当前坐标系 X 轴之间的以十分之一度为单位的角度
    lfWeight        : Longint; // 从 0 至 1000 的字体加重程度 ,400 是标准字体 700 为加重字体 ,0 表示采用默认值
    lfItalic        : Byte;
    lfUnderline     : Byte;
    lfStrikeOut     : Byte;
    lfCharSet       : Byte;
    lfOutPrecision  : Byte;    // 输出精度。用于确定对前面一些设定值的精确程度
    lfClipPrecision : Byte;    // 裁剪精度。裁剪是 Windows 图形环境下的一种特殊处理 ,简单说就是去掉图形中落在视
                               // 图以外的部分 ,有助于提高图形的处理速度
    lfQuality       : Byte;    // 输出质量
    lfPitchAndFamily: Byte;
    lfFaceName      : array[0..LF_FACESIZE - 1] of AnsiChar;
  end;

const
  { Font Weights }
  FW_DONTCARE = 0;
  FW_THIN = 100;
  FW_EXTRALIGHT = 200;
  FW_LIGHT = 300;
  FW_NORMAL = 400;
  FW_MEDIUM = 500;
  FW_SEMIBOLD = 600;
  FW_BOLD = 700;
  FW_EXTRABOLD = 800;
  FW_HEAVY = 900;
  FW_ULTRALIGHT = FW_EXTRALIGHT;
  FW_REGULAR = FW_NORMAL;
  FW_DEMIBOLD = FW_SEMIBOLD;
  FW_ULTRABOLD = FW_EXTRABOLD;
  FW_BLACK = FW_HEAVY;

  DEFAULT_QUALITY     = 0;
  DRAFT_QUALITY       = 1;
  PROOF_QUALITY       = 2;
  NONANTIALIASED_QUALITY = 3;
  ANTIALIASED_QUALITY = 4;
  CLEARTYPE_QUALITY = 5;
  CLEARTYPE_NATURAL_QUALITY = 6;


  OUT_DEFAULT_PRECIS  = 0;
  OUT_STRING_PRECIS   = 1;
  OUT_CHARACTER_PRECIS = 2;
  OUT_STROKE_PRECIS   = 3;
  OUT_TT_PRECIS       = 4;
  OUT_DEVICE_PRECIS   = 5;
  OUT_RASTER_PRECIS   = 6;
  OUT_TT_ONLY_PRECIS  = 7;
  OUT_OUTLINE_PRECIS  = 8;
  OUT_SCREEN_OUTLINE_PRECIS = 9;

  CLIP_DEFAULT_PRECIS = 0;
  CLIP_CHARACTER_PRECIS = 1;
  CLIP_STROKE_PRECIS  = 2;
  CLIP_MASK           = 15;
  CLIP_LH_ANGLES      = (1 shl 4);
  CLIP_TT_ALWAYS      = (2 shl 4);
  CLIP_EMBEDDED       = (8 shl 4);

  DEFAULT_PITCH       = 0;
  FIXED_PITCH         = 1;
  VARIABLE_PITCH      = 2;
  MONO_FONT           = 8;

  ETO_OPAQUE          = 2;
  ETO_CLIPPED         = 4;
  ETO_GLYPH_INDEX     = $10;
  ETO_RTLREADING      = $80;
  ETO_NUMERICSLOCAL   = $400;
  ETO_NUMERICSLATIN   = $800;
  ETO_IGNORELANGUAGE  = $1000;
  ETO_PDY             = $2000;

  function CreateFont(nHeight, nWidth, nEscapement, nOrientaion, fnWeight: Integer;
      fdwItalic, fdwUnderline, fdwStrikeOut, fdwCharSet, fdwOutputPrecision,
      fdwClipPrecision, fdwQuality, fdwPitchAndFamily: DWORD; lpszFace: PAnsiChar): HFONT; stdcall; external gdi32 name 'CreateFontA';
  function CreateFontIndirectA(const p1: TLogFontA): HFONT; stdcall; external gdi32 name 'CreateFontIndirectA';
//  function CreateFontIndirectEx(const p1: PEnumLogFontExDV): HFONT; stdcall; external gdi32 name 'CreateFontIndirectExA';

  function GetCharWidth32A(ADC: HDC; FirstChar, LastChar: UINT; const Widths): BOOL; stdcall; external gdi32 name 'GetCharWidth32A';


const
  { flAccel flags for the TGlyphSet structure above }
  {$EXTERNALSYM GS_8BIT_INDICES}
  GS_8BIT_INDICES = 1;
  { flags for GetGlyphIndices }
  GGI_MARK_NONEXISTING_GLYPHS = 1;

  // 获取字模索引 原生实现 TextOut
  function GetGlyphIndicesA(ADC: HDC; p2: PAnsiChar; p3: Integer; p4: PWORD; p5: DWORD): DWORD; stdcall;
      external gdi32 name 'GetGlyphIndicesA';
  function GetGlyphIndicesW(ADC: HDC; p2: PWideChar; p3: Integer; p4: PWORD; p5: DWORD): DWORD; stdcall;
      external gdi32 name 'GetGlyphIndicesW';

type
  PGlyphMetrics = ^TGlyphMetrics;
  TGlyphMetrics = packed record
    gmBlackBoxX: UINT;
    gmBlackBoxY: UINT;
    gmptGlyphOrigin: TPoint;
    gmCellIncX: SHORT;
    gmCellIncY: SHORT;
  end;
  (*
  PFixed  = ^TFixed;
  TFixed  = packed record
    fract: Word;
    value: SHORT;
  end;
  *)
  // This type has data bits arrangement compatible wth Windows.TFixed
  PFixed = ^TFixed;
  TFixed = type Integer;

  PFixedRec = ^TFixedRec;
  TFixedRec = packed record
    case Integer of
      0: (Fixed: TFixed);
      1: (Frac: Word; Int: SmallInt);
  end;
  
  PMat2 = ^TMat2;
  TMat2 = packed record
    eM11: TFixed;
    eM12: TFixed;
    eM21: TFixed;
    eM22: TFixed;
  end;

  // GetGlyphOutLine可以获取一系列TTF存放的点的信息，然后可以用不同的连接方法连接各个点，就是一个字了
  // 取回轮廓数据
  function GetGlyphOutlineA(ADC: HDC; uChar, uFormat: UINT; const lpgm: TGlyphMetrics;
      cbBuffer: DWORD; lpvBuffer: Pointer; const lpmat2: TMat2): DWORD; stdcall; external gdi32 name 'GetGlyphOutlineA';
  function GetGlyphOutlineW(ADC: HDC; uChar, uFormat: UINT; const lpgm: TGlyphMetrics;
      cbBuffer: DWORD; lpvBuffer: Pointer; const lpmat2: TMat2): DWORD; stdcall; external gdi32 name 'GetGlyphOutlineW';

type
  PWCRange = ^TWCRange;
  TWCRange = packed record
    wcLow: WCHAR;
    cGlyphs: SHORT;
  end;

  PGlyphSet = ^TGlyphSet;
  TGlyphSet = packed record
    cbThis: DWORD;
    flAccel: DWORD;
    cGlyphsSupported: DWORD;
    cRanges: DWORD;
    ranges: array[0..0] of TWCRange;
  end;
  // 获得TrueType字体文件 的相关信息
  function GetFontUnicodeRanges(ADC: HDC; lpgs: PGlyphSet): DWORD; stdcall; external gdi32 name 'GetFontUnicodeRanges';

type
  PGCPResultsA = ^TGCPResultsA;
  TGCPResultsA = record
    lStructSize: DWORD;
    lpOutString: PAnsiChar;
    lpOrder: PUINT;
    lpDx: PINT;
    lpCaretPos: PINT;
    lpClass: PAnsiChar;
    lpGlyphs: PUINT;
    nGlyphs: UINT;
    nMaxFit: Integer;
  end;

  PGCPResultsW = ^TGCPResultsW;
  TGCPResultsW = record
    lStructSize: DWORD;
    lpOutString: PWideChar;
    lpOrder: PUINT;
    lpDx: PINT;
    lpCaretPos: PINT;
    lpClass: PAnsiChar;
    lpGlyphs: PUINT;
    nGlyphs: UINT;
    nMaxFit: Integer;
  end;

  function GetCharacterPlacementA(ADC: HDC; p2: PAnsiChar; p3, p4: Integer;
      var p5: TGCPResultsA; p6: DWORD): DWORD; stdcall; external gdi32 name 'GetCharacterPlacementA';
  function GetCharacterPlacementW(ADC: HDC; p2: PWideChar; p3, p4: Integer;
      var p5: TGCPResultsW; p6: DWORD): DWORD; stdcall; external gdi32 name 'GetCharacterPlacementW';

implementation

end.
