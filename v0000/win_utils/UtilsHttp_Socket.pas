unit UtilsHttp_Socket;

interface

uses
  UtilsHttp, win.iobuffer;
  
  procedure CheckOutSocketConnection(ANetSession: PHttpClientSession);    
  procedure CheckInSocketConnection(ANetSession: PHttpClientSession);
  procedure CloseSocketConnection(ANetSession: PHttpClientSession);
                          
  function Http_GetString(AURL: AnsiString; AHttpClientSession: PHttpClientSession; ABufferSizeMode: Integer = SizeMode_16k): PIOBuffer;
  function Http_GetFile(AUrl, AOutputFile: AnsiString; AHttpClientSession: PHttpClientSession): Boolean;

implementation

uses
  Classes, Sysutils, Winsock2, Windows, xlClientSocket, xlNetwork, xlTcpClient;
                                    
procedure CheckOutSocketConnection(ANetSession: PHttpClientSession);
begin
  ANetSession.ConnectionSession.Connection := CheckOutTcpClient;
end;
                                    
procedure CheckInSocketConnection(ANetSession: PHttpClientSession);
begin
  if nil <> ANetSession then
  begin
    CloseSocketConnection(ANetSession);
    FreeMem(ANetSession.ConnectionSession.Connection);
    ANetSession.ConnectionSession.Connection := nil;
  end;
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

procedure CloseSocketConnection(ANetSession: PHttpClientSession);
var
  tmpTcpClient: PxlTcpClient;
begin
  if nil <> ANetSession then
  begin
    tmpTcpClient := ANetSession.ConnectionSession.Connection;
    if nil <> tmpTcpClient then
    begin
      TcpClientDisconnect(tmpTcpClient);
    end;
  end;
end;

function Http_GetString(AURL: AnsiString; AHttpClientSession: PHttpClientSession; ABufferSizeMode: Integer = SizeMode_16k): PIOBuffer;
var
  tmpHttpInfo: THttpUrlInfo;
  tmpTcpClient: PxlTcpClient;
  tmpAddress: TxlNetServerAddress;   
  tmpStr: AnsiString; 
  tmpRet: Integer;        
  tmpBuffer: PIOBuffer;
  tmpString: AnsiString;
  tmpStrs: TStringList;
  i: integer;
  tmpPos: integer;
begin
  Result := nil;
  FillChar(tmpHttpInfo, SizeOf(tmpHttpInfo), 0);
  FillChar(AHttpClientSession.HttpHeadSession, SizeOf(AHttpClientSession.HttpHeadSession), 0);

  if ParseHttpUrlInfo(AURL, @tmpHttpInfo) then
  begin
    tmpTcpClient := AHttpClientSession.ConnectionSession.Connection;
    
    tmpTcpClient.Base.TimeOutConnect := AHttpClientSession.ConnectionSession.ConnectTimeOut;
    tmpTcpClient.Base.TimeOutRead := AHttpClientSession.ConnectionSession.ReceiveTimeOut;        
    tmpTcpClient.Base.TimeOutSend := AHttpClientSession.ConnectionSession.SendTimeOut;

    if 0 = tmpTcpClient.Base.TimeOutConnect then
      tmpTcpClient.Base.TimeOutConnect := 3000;
    if 0 = tmpTcpClient.Base.TimeOutRead then
      tmpTcpClient.Base.TimeOutRead := 500;
    if 0 = tmpTcpClient.Base.TimeOutSend then
      tmpTcpClient.Base.TimeOutSend := 500;
    
    if AHttpClientSession.IsKeepAlive then
    begin
      if (Winsock2.INVALID_SOCKET = tmpTcpClient.Base.ConnectSocketHandle) or
         (0 = tmpTcpClient.Base.ConnectSocketHandle) then
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

    tmpStr := GenHttpHeader(AUrl, tmpHttpInfo, AHttpClientSession.IsKeepAlive);
    if not NetClientSendBuf(tmpTcpClient, Pointer(@tmpStr[1]),Length(tmpStr), tmpRet) then
    begin
      TcpClientDisconnect(tmpTcpClient);
      exit;
    end;
    tmpRet := 0;
    tmpBuffer := CheckOutIOBuffer(ABufferSizeMode);
    if nil <> tmpBuffer then
    begin
      NetClientRecvBuf(tmpTcpClient, tmpBuffer, tmpRet);
      if 0 < tmpBuffer.BufferHead.ExNodeCount then
      begin
        Result := RepackIOBuffer(tmpBuffer);
        CheckInIOBuffer(tmpBuffer);
      end else
      begin
        Result := tmpBuffer;
      end;
      if nil <> Result then
      begin
        FIllChar(AHttpClientSession.HttpHeadSession, SizeOf(AHttpClientSession.HttpHeadSession), 0);
        HttpBufferHeader_Parser(Result, @AHttpClientSession.HttpHeadSession);
        if (0 < AHttpClientSession.HttpHeadSession.HeadEndPos) then
        begin
          SetLength(tmpString, AHttpClientSession.HttpHeadSession.HeadEndPos + 1);
          CopyMemory(@tmpString[1], @Result.Data[0], AHttpClientSession.HttpHeadSession.HeadEndPos - 1);
          tmpStrs := TStringList.Create;
          try
            tmpStrs.Text := tmpString;
            for i := 0 to tmpStrs.Count - 1 do
            begin
              tmpString := tmpStrs[i];
              tmpPos := Pos('connection:', Lowercase(tmpString));
              if 0 < tmpPos then
              begin
                tmpString := Trim(Copy(tmpString, tmpPos + Length('connection:'), maxint));
                if SameText('close', tmpString) then
                begin
                  TcpClientDisconnect(tmpTcpClient);
                  exit;
                end;
              end;
            end;
          finally
            tmpStrs.Clear;
            tmpStrs.Free;
          end;
          tmpString := '';
        end;
      end;
    end;
  end;
end;

function Http_GetFile(AUrl, AOutputFile: AnsiString; AHttpClientSession: PHttpClientSession): Boolean;
begin
  Result := false;
end;
                
end.
