unit NetDataBuffer;

interface

uses
  BaseDataIO, DataChain;
                          
  function CheckOutDataBuffer(ABufferChainPool: PChainPool): PDataBuffer;
  procedure CheckInDataBuffer(ABufferChainPool: PChainPool; var ABuffer: PDataBuffer);
                                
var
  DataBufferChain: TChainPool;
                 
implementation
                     
function CheckOutDataBuffer(ABufferChainPool: PChainPool): PDataBuffer;
var
  tmpNode: PChainNode;
begin
  Result := nil;
  tmpNode := CheckOutPoolChainNode(ABufferChainPool);
  if nil <> tmpNode then
  begin
    Result := tmpNode.NodePointer;
    if nil = Result then
    begin
      Result := System.New(PDataBuffer);
      FillChar(Result^, SizeOf(TDataBuffer), 0);
      tmpNode.NodePointer := Result;
      Result.BufferHead.ChainNode := tmpNode;
    end;
  end;
end;

procedure CheckInDataBuffer(ABufferChainPool: PChainPool; var ABuffer: PDataBuffer);
begin
  if nil = ABuffer then
    exit;
  if nil = ABufferChainPool then
    exit;
  CheckInPoolChainNode(ABufferChainPool, ABuffer.BufferHead.ChainNode);
end;

procedure InitDataBuffer;
begin
  FillChar(DataBufferChain, SizeOf(DataBufferChain), 0);
  InitializeChainPool(@DataBufferChain);
end;

initialization
  InitDataBuffer;

end.
