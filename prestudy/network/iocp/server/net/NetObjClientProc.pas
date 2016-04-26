unit NetObjClientProc;

interface

uses
  NetBaseObj;
                 
  procedure NetClientConnect(ANetClient: PNetClient; AConnectAddress: PNetServerAddress);      
  procedure NetClientDisconnect(ANetClient: PNetClient);

  procedure NetClientSetSendTimeOut(ANetClient: PNetClient; const Value: Integer);
  
  function NetCLientCheckIsConnected(ANetClient: PNetClient): Boolean;   
  procedure NetClientSendBuf(ANetClient: PNetClient; ABuf: Pointer; ABufSize: Integer; var ASendCount:Integer); 

  function NetClientRecvBuf(ANetClient: PNetClient; const ABuffer: PAnsiChar; ABufLen: Integer; ATimeOut:Integer): Integer; //单位 秒

implementation

uses
  Windows, WinSock2, NetObjClient;
  
procedure NetClientConnect(ANetClient: PNetClient; AConnectAddress: PNetServerAddress);
var
  tmpRet: DWORD;
  tmpUlong: u_long;
  //strErr:string;
  tmpSockAddr: WinSock2.TSockAddrIn;
  tmpTimeOut: TTimeVal;
  tmpFDSet: TFDSet;
begin
  //FUserCancelld := FALSE;
  if (Winsock2.INVALID_SOCKET = ANetClient.ConnectSocketHandle) or
     (0 = ANetClient.ConnectSocketHandle) then
  begin
    ANetClient.ConnectSocketHandle := Winsock2.Socket(AF_INET,SOCK_STREAM,0);
    if ANetClient.ConnectSocketHandle = INVALID_SOCKET  then
    begin
      //RaiseWSExcption();
    end;
  end;
  if nil <> AConnectAddress then
  begin
    ANetClient.ConnectAddress := AConnectAddress;
  end;
  if nil <> ANetClient.ConnectAddress then
  begin
    if '' = ANetClient.ConnectAddress.HOST then
    begin
      //raise Exception.Create('TsfSocket.Connect,HOST 为空');
    end;
    if 0 = ANetClient.ConnectAddress.Port then
    begin
      //raise Exception.Create('TsfSocket.Connect,PORT 必须大于 0');
    end;
  end;
  if ANetClient.TimeOutConnect > 0 then
  begin
    //设置非阻塞方式连接
    tmpUlong := 1;
    tmpRet := ioctlsocket(ANetClient.ConnectSocketHandle, FIONBIO, tmpUlong);
    if(tmpRet = SOCKET_ERROR) then
    begin
      tmpRet := Winsock2.WSAGetLastError();
      //strErr := GetLastErrorErrorMessage(iRet);
//      raise
//        exception.CreateFmt('Connect [1] socket error %d  %s',[iRet,strErr]);
    end;
  end;   
  ZeroMemory(@tmpSockAddr,SizeOf(tmpSockAddr));
  tmpSockAddr.sin_family      := AF_INET;
  if '' = AConnectAddress.Ip then
  begin
    AConnectAddress.Ip := ResolveIP(ANetClient.ConnectAddress.HOST);
  end;
  tmpSockAddr.sin_addr.S_addr := Winsock2.inet_addr(PAnsiChar(@AConnectAddress.Ip[1]));
  
  tmpSockAddr.sin_port        := Winsock2.htons(ANetClient.ConnectAddress.Port);
    // function connect(s: TSocket; name: PSockAddr; namelen: Integer): Integer; stdcall;
  tmpRet := Winsock2.connect(ANetClient.ConnectSocketHandle, PSockAddr(@tmpSockAddr), SizeOf(tmpSockAddr));
  if DWORD(SOCKET_ERROR) = tmpRet then
  begin
    tmpRet := Winsock2.WSAGetLastError();
    if tmpRet <> WSAEWOULDBLOCK then
    begin
      //strErr := GetLastErrorErrorMessage(iRet);
      //raise exception.CreateFmt('Connect socket [2] error %d  %s',[iRet,strErr]);
    end;
  end;
  if ANetClient.TimeOutConnect > 0 then
  begin
    //select 模型，即设置超时
    tmpTimeOut.tv_sec  := ANetClient.TimeOutConnect div 1000;
    tmpTimeOut.tv_usec := ANetClient.TimeOutConnect mod 1000;
    // ---------------------------------
    //FD_ZERO(tmpFDSet);
    tmpFDSet.fd_count := 0;
    // ---------------------------------
    //FD_SET(ANetClient.SocketHandle, tmpFDSet);        
    if tmpFDSet.fd_count < FD_SETSIZE then
    begin
      tmpFDSet.fd_array[tmpFDSet.fd_count] := ANetClient.ConnectSocketHandle;
      Inc(tmpFDSet.fd_count);
    end;
    // ---------------------------------
    tmpRet := WinSock2.select(0, 0, @tmpFDSet, 0, @tmpTimeOut);
    if tmpRet = 0 then //超时
    begin
      WinSock2.CloseSocket(ANetClient.ConnectSocketHandle);
      //FErrorCode := WSAETIMEDOUT;//10060 连接超时
      //raise exception.CreateFmt('TsfSocket.Connect failure TimeOut %d ms',[ANetClient.TimeOutConnect]);
    end;
    //一般非锁定模式套接比较难控制，可以根据实际情况考虑 再设回阻塞模式
    tmpUlong := 0;
    tmpRet := ioctlsocket(ANetClient.ConnectSocketHandle, FIONBIO, tmpUlong);
    if(SOCKET_ERROR = tmpRet) then
    begin
      //FErrorCode := Winsock2.WSAGetLastError();
      //strErr := GetLastErrorErrorMessage(iRet);
      //raise exception.CreateFmt('Connect socket [3] error %d  %s',[FErrorCode,strErr]);
    end;
  end;
  //FConnected := TRUE;
  //ANetClient.RecvCount := 0;
  //ANetClient.SendCount := 0;
