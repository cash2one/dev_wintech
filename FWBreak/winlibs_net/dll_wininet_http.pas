unit dll_wininet_http;

interface

uses
  atmcmbaseconst, winconst, wintype, dll_wininet;
                         
const
{ the default major/minor HTTP version numbers }
  HTTP_MAJOR_VERSION = 1;
  HTTP_MINOR_VERSION = 0;
  HTTP_VERSION_10    = 'HTTP/1.0';
  HTTP_VERSION_11    = 'HTTP/1.1';

{ HttpQueryInfo info levels. Generally, there is one info level }
{ for each potential RFC822/HTTP/MIME header that an HTTP server }
{ may send as part of a request response. }

{ The HTTP_QUERY_RAW_HEADERS info level is provided for clients }
{ that choose to perform their own header parsing. }

  HTTP_QUERY_MIME_VERSION                     = 0;
  HTTP_QUERY_CONTENT_TYPE                     = 1;
  HTTP_QUERY_CONTENT_TRANSFER_ENCODING        = 2;
  HTTP_QUERY_CONTENT_ID                       = 3;
  HTTP_QUERY_CONTENT_DESCRIPTION              = 4;
  HTTP_QUERY_CONTENT_LENGTH                   = 5;
  HTTP_QUERY_CONTENT_LANGUAGE                 = 6;
  HTTP_QUERY_ALLOW                            = 7;
  HTTP_QUERY_PUBLIC                           = 8;
  HTTP_QUERY_DATE                             = 9;
  HTTP_QUERY_EXPIRES                          = 10;
  HTTP_QUERY_LAST_MODIFIED                    = 11;
  HTTP_QUERY_MESSAGE_ID                       = 12;
  HTTP_QUERY_URI                              = 13;
  HTTP_QUERY_DERIVED_FROM                     = 14;
  HTTP_QUERY_COST                             = 15;
  HTTP_QUERY_LINK                             = 16;
  HTTP_QUERY_PRAGMA                           = 17;
  HTTP_QUERY_VERSION                          = 18; { special: part of status line }
  HTTP_QUERY_STATUS_CODE                      = 19; { special: part of status line }
  HTTP_QUERY_STATUS_TEXT                      = 20; { special: part of status line }
  HTTP_QUERY_RAW_HEADERS                      = 21; { special: all headers as ASCIIZ }
  HTTP_QUERY_RAW_HEADERS_CRLF                 = 22; { special: all headers }
  HTTP_QUERY_CONNECTION                       = 23;
  HTTP_QUERY_ACCEPT                           = 24;
  HTTP_QUERY_ACCEPT_CHARSET                   = 25;
  HTTP_QUERY_ACCEPT_ENCODING                  = 26;
  HTTP_QUERY_ACCEPT_LANGUAGE                  = 27;
  HTTP_QUERY_AUTHORIZATION                    = 28;
  HTTP_QUERY_CONTENT_ENCODING                 = 29;
  HTTP_QUERY_FORWARDED                        = 30;
  HTTP_QUERY_FROM                             = 31;
  HTTP_QUERY_IF_MODIFIED_SINCE                = 32;
  HTTP_QUERY_LOCATION                         = 33;
  HTTP_QUERY_ORIG_URI                         = 34;
  HTTP_QUERY_REFERER                          = 35;
  HTTP_QUERY_RETRY_AFTER                      = 36;
  HTTP_QUERY_SERVER                           = 37;
  HTTP_QUERY_TITLE                            = 38;
  HTTP_QUERY_USER_AGENT                       = 39;
  HTTP_QUERY_WWW_AUTHENTICATE                 = 40;
  HTTP_QUERY_PROXY_AUTHENTICATE               = 41;
  HTTP_QUERY_ACCEPT_RANGES                    = 42;
  HTTP_QUERY_SET_COOKIE                       = 43;
  HTTP_QUERY_COOKIE                           = 44;
  HTTP_QUERY_REQUEST_METHOD                   = 45;  { special: GET/POST etc. }
  HTTP_QUERY_REFRESH                          = 46;
  HTTP_QUERY_CONTENT_DISPOSITION              = 47;

{ HTTP 1.1 defined headers }

  HTTP_QUERY_AGE                              = 48;
  HTTP_QUERY_CACHE_CONTROL                    = 49;
  HTTP_QUERY_CONTENT_BASE                     = 50;
  HTTP_QUERY_CONTENT_LOCATION                 = 51;
  HTTP_QUERY_CONTENT_MD5                      = 52;
  HTTP_QUERY_CONTENT_RANGE                    = 53;
  HTTP_QUERY_ETAG                             = 54;
  HTTP_QUERY_HOST                             = 55;
  HTTP_QUERY_IF_MATCH                         = 56;
  HTTP_QUERY_IF_NONE_MATCH                    = 57;
  HTTP_QUERY_IF_RANGE                         = 58;
  HTTP_QUERY_IF_UNMODIFIED_SINCE              = 59;
  HTTP_QUERY_MAX_FORWARDS                     = 60;
  HTTP_QUERY_PROXY_AUTHORIZATION              = 61;
  HTTP_QUERY_RANGE                            = 62;
  HTTP_QUERY_TRANSFER_ENCODING                = 63;
  HTTP_QUERY_UPGRADE                          = 64;
  HTTP_QUERY_VARY                             = 65;
  HTTP_QUERY_VIA                              = 66;
  HTTP_QUERY_WARNING                          = 67;
  HTTP_QUERY_MAX                              = 67;

