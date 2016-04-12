unit UtilsNet_Socket;

interface

uses
  UtilsHttp, win.iobuffer, xlClientSocket, xlNetwork, xlTcpClient;
  
  function NetClientSendBuf(ANetClient: PxlTcpClient; ABuf: Pointer; ABufSize: Integer; var ASendCount:Integer): Boolean;
  function NetClientRecvBuf(ATcpClient: PxlTcpClient; AHttpBuffer: PIOBuffer; AReadTimeOut:Integer): Integer; //单位 秒

implementation

uses
  Classes, Sysutils, Winsock2, Windows;
                        
function NetClientSendBuf(ANetClient: PxlTcpClient; ABuf: Pointer; ABufSize: Integer; var ASendCount:Integer): Boolean;  
const
  SF_SOCKET_BUFF_SIZE = 1024 * 32;
  INT_BUF_SIZE = SF_SOCKET_BUFF_SIZE;
  
var
  P: PAnsiChar;
  tmpLen: Integer;
  iRet: Integer;
begin
  Result := false;
  P := ABuf;
  //FErrorCode := 0;
  //gLock();
  ASendCount := 0;
  //gUnLock();
  //\\
  while (ABufSize > 0) do
  begin
    if ABufSize > INT_BUF_SIZE then
      tmpLen := INT_BUF_SIZE
    else
      tmpLen := ABufSize;
    //iRet :=  Winsock2.Send(Socket,P^,Len,0);
    //iRet := Inner_Send(P^, Len);
    iRet := Winsock2.Send(ANetClient.Base.ConnectSocketHandle, P^, tmpLen, 0);
    if iRet > 0 then
    begin
      //if UserCancelled then
      //begin
        //FErrorCode := ERROR_CANCELLED;
        //raise Exception.Create('Inner_send,User_Abort');
      //end;
      //gLock();
      //Inc(FSendCount, iRet);
      //gUnLock();  
      Result := true;
    end;

    if WinSock2.SOCKET_ERROR = iRet then
    begin
      ANetClient.Base.LastErrorCode := Winsock2.WSAGetLastError();
      // http://my.oschina.net/limodou/blog/142430
      // http://bbs.csdn.net/topics/390786814
      // 10053  后台服务器抛出异常，说前端主动断开
      // 
      //raise Exception.CreateFmt('SendBuf ErrorCode = %d',[FErrorCode]);
      Break;
    end;
    //gLock();
    Inc(ASendCount, iRet);
    //gUnLock();
    Inc(P, iRet);
    Dec(ABufSize, iRet);
  end;
end;

function NetClientRecvBuf(ATcpClient: PxlTcpClient; AHttpBuffer: PIOBuffer; AReadTimeOut:Integer): Integer; //单位 秒
const
  eof:AnsiString = #13#10#13#10;
var
  iRet: Integer;
  tmpReadedBytes: Integer;
  tmpReadBufSize: integer;   
  tmpReadBufPos: integer;
  tmpReadExNode: PIOBufferExNode;
begin
  Result := -1;

  if AReadTimeOut > 0 then
    TcpClientSetReadTimeOut(ATcpClient, AReadTimeOut)
  else
    TcpClientSetReadTimeOut(ATcpClient, ATcpClient.Base.TimeOutRead); //设置读超时

  tmpReadedBytes := 1;
  tmpReadBufSize := AHttpBuffer.BufferHead.Size;
  tmpReadBufPos := 0;
  tmpReadExNode := nil;
  while (0 < tmpReadedBytes) do
  begin
    if nil <> tmpReadExNode then
    begin
      iRet := WinSock2.recv(ATcpClient.Base.ConnectSocketHandle, tmpReadExNode.Data[tmpReadBufPos], tmpReadBufSize, 0);
    end else
    begin
      iRet := WinSock2.recv(ATcpClient.Base.ConnectSocketHandle, AHttpBuffer.Data[tmpReadBufPos], tmpReadBufSize, 0);
    end;
    if iRet > 0 then
    begin
      AHttpBuffer.BufferHead.TotalLength := AHttpBuffer.BufferHead.TotalLength + iRet;
      tmpReadedBytes := iRet;
      tmpReadBufSize := tmpReadBufSize - tmpReadedBytes;
      if nil = tmpReadExNode then
      begin
        AHttpBuffer.BufferHead.BufDataLength := AHttpBuffer.BufferHead.BufDataLength + iRet;
      end else
      begin
        tmpReadExNode.Length := tmpReadExNode.Length + iRet;
      end;
      if 1 > tmpReadBufSize then
      begin
        tmpReadExNode := CheckOutIOBufferExNode(AHttpBuffer);
        tmpReadBufSize := tmpReadExNode.Size;
        tmpReadBufPos := 0;
      end else
      begin
        tmpReadBufPos := tmpReadBufPos + tmpReadedBytes;
      end;
    end else
    begin           
      tmpReadedBytes := 0;
      if iRet = 0 then
      begin
        //对方已经优雅的关闭了连接
        Result := 0;
        //FErrorCode := ERROR_GRACEFUL_DISCONNECT;//对方优雅关闭
        //raise exception.Create('ReadLnII 对方已经优雅的关闭了连接');
      end else
      begin
        Result := -1;
        ATcpClient.Base.LastErrorCode := WSAGetLastError();
        {
          Socket error 10060 - Connection timed out
          要访问的网站有问题，关机了或者服务未启动等等；
          到网站的网络有问题，连接不上；
          防火墙阻挡了连接。
        }
      end;
    end;
  end;//while end
end;

end.
