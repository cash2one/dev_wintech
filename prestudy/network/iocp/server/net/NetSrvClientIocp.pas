unit NetSrvClientIocp;

interface

uses
  Windows, WinSock2,
  DataChain, NetBaseObj, BaseDataIO;
  
type       
  {* 完成端口操作定义 *}
  TIocpOperate = (ioNone, ioExit, ioSockRead, ioSockWrite, ioHandle, ioStream);
                                 
  PNetClientConnectIOCP  = ^TNetClientConnectIOCP;

  PNetIocpBuffer      = ^TNetIocpBuffer;
  TNetIocpBuffer      = packed record
    Overlapped        : TOverlapped;   //完成端口重叠结构
    WsaBuf            : TWsaBuf;           //完成端口的缓冲区定义
    IocpOperate       : TIocpOperate; //当前操作类型
    ClientConnect     : PNetClientConnectIOCP;                 
    DataBuffer        : BaseDataIO.TDataBuffer;
  end;

  TNetClientConnectIOCP  = packed record
    BaseConnect       : TNetClientConnect;
    //DataIO              : TDataIO; ???
  end;
         
  function CheckOutClientConnectionIocp(AServer: PNetServer): PNetClientConnectIOCP;       
  procedure CheckInClientConnectionIocp(const AClientConnection: PNetClientConnectIOCP);
                                     
  function CheckOutIocpBuffer(): PNetIocpBuffer;
  procedure CheckInIocpBuffer(const ABufferIocp: PNetIocpBuffer);

  procedure ReadIocpDataIn(AClientConnect: PNetClientConnectIOCP; AIocpBuffer: PNetIocpBuffer);
  procedure SendIocpDataOut(AClient: PNetClientConnect; ADataBuffer: PDataBuffer);
     
  function CheckOutIocpDataOutBuffer(AClient: PNetClientConnect): PDataBuffer;

var
  IocpClientConnectPool: TChainPool;    
  IocpBufferChainPool: TChainPool;         
                         
  GNetIocpBufferCounter: integer = 0;
  GNetIocpClientConnectCounter: integer = 0;
  
implementation

function CheckOutClientConnectionIocp(AServer: PNetServer): PNetClientConnectIOCP;
var
  tmpNode: PChainNode;
begin
  Result := nil;
  tmpNode := CheckOutPoolChainNode(@IocpClientConnectPool);
  if nil <> tmpNode then
  begin
    Result := tmpNode.NodePointer;
    if nil = Result then
    begin
      InterlockedIncrement(GNetIocpClientConnectCounter);
      Result := System.New(PNetClientConnectIOCP);  
      FillChar(Result^, SizeOf(TNetClientConnectIOCP), 0);
      tmpNode.NodePointer := Result;
      Result.BaseConnect.ChainNode := tmpNode;
    end;
  end;
  if nil <> Result then
  begin
    Result.BaseConnect.Server := AServer;
  end;
end;

procedure CheckInClientConnectionIocp(const AClientConnection: PNetClientConnectIOCP);
begin
  if nil = AClientConnection then
    exit;
  if nil <> AClientConnection.BaseConnect.Session then
  begin
    AClientConnection.BaseConnect.Server.CheckInClientSession(AClientConnection.BaseConnect.Session);
  end;
  if nil <> AClientConnection.BaseConnect.ChainNode then
  begin
    //CheckInIOCPBuffer(AClientConnection.WriteBuffer);
    CheckInPoolChainNode(@IocpClientConnectPool, AClientConnection.BaseConnect.ChainNode);
  end;
  AClientConnection.BaseConnect.Server := nil;
end;

function CheckOutIocpBuffer(): PNetIocpBuffer;
var
  tmpNode: PChainNode;
begin
  Result := nil;
  tmpNode := CheckOutPoolChainNode(@IocpBufferChainPool);
  if nil <> tmpNode then
  begin
    Result := tmpNode.NodePointer;
  end;
  if nil = Result then
  begin
    InterlockedIncrement(GNetIocpBufferCounter);
    Result := System.New(PNetIocpBuffer);
    FillChar(Result^, SizeOf(TNetIocpBuffer), 0);
    Result.DataBuffer.BufferHead.ChainNode := tmpNode;
    Result.DataBuffer.BufferHead.BufferSize := SizeOf(Result.DataBuffer.Data);
    Result.DataBuffer.BufferHead.Owner := Result;
    if nil <> tmpNode then
    begin
      tmpNode.NodePointer := Result;
    end;
  end else
  begin
    Result.DataBuffer.BufferHead.DataLength := 0;
    FillChar(Result.DataBuffer.Data, SizeOf(Result.DataBuffer.Data), 0);
  end;
end;

function CheckOutIocpDataOutBuffer(AClient: PNetClientConnect): PDataBuffer;
var    
  tmpBuffer: PNetIocpBuffer;
begin
  Result := nil;
  tmpBuffer := CheckOutIocpBuffer;
  if nil <> tmpBuffer then
  begin
    tmpBuffer.ClientConnect := PNetClientConnectIOCP(AClient);
    Result := @tmpBuffer.DataBuffer;
  end;
