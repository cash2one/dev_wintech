unit dll_wininet;

interface

uses
  atmcmbaseconst, winconst, wintype;

const
  wininet                  = 'wininet.dll';

type
  HINTERNET       = Pointer;
  INTERNET_PORT   = Word;
  LPCTSTR = PAnsiChar;
                                    
  INTERNET_STATUS_CALLBACK = TFarProc;
  TFNInternetStatusCallback = INTERNET_STATUS_CALLBACK;
  PFNInternetStatusCallback = ^TFNInternetStatusCallback;
  LPINTERNET_STATUS_CALLBACK = PFNInternetStatusCallback;

  PInternetBuffersA = ^INTERNET_BUFFERSA;
  PInternetBuffers = PInternetBuffersA;
  INTERNET_BUFFERSA = record
    dwStructSize: DWORD;      { used for API versioning. Set to sizeof(INTERNET_BUFFERS) }
    Next: PInternetBuffers;   { chain of buffers }
    lpcszHeader: PAnsiChar;       { pointer to headers (may be NULL) }
    dwHeadersLength: DWORD;   { length of headers if not NULL }
    dwHeadersTotal: DWORD;    { size of headers if not enough buffer }
    lpvBuffer: Pointer;       { pointer to data buffer (may be NULL) }
    dwBufferLength: DWORD;    { length of data buffer if not NULL }
    dwBufferTotal: DWORD;     { total size of chunk, or content-length if not chunked }
    dwOffsetLow: DWORD;       { used for read-ranges (only used in HttpSendRequest2) }
    dwOffsetHigh: DWORD;
  end;
  TInternetBuffersA = INTERNET_BUFFERSA;
  LPINTERNET_BUFFERSA = PInternetBuffersA;
  INTERNET_BUFFERS = INTERNET_BUFFERSA;

