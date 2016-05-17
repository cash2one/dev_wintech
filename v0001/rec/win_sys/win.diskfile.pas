unit win.diskfile;

interface

uses
  types;
  
type
  PFileUrl          = ^TFileUrl;                             
  TFileUrl          = record
    Url             : AnsiString;
  end;
  
  PWinFile          = ^TWinFile;          
  TWinFile          = record
    FileHandle      : THandle;
    FileMapHandle   : THandle;
    FileMapRootView : Pointer;
    FilePosition    : DWORD;
    FileSizeLow     : DWORD;
  end;
            
  PWinFileMap       = ^TWinFileMap;
  TWinFileMap       = record
    WinFile         : PWinFile;
    MapHandle       : THandle;
    MapSize         : DWORD;
    SizeHigh        : DWORD;
    SizeLow         : DWORD;
    MapView         : Pointer;
  end;
                
const
  faSymLink     = $00000400 platform; // Only available on Vista and above
  faDirectory   = $00000010;

{line 2250}
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
  FILE_ATTRIBUTE_VIRTUAL              = $00010000;
  INVALID_FILE_ATTRIBUTES             = DWORD($FFFFFFFF);
   
  function CheckOutWinFile: PWinFile;    
  procedure CheckInWinFile(var AWinFile: PWinFile);

  function WinFileOpen(AWinFile: PWinFile; AFileUrl: AnsiString; AForceOpen: Boolean): Boolean;  
  procedure WinFileClose(AWinFile: PWinFile);      
  procedure WinFileUpdateSize(AWinFile: PWinFile; const Value: integer);
  function IsWinFileExists(const AFileName: AnsiString): Boolean;
  function IsWinFileExistsLockedOrShared(const AFilename: Ansistring): Boolean;

  function WinFileOpenMap(AWinFile: PWinFile): Boolean;  
  procedure WinFileCloseMap(AWinFile: PWinFile);

  function CheckOutWinFileMap: PWinFileMap;
  procedure CheckInWinFileMap(var AWinFileMap: PWinFileMap);  
  function WinFileMapOpen(AWinFileMap: PWinFileMap): Boolean;
  procedure WinFileMapClose(AWinFileMap: PWinFileMap);

implementation

uses
  Windows;
               
function CheckOutWinFile: PWinFile;                            
begin
  Result := System.New(PWinFile);
  FillChar(Result^, SizeOf(TWinFile), 0);
end;

procedure CheckInWinFile(var AWinFile: PWinFile);
begin
  if nil = AWinFile then
    exit;
  WinFileClose(AWinFile);
  FreeMem(AWinFile);
  AWinFile := nil;
end;

function WinFileOpen(AWinFile: PWinFile; AFileUrl: AnsiString; AForceOpen: Boolean): Boolean;
var
  tmpFlags: DWORD;
  tmpCreation: DWORD;
begin
  tmpFlags := Windows.FILE_ATTRIBUTE_NORMAL;
  tmpCreation := Windows.OPEN_EXISTING;
  if AForceOpen then
  begin
    if not IsWinFileExists(AFileUrl) then
    begin
      tmpCreation := Windows.CREATE_NEW;
    end;
  end;
  AWinFile.FileHandle := Windows.CreateFileA(PAnsiChar(AFileUrl),
          Windows.GENERIC_ALL,         // GENERIC_READ
          Windows.FILE_SHARE_READ or
          Windows.FILE_SHARE_WRITE or
          Windows.FILE_SHARE_DELETE,
        nil,
        tmpCreation,
        tmpFlags, 0);
  Result := (AWinFile.FileHandle <> 0) and (AWinFile.FileHandle <> Windows.INVALID_HANDLE_VALUE);
  if Result then
  begin
    AWinFile.FileSizeLow := Windows.GetFileSize(AWinFile.FileHandle, nil);
  end;
end;

procedure WinFileClose(AWinFile: PWinFile);
begin
  if (0 <> AWinFile.FileHandle) and (INVALID_HANDLE_VALUE <> AWinFile.FileHandle) then
  begin
    WinFileCloseMap(AWinFile);
    if Windows.CloseHandle(AWinFile.FileHandle) then
    begin
      AWinFile.FileHandle := 0;
    end;
  end;
end;


function IsWinFileExistsLockedOrShared(const AFilename: Ansistring): Boolean;
var
  tmpFindData: TWin32FindData;
  tmpFindHandle: THandle;
begin
  { Either the file is locked/share_exclusive or we got an access denied }
  tmpFindHandle := FindFirstFileA(PAnsiChar(AFilename), tmpFindData);
  if tmpFindHandle <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(tmpFindHandle);
    Result := tmpFindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY = 0;
  end else
    Result := False;
end;
  
function IsWinFileExists(const AFileName: AnsiString): Boolean;
var  
  tmpCode: Integer;
  tmpErrorCode: DWORD;
