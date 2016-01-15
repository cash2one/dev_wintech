unit UtilsHttp_WinInet;

interface
                      
  function Http_GetString(AURL: string): string;

implementation

uses
  CnInetUtils;

function Http_GetString(AURL: string): string;
begin
  Result := CnInet_GetString(AURL);
end;

end.
