{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_char_a;

interface

uses
  atmcmbaseconst, winconst, wintype;


  function CharToOem(lpszSrc: PAnsiChar; lpszDst: PAnsiChar): BOOL; stdcall; external user32 name 'CharToOemA';
  function AnsiToOem(const lpszSrc: LPCSTR; lpszDst: LPSTR): BOOL; stdcall; external user32 name 'CharToOemA';
  function CharToOemBuff(lpszSrc: PAnsiChar; lpszDst: PAnsiChar; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'CharToOemBuffA';
  function AnsiToOemBuff(lpszSrc: LPCSTR; lpszDst: LPSTR; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'CharToOemBuffA';

  function CharUpper(lpsz: PAnsiChar): PAnsiChar; stdcall; external user32 name 'CharUpperA';
  function AnsiUpper(lpsz: LPSTR): LPSTR; stdcall; external user32 name 'CharUpperA';
  function CharUpperBuff(lpsz: PAnsiChar; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharUpperBuffA';
  function AnsiUpperBuff(lpsz: LPSTR; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharUpperBuffA';

  function CharLower(lpsz: PAnsiChar): PAnsiChar; stdcall; external user32 name 'CharLowerA';
  function AnsiLower(lpsz: LPSTR): LPSTR; stdcall; external user32 name 'CharLowerA';
  function CharLowerBuff(lpsz: PAnsiChar; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharLowerBuffA';
  function AnsiLowerBuff(lpsz: LPSTR; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharLowerBuffA';

  function CharNext(lpsz: PAnsiChar): PAnsiChar; stdcall; external user32 name 'CharNextA';
  function CharPrev(lpszStart: PAnsiChar; lpszCurrent: PAnsiChar): PAnsiChar; stdcall; external user32 name 'CharPrevA';
  function AnsiNext(const lpsz: LPCSTR): LPSTR; stdcall; external user32 name 'CharNextA';
  function AnsiPrev(const lpszStart: LPCSTR; const lpszCurrent: LPCSTR): LPSTR; stdcall; external user32 name 'CharPrevA';
  function CharNextEx(CodePage: Word; lpCurrentChar: LPCSTR; dwFlags: DWORD): LPSTR; stdcall; external user32 name 'CharNextExA';
  function CharPrevEx(CodePage: Word; lpStart, lpCurrentChar: LPCSTR; dwFlags: DWORD): LPSTR; stdcall; external user32 name 'CharPrevExA';
  function IsCharAlpha(ch: AnsiChar): BOOL; stdcall; external user32 name 'IsCharAlphaA';
  function IsCharAlphaNumeric(ch: AnsiChar): BOOL; stdcall; external user32 name 'IsCharAlphaNumericA';
  function IsCharUpper(ch: AnsiChar): BOOL; stdcall; external user32 name 'IsCharUpperA';
  function IsCharUpperW(ch: WideChar): BOOL; stdcall; external user32 name 'IsCharUpperW';
  function IsCharLower(ch: AnsiChar): BOOL; stdcall; external user32 name 'IsCharLowerA';
  function IsCharLowerW(ch: WideChar): BOOL; stdcall; external user32 name 'IsCharLowerW';


type
  PKeyboardState = ^TKeyboardState;
  TKeyboardState = array[0..255] of Byte;
                          
  function LoadKeyboardLayout(pwszKLID: PAnsiChar; Flags: UINT): HKL; stdcall; external user32 name 'LoadKeyboardLayoutA';
  function GetKeyboardLayoutName(pwszKLID: PAnsiChar): BOOL; stdcall; external user32 name 'GetKeyboardLayoutNameA';

  function GetKeyNameText(lParam: Longint; lpString: PAnsiChar; nSize: Integer): Integer; stdcall; external user32 name 'GetKeyNameTextA';

  function OemToAnsi(const lpszSrc: LPCSTR; lpszDst: LPSTR): BOOL; stdcall; external user32 name 'OemToCharA';
  function OemToAnsiBuff(lpszSrc: LPCSTR; lpszDst: LPSTR; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'OemToCharBuffA';
  function OemToChar(lpszSrc: PAnsiChar; lpszDst: PAnsiChar): BOOL; stdcall; external user32 name 'OemToCharA';
  function OemToCharBuff(lpszSrc: PAnsiChar; lpszDst: PAnsiChar; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'OemToCharBuffA';

  function VkKeyScan(ch: AnsiChar): SHORT; stdcall; external user32 name 'VkKeyScanA';
  function VkKeyScanEx(ch: AnsiChar; dwhkl: HKL): SHORT; stdcall; external user32 name 'VkKeyScanExA';

  function MapVirtualKey(uCode, uMapType: UINT): UINT; stdcall; external user32 name 'MapVirtualKeyA';
  function MapVirtualKeyEx(uCode, uMapType: UINT; dwhkl: HKL): UINT; stdcall; external user32 name 'MapVirtualKeyExA';

type
  va_list = PAnsiChar;
(*
var
  buf: PAnsiChar;
  arr: array[0..1] of Pointer;
begin
  buf := PAnsiChar(StrOfChar(#0, 255)); {我这样准备缓冲区}

  arr[0] := PAnsiChar('万一');
  arr[1] := Pointer(123);

  wvsprintf(buf, '%s, %d', @arr);

var
  buf: PAnsiChar;
  arr: array of Pointer; {和上一例的区别是这里用了动态数组}
begin
  buf := PAnsiChar(StrOfChar(#0, 255));

  SetLength(arr, Length(arr)+1);
  arr[High(arr)] := PAnsiChar('万一');

  SetLength(arr, Length(arr)+1);
  arr[High(arr)] := Pointer(123);

  wvsprintf(buf, '%s, %d', PAnsiChar(arr));
  //wvsprintf(buf, '%s, %d', @arr[0]); {或者这样}

  wsprintf(buf, '我是%s', PAnsiChar('万一'));
  ShowMessage(buf);                            {我是万一}
  wsprintf(buf, '现在是 %d 年', Pointer(2008));
  ShowMessage(buf);                            {现在是 2008 年}

  ---------------------------------
var
  data: array[0..255] of AnsiChar;
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
  function wsprintf(Output: PAnsiChar; Format: PAnsiChar; Data: Pointer): Integer; stdcall; external user32 name 'wsprintfA';
  function wvsprintf(Output: PAnsiChar; Format: PAnsiChar; arglist: va_list): Integer; stdcall; external user32 name 'wvsprintfA';

  function CreateAcceleratorTable(var Accel; Count: Integer): HACCEL; stdcall; external user32 name 'CreateAcceleratorTableA';
  function CopyAcceleratorTable(hAccelSrc: HACCEL; var lpAccelDst;
    cAccelEntries: Integer): Integer; stdcall; external user32 name 'CopyAcceleratorTableA';
  function LoadAccelerators(hInstance: HINST; lpTableName: PAnsiChar): HACCEL; stdcall; external user32 name 'LoadAcceleratorsA';
  function TranslateAccelerator(hWnd: HWND; hAccTable: HACCEL;
    var lpMsg: TMsg): Integer; stdcall; external user32 name 'TranslateAcceleratorA';
    
  
implementation

end.
