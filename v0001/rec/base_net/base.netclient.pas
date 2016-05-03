unit base.netclient;

interface

uses
  Types;

type  
  PNetServerAddress       = ^TNetServerAddress;
  TNetServerAddress       = record
    DataType              : integer;
    Host                  : AnsiString;
    Ip                    : AnsiString;
    Port                  : Word;
  end;

implementation

end.
