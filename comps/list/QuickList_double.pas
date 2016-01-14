unit QuickList_double;

interface

uses
  QuickSortList;

type
  {---------------------------------------}
  PALDoubleListItem = ^TALDoubleListItem;
  TALDoubleListItem = record
    FDouble: Double;
    FObject: TObject;
  end;

  {------------------------------------------}
  TALDoubleList = class(TALBaseQuickSortList)
  public
    function  GetItem(Index: Integer): double;
    procedure SetItem(Index: Integer; const Item: double);
    function  GetObject(Index: Integer): TObject;
    procedure PutObject(Index: Integer; AObject: TObject);
  public
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    procedure InsertItem(Index: Integer; const item: double; AObject: TObject);
    function  CompareItems(const Index1, Index2: Integer): Integer; override;
  public
    function  IndexOf(Item: double): Integer;
    function  IndexOfObject(AObject: TObject): Integer;
    function  Add(const Item: double): Integer;
    Function  AddObject(const Item: double; AObject: TObject): Integer;
    function  Find(item: double; var Index: Integer): Boolean;
    procedure Insert(Index: Integer; const item: double);
    procedure InsertObject(Index: Integer; const item: double; AObject: TObject);
    property  Items[Index: Integer]: double read GetItem write SetItem; default;
    property  Objects[Index: Integer]: TObject read GetObject write PutObject;
  end;

implementation

{********************************************************}
function TALDoubleList.Add(const Item: double): Integer;
begin
  Result := AddObject(Item, nil);
end;

{********************************************************************************}
function TALDoubleList.AddObject(const Item: double; AObject: TObject): Integer;
begin
  if not Sorted then
  begin
    Result := FCount
  end else if Find(Item, Result) then
  begin
    case Duplicates of
      lstDupIgnore: Exit;
      lstDupError: Error(@SALDuplicateItem, 0);
    end;
  end;
  InsertItem(Result, Item, AObject);
end;

{*****************************************************************************************}
procedure TALDoubleList.InsertItem(Index: Integer; const item: double; AObject: TObject);
Var
  tmpDoubleListItem: PALDoubleListItem;
begin
  New(tmpDoubleListItem);
  tmpDoubleListItem^.FDouble := item;
  tmpDoubleListItem^.FObject := AObject;
  try
    inherited InsertItem(index, tmpDoubleListItem);
  except
    Dispose(tmpDoubleListItem);
    raise;
  end;
end;

{***************************************************************************}
function TALDoubleList.CompareItems(const Index1, Index2: integer): Integer;
begin
  if PALDoubleListItem(Get(Index1))^.FDouble = PALDoubleListItem(Get(Index2))^.FDouble then
  begin
    Result := 0;
  end else
  begin
    if PALDoubleListItem(Get(Index1))^.FDouble > PALDoubleListItem(Get(Index2))^.FDouble then
    begin
      Result := 1;
    end else
    begin
      Result := -1;
    end;
  end;
  //result := PALDoubleListItem(Get(Index1))^.FDouble - PALDoubleListItem(Get(Index2))^.FDouble;
end;

{***********************************************************************}
function TALDoubleList.Find(item: Double; var Index: Integer): Boolean;
var
  L: Integer;
  H: Integer;
  I: Integer;
  C: double;
begin
  Result := False;
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := GetItem(I) - item;
    if C < 0 then
    begin
      L := I + 1
    end else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> lstDupAccept then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

{*******************************************************}
function TALDoubleList.GetItem(Index: Integer): double;
begin
  Result := PALDoubleListItem(Get(index))^.FDouble
end;

{******************************************************}
function TALDoubleList.IndexOf(Item: double): Integer;
begin
  if not Sorted then
  Begin
    Result := 0;
    while (Result < FCount) and (GetItem(result) <> Item) do
    begin
      Inc(Result);
    end;
    if Result = FCount then
    begin
      Result := -1;
    end;
  end else
  begin
    if not Find(Item, Result) then
      Result := -1;
  end;
end;

{*******************************************************************}
procedure TALDoubleList.Insert(Index: Integer; const Item: double);
begin
  InsertObject(Index, index, nil);
end;

{*******************************************************************************************}
procedure TALDoubleList.InsertObject(Index: Integer; const item: double; AObject: TObject);
Var
  tmpDoubleListItem: PALDoubleListItem;
begin
  New(tmpDoubleListItem);
  tmpDoubleListItem^.FDouble := item;
  tmpDoubleListItem^.FObject := AObject;
  try
    inherited insert(index, tmpDoubleListItem);
  except
    Dispose(tmpDoubleListItem);
    raise;
  end;
end;

{***********************************************************************}
procedure TALDoubleList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Action = lstDeleted then
    dispose(ptr);
  inherited Notify(Ptr, Action);
end;

{********************************************************************}
procedure TALDoubleList.SetItem(Index: Integer; const Item: double);
Var
  tmpDoubleListItem: PALDoubleListItem;
begin
  New(tmpDoubleListItem);
  tmpDoubleListItem^.FDouble := item;
  tmpDoubleListItem^.FObject := nil;
  Try
    Put(Index, tmpDoubleListItem);
  except
    Dispose(tmpDoubleListItem);
    raise;
  end;
end;

{*********************************************************}
function TALDoubleList.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then Error(@SALListIndexError, Index);
  Result :=  PALDoubleListItem(Get(index))^.FObject;
end;

{***************************************************************}
function TALDoubleList.IndexOfObject(AObject: TObject): Integer;
begin
  for Result := 0 to Count - 1 do
  begin
    if GetObject(Result) = AObject then
    begin
      Exit;
    end;
  end;
  Result := -1;
end;

{*******************************************************************}
procedure TALDoubleList.PutObject(Index: Integer; AObject: TObject);
begin
  if (Index < 0) or (Index >= FCount) then
  begin
    Error(@SALListIndexError, Index);
  end;
  PALDoubleListItem(Get(index))^.FObject := AObject;
end;

end.
