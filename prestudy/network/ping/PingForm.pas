unit PingForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    mmo1: TMemo;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  WinSock, WinSock2;

type
  PIPOptionInformation =  ^TIPOptionInformation;
  TIPOptionInformation = packed record
    TTL           : Byte;
    TOS           : Byte;
    Flags         : Byte;
    OptionsSize   : Byte;
    OptionsData   : PAnsiChar;
  end;

  PIcmpEchoReply  = ^TIcmpEchoReply;
  TIcmpEchoReply  = packed record
    Address       : DWORD;
    Status        : DWORD;
    RTT           : DWORD;
    DataSize      : Word;
    Reserved      : Word;
    Data          : Pointer;
    Options       : TIPOptionInformation;
  end;

var
  WSAData: TWSAData;
      
function PingHost(HostIP: AnsiString): Boolean;
type
  TIcmpCreateFile = function:THandle;stdcall;
  TIcmpCloseHandle= function(IcmpHandle:THandle):Boolean;stdcall;
  TIcmpSendEcho=function(IcmpHandle:THandle;
                  DestinationAddress: DWORD;
                  RequestData:   Pointer;
                  RequestSize:   Word;
                  RequestOptions:   PIPOptionInformation;
                  ReplyBuffer:   Pointer;
                  ReplySize:   DWord;
                  Timeout:   DWord
                  ):DWord;stdcall;
var
  hICMP:THandle;
  hICMPdll:THandle;
  IcmpCreateFile:TIcmpCreateFile;
  IcmpCloseHandle:TIcmpCloseHandle;
  IcmpSendEcho:TIcmpSendEcho;
  pIPE:PIcmpEchoReply;//   ICMP   Echo   reply   buffer
  FIPAddress:DWORD;
  FSize:DWORD;
  FTimeOut:DWORD;
  BufferSize:DWORD;
  pReqData: PAnsiChar;
  pRevData: PAnsiChar;
  MyString: AnsiString;
begin   
  Result:=False;
  hICMPdll:=LoadLibrary('icmp.dll');
  if hICMPdll=0 then   exit;

  @ICMPCreateFile:=GetProcAddress(hICMPdll,'IcmpCreateFile');
  @IcmpCloseHandle:=GetProcAddress(hICMPdll,'IcmpCloseHandle');
  @IcmpSendEcho:=GetProcAddress(hICMPdll, 'IcmpSendEcho');
  hICMP   :=   IcmpCreateFile;
  if (INVALID_HANDLE_VALUE = hICMP) then
    exit;

  //WSAStartup();
  
  FIPAddress := inet_addr(PAnsiChar(HostIP));
  MyString := 'Hello,World';                                 //send   data   buffer
  pReqData := PAnsiChar(MyString);

  FSize:=40;                                                 //receive   data   buffer
  BufferSize:=SizeOf(TICMPEchoReply)+FSize;
  GetMem(pIPE,BufferSize);   
  FillChar(pIPE^,SizeOf(pIPE^), 0);
  GetMem(pRevData,FSize);
  pIPE^.Data:=pRevData;
  FTimeOut:=500;
  try
    Result:=IcmpSendEcho(hICMP, FIPAddress, pReqData, Length(MyString),nil,pIPE,BufferSize,FTimeOut) > 0;
  finally
    IcmpCloseHandle(hICMP);
    FreeLibrary(hICMPdll);
    FreeMem(pRevData);
    FreeMem(pIPE);
  end;
end;

function GetIPFromName(Name: string): string;
var
  WSAData: TWSAData;
  HostEnt: PHostEnt;
begin
  WSAStartup(2, WSAData);
  HostEnt := gethostbyname(PChar(Name));
  if nil <> HostEnt then
  begin
    if nil <> HostEnt.h_addr then
    begin
//      Result := Format('%d.%d.%d.%d', [
//        Byte(HostEnt.h_addr^.S_un_b.s_b1),
//        Byte(HostEnt.h_addr^.S_un_b.s_b2),
//        Byte(HostEnt.h_addr^.S_un_b.s_b3),
//        Byte(HostEnt.h_addr^.S_un_b.s_b4)]);
    end;
  end;
  WSACleanup;