begin
  tmpCode := Windows.GetFileAttributesA(PAnsiChar(AFileName));
  if -1 = tmpCode then
  begin
    tmpErrorCode := Windows.GetLastError;
    Result := (tmpErrorCode <> ERROR_FILE_NOT_FOUND) and
              (tmpErrorCode <> ERROR_PATH_NOT_FOUND) and
              (tmpErrorCode <> ERROR_INVALID_NAME);
    if Result then
    begin
      Result := IsWinFileExistsLockedOrShared(AFileName);
    end;
  end else
  begin
    Result := (FILE_ATTRIBUTE_DIRECTORY and tmpCode = 0)
  end;
end;

procedure WinFileUpdateSize(AWinFile: PWinFile; const Value: integer);
begin
  if AWinFile.FileSizeLow <> Value then
  begin
    if 0 < Value then
    begin
      Windows.SetFilePointer(AWinFile.FileHandle, Value, nil, FILE_BEGIN);
      Windows.SetEndOfFile(AWinFile.FileHandle);
      Windows.SetFilePointer(AWinFile.FileHandle, 0, nil, FILE_BEGIN);
      AWinFile.FileSizeLow := Value;
    end;
  end;
end;         

function WinFileOpenMap(AWinFile: PWinFile): Boolean;
begin
  AWinFile.FileMapHandle := Windows.CreateFileMappingA(AWinFile.FileHandle, nil, Windows.PAGE_READWRITE, 0, 0, nil);
  if AWinFile.FileMapHandle <> 0 then
  begin
     // OpenFileMapping
    AWinFile.FileMapRootView := Windows.MapViewOfFile(AWinFile.FileMapHandle, Windows.FILE_MAP_ALL_ACCESS, 0, 0, 0);
//    fWinFileData.FileMapRootView := MapViewOfFileEx(
//      fWinFileData.FileMapHandle, //hFileMappingObject: THandle;
//      Windows.FILE_MAP_ALL_ACCESS, //dwDesiredAccess,
//      0, //dwFileOffsetHigh,
//      0, //dwFileOffsetLow,
//      0, //dwNumberOfBytesToMap: DWORD;
//      nil //lpBaseAddress: Pointer
//      );
  end;
  Result := nil <> AWinFile.FileMapRootView;
end;

procedure WinFileCloseMap(AWinFile: PWinFile);
begin
  if nil <> AWinFile.FileMapRootView then
  begin
    UnMapViewOfFile(AWinFile.FileMapRootView);
    AWinFile.FileMapRootView := nil;
  end;
  if 0 <> AWinFile.FileMapHandle then
  begin
    Windows.CloseHandle(AWinFile.FileMapHandle);
    AWinFile.FileMapHandle := 0;
  end;
end;

function CheckOutWinFileMap: PWinFileMap;
begin
  Result := System.New(PWinFileMap);
  FillChar(Result^, SizeOf(TWinFileMap), 0);
end;

procedure CheckInWinFileMap(var AWinFileMap: PWinFileMap);
begin
  if nil <> AWinFileMap then
  begin
    WinFileMapClose(AWinFileMap);
    FreeMem(AWinFileMap);
    AWinFileMap := nil;
  end;
end;

function WinFileMapOpen(AWinFileMap: PWinFileMap): Boolean;
begin
  if nil = AWinFileMap.MapView then
  begin
    if 0 = AWinFileMap.MapHandle then
    begin
      AWinFileMap.MapHandle := Windows.CreateFileMappingA(AWinFileMap.WinFile.FileHandle,
        nil, //lpFileMappingAttributes: PSecurityAttributes;
        0, //flProtect: DWORD
        AWinFileMap.SizeHigh, //dwMaximumSizeHigh: DWORD
        AWinFileMap.SizeLow, //dwMaximumSizeLow: DWORD
        nil //lpName: PAnsiChar
      );
    end;
    if (0 <> AWinFileMap.MapHandle) and (INVALID_HANDLE_VALUE <> AWinFileMap.MapHandle) then
    begin
      AWinFileMap.MapView := Windows.MapViewOfFile(AWinFileMap.MapHandle, 0, 0, 0, AWinFileMap.MapSize);
    end;
  end;
  Result := nil <> AWinFileMap.MapView;
end;

procedure WinFileMapClose(AWinFileMap: PWinFileMap);
begin
  if nil <> AWinFileMap then
  begin
    if nil <> AWinFileMap.MapView then
    begin
      if UnmapViewOfFile(AWinFileMap.MapView) then
      begin
        AWinFileMap.MapView := nil;
      end;
    end;
    if 0 <> AWinFileMap.MapHandle then
    begin
      if CloseHandle(AWinFileMap.MapHandle) then
      begin
        AWinFileMap.MapHandle := 0;
      end;
    end;
  end;
end;

end.
