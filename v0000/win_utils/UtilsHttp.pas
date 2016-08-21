unit UtilsHttp;

interface

uses
  Windows, ActiveX, UrlMon, win.iobuffer;

type
  PClientConnectSession = ^TClientConnectSession;
  TClientConnectSession = record
    Connection      : Pointer; 
    SendTimeOut     : Cardinal;
    ConnectTimeOut  : Cardinal;
    ReceiveTimeOut  : Cardinal;
  end;
           
  PHttpHeadParseSession = ^THttpHeadParseSession;
  THttpHeadParseSession = record
    RetCode         : integer;
    HeadEndPos      : integer;
  end;
            
  PHttpClientSession = ^THttpClientSession;
  THttpClientSession = record
    ConnectionSession: TClientConnectSession;  
    IsKeepAlive     : Boolean;
    HttpHeadSession : THttpHeadParseSession;
  end;
  
  PHttpUrlInfo      = ^THttpUrlInfo;
  THttpUrlInfo      = record
    Protocol        : AnsiString;
    Host            : AnsiString;
    Port            : AnsiString;
    PathName        : AnsiString;
    UserName        : AnsiString;
    Password        : AnsiString;
  end;

  PHttpBuffer       = ^THttpBuffer;
  THttpBuffer       = record

  end;
  
  function CheckOutHttpClientSession: PHttpClientSession;
  procedure CheckInHttpClientSession(var ANetClientSession: PHttpClientSession);

  function GetHttpUrlData(AUrl: AnsiString; ANetSession: PHttpClientSession; ABuffer: PIOBuffer; ABufferSizeMode: Integer = SizeMode_16k): PIOBuffer; overload;      
  function GetHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PHttpClientSession; ABuffer: PIOBuffer; ABufferSizeMode: Integer = SizeMode_16k): PIOBuffer; overload;
  
  function GetHttpUrlFile(AUrl: AnsiString; AOutputFile: AnsiString; ANetSession: PHttpClientSession): Boolean; overload;

  function PostHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PHttpClientSession): PIOBuffer;

  function GetDefaultUserAgent: AnsiString;    
  function ParseHttpUrlInfo(AUrl: AnsiString; AInfo: PHttpUrlInfo): Boolean;

  procedure HttpBufferHeader_Parser(AHttpBuffer: PIOBuffer; AHttpHeadParseSession: PHttpHeadParseSession);
  procedure SaveHttpResponseToFile(AHttpBuffer: PIOBuffer; AHttpHeadParseSession: PHttpHeadParseSession; AFileName: AnsiString);

  {* 将 URL 中的特殊字符转换成 %XX 的形式}
  function EncodeURL(const AUrl: string): string;

const
  SAcceptEncoding = 'Accept-Encoding: gzip,deflate';
  
implementation

uses
  Sysutils,
  //UtilsHttp_Indy,
  //win.diskfile,
  UtilsHttp_Socket;

function CheckOutHttpClientSession: PHttpClientSession;
begin
  Result := System.New(PHttpClientSession);
  FillChar(Result^, SizeOf(THttpClientSession), 0);
  Result.IsKeepAlive := True;
end;

procedure CheckInHttpClientSession(var ANetClientSession: PHttpClientSession);
begin
  if nil <> ANetClientSession then
  begin
    if nil <> ANetClientSession.ConnectionSession.Connection then
    begin
      CheckInSocketConnection(ANetClientSession);
    end;
    FreeMem(ANetClientSession);
    ANetClientSession := nil;
  end;
end;

function EncodeURL(const AUrl: string): string;
const
  UnsafeChars = ['*', '#', '%', '<', '>', '+', ' '];
var
  i: Integer;
  InStr, OutStr: AnsiString;
