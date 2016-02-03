unit UtilsHttp_Indy;

interface

type
  PIndyConnection = ^TIndyConnection;
  TIndyConnection = record
    ConnectionObj : TObject;
  end;

  function CheckOutIndyConnection: PIndyConnection;   
  procedure CheckInIndyConnection(var AIndyConnection: PIndyConnection);
  
  function Http_GetString(AURL: AnsiString; AIndyConnection: PIndyConnection): string;
  function Http_GetFile(AUrl, AOutputFile: AnsiString; AIndyConnection: PIndyConnection): Boolean;

implementation

uses
  Classes, Sysutils, IdHttp;

function CheckOutIndyConnection: PIndyConnection;
begin
  Result := System.New(PIndyConnection);
  FillChar(Result^, SizeOf(TIndyConnection), 0);
  Result.ConnectionObj := TIdHttp.Create(nil);
end;

procedure CheckInIndyConnection(var AIndyConnection: PIndyConnection);
begin
end;

function Http_GetString(AURL: AnsiString; AIndyConnection: PIndyConnection): string;
var
  tmpHttp: TIdHttp;
  tmpIsOwned: Boolean;
begin
  tmpHttp := nil;
  tmpIsOwned := false;
  if nil <> AIndyConnection then
  begin
    tmpHttp := TIdHttp(AIndyConnection.ConnectionObj);
  end;
  if nil = tmpHttp then
  begin
    tmpIsOwned := true;
    tmpHttp := TIdHttp.Create(nil);
  end;
  try
    Result := tmpHttp.get(AURL);
  finally
    if tmpIsOwned then
    begin
      tmpHttp.Free;
    end;
  end;
end;

function Http_GetFile(AUrl, AOutputFile: AnsiString; AIndyConnection: PIndyConnection): Boolean; 
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
