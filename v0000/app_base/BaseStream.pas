unit BaseStream;

interface

uses
  Sysutils;
  
const
{ Maximum TList size }
  MaxListSize = Maxint div 16;

{ TStream seek origins }
  soFromBeginning = 0;
  soFromCurrent = 1;
  soFromEnd = 2;
               
type                     
  TNotifyEvent = procedure(Sender: TObject) of object;
  
{ TStream seek origins }
  TSeekOrigin = (soBeginning, soCurrent, soEnd);

type                         
  EStreamError = class(Exception);
  EFilerError = class(EStreamError);
  EReadError = class(EFilerError);    
  EWriteError = class(EFilerError); 
  EInvalidImage = class(EFilerError);
  
{ TStream abstract class }
  TStream = class(TObject)
  private
    function GetPosition: Int64;
    procedure SetPosition(const Pos: Int64);
    procedure SetSize64(const NewSize: Int64);
  protected
    function GetSize: Int64; virtual;
    procedure SetSize(NewSize: Longint); overload; virtual;
    procedure SetSize(const NewSize: Int64); overload; virtual;
  public
    function Read(var Buffer; Count: Longint): Longint; virtual; abstract;
    function Write(const Buffer; Count: Longint): Longint; virtual; abstract;
    function Seek(Offset: Longint; Origin: Word): Longint; overload; virtual;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; overload; virtual;
    procedure ReadBuffer(var Buffer; Count: Longint);
    procedure WriteBuffer(const Buffer; Count: Longint);
    function CopyFrom(Source: TStream; Count: Int64): Int64;
    //function ReadComponent(Instance: TComponent): TComponent;
    //function ReadComponentRes(Instance: TComponent): TComponent;
    //procedure WriteComponent(Instance: TComponent);
    //procedure WriteComponentRes(const ResName: string; Instance: TComponent);
    //procedure WriteDescendent(Instance, Ancestor: TComponent);
    //procedure WriteDescendentRes(const ResName: string; Instance, Ancestor: TComponent);
    procedure WriteResourceHeader(const ResName: string; out FixupInfo: Integer);
    procedure FixupResourceHeader(FixupInfo: Integer);
    procedure ReadResHeader;
    property Position: Int64 read GetPosition write SetPosition;
    property Size: Int64 read GetSize write SetSize64;
  end;

implementation

uses
  SysConst,
  RTLConsts;
  
{ TStream }

function TStream.GetPosition: Int64;
begin
  Result := Seek(0, soCurrent);
end;

procedure TStream.SetPosition(const Pos: Int64);
begin
  Seek(Pos, soBeginning);
end;

function TStream.GetSize: Int64;
var
  Pos: Int64;
begin
  Pos := Seek(0, soCurrent);
  Result := Seek(0, soEnd);
  Seek(Pos, soBeginning);
end;

procedure TStream.SetSize(NewSize: Longint);
begin
  // default = do nothing  (read-only streams, etc)
  // descendents should implement this method to call the Int64 sibling
end;

procedure TStream.SetSize64(const NewSize: Int64);
begin
  SetSize(NewSize);
end;

procedure TStream.SetSize(const NewSize: Int64);
begin
{ For compatibility with old stream implementations, this new 64 bit SetSize
  calls the old 32 bit SetSize.  Descendent classes that override this
  64 bit SetSize MUST NOT call inherited. Descendent classes that implement
  64 bit SetSize should reimplement their 32 bit SetSize to call their 64 bit
  version.}
  if (NewSize < Low(Longint)) or (NewSize > High(Longint)) then
  begin
    raise ERangeError.CreateRes(@SRangeError);
  end;
  SetSize(Longint(NewSize));
end;

function TStream.Seek(Offset: Longint; Origin: Word): Longint;

  procedure RaiseException;
  begin
    raise EStreamError.CreateResFmt(@sSeekNotImplemented, [Classname]);
  end;

type
  TSeek64 = function (const Offset: Int64; Origin: TSeekOrigin): Int64 of object;
var
  Impl: TSeek64;
  Base: TSeek64;
  ClassTStream: TClass;
begin
{ Deflect 32 seek requests to the 64 bit seek, if 64 bit is implemented.
  No existing TStream classes should call this method, since it was originally
  abstract.  Descendent classes MUST implement at least one of either
  the 32 bit or the 64 bit version, and must not call the inherited
  default implementation. }
  Impl := Seek;
  ClassTStream := Self.ClassType;
  while (ClassTStream <> nil) and (ClassTStream <> TStream) do
    ClassTStream := ClassTStream.ClassParent;
  if ClassTStream = nil then RaiseException;
  Base := TStream(@ClassTStream).Seek;
  if TMethod(Impl).Code = TMethod(Base).Code then
    RaiseException;
  Result := Seek(Int64(Offset), TSeekOrigin(Origin));
