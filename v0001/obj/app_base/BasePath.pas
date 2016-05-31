unit BasePath;

interface

type
  TBasePath = class
  protected
    function GetDataBasePath(ADBType: integer; ADataSrc: integer): WideString; virtual;
    function GetInstallPath: WideString; virtual;
    procedure SetDataBasePath(ADBType: integer; ADataSrc: integer; const Value: WideString); virtual;
    procedure SetInstallPath(const Value: WideString); virtual;
  public
    function IsFileExists(AFileUrl: WideString): Boolean; virtual;
    function IsPathExists(APathUrl: WideString): Boolean; virtual;

    function GetRootPath: WideString; virtual;
    function GetFileRelativePath(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): WideString; virtual;
    function GetFilePath(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): WideString; virtual;

    function GetFileName(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: WideString): WideString; virtual;
    function GetFileExt(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: WideString): WideString; virtual;
    
    function GetFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): WideString; overload; virtual;
    function GetFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: WideString): WideString; overload; virtual;

    function CheckOutFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: WideString): WideString; virtual;

    property InstallPath: WideString read GetInstallPath write SetInstallPath;  
    property DataBasePath[ADBType: integer; ADataSrc: integer]: WideString read GetDataBasePath write SetDataBasePath;
  end;
  
implementation

function TBasePath.GetDataBasePath(ADBType: integer; ADataSrc: integer): WideString;
begin
  Result := '';
end;

function TBasePath.GetFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): WideString;
begin
  Result := GetFileUrl(ADBType, ADataSrc, AParamType, AParam, '');
end;

function TBasePath.CheckOutFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: WideString): WideString; 
begin
  Result := '';
end;
                      
function TBasePath.GetRootPath: WideString;
begin
  Result := '';
end;

function TBasePath.GetFileRelativePath(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): WideString; 
begin
  Result := '';
end;

function TBasePath.GetFilePath(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): WideString;
begin
  Result := '';
end;

function TBasePath.GetFileName(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: WideString): WideString; 
begin
  Result := '';
end;

function TBasePath.GetFileExt(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: WideString): WideString;
begin
  Result := '';
end;

function TBasePath.GetFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: WideString): WideString;
begin
  Result := '';
end;

function TBasePath.GetInstallPath: WideString;
begin
  Result := '';
end;

function TBasePath.IsFileExists(AFileUrl: WideString): Boolean;
begin
  Result := false;
end;

function TBasePath.IsPathExists(APathUrl: WideString): Boolean;
begin
  Result := false;
end;

procedure TBasePath.SetDataBasePath(ADBType: integer; ADataSrc: integer; const Value: WideString);
begin
end;

procedure TBasePath.SetInstallPath(const Value: WideString);
begin
end;

end.
