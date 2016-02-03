unit UtilsHttp;

interface

uses
  Windows, ActiveX, UrlMon, win.iobuffer;

type
  PNetClientSession = ^TNetClientSession;
  TNetClientSession = record
    Connection  : Pointer;
  end;

  PHttpUrlInfo  = ^THttpUrlInfo;
  THttpUrlInfo  = record
    Protocol    : AnsiString;
    Host        : AnsiString;
    Port        : AnsiString;
    PathName    : AnsiString;
    UserName    : AnsiString;
    Password    : AnsiString;
  end;
          
  PHttpHeadParseSession = ^THttpHeadParseSession;
  THttpHeadParseSession = record
    RetCode: integer;
    HeadEndPos: integer;
  end;
  
  function CheckOutNetClientSession: PNetClientSession;
  procedure CheckInNetClientSession(var ANetClientSession: PNetClientSession);

  function GetHttpUrlData(AUrl: AnsiString; ANetSession: PNetClientSession): PIOBuffer; overload;      
  function GetHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): PIOBuffer; overload;
  function GetHttpUrlFile(AUrl: AnsiString; AOutputFile: AnsiString; ANetSession: PNetClientSession): Boolean; overload;

  function PostHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): PIOBuffer;

  function GetDefaultUserAgent: AnsiString;    
  function ParseHttpUrlInfo(AUrl: AnsiString; AInfo: PHttpUrlInfo): Boolean;

  procedure HttpBufferHeader_Parser(AHttpBuffer: PIOBuffer; AHttpHeadParseSession: PHttpHeadParseSession);

implementation

uses
  Sysutils,
  UtilsHttp_Indy,
  UtilsHttp_Socket;

function CheckOutNetClientSession: PNetClientSession;
begin
  Result := System.New(PNetClientSession);
  FillChar(Result^, SizeOf(TNetClientSession), 0);
end;

procedure CheckInNetClientSession(var ANetClientSession: PNetClientSession);
begin

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

function GetHttpUrlData(AUrl: AnsiString; ANetSession: PNetClientSession): PIOBuffer;
var
  tmpIConnection: PIndyConnectionSession;
  tmpConnection: PSocketConnectionSession;
begin    
  tmpConnection := nil;
  if nil <> ANetSession then
  begin
    if nil = ANetSession.Connection then
    begin
      //ANetSession.Connection := CheckOutIndyConnection;
      ANetSession.Connection := CheckOutSocketConnection;
    end;
    tmpConnection := ANetSession.Connection;
  end;
  //Result := Http_WinInet.Http_GetString(AUrl);
  //Result := UtilsHttp_Indy.Http_GetString(AUrl, tmpConnection);
  Result := UtilsHttp_Socket.Http_GetString(AUrl, tmpConnection);
end;

function GetHttpUrlFile(AUrl: AnsiString; AOutputFile: AnsiString; ANetSession: PNetClientSession): Boolean;
var
  //tmpConnection: PIndyConnection;
  tmpConnection: PSocketConnectionSession;
begin    
  tmpConnection := nil;     
  if nil <> ANetSession then
  begin
    if nil = ANetSession.Connection then
    begin                
      //ANetSession.Connection := CheckOutIndyConnection;
      ANetSession.Connection := CheckOutSocketConnection;
    end;  
    tmpConnection := ANetSession.Connection;
  end;
  //Result := UtilsHttp_Indy.Http_GetFile(AUrl, AOutputFile, tmpConnection);
  Result := UtilsHttp_Socket.Http_GetFile(AUrl, AOutputFile, tmpConnection);
end;

function GetHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): PIOBuffer;
begin          
  Result := nil;
//  Result := Http_WinInet.Http_GetString(AUrl);
end;

function PostHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): PIOBuffer;
begin
  Result := nil;
//  Result := Http_WinInet.Http_GetString(AUrl);
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
  for i := 0 to SizeOf(AHttpBuffer.Data) - 1 do
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

end.
