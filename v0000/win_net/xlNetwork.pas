unit xlNetwork;

interface

uses
  Winsock2;

  function Host2Ip(const AHostName: AnsiString): AnsiString;

implementation
              
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