end;

procedure NetClientDisconnect(ANetClient: PNetClient);
var
  ErrCode:Integer;
  tmpLinger: TLinger;
begin
  if Winsock2.INVALID_SOCKET = ANetClient.ConnectSocketHandle then
    Exit;
  WinSock2.Shutdown(ANetClient.ConnectSocketHandle, SD_SEND);
  //Self.FErrorCode := 0;
  tmpLinger.l_onoff  := 1;
  tmpLinger.l_linger := 0;
  if SOCKET_ERROR = Winsock2.SetSockOpt(ANetClient.ConnectSocketHandle,
                        SOL_SOCKET,
                        SO_LINGER,
                        @tmpLinger,
                        SizeOf(tmpLinger)) then
  begin
   // ErrCode := WSAGetLastError();
   // TmpStr := IntToStr(ErrCode);
   // MessageBox(0,'aaaaaaaaaaaaaaaaaaa',PChar(TmpStr),0);
  end;
  Winsock2.CloseSocket(ANetClient.ConnectSocketHandle);
  ANetClient.ConnectSocketHandle := Winsock2.INVALID_SOCKET;
//  FConnected := FALSE;
//  FInputStream.Position := 0;
//  FInputStream.ReadEndPosition := 0;
//  Windows.ZeroMemory(FInputStream.Memory,FInputStream.Size);
end;

procedure NetClientSetReadTimeOut(ANetClient: PNetClient; const Value: Integer);
var
  tmpNetTimeout: Integer;
begin
  if ANetClient.TimeOutSend <> Value then
  begin
    tmpNetTimeout := Value;
    if SOCKET_ERROR = WinSock2.Setsockopt(
               ANetClient.ConnectSocketHandle,
               SOL_SOCKET,
               SO_RCVTIMEO,
               PAnsiChar(@tmpNetTimeout),
               Sizeof(tmpNetTimeout)) then
    begin
      //RaiseWSExcption();
    end;
  end;
end;

procedure NetClientSetSendTimeOut(ANetClient: PNetClient; const Value: Integer);
var
  tmpNetTimeout: Integer;
begin
  if ANetClient.TimeOutSend <> Value then
  begin
    tmpNetTimeout := Value;
    if SOCKET_ERROR = WinSock2.Setsockopt(
               ANetClient.ConnectSocketHandle,
               SOL_SOCKET,
               SO_SNDTIMEO,
               PAnsiChar(@tmpNetTimeout),
               Sizeof(tmpNetTimeout)) then
    begin
      //RaiseWSExcption();
    end;
  end;
end;

function NetCLientCheckIsConnected(ANetClient: PNetClient): Boolean;
var
  tmpTimeOut: TTimeVal;  
  tmpNetTimeoutValue: Integer;
  tmpFDSet: TFDSet;
  i: integer;
  iRet: integer;  
  Len: Integer;
  argp: DWORD;
  Buf: array[1..32] of Byte;
