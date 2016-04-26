unit NetHttpClientProc;

interface

uses
  NetHttpClient;
                
  function HttpGet(AHttpClient: PNetHttpClient; AUrl: AnsiString): AnsiString;

implementation

uses
  DealServerHttpProtocol,
  Sysutils,
  NetBaseObj,
  NetObjClient,
  NetObjClientProc;
                 
function GenHttpHeader(const AUrl: AnsiString; AHttpUrlInfo: THttpUrlInfo): AnsiString;
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

  //Result := Result + 'Connection:' + #32 + 'keep-alive'; 
  Result := Result + 'Connection:' + #32 + 'close';
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

function HttpGet(AHttpClient: PNetHttpClient; AUrl: AnsiString): AnsiString; 
var
  tmpAddress: TNetServerAddress;
  tmpStr: AnsiString;
  iRet: Integer;
  tmpBuffer: array[0..64 * 1024 - 1] of AnsiChar;
  tmpHttpInfo: DealServerHttpProtocol.THttpUrlInfo;
begin
  Result := '';          
  //tmpAddress.Host := 'www.sohu.com';
  FillChar(tmpHttpInfo, SizeOf(tmpHttpInfo), 0);
  if HttpUrlInfoParse(AUrl, @tmpHttpInfo) then
  begin
    tmpAddress.Host := tmpHttpInfo.Host;
    tmpAddress.Port := StrToIntDef(tmpHttpInfo.Port, 80);
    NetClientConnect(AHttpClient.NetClient, @tmpAddress);

    tmpStr := GenHttpHeader(AUrl, tmpHttpInfo);
    NetClientSendBuf(AHttpClient.NetClient, Pointer(@tmpStr[1]),Length(tmpStr), iRet);
    iRet := 0;
    FillChar(tmpBuffer, SizeOf(tmpBuffer), 0);
    NetClientRecvBuf(AHttpClient.NetClient, @tmpBuffer[0], SizeOf(tmpBuffer), iRet);
    if tmpBuffer[0] = '0' then
    begin
  
    end;
  end;
end;

end.
