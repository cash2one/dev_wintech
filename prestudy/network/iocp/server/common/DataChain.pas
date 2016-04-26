unit DataChain;

interface

uses
  Windows;
  
type           
  PChainNode            = ^TChainNode;   
  PChainNodes           = ^TChainNodes;
  PChain                = ^TChain;      
  PLockChain            = ^TLockChain;
  
  TChainNode            = packed record
    PrevSibling         : PChainNode;
    NextSibling         : PChainNode;
    NodePointer         : Pointer;
  end;

  TChainNodes           = packed record        
    PrevSibling         : PChainNodes;
    NextSibling         : PChainNodes;
    Nodes               : array[0..255] of TChainNode;
  end;

  TChain                = record
    NodeCount           : integer;
    FirstNode           : PChainNode;
    LastNode            : PChainNode;      
    FirstNodes          : PChainNodes;
    LastNodes           : PChainNodes;
  end;

  TLockChain            = record
    InitStatus          : Integer;
    Lock                : TRTLCriticalSection;
    Chain               : TChain;
  end;
  
  PChainPool            = ^TChainPool;
  TChainPool            = packed record        
    InitStatus          : Integer;
    Lock                : TRTLCriticalSection;
    UsedChain           : TChain;
    UnUsedChain         : TChain;
  end;
            
  procedure InitializeChainNodes(AChainNodes: PChainNodes);

  procedure AddChainNode(AChain: PChain; AChainNode: PChainNode);
  procedure DeleteChainNode(AChain: PChain; AChainNode: PChainNode);
                                              
  function CheckOutLockChain: PLockChain;
  procedure CheckInLockChain(var ALockChain: PLockChain);  
  procedure InitializeLockChain(ALockChain: PLockChain);
  procedure AddLockChainNode(ALockChain: PLockChain; AChainNode: PChainNode);
  procedure DeleteLockChainNode(ALockChain: PLockChain; AChainNode: PChainNode);

  function CheckOutChainPool: PChainPool;
  procedure CheckInChainPool(var AChainPool: PChainPool);
  procedure InitializeChainPool(AChainPool: PChainPool);

  function CheckOutPoolChainNode(AChainPool: PChainPool): PChainNode;
  procedure CheckInPoolChainNode(AChainPool: PChainPool; AChainNode: PChainNode);
  
implementation
                
procedure InternalAddChainNode(AChain: PChain; AChainNode: PChainNode);
begin
  if nil = AChain then
    exit;
  if nil = AChainNode then
    exit;
  AChain.NodeCount := AChain.NodeCount + 1;
  if nil = AChain.FirstNode then
    AChain.FirstNode := AChainNode;
  if nil <> AChain.LastNode then
  begin
    AChainNode.PrevSibling := AChain.LastNode;
    AChain.LastNode.NextSibling := AChainNode;
  end;
  AChain.LastNode := AChainNode;
end;
            
procedure InternalDeleteChainNode(AChain: PChain; AChainNode: PChainNode);
begin    
  if nil = AChain then
    exit;
  if nil = AChainNode then
    exit;
  AChain.NodeCount := AChain.NodeCount - 1;
  if nil = AChainNode.PrevSibling then
  begin
    AChain.FirstNode := AChainNode.NextSibling;
  end else
  begin
    AChainNode.PrevSibling.NextSibling := AChainNode.NextSibling;
  end;
  if nil = AChainNode.NextSibling then
  begin
    AChain.LastNode := AChainNode.PrevSibling;
  end else
  begin
    AChainNode.NextSibling.PrevSibling := AChainNode.PrevSibling;
  end;
  AChainNode.PrevSibling := nil;
  AChainNode.NextSibling := nil;
end;
                 
function CheckOutPoolChainNode(AChainPool: PChainPool): PChainNode;
begin             
  EnterCriticalSection(AChainPool.Lock);
  try
    Result := AChainPool.UnUsedChain.FirstNode;
    if nil <> Result then
    begin
      InternalDeleteChainNode(@AChainPool.UnUsedChain, Result);
    end;
    if nil = Result then
    begin
      Result := System.New(PChainNode);
      FillChar(Result^, SizeOf(TChainNode), 0);
    end;
    AddChainNode(@AChainPool.UsedChain, Result);
  finally
    LeaveCriticalSection(AChainPool.Lock);
  end;
end;
           
