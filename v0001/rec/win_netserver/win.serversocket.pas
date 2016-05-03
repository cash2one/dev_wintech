unit win.serversocket;

interface

uses
  Winsock2;
  
type
  PWinNetServerSocket     = ^TWinNetServerSocket;
  TWinNetServerSocket     = packed record
    DataType              : integer;
    IsActiveStatus        : Integer;
    ListenSocketHandle    : Winsock2.TSocket;
    ListenPort            : Word;
  end;

  PWinNetClientConnect    = ^TWinNetClientConnect;
  TWinNetClientConnect    = packed record  
    DataType              : integer;
    ClientSocketHandle    : Winsock2.TSocket;
    Server                : PWinNetServerSocket;
  end;
             
implementation

end.
