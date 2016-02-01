unit win.diskfile;

interface

uses
  types;
  
type
  PFileUrl          = ^TFileUrl;                             
  TFileUrl          = record
  end;
  
  PWinFile          = ^TWinFile;          
  TWinFile          = record
    FileHandle      : THandle;
    FileMapHandle   : THandle;
    FileMapRootView : Pointer;
    FilePosition    : DWORD;
    FileSizeLow     : DWORD;
  end;
                  
  function WinFileOpen(AWinFile: PWinFile; AFileUrl: AnsiString; AForceOpen: Boolean): Boolean;  
  procedure WinFileClose(AWinFile: PWinFile);      
  procedure UpdateWinFileSize(AWinFile: PWinFile; const Value: integer);
  function WinFileExists(const AFileName: AnsiString): Boolean;
  function WinFileExistsLockedOrShared(const AFilename: Ansistring): Boolean;

  function WinFileMapOpen(AWinFile: PWinFile): Boolean;  
  procedure WinFileMapClose(AWinFile: PWinFile);

implementation

uses
  Windows;

function WinFileOpen(AWinFile: PWinFile; AFileUrl: AnsiString; AForceOpen: Boolean): Boolean;
var
  tmpFlags: DWORD;
  tmpCreation: DWORD;
begin
  tmpFlags := Windows.FILE_ATTRIBUTE_NORMAL;
  tmpCreation := Windows.OPEN_EXISTING;
  if AForceOpen then
  begin
    if not WinFileExists(AFileUrl) then
    begin
      tmpCreation := Windows.CREATE_NEW;
    end;
  end;
  AWinFile.FileHandle := Windows.CreateFile(PChar(AFileUrl),
          Windows.GENERIC_ALL,
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
    if Windows.CloseHandle(AWinFile.FileHandle) then
    begin
      AWinFile.FileHandle := 0;
    end;
  end;
end;


function WinFileExistsLockedOrShared(const AFilename: Ansistring): Boolean;
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
  
function WinFileExists(const AFileName: AnsiString): Boolean;
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
      Result := WinFileExistsLockedOrShared(AFileName);
    end;
  end else
  begin
    Result := (FILE_ATTRIBUTE_DIRECTORY and tmpCode = 0)
  end;
end;

procedure UpdateWinFileSize(AWinFile: PWinFile; const Value: integer);
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

function WinFileMapOpen(AWinFile: PWinFile): Boolean;
begin
  AWinFile.FileMapHandle := Windows.CreateFileMapping(AWinFile.FileHandle, nil, Windows.PAGE_READWRITE, 0, 0, nil);
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

procedure WinFileMapClose(AWinFile: PWinFile);
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

end.
