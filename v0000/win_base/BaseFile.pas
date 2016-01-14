unit BaseFile;

interface

type
  TBaseFile = class
  protected
    function GetFileSize: integer; virtual;
    procedure SetFileSize(const Value: integer); virtual;
  public
    destructor Destroy; override;
    function OpenFile(AFileUrl: string; AForceOpen: Boolean): Boolean; virtual;
    procedure CloseFile; virtual;
    property FileSize: integer read GetFileSize write SetFileSize;
  end;

implementation

{ TBaseFile }

destructor TBaseFile.Destroy;
begin
  CloseFile;
  inherited;
end;

function TBaseFile.GetFileSize: integer;
begin
  Result := 0;
end;

function TBaseFile.OpenFile(AFileUrl: string; AForceOpen: Boolean): Boolean;
begin
  Result := false;
end;

procedure TBaseFile.SetFileSize(const Value: integer);
begin
end;

procedure TBaseFile.CloseFile;
begin
end;

end.
