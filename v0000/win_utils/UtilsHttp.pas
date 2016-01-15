unit UtilsHttp;

interface

uses
  Windows, ActiveX, UrlMon;

  function GetHttpUrlData(AUrl: string): string; overload;      
  function GetHttpUrlData(AUrl: string; APost: string): string; overload;
  function GetHttpUrlFile(AUrl: string; AOutputFile: string): Boolean; overload;

  function PostHttpUrlData(AUrl: string; APost: string): string;     

  function GetDefaultUserAgent: string;  

implementation

uses
  UtilsHttp_Indy;

function GetDefaultUserAgent: string;
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
  Result := string(s);
end;
  
function GetHttpUrlData(AUrl: string): string;
begin
  //Result := Http_WinInet.Http_GetString(AUrl);     
  Result := UtilsHttp_Indy.Http_GetString(AUrl);
end;

function GetHttpUrlFile(AUrl: string; AOutputFile: string): Boolean;
begin    
  Result := UtilsHttp_Indy.Http_GetFile(AUrl, AOutputFile);
end;

function GetHttpUrlData(AUrl: string; APost: string): string;
begin          
  Result := '';
//  Result := Http_WinInet.Http_GetString(AUrl);
end;

function PostHttpUrlData(AUrl: string; APost: string): string;
begin
  Result := '';
//  Result := Http_WinInet.Http_GetString(AUrl);
end;

end.
