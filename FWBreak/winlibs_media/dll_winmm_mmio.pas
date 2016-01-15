unit dll_winmm_mmio;

interface

uses
  atmcmbaseconst, winconst, wintype, dll_winmm;

type
{ MMIO data types }
  FOURCC = DWORD;                    { a four character code }

  PHMMIO = ^HMMIO;
  HMMIO = Integer;      { a handle to an open file }

  TFNMMIOProc = function(lpmmioinfo: PAnsiChar; uMessage: UINT; lParam1, lParam2: LPARAM): Longint stdcall;

  PMMIOInfo = ^TMMIOInfo;
  _MMIOINFO = record
    { general fields }
    dwFlags: DWORD;        { general status flags }
    fccIOProc: FOURCC;      { pointer to I/O procedure }
    pIOProc: TFNMMIOProc;        { pointer to I/O procedure }
    wErrorRet: UINT;      { place for error to be returned }
    hTask: HTASK;          { alternate local task }

    { fields maintained by MMIO functions during buffered I/O }
    cchBuffer: Longint;      { size of I/O buffer (or 0L) }
    pchBuffer: PAnsiChar;      { start of I/O buffer (or NULL) }
    pchNext: PAnsiChar;        { pointer to next byte to read/write }
    pchEndRead: PAnsiChar;     { pointer to last valid byte to read }
    pchEndWrite: PAnsiChar;    { pointer to last byte to write }
    lBufOffset: Longint;     { disk offset of start of buffer }

    { fields maintained by I/O procedure }
    lDiskOffset: Longint;    { disk offset of next read or write }
    adwInfo: array[0..2] of DWORD;     { data specific to type of MMIOPROC }

    { other fields maintained by MMIO }
    dwReserved1: DWORD;    { reserved for MMIO use }
    dwReserved2: DWORD;    { reserved for MMIO use }
    hmmio: HMMIO;          { handle to open file }
  end;
  TMMIOInfo = _MMIOINFO;
  MMIOINFO = _MMIOINFO;

  PMMCKInfo = ^TMMCKInfo;
  _MMCKINFO = record
    ckid: FOURCC;           { chunk ID }
    cksize: DWORD;         { chunk size }
    fccType: FOURCC;        { form type or list type }
    dwDataOffset: DWORD;   { offset of data portion of chunk }
    dwFlags: DWORD;        { flags used by MMIO functions }
  end;
  TMMCKInfo = _MMCKINFO;
  MMCKINFO = _MMCKINFO;

function mmioAdvance(hmmio: HMMIO; lpmmioinfo: PMMIOInfo; uFlags: UINT): MMRESULT; stdcall; external winmm name 'mmioAdvance';
function mmioAscend(hmmio: HMMIO; lpck: PMMCKInfo; uFlags: UINT): MMRESULT; stdcall; external winmm name 'mmioAscend';
function mmioClose(hmmio: HMMIO; uFlags: UINT): MMRESULT; stdcall; external winmm name 'mmioClose';
function mmioCreateChunk(hmmio: HMMIO; lpck: PMMCKInfo; uFlags: UINT): MMRESULT; stdcall; external winmm name 'mmioCreateChunk';
function mmioDescend(hmmio: HMMIO; lpck: PMMCKInfo;
  lpckParent: PMMCKInfo; uFlags: UINT): MMRESULT; stdcall; external winmm name 'mmioDescend';
function mmioFlush(hmmio: HMMIO; uFlags: UINT): MMRESULT; stdcall; external winmm name 'mmioFlush';
function mmioGetInfo(hmmio: HMMIO; lpmmioinfo: PMMIOInfo; uFlags: UINT): MMRESULT; stdcall; external winmm name 'mmioGetInfo';
function mmioInstallIOProc(fccIOProc: FOURCC; pIOProc: TFNMMIOProc;
  dwFlags: DWORD): TFNMMIOProc; stdcall; external winmm name 'mmioInstallIOProcA';
function mmioOpen(szFileName: PAnsiChar; lpmmioinfo: PMMIOInfo;
  dwOpenFlags: DWORD): HMMIO; stdcall; external winmm name 'mmioOpenA';
function mmioRead(hmmio: HMMIO; pch: PAnsiChar; cch: Longint): Longint; stdcall; external winmm name 'mmioRead';
function mmioRename(szFileName, szNewFileName: PAnsiChar;
  lpmmioinfo: PMMIOInfo; dwRenameFlags: DWORD): MMRESULT; stdcall; external winmm name 'mmioRenameA';
function mmioSeek(hmmio: HMMIO; lOffset: Longint; 
  iOrigin: Integer): Longint; stdcall; external winmm name 'mmioSeek';
function mmioSendMessage(hmmio: HMMIO; uMessage: UINT;
  lParam1, lParam2: DWORD): Longint; stdcall; external winmm name 'mmioSendMessage';
function mmioSetBuffer(hmmio: HMMIO; pchBuffer: PAnsiChar; cchBuffer: Longint;
  uFlags: Word): MMRESULT; stdcall; external winmm name 'mmioSetBuffer';
function mmioSetInfo(hmmio: HMMIO; lpmmioinfo: PMMIOInfo; uFlags: UINT): MMRESULT; stdcall; external winmm name 'mmioSetInfo';
function mmioStringToFOURCC(sz: PAnsiChar; uFlags: UINT): FOURCC; stdcall; external winmm name 'mmioStringToFOURCCA';
function mmioWrite(hmmio: HMMIO; pch: PAnsiChar; cch: Longint): Longint; stdcall; external winmm name 'mmioWrite';


implementation

end.
