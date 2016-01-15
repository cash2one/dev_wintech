{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_kernel32_file;

interface
                
uses
  atmcmbaseconst, winconst, wintype;

const
  FILE_SHARE_READ                     = $00000001;
  FILE_SHARE_WRITE                    = $00000002;
  FILE_SHARE_DELETE                   = $00000004;
  FILE_ATTRIBUTE_READONLY             = $00000001;
  FILE_ATTRIBUTE_HIDDEN               = $00000002;
  FILE_ATTRIBUTE_SYSTEM               = $00000004;
  FILE_ATTRIBUTE_DIRECTORY            = $00000010;
  FILE_ATTRIBUTE_ARCHIVE              = $00000020;
  FILE_ATTRIBUTE_DEVICE               = $00000040;
  FILE_ATTRIBUTE_NORMAL               = $00000080;
  FILE_ATTRIBUTE_TEMPORARY            = $00000100;
  FILE_ATTRIBUTE_SPARSE_FILE          = $00000200;
  FILE_ATTRIBUTE_REPARSE_POINT        = $00000400;
  FILE_ATTRIBUTE_COMPRESSED           = $00000800;
  FILE_ATTRIBUTE_OFFLINE              = $00001000;
  FILE_ATTRIBUTE_NOT_CONTENT_INDEXED  = $00002000;
  FILE_ATTRIBUTE_ENCRYPTED            = $00004000;
  FILE_NOTIFY_CHANGE_FILE_NAME        = $00000001;
  FILE_NOTIFY_CHANGE_DIR_NAME         = $00000002;
  FILE_NOTIFY_CHANGE_ATTRIBUTES       = $00000004;
  FILE_NOTIFY_CHANGE_SIZE             = $00000008;
  FILE_NOTIFY_CHANGE_LAST_WRITE       = $00000010;
  FILE_NOTIFY_CHANGE_LAST_ACCESS      = $00000020;
  FILE_NOTIFY_CHANGE_CREATION         = $00000040;
  FILE_NOTIFY_CHANGE_SECURITY         = $00000100;
  FILE_ACTION_ADDED                   = $00000001;
  FILE_ACTION_REMOVED                 = $00000002;
  FILE_ACTION_MODIFIED                = $00000003;
  FILE_ACTION_RENAMED_OLD_NAME        = $00000004;
  FILE_ACTION_RENAMED_NEW_NAME        = $00000005;
  FILE_CASE_SENSITIVE_SEARCH          = $00000001;
  FILE_CASE_PRESERVED_NAMES           = $00000002;
  FILE_UNICODE_ON_DISK                = $00000004;
  FILE_PERSISTENT_ACLS                = $00000008;
  FILE_FILE_COMPRESSION               = $00000010;
  FILE_VOLUME_IS_COMPRESSED           = $00008000;
                                             
  FILE_FLAG_WRITE_THROUGH             = DWORD($80000000);
  FILE_FLAG_OVERLAPPED                = $40000000;
  FILE_FLAG_NO_BUFFERING              = $20000000;
  FILE_FLAG_RANDOM_ACCESS             = $10000000;
  FILE_FLAG_SEQUENTIAL_SCAN           = $8000000;
  FILE_FLAG_DELETE_ON_CLOSE           = $4000000;
  FILE_FLAG_BACKUP_SEMANTICS          = $2000000;
  FILE_FLAG_POSIX_SEMANTICS           = $1000000;
                       
  FILE_BEGIN                          = 0;
  FILE_CURRENT                        = 1;
  FILE_END                            = 2;

  // dwDesiredAccess: GENERIC_READ
  // dwShareMode: FILE_SHARE_READ
  // dwCreationDisposition: CREATE_ALWAYS
  // dwFlagsAndAttributes: FILE_ATTRIBUTE_NORMAL
  function CreateFileA(lpFileName: PAnsiChar; dwDesiredAccess, dwShareMode: DWORD;
    lpSecurityAttributes: PSecurityAttributes; dwCreationDisposition, dwFlagsAndAttributes: DWORD;
    hTemplateFile: THandle): THandle; stdcall; external kernel32 name 'CreateFileA';
  function DeleteFileA(lpFileName: PAnsiChar): BOOL; stdcall; external kernel32 name 'DeleteFileA';
  function CopyFileA(lpExistingFileName, lpNewFileName: PAnsiChar; bFailIfExists: BOOL): BOOL; stdcall; external kernel32 name 'CopyFileA';

  function WriteFile(AFile: THandle; const Buffer; nNumberOfBytesToWrite: DWORD;
    var lpNumberOfBytesWritten: DWORD; lpOverlapped: POverlapped): BOOL; stdcall; external kernel32 name 'WriteFile';
  function WriteFileEx(AFile: THandle; lpBuffer: Pointer; nNumberOfBytesToWrite: DWORD;
    const lpOverlapped: TOverlapped; lpCompletionRoutine: FARPROC): BOOL; stdcall; external kernel32 name 'WriteFileEx';
  function ReadFile(AFile: THandle; var Buffer; nNumberOfBytesToRead: DWORD;
    var lpNumberOfBytesRead: DWORD; lpOverlapped: POverlapped): BOOL; stdcall; external kernel32 name 'ReadFile';
  function ReadFileEx(AFile: THandle; lpBuffer: Pointer; nNumberOfBytesToRead: DWORD;
    lpOverlapped: POverlapped; lpCompletionRoutine: TPROverlappedCompletionRoutine): BOOL; stdcall; external kernel32 name 'ReadFileEx';

  function SetEndOfFile(AFile: THandle): BOOL; stdcall; external kernel32 name 'SetEndOfFile';
  function SetFilePointer(AFile: THandle; lDistanceToMove: Longint;
    lpDistanceToMoveHigh: Pointer; dwMoveMethod: DWORD): DWORD; stdcall; external kernel32 name 'SetFilePointer';

  // 刷新内部文件缓冲区 清空串口缓冲区,然后去读串口的数据
  // FlushFileBuffers   返回的值是非零只是说明该函数调用成功了，但是它的清除是滞后的，就是说直到缓冲区中的数据传输完毕才清除缓冲区。
  // 而PurgeComm是直接删除未传输的数据。所以不同啊，其实你的问题是出在延时上，所以用PurgeComm就成功了
  function FlushFileBuffers(AFile: THandle): BOOL; stdcall; external kernel32 name 'FlushFileBuffers';
  
  function SetFileAttributesA(lpFileName: PAnsiChar; dwFileAttributes: DWORD): BOOL; stdcall; external kernel32 name 'SetFileAttributesA';
  function GetFileAttributesA(lpFileName: PAnsiChar): DWORD; stdcall; external kernel32 name 'GetFileAttributesA';

//  function GetFileInformationByHandle(AFile: THandle; var lpFileInformation: TByHandleFileInformation): BOOL; stdcall; external kernel32 name 'GetFileInformationByHandle';
  function GetFileType(AFile: THandle): DWORD; stdcall; external kernel32 name 'GetFileType';
  function GetFileSize(AFile: THandle; lpFileSizeHigh: Pointer): DWORD; stdcall; external kernel32 name 'GetFileSize';
  function GetFileTime(AFile: THandle; lpCreationTime, lpLastAccessTime, lpLastWriteTime: PFileTime):
    BOOL; stdcall; external kernel32 name 'GetFileTime';
  
  function CreateFileMappingA(AFile: THandle; lpFileMappingAttributes: PSecurityAttributes;
    flProtect, dwMaximumSizeHigh, dwMaximumSizeLow: DWORD; lpName: PAnsiChar): THandle; stdcall; external kernel32 name 'CreateFileMappingA';
  function OpenFileMappingA(dwDesiredAccess: DWORD; bInheritHandle: BOOL; lpName: PAnsiChar): THandle; stdcall; external kernel32 name 'OpenFileMappingA';
                 
  function MapViewOfFile(AFileMappingObject: THandle; dwDesiredAccess: DWORD;
    dwFileOffsetHigh, dwFileOffsetLow, dwNumberOfBytesToMap: DWORD): Pointer; stdcall; external kernel32 name 'MapViewOfFile';
  function MapViewOfFileEx(AFileMappingObject: THandle;
    dwDesiredAccess, dwFileOffsetHigh, dwFileOffsetLow, dwNumberOfBytesToMap: DWORD;
    lpBaseAddress: Pointer): Pointer; stdcall; external kernel32 name 'MapViewOfFileEx';
  function FlushViewOfFile(const lpBaseAddress: Pointer; dwNumberOfBytesToFlush: DWORD): BOOL; stdcall; external kernel32 name 'FlushViewOfFile';
  function UnmapViewOfFile(lpBaseAddress: Pointer): BOOL; stdcall; external kernel32 name 'UnmapViewOfFile';
  function EncryptFile(lpFilename: PAnsiChar): BOOL; stdcall; external kernel32 name 'EncryptFile';
  function DecryptFile(lpFilename: PAnsiChar; dwReserved: DWORD): BOOL; stdcall; external kernel32 name 'DecryptFile';

  function FindFirstFileA(lpFileName: PAnsiChar; var lpFindFileData: TWIN32FindDataA): THandle; stdcall; external kernel32 name 'FindFirstFileA';
  function FindNextFileA(hFindFile: THandle; var lpFindFileData: TWIN32FindDataA): BOOL; stdcall; external kernel32 name 'FindNextFileA';

type
  _FINDEX_INFO_LEVELS = (FindExInfoStandard, FindExInfoMaxInfoLevel);
  TFindexInfoLevels = _FINDEX_INFO_LEVELS;
  FINDEX_INFO_LEVELS = _FINDEX_INFO_LEVELS;
                         
  _FINDEX_SEARCH_OPS = (FindExSearchNameMatch, FindExSearchLimitToDirectories,
    FindExSearchLimitToDevices, FindExSearchMaxSearchOp);
  TFindexSearchOps = _FINDEX_SEARCH_OPS;
  FINDEX_SEARCH_OPS = _FINDEX_SEARCH_OPS;

  function FindFirstFileExA(lpFileName: PAnsiChar; fInfoLevelId: TFindexInfoLevels;
    lpFindFileData: Pointer; fSearchOp: TFindexSearchOps; lpSearchFilter: Pointer;
    dwAdditionalFlags: DWORD): BOOL; stdcall; external kernel32 name 'FindFirstFileExA';
  function FindClose(hFindFile: THandle): BOOL; stdcall; external kernel32 name 'FindClose';

const
  OFS_MAXPATHNAME = 128;

type
  POFStruct = ^TOFStruct;
  TOFStruct = record
    cBytes: Byte;
    fFixedDisk: Byte;
    nErrCode: Word;
    Reserved1: Word;
    Reserved2: Word;
    szPathName: array[0..OFS_MAXPATHNAME-1] of AnsiChar;
  end;

  function OpenFile(const lpFileName: LPCSTR; var lpReOpenBuff: TOFStruct; uStyle: UINT): HFILE; stdcall;
      external kernel32 name 'OpenFile';

implementation

end.