begin
  InStr := AnsiString(AUrl);
  OutStr := '';
  for i := 1 to Length(InStr) do begin
    if (InStr[i] in UnsafeChars) or (InStr[i] >= #$80) or (InStr[i] < #32) then
      OutStr := OutStr + '%' + AnsiString(IntToHex(Ord(InStr[i]), 2))
    else
      OutStr := OutStr + InStr[i];
  end;
  Result := string(OutStr);
end;

function GetDefaultUserAgent: AnsiString;
var
  s: AnsiString;
  cbSize: Cardinal;
  hRet: HRESULT;
begin
  cbSize := MAX_PATH;
  repeat
    SetLength(s, cbSize);
    hRet := UrlMon.ObtainUserAgentString(0, PAnsiChar(s), cbSize);
    case hRet of
      E_OUTOFMEMORY:
        cbSize := cbSize * 2;
      NOERROR:
        SetLength(s, cbSize - 1);
      else
        SetLength(s, 0);
    end;
  until hRet <> E_OUTOFMEMORY;
  Result := s;
end;

function ParseHttpUrlInfo(AUrl: AnsiString; AInfo: PHttpUrlInfo): Boolean;
var
  Idx: Integer;
  Buff: AnsiString;
  
  function ExtractStr(var ASrc: AnsiString; ADelim: AnsiString; ADelete: Boolean = True): AnsiString;
  var
    Idx: Integer;
  begin
    Idx := Pos(ADelim, ASrc);
    if Idx = 0 then
    begin
      Result := ASrc;
      if ADelete then
        ASrc := '';
    end else
    begin
      Result := Copy(ASrc, 1, Idx - 1);
      if ADelete then
        ASrc := Copy(ASrc, Idx + Length(ADelim), MaxInt);
    end;
  end;
  
begin
  Result := False;
  AUrl := Trim(AUrl);
  Idx := Pos('://', AUrl);
  if Idx > 0 then
  begin
    AInfo.Protocol := Copy(AUrl, 1, Idx  - 1);
    Delete(AUrl, 1, Idx + 2);
    if AUrl = '' then
      Exit;

    Buff := ExtractStr(AUrl, '/');
    Idx := Pos('@', Buff);
    AInfo.Password := Copy(Buff, 1, Idx  - 1);
    if Idx > 0 then
      Delete(Buff, 1, Idx);

    AInfo.UserName := ExtractStr(AInfo.Password, ':');
    if Length(AInfo.UserName) = 0 then
      AInfo.Password := '';

    AInfo.Host := ExtractStr(Buff, ':');
    AInfo.Port := Buff;
    AInfo.PathName := '/' + AUrl;
    Result := True;
  end;
end;

function GetHttpUrlData(AUrl: AnsiString; ANetSession: PHttpClientSession; ABuffer: PIOBuffer; ABufferSizeMode: Integer = SizeMode_16k): PIOBuffer;
var
//  tmpIConnection: PIndyConnectionSession;
  tmpOwnedConnection: Boolean;
begin    
  tmpOwnedConnection := false;
  if nil <> ANetSession then
  begin
    if nil = ANetSession.ConnectionSession.Connection then
    begin
      CheckOutSocketConnection(ANetSession);
      if not ANetSession.IsKeepAlive then
        tmpOwnedConnection := true;
    end;
  end;
  //Result := Http_WinInet.Http_GetString(AUrl);
  //Result := UtilsHttp_Indy.Http_GetString(AUrl, tmpConnection);
  Result := UtilsHttp_Socket.Http_GetString(AUrl, ANetSession, ABuffer, ABufferSizeMode);
  if tmpOwnedConnection then
  begin
    CheckInSocketConnection(ANetSession);
  end;
end;

function GetHttpUrlFile(AUrl: AnsiString; AOutputFile: AnsiString; ANetSession: PHttpClientSession): Boolean;
begin    
  if nil <> ANetSession then
  begin
    if nil = ANetSession.ConnectionSession.Connection then
    begin                
      //ANetSession.Connection := CheckOutIndyConnection;
      CheckOutSocketConnection(ANetSession);
    end;  
  end;
  //Result := UtilsHttp_Indy.Http_GetFile(AUrl, AOutputFile, tmpConnection);
  Result := UtilsHttp_Socket.Http_GetFile(AUrl, AOutputFile, ANetSession);
end;

function GetHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PHttpClientSession; ABuffer: PIOBuffer; ABufferSizeMode: Integer = SizeMode_16k): PIOBuffer;
var
//  tmpIConnection: PIndyConnectionSession;
  tmpOwnedConnection: Boolean;
begin    
  tmpOwnedConnection := false;
  if nil <> ANetSession then
  begin
    if nil = ANetSession.ConnectionSession.Connection then
    begin
      CheckOutSocketConnection(ANetSession);
      if not ANetSession.IsKeepAlive then
        tmpOwnedConnection := true;
    end;
  end;
  //Result := Http_WinInet.Http_GetString(AUrl);
  //Result := UtilsHttp_Indy.Http_GetString(AUrl, tmpConnection);
  Result := UtilsHttp_Socket.Http_GetString(AUrl, ANetSession, ABuffer, ABufferSizeMode);
  if tmpOwnedConnection then
  begin
    CheckInSocketConnection(ANetSession);
  end;