end;
                       
procedure CheckInIocpBuffer(const ABufferIocp: PNetIocpBuffer);
begin
  if nil = ABufferIocp then
    exit;
  ABufferIocp.IocpOperate := ioNone; 
  CheckInPoolChainNode(@IocpBufferChainPool, ABufferIocp.DataBuffer.BufferHead.ChainNode);
end;

procedure InitNetSrvClientIocp;
begin
  FillChar(IocpClientConnectPool, SizeOf(IocpClientConnectPool), 0);
  InitializeChainPool(@IocpClientConnectPool);

  FillChar(IocpBufferChainPool, SizeOf(IocpBufferChainPool), 0);
  InitializeChainPool(@IocpBufferChainPool);
end;

procedure ReadIocpDataIn(AClientConnect: PNetClientConnectIOCP; AIocpBuffer: PNetIocpBuffer);
var
  iFlags, iTransfer: Cardinal;    
  iErrCode: Integer;
begin
  if nil = AClientConnect then
    exit;
  if nil = AIocpBuffer then
    exit;
  FillChar(AIocpBuffer.Overlapped, SizeOf(AIocpBuffer.Overlapped), 0);
  AIocpBuffer.WsaBuf.buf := @AIocpBuffer.DataBuffer.Data[0];
  AIocpBuffer.WsaBuf.len := Length(AIocpBuffer.DataBuffer.Data);

  FillChar(AIocpBuffer.DataBuffer.Data, SizeOf(AIocpBuffer.DataBuffer.Data), 0);
  AIocpBuffer.IocpOperate := ioSockRead;

  AIocpBuffer.ClientConnect := AClientConnect;
  AIocpBuffer.DataBuffer.BufferHead.Owner := AIocpBuffer;
  
  iFlags := 0;
  iTransfer := 0;
  if SOCKET_ERROR = WinSock2.WSARecv(AClientConnect.BaseConnect.ClientSocketHandle,
      @AIocpBuffer.WsaBuf, 1, @iTransfer, @iFlags, @AIocpBuffer.Overlapped, nil) then
  begin
    iErrCode := WSAGetLastError;
    if iErrCode = WSAECONNRESET then //客户端被关闭
    begin

    end;
//            FConnected := False;
//          if iErrCode <> ERROR_IO_PENDING then //不抛出异常，触发异常事件
//          begin
//            FIocpServer.DoError('WSARecv', GetLastWsaErrorStr);
//            ProcessNetError(iErrCode);
//          end;
  end;
end;
             
procedure SendIocpDataOut(AClient: PNetClientConnect; ADataBuffer: PDataBuffer);
var
  iFlags: DWORD;
  iTransfer: DWORD;
  iErrCode: DWORD;
  tmpBufferCount: DWORD;
  tmpIocpBuffer: PNetIocpBuffer;
begin
  if nil = ADataBuffer then
    exit;
  tmpIocpBuffer := ADataBuffer.BufferHead.Owner;
  if nil = tmpIocpBuffer then
    exit;
  tmpIocpBuffer.ClientConnect := PNetClientConnectIOCP(AClient);
  tmpIocpBuffer.IocpOperate := ioSockWrite;
  tmpIocpBuffer.WsaBuf.len := Length(tmpIocpBuffer.DataBuffer.Data);
  tmpIocpBuffer.WsaBuf.len := 4096;
  tmpIocpBuffer.WsaBuf.len := tmpIocpBuffer.DataBuffer.BufferHead.DataLength;
  tmpIocpBuffer.WsaBuf.buf := @tmpIocpBuffer.DataBuffer.Data[0]; 
  (*//            
  iTransfer := 0;
  iFlags := 0;
  if SOCKET_ERROR = WinSock2.send(
    tmpBuffer.ClientConnect.ConnectSocketHandle,
    tmpBuffer.ClientConnect.WriteBuffer.Data,
    tmpBuffer.ClientConnect.WriteBuffer.WsaBuf.len,
    iFlags) then
  begin
    iErrCode := WSAGetLastError;
    if iErrCode = WSAECONNRESET then //客户端被关闭
    begin

    end;
  end;
  //*)
  //(*//
  tmpBufferCount := 1;  
  iTransfer := 0;
  iFlags := MSG_PARTIAL;
  iFlags := MSG_OOB;
  if SOCKET_ERROR = WinSock2.WSASend(tmpIocpBuffer.ClientConnect.BaseConnect.ClientSocketHandle,
      @tmpIocpBuffer.WsaBuf,
      tmpBufferCount,
      @iTransfer,
      iFlags,
      @tmpIocpBuffer.Overlapped, nil) then
  begin
    iErrCode := WSAGetLastError;
    if iErrCode = WSAECONNRESET then //客户端被关闭
    begin

    end;    
  end;
  //*)
end;
          
initialization
  InitNetSrvClientIocp;

end.