{ HTTP_QUERY_CUSTOM - if this special value is supplied as the dwInfoLevel }
{ parameter of HttpQueryInfo then the lpBuffer parameter contains the name }
{ of the header we are to query }
  HTTP_QUERY_CUSTOM                           = 65535;

{ HTTP_QUERY_FLAG_REQUEST_HEADERS - if this bit is set in the dwInfoLevel }
{ parameter of HttpQueryInfo then the request headers will be queried for the }
{ request information }
  HTTP_QUERY_FLAG_REQUEST_HEADERS             = $80000000;

{ HTTP_QUERY_FLAG_SYSTEMTIME - if this bit is set in the dwInfoLevel parameter }
{ of HttpQueryInfo AND the header being queried contains date information, }
{ e.g. the "Expires:" header then lpBuffer will contain a SYSTEMTIME structure }
{ containing the date and time information converted from the header string }
  HTTP_QUERY_FLAG_SYSTEMTIME                  = $40000000;

{ HTTP_QUERY_FLAG_NUMBER - if this bit is set in the dwInfoLevel parameter of }
{ HttpQueryInfo, then the value of the header will be converted to a number }
{ before being returned to the caller, if applicable }
  HTTP_QUERY_FLAG_NUMBER                      = $20000000;

{ HTTP_QUERY_FLAG_COALESCE - combine the values from several headers of the }
{ same name into the output buffer }
  HTTP_QUERY_FLAG_COALESCE                    = $10000000;

  HTTP_QUERY_MODIFIER_FLAGS_MASK              = HTTP_QUERY_FLAG_REQUEST_HEADERS or
                                                HTTP_QUERY_FLAG_SYSTEMTIME or
                                                HTTP_QUERY_FLAG_NUMBER or
                                                HTTP_QUERY_FLAG_COALESCE;

  HTTP_QUERY_HEADER_MASK                      = not HTTP_QUERY_MODIFIER_FLAGS_MASK;

