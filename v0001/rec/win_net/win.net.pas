unit win.net;

interface
          
uses
  Windows, Winsock2;
            
type
  PWinNetwork   = ^TWinNetwork;
  TWinNetwork   = record
    Status      : Integer;
    WSA         : TWSAData;
  end;
  
  function Host2Ip(const AHostName: AnsiString): AnsiString;  
  procedure InitializeNetwork(ANet: PWinNetwork);
  procedure FinalizeNetwork(ANet: PWinNetwork);

var
  Network: TWinNetwork;
    
implementation

procedure InitializeNetwork(ANet: PWinNetwork);
begin
  if 0 = ANet.Status then
  begin
    FillChar(ANet.WSA, SizeOf(ANet.WSA), 0);
    //WinSock2.WSAStartup(MAKEWORD(1, 1), ANet.WSA);
    WinSock2.WSAStartup(MAKEWORD(2, 2), ANet.WSA);
    ANet.Status := 1;
  end;
  //WinSock2.WSAStartup($0202, ANet.WSA);
end;

procedure FinalizeNetwork(ANet: PWinNetwork);
begin
  if 1 = ANet.Status then
  begin
    WinSock2.WSACleanup;
    ANet.Status := 0;
  end;
end;

function Host2Ip(const AHostName: AnsiString): AnsiString;
type
  TAddr = array[0..100] of Winsock2.PInAddr;
  pAddr = ^TAddr;
var
  I: Integer;
  tmpHost: Winsock2.PHostEnt;
  P: pAddr;
begin
  tmpHost := Winsock2.GetHostByName(PAnsiChar(AHostName));
  if (nil <> tmpHost) then
  begin
    P := pAddr(tmpHost^.h_addr_list);
    I := 0;
    while (P^[I] <> nil) do
    begin
      Result := (Winsock2.inet_nToa(P^[I]^));
      Inc(I);
    end;
  end else
  begin
    Result := '';
  end;
end;

end.
