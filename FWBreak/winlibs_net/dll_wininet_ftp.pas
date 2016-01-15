unit dll_wininet_ftp;

interface

uses
  atmcmbaseconst, winconst, wintype, dll_wininet;

const
{ flags for FTP }
  FTP_TRANSFER_TYPE_UNKNOWN   = $00000000;
  FTP_TRANSFER_TYPE_ASCII     = $00000001;
  FTP_TRANSFER_TYPE_BINARY    = $00000002;

  FTP_TRANSFER_TYPE_MASK      = FTP_TRANSFER_TYPE_ASCII or
                                FTP_TRANSFER_TYPE_BINARY;

function FtpFindFirstFile(AConnect: HINTERNET; lpszSearchFile: PAnsiChar; var lpFindFileData: TWin32FindData;
    dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall; external wininet name 'FtpFindFirstFileA';
function FtpGetFile(AConnect: HINTERNET; lpszRemoteFile: PAnsiChar; lpszNewFile: PAnsiChar;
    fFailIfExists: BOOL; dwFlagsAndAttributes: DWORD; dwFlags: DWORD; dwContext: DWORD): BOOL stdcall; external wininet name 'FtpGetFileA';
function FtpPutFile(AConnect: HINTERNET; lpszLocalFile: PAnsiChar; lpszNewRemoteFile: PAnsiChar; dwFlags: DWORD;
    dwContext: DWORD): BOOL; stdcall; external wininet name 'FtpPutFileA';
function FtpDeleteFile(AConnect: HINTERNET; lpszFileName: PAnsiChar): BOOL; stdcall; external wininet name 'FtpDeleteFileA';
function FtpRenameFile(AConnect: HINTERNET; lpszExisting: PAnsiChar; lpszNew: PAnsiChar): BOOL; stdcall; external wininet name 'FtpRenameFileA';
function FtpOpenFile(AConnect: HINTERNET; lpszFileName: PAnsiChar; dwAccess: DWORD; dwFlags: DWORD;
    dwContext: DWORD): HINTERNET; stdcall; external wininet name 'FtpOpenFileA';
function FtpGetFileSize(AFile: HINTERNET; lpdwFileSizeHigh: LPDWORD): DWORD; stdcall; external wininet name 'FtpGetFileSize';

function FtpCreateDirectory(AConnect: HINTERNET; lpszDirectory: PAnsiChar): BOOL; stdcall; external wininet name 'FtpCreateDirectoryA';
function FtpRemoveDirectory(AConnect: HINTERNET; lpszDirectory: PAnsiChar): BOOL; stdcall; external wininet name 'FtpRemoveDirectoryA';
function FtpSetCurrentDirectory(AConnect: HINTERNET; lpszDirectory: PAnsiChar): BOOL; stdcall; external wininet name 'FtpSetCurrentDirectoryA';
function FtpGetCurrentDirectory(AConnect: HINTERNET; lpszCurrentDirectory: PAnsiChar;
    var lpdwCurrentDirectory: DWORD): BOOL; stdcall; external wininet name 'FtpGetCurrentDirectoryA';

function FtpCommand(AConnect: HINTERNET; fExpectResponse: BOOL; dwFlags: DWORD; lpszCommand: PAnsiChar;
    dwContext: DWORD): BOOL; stdcall; external wininet name 'FtpCommandA';

implementation

end.
