unit dll_winhttp;

interface

uses
  atmcmbaseconst;

const
  winhttp = 'winhttp.dll';
  

const
  Winhttp_NO_REFERER              = nil;
  Winhttp_NO_PROXY_NAME           = nil;
  Winhttp_NO_PROXY_BYPASS         = nil;
  Winhttp_DEFAULT_ACCEPT_TYPES    = nil;
  Winhttp_ACCESS_TYPE_DEFAULT_PROXY = 0;
  Winhttp_ACCESS_TYPE_NO_PROXY    = 1;
  Winhttp_OPTION_PROXY            = 38;
  Winhttp_OPTION_PROXY_USERNAME   = $1002;
  Winhttp_OPTION_PROXY_PASSWORD   = $1003;

  Winhttp_AUTOPROXY_AUTO_DETECT   = $00000001;
  Winhttp_AUTOPROXY_CONFIG_URL    = $00000002;

  Winhttp_AUTO_DETECT_TYPE_DHCP   = $00000001;
  Winhttp_AUTO_DETECT_TYPE_DNS_A  = $00000002;

  Winhttp_FLAG_BYPASS_PROXY_CACHE = $00000100;
  WINHTTP_FLAG_SECURE             = $00800000;
  Winhttp_FLAG_REFRESH            = Winhttp_FLAG_BYPASS_PROXY_CACHE;

  WINHTTP_ADDREQ_FLAG_COALESCE    = $40000000;
  WINHTTP_QUERY_FLAG_NUMBER       = $20000000;

  function WinHttpOpen(pwszUserAgent: PWideChar; dwAccessType: DWORD;
    pwszProxyName, pwszProxyBypass: PWideChar; dwFlags: DWORD): HINTERNET; stdcall; external winhttp;
  function WinHttpConnect(hSession: HINTERNET; pswzServerName: PWideChar;
    nServerPort: INTERNET_PORT; dwReserved: DWORD): HINTERNET; stdcall; external winhttp;
  function WinHttpOpenRequest(hConnect: HINTERNET; pwszVerb: PWideChar;
    pwszObjectName: PWideChar; pwszVersion: PWideChar; pwszReferer: PWideChar;
    ppwszAcceptTypes: PLPWSTR; dwFlags: DWORD): HINTERNET; stdcall; external winhttp;
  function WinHttpCloseHandle(hInternet: HINTERNET): BOOL; stdcall; external winhttp;

  function WinHttpAddRequestHeaders(hRequest: HINTERNET; pwszHeaders: PWideChar; dwHeadersLength: DWORD;
    dwModifiers: DWORD): BOOL; stdcall; external winhttp;
  function WinHttpSendRequest(hRequest: HINTERNET; pwszHeaders: PWideChar;
    dwHeadersLength: DWORD; lpOptional: Pointer; dwOptionalLength: DWORD; dwTotalLength: DWORD;
    dwContext: DWORD): BOOL; stdcall; external winhttp;
  function WinHttpReceiveResponse(hRequest: HINTERNET;
    lpReserved: Pointer): BOOL; stdcall; external winhttp;
  function WinHttpQueryHeaders(hRequest: HINTERNET; dwInfoLevel: DWORD; pwszName: PWideChar;
    lpBuffer: Pointer; var lpdwBufferLength, lpdwIndex: DWORD): BOOL; stdcall; external winhttp;
  function WinHttpReadData(hRequest: HINTERNET; lpBuffer: Pointer;
    dwNumberOfBytesToRead: DWORD; var lpdwNumberOfBytesRead: DWORD): BOOL; stdcall; external winhttp;

