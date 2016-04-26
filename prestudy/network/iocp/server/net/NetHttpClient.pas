unit NetHttpClient;

interface

uses
  NetBaseObj;
  
type
  PNetHttpClient = ^TNetHttpClient;
  TNetHttpClient = record
    NetClient: PNetClient;
  end;

implementation

end.
