unit win.registry;

interface

uses
  Windows;

type           
  TRegDataType  = (rdUnknown, rdString, rdExpandString, rdInteger, rdBinary);
                   
  TRegDataInfo  = record
    RegDataType : TRegDataType;
    DataSize    : Integer;
  end;

  PRegistryUrl  = ^TRegistryUrl;    
  TRegistryUrl  = record
    Path        : AnsiString;
  end;

  PRegistryKey  = ^TRegistryKey;
  TRegistryKey  = record
    CurrentKey  : HKEY;
    RootKey     : HKEY;       
    Access      : LongWord;
    Url         : PRegistryUrl;
  end;

  procedure CloseRegistryKey(AKey: PRegistryKey);
  function OpenRegistryKey(AKey: PRegistryKey; AKeyUrl: PRegistryUrl; AIsCanCreate: Boolean): Boolean;
  function GetRegistryData(AKey: PRegistryKey; const AKeyName: AnsiString; Buffer: Pointer; BufSize: Integer; var RegData: TRegDataType): Integer;
  function DataTypeToRegData(Value: Integer): TRegDataType;

  function RegistryReadInteger(AKey: PRegistryKey; const AKeyName: AnsiString): Integer;
  
implementation

procedure CloseRegistryKey(AKey: PRegistryKey);
begin
  if AKey.CurrentKey <> 0 then
  begin
    //if not LazyWrite then
      //RegFlushKey(AKey.CurrentKey);
    RegCloseKey(AKey.CurrentKey);
    AKey.CurrentKey := 0;
    AKey.Url := nil;
  end;
end;

function OpenRegistryKey(AKey: PRegistryKey; AKeyUrl: PRegistryUrl; AIsCanCreate: Boolean): Boolean;
var
  TempKey: HKey;
  S: string;
  Disposition: Integer;
  Relative: Boolean;
begin
//  S := Key;
//  Relative := IsRelative(S);
//  if not Relative then
//  begin
//    Delete(S, 1, 1);
//  end;
  TempKey := 0;
  if not AIsCanCreate or (S = '') then
  begin
    Result := Windows.RegOpenKeyExA(AKey.RootKey, PAnsiChar(AKeyUrl.Path), 0, AKey.Access, TempKey) = ERROR_SUCCESS;
//    Result := RegOpenKeyEx(GetBaseKey(Relative), PChar(S), 0, FAccess, TempKey) = ERROR_SUCCESS;
  end else
  begin
//    Result := RegCreateKeyEx(GetBaseKey(Relative), PChar(S), 0, nil,
//      REG_OPTION_NON_VOLATILE, FAccess, nil, TempKey, @Disposition) = ERROR_SUCCESS;
  end;
  if Result then
  begin
    if (0 <> AKey.CurrentKey) then
    begin
      //S := CurrentPath + '\' + S;
    end;
    //ChangeKey(TempKey, S);
  end;
end;

function DataTypeToRegData(Value: Integer): TRegDataType;
begin
  if Value = REG_SZ then Result := rdString
  else if Value = REG_EXPAND_SZ then Result := rdExpandString
  else if Value = REG_DWORD then Result := rdInteger
  else if Value = REG_BINARY then Result := rdBinary
  else Result := rdUnknown;
end;

function GetRegistryData(AKey: PRegistryKey; const AKeyName: AnsiString; Buffer: Pointer; BufSize: Integer; var RegData: TRegDataType): Integer;
var
  tmpDataType: Integer;
begin
  tmpDataType := REG_NONE;
  if RegQueryValueExA(AKey.CurrentKey, PAnsiChar(AKeyName), nil, @tmpDataType, PByte(Buffer), @BufSize) <> ERROR_SUCCESS then
  begin
    //raise ERegistryException.CreateResFmt(@SRegGetDataFailed, [Name]);
  end;
  Result := BufSize;
  RegData := DataTypeToRegData(tmpDataType);
end;

function RegistryReadInteger(AKey: PRegistryKey; const AKeyName: AnsiString): Integer;
var
  tmpRegData: TRegDataType;
begin
  GetRegistryData(AKey, AKeyName, @Result, SizeOf(Integer), tmpRegData);
  if tmpRegData <> rdInteger then
  begin
    //ReadError(Name);
  end;
end;
      
function RegistryGetDataInfo(AKey: PRegistryKey; const ValueName: AnsiString; var Value: TRegDataInfo): Boolean;
var
  tmpDataType: Integer;
begin
  FillChar(Value, SizeOf(TRegDataInfo), 0);
  Result := RegQueryValueExA(AKey.CurrentKey, PAnsiChar(ValueName), nil, @tmpDataType, nil, @Value.DataSize) = ERROR_SUCCESS;
  Value.RegDataType := DataTypeToRegData(tmpDataType);
end;
          
function RegistryGetDataSize(AKey: PRegistryKey; const ValueName: AnsiString): Integer;
var
  tmpInfo: TRegDataInfo;
begin
  if RegistryGetDataInfo(AKey, ValueName, tmpInfo) then
    Result := tmpInfo.DataSize
  else
    Result := -1;
end;

function RegistryReadString(AKey: PRegistryKey; const AKeyName: AnsiString): AnsiString;
var
  tmpLen: Integer;
  tmpRegData: TRegDataType;
begin
  tmpLen := RegistryGetDataSize(AKey, AKeyName);
  if tmpLen > 0 then
  begin
    SetString(Result, nil, tmpLen);
    GetRegistryData(AKey, AKeyName, PAnsiChar(Result), tmpLen, tmpRegData);
    if (tmpRegData = rdString) or (tmpRegData = rdExpandString) then
    begin
      //SetLength(Result, StrLen(PAnsiChar(Result)))
    end else
    begin
      //ReadError(Name);
    end;
  end else
  begin
    Result := '';
  end;
end;

end.
