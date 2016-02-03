unit UtilsHttp;

interface

uses
  Windows, ActiveX, UrlMon;

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

  function CheckOutNetClientSession: PNetClientSession;
  procedure CheckInNetClientSession(var ANetClientSession: PNetClientSession);

  function GetHttpUrlData(AUrl: AnsiString; ANetSession: PNetClientSession): string; overload;      
  function GetHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): string; overload;
  function GetHttpUrlFile(AUrl: AnsiString; AOutputFile: AnsiString; ANetSession: PNetClientSession): Boolean; overload;

  function PostHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): string;

  function GetDefaultUserAgent: AnsiString;    
  function ParseHttpUrlInfo(AUrl: AnsiString; AInfo: PHttpUrlInfo): Boolean;

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

function GetHttpUrlData(AUrl: AnsiString; ANetSession: PNetClientSession): string;
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

function GetHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): string;
begin          
  Result := '';
//  Result := Http_WinInet.Http_GetString(AUrl);
end;

function PostHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): string;
begin
  Result := '';
//  Result := Http_WinInet.Http_GetString(AUrl);
end;

end.
