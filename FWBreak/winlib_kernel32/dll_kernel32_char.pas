{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_kernel32_char;

interface 
              
uses
  atmcmbaseconst, winconst, wintype;
  
const
{ Str Length Maximums. }
  MAX_LEADBYTES     = 12; { 5 ranges, 2 bytes ea., 0 term. }
  MAX_DEFAULTCHAR   = 2; { single or double byte }

type
  PCPInfo           = ^TCPInfo;
  TCPInfo           = record
    MaxCharSize     : UINT;                       { max length (bytes) of a char }
    DefaultChar     : array[0..MAX_DEFAULTCHAR - 1] of Byte; { default character }
    LeadByte        : array[0..MAX_LEADBYTES - 1] of Byte;      { lead byte ranges }
  end;
                    
  PNumberFmtA       = ^TNumberFmtA;
  PNumberFmt        = PNumberFmtA;
  TNumberFmtA       = packed record
    NumDigits       : UINT;        { number of decimal digits }
    LeadingZero     : UINT;      { if leading zero in decimal fields }
    Grouping        : UINT;         { group size left of decimal }
    lpDecimalSep    : PAnsiChar;   { ptr to decimal separator AnsiStr }
    lpThousandSep   : PAnsiChar;  { ptr to thousand separator AnsiStr }
    NegativeOrder   : UINT;    { negative number ordering }
  end;
  TNumberFmt = TNumberFmtA;
                         
  PCurrencyFmtA = ^TCurrencyFmtA;
  PCurrencyFmt = PCurrencyFmtA;
  TCurrencyFmtA = packed record
    NumDigits: UINT;           { number of decimal digits }
    LeadingZero: UINT;         { if leading zero in decimal fields }
    Grouping: UINT;            { group size left of decimal }
    lpDecimalSep: PAnsiChar;      { ptr to decimal separator AnsiStr }
    lpThousandSep: PAnsiChar;     { ptr to thousand separator AnsiStr }
    NegativeOrder: UINT;       { negative currency ordering }
    PositiveOrder: UINT;       { positive currency ordering }
    lpCurrencySymbol: PAnsiChar;  { ptr to currency symbol AnsiStr }
  end;             
  TCurrencyFmt = TCurrencyFmtA;
  
{ Code Page Dependent APIs. }
  function IsValidCodePage(CodePage: UINT): BOOL; stdcall; external kernel32 name 'IsValidCodePage';
  function GetACP: UINT; stdcall; external kernel32 name 'GetACP';
  function GetOEMCP: UINT; stdcall; external kernel32 name 'GetOEMCP';
  function GetCPInfo(CodePage: UINT; var lpCPInfo: TCPInfo): BOOL; stdcall; external kernel32 name 'GetCPInfo';
  
  function IsDBCSLeadByte(TestChar: Byte): BOOL; stdcall; external kernel32 name 'IsDBCSLeadByte';
  function IsDBCSLeadByteEx(CodePage: UINT; TestChar: Byte): BOOL; stdcall; external kernel32 name 'IsDBCSLeadByteEx';

(*
  codepage := CP_UTF8;
  codepage := CP_ACP;
  ulen := WideCharToMultiByte(codepage, 0, @wch.Data[0], wch.len, nil, 0, nil, nil);
  WideCharToMultiByte(codepage, 0,
    @wch.Data[0], wch.len,
    @ach.Data[0], ulen, NIL, NIL);
  ------------------------------------------
  codepage := CP_ACP;
  wlen := MultiByteToWideChar(codepage, 0, @ach.Data[0], ach.Len, nil, 0); // wlen is the number of UCS2 without NULL terminater.
  if wlen = 0 then exit;
  MultiByteToWideChar(codepage, 0, @ach.Data[0], ach.Len, @wch.Data[0], wlen);
*)
  // CP_UTF7
  // winconst_char.pas
  //   CodePage：指定执行转换的代码页，这个参数可以为系统已安装或有效的任何代码页所给定的值。你也可以指定其为下面的任意一值：
  //       CP_ACP：ANSI代码页；
  //       CP_MACCP：Macintosh代码页；
  //       CP_OEMCP：OEM代码页；
  //　     CP_SYMBOL：符号代码页（42）；
  //       CP_THREAD_ACP：当前线程ANSI代码页；
  //　     CP_UTF7：使用UTF-7转换；
  //       CP_UTF8：使用UTF-8转换
  //dwFlags：一组位标记用以指出是否未转换成预作或宽字符（若组合形式存在），
  //    是否使用象形文字替代控制字符，以及如何处理无效字符。你可以指定下面是标记常量的组合，含义如下：
  //    MB_PRECOMPOSED：通常使用预作字符——就是说，由一个基本字符和一个非空字符组成的字符只有一个单一的字符值。这是缺省的转换选择。不能与
  //    MB_COMPOSITE值一起使用。
  //    MB_COMPOSITE：通常使用组合字符——就是说，由一个基本字符和一个非空字符组成的字符分别有不同的字符值。不能与MB_PRECOMPOSED值一起使用。
  //    MB_ERR_INVALID_CHARS：如果函数遇到无效的输入字符，它将运行失败，且GetLastErro返回ERROR_NO_UNICODE_TRANSLATION值。
  //    MB_USEGLYPHCHARS：使用象形文字替代控制字符。
  function MultiByteToWideChar(CodePage: UINT; dwFlags: DWORD;
    const lpMultiByteStr: LPCSTR; cchMultiByte: Integer;
    lpWideCharStr: LPWSTR; cchWideChar: Integer): Integer; stdcall; external kernel32 name 'MultiByteToWideChar';
  function WideCharToMultiByte(CodePage: UINT; dwFlags: DWORD;
    lpWideCharStr: LPWSTR; cchWideChar: Integer; lpMultiByteStr: LPSTR;
    cchMultiByte: Integer; lpDefaultChar: LPCSTR; lpUsedDefaultChar: PBOOL): Integer; stdcall; external kernel32 name 'WideCharToMultiByte';
    
{ Locale Dependent APIs. }
const          
  CSTR_LESS_THAN           = 1;             { str 1 less than str 2 }
  CSTR_EQUAL               = 2;             { str 1 equal to str 2 }
  CSTR_GREATER_THAN        = 3;             { str 1 greater than str 2 }

  function CompareStrA(Locale: LCID; dwCmpFlags: DWORD; lpStr1: PAnsiChar;
    cchCount1: Integer; lpStr2: PAnsiChar; cchCount2: Integer): Integer; stdcall; external kernel32 name 'CompareStringA';
  function LCMapStrA(Locale: LCID; dwMapFlags: DWORD; lpSrcStr: PAnsiChar;
    cchSrc: Integer; lpDestStr: PAnsiChar; cchDest: Integer): Integer; stdcall; external kernel32 name 'LCMapStringA';
  function GetTimeFormatA(Locale: LCID; dwFlags: DWORD; lpTime: PSystemTime;
    lpFormat: PAnsiChar; lpTimeStr: PAnsiChar; cchTime: Integer): Integer; stdcall; external kernel32 name 'GetTimeFormatA';
  function GetDateFormatA(Locale: LCID; dwFlags: DWORD; lpDate: PSystemTime;
    lpFormat: PAnsiChar; lpDateStr: PAnsiChar; cchDate: Integer): Integer; stdcall; external kernel32 name 'GetDateFormatA';
  function GetNumberFormatA(Locale: LCID; dwFlags: DWORD; lpValue: PAnsiChar;
    lpFormat: PNumberFmt; lpNumberStr: PAnsiChar; cchNumber: Integer): Integer; stdcall; external kernel32 name 'GetNumberFormatA';
  function GetCurrencyFormatA(Locale: LCID; dwFlags: DWORD; lpValue: PAnsiChar;
    lpFormat: PCurrencyFmt; lpCurrencyStr: PAnsiChar; cchCurrency: Integer): Integer; stdcall; external kernel32 name 'GetCurrencyFormatA';
//  function EnumCalendarInfo(lpCalInfoEnumProc: TFNCalInfoEnumProc; Locale: LCID;
//    Calendar: CALID; CalType: CALTYPE): BOOL; stdcall;
  function GetStrTypeExA(Locale: LCID; dwInfoType: DWORD; lpSrcStr: PAnsiChar;
    cchSrc: Integer; var lpCharType): BOOL; stdcall; external kernel32 name 'GetStringTypeExA';

  function GetStrTypeA(Locale: LCID; dwInfoType: DWORD; const lpSrcStr: LPCSTR;
    cchSrc: BOOL; var ACharType: Word): BOOL; stdcall; external kernel32 name 'GetStringTypeA';
  function FoldStrA(dwMapFlags: DWORD; lpSrcStr: PAnsiChar; cchSrc: Integer;
    lpDestStr: PAnsiChar; cchDest: Integer): Integer; stdcall; external kernel32 name 'FoldStringA';
  { LPWSTR pMessage = L"%1!*.*s! %3 %4!*s!";
    FormatMessage(FORMAT_MESSAGE_FROM_STR |
                  FORMAT_MESSAGE_ALLOCATE_BUFFER,
                  pMessage, 
                  0,
                  0,
                  (LPWSTR)&pBuffer, 
                  0, 
                  &args); }
  function FormatMessageA(dwFlags: DWORD; lpSource: Pointer; dwMessageId: DWORD; dwLanguageId: DWORD;
    lpBuffer: PAnsiChar; nSize: DWORD; Arguments: Pointer): DWORD; stdcall; external kernel32 name 'FormatMessageA';

type
  TwDLLKernel_Char  = record
    IsValidCodePage : function (CodePage: UINT): BOOL; stdcall;
    GetACP          : function : UINT; stdcall;
    GetOEMCP        : function : UINT; stdcall;
    GetCPInfo       : function (CodePage: UINT; var lpCPInfo: TCPInfo): BOOL; stdcall;

    IsDBCSLeadByte  : function (TestChar: Byte): BOOL; stdcall;
    IsDBCSLeadByteEx: function (CodePage: UINT; TestChar: Byte): BOOL; stdcall;
    MultiByteToWideChar: function (CodePage: UINT; dwFlags: DWORD; const lpMultiByteStr: LPCSTR;
        cchMultiByte: Integer; lpWideCharStr: LPWSTR; cchWideChar: Integer): Integer; stdcall;
    WideCharToMultiByte: function (CodePage: UINT; dwFlags: DWORD; lpWideCharStr: LPWSTR;
        cchWideChar: Integer; lpMultiByteStr: LPSTR; cchMultiByte: Integer; lpDefaultChar: LPCSTR;
        lpUsedDefaultChar: PBOOL): Integer; stdcall;
    CompareStr      : function (Locale: LCID; dwCmpFlags: DWORD; lpStr1: PAnsiChar; cchCount1: Integer;
        lpStr2: PAnsiChar; cchCount2: Integer): Integer; stdcall;
    LCMapStr        : function (Locale: LCID; dwMapFlags: DWORD; lpSrcStr: PAnsiChar;
        cchSrc: Integer; lpDestStr: PAnsiChar; cchDest: Integer): Integer; stdcall;
    GetTimeFormat   : function (Locale: LCID; dwFlags: DWORD; lpTime: PSystemTime;
        lpFormat: PAnsiChar; lpTimeStr: PAnsiChar; cchTime: Integer): Integer; stdcall;
    GetDateFormat   : function (Locale: LCID; dwFlags: DWORD; lpDate: PSystemTime;
        lpFormat: PAnsiChar; lpDateStr: PAnsiChar; cchDate: Integer): Integer; stdcall;
    GetNumberFormat : function (Locale: LCID; dwFlags: DWORD; lpValue: PAnsiChar;
        lpFormat: PNumberFmt; lpNumberStr: PAnsiChar; cchNumber: Integer): Integer; stdcall;
    GetCurrencyFormat: function (Locale: LCID; dwFlags: DWORD; lpValue: PAnsiChar;
        lpFormat: PCurrencyFmt; lpCurrencyStr: PAnsiChar; cchCurrency: Integer): Integer; stdcall;
  //  EnumCalendarInfo: function (lpCalInfoEnumProc: TFNCalInfoEnumProc; Locale: LCID;
  //    Calendar: CALID; CalType: CALTYPE): BOOL; stdcall;
    GetStrTypeEx    : function (Locale: LCID; dwInfoType: DWORD; lpSrcStr: PAnsiChar;
        cchSrc: Integer; var lpCharType): BOOL; stdcall;
    GetStrTypeA     : function (Locale: LCID; dwInfoType: DWORD; const lpSrcStr: LPCSTR;
        cchSrc: BOOL; var ACharType: Word): BOOL; stdcall;
    FoldStr         : function (dwMapFlags: DWORD; lpSrcStr: PAnsiChar; cchSrc: Integer;
        lpDestStr: PAnsiChar; cchDest: Integer): Integer; stdcall;
    FormatMessage   : function (dwFlags: DWORD; lpSource: Pointer; dwMessageId: DWORD;
        dwLanguageId: DWORD; lpBuffer: PAnsiChar; nSize: DWORD; Arguments: Pointer): DWORD; stdcall;
  end;
  
implementation

end.
