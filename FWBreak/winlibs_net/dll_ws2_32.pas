unit dll_ws2_32;

interface

uses
 atmcmbaseconst, winconst, wintype, winconst_sock;

const
  ws2_32              = 'ws2_32.dll';  // winsock2
type                           
  GROUP                 = DWORD;
  TSocket               = DWORD;

const
  INVALID_SOCKET        = TSocket(not(0));
  SOCKET_ERROR          = -1;

type                                   
  PLinger               = ^TLinger;
  TLinger               = packed record
    l_onoff             : Word;
    l_linger            : Word;
  end;
  
  TSunB                 = packed record
    s_b1                : Byte;
    s_b2                : Byte;
    s_b3                : Byte;
    s_b4                : Byte;
  end;

  TSunW                 = packed record
    s_w1                : Word;
    s_w2                : Word;
  end;

  TInAddr               = packed record
    case integer of
      0: (Sun_b         : TSunB);
      1: (Sun_w         : TSunW);
      2: (S_addr        : DWORD);
  end;
  PInAddr               = ^TInAddr;
                    
  TSockAddrIn           = packed record
    case Integer of
      0: (sin_family    : Word;
          sin_port      : Word;
          sin_addr      : TInAddr;
          sin_zero      : array[0..7] of AnsiChar);
      1: (sa_family     : Word;
          sa_data       : array[0..13] of AnsiChar)
  end;
  PSockAddrIn           = ^TSockAddrIn;
  TSockAddr             = TSockAddrIn;
  PSockAddr             = ^TSockAddr;
  SOCKADDR              = TSockAddr;
  SOCKADDR_IN           = TSockAddrIn;
                       
  PHostEnt              = ^THostEnt;
  THostEnt              = packed record
    h_name              : PAnsiChar;                 // official name of host
    h_aliases           : ^PAnsiChar;             // alias list
    h_addrtype          : Smallint;          // host address type
    h_length            : Smallint;            // length of address
    case Byte of
      0: (h_addr_list   : ^PAnsiChar);    // list of addresses
      1: (h_addr        : ^PAnsiChar);         // address, for backward compat
  end;
                       
  WSAOVERLAPPED         = TOverlapped;
  PWSAOverlapped        = ^WSAOverlapped;
  LPWSAOVERLAPPED       = PWSAOverlapped;
                   
  WSABUF                = packed record
    len                 : DWORD;  { the length of the buffer }
    buf                 : PAnsiChar; { the pointer to the buffer }
  end {WSABUF};
  PWSABUF               = ^WSABUF;
  LPWSABUF              = PWSABUF;
                                
  WSAEVENT              = THandle;    
  PWSAEVENT             = ^WSAEVENT;
  
  PWSAData              = ^TWSAData;
  TWSAData              = packed record
    wVersion            : Word;
    wHighVersion        : Word;
    szDescription       : Array[0..WSADESCRIPTION_LEN] of AnsiChar;
    szSystemStatus      : Array[0..WSASYS_STATUS_LEN] of AnsiChar;
    //WSADATA中的iMaxSockets就是最大可打开socket 
    iMaxSockets         : Word;
    iMaxUdpDg           : Word;
    lpVendorInfo        : PAnsiChar;
  end;
                            
  TWSAProtocolChain     = record
    ChainLen            : Integer;  // the length of the chain,
    // length = 0 means layered protocol,
    // length = 1 means base protocol,
    // length > 1 means protocol chain
    ChainEntries        : Array[0..MAX_PROTOCOL_CHAIN-1] of LongInt; // a list of dwCatalogEntryIds
  end;
   
  TWSAProtocol_InfoA    = record
    dwServiceFlags1     : LongInt;
    dwServiceFlags2     : LongInt;
    dwServiceFlags3     : LongInt;
    dwServiceFlags4     : LongInt;
    dwProviderFlags     : LongInt;
    ProviderId          : TGUID;
    dwCatalogEntryId    : LongInt;
    ProtocolChain       : TWSAProtocolChain;
    iVersion            : Integer;
    iAddressFamily      : Integer;
    iMaxSockAddr        : Integer;
    iMinSockAddr        : Integer;
    iSocketType         : Integer;
    iProtocol           : Integer;
    iProtocolMaxOffset  : Integer;
    iNetworkByteOrder   : Integer;
    iSecurityScheme     : Integer;
    dwMessageSize       : LongInt;
    dwProviderReserved  : LongInt;
    szProtocol          : Array[0..WSAPROTOCOL_LEN+1-1] of AnsiChar;
  end {TWSAProtocol_InfoA};
  PWSAProtocol_InfoA    = ^TWSAProtocol_InfoA;
  LPWSAProtocol_InfoA   = PWSAProtocol_InfoA;

  TWSAProtocol_InfoW    = record
    dwServiceFlags1     : LongInt;
    dwServiceFlags2     : LongInt;
    dwServiceFlags3     : LongInt;
    dwServiceFlags4     : LongInt;
    dwProviderFlags     : LongInt;
    ProviderId          : TGUID;
    dwCatalogEntryId    : LongInt;
    ProtocolChain       : TWSAProtocolChain;
    iVersion            : Integer;
    iAddressFamily      : Integer;
    iMaxSockAddr        : Integer;
    iMinSockAddr        : Integer;
    iSocketType         : Integer;
    iProtocol           : Integer;
    iProtocolMaxOffset  : Integer;
    iNetworkByteOrder   : Integer;
    iSecurityScheme     : Integer;
    dwMessageSize       : LongInt;
    dwProviderReserved  : LongInt;
    szProtocol          : Array[0..WSAPROTOCOL_LEN+1-1] of WideChar;
  end {TWSAProtocol_InfoW};
  PWSAProtocol_InfoW    = ^TWSAProtocol_InfoW;
  LPWSAProtocol_InfoW   = PWSAProtocol_InfoW;

