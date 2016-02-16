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
    
implementation

function GetMemoryNode(AThread: PSysThread; ASize: Integer): PMemoryNode;
begin
  Result := nil;
end;

function GetMemory(AThread: PSysThread; ASize: Integer): Pointer;
begin
  GetMem(Result, ASize);
end;

end.
