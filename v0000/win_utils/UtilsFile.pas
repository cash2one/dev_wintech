unit UtilsFile;

interface

uses
  Windows, win.iobuffer;

  function GetFileIOBuffer(AFileName: AnsiString): PIOBuffer; 

implementation

uses
  Sysutils;
              
procedure LoadFile2IOBuffer(AIOBuffer: PIOBuffer; AFileName: AnsiString); overload;
var   
  tmpFileHandle: THandle;
begin
  tmpFileHandle := Windows.CreateFileA(PAnsiChar(AFileName),
          Windows.GENERIC_ALL,         // GENERIC_READ
          Windows.FILE_SHARE_READ or
          Windows.FILE_SHARE_WRITE or
          Windows.FILE_SHARE_DELETE,
        nil,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL, 0);
  if (0 <> tmpFileHandle) and (INVALID_HANDLE_VALUE <> tmpFileHandle) then
  begin       
    try

    finally
      Windows.CloseHandle(tmpFileHandle);
    end;
  end;
end;
         
procedure LoadFile2IOBuffer(AIOBuffer: PIOBuffer; AFileHandle: THandle; ASize: integer); overload;
var
  tmpBytesRead: DWORD;
  tmpBytesReaded: DWORD;
begin
  tmpBytesRead := ASize;
  tmpBytesReaded := 0;
  if Windows.ReadFile(
    AFileHandle, //hFile: THandle;
    AIOBuffer.Data[0], // const Buffer;
    tmpBytesRead, //nNumberOfBytesToWrite: DWORD;
    tmpBytesReaded, //var lpNumberOfBytesWritten: DWORD;
    nil {lpOverlapped: POverlapped}) then
  begin
      
  end;
end;

function GetFileIOBuffer(AFileName: AnsiString): PIOBuffer;
var
  tmpSize: integer;
  tmpFileHandle: THandle;
begin
  Result := nil;
  tmpFileHandle := Windows.CreateFileA(PAnsiChar(AFileName),
          Windows.GENERIC_ALL,         // GENERIC_READ
          Windows.FILE_SHARE_READ or
          Windows.FILE_SHARE_WRITE or
          Windows.FILE_SHARE_DELETE,
        nil,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL, 0); 
  if (0 <> tmpFileHandle) and (INVALID_HANDLE_VALUE <> tmpFileHandle) then
  begin       
    try
      tmpSize := Windows.GetFileSize(tmpFileHandle, nil);
      Result := CheckOutIOBuffer(GetSizeMode(tmpSize));
      if nil <> Result then
      begin
        LoadFile2IOBuffer(Result, tmpFileHandle, tmpSize);
      end;
    finally
      Windows.CloseHandle(tmpFileHandle);
    end;
  end;
end;

end.
