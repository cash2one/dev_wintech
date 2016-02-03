unit UtilsHttp_Indy;

interface

type
  PIndyConnectionSession = ^TIndyConnectionSession;
  TIndyConnectionSession = record
    ConnectionObj : TObject;
  end;

  function CheckOutIndyConnection: PIndyConnectionSession;   
  procedure CheckInIndyConnection(var AConnection: PIndyConnectionSession);
  
  function Http_GetString(AURL: AnsiString; AConnection: PIndyConnectionSession): string;
  function Http_GetFile(AUrl, AOutputFile: AnsiString; AConnection: PIndyConnectionSession): Boolean;

implementation

uses
  Classes, Sysutils, IdHttp;

function CheckOutIndyConnection: PIndyConnectionSession;
begin
  Result := System.New(PIndyConnectionSession);
  FillChar(Result^, SizeOf(TIndyConnectionSession), 0);
  Result.ConnectionObj := TIdHttp.Create(nil);
end;

procedure CheckInIndyConnection(var AConnection: PIndyConnectionSession);
begin
end;

function Http_GetString(AURL: AnsiString; AConnection: PIndyConnectionSession): string;
var
  tmpHttp: TIdHttp;
  tmpIsOwned: Boolean;
begin
  tmpHttp := nil;
  tmpIsOwned := false;
  if nil <> AConnection then
  begin
    tmpHttp := TIdHttp(AConnection.ConnectionObj);
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

function Http_GetFile(AUrl, AOutputFile: AnsiString; AConnection: PIndyConnectionSession): Boolean; 
var
  tmpHttp: TIdHttp;        
  tmpIsOwned: Boolean;
  tmpOutputFile: TFileStream;
begin          
  tmpHttp := nil;
  tmpIsOwned := false;
  if nil <> AConnection then
  begin
    tmpHttp := TIdHttp(AConnection.ConnectionObj);
  end;
  tmpOutputFile := TFileStream.Create(AOutputFile, fmCreate);
  if nil = tmpHttp then
  begin
    tmpIsOwned := true;
    tmpHttp := TIdHttp.Create(nil);
  end;
  try
    tmpHttp.get(AURL, tmpOutputFile);
  finally
    if tmpIsOwned then
    begin
      tmpHttp.Free;
    end;
    tmpOutputFile.Free;
  end;
  Result := FileExists(AOutputFile);
end;

end.
