unit win.iobuffer;

interface

uses
  Types;

const
  SizeMode_0      = 1;
  SizeMode_1      = 2;
  SizeMode_2      = 3;
  SizeMode_4      = 4;
  SizeMode_8      = 5;
  SizeMode_16     = 6;
  SizeMode_32     = 7;
  SizeMode_64     = 8;
  SizeMode_128    = 9;
  SizeMode_256    = 10;
  SizeMode_512    = 11;
  SizeMode_1k     = 12;
  SizeMode_2k     = 13;
  SizeMode_4k     = 14;
  SizeMode_8k     = 15;
  SizeMode_16k    = 16;
  SizeMode_32k    = 17;
  SizeMode_64k    = 18;
  SizeMode_128k   = 19;
  SizeMode_256k   = 20;
  SizeMode_512k   = 21;
  SizeMode_1m     = 22;
  SizeMode_2m     = 23;
  SizeMode_4m     = 24;
  SizeMode_8m     = 25;
  SizeMode_16m    = 26;
  SizeMode_32m    = 27;
  SizeMode_64m    = 28;
  SizeMode_128m   = 29;
  SizeMode_256m   = 30;
  SizeMode_512m   = 31;
  SizeMode_1g     = 32;
  SizeMode_2g     = 33;
  SizeMode_4g     = 34;
  SizeMode_8g     = 35;
  SizeMode_16g    = 36;
  SizeMode_32g    = 37;
  SizeMode_64g    = 38;
  SizeMode_128g   = 39;
  SizeMode_256g   = 40;
  SizeMode_512g   = 41;
  SizeMode_1t     = 42;
  SizeMode_2t     = 43;
  SizeMode_4t     = 44;
  SizeMode_8t     = 45;
  SizeMode_16t    = 46;
  SizeMode_32t    = 47;
  SizeMode_64t    = 48;
  SizeMode_128t   = 39;
  SizeMode_256t   = 50;
  SizeMode_512t   = 51;
  SizeMode_1p     = 52;
  
type
  PIOBufferExNode = ^TIOBufferExNode;
          
  PIOBufferHead   = ^TIOBufferHead;
  TIOBufferHead   = record
    FirstExNode   : PIOBufferExNode;
    LastExNode    : PIOBufferExNode;
    Size          : DWORD;
    Length        : DWORD;
  end;

  PIOBuffer       = ^TIOBuffer;
  TIOBuffer       = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..0] of AnsiChar;
  end;
                                 
  PIOBuffer4k     = ^TIOBuffer4k;
  TIOBuffer4k     = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..4 * 1024 - 1] of AnsiChar;
  end;
  
  PIOBuffer8k     = ^TIOBuffer8k;
  TIOBuffer8k     = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..8 * 1024 - 1] of AnsiChar;
  end;

  PIOBuffer16k    = ^TIOBuffer16k;
  TIOBuffer16k    = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..16 * 1024 - 1] of AnsiChar;
  end;
                        
  PIOBuffer32k    = ^TIOBuffer32k;
  TIOBuffer32k    = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..32 * 1024 - 1] of AnsiChar;
  end;
                         
  PIOBuffer64k    = ^TIOBuffer32k;
  TIOBuffer64k    = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..64 * 1024 - 1] of AnsiChar;
  end;
                         
  PIOBuffer128k   = ^TIOBuffer128k;
  TIOBuffer128k   = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..128 * 1024 - 1] of AnsiChar;
  end;
          
  PIOBuffer256k   = ^TIOBuffer256k;
  TIOBuffer256k   = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..256 * 1024 - 1] of AnsiChar;
  end;
                       
  PIOBuffer512k   = ^TIOBuffer512k;
  TIOBuffer512k   = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..512 * 1024 - 1] of AnsiChar;
  end;

  PIOBuffer1m     = ^TIOBuffer1m;
  TIOBuffer1m     = record
    BufferHead    : TIOBufferHead;
    Data          : array[0..1024 * 1024 - 1] of AnsiChar;
  end;
  
  TIOBufferExNode = record
    Buffer        : PIOBufferHead;
    PrevSibling   : PIOBufferExNode;
    NextSibling   : PIOBufferExNode;
    Size          : Word;
    Length        : Word;
    Data          : array[0..16 * 1024 - 1] of AnsiChar;
  end;
                  
  function CheckOutIOBuffer(ASizeMode: Integer = SizeMode_256k): PIOBuffer;    
  procedure CheckInIOBuffer(var AIOBuffer: PIOBuffer);  
  function CheckOutIOBufferExNode(AIOBuffer: PIOBuffer): PIOBufferExNode; 
  procedure CheckInIOBufferExNode(AIOBufferExNode: PIOBufferExNode);
  
  function RepackIOBuffer(AIOBuffer: PIOBuffer): PIOBuffer;
  
  function GetSizeMode(ASize: Integer): Integer;

implementation

function CheckOutIOBuffer(ASizeMode: Integer = SizeMode_256k): PIOBuffer;
var
  tmpBuffer: PIOBuffer256k;
begin
  tmpBuffer := System.New(PIOBuffer256k);
  FillChar(tmpBuffer^, SizeOf(TIOBuffer256k), 0);
  tmpBuffer.BufferHead.Size := SizeOf(tmpBuffer.Data);
  Result := PIOBuffer(tmpBuffer);  
end;

function GetSizeMode(ASize: Integer): Integer;
var
  tmpSize: Integer;
begin
  Result := 2;
  tmpSize := 1;
  while tmpSize < ASize do
  begin
    Result := Result + 1;
    tmpSize := tmpSize + tmpSize;
  end;
end;

procedure CheckInIOBuffer(var AIOBuffer: PIOBuffer);
begin

end;

function RepackIOBuffer(AIOBuffer: PIOBuffer): PIOBuffer;
begin
  Result := CheckOutIOBuffer(GetSizeMode(AIOBuffer.BufferHead.Length));
end;

function CheckOutIOBufferExNode(AIOBuffer: PIOBuffer): PIOBufferExNode;
var
  tmpNode: PIOBufferExNode;
begin
  tmpNode := System.New(PIOBufferExNode);
  FillChar(tmpNode^, SizeOf(TIOBufferExNode), 0);
  tmpNode.Buffer := @AIOBuffer.BufferHead;
  tmpNode.Size := SizeOf(tmpNode.Data);
  if nil = AIOBuffer.BufferHead.FirstExNode then
    AIOBuffer.BufferHead.FirstExNode := tmpNode;
  if nil <> AIOBuffer.BufferHead.LastExNode then
  begin
    tmpNode.PrevSibling := AIOBuffer.BufferHead.LastExNode;
    AIOBuffer.BufferHead.LastExNode.NextSibling := tmpNode;
  end;
  AIOBuffer.BufferHead.LastExNode := tmpNode;
  Result := tmpNode;
end;

procedure CheckInIOBufferExNode(AIOBufferExNode: PIOBufferExNode);
begin
end;

end.
