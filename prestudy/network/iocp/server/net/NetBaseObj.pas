unit NetBaseObj;

interface

uses
  Windows, WinSock2, Win.Thread, BaseDataIO, DataChain, win.diskfile;

type                    
  PNetServer              = ^TNetServer;   
  PNetClientConnect       = ^TNetClientConnect;
  PNetClientConnectSession = ^TNetClientConnectSession;
  PNetClient              = ^TNetClient;       
  PNetServerAddress       = ^TNetServerAddress;

  TNetServer              = packed record
    ListenSocketHandle    : Winsock2.TSocket;
    ListenPort            : Word;
    IsActiveStatus        : Integer;

    SendDataOut           : procedure(AClient: PNetClientConnect; ADataBuffer: PDataBuffer);
    CheckOutDataOutBuffer : function(AClient: PNetClientConnect) : PDataBuffer;
    
    CheckOutClientSession : function(AClient: PNetClientConnect) : PNetClientConnectSession;
    CheckInClientSession  : procedure(var ASession: PNetClientConnectSession);
  end;


  TNetClientConnectSession = packed record
    SessionMagic          : Integer;
    ClientConnect         : PNetClientConnect; 
    DataInFile            : PWinFile;
    DataOutFile           : PWinFile;
  end;

  TNetClientConnect       = packed record
    ClientSocketHandle    : Winsock2.TSocket;
    Server                : PNetServer;
    ChainNode             : PChainNode;
    Session               : PNetClientConnectSession;
  end;
                                   
  TNetClient              = packed record
    ConnectSocketHandle   : Winsock2.TSocket;  
    TimeOutConnect        : Integer; //单位毫秒 (>0 值有效)
    TimeOutRead           : Integer; //单位毫秒
    TimeOutSend           : Integer; //单位毫秒
    ConnectAddress        : PNetServerAddress;
  end;

  TNetServerAddress       = record
    Host                  : AnsiString;
    Ip                    : AnsiString;
    Port                  : Word;
  end;
  
implementation
                             
end.
