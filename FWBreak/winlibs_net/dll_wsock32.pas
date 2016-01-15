unit dll_wsock32;

interface

uses
  atmcmbaseconst, winconst, wintype;

const
  wsock32                   = 'wsock32.dll';

const
  FD_SETSIZE = 64;

type
// u_char = Byte;
  u_long    = Cardinal;
  u_short   = Word;
  u_int     = Cardinal;

  TSocket = Integer;

  TSockAddr = record
    sa_family: Word;//u_short; // address family
    sa_data: array [0..13] of AnsiChar; // up to 14 bytes of direct address
  end;
  PSockAddr = ^TSockAddr;

  TWSAData = record
    wVersion: WORD;
    wHighVersion: WORD;
{$IFDEF WIN64}
    iMaxSockets: Word;
    iMaxUdpDg: Word;
    lpVendorInfo: PAnsiChar;
    szDescription: array [0..WSADESCRIPTION_LEN] of AnsiChar;
    szSystemStatus: array [0..WSASYS_STATUS_LEN] of AnsiChar;
{$ELSE}
    szDescription: array [0..WSADESCRIPTION_LEN] of AnsiChar;
    szSystemStatus: array [0..WSASYS_STATUS_LEN] of AnsiChar;
    iMaxSockets: Word;
    iMaxUdpDg: Word;
    lpVendorInfo: PAnsiChar;
{$ENDIF}
  end;
  PWsaData = TWSAData;

  TFDSet      = record
    fd_count  : u_int;                                 // how many are SET?
    fd_array  : array [0..FD_SETSIZE - 1] of TSocket;   // an array of SOCKETs
  end;
  PFdSet = ^TFDSet;

  TSunB = record
    s_b1: Byte; //u_char;
    s_b2: Byte; //u_char;
    s_b3: Byte; //u_char;
    s_b4: Byte; //u_char;
  end;


  TSunC = record
    s_c1: AnsiChar;
    s_c2: AnsiChar;
    s_c3: AnsiChar;
    s_c4: AnsiChar;
  end;

  TSunW = record
    s_w1: Word; //u_short;
    s_w2: Word; //u_short;
  end;

  TInAddr = record
    case Integer of
      0: (S_un_b: TSunB);
      1: (S_un_c: TSunC);
      2: (S_un_w: TSunW);
      3: (S_addr: u_long);
    // #define s_addr  S_un.S_addr // can be used for most tcp & ip code
    // #define s_host  S_un.S_un_b.s_b2 // host on imp
    // #define s_net   S_un.S_un_b.s_b1  // netword
    // #define s_imp   S_un.S_un_w.s_w2 // imp
    // #define s_impno S_un.S_un_b.s_b4 // imp #
    // #define s_lh    S_un.S_un_b.s_b3 // logical host
  end;
  PInAddr = ^TInAddr;

  THostEnt = record
    h_name: PAnsiChar;              // official name of host
    h_aliases: PPAnsiChar;          // alias list
    h_addrtype: Smallint;           // host address type
    h_length: Smallint;             // length of address
    case Integer of
      0: (h_addr_list: PPAnsiChar); // list of addresses
      1: (h_addr: PPAnsiChar);      // address, for backward compat
  end;
  PHostEnt = ^THostEnt;

  TProtoEnt = record
    p_name: PAnsiChar;           // official protocol name
    p_aliases: PPAnsiChar;  // alias list
    p_proto: Smallint;                // protocol #
  end;
  PProtoEnt = ^TProtoEnt;

  TNetEnt = record
    n_name: PAnsiChar;           // official name of net
    n_aliases: PPAnsiChar;  // alias list
    n_addrtype: Smallint;             // net address type
    n_net: u_long;                  // network #
  end;
  PNetEnt = ^TNetEnt;

  TServEnt = record
    s_name: PAnsiChar;           // official service name
    s_aliases: PPAnsiChar;  // alias list
{$IFDEF WIn64}
    s_proto: PAnsiChar;          // protocol to use
    s_port: Smallint;                 // port #
{$ELSE}
    s_port: Smallint;                 // port #
    s_proto: PAnsiChar;          // protocol to use
{$ENDIF}
  end;
  PServEnt = ^TServEnt;

  TTimeVal = record
    tv_sec: Longint;         // seconds
    tv_usec: Longint;        // and microseconds
  end;
  PTimeVal = ^TTimeVal;

