unit UtilsHttp;

interface

  function GetHttpUrlData(AUrl: string): string; overload;      
  function GetHttpUrlData(AUrl: string; APost: string): string; overload;
  function GetHttpUrlFile(AUrl: string; AOutputFile: string): Boolean; overload;

  function PostHttpUrlData(AUrl: string; APost: string): string;       

implementation

uses
  Http_Indy;

function GetHttpUrlData(AUrl: string): string;
begin
  //Result := Http_WinInet.Http_GetString(AUrl);     
  Result := Http_Indy.Http_GetString(AUrl);
end;

function GetHttpUrlFile(AUrl: string; AOutputFile: string): Boolean;
begin    
  Result := Http_Indy.Http_GetFile(AUrl, AOutputFile);
end;

function GetHttpUrlData(AUrl: string; APost: string): string;
begin          
  Result := '';
//  Result := Http_WinInet.Http_GetString(AUrl);
end;

function PostHttpUrlData(AUrl: string; APost: string): string;
begin
  Result := '';
//  Result := Http_WinInet.Http_GetString(AUrl);
end;

end.
