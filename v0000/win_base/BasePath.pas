unit BasePath;

interface

type
  TBasePath = class
  protected
    function GetDataBasePath(ADBType: integer; ADataSrc: integer): string; virtual;
    function GetInstallPath: string; virtual;
    procedure SetDataBasePath(ADBType: integer; ADataSrc: integer; const Value: string); virtual;
    procedure SetInstallPath(const Value: string); virtual;
  public
    function IsFileExists(AFileUrl: string): Boolean; virtual;
    function IsPathExists(APathUrl: string): Boolean; virtual;
    function GetFilePath(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): string; virtual;
    function GetFileName(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: string): string; virtual;
    
    function CheckOutFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: string): string; virtual;
    function GetFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): string; overload; virtual;
    function GetFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: string): string; overload; virtual;
    
    property InstallPath: string read GetInstallPath write SetInstallPath;  
    property DataBasePath[ADBType: integer; ADataSrc: integer]: string read GetDataBasePath write SetDataBasePath;
  end;
  
implementation

function TBasePath.GetDataBasePath(ADBType: integer; ADataSrc: integer): string;
begin
  Result := '';
end;

function TBasePath.GetFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): string;
begin
  Result := GetFileUrl(ADBType, ADataSrc, AParamType, AParam, '');
end;

function TBasePath.CheckOutFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: string): string; 
begin
  Result := '';
end;

function TBasePath.GetFilePath(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer): string; 
begin
  Result := '';
end;

function TBasePath.GetFileName(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: string): string; 
begin
  Result := '';
end;

function TBasePath.GetFileUrl(ADBType: integer; ADataSrc: integer; AParamType: integer; AParam: Pointer; AFileExt: string): string;
begin
  Result := '';
end;

function TBasePath.GetInstallPath: string;
begin
  Result := '';
end;

function TBasePath.IsFileExists(AFileUrl: string): Boolean;
begin
  Result := false;
end;

function TBasePath.IsPathExists(APathUrl: string): Boolean;
begin
  Result := false;
end;

procedure TBasePath.SetDataBasePath(ADBType: integer; ADataSrc: integer; const Value: string);
begin
end;

procedure TBasePath.SetInstallPath(const Value: string);
begin
end;

end.