{$IFDEF UNICODE}
  WSAProtocol_Info      = TWSAProtocol_InfoW;
  TWSAProtocol_Info     = TWSAProtocol_InfoW;
  PWSAProtocol_Info     = PWSAProtocol_InfoW;
  LPWSAProtocol_Info    = PWSAProtocol_InfoW;
{$ELSE}
  WSAProtocol_Info      = TWSAProtocol_InfoA;
  TWSAProtocol_Info     = TWSAProtocol_InfoA;
  PWSAProtocol_Info     = PWSAProtocol_InfoA;
  LPWSAProtocol_Info    = PWSAProtocol_InfoA;
{$ENDIF}
                 
  TServiceType          = LongInt;
          
  TFlowSpec             = packed record
    TokenRate           : LongInt;               // In Bytes/sec
    TokenBucketSize     : LongInt;         // In Bytes
    PeakBandwidth       : LongInt;           // In Bytes/sec
    Latency             : LongInt;                 // In microseconds
    DelayVariation      : LongInt;// In microseconds
    ServiceType         : TServiceType;
    MaxSduSize          : LongInt;
    MinimumPolicedSize  : LongInt;// In Bytes
  end;
  PFlowSpec             = ^TFLOWSPEC;

  QOS                   = packed record
    SendingFlowspec     : TFlowSpec; { the flow spec for data sending }
    ReceivingFlowspec   : TFlowSpec; { the flow spec for data receiving }
    ProviderSpecific    : WSABUF; { additional provider specific stuff }
  end;
  TQualityOfService     = QOS;
  PQOS                  = ^QOS;
  LPQOS                 = PQOS;

  LPWSAOVERLAPPED_COMPLETION_ROUTINE = procedure ( const dwError, cbTransferred : DWORD;
    const lpOverlapped : LPWSAOVERLAPPED; const dwFlags : DWORD ); stdcall;
  LPCONDITIONPROC = function (lpCallerId: LPWSABUF; lpCallerData : LPWSABUF;
    lpSQOS, lpGQOS : LPQOS; lpCalleeId, lpCalleeData : LPWSABUF;
    g : GROUP; dwCallbackData : DWORD ) : Integer; stdcall;
    
  function WSAStartup(wVersionRequired: word; var WSData: TWSAData): Integer; stdcall; external ws2_32 name 'WSAStartup';
  function WSACleanup: Integer; stdcall; external ws2_32 name 'WSACleanup';
  function WSASocket( af, iType, protocol : Integer;
      lpProtocolInfo : LPWSAProtocol_Info; g : GROUP; dwFlags : DWORD ): TSocket; stdcall; external ws2_32 name 'WSASocketA';
  function WSAAccept(ASocket: TSocket; addr : PSockAddr; addrlen : PInteger; lpfnCondition : LPCONDITIONPROC; dwCallbackData : DWORD ): TSocket; stdcall; external ws2_32 name 'WSAAccept';
  // 消息选择模型