end;

function PostHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PHttpClientSession): PIOBuffer;
var
//  tmpIConnection: PIndyConnectionSession;
  tmpOwnedConnection: Boolean;
begin    
  tmpOwnedConnection := false;
  if nil <> ANetSession then
  begin
    if nil = ANetSession.ConnectionSession.Connection then
    begin
      CheckOutSocketConnection(ANetSession);
      if not ANetSession.IsKeepAlive then
        tmpOwnedConnection := true;
    end;
  end;
  //Result := Http_WinInet.Http_GetString(AUrl);
  //Result := UtilsHttp_Indy.Http_GetString(AUrl, tmpConnection);
  Result := UtilsHttp_Socket.Http_GetString(AUrl, ANetSession, nil);
  if tmpOwnedConnection then
  begin
    CheckInSocketConnection(ANetSession);
  end;
end;

procedure HttpBufferHeader_Parser(AHttpBuffer: PIOBuffer; AHttpHeadParseSession: PHttpHeadParseSession);
var  
  tmpHttpHeadBuffer: array[0..256 - 1] of AnsiChar; 
  i: integer;
  tmpStr: AnsiString;
  tmpPos: integer;
  tmpLastPos_CRLF: integer;
begin
  if nil = AHttpBuffer then
    exit;
  FillChar(tmpHttpHeadBuffer, SizeOf(tmpHttpHeadBuffer), 0);
  tmpLastPos_CRLF := 0;
  for i := 0 to AHttpBuffer.BufferHead.TotalLength - 1 do
  begin            
    if (#13 = AHttpBuffer.Data[i]) then
    begin
      //#13#10
      if 0 = tmpLastPos_CRLF then
      begin
        CopyMemory(@tmpHttpHeadBuffer[0], @AHttpBuffer.Data[0], i);
        tmpStr := tmpHttpHeadBuffer;          
        FillChar(tmpHttpHeadBuffer, SizeOf(tmpHttpHeadBuffer), 0);
        tmpPos := Pos(#32, tmpStr);
        if tmpPos > 0 then
        begin
          tmpStr := Copy(tmpStr, tmpPos + 1, maxint);
          tmpPos := Pos(#32, tmpStr);
          if tmpPos > 0 then
          begin          
            tmpStr := Copy(tmpStr, 1, tmpPos - 1); 
            AHttpHeadParseSession.RetCode := StrToIntDef(tmpStr, 0);
          end;
        end;
      end;                               
      if i - tmpLastPos_CRLF < 3 then
      begin
        AHttpHeadParseSession.HeadEndPos := i + 1;
        exit;
      end;
      tmpLastPos_CRLF := i;
    end;
  end;
end;

procedure SaveHttpResponseToFile(AHttpBuffer: PIOBuffer; AHttpHeadParseSession: PHttpHeadParseSession; AFileName: AnsiString);
var
  tmpFileHandle: THandle;
  tmpBytesWrite: DWORD;
  tmpBytesWritten: DWORD;  
begin
  tmpFileHandle := Windows.CreateFileA(PAnsiChar(AFileName),
          Windows.GENERIC_ALL,         // GENERIC_READ
          Windows.FILE_SHARE_READ or
          Windows.FILE_SHARE_WRITE or
          Windows.FILE_SHARE_DELETE,
        nil,
        CREATE_NEW,
        FILE_ATTRIBUTE_NORMAL, 0);
  if (0 <> tmpFileHandle) and (INVALID_HANDLE_VALUE <> tmpFileHandle) then
  begin
    try
      tmpBytesWrite := AHttpBuffer.BufferHead.BufDataLength - AHttpHeadParseSession.HeadEndPos; 
      if Windows.WriteFile(
        tmpFileHandle, //hFile: THandle;
        AHttpBuffer.Data[AHttpHeadParseSession.HeadEndPos + 1], // const Buffer;
        tmpBytesWrite, //nNumberOfBytesToWrite: DWORD;
        tmpBytesWritten, //var lpNumberOfBytesWritten: DWORD;
        nil {lpOverlapped: POverlapped}) then
      begin
      
      end;
      //Windows.WriteFileEx();
    finally
      Windows.CloseHandle(tmpFileHandle);
    end;
  end;
end;

end.