function accept(s: TSocket; addr: PSockAddr; addrlen: PInteger): TSocket; stdcall; external    wsock32 name 'accept';
function bind(s: TSocket; var addr: TSockAddr; namelen: Integer): Integer; stdcall; external    wsock32 name 'bind';
function closesocket(s: TSocket): Integer; stdcall; external    wsock32 name 'closesocket';
function connect(s: TSocket; var name: TSockAddr; namelen: Integer): Integer; stdcall; external    wsock32 name 'connect';
function getpeername(s: TSocket; var name: TSockAddr; var namelen: Integer): Integer; stdcall; external    wsock32 name 'getpeername';
function getsockname(s: TSocket; var name: TSockAddr; var namelen: Integer): Integer; stdcall; external    wsock32 name 'getsockname';
function getsockopt(s: TSocket; level, optname: Integer; optval: PAnsiChar; var optlen: Integer): Integer; stdcall; external    wsock32 name 'getsockopt';
function htonl(hostlong: u_long): u_long; stdcall; external    wsock32 name 'htonl';
function htons(hostshort: u_short): u_short; stdcall; external    wsock32 name 'htons';
function inet_addr(cp: PAnsiChar): u_long; stdcall; {PInAddr;}  { TInAddr } external    wsock32 name 'inet_addr';
function inet_ntoa(inaddr: TInAddr): PAnsiChar; stdcall; external    wsock32 name 'inet_ntoa';
function ioctlsocket(s: TSocket; cmd: DWORD; var arg: u_long): Integer; stdcall; external    wsock32 name 'ioctlsocket';
function listen(s: TSocket; backlog: Integer): Integer; stdcall; external    wsock32 name 'listen';
function ntohl(netlong: u_long): u_long; stdcall; external    wsock32 name 'ntohl';
function ntohs(netshort: u_short): u_short; stdcall; external    wsock32 name 'ntohs';
function recv(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall; external    wsock32 name 'recv';
function recvfrom(s: TSocket; var Buf; len, flags: Integer;
  var from: TSockAddr; var fromlen: Integer): Integer; stdcall; external    wsock32 name 'recvfrom';
function select(nfds: Integer; readfds, writefds, exceptfds: PFDSet;
  timeout: PTimeVal): Longint; stdcall; external    wsock32 name 'select';
function send(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall; external    wsock32 name 'send';
function sendto(s: TSocket; var Buf; len, flags: Integer; var addrto: TSockAddr;
  tolen: Integer): Integer; stdcall; external    wsock32 name 'sendto';
function setsockopt(s: TSocket; level, optname: Integer; optval: PAnsiChar;
  optlen: Integer): Integer; stdcall; external    wsock32 name 'setsockopt';
function shutdown(s: TSocket; how: Integer): Integer; stdcall; external    wsock32 name 'shutdown';
function socket(af, Struct, protocol: Integer): TSocket; stdcall; external    wsock32 name 'socket';

function gethostbyaddr(addr: Pointer; len, Struct: Integer): PHostEnt; stdcall; external    wsock32 name 'gethostbyaddr';
function gethostbyname(name: PAnsiChar): PHostEnt; stdcall; external    wsock32 name 'gethostbyname';
function getprotobyname(name: PAnsiChar): PProtoEnt; stdcall; external    wsock32 name 'getprotobyname';
function getprotobynumber(proto: Integer): PProtoEnt; stdcall; external    wsock32 name 'getprotobynumber';
function getservbyname(name, proto: PAnsiChar): PServEnt; stdcall; external    wsock32 name 'getservbyname';
function getservbyport(port: Integer; proto: PAnsiChar): PServEnt; stdcall; external    wsock32 name 'getservbyport';
function gethostname(name: PAnsiChar; len: Integer): Integer; stdcall; external    wsock32 name 'gethostname';

function WSAAsyncSelect(s: TSocket; AWindow: HWND; wMsg: u_int; lEvent: Longint): Integer; stdcall; external    wsock32 name 'WSAAsyncSelect';
function WSARecvEx(s: TSocket; var buf; len: Integer; var flags: Integer): Integer; stdcall; external    wsock32 name 'WSARecvEx';
function WSAAsyncGetHostByAddr(AWindow: HWND; wMsg: u_int; addr: PAnsiChar;
  len, Struct: Integer; buf: PAnsiChar; buflen: Integer): THandle; stdcall; external wsock32 name 'WSAAsyncGetHostByAddr';
function WSAAsyncGetHostByName(AWindow: HWND; wMsg: u_int;
  name, buf: PAnsiChar; buflen: Integer): THandle; stdcall; external wsock32 name 'WSAAsyncGetHostByName';
function WSAAsyncGetProtoByNumber(AWindow: HWND; wMsg: u_int; number: Integer;
  buf: PAnsiChar; buflen: Integer): THandle; stdcall; external wsock32 name 'WSAAsyncGetProtoByNumber';
function WSAAsyncGetProtoByName(AWindow: HWND; wMsg: u_int;
  name, buf: PAnsiChar; buflen: Integer): THandle; stdcall; external wsock32 name 'WSAAsyncGetProtoByName';
function WSAAsyncGetServByPort(AWindow: HWND; wMsg, port: u_int;
  proto, buf: PAnsiChar; buflen: Integer): THandle; stdcall; external wsock32 name 'WSAAsyncGetServByPort';
function WSAAsyncGetServByName(AWindow: HWND; wMsg: u_int;
  name, proto, buf: PAnsiChar; buflen: Integer): THandle; stdcall; external wsock32 name 'WSAAsyncGetServByName';
function WSACancelAsyncRequest(AsyncTaskHandle: THandle): Integer; stdcall; external wsock32 name 'WSACancelAsyncRequest';
function WSASetBlockingHook(lpBlockFunc: TFarProc): TFarProc; stdcall; external    wsock32 name 'WSASetBlockingHook';
function WSAUnhookBlockingHook: Integer; stdcall; external wsock32 name 'WSAUnhookBlockingHook';
function WSAGetLastError: Integer; stdcall; external    wsock32 name 'WSAGetLastError';
procedure WSASetLastError(iError: Integer); stdcall; external    wsock32 name 'WSASetLastError';
function WSACancelBlockingCall: Integer; stdcall; external wsock32 name 'WSACancelBlockingCall';
function WSAIsBlocking: BOOL; stdcall; external     wsock32 name 'WSAIsBlocking';
function WSAStartup(wVersionRequired: word; var WSData: TWSAData): Integer; stdcall; external     wsock32 name 'WSAStartup';
function WSACleanup: Integer; stdcall; external     wsock32 name 'WSACleanup';
function __WSAFDIsSet(s: TSocket; var FDSet: TFDSet): Bool; stdcall; external     wsock32 name '__WSAFDIsSet';

function TransmitFile(ASocket: TSocket; AFile: THandle; nNumberOfBytesToWrite: DWORD;
  nNumberOfBytesPerSend: DWORD; lpOverlapped: POverlapped;
  lpTransmitBuffers: PTransmitFileBuffers; dwReserved: DWORD): BOOL; stdcall; external     wsock32 name 'TransmitFile';
function AcceptEx(sListenSocket, sAcceptSocket: TSocket;
  lpOutputBuffer: Pointer; dwReceiveDataLength, dwLocalAddressLength,
  dwRemoteAddressLength: DWORD; var lpdwBytesReceived: DWORD;
  lpOverlapped: POverlapped): BOOL; stdcall; external     wsock32 name 'AcceptEx';
procedure GetAcceptExSockaddrs(lpOutputBuffer: Pointer;
  dwReceiveDataLength, dwLocalAddressLength, dwRemoteAddressLength: DWORD;
  var LocalSockaddr: PSockAddr; var LocalSockaddrLength: Integer;
  var RemoteSockaddr: PSockAddr; var RemoteSockaddrLength: Integer); stdcall; external    wsock32 name 'GetAcceptExSockaddrs';

implementation

end.