//  function select(nfds: Integer; readfds, writefds, exceptfds: PFDSet; timeout: PTimeVal): Integer; stdcall;
  function WSAAsyncSelect(ASocket: TSocket; AWindow: HWND; wMsg: DWORD; lEvent: Longint): Integer; stdcall; external ws2_32 name 'WSAAsyncSelect';
  // 事件选择模型
  function WSAEventSelect(ASocket: TSocket; hEventObject : WSAEVENT; lNetworkEvents : LongInt ): Integer; stdcall; external ws2_32 name 'WSAEventSelect';
  function WSAIoctl(ASocket: TSocket; dwIoControlCode : DWORD; lpvInBuffer : Pointer;
      cbInBuffer : DWORD; lpvOutBuffer : Pointer; cbOutBuffer : DWORD;
      lpcbBytesReturned : LPDWORD; lpOverlapped : LPWSAOVERLAPPED;
      lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ) : Integer; stdcall; external ws2_32 name 'WSAIoctl';
  function WSASend(ASocket: TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; lpNumberOfBytesSent : PDWORD; dwFlags : DWORD;
      lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall; external ws2_32 name 'WSASend';
  function WSAGetLastError: Integer; stdcall; external ws2_32 name 'WSAGetLastError';
  function WSARecv(ASocket: TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesRecvd : DWORD; var lpFlags : DWORD;
    lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall; external ws2_32 name 'WSARecv';
  function WSARecvDisconnect(ASocket: TSocket; lpInboundDisconnectData : LPWSABUF ): Integer; stdcall; external ws2_32 name 'WSARecvDisconnect';
  function WSARecvFrom(ASocket: TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD;
    var lpNumberOfBytesRecvd : DWORD; var lpFlags : DWORD; lpFrom : PSockAddr;
    lpFromlen : PInteger; lpOverlapped : LPWSAOVERLAPPED;
    lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE ): Integer; stdcall; external ws2_32 name 'WSARecvFrom';
  function WSAGetOverlappedResult(ASocket: TSocket; lpOverlapped : LPWSAOVERLAPPED;
    lpcbTransfer : LPDWORD; fWait : BOOL; var lpdwFlags : DWORD ) : WordBool; stdcall; external ws2_32 name 'WSAGetOverlappedResult';
  function WSAResetEvent( hEvent : WSAEVENT ): WordBool; stdcall; external ws2_32 name 'WSAResetEvent';
  function WSAWaitForMultipleEvents( cEvents : DWORD; lphEvents : PWSAEVENT; fWaitAll : LongBool;
    dwTimeout : DWORD; fAlertable : LongBool ): DWORD; stdcall; external ws2_32 name 'WSAWaitForMultipleEvents';


  function send(ASocket: TSocket; var Buf; len, flags: Integer): Integer; stdcall; external ws2_32 name 'send';
  function sendto(ASocket: TSocket; var Buf; len, flags: Integer;
      var addrto: TSockAddr; tolen: Integer): Integer; stdcall; external ws2_32 name 'sendto';
  function getsockopt(const ASocket: TSocket; const level, optname: Integer; optval: PAnsiChar; var optlen: Integer ): Integer; stdcall; external ws2_32 name 'getsockopt';
  function setsockopt(ASocket: TSocket; level, optname: Integer; optval: PAnsiChar; optlen: Integer): Integer; stdcall;  external ws2_32 name 'setsockopt';
  function recv(ASocket: TSocket; var Buf; len, flags: Integer): Integer; stdcall; external ws2_32 name 'recv';
  function recvfrom(ASocket: TSocket; var Buf; len, flags: Integer;
      var from: TSockAddr; var fromlen: Integer): Integer; stdcall; external ws2_32 name 'recvfrom';
  //---------------------------------------------------------
  // 控制套接口的模式
  //     FIONBIO：允许或禁止套接口s的非阻塞模式
  //               当创建一个套接口时，它就处于阻塞模式 WSAAsynSelect()函数将套接口自动设置为非阻塞模式
  //     FIONREAD：确定套接口s自动读入的数据量
  //     SIOCATMARK：确实是否所有的带外数据都已被读入 SOCK_STREAM类型的套接口
  function ioctlsocket(const ASocket: TSocket; const cmd: DWORD; var arg: DWORD ): Integer; stdcall; external ws2_32 name 'ioctlsocket';
  //---------------------------------------------------------
  
  function htonl(hostlong: DWORD): DWORD; stdcall; external ws2_32 name 'htonl';
  function htons(hostshort: Word): Word; stdcall; external ws2_32 name 'htons';

  function inet_addr(cp: PAnsiChar): DWORD; stdcall; external ws2_32 name 'inet_addr';
  function inet_ntoa(inaddr: TInAddr): PAnsiChar; stdcall; external ws2_32 name 'inet_ntoa';
  function listen(ASocket: TSocket; backlog: Integer): Integer; stdcall; external ws2_32 name 'listen';
  function ntohl(netlong: DWORD): DWORD; stdcall; external ws2_32 name 'ntohl';
  function ntohs(netshort: Word): Word; stdcall; external ws2_32 name 'ntohs';

  function gethostbyaddr(addr: Pointer; len, struct: Integer): PHostEnt; stdcall; external ws2_32 name 'gethostbyaddr';
  function gethostbyname(name: PAnsiChar): PHostEnt; stdcall; external ws2_32 name 'gethostbyname';
  function gethostname(name: PAnsiChar; len: Integer): Integer; stdcall; external ws2_32 name 'gethostname';
//  function getservbyport(port: Integer; proto: PAnsiChar): PServEnt; stdcall; external ws2_32 name 'getservbyport';
//  function getservbyname(const name, proto: PAnsiChar): PServEnt; stdcall; external ws2_32 name 'getservbyname';
//  function getprotobynumber(const proto: Integer): PProtoEnt; stdcall; external ws2_32 name 'getprotobynumber';
//  function getprotobyname(const name: PAnsiChar): PProtoEnt; stdcall; external ws2_32 name 'getprotobyname';
  function accept(const ASocket: TSocket; var addr: TSockAddr; var addrlen: Integer ): TSocket; stdcall; external ws2_32 name 'accept';
  function bind(const ASocket: TSocket; const addr: PSockAddr; const namelen: Integer ): Integer; stdcall; external ws2_32 name 'bind';
  function WSAConnect(ASocket: TSocket; const name : PSockAddr; namelen : Integer;
      lpCallerData, lpCalleeData : LPWSABUF; lpSQOS, lpGQOS : LPQOS ) : Integer; stdcall; external ws2_32 name 'WSAConnect';
  function connect(const ASocket: TSocket; const name: PSockAddr; namelen: Integer): Integer; stdcall; external ws2_32 name 'connect';
  function closesocket(const ASocket: TSocket ): Integer; stdcall; external ws2_32 name 'closesocket';

implementation

end.
