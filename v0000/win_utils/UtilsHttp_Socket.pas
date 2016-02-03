unit UtilsHttp_Socket;

interface

uses
  UtilsHttp;
  
type
  PSocketConnectionSession = ^TSocketConnectionSession;
  TSocketConnectionSession = record
    IsKeepAlive : Boolean;
    Connection  : Pointer;
  end;
                  
  function CheckOutSocketConnection: PSocketConnectionSession;    
  procedure CheckInSocketConnection(var AConnection: PSocketConnectionSession);
                          
  function Http_GetString(AURL: AnsiString; AConnection: PSocketConnectionSession): PHttpBuffer;
  function Http_GetFile(AUrl, AOutputFile: AnsiString; AConnection: PSocketConnectionSession): Boolean;

implementation

uses
  Classes, Sysutils, Winsock2, Windows, xlClientSocket, xlNetwork, xlTcpClient;

function CheckOutSocketConnection: PSocketConnectionSession;
begin
  Result := System.New(PSocketConnectionSession);
  FillChar(Result^, SizeOf(TSocketConnectionSession), 0);
  Result.Connection := CheckOutTcpClient;
  Result.IsKeepAlive := True;
  InitializeNetwork(@Network);
end;

procedure CheckInSocketConnection(var AConnection: PSocketConnectionSession);
begin
end;

function GenHttpHeader(const AUrl: AnsiString; AHttpUrlInfo: THttpUrlInfo; AIsKeepAlive: Boolean): AnsiString;
var
  strVersion:AnsiString;
begin
  Result := '';
  //if Self.HttpVersion = pv_11 then
  //else
    //strVersion := '1.0';

//  if (ProxyType = ptNone) or (ProxyType = ptSock5) then
//  begin
//    if FHttpMethod = hmGet then
//      TmpStr := 'GET' + #32 + URLPath + #32 + 'HTTP/' + strVersion
//    else
//      TmpStr := 'POST' + #32 + URLPath + #32 + 'HTTP/' + strVersion;
//  end else if FProxyType = ptHttp then
//  begin
//   if FHttpMethod = hmGet then
//      TmpStr := 'GET' + #32 + URL + #32 + 'HTTP/' + strVersion
//    else
//      TmpStr := 'POST' + #32 + URL + #32 + 'HTTP/' + strVersion;
//  end;
  (*//
  GET / HTTP/1.1#$D#$A
  Host: www.sohu.com#$D#$A
  User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:21.0) Gecko/20100101 Firefox/21.0#$D#$A
  Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'#$D#$A
  Connection: keep-alive#$D#$A
  Accept-Encoding: gzip, deflate'#$D#$A
  Accept-Language: zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3'#$D#$A#$D#$A
  //*)                       
    strVersion := '1.1';
  Result := 'GET' + #32 + AHttpUrlInfo.PathName + #32 + 'HTTP/' + strVersion;
  Result := Result + #13#10;

  Result := Result + 'Host:' + #32 + AHttpUrlInfo.Host;
  Result := Result + #13#10;

  Result := Result + 'User-Agent:' + #32 + 'Mozilla/5.0 (Windows NT 5.1; rv:21.0) Gecko/20100101 Firefox/21.0';//UserAgent;
  Result := Result + #13#10;

  //Result := Result + 'Accept:' + #32 + 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
  //Result := Result + #13#10;
  Result := Result + 'Accept:' + #32 + 'text/html,*/*';
  Result := Result + #13#10;


  //Referer
  //if Self.Referer <> '' then
  //  Headers.Add('Referer: ' + Referer);
  if AIsKeepAlive then
  begin
    Result := Result + 'Connection:' + #32 + 'keep-alive';
  end else
  begin
    Result := Result + 'Connection:' + #32 + 'close';
  end;
  Result := Result + #13#10;


  Result := Result + 'Accept-Encoding:identity';  
  //Result := Result + 'Accept-Encoding:' + #32 + 'gzip, deflate';
  Result := Result + #13#10;

  Result := Result + 'Accept-Language:' + #32 + 'zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3';
  Result := Result + #13#10;
  
  Result := Result + #13#10;

  //ContentType
  //if (HttpMethod = hmPost) and (ContentType <> '') then
  //  Headers.Add('Content-Type: ' + ContentType);


  //if (HttpMethod = hmPost) and (ContentLength > 0) then
  //begin
  //  Headers.Add('Content-Length: ' + IntToStr(ContentLength));
  //end;

  //Cookie
  //if FOwner.Cookies <> nil then
  //begin
  //  FCookie := FOwner.Cookies.GetCookies(URL);
  // if FCookie <> '' then
  //   Headers.Add('Cookie: ' + FCookie);

  //插入客户头
  //for Index := 0 to CustomHeaders.Count - 1 do
  //begin
  //  TmpStr := CustomHeaders.Strings[Index];
  //  if TmpStr <> '' then
  //    Headers.Add(TmpStr);
  //end;        