const                       
  wininet_HTTP_MAJOR_VERSION        = 1;
  wininet_HTTP_MINOR_VERSION        = 0;
  wininet_HTTP_VERSION              = 'HTTP/1.0';
  wininet_AcceptEncoding            = 'Accept-Encoding: gzip,deflate';
                              
  wininet_Http_Verb_Post            = 'POST';
  wininet_Http_Verb_Get             = 'GET';

  HTTP_ADDREQ_FLAG_ADD              = $20000000;
  HTTP_ADDREQ_FLAG_REPLACE          = $80000000;

  HTTP_QUERY_CONTENT_LENGTH         = 5;

  INTERNET_OPEN_TYPE_PRECONFIG      = 0;  { use registry configuration }
  INTERNET_OPEN_TYPE_DIRECT         = 1;  { direct to net }
  INTERNET_OPEN_TYPE_PROXY          = 3;  { via named proxy }
  INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY  = 4;   { prevent using java/script/INS }
                                              
  INTERNET_SERVICE_URL              = 0;
  INTERNET_SERVICE_FTP              = 1;
  INTERNET_SERVICE_GOPHER           = 2;
  INTERNET_SERVICE_HTTP             = 3;
                             
  INTERNET_INVALID_PORT_NUMBER      = 0;                 { use the protocol-specific default }
  INTERNET_DEFAULT_FTP_PORT         = 21;                   { default for FTP servers }
  INTERNET_DEFAULT_GOPHER_PORT      = 70;                {    "     "  gopher " }
  INTERNET_DEFAULT_HTTP_PORT        = 80;                  {    "     "  HTTP   " }
  INTERNET_DEFAULT_HTTPS_PORT       = 443;                {    "     "  HTTPS  " }
  INTERNET_DEFAULT_SOCKS_PORT       = 1080;               { default for SOCKS firewall servers.}

  MAX_CACHE_ENTRY_INFO_SIZE         = 4096;
                         
  INTERNET_FLAG_RELOAD              = $80000000;                 { retrieve the original item }

  INTERNET_FLAG_RAW_DATA            = $40000000;               { receive the item as raw data }
  INTERNET_FLAG_EXISTING_CONNECT    = $20000000;       { do not create new connection object }

{ flags for InternetOpen: }

  INTERNET_FLAG_ASYNC               = $10000000;                  { this request is asynchronous (where supported) }

{ protocol-specific flags: }

  INTERNET_FLAG_PASSIVE             = $08000000;                { used for FTP connections }

{ additional cache flags }

  INTERNET_FLAG_NO_CACHE_WRITE      = $04000000;  { don't write this item to the cache }
  INTERNET_FLAG_DONT_CACHE          = INTERNET_FLAG_NO_CACHE_WRITE;
  INTERNET_FLAG_MAKE_PERSISTENT     = $02000000;  { make this item persistent in cache }
  INTERNET_FLAG_FROM_CACHE          = $01000000;  { use offline semantics }
  INTERNET_FLAG_OFFLINE             = $01000000;  { use offline semantics }

{ additional flags }

  INTERNET_FLAG_SECURE              = $00800000;  { use PCT/SSL if applicable (HTTP) }
  INTERNET_FLAG_KEEP_CONNECTION     = $00400000;  { use keep-alive semantics }
  INTERNET_FLAG_NO_AUTO_REDIRECT    = $00200000;  { don't handle redirections automatically }
  INTERNET_FLAG_READ_PREFETCH       = $00100000;  { do background read prefetch }
  INTERNET_FLAG_NO_COOKIES          = $00080000;  { no automatic cookie handling }
  INTERNET_FLAG_NO_AUTH             = $00040000;  { no automatic authentication handling }
  INTERNET_FLAG_CACHE_IF_NET_FAIL   = $00010000;  { return cache file if net request fails }

{ Security Ignore Flags, Allow HttpOpenRequest to overide
  Secure Channel (SSL/PCT) failures of the following types. }

  INTERNET_FLAG_IGNORE_CERT_CN_INVALID        = $00001000; { bad common name in X509 Cert. }
  INTERNET_FLAG_IGNORE_CERT_DATE_INVALID      = $00002000; { expired X509 Cert. }
  INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS      = $00004000; { ex: http:// to https:// }
  INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP       = $00008000; { ex: https:// to http:// }

//
// more caching flags
//

  INTERNET_FLAG_RESYNCHRONIZE       = $00000800;  // asking wininet to update an item if it is newer
  INTERNET_FLAG_HYPERLINK           = $00000400;  // asking wininet to do hyperlinking semantic which works right for scripts
  INTERNET_FLAG_NO_UI               = $00000200;  // no cookie popup
  INTERNET_FLAG_PRAGMA_NOCACHE      = $00000100;  // asking wininet to add "pragma: no-cache"
  INTERNET_FLAG_CACHE_ASYNC         = $00000080;  // ok to perform lazy cache-write
  INTERNET_FLAG_FORMS_SUBMIT        = $00000040;  // this is a forms submit
  INTERNET_FLAG_NEED_FILE           = $00000010;  // need a file for this request
  INTERNET_FLAG_MUST_CACHE_REQUEST  = INTERNET_FLAG_NEED_FILE;
                                   
  INTERNET_OPTION_HTTP_DECODING     = 65;
                                             
  INTERNET_OPTION_CALLBACK          = 1;
  INTERNET_OPTION_CONNECT_TIMEOUT   = 2;
  INTERNET_OPTION_CONNECT_RETRIES   = 3;
  INTERNET_OPTION_CONNECT_BACKOFF   = 4;
  INTERNET_OPTION_SEND_TIMEOUT      = 5;
  INTERNET_OPTION_CONTROL_SEND_TIMEOUT       = INTERNET_OPTION_SEND_TIMEOUT;
  INTERNET_OPTION_RECEIVE_TIMEOUT   = 6;
  INTERNET_OPTION_CONTROL_RECEIVE_TIMEOUT    = INTERNET_OPTION_RECEIVE_TIMEOUT;
  INTERNET_OPTION_DATA_SEND_TIMEOUT = 7;
  INTERNET_OPTION_DATA_RECEIVE_TIMEOUT = 8;
  INTERNET_OPTION_HANDLE_TYPE       = 9;
  INTERNET_OPTION_READ_BUFFER_SIZE  = 12;
  INTERNET_OPTION_WRITE_BUFFER_SIZE = 13;
  INTERNET_OPTION_ASYNC_ID          = 15;
  INTERNET_OPTION_ASYNC_PRIORITY    = 16;
  INTERNET_OPTION_PARENT_HANDLE     = 21;
  INTERNET_OPTION_KEEP_CONNECTION   = 22;
  INTERNET_OPTION_REQUEST_FLAGS     = 23;
  INTERNET_OPTION_EXTENDED_ERROR    = 24;
  INTERNET_OPTION_OFFLINE_MODE      = 26;
  INTERNET_OPTION_CACHE_STREAM_HANDLE         = 27;
  INTERNET_OPTION_USERNAME          = 28;
  INTERNET_OPTION_PASSWORD          = 29;
  INTERNET_OPTION_ASYNC             = 30;
  INTERNET_OPTION_SECURITY_FLAGS    = 31;
  INTERNET_OPTION_SECURITY_CERTIFICATE_STRUCT = 32;
  INTERNET_OPTION_DATAFILE_NAME     = 33;
  INTERNET_OPTION_URL               = 34;
  INTERNET_OPTION_SECURITY_CERTIFICATE        = 35;
  INTERNET_OPTION_SECURITY_KEY_BITNESS        = 36;
  INTERNET_OPTION_REFRESH           = 37;
  INTERNET_OPTION_PROXY             = 38;
                                              
  INTERNET_OPTION_SETTINGS_CHANGED            = 39;
  INTERNET_OPTION_VERSION                     = 40;
  INTERNET_OPTION_USER_AGENT                  = 41;
  INTERNET_OPTION_END_BROWSER_SESSION         = 42;
  INTERNET_OPTION_PROXY_USERNAME              = 43;
  INTERNET_OPTION_PROXY_PASSWORD              = 44;
  INTERNET_OPTION_CONTEXT_VALUE               = 45;
  INTERNET_OPTION_CONNECT_LIMIT               = 46;
  INTERNET_OPTION_SECURITY_SELECT_CLIENT_CERT = 47;
  INTERNET_OPTION_POLICY                      = 48;
  INTERNET_OPTION_DISCONNECTED_TIMEOUT        = 49;
  INTERNET_OPTION_CONNECTED_STATE             = 50;
  INTERNET_OPTION_IDLE_STATE                  = 51;
  INTERNET_OPTION_OFFLINE_SEMANTICS           = 52;
  INTERNET_OPTION_SECONDARY_CACHE_KEY         = 53;
  INTERNET_OPTION_CALLBACK_FILTER             = 54;
  INTERNET_OPTION_CONNECT_TIME                = 55;
  INTERNET_OPTION_SEND_THROUGHPUT             = 56;
  INTERNET_OPTION_RECEIVE_THROUGHPUT          = 57;
  INTERNET_OPTION_REQUEST_PRIORITY            = 58;
  INTERNET_OPTION_HTTP_VERSION                = 59;
  INTERNET_OPTION_RESET_URLCACHE_SESSION      = 60;
  INTERNET_OPTION_ERROR_MASK                  = 62;
  
  function InternetConnect(AInet: HINTERNET; lpszServerName: PAnsiChar;
    nServerPort: INTERNET_PORT; lpszUsername: PAnsiChar; lpszPassword: PAnsiChar;
    dwService: DWORD; dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall; external wininet name 'InternetConnectA';
  function InternetAttemptConnect(dwReserved: DWORD): DWORD; stdcall; external wininet name 'InternetAttemptConnect';
  function InternetHangUp(dwConnection: DWORD; dwReserved: DWORD): DWORD; stdcall; external wininet name 'InternetHangUp';

  function InternetAutodial(dwFlags: DWORD; dwReserved: DWORD): BOOL; stdcall; external wininet name 'InternetAutodial';
  function InternetAutodialHangup(dwReserved: DWORD): BOOL; stdcall; external wininet name 'InternetAutodialHangup';

  function InternetOpen(lpszAgent: PAnsiChar; dwAccessType: DWORD;
    lpszProxy, lpszProxyBypass: PAnsiChar; dwFlags: DWORD): HINTERNET; stdcall; external wininet name 'InternetOpenA';
  function InternetCloseHandle(AInet: HINTERNET): BOOL; stdcall; external wininet name 'InternetCloseHandle';
  function InternetAuthNotifyCallback(dwContext: DWORD;     { as passed to InternetErrorDlg }
    dwReturn: DWORD;      { error code: success, resend, or cancel }
    lpReserved: Pointer   { reserved: will be set to null }): DWORD; stdcall; external wininet name 'InternetAuthNotifyCallback';
  function InternetDial(hwndParent: HWND; lpszConnectoid: LPTSTR; dwFlags: DWORD;
    lpdwConnection: LPDWORD; dwReserved: DWORD): DWORD; stdcall; external wininet name 'InternetDial';
  function InternetSetDialState(lpszConnectoid: LPCTSTR; dwState: DWORD; dwReserved: DWORD): BOOL; stdcall; external wininet name 'InternetSetDialState';

  function InternetSetOption(AInet: HINTERNET; dwOption: DWORD; lpBuffer: Pointer;
      dwBufferLength: DWORD): BOOL; stdcall; external wininet name 'InternetSetOptionA';
  function InternetQueryOption(AInet: HINTERNET; dwOption: DWORD; lpBuffer: Pointer;
    var lpdwBufferLength: DWORD): BOOL; stdcall; external wininet name 'InternetQueryOptionA';

  { ÅÐ¶ÏÍøÂçÊÇ·ñÁªÍ¨ }
  // ConTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY
  // if InternetGetConnectedState(@ConTypes, 0) then //ConTypes := $01 + $02 + $04; 
  function InternetGetConnectedState(lpdwFlags: LPDWORD; dwReserved: DWORD): BOOL; stdcall; external wininet name 'InternetGetConnectedState';
  // if InternetCheckConnection('http://www.microsoft.com/', 1, 0) then
  function InternetCheckConnection(lpszUrl: PAnsiChar; dwFlags: DWORD; dwReserved: DWORD): BOOL; stdcall; external wininet name 'InternetCheckConnectionA';
    
  function InternetReadFile(AFile: HINTERNET; lpBuffer: Pointer;
    dwNumberOfBytesToRead: DWORD; var lpdwNumberOfBytesRead: DWORD): BOOL; stdcall; external wininet name 'InternetReadFile';
  function InternetWriteFile(AFile: HINTERNET; lpBuffer: Pointer; dwNumberOfBytesToWrite: DWORD;
    var lpdwNumberOfBytesWritten: DWORD): BOOL; stdcall; external wininet name 'InternetWriteFile';
  function InternetSetFilePointer(AFile: HINTERNET; lDistanceToMove: Longint; pReserved: Pointer;
    dwMoveMethod, dwContext: DWORD): DWORD; stdcall; external wininet name 'InternetSetFilePointer';
  function InternetLockRequestFile(hInternet: HINTERNET; lphLockRequestInfo: PHandle): BOOL; stdcall; external wininet name 'InternetLockRequestFile';
  function InternetUnlockRequestFile(hLockRequestInfo: THANDLE): BOOL; stdcall; external wininet name 'InternetUnlockRequestFile';

  function InternetSetCookie(lpszUrl, lpszCookieName, lpszCookieData: PAnsiChar): BOOL; stdcall; external wininet name 'InternetSetCookieA';
  function InternetGetCookie(lpszUrl, lpszCookieName, lpszCookieData: PAnsiChar;
    var lpdwSize: DWORD): BOOL; stdcall; external wininet name 'InternetGetCookieA';

  function InternetOpenUrl(AInet: HINTERNET; lpszUrl: PAnsiChar; lpszHeaders: PAnsiChar; dwHeadersLength: DWORD; dwFlags: DWORD;
    dwContext: DWORD): HINTERNET; stdcall; external wininet name 'InternetOpenUrlA';
  function InternetQueryDataAvailable(AFile: HINTERNET; var lpdwNumberOfBytesAvailable: DWORD;
    dwFlags, dwContext: DWORD): BOOL; stdcall; external wininet name 'InternetQueryDataAvailable';
  function InternetSetStatusCallback(AInet: HINTERNET;
    lpfnInternetCallback: PFNInternetStatusCallback): PFNInternetStatusCallback; stdcall; external wininet name 'InternetSetStatusCallback';
  function InternetTimeFromSystemTime(const pst: TSystemTime; dwRFC: DWORD; lpszTime: LPSTR;
    cbTime: DWORD): BOOL; stdcall; external wininet name 'InternetTimeFromSystemTime';
  function InternetGetLastResponseInfo(var lpdwError: DWORD; lpszBuffer: PAnsiChar;
    var lpdwBufferLength: DWORD): BOOL; stdcall; external wininet name 'InternetGetLastResponseInfoA';

implementation

end.
