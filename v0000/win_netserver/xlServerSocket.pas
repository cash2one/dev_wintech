unit xlServerSocket;

interface

uses
  Winsock2;
  
type
  PNetServer              = ^TNetServer;
  TNetServer              = packed record
    DataType              : integer;
    IsActiveStatus        : Integer;
    ListenSocketHandle    : Winsock2.TSocket;
    ListenPort            : Word;
  end;

  PNetClientConnect       = ^TNetClientConnect;       
  TNetClientConnect       = packed record  
    DataType              : integer;
    ClientSocketHandle    : Winsock2.TSocket;
    Server                : PNetServer;
  end;
             
implementation

end.