procedure CheckInPoolChainNode(AChainPool: PChainPool; AChainNode: PChainNode);
begin
  if nil = AChainNode then
    exit;
  if nil = AChainPool then
    exit;
  EnterCriticalSection(AChainPool.Lock);
  try
    InternalDeleteChainNode(@AChainPool.UsedChain, AChainNode);
    InternalAddChainNode(@AChainPool.UnUsedChain, AChainNode);
  finally
    LeaveCriticalSection(AChainPool.Lock);
  end;
end;

procedure AddChainNode(AChain: PChain; AChainNode: PChainNode);
begin
  InternalAddChainNode(AChain, AChainNode);
end;

procedure DeleteChainNode(AChain: PChain; AChainNode: PChainNode);
begin
  InternalDeleteChainNode(AChain, AChainNode);
end;

procedure AddLockChainNode(ALockChain: PLockChain; AChainNode: PChainNode);
begin
  EnterCriticalSection(ALockChain.Lock);
  try
    InternalAddChainNode(@ALockChain.Chain, AChainNode);
  finally
    LeaveCriticalSection(ALockChain.Lock);
  end;
end;

procedure DeleteLockChainNode(ALockChain: PLockChain; AChainNode: PChainNode);
begin
  EnterCriticalSection(ALockChain.Lock);
  try
    InternalDeleteChainNode(@ALockChain.Chain, AChainNode);
  finally
    LeaveCriticalSection(ALockChain.Lock);
  end;
end;

procedure AddChainNodes(AChain: PChain; AChainNodes: PChainNodes);
begin
  if nil = AChainNodes then
    exit;
  if nil = AChain.FirstNodes then
    AChain.FirstNodes := AChainNodes;
  if nil <> AChain.LastNodes then
  begin
    AChainNodes.PrevSibling := AChain.LastNodes;
    AChain.LastNodes.NextSibling := AChainNodes;
  end;
  AChain.LastNodes := AChainNodes;
end;
       
procedure DeleteChainNodes(AChain: PChain; AChainNodes: PChainNodes);
begin
  if nil = AChainNodes.PrevSibling then
  begin
    AChain.FirstNodes := AChainNodes.NextSibling;
  end else
  begin
    AChainNodes.PrevSibling.NextSibling := AChainNodes.NextSibling;
  end;
  if nil = AChainNodes.NextSibling then
  begin
    AChain.LastNodes := AChainNodes.PrevSibling;
  end else
  begin
    AChainNodes.NextSibling.PrevSibling := AChainNodes.PrevSibling;
  end;
  AChainNodes.PrevSibling := nil;
  AChainNodes.NextSibling := nil;
end;
         
procedure InitializeChainNodes(AChainNodes: PChainNodes);
var
  i: integer;
begin
  for i := Low(AChainNodes.Nodes) to High(AChainNodes.Nodes) do
  begin
    if i < High(AChainNodes.Nodes) then
    begin
      AChainNodes.Nodes[i].NextSibling := @AChainNodes.Nodes[i + 1];
      AChainNodes.Nodes[i + 1].PrevSibling := @AChainNodes.Nodes[i];
    end;
  end;
end;

function CheckOutChainPool: PChainPool;
begin
  Result := System.New(PChainPool);
  FillChar(Result^, SizeOf(TChainPool), 0);
  InitializeChainPool(Result);
end;

procedure InitializeChainPool(AChainPool: PChainPool);
begin
  if 0 = AChainPool.InitStatus then
  begin
    Windows.InitializeCriticalSection(AChainPool.Lock);
    AChainPool.InitStatus := 1;
  end;
end;

procedure CheckInChainPool(var AChainPool: PChainPool);
begin
  if nil = AChainPool then
    exit;
  Windows.DeleteCriticalSection(AChainPool.Lock);
  AChainPool.InitStatus := 0;  
end;
           
function CheckOutLockChain: PLockChain;
begin
  Result := System.New(PLockChain);
  FillChar(Result^, SizeOf(TLockChain), 0);
  InitializeLockChain(Result);
end;

procedure CheckInLockChain(var ALockChain: PLockChain);
begin
  if nil = ALockChain then
    exit;
  Windows.DeleteCriticalSection(ALockChain.Lock);
  ALockChain.InitStatus := 0;  
end;

procedure InitializeLockChain(ALockChain: PLockChain);
begin
  if 0 = ALockChain.InitStatus then
  begin
    Windows.InitializeCriticalSection(ALockChain.Lock);
    ALockChain.InitStatus := 1;
  end;
end;

end.
