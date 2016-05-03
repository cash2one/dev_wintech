unit BaseFile;

interface

uses
  Types;
  
type
  TBaseFile = class
  protected
    function GetFileSize: Types.DWORD; virtual;
    procedure SetFileSize(const Value: Types.DWORD); virtual;
  public
    destructor Destroy; override;
    function OpenFile(AFileUrl: WideString; AForceOpen: Boolean): Boolean; virtual;
    procedure CloseFile; virtual;
    property FileSize: Types.DWORD read GetFileSize write SetFileSize;
  end;

implementation

{ TBaseFile }

destructor TBaseFile.Destroy;
begin
  CloseFile;
  inherited;
end;

function TBaseFile.GetFileSize: Types.DWORD;
begin
  Result := 0;
end;

function TBaseFile.OpenFile(AFileUrl: WideString; AForceOpen: Boolean): Boolean;
begin
  Result := false;
end;

procedure TBaseFile.SetFileSize(const Value: Types.DWORD);
begin
end;

procedure TBaseFile.CloseFile;
begin
end;

end.
