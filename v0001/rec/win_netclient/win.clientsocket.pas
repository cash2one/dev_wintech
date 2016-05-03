unit win.clientsocket;

interface

uses
  Winsock2, base.netclient;
  
type
  PWinNetClient           = ^TWinNetClient;
  TWinNetClient           = packed record    
    DataType              : integer;
    ConnectSocketHandle   : Winsock2.TSocket;  
    TimeOutConnect        : Integer; //单位毫秒 (>0 值有效)
    TimeOutRead           : Integer; //单位毫秒
    TimeOutSend           : Integer; //单位毫秒
    LastErrorCode         : Integer;
    ConnectAddress        : PNetServerAddress;
  end;

implementation

end.