end;

function TStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
{ Default implementation of 64 bit seek is to deflect to existing 32 bit seek.
  Descendents that override 64 bit seek must not call this default implementation. }
  if (Offset < Low(Longint)) or (Offset > High(Longint)) then
    raise ERangeError.CreateRes(@SRangeError);
  Result := Seek(Longint(Offset), Ord(Origin));
end;

procedure TStream.ReadBuffer(var Buffer; Count: Longint);
begin
  if (Count <> 0) and (Read(Buffer, Count) <> Count) then
    raise EReadError.CreateRes(@SReadError);
end;

procedure TStream.WriteBuffer(const Buffer; Count: Longint);
begin
  if (Count <> 0) and (Write(Buffer, Count) <> Count) then
    raise EWriteError.CreateRes(@SWriteError);
end;

function TStream.CopyFrom(Source: TStream; Count: Int64): Int64;
const
  MaxBufSize = $F000;
var
  BufSize, N: Integer;
  Buffer: PChar;
begin
  if Count = 0 then
  begin
    Source.Position := 0;
    Count := Source.Size;
  end;
  Result := Count;
  if Count > MaxBufSize then BufSize := MaxBufSize else BufSize := Count;
  GetMem(Buffer, BufSize);
  try
    while Count <> 0 do
    begin
      if Count > BufSize then N := BufSize else N := Count;
      Source.ReadBuffer(Buffer^, N);
      WriteBuffer(Buffer^, N);
      Dec(Count, N);
    end;
  finally
    FreeMem(Buffer, BufSize);
  end;
end;

(*//
function TStream.ReadComponent(Instance: TComponent): TComponent;
var
  Reader: TReader;
begin
  Reader := TReader.Create(Self, 4096);
  try
    Result := Reader.ReadRootComponent(Instance);
  finally
    Reader.Free;
  end;
end;

procedure TStream.WriteComponent(Instance: TComponent);
begin
  WriteDescendent(Instance, nil);
end;

procedure TStream.WriteDescendent(Instance, Ancestor: TComponent);
var
  Writer: TWriter;
begin
  Writer := TWriter.Create(Self, 4096);
  try
    Writer.WriteDescendent(Instance, Ancestor);
  finally
    Writer.Free;
  end;
end;

function TStream.ReadComponentRes(Instance: TComponent): TComponent;
begin
  ReadResHeader;
  Result := ReadComponent(Instance);
end;

procedure TStream.WriteComponentRes(const ResName: string; Instance: TComponent);
begin
  WriteDescendentRes(ResName, Instance, nil);
end;
//*)
procedure TStream.WriteResourceHeader(const ResName: string; out FixupInfo: Integer);
var
  HeaderSize: Integer;
  Header: array[0..79] of Char;
begin
  Byte((@Header[0])^) := $FF;
  Word((@Header[1])^) := 10;
  HeaderSize := StrLen(StrUpper(StrPLCopy(@Header[3], ResName, 63))) + 10;
  Word((@Header[HeaderSize - 6])^) := $1030;
  Longint((@Header[HeaderSize - 4])^) := 0;
  WriteBuffer(Header, HeaderSize);
  FixupInfo := Position;
end;

procedure TStream.FixupResourceHeader(FixupInfo: Integer);
var
  ImageSize: Integer;
begin
  ImageSize := Position - FixupInfo;
  Position := FixupInfo - 4;
  WriteBuffer(ImageSize, SizeOf(Longint));
  Position := FixupInfo + ImageSize;
end;
(*//
procedure TStream.WriteDescendentRes(const ResName: string; Instance,
  Ancestor: TComponent);
var
  FixupInfo: Integer;
begin
  WriteResourceHeader(ResName, FixupInfo);
  WriteDescendent(Instance, Ancestor);
  FixupResourceHeader(FixupInfo);
end;
//*)
procedure TStream.ReadResHeader;
var
  ReadCount: Cardinal;
  Header: array[0..79] of Char;
begin
  FillChar(Header, SizeOf(Header), 0);
  ReadCount := Read(Header, SizeOf(Header) - 1);
  if (Byte((@Header[0])^) = $FF) and (Word((@Header[1])^) = 10) then
    Seek(StrLen(Header + 3) + 10 - ReadCount, 1)
  else
    raise EInvalidImage.CreateRes(@SInvalidImage);
end;

end.
