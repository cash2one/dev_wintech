unit xlClientSocket;

interface

uses
  Winsock2;
  
type
  PxlNetServerAddress     = ^TxlNetServerAddress;
  TxlNetServerAddress     = record
    DataType              : integer;
    Host                  : AnsiString;
    Ip                    : AnsiString;
    Port                  : Word;
  end;

  PxlNetClient            = ^TxlNetClient;
  TxlNetClient            = packed record    
    DataType              : integer;
    ConnectSocketHandle   : Winsock2.TSocket;  
    TimeOutConnect        : Integer; //单位毫秒 (>0 值有效)
    TimeOutRead           : Integer; //单位毫秒
    TimeOutSend           : Integer; //单位毫秒
    LastErrorCode         : Integer;
    ConnectAddress        : PxlNetServerAddress;
  end;

implementation

end.
