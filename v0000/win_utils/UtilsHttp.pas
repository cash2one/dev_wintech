unit UtilsHttp;

interface

uses
  Windows, ActiveX, UrlMon;

type
  PNetClientSession = ^TNetClientSession;
  TNetClientSession = record
    Connection: Pointer;
  end;

  function CheckOutNetClientSession: PNetClientSession;
  procedure CheckInNetClientSession(var ANetClientSession: PNetClientSession);

  function GetHttpUrlData(AUrl: AnsiString; ANetSession: PNetClientSession): string; overload;      
  function GetHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): string; overload;
  function GetHttpUrlFile(AUrl: AnsiString; AOutputFile: AnsiString; ANetSession: PNetClientSession): Boolean; overload;

  function PostHttpUrlData(AUrl: AnsiString; APost: AnsiString; ANetSession: PNetClientSession): string;

  function GetDefaultUserAgent: AnsiString;  

implementation

uses
  UtilsHttp_Indy;

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
  
function GetHttpUrlData(AUrl: string; ANetSession: PNetClientSession): string;
var
  tmpIndyConnection: PIndyConnection;
begin    
  tmpIndyConnection := nil;
  if nil <> ANetSession then
  begin
    if nil = ANetSession.Connection then
    begin
      ANetSession.Connection := CheckOutIndyConnection;
    end;
    tmpIndyConnection := ANetSession.Connection;
  end;
  //Result := Http_WinInet.Http_GetString(AUrl);
  Result := UtilsHttp_Indy.Http_GetString(AUrl, tmpIndyConnection);
end;

function GetHttpUrlFile(AUrl: AnsiString; AOutputFile: AnsiString; ANetSession: PNetClientSession): Boolean;
var
  tmpIndyConnection: PIndyConnection;
begin    
  tmpIndyConnection := nil;     
  if nil <> ANetSession then
  begin
    if nil = ANetSession.Connection then
    begin
    end;
  end;
  Result := UtilsHttp_Indy.Http_GetFile(AUrl, AOutputFile, tmpIndyConnection);
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
