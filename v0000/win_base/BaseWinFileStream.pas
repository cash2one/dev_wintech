unit BaseWinFileStream;

interface

uses
  BaseStream;
            
const
{ TFileStream create mode }
  fmCreate = $FFFF;

type              
  EFileStreamError = class(EStreamError)
    constructor Create(ResStringRec: PResStringRec; const FileName: string);
  end;
  EFCreateError = class(EFileStreamError); 
  EFOpenError = class(EFileStreamError);
  
{ THandleStream class }      
  THandleStream = class(TStream)
  protected
    FHandle: Integer;
    procedure SetSize(NewSize: Longint); override;
    procedure SetSize(const NewSize: Int64); override;
  public
    constructor Create(AHandle: Integer);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    property Handle: Integer read FHandle;
  end;

{ TFileStream class }  
  TFileStream = class(THandleStream)
  strict private
    FFileName: string;
  public
    constructor Create(const AFileName: string; Mode: Word); overload;
    constructor Create(const AFileName: string; Mode: Word; Rights: Cardinal); overload;
    destructor Destroy; override;
    property FileName: string read FFileName;
  end;
  
implementation

uses
  RTLConsts,
  Sysutils,
  Windows;

{ THandleStream }

constructor THandleStream.Create(AHandle: Integer);
begin
  inherited Create;
  FHandle := AHandle;
end;

function THandleStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := FileRead(FHandle, Buffer, Count);
  if Result = -1 then Result := 0;
end;

function THandleStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := FileWrite(FHandle, Buffer, Count);
  if Result = -1 then Result := 0;
end;

function THandleStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := FileSeek(FHandle, Offset, Ord(Origin));
end;

procedure THandleStream.SetSize(NewSize: Longint);
begin
  SetSize(Int64(NewSize));
end;

procedure THandleStream.SetSize(const NewSize: Int64);
begin
  Seek(NewSize, soBeginning);
{$IFDEF MSWINDOWS}
  Win32Check(SetEndOfFile(FHandle));
{$ELSE}
  if ftruncate(FHandle, Position) = -1 then
    raise EStreamError(sStreamSetSize);
{$ENDIF}
end;

{ TFileStream }

constructor TFileStream.Create(const AFileName: string; Mode: Word);
begin
{$IFDEF MSWINDOWS}
  Create(AFilename, Mode, 0);
{$ELSE}
  Create(AFilename, Mode, FileAccessRights);
{$ENDIF}
end;

constructor TFileStream.Create(const AFileName: string; Mode: Word; Rights: Cardinal);
begin
  if Mode = fmCreate then
  begin
    inherited Create(FileCreate(AFileName, Rights));
    if FHandle < 0 then
      raise EFCreateError.CreateResFmt(@SFCreateErrorEx, [ExpandFileName(AFileName), SysErrorMessage(GetLastError)]);
  end
  else
  begin
    inherited Create(FileOpen(AFileName, Mode));
    if FHandle < 0 then
      raise EFOpenError.CreateResFmt(@SFOpenErrorEx, [ExpandFileName(AFileName), SysErrorMessage(GetLastError)]);
  end;
  FFileName := AFileName;
end;

destructor TFileStream.Destroy;
begin
  if FHandle >= 0 then FileClose(FHandle);
  inherited Destroy;
end;

{ EFileStreamError }
constructor EFileStreamError.Create(ResStringRec: PResStringRec; const FileName: string);
begin
  inherited CreateResFmt(ResStringRec, [ExpandFileName(FileName), SysErrorMessage(GetLastError)]);
end;

end.
