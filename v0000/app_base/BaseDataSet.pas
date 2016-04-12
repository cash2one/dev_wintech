unit BaseDataSet;

interface

type
  TBaseDataSetAccess = class
  protected
    function GetRecordCount: Integer; virtual;
    function GetRecordItem(AIndex: integer): Pointer; virtual;
  public
    function FindRecordByKey(AKey: Integer): Pointer; virtual;
    function CheckOutKeyRecord(AKey: Integer): Pointer; virtual;

    procedure Sort; virtual;  
    procedure Clear; virtual;
    property RecordCount: Integer read GetRecordCount;
    property RecordItem[AIndex: integer]: Pointer read GetRecordItem;
  end;

implementation

{ TBaseDataSetAccess }

function TBaseDataSetAccess.CheckOutKeyRecord(AKey: Integer): Pointer;
begin
  Result := nil;
end;

function TBaseDataSetAccess.FindRecordByKey(AKey: Integer): Pointer;
begin
  Result := nil;
end;

function TBaseDataSetAccess.GetRecordCount: Integer;
begin
  Result := 0;
end;

function TBaseDataSetAccess.GetRecordItem(AIndex: integer): Pointer;
begin
  Result := nil;
end;

procedure TBaseDataSetAccess.Sort;
begin
end;

procedure TBaseDataSetAccess.Clear;
begin
end;

end.
