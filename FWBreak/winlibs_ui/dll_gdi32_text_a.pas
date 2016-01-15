{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdi32_text_a;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype, wintypeA;

type                
  PTextMetricA        = ^TTextMetricA;
  PTextMetric         = PTextMetricA;
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
                                 
  function TextOut(DC: HDC; X, Y: Integer; Str: PAnsiChar; Count: Integer): BOOL; stdcall; external gdi32 name 'TextOutA';
  function ExtTextOut(DC: HDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: PAnsiChar;
    Count: Longint; Dx: PInteger): BOOL; stdcall; external gdi32 name 'ExtTextOutA';

  function PolyTextOut(DC: HDC; const PolyTextArray; Strings: Integer): BOOL; stdcall; external gdi32 name 'PolyTextOutA';
  
  function EnumFontFamiliesEx(DC: HDC; var p2: TLogFontA;
    p3: TFNFontEnumProc; p4: LPARAM; p5: DWORD): BOOL; stdcall; external gdi32 name 'EnumFontFamiliesExA';

  function GetTextExtentPoint32(DC: HDC; Str: PAnsiChar; Count: Integer;
      var Size: TSize): BOOL; stdcall; external gdi32 name 'GetTextExtentPoint32A';
  function GetTextExtentPoint(DC: HDC; Str: PAnsiChar; Count: Integer;
      var Size: TSize): BOOL; stdcall; external gdi32 name 'GetTextExtentPointA';
  function GetTextFace(DC: HDC; Count: Integer; Buffer: PAnsiChar): Integer; stdcall; external gdi32 name 'GetTextFaceA';
  function GetTextMetrics(DC: HDC; var TM: TTextMetricA): BOOL; stdcall; external gdi32 name 'GetTextMetricsA';

type
  PLogFontA         = ^TLogFontA;
  PLogFont          = PLogFontA;
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

  function CreateFont(nHeight, nWidth, nEscapement, nOrientaion, fnWeight: Integer;
      fdwItalic, fdwUnderline, fdwStrikeOut, fdwCharSet, fdwOutputPrecision,
      fdwClipPrecision, fdwQuality, fdwPitchAndFamily: DWORD; lpszFace: PAnsiChar): HFONT; stdcall; external gdi32 name 'CreateFontA';
  function CreateFontIndirect(const p1: TLogFontA): HFONT; stdcall; external gdi32 name 'CreateFontIndirectA';
//  function CreateFontIndirectEx(const p1: PEnumLogFontExDV): HFONT; stdcall; external gdi32 name 'CreateFontIndirectExA';

implementation

end.
