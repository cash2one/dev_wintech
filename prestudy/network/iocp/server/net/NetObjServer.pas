unit NetObjServer;

interface

uses
  Windows, WinSock2, SysThread, BaseDataIO, DataChain;

type                    
  PNetServer            = ^TNetServer; 
  TNetServer            = packed record
    ListenSocketHandle  : Winsock2.TSocket;
    ListenPort          : Word;
    IsActiveStatus      : Integer;
    CheckOutClientSessionData: function : 
    CheckInClientSessionData: procedure(var ASessionData:); 
  end;
             
implementation

uses
  Sysutils;
                             
end.
