{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_char;

interface

uses
  atmcmbaseconst, winconst, wintype;


  function CharToOemA(lpszSrc: PAnsiChar; lpszDst: PAnsiChar): BOOL; stdcall; external user32 name 'CharToOemA';
  function AnsiToOemA(const lpszSrc: LPCSTR; lpszDst: LPSTR): BOOL; stdcall; external user32 name 'CharToOemA';
  function CharToOemBuffA(lpszSrc: PAnsiChar; lpszDst: PAnsiChar; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'CharToOemBuffA';
  function AnsiToOemBuffA(lpszSrc: LPCSTR; lpszDst: LPSTR; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'CharToOemBuffA';

  function CharUpperA(lpsz: PAnsiChar): PAnsiChar; stdcall; external user32 name 'CharUpperA';
  function AnsiUpperA(lpsz: LPSTR): LPSTR; stdcall; external user32 name 'CharUpperA';
  function CharUpperBuffA(lpsz: PAnsiChar; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharUpperBuffA';
  function AnsiUpperBuffA(lpsz: LPSTR; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharUpperBuffA';

  function CharLowerA(lpsz: PAnsiChar): PAnsiChar; stdcall; external user32 name 'CharLowerA';
  function AnsiLowerA(lpsz: LPSTR): LPSTR; stdcall; external user32 name 'CharLowerA';
  function CharLowerBuffA(lpsz: PAnsiChar; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharLowerBuffA';
  function AnsiLowerBuffA(lpsz: LPSTR; cchLength: DWORD): DWORD; stdcall; external user32 name 'CharLowerBuffA';

  function CharNextA(lpsz: PAnsiChar): PAnsiChar; stdcall; external user32 name 'CharNextA';
  function CharPrevA(lpszStart: PAnsiChar; lpszCurrent: PAnsiChar): PAnsiChar; stdcall; external user32 name 'CharPrevA';
  function AnsiNextA(const lpsz: LPCSTR): LPSTR; stdcall; external user32 name 'CharNextA';
  function AnsiPrevA(const lpszStart: LPCSTR; const lpszCurrent: LPCSTR): LPSTR; stdcall; external user32 name 'CharPrevA';
  function CharNextExA(CodePage: Word; lpCurrentChar: LPCSTR; dwFlags: DWORD): LPSTR; stdcall; external user32 name 'CharNextExA';
  function CharPrevExA(CodePage: Word; lpStart, lpCurrentChar: LPCSTR; dwFlags: DWORD): LPSTR; stdcall; external user32 name 'CharPrevExA';
  function IsCharAlphaA(ch: AnsiChar): BOOL; stdcall; external user32 name 'IsCharAlphaA';
  function IsCharAlphaNumericA(ch: AnsiChar): BOOL; stdcall; external user32 name 'IsCharAlphaNumericA';
  function IsCharUpperA(ch: AnsiChar): BOOL; stdcall; external user32 name 'IsCharUpperA';
  function IsCharUpperW(ch: WideChar): BOOL; stdcall; external user32 name 'IsCharUpperW';
  function IsCharLowerA(ch: AnsiChar): BOOL; stdcall; external user32 name 'IsCharLowerA';
  function IsCharLowerW(ch: WideChar): BOOL; stdcall; external user32 name 'IsCharLowerW';


type
  PKeyboardState = ^TKeyboardState;
  TKeyboardState = array[0..255] of Byte;
                          
  function LoadKeyboardLayoutA(pwszKLID: PAnsiChar; Flags: UINT): HKL; stdcall; external user32 name 'LoadKeyboardLayoutA';
  function ActivateKeyboardLayout(hkl: HKL; Flags: UINT): HKL; stdcall; external user32 name 'ActivateKeyboardLayout';
  function UnloadKeyboardLayout(hkl: HKL): BOOL; stdcall; external user32 name 'UnloadKeyboardLayout';
  function GetKeyboardLayoutNameA(pwszKLID: PAnsiChar): BOOL; stdcall; external user32 name 'GetKeyboardLayoutNameA';
  function GetKeyboardLayoutList(nBuff: Integer; var List): UINT; stdcall; external user32 name 'GetKeyboardLayoutList';
  function GetKeyboardLayout(dwLayout: DWORD): HKL; stdcall; external user32 name 'GetKeyboardLayout';
  function GetKeyboardType(nTypeFlag: Integer): Integer; stdcall; external user32 name 'GetKeyboardType';

  function GetKeyboardState(var KeyState: TKeyboardState): BOOL; stdcall; external user32 name 'GetKeyState';
  function SetKeyboardState(var KeyState: TKeyboardState): BOOL; stdcall; external user32 name 'SetKeyboardState';
  function GetKeyNameTextA(lParam: Longint; lpString: PAnsiChar; nSize: Integer): Integer; stdcall; external user32 name 'GetKeyNameTextA';

  function ToAscii(uVirtKey, uScanCode: UINT; const KeyState: TKeyboardState;
    AChar: PAnsiChar; uFlags: UINT): Integer; stdcall; external user32 name 'ToAscii';
  function ToAsciiEx(uVirtKey: UINT; uScanCode: UINT; const KeyState: TKeyboardState;
    AChar: PAnsiChar; uFlags: UINT; dwhkl: HKL): Integer; stdcall; external user32 name 'ToAsciiEx';
  function ToUnicode(wVirtKey, wScanCode: UINT; const KeyState: TKeyboardState;
    var pwszBuff; cchBuff: Integer; wFlags: UINT): Integer; stdcall; external user32 name 'ToUnicode';
  function ToUnicodeEx(wVirtKey, wScanCode: UINT; lpKeyState: PByte; pwszBuff: PWideChar;
    cchBuff: Integer; wFlags: UINT; dwhkl: HKL): Integer; stdcall; external user32 name 'ToUnicodeEx';

  function GetInputState: BOOL; stdcall; external user32 name 'GetInputState';
  function GetKBCodePage: UINT; stdcall; external user32 name 'GetKBCodePage';
  function OemKeyScan(wOemChar: Word): DWORD; stdcall; external user32 name 'OemKeyScan';
  function OemToAnsiA(const lpszSrc: LPCSTR; lpszDst: LPSTR): BOOL; stdcall; external user32 name 'OemToCharA';
  function OemToAnsiBuffA(lpszSrc: LPCSTR; lpszDst: LPSTR; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'OemToCharBuffA';
  function OemToCharA(lpszSrc: PAnsiChar; lpszDst: PAnsiChar): BOOL; stdcall; external user32 name 'OemToCharA';
  function OemToCharBuffA(lpszSrc: PAnsiChar; lpszDst: PAnsiChar; cchDstLength: DWORD): BOOL; stdcall; external user32 name 'OemToCharBuffA';

  function VkKeyScanA(ch: AnsiChar): SHORT; stdcall; external user32 name 'VkKeyScanA';
  function VkKeyScanExA(ch: AnsiChar; dwhkl: HKL): SHORT; stdcall; external user32 name 'VkKeyScanExA';


type
  PLastInputInfo = ^TLastInputInfo;
  TLastInputInfo = packed record
    cbSize: UINT;
    dwTime: DWORD;
  end;

  function GetLastInputInfo(var plii: TLastInputInfo): BOOL; stdcall; external user32 name 'GetLastInputInfo';
  function MapVirtualKeyA(uCode, uMapType: UINT): UINT; stdcall; external user32 name 'MapVirtualKeyA';
  function MapVirtualKeyExA(uCode, uMapType: UINT; dwhkl: HKL): UINT; stdcall; external user32 name 'MapVirtualKeyExA';

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
  function wsprintfA(Output: PAnsiChar; Format: PAnsiChar; Data: Pointer): Integer; stdcall; external user32 name 'wsprintfA';
  function wvsprintfA(Output: PAnsiChar; Format: PAnsiChar; arglist: va_list): Integer; stdcall; external user32 name 'wvsprintfA';

  function CreateAcceleratorTableA(var Accel; Count: Integer): HACCEL; stdcall; external user32 name 'CreateAcceleratorTableA';
  function CopyAcceleratorTableA(hAccelSrc: HACCEL; var lpAccelDst;
    cAccelEntries: Integer): Integer; stdcall; external user32 name 'CopyAcceleratorTableA';
  function DestroyAcceleratorTable(hAccel: HACCEL): BOOL; stdcall; external user32 name 'DestroyAcceleratorTable';
  function LoadAcceleratorsA(hInstance: HINST; lpTableName: PAnsiChar): HACCEL; stdcall; external user32 name 'LoadAcceleratorsA';
  function TranslateAcceleratorA(AWnd: HWND; hAccTable: HACCEL;
    var lpMsg: TMsg): Integer; stdcall; external user32 name 'TranslateAcceleratorA';
    
  
implementation

end.
