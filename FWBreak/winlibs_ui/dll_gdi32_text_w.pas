{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_gdi32_text_w;

interface 
                          
uses
  atmcmbaseconst, winconst, wintype, wintypeW;

type
  PTextMetricW = ^TTextMetricW;              
  TTextMetricW = record
    tmHeight: Longint;
    tmAscent: Longint;
    tmDescent: Longint;
    tmInternalLeading: Longint;
    tmExternalLeading: Longint;
    tmAveCharWidth: Longint;
    tmMaxCharWidth: Longint;
    tmWeight: Longint;
    tmOverhang: Longint;
    tmDigitizedAspectX: Longint;
    tmDigitizedAspectY: Longint;
    tmFirstChar: WideChar;
    tmLastChar: WideChar;
    tmDefaultChar: WideChar;
    tmBreakChar: WideChar;
    tmItalic: Byte;
    tmUnderlined: Byte;
    tmStruckOut: Byte;
    tmPitchAndFamily: Byte;
    tmCharSet: Byte;
  end;
  
  function TextOutW(ADC: HDC; X, Y: Integer; Str: PWideChar; Count: Integer): BOOL; stdcall; external gdi32 name 'TextOutW';
  function ExtTextOutW(ADC: HDC; X, Y: Integer; Options: Longint;
    Rect: PRect; Str: PWideChar; Count: Longint; Dx: PInteger): BOOL; stdcall; external gdi32 name 'ExtTextOutW';

  function PolyTextOutW(ADC: HDC; const PolyTextArray; Strings: Integer): BOOL; stdcall; external gdi32 name 'PolyTextOutW';

  function EnumFontFamiliesExW(ADC: HDC; var p2: TLogFontW;
    p3: TFNFontEnumProc; p4: LPARAM; p5: DWORD): BOOL; stdcall; external gdi32 name 'EnumFontFamiliesExW';

  function GetTextExtentPoint32W(ADC: HDC; Str: PWideChar; Count: Integer;
      var Size: TSize): BOOL; stdcall; external gdi32 name 'GetTextExtentPoint32W';
  function GetTextExtentPointW(ADC: HDC; Str: PWideChar; Count: Integer;
      var Size: TSize): BOOL; stdcall; external gdi32 name 'GetTextExtentPointW';
  function GetTextFaceW(ADC: HDC; Count: Integer; Buffer: PWideChar): Integer; stdcall; external gdi32 name 'GetTextFaceW';
  function GetTextMetricsW(ADC: HDC; var TM: TTextMetricW): BOOL; stdcall; external gdi32 name 'GetTextMetricsW';

  function CreateFontW(nHeight, nWidth, nEscapement, nOrientaion, fnWeight: Integer;
      fdwItalic, fdwUnderline, fdwStrikeOut, fdwCharSet, fdwOutputPrecision,
      fdwClipPrecision, fdwQuality, fdwPitchAndFamily: DWORD; lpszFace: PWideChar): HFONT; stdcall; external gdi32 name 'CreateFontW';
  function CreateFontIndirectW(const p1: TLogFontW): HFONT; stdcall; external gdi32 name 'CreateFontIndirectW';
//  function CreateFontIndirectExW(const p1: PEnumLogFontExDV): HFONT; stdcall; external gdi32 name 'CreateFontIndirectExW';

implementation

end.