{  HTTP Response Status Codes: }
  HTTP_STATUS_CONTINUE            = 100;    { OK to continue with request }
  HTTP_STATUS_SWITCH_PROTOCOLS    = 101;    { server has switched protocols in upgrade header }
  HTTP_STATUS_OK                  = 200;    { request completed }
  HTTP_STATUS_CREATED             = 201;    { object created, reason = new URI }
  HTTP_STATUS_ACCEPTED            = 202;    { async completion (TBS) }
  HTTP_STATUS_PARTIAL             = 203;    { partial completion }
  HTTP_STATUS_NO_CONTENT          = 204;    { no info to return }
  HTTP_STATUS_RESET_CONTENT       = 205;    { request completed, but clear form }
  HTTP_STATUS_PARTIAL_CONTENT     = 206;    { partial GET furfilled }
  HTTP_STATUS_AMBIGUOUS           = 300;    { server couldn't decide what to return }
  HTTP_STATUS_MOVED               = 301;    { object permanently moved }
  HTTP_STATUS_REDIRECT            = 302;    { object temporarily moved }
  HTTP_STATUS_REDIRECT_METHOD     = 303;    { redirection w/ new access method }
  HTTP_STATUS_NOT_MODIFIED        = 304;    { if-modified-since was not modified }
  HTTP_STATUS_USE_PROXY           = 305;    { redirection to proxy, location header specifies proxy to use }
  HTTP_STATUS_REDIRECT_KEEP_VERB  = 307;    { HTTP/1.1: keep same verb }
  HTTP_STATUS_BAD_REQUEST         = 400;    { invalid syntax }
  HTTP_STATUS_DENIED              = 401;    { access denied }
  HTTP_STATUS_PAYMENT_REQ         = 402;    { payment required }
  HTTP_STATUS_FORBIDDEN           = 403;    { request forbidden }
  HTTP_STATUS_NOT_FOUND           = 404;    { object not found }
  HTTP_STATUS_BAD_METHOD          = 405;    { method is not allowed }
  HTTP_STATUS_NONE_ACCEPTABLE     = 406;    { no response acceptable to client found }
  HTTP_STATUS_PROXY_AUTH_REQ      = 407;    { proxy authentication required }
  HTTP_STATUS_REQUEST_TIMEOUT     = 408;    { server timed out waiting for request }
  HTTP_STATUS_CONFLICT            = 409;    { user should resubmit with more info }
  HTTP_STATUS_GONE                = 410;    { the resource is no longer available }
  HTTP_STATUS_AUTH_REFUSED        = 411;    { couldn't authorize client }
  HTTP_STATUS_PRECOND_FAILED      = 412;    { precondition given in request failed }
  HTTP_STATUS_REQUEST_TOO_LARGE   = 413;    { request entity was too large }
  HTTP_STATUS_URI_TOO_LONG        = 414;    { request URI too long }
  HTTP_STATUS_UNSUPPORTED_MEDIA   = 415;    { unsupported media type }
  HTTP_STATUS_SERVER_ERROR        = 500;    { internal server error }
  HTTP_STATUS_NOT_SUPPORTED       = 501;    { required not supported }
  HTTP_STATUS_BAD_GATEWAY         = 502;    { error response received from gateway }
  HTTP_STATUS_SERVICE_UNAVAIL     = 503;    { temporarily overloaded }
  HTTP_STATUS_GATEWAY_TIMEOUT     = 504;    { timed out waiting for gateway }
  HTTP_STATUS_VERSION_NOT_SUP     = 505;    { HTTP version not supported }
  HTTP_STATUS_FIRST               = HTTP_STATUS_CONTINUE;
  HTTP_STATUS_LAST                = HTTP_STATUS_VERSION_NOT_SUP;
  
{ values for dwModifiers parameter of HttpAddRequestHeaders }

  HTTP_ADDREQ_INDEX_MASK          = $0000FFFF;
  HTTP_ADDREQ_FLAGS_MASK          = $FFFF0000;

{ HTTP_ADDREQ_FLAG_ADD_IF_NEW - the header will only be added if it doesn't }
{ already exist }

  HTTP_ADDREQ_FLAG_ADD_IF_NEW     = $10000000;

{ HTTP_ADDREQ_FLAG_ADD - if HTTP_ADDREQ_FLAG_REPLACE is set but the header is }
{ not found then if this flag is set, the header is added anyway, so long as }
{ there is a valid header-value }

  HTTP_ADDREQ_FLAG_ADD            = $20000000;

{ HTTP_ADDREQ_FLAG_COALESCE - coalesce headers with same name. e.g. }
{ "Accept: text/*" and "Accept: audio/*" with this flag results in a single }
{ header: "Accept: text/*, audio/*" }

  HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA           = $40000000;
  HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON       = $01000000;
  HTTP_ADDREQ_FLAG_COALESCE                      = HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA;

{ HTTP_ADDREQ_FLAG_REPLACE - replaces the specified header. Only one header can }
{ be supplied in the buffer. If the header to be replaced is not the first }
{ in a list of headers with the same name, then the relative index should be }
{ supplied in the low 8 bits of the dwModifiers parameter. If the header-value }
{ part is missing, then the header is removed }

  HTTP_ADDREQ_FLAG_REPLACE        = $80000000;
                          
  function HttpSendRequest(hRequest: HINTERNET; lpszHeaders: PAnsiChar;
    dwHeadersLength: DWORD; lpOptional: Pointer; 
    dwOptionalLength: DWORD): BOOL; stdcall; external wininet name 'HttpSendRequestA';

  function HttpSendRequestEx(hRequest: HINTERNET; lpBuffersIn: PInternetBuffers; lpBuffersOut: PInternetBuffers;
    dwFlags: DWORD; dwContext: DWORD): BOOL; stdcall; external wininet name 'HttpSendRequestExA';
    
  function HttpOpenRequest(hConnect: HINTERNET; lpszVerb: PAnsiChar;
    lpszObjectName: PAnsiChar; lpszVersion: PAnsiChar; lpszReferrer: PAnsiChar;
    lplpszAcceptTypes: PLPSTR; dwFlags: DWORD;
    dwContext: DWORD): HINTERNET; stdcall; external wininet name 'HttpOpenRequestA';
  function HttpAddRequestHeaders(hRequest: HINTERNET; lpszHeaders: PAnsiChar;
    dwHeadersLength: DWORD; dwModifiers: DWORD): BOOL; stdcall; external wininet name 'HttpAddRequestHeadersA';
                      
  function HttpQueryInfo(hRequest: HINTERNET; dwInfoLevel: DWORD;
    lpvBuffer: Pointer; var lpdwBufferLength: DWORD;
    var lpdwReserved: DWORD): BOOL; stdcall; external wininet name 'HttpQueryInfoA';
                        
  function HttpEndRequest(hRequest: HINTERNET; lpBuffersOut: PInternetBuffers; dwFlags: DWORD;
    dwContext: DWORD): BOOL; stdcall; external wininet name 'HttpEndRequestA';

implementation

end.