type
  PWinhttpProxyInfo = ^TWinhttpProxyInfo;
  TWinhttpProxyInfo = record
    dwAccessType: DWORD;
    lpszProxy: LPWSTR;
    lpszProxyBypass: LPWSTR;
  end;

  PWinhttpAutoProxyOptions = ^TWinhttpAutoProxyOptions;
  TWinhttpAutoProxyOptions = record
    dwFlags: DWORD;
    dwAutoDetectFlags: DWORD;
    lpszAutoConfigUrl: LPCWSTR;
    lpvReserved: Pointer;
    dwReserved: DWORD;
    fAutoLogonIfChallenged: BOOL;
  end;

  PWinhttpCurrentUserIEProxyConfig = ^TWinhttpCurrentUserIEProxyConfig;
  TWinhttpCurrentUserIEProxyConfig = record
    fAutoDetect: BOOL;
    lpszAutoConfigUrl: LPWSTR;
    lpszProxy: LPWSTR;
    lpszProxyBypass: LPWSTR;
  end;

  function WinhttpQueryOption(hInet: HINTERNET; dwOption: DWORD;
    lpBuffer: Pointer; var lpdwBufferLength: DWORD): BOOL; stdcall; external Winhttp;
  function WinhttpGetProxyForUrl(hSession: HINTERNET; lpcwszUrl: LPCWSTR;
    pAutoProxyOptions: PWinhttpAUTOPROXYOPTIONS;
    var pProxyInfo: TWinhttpPROXYINFO): BOOL; stdcall; external Winhttp;
  function WinhttpGetIEProxyConfigForCurrentUser(
    var pProxyInfo: TWinhttpCURRENTUSERIEPROXYCONFIG): BOOL; stdcall; external Winhttp;

implementation

(*

function GetProxyInfo(const AURL: WideString; var AProxyInfo: TProxyInfo): DWORD;
var
  Session: HINTERNET;
  AutoDetectProxy: Boolean;
  WinhttpProxyInfo: TWinhttpProxyInfo;
  AutoProxyOptions: TWinhttpAutoProxyOptions;
  IEProxyConfig: TWinhttpCurrentUserIEProxyConfig;
begin
  Result := 0;
  AutoDetectProxy := False;
  if WinhttpGetIEProxyConfigForCurrentUser(IEProxyConfig) then
  begin
    if IEProxyConfig.fAutoDetect then
    begin
      AutoProxyOptions.dwFlags := Winhttp_AUTOPROXY_AUTO_DETECT;
      AutoProxyOptions.dwAutoDetectFlags := Winhttp_AUTO_DETECT_TYPE_DHCP or
        Winhttp_AUTO_DETECT_TYPE_DNS_A;
      AutoDetectProxy := True;
    end;
    if IEProxyConfig.lpszAutoConfigURL <> '' then
    begin
      AutoProxyOptions.dwFlags := AutoProxyOptions.dwFlags or Winhttp_AUTOPROXY_CONFIG_URL;
      AutoProxyOptions.lpszAutoConfigUrl := IEProxyConfig.lpszAutoConfigUrl;
      AutoDetectProxy := True;
    end;
    if not AutoDetectProxy then
    begin
      AProxyInfo.ProxyURL := IEProxyConfig.lpszProxy;
      AProxyInfo.ProxyBypass := IEProxyConfig.lpszProxyBypass;
      AProxyInfo.ProxyAutoDetected := False;
    end;
  end else
  begin
    AutoProxyOptions.dwFlags := Winhttp_AUTOPROXY_AUTO_DETECT;
    AutoProxyOptions.dwAutoDetectFlags := Winhttp_AUTO_DETECT_TYPE_DHCP or Winhttp_AUTO_DETECT_TYPE_DNS_A;
    AutoDetectProxy := True;
  end;
  if AutoDetectProxy then
  begin
    Session := WinhttpOpen(nil, Winhttp_ACCESS_TYPE_DEFAULT_PROXY, Winhttp_NO_PROXY_NAME, Winhttp_NO_PROXY_BYPASS, 0);
    if Assigned(Session) then
      try
        if WinhttpGetProxyForUrl(Session, LPCWSTR(AURL), @AutoProxyOptions, WinhttpProxyInfo) then
        begin
          AProxyInfo.ProxyURL := WinhttpProxyInfo.lpszProxy;
          AProxyInfo.ProxyBypass := WinhttpProxyInfo.lpszProxyBypass;
          AProxyInfo.ProxyAutoDetected := True;
        end else
          Result := GetLastError;
      finally
        WinhttpCloseHandle(Session);
      end
    else
      Result := GetLastError;
  end;
end;
*)

end.