{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_char_w;

interface

uses
  atmcmbaseconst, winconst, wintype;


  function CharToOemW(lpszSrc: PWideChar; lpszDst: PWideChar): BOOL; stdcall; external user32 name 'CharToOemW';
  function AnsiToOemW(const lpszSrc: LPCSTR; lpszDst: LPSTR): BOOL; stdcall; external user32 name 'CharToOemW';
  function CharToOemBuffW(lpszSrc: PWideChar; lpszDst: PWideChar; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'CharToOemBuffW';
  function AnsiToOemBuffW(lpszSrc: LPCSTR; lpszDst: LPSTR; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'CharToOemBuffW';

  function CharUpperW(lpsz: PWideChar): PWideChar; stdcall; external user32 name 'CharUpperW';
  function AnsiUpperW(lpsz: LPSTR): LPSTR; stdcall; external user32 name 'CharUpperW';
  function CharUpperBuffW(lpsz: PWideChar; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharUpperBuffW';
  function AnsiUpperBuffW(lpsz: LPSTR; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharUpperBuffW';

  function CharLowerW(lpsz: PWideChar): PWideChar; stdcall; external user32 name 'CharLowerW';
  function AnsiLowerW(lpsz: LPSTR): LPSTR; stdcall; external user32 name 'CharLowerW';
  function CharLowerBuffW(lpsz: PWideChar; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharLowerBuffW';
  function AnsiLowerBuffW(lpsz: LPSTR; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharLowerBuffW';

  function CharNextW(lpsz: PWideChar): PWideChar; stdcall; external user32 name 'CharNextW';
  function CharPrevW(lpszStart: PWideChar; lpszCurrent: PWideChar): PWideChar; stdcall; external user32 name 'CharPrevW';
  function AnsiNextW(const lpsz: LPCSTR): LPSTR; stdcall; external user32 name 'CharNextW';
  function AnsiPrevW(const lpszStart: LPCSTR; const lpszCurrent: LPCSTR): LPSTR; stdcall; external user32 name 'CharPrevW';
  function CharNextExW(CodePage: Word; lpCurrentChar: LPCSTR; dwFlags: DWORD): LPSTR; stdcall; external user32 name 'CharNextExW';
  function CharPrevExW(CodePage: Word; lpStart, lpCurrentChar: LPCSTR; dwFlags: DWORD): LPSTR; stdcall; external user32 name 'CharPrevExW';
  function IsCharAlphaW(ch: WideChar): BOOL; stdcall; external user32 name 'IsCharAlphaW';
  function IsCharAlphaNumericW(ch: WideChar): BOOL; stdcall; external user32 name 'IsCharAlphaNumericW';

  function IsCharUpperW(ch: WideChar): BOOL; stdcall; external user32 name 'IsCharUpperW';
  function IsCharLowerW(ch: WideChar): BOOL; stdcall; external user32 name 'IsCharLowerW';

  function LoadKeyboardLayoutW(pwszKLID: PWideChar; Flags: UINT): HKL; stdcall; external user32 name 'LoadKeyboardLayoutW';
  function GetKeyboardLayoutNameW(pwszKLID: PWideChar): BOOL; stdcall; external user32 name 'GetKeyboardLayoutNameW';
  function GetKeyNameTextW(lParam: Longint; lpString: PWideChar; nSize: Integer): Integer; stdcall; external user32 name 'GetKeyNameTextW';

  function OemToAnsiW(const lpszSrc: LPCSTR; lpszDst: LPSTR): BOOL; stdcall; external user32 name 'OemToCharW';
  function OemToAnsiBuffW(lpszSrc: LPCSTR; lpszDst: LPSTR; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'OemToCharBuffW';
  function OemToCharW(lpszSrc: PWideChar; lpszDst: PWideChar): BOOL; stdcall; external user32 name 'OemToCharW';
  function OemToCharBuffW(lpszSrc: PWideChar; lpszDst: PWideChar; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'OemToCharBuffW';

  function VkKeyScanW(ch: WideChar): SHORT; stdcall; external user32 name 'VkKeyScanW';
  function VkKeyScanExW(ch: WideChar; dwhkl: HKL): SHORT; stdcall; external user32 name 'VkKeyScanExW';

  function MapVirtualKeyW(uCode, uMapType: UINT): UINT; stdcall; external user32 name 'MapVirtualKeyW';
  function MapVirtualKeyExW(uCode, uMapType: UINT; dwhkl: HKL): UINT; stdcall; external user32 name 'MapVirtualKeyExW';

type
  va_list = PWideChar;
(*
var
  buf: PWideChar;
  arr: array[0..1] of Pointer;
begin
  buf := PWideChar(StrOfChar(#0, 255)); {我这样准备缓冲区}

  arr[0] := PWideChar('万一');
  arr[1] := Pointer(123);

  wvsprintf(buf, '%s, %d', @arr);

var
  buf: PWideChar;
  arr: array of Pointer; {和上一例的区别是这里用了动态数组}
begin
  buf := PWideChar(StrOfChar(#0, 255));

  SetLength(arr, Length(arr)+1);
  arr[High(arr)] := PWideChar('万一');

  SetLength(arr, Length(arr)+1);
  arr[High(arr)] := Pointer(123);

  wvsprintf(buf, '%s, %d', PWideChar(arr));
  //wvsprintf(buf, '%s, %d', @arr[0]); {或者这样}

  wsprintf(buf, '我是%s', PWideChar('万一'));
  ShowMessage(buf);                            {我是万一}
  wsprintf(buf, '现在是 %d 年', Pointer(2008));
  ShowMessage(buf);                            {现在是 2008 年}

  ---------------------------------
var
  data: array[0..255] of WideChar;
  Param: array[0..1] of DWORD;
  s: string;
  len: integer;
begin
  FillChar(data, SizeOf(data), 0);
  s := 'oh yes';
  Param[0] := 101;
  Param[1] := Integer(@s[1]);
  len := wvsprintf(data, 'good %d %s', @Param);
  mmo1.lines.Add('len:' + IntToStr(len));
  mmo1.lines.Add(string(data));
*)
  function wsprintfW(Output: PWideChar; Format: PWideChar; Data: Pointer): Integer; stdcall; external user32 name 'wsprintfW';
  function wvsprintfW(Output: PWideChar; Format: PWideChar; arglist: va_list): Integer; stdcall; external user32 name 'wvsprintfW';

  function CreateAcceleratorTableW(var Accel; Count: Integer): HACCEL; stdcall; external user32 name 'CreateAcceleratorTableW';
  function CopyAcceleratorTableW(hAccelSrc: HACCEL; var lpAccelDst;
    cAccelEntries: Integer): Integer; stdcall; external user32 name 'CopyAcceleratorTableW';
  function LoadAcceleratorsW(hInstance: HINST; lpTableName: PWideChar): HACCEL; stdcall; external user32 name 'LoadAcceleratorsW';
  function TranslateAcceleratorW(hWnd: HWND; hAccTable: HACCEL;
    var lpMsg: TMsg): Integer; stdcall; external user32 name 'TranslateAcceleratorW';
    
implementation

end.
