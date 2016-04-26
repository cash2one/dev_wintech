unit NetObjClient;

interface

uses
  Windows, WinSock2;
  
  function ResolveIP(const AHostName: AnsiString): AnsiString;

implementation
              
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

end.
