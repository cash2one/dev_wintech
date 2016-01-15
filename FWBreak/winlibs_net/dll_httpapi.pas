unit dll_httpapi;

interface

uses
  atmcmbaseconst;

const
  httpapi = 'httpapi.dll';

type
  HTTP_URL_GROUP_ID = Pointer;
  HTTP_URL_CONTEXT  = Pointer;
  HTTP_SERVER_SESSION_ID = Pointer;
  PHTTP_SERVER_SESSION_ID = ^HTTP_SERVER_SESSION_ID;
  HTTPAPI_VERSION   = Pointer;
  THTTP_DATA_CHUNK = Pointer;
  PHTTP_DATA_CHUNK  = ^THTTP_DATA_CHUNK;
  THTTP_CACHE_POLICY = Pointer;
  PHTTP_CACHE_POLICY  = ^THTTP_CACHE_POLICY;
  THTTP_BYTE_RANGE = Pointer;
  PHTTP_BYTE_RANGE = ^THTTP_BYTE_RANGE;

  { HTTP Server API Version 1.0 Functions }
  { General }
  function HttpCreateHttpHandle( pReqQueueHandle: PHANDLE; Reserved: ULONG): DWORD; stdcall; external Httpapi name 'HttpCreateHttpHandle';
  function HttpInitialize(Version: HTTPAPI_VERSION; Flags: ULONG; pReserved: PVOID): DWORD; stdcall; external Httpapi name 'HttpInitialize';

    { flag : HTTP_INITIALIZE_CONFIG / HTTP_INITIALIZE_SERVER }
  function HttpTerminate(Flags: ULONG; pReserved: PVOID): DWORD; stdcall; external Httpapi name 'HttpTerminate';
  { Cache Management }
  function HttpAddFragmentToCache(ReqQueueHandle: THANDLE; pUrlPrefix: PWideChar;
    pDataChunk: PHTTP_DATA_CHUNK; pCachePolicy: PHTTP_CACHE_POLICY; pOverlapped: POVERLAPPED): DWORD; stdcall; external Httpapi name 'HttpAddFragmentToCache';
  function HttpFlushResponseCache(ReqQueueHandle: THANDLE; pUrlPrefix: PWideChar; Flags: ULONG; pOverlapped: POVERLAPPED): DWORD; stdcall; external Httpapi name 'HttpFlushResponseCache';
  function HttpReadFragmentFromCache(ReqQueueHandle: THANDLE; pUrlPrefix: PWideChar;
      pByteRange: PHTTP_BYTE_RANGE; pBuffer: PVOID; BufferLength: ULONG;
      pBytesRead: PULONG; pOverlapped: POVERLAPPED): DWORD; stdcall; external Httpapi name 'HttpReadFragmentFromCache';
  { Configuration }
  function HttpDeleteServiceConfiguration: DWORD; stdcall; external Httpapi name 'HttpDeleteServiceConfiguration';
  function HttpQueryServiceConfiguration: DWORD; stdcall; external Httpapi name 'HttpQueryServiceConfiguration';
  function HttpSetServiceConfiguration: DWORD; stdcall; external Httpapi name 'HttpSetServiceConfiguration';
  { Input and Output }
  function HttpReceiveHttpRequest: DWORD; stdcall; external Httpapi name 'HttpReceiveHttpRequest';
  function HttpReceiveRequestEntityBody: DWORD; stdcall; external Httpapi name 'HttpReceiveRequestEntityBody';
  function HttpSendHttpResponse: DWORD; stdcall; external Httpapi name 'HttpSendHttpResponse';
  function HttpSendResponseEntityBody: DWORD; stdcall; external Httpapi name 'HttpSendResponseEntityBody';
  function HttpWaitForDisconnect: DWORD; stdcall; external Httpapi name 'HttpWaitForDisconnect';
  { ssl }
  function HttpReceiveClientCertificate: DWORD; stdcall; external Httpapi name 'HttpReceiveClientCertificate';
  { URL Registration }
  function HttpAddUrl: DWORD; stdcall; external Httpapi name 'HttpAddUrl';
  function HttpRemoveUrl: DWORD; stdcall; external Httpapi name 'HttpRemoveUrl';
                              
  { HTTP Server API Version 2.0 Functions }
  { Server Session }
  function HttpCloseServerSession(ServerSessionId: HTTP_SERVER_SESSION_ID): DWORD; stdcall; external Httpapi name 'HttpCloseServerSession';
  function HttpCreateServerSession(Version: HTTPAPI_VERSION; pServerSessionId: PHTTP_SERVER_SESSION_ID; Reserved: DWORD): DWORD; stdcall; external Httpapi name 'HttpCreateServerSession';
  function HttpQueryServerSessionProperty: DWORD; stdcall; external Httpapi name 'HttpQueryServerSessionProperty';
  function HttpSetServerSessionProperty: DWORD; stdcall; external Httpapi name 'HttpSetServerSessionProperty';
  { URL Groups }
  function HttpAddUrlToUrlGroup(UrlGroupId: HTTP_URL_GROUP_ID;
      pFullyQualifiedUrl: PWideChar; UrlContext: HTTP_URL_CONTEXT; Reserved: DWORD): DWORD; stdcall; external Httpapi name 'HttpAddUrlToUrlGroup';
  function HttpCreateUrlGroup: DWORD; stdcall; external Httpapi name 'HttpCreateUrlGroup';
  function HttpCloseUrlGroup: DWORD; stdcall; external Httpapi name 'HttpCloseUrlGroup';
  function HttpQueryUrlGroupProperty: DWORD; stdcall; external Httpapi name 'HttpQueryUrlGroupProperty';
  function HttpRemoveUrlFromUrlGroup: DWORD; stdcall; external Httpapi name 'HttpRemoveUrlFromUrlGroup';
  function HttpSetUrlGroupProperty: DWORD; stdcall; external Httpapi name 'HttpSetUrlGroupProperty';
  { Request Queue }
  function HttpCancelHttpRequest: DWORD; stdcall; external Httpapi name 'HttpCancelHttpRequest';
  function HttpCloseRequestQueue: DWORD; stdcall; external Httpapi name 'HttpCloseRequestQueue';
  function HttpCreateRequestQueue: DWORD; stdcall; external Httpapi name 'HttpCreateRequestQueue';
  function HttpQueryRequestQueueProperty: DWORD; stdcall; external Httpapi name 'HttpQueryRequestQueueProperty';
  function HttpSetRequestQueueProperty: DWORD; stdcall; external Httpapi name 'HttpSetRequestQueueProperty';
  function HttpShutdownRequestQueue: DWORD; stdcall; external Httpapi name 'HttpShutdownRequestQueue';
  function HttpWaitForDemandStart: DWORD; stdcall; external Httpapi name 'HttpWaitForDemandStart';
  
implementation

end.