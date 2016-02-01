unit BaseMemory;

interface

uses
  Types,
  BaseThread;

type
  PMemoryNode = ^TMemoryNode;
  TMemoryNode = record
    Data: Pointer;
  end;
  
  function GetMemoryNode(AThread: PSysThread; ASize: Integer): PMemoryNode;
  function GetMemory(AThread: PSysThread; ASize: Integer): Pointer;
    
  procedure CopyMemory(ADestination: Pointer; ASource: Pointer; ALength: DWORD);
  procedure ZeroMemory(ADestination: Pointer; ALength: DWORD);
               
{ An analogue of FillChar for 32 bit values }
var
  FillLongword: procedure(var X; Count: Cardinal; Value: Longword);

implementation

procedure CopyMemory(ADestination: Pointer; ASource: Pointer; ALength: DWORD);
begin
  Move(ASource^, ADestination^, ALength);
end;

procedure ZeroMemory(ADestination: Pointer; ALength: DWORD);
begin
  FillChar(ADestination^, ALength, 0);
end;

function GetMemoryNode(AThread: PSysThread; ASize: Integer): PMemoryNode;
begin
  Result := nil;
end;

function GetMemory(AThread: PSysThread; ASize: Integer): Pointer;
begin
  GetMem(Result, ASize);
end;

end.
