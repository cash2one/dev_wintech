unit UtilsHttp_Indy;

interface
    
  function Http_GetString(AURL: string): string;
  function Http_GetFile(AUrl, AOutputFile: string): Boolean;

implementation

uses
  Classes, Sysutils, IdHttp;

function Http_GetString(AURL: string): string;
var
  tmpHttp: TIdHttp;
begin             
  tmpHttp := TIdHttp.Create(nil);
  try
    Result := tmpHttp.get(AURL);
  finally
    tmpHttp.Free;
  end;
end;

function Http_GetFile(AUrl, AOutputFile: string): Boolean; 
var
  tmpHttp: TIdHttp;
  tmpOutputFile: TFileStream;
begin
  tmpOutputFile := TFileStream.Create(AOutputFile, fmCreate);
  tmpHttp := TIdHttp.Create(nil);
  try
    tmpHttp.get(AURL, tmpOutputFile);
  finally
    tmpHttp.Free;
    tmpOutputFile.Free;
  end;
  Result := FileExists(AOutputFile);
end;

end.