begin
  tmpTimeOut.tv_sec  := 0;
  tmpTimeOut.tv_usec := 0;
  tmpFDSet.fd_array[0] := ANetClient.ConnectSocketHandle;
  tmpFDSet.fd_count := 1;          
  iRet := WinSock2.Select(0, @tmpFDSet, 0, 0, @tmpTimeOut);
  
  Result := (iRet = 1);
  if iRet = SOCKET_ERROR then
  begin
    //FErrorCode := WSAGetLastError();
  end;
  if Result then
  begin
  //对方优雅关闭检测
    I := 0;
    Len := SizeOf(Integer);
    iRet := WinSock2.getsockopt(ANetClient.ConnectSocketHandle, SOL_SOCKET, SO_RCVTIMEO, @I, Len);
    if iRet < 0  then
      I := -1;
    if I < 0 then
    begin
      Result := FALSE;
      Exit;
    end;

    tmpNetTimeoutValue := 10;
    if 0 <> WinSock2.Setsockopt(ANetClient.ConnectSocketHandle, SOL_SOCKET, SO_RCVTIMEO,
        PAnsiChar(@tmpNetTimeoutValue),Sizeof(tmpNetTimeoutValue)) then
    begin
      Result := FALSE;
      Exit;
    end;

    iRet := recv(ANetClient.ConnectSocketHandle, Buf, 1, MSG_PEEK);
    Result := (iRet > 0);
    //setRecvTimeOut(I);    
    tmpNetTimeoutValue := I;
    iRet := WinSock2.Setsockopt(
               ANetClient.ConnectSocketHandle,
               SOL_SOCKET,
               SO_RCVTIMEO,
               PAnsiChar(@tmpNetTimeoutValue),
               Sizeof(tmpNetTimeoutValue));
    if iRet = SOCKET_ERROR then
    begin
      //RaiseWSExcption();
    end;
  end;
end;

procedure NetClientSendBuf(ANetClient: PNetClient; ABuf: Pointer; ABufSize: Integer; var ASendCount:Integer);  
const
  SF_SOCKET_BUFF_SIZE = 1024 * 32;
  INT_BUF_SIZE = SF_SOCKET_BUFF_SIZE;
  
var
  P: PAnsiChar;
  tmpLen: Integer;
  iRet: Integer;
begin
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
    iRet := Winsock2.Send(ANetClient.ConnectSocketHandle, P^, tmpLen, 0);
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
    end;

    if WinSock2.SOCKET_ERROR = iRet then
    begin
      //FErrorCode := Winsock2.WSAGetLastError();
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

function NetClientRecvBuf(ANetClient: PNetClient; const ABuffer: PAnsiChar; ABufLen: Integer; ATimeOut:Integer): Integer; //单位 秒
const
  eof:AnsiString = #13#10#13#10;
var
  iRet,Len:Integer;
  P:PAnsiChar;
begin
  Result := -1;

  if ATimeOut > 0 then
    NetClientSetReadTimeOut(ANetClient, ATimeOut)
  else
    NetClientSetReadTimeOut(ANetClient, ANetClient.TimeOutRead); //设置读超时
  (*//
  if FInputStream.Datalen >= 4 then
  begin
    P := FInputStream.Memory;
    Inc(P,FInputStream.Position);
    Result := sfString.PosBuff(P,PAnsiChar(eof),FInputStream.Datalen,4);
    if Result > 0 then
    begin
      if (Result - 1) <= BufLen then
      begin
        FInputStream.Read(Bufffer^,Result - 1);
        FInputStream.Position := FInputStream.Position + 4;
      end
      else if Len < 1 then raise exception.Create('ReadLnII 缓冲区内未收到#13#10#13#10');
      Exit;
    end;
  end;
  //*)
  //数据归位
  (*//
  P := FInputStream.Memory;
  Inc(P,FInputStream.Position);
  Windows.MoveMemory(FInputStream.Memory,P,FInputStream.Datalen);
  FInputStream.ReadEndPosition := FInputStream.Datalen;
  FInputStream.Position := 0;
  //*)
  //\\
  while(TRUE) do
  begin
    (*//
    P := FInputStream.Memory;
    Inc(P,FInputStream.ReadEndPosition);
    Len := FInputStream.Size - FInputStream.ReadEndPosition;
    if Len <= 0 then Break;
    //*)
    //iRet := Winsock2.recv(Socket,P^,Len,0);
    //iRet := Inner_Recv(P^,Len);   
    iRet := WinSock2.recv(ANetClient.ConnectSocketHandle, ABuffer^, ABufLen, 0); 
    if iRet > 0 then
    begin
    
    end;
    Break;
    if iRet > 0 then
    begin
      (*//
      FInputStream.ReadEndPosition := FInputStream.ReadEndPosition + iRet;
      P := FInputStream.Memory;
      Result := sfString.PosBuff(P,PAnsiChar(eof),FInputStream.Datalen,4);
      if Result > 0 then
      begin
        if (Result - 1) <= BufLen then
        begin
          FInputStream.Read(Bufffer^,Result - 1);
          FInputStream.Position := FInputStream.Position + 4;
          Break;
        end else
          raise exception.Create('ReadLnII 缓冲区内未收到#13#10#13#10');
      end;
      //*)
    end else if iRet = 0 then
    begin
      //对方已经优雅的关闭了连接
      Result := 0;
      //FErrorCode := ERROR_GRACEFUL_DISCONNECT;//对方优雅关闭
      //raise exception.Create('ReadLnII 对方已经优雅的关闭了连接');
    end else
    begin
      (*//
      Result := -1;
      FErrorCode := WSAGetLastError();
      if FErrorCode <> 0 then
        raise exception.Create('ReadLnII ErrorCode=' + IntToStr(FErrorCode));
      break;
      //*)
    end;
  end;//while end
end;

end.