end;

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

procedure NetClientSetReadTimeOut(ANetClient: PxlTcpClient; const Value: Integer);
var
  tmpNetTimeout: Integer;
begin
  if ANetClient.Base.TimeOutSend <> Value then
  begin
    tmpNetTimeout := Value;
    if SOCKET_ERROR = WinSock2.Setsockopt(
               ANetClient.Base.ConnectSocketHandle,
               SOL_SOCKET,
               SO_RCVTIMEO,
               PAnsiChar(@tmpNetTimeout),
               Sizeof(tmpNetTimeout)) then
    begin
      //RaiseWSExcption();
    end;
  end;
end;

function NetClientRecvBuf(ANetClient: PxlTcpClient; const ABuffer: PAnsiChar; ABufLen: Integer; ATimeOut:Integer): Integer; //单位 秒
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
    NetClientSetReadTimeOut(ANetClient, ANetClient.Base.TimeOutRead); //设置读超时
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
    iRet := WinSock2.recv(ANetClient.Base.ConnectSocketHandle, ABuffer^, ABufLen, 0); 
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

function Http_GetString(AURL: AnsiString; AConnection: PSocketConnectionSession): PHttpBuffer;
var
  tmpHttpInfo: THttpUrlInfo;
  tmpTcpClient: PxlTcpClient;
  tmpAddress: TxlNetServerAddress;   
  tmpStr: AnsiString; 
  tmpRet: Integer;        
  tmpBuffer: PHttpBuffer;
begin
  Result := nil;
  FillChar(tmpHttpInfo, SizeOf(tmpHttpInfo), 0);
  if ParseHttpUrlInfo(AURL, @tmpHttpInfo) then
  begin
    tmpTcpClient := AConnection.Connection;
    if AConnection.IsKeepAlive then
    begin
      if (0 = tmpTcpClient.Base.ConnectSocketHandle) then
      begin
        tmpAddress.Host := tmpHttpInfo.Host;
        tmpAddress.Port := StrToIntDef(tmpHttpInfo.Port, 80);
        TcpClientConnect(tmpTcpClient, @tmpAddress);
      end;
    end else
    begin
      tmpAddress.Host := tmpHttpInfo.Host;
      tmpAddress.Port := StrToIntDef(tmpHttpInfo.Port, 80);
      TcpClientConnect(tmpTcpClient, @tmpAddress);
    end;

    tmpStr := GenHttpHeader(AUrl, tmpHttpInfo, AConnection.IsKeepAlive);
    if not NetClientSendBuf(tmpTcpClient, Pointer(@tmpStr[1]),Length(tmpStr), tmpRet) then
    begin
      TcpClientDisconnect(tmpTcpClient);
      exit;
    end;
    tmpRet := 0;
    tmpBuffer := System.New(PHttpBuffer);
    FillChar(tmpBuffer^, SizeOf(PHttpBuffer), 0);
    
    NetClientRecvBuf(tmpTcpClient, @tmpBuffer.Data[0], SizeOf(THttpBuffer), tmpRet);
    Result := tmpBuffer;
  end;
end;

function Http_GetFile(AUrl, AOutputFile: AnsiString; AConnection: PSocketConnectionSession): Boolean;
begin
  Result := false;
end;
                
end.
