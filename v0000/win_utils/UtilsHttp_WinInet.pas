unit UtilsHttp_WinInet;

interface

uses
  WinInet, Classes, Sysutils, UtilsHttp;
  
type
  PWinInetSession   = ^TWinInetSession;
  TWinInetSession   = record
    Session         : HINTERNET;
    Connect         : HINTERNET;
    Request         : HINTERNET;
  end;

  function Http_GetString(AURL: string): string;       
  function GetHTTPStream(AHttpUrlInfo: PHttpUrlInfo; AWinInetSession: PWinInetSession;
      AStream: TStream; APost: TStrings): Boolean;    
  function IsUrlValid(AUrl: AnsiString): boolean;

implementation

//uses
//  CnInetUtils;

function GetStreamFromHandle(ARequestHandle: HINTERNET; ATotalSize: Integer; AStream: TStream): Boolean;
const
  csBufferSize = 4096;
var
  tmpCurrSize: Cardinal;
  tmpReaded: Cardinal;
  tmpBuf: array[0..csBufferSize - 1] of Byte;
begin
  Result := False;
  tmpCurrSize := 0;
  tmpReaded := 0;
  repeat
    if not InternetReadFile(ARequestHandle, @tmpBuf, csBufferSize, tmpReaded) then
      Exit;
    if tmpReaded > 0 then
    begin
      AStream.Write(tmpBuf, tmpReaded);
      Inc(tmpCurrSize, tmpReaded);
      //DoProgress(TotalSize, CurrSize);
      //if Aborted then
      //  Exit;
    end;
  until tmpReaded = 0;
  Result := True;
end;

function GetHTTPStream(AHttpUrlInfo: PHttpUrlInfo;
    AWinInetSession: PWinInetSession;
    AStream: TStream; APost: TStrings): Boolean;
var
  tmpIsHttps: Boolean;
  tmpPathName: string;
  tmpSizeStr: array[0..63] of Char;
  tmpBufLen: Cardinal;
  tmpIndex: Cardinal;
  i: Integer;
  tmpPort: Word;
  tmpFlag: Cardinal;
  tmpVerb: string;
  tmpOpt: string;
  tmpPOpt: PChar;
  tmpOptLen: Integer;
begin
  Result := False;
  try
    tmpIsHttps := SameText(AHttpUrlInfo.Protocol, 'https');
    if tmpIsHttps then
    begin
      tmpPort := StrToIntDef(AHttpUrlInfo.Port, INTERNET_DEFAULT_HTTPS_PORT);
      tmpFlag := INTERNET_FLAG_RELOAD or INTERNET_FLAG_SECURE or
        INTERNET_FLAG_IGNORE_CERT_CN_INVALID or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID;
    end
    else
    begin
      tmpPort := StrToIntDef(AHttpUrlInfo.Port, INTERNET_DEFAULT_HTTP_PORT);
      tmpFlag := INTERNET_FLAG_RELOAD;
    end;
    //if NoCookie then
    //  Flag := Flag + INTERNET_FLAG_NO_COOKIES;

    AWinInetSession.Connect :=
      InternetConnect(AWinInetSession.Session, PChar(AHttpUrlInfo.Host), tmpPort, nil, nil, INTERNET_SERVICE_HTTP, 0, 0);
    if (nil = AWinInetSession.Connect) {or FAborted } then
      Exit;

    if APost <> nil then
    begin
      tmpVerb := 'POST';
      tmpOpt := '';
      for i := 0 to APost.Count - 1 do
        if tmpOpt = '' then
          tmpOpt := EncodeURL(APost[i])
        else
          tmpOpt := tmpOpt + '&' + EncodeURL(APost[i]);
      tmpPOpt := PChar(tmpOpt);
      tmpOptLen := Length(tmpOpt);
    end
    else
    begin
      tmpVerb := 'GET';
      tmpPOpt := nil;
      tmpOptLen := 0;
    end;

    tmpPathName := AHttpUrlInfo.PathName;
    //if EncodeUrlPath then
      tmpPathName := EncodeURL(tmpPathName);
    AWinInetSession.Request := HttpOpenRequest(AWinInetSession.Connect,
        PChar(tmpVerb), PChar(tmpPathName), HTTP_VERSION, nil, nil, tmpFlag, 0);
    if (nil = AWinInetSession.Request) {or FAborted} then
      Exit;

    //if FDecoding and FDecodingValid then
    begin
      HttpAddRequestHeaders(AWinInetSession.Request,
          PChar(SAcceptEncoding),
          Length(SAcceptEncoding),
          HTTP_ADDREQ_FLAG_REPLACE or HTTP_ADDREQ_FLAG_ADD);
    end;
//    for i := 0 to FHttpRequestHeaders.Count - 1 do
//    begin
//      HttpAddRequestHeaders(AWinInetSession.Request,
//        PChar(FHttpRequestHeaders[i]),
//        Length(FHttpRequestHeaders[i]),
//        HTTP_ADDREQ_FLAG_REPLACE or HTTP_ADDREQ_FLAG_ADD);
//    end;

    if HttpSendRequest(AWinInetSession.Request, nil, 0, tmpPOpt, tmpOptLen) then
    begin
      //if FAborted then
      //  Exit;

      FillChar(tmpSizeStr, SizeOf(tmpSizeStr), 0);
      tmpBufLen := SizeOf(tmpSizeStr);
      tmpIndex := 0;
      HttpQueryInfo(AWinInetSession.Request, HTTP_QUERY_CONTENT_LENGTH, @tmpSizeStr, tmpBufLen, tmpIndex);
        
      //if Aborted then
      //  Exit;

      Result := GetStreamFromHandle(AWinInetSession.Request, StrToIntDef(tmpSizeStr, -1), AStream);
    end;
  finally
    if nil <> AWinInetSession.Request then
      InternetCloseHandle(AWinInetSession.Request);
    if nil <> AWinInetSession.Connect then
      InternetCloseHandle(AWinInetSession.Connect);
  end;
end;

function Http_GetString(AURL: string): string;
begin
//  Result := CnInet_GetString(AURL);
end;

// 检查URL是否有效的函数
function IsUrlValid(AUrl: AnsiString): boolean;
var
  tmpWinInet: TWinInetSession;
  dwindex: dword;
  dwcodelen: dword;
  dwcode: array[1..20] of AnsiChar;
  res: PAnsiChar;
  tmpAgent: AnsiString;
begin
  Result := false;
  if Pos('://', lowercase(AUrl)) < 1 then
    AUrl := 'http://' + AUrl;

  tmpAgent := 'InetURL:/1.0';
  tmpWinInet.Session := InternetOpenA(PAnsiChar(tmpAgent), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(tmpWinInet.Session) then
  begin
    try
      tmpWinInet.Request := InternetOpenUrlA(tmpWinInet.Session, PAnsiChar(AUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
      try
        dwIndex := 0;
        dwCodeLen := 10;
        if HttpQueryInfoA(tmpWinInet.Request, HTTP_QUERY_STATUS_CODE, @dwcode, dwcodeLen, dwIndex) then
        begin
          res := PAnsiChar(@dwcode);
          result := (res = '200') or (res = '302');
        end;
      finally
        InternetCloseHandle(tmpWinInet.Request);
      end;
    finally           
      InternetCloseHandle(tmpWinInet.Session);
    end;
  end;
end;

end.
