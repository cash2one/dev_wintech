
unit dll_lz32;

interface

uses
  dll_kernel32_file;

const
  lz32 = 'LZ32.DLL';

  LZERROR_BADINHANDLE = -1;         { invalid input handle }
  LZERROR_BADOUTHANDLE = -2;        { invalid output handle }
  LZERROR_READ = -3;                { corrupt compressed file format }
  LZERROR_WRITE = -4;               { out of space for output file }
  LZERROR_GLOBALLOC = -5;           { insufficient memory for LZFile struct }
  LZERROR_GLOBLOCK = -6;            { bad global handle }
  LZERROR_BADVALUE = -7;            { input parameter out of acceptable range }
  LZERROR_UNKNOWNALG = -8;          { compression algorithm not recognized }

  function GetExpandedNameA(Source, Buffer: PAnsiChar): Integer; stdcall; external lz32 name 'GetExpandedNameA';
  function GetExpandedNameW(Source, Buffer: PWideChar): Integer; stdcall; external lz32 name 'GetExpandedNameW';
  procedure LZClose(AFile: Integer); stdcall; external lz32 name 'LZClose';
  function LZCopy(Source, Dest: Integer): Longint; stdcall; external lz32 name 'LZCopy';
  function LZInit(Source: Integer): Integer; stdcall; external lz32 name 'LZInit';
  function LZOpenFileA(AFilename: PAnsiChar; var ReOpenBuff: TOFStruct; Style: Word): Integer; stdcall; external lz32 name 'LZOpenFileA';
  function LZOpenFileW(AFilename: PWideChar; var ReOpenBuff: TOFStruct; Style: Word): Integer; stdcall; external lz32 name 'LZOpenFileW';
  function LZRead(AFile: Integer; Buffer: PAnsiChar; Count: Integer): Integer; stdcall; external lz32 name 'LZRead';
  function LZSeek(AFile: Integer; Offset: Longint; Origin: Integer): Longint; stdcall; external lz32 name 'LZSeek';

implementation

end.