end;

const
  PACKET_SIZE = 32;
  MAX_PACKET_SIZE = 512;
  TRACE_PORT = 34567;
  LOCAL_PORT = 5555;
type
  s32 = Integer;
  u32 = DWORD;
  u8 = Byte;
  u16 = word; PU16 = ^U16;

  //IP Packet Header

  PIPHeader = ^YIPHeader;
  YIPHeader = record
    u8verlen : u8;//4bits ver, 4bits len, len*4=true length
    u8tos : u8;//type of service, 3bits 优先权(现在已经被忽略), 4bits TOS, 最多只能有1bit为1
    u16totallen : u16;//整个IP数据报的长度，以字节为单位。
    u16id : u16;//标识主机发送的每一份数据报。
    u16offset : u16;//3bits 标志，13bits片偏移
    u8ttl : u8;//生存时间字段设置了数据报可以经过的最多路由器数。
    u8protol : u8;//协议类型，6表示传输层是TCP协议。
    u16checksum : u16;//首部检验和。
    u32srcaddr : u32;//源IP地址，不是‘xxx.xxx.xxx.xxx’的形势哦
    u32destaddr : u32;//目的IP地址，同上
  end;

  //ICMP Packet Header
  PICMPHeader = ^YICMPHeader;
  YICMPHeader = record
    u8type : u8;
    u8code : u8;
    u16chksum : u16;
    u16id : u16;
    u16seq : u16;
  end;
  
function DecodeIcmpReply( pbuf: PChar; var seq: s32 ): string;
var
  pIpHdr : PChar;
  pIcmphdr : PICMPHeader;
  sip : string;
  ttl : integer;
begin
  pIpHdr := pbuf;
  sip := inet_ntoa( TInAddr( PIPHeader(pIpHdr)^.u32srcaddr ) );
  ttl := PIPHeader(pIpHdr)^.u8ttl;
  Inc( pIpHdr, (PIPHeader(pIpHdr)^.u8verlen and $0F) * 4 );
  pIcmpHdr := PICMPHeader(pIpHdr);
  result := '';
  if pIcmpHdr^.u8type = 3 then //目的不可达信息，Trace完成
    seq := 0;
  if pIcmpHdr^.u8type = 11 then //超时信息，正在Trace
    result := Format('', [seq, sip, ttl] );
end;

procedure TForm1.btn1Click(Sender: TObject);
const
  SIO_RCVALL = IOC_IN or IOC_VENDOR or 1;
var
  rawsock : WinSock2.TSocket;
  pRecvBuf : PChar;
  FromAdr : WinSock2.TSockAddr;
  FromLen : s32;
  fd_read : WinSock.TFDSet;
  timev : WinSock2.TTimeVal;
  sReply : string;
  udpsock : WinSock2.TSocket;
  ret : s32;
  DestAdr : WinSock2.TSockAddr;
  pSendBuf : PChar;
  ttl: s32;
  opt : s32;
  pHost : WinSock2.PHostEnt;
