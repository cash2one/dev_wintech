unit NetUdpServer;

interface

uses
  Winsock2, BaseDataIO;
             
type                    
  PNetUDPServer            = ^TNetUDPServer; 
  TNetUDPServer            = packed record
    ListenSocketHandle  : Winsock2.TSocket;
    ListenPort          : Word;
    IsActiveStatus      : Integer;
    DataIO              : TDataIO;
  end;

  procedure TestUDPServer;

implementation

uses
  Windows;
  
procedure TestUDPServer;
var
  tmpUDPSever: TNetUDPServer;  
  tmpAddr: WinSock2.TSockAddr;
  tmpRet: integer;
  BufRecv:array[0..1024] of byte;
begin
  // 建立socket
  tmpUDPSever.ListenSocketHandle := Winsock2.socket(AF_INET,SOCK_DGRAM,IPPROTO_UDP);
  if(INVALID_SOCKET <> tmpUDPSever.ListenSocketHandle)then
  begin
    //绑定主机
    ZeroMemory(@tmpAddr,sizeof(tmpAddr));
    tmpAddr.sin_family :=AF_INET;
    //tmpAddr.sin_addr.s_addr := inet_addr('192.168.1.106');
    tmpAddr.sin_addr.s_addr := inet_addr('192.168.10.81');
    tmpAddr.sin_port := htons(7784);
    if 0 = WinSock2.Bind(tmpUDPSever.ListenSocketHandle, @tmpAddr, Sizeof(tmpAddr)) then
    begin
      FillChar(BufRecv, SizeOf(BufRecv), 0);
      tmpRet := WinSock2.Recv(tmpUDPSever.ListenSocketHandle, BufRecv, SizeOf(BufRecv), 0);
      if (SOCKET_ERROR <> tmpRet) then
      begin
      
      end;
    end;
    Winsock2.closesocket(tmpUDPSever.ListenSocketHandle);
  end;
end;

end.
