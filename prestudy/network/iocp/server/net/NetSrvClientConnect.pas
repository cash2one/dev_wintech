unit NetSrvClientConnect;

interface

uses
  Windows, Winsock2,
  BaseDataIO, DataChain;
  
type
  PNetSrvClientConnect  = ^TNetSrvClientConnect;
  
  TNetSrvClientConnect  = packed record
    ConnectSocketHandle : Winsock2.TSocket;
    ChainNode           : PChainNode;
  end;

implementation

end.
