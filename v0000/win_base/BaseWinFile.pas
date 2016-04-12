unit BaseWinFile;

interface

uses
  Windows,
  Types,
  Sysutils,
  BaseFile;

type
  TWinFileData = record
    FileHandle: THandle;
    FileMapHandle: THandle;
    FileMapRootView: Pointer;
    FileSizeLow: DWORD;
  end;

  TWinFile = class(TBaseFile)
  protected
    fWinFileData: TWinFileData;
    function GetFileSize: DWORD; override;
    procedure SetFileSize(const Value: DWORD); override;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function OpenFile(AFileUrl: string; AForceOpen: Boolean): Boolean; override;
    procedure CloseFile; override;
    function OpenFileMap: Pointer;
    procedure CloseFileMap;

    procedure ReadTest();
    procedure WriteTest();

    property FileHandle: THandle read fWinFileData.FileHandle;
  end;

implementation

{ TWinFile }
constructor TWinFile.Create;
begin
  FillChar(fWinFileData, SizeOf(fWinFileData), 0);
end;

destructor TWinFile.Destroy;
begin
  inherited;
end;

function TWinFile.OpenFile(AFileUrl: string; AForceOpen: Boolean): Boolean;
var
  tmpFlags: DWORD;
  tmpCreation: DWORD;
begin
  tmpFlags := Windows.FILE_ATTRIBUTE_NORMAL;
  tmpCreation := Windows.OPEN_EXISTING;
  if AForceOpen then
  begin
    if not FileExists(AFileUrl) then
    begin
      tmpCreation := Windows.CREATE_NEW;
    end;
  end;
  fWinFileData.FileHandle := Windows.CreateFile(PChar(AFileUrl),
          Windows.GENERIC_ALL,
          Windows.FILE_SHARE_READ or
          Windows.FILE_SHARE_WRITE or
          Windows.FILE_SHARE_DELETE,
        nil,
        tmpCreation,
        tmpFlags, 0);
  Result := (fWinFileData.FileHandle <> 0) and (fWinFileData.FileHandle <> Windows.INVALID_HANDLE_VALUE);
  if Result then
  begin
    fWinFileData.FileSizeLow := Windows.GetFileSize(fWinFileData.FileHandle, nil);
  end;
end;

procedure TWinFile.CloseFile;
begin
  CloseFileMap;
  if (0 <> fWinFileData.FileHandle) and (INVALID_HANDLE_VALUE <> fWinFileData.FileHandle) then
  begin
    if Windows.CloseHandle(fWinFileData.FileHandle) then
    begin
      fWinFileData.FileHandle := 0;
    end;
  end;
  inherited;
end;

function TWinFile.OpenFileMap: Pointer;
begin
  fWinFileData.FileMapHandle := Windows.CreateFileMapping(fWinFileData.FileHandle, nil, Windows.PAGE_READWRITE, 0, 0, nil);
  if fWinFileData.FileMapHandle <> 0 then
  begin
     // OpenFileMapping
    fWinFileData.FileMapRootView := Windows.MapViewOfFile(fWinFileData.FileMapHandle, Windows.FILE_MAP_ALL_ACCESS, 0, 0, 0);
//    fWinFileData.FileMapRootView := MapViewOfFileEx(
//      fWinFileData.FileMapHandle, //hFileMappingObject: THandle;
//      Windows.FILE_MAP_ALL_ACCESS, //dwDesiredAccess,
//      0, //dwFileOffsetHigh,
//      0, //dwFileOffsetLow,
//      0, //dwNumberOfBytesToMap: DWORD;
//      nil //lpBaseAddress: Pointer
//      );
  end;
  Result := fWinFileData.FileMapRootView;
end;

procedure TWinFile.CloseFileMap;
begin
  if nil <> fWinFileData.FileMapRootView then
  begin
    UnMapViewOfFile(fWinFileData.FileMapRootView);
    fWinFileData.FileMapRootView := nil;
  end;
  if 0 <> fWinFileData.FileMapHandle then
  begin
    Windows.CloseHandle(fWinFileData.FileMapHandle);
    fWinFileData.FileMapHandle := 0;
  end;
end;

procedure TWinFile.SetFileSize(const Value: DWORD);
begin
  if fWinFileData.FileSizeLow <> Value then
  begin
    if 0 < Value then
    begin
      Windows.SetFilePointer(fWinFileData.FileHandle, Value, nil, FILE_BEGIN);
      Windows.SetEndOfFile(fWinFileData.FileHandle);
      Windows.SetFilePointer(fWinFileData.FileHandle, 0, nil, FILE_BEGIN);
      fWinFileData.FileSizeLow := Value;
    end;
  end;
end;

function TWinFile.GetFileSize: DWORD;
begin
  Result := fWinFileData.FileSizeLow;
end;

procedure Proc_ReadCompletion(); stdcall;
begin

end;

procedure Proc_WriteCompletion(); stdcall;
begin

end;

procedure TWinFile.ReadTest();
var
  tmpBytesRead: Cardinal;
  tmpBytesReaded: Cardinal;
  tmpOverlap: TOverlapped;
  tmpError: DWORD;
  tmpReadedBuffer: array[0..4 * 1024 - 1] of AnsiChar;
begin
  tmpBytesRead := 0;
  tmpBytesReaded := 0;
  if Windows.ReadFile(fWinFileData.FileHandle, tmpReadedBuffer, tmpBytesRead, tmpBytesReaded, @tmpOverlap) then
  begin

  end else
  begin
    tmpError := Windows.GetLastError();
    case tmpError of
      ERROR_HANDLE_EOF: begin      
      end;
      ERROR_IO_PENDING: begin
        if Windows.GetOverlappedResult(fWinFileData.FileHandle, tmpOverlap, tmpBytesReaded, false) then
        begin

        end else
        begin
        
        end;
      end;
    end;
  end;
  // ReadFileEx 与 ReadFile相似
  // 只是它只能用于异步读操作，并包含了一个完整的回调
  if Windows.ReadFileEx(fWinFileData.FileHandle, @tmpReadedBuffer, tmpBytesRead, @tmpOverlap, @Proc_ReadCompletion) then
  begin

  end;
end;

procedure TWinFile.WriteTest();     
var
  tmpBytesWrite: Cardinal;
  tmpBytesWritten: Cardinal;
  tmpOverlap: TOverlapped;
  tmpWriteBuffer: array[0..4 * 1024 - 1] of AnsiChar;
begin
  tmpBytesWrite := 0;
  if Windows.WriteFile(fWinFileData.FileHandle, tmpWriteBuffer, tmpBytesWrite, tmpBytesWritten, @tmpOverlap) then
  begin              
  end;
  if Windows.WriteFileEx(fWinFileData.FileHandle, @tmpWriteBuffer, tmpBytesWrite, tmpOverlap, @Proc_WriteCompletion) then
  begin              
  end;  
end;

end.
