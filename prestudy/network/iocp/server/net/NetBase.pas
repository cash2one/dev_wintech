unit NetBase;

interface

uses
  WinSock2;
  
type
  PNetBase          = ^TNetBase;
  TNetBase          = record
    WSA             : TWSAData;
  end;
            
  PNetAddress       = ^TNetAddress;
  TNetAddress       = record
    Host            : AnsiString;
    Ip              : AnsiString;
    Port            : Word;
  end;
                    
const
  Connect_Unknown = 0;
  Connect_Connected  = 1;
  Connect_Disconnected  = 2;

  function ResolveIP(const AHostName: AnsiString): AnsiString;

  procedure InitializeNet(ANet: PNetBase);    
  procedure FinalizeNet(ANet: PNetBase);
  
implementation

uses
  Windows;

function ResolveIP(const AHostName: AnsiString): AnsiString;
type
  tAddr = array[0..100] of PInAddr;
  pAddr = ^tAddr;
var
  I: Integer;
  PHE: Winsock2.PHostEnt;
  P: pAddr;
begin
  PHE := Winsock2.GetHostByName(pAnsiChar(AHostName));
  if (PHE <> nil) then
  begin
    P := pAddr(PHE^.h_addr_list);
    I := 0;
    while (P^[I] <> nil) do
    begin
      Result := (inet_nToa(P^[I]^));
      Inc(I);
    end;
  end else
  begin
    Result := '';
  end;
end;
  
procedure InitializeNet(ANet: PNetBase);
begin       
  FillChar(ANet.WSA, SizeOf(ANet.WSA), 0);
  //WinSock2.WSAStartup(MAKEWORD(1, 1), ANet.WSA);
  WinSock2.WSAStartup(MAKEWORD(2, 2), ANet.WSA);     
  //WinSock2.WSAStartup($0202, ANet.WSA);
end;

procedure FinalizeNet(ANet: PNetBase);
begin
  WinSock2.WSACleanup;
end;

end.