begin
  FillChar(WSAData, SizeOf(WSAData), 0);
  //WSAStartup($0202, WSAData);
  //WSAStartup($0101, WSAData);
  //mmo1.Lines.Add(GetIPFromName('litwrd.51mypc.cn'));
  if 0 = WSAStartup( $0202, WSAData) then
  begin
    //创建一个RAWSOCK接收回应ICMP包
    rawsock := socket( AF_INET, SOCK_RAW, IPPROTO_ICMP );
    FromAdr.sin_family := AF_INET;
    FromAdr.sin_port := htons(0);
    FromAdr.sin_addr.S_addr := inet_addr('192.168.10.81'); //换成你的IP
    //FromAdr.sin_addr.S_addr := inet_addr('litwrd.51mypc.cn'); //换成你的IP
    //如果不bind就无法接收包了~~~因为下面还要创建一个UDPSOCK
    WinSock2.bind( rawsock, @FromAdr, SizeOf(FromAdr) );
    Opt := 1;
    WinSock2.WSAIoctl( rawsock, SIO_RCVALL, @Opt, SizeOf(Opt), nil, 0, @ret, nil, nil );
    //接收ICMP回应包的缓冲区
    pRecvBuf := AllocMem( MAX_PACKET_SIZE );
    //创建一个UDPSOCK发送探测包
    udpsock := socket( AF_INET, SOCK_DGRAM, IPPROTO_UDP );
    //要发送的UDP数据
    pSendBuf := AllocMem( PACKET_SIZE );
    FillChar( pSendBuf^, PACKET_SIZE, 'c');
    FillChar( DestAdr, sizeof(DestAdr), 0 );
    DestAdr.sin_family := AF_INET;
    DestAdr.sin_port := htons( TRACE_PORT );
    DestAdr.sin_addr.S_addr := inet_addr( PChar('litwrd.51mypc.cn') );
    //如果edit1.text不是IP地址，则尝试解析域名
    if DWORD(DestAdr.sin_addr.S_addr) = DWORD(INADDR_NONE) then
    begin
      pHost := WinSock2.gethostbyname( PChar('litwrd.51mypc.cn') );
    end;
    if pHost <> nil then
    begin               
      mmo1.Lines.Add(
        inttostr(Byte(pHost^.h_addr^.S_un_b.s_b1)) + '.' +
        inttostr(Byte(pHost^.h_addr^.S_un_b.s_b2)) + '.' +
        inttostr(Byte(pHost^.h_addr^.S_un_b.s_b3)) + '.' +
        inttostr(Byte(pHost^.h_addr^.S_un_b.s_b4)));

      move( pHost^.h_addr^^, DestAdr.sin_addr, pHost^.h_length );
      DestAdr.sin_family := pHost^.h_addrtype;
      DestAdr.sin_port := htons( TRACE_PORT );
                     
      mmo1.Lines.Add('begin trace');
      //开始Trace!!!
      ttl := 1;
      while True do
      begin
        //设置TTL，使我们发送的UDP包的TTL依次累加
        WinSock2.setsockopt( udpsock, IPPROTO_IP, WinSock.IP_TTL, @ttl, sizeof(ttl) );
        //发送UDP包到HOST
        WinSock2.sendto( udpsock, pSendBuf^, PACKET_SIZE, 0, @DestAdr, sizeof(DestAdr) );
        WinSock.FD_ZERO( fd_read );
        WinSock.FD_SET( rawsock, fd_read );
        timev.tv_sec := 5;
        timev.tv_usec := 0;
        if WinSock2.select( 0, @fd_read, nil, nil, @timev ) < 1 then
          break;
        if WinSock.FD_ISSET( rawsock, fd_read ) then
        begin
          FillChar( pRecvBuf^, MAX_PACKET_SIZE, 0 );
          FillChar( FromAdr, sizeof(FromAdr), 0 );
          FromAdr.sin_family := AF_INET;
          FromLen := sizeof( FromAdr );
          WinSock2.recvfrom( rawsock, pRecvBuf^, MAX_PACKET_SIZE, 0, @FromAdr, FromLen );
          sReply := DecodeIcmpReply( pRecvBuf, ttl );
          if sReply <> '' then
          begin
            mmo1.Lines.Add(sReply);
            //ListBox1.ItemIndex := ListBox1.Items.Add( sReply );
            //Listbox1.Update;
          end;
          if 0 = ttl then //如果收到目标主机的相应包，DecodeIcmpReply会把ttl==0
            break;
        end;
        Inc( ttl );
        Sleep( 110 );
      end; //while not bStop do
      mmo1.Lines.Add('end trace');      
      closesocket( rawsock );
      closesocket(udpsock);
      FreeMem( pSendBuf );
      FreeMem( pRecvBuf );
    end else
    begin
      closesocket( rawsock );
      closesocket(udpsock);
      FreeMem( pSendBuf );
      FreeMem( pRecvBuf );
    end;
    WSACleanup;
  end;
//  if PingHost('litwrd.51mypc.cn') then
//  begin
//    mmo1.Lines.Add('ping ok');
//  end else
//  begin
//    mmo1.Lines.Add('ping fail');
//  end;
end;

end.
