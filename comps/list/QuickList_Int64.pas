unit QuickList_Int64;

interface

uses
  QuickSortList;

type
  {-----------------------------------}
  PALInt64ListItem = ^TALInt64ListItem;
  TALInt64ListItem = record
    FInt64: Int64;
    FObject: TObject;
  end;

  {----------------------------------------}
  TALInt64List = class(TALBaseQuickSortList)
  public
    function  GetItem(Index: Integer): Int64;
    procedure SetItem(Index: Integer; const Item: Int64);
    function  GetObject(Index: Integer): TObject;
    procedure PutObject(Index: Integer; AObject: TObject);
  public
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    procedure InsertItem(Index: Integer; const item: Int64; AObject: TObject);
    function  CompareItems(const Index1, Index2: Integer): Integer; override;
  public
    function  IndexOf(Item: Int64): Integer;
    function  IndexOfObject(AObject: TObject): Integer;
    function  Add(const Item: Int64): Integer;
    Function  AddObject(const Item: Int64; AObject: TObject): Integer;
    function  Find(item: Int64; var Index: Integer): Boolean;
    procedure Insert(Index: Integer; const item: Int64);
    procedure InsertObject(Index: Integer; const item: Int64; AObject: TObject);
    property  Items[Index: Integer]: Int64 read GetItem write SetItem; default;
    property  Objects[Index: Integer]: TObject read GetObject write PutObject;
  end;

implementation


{****************************************************}
function TALInt64List.Add(const Item: Int64): Integer;
begin
  Result := AddObject(Item, nil);
end;

{****************************************************************************}
function TALInt64List.AddObject(const Item: Int64; AObject: TObject): Integer;
begin
  if not Sorted then
  begin
    Result := FCount
  end else if Find(Item, Result) then
  begin
    case Duplicates of
      lstdupIgnore: Exit;
      lstdupError: Error(@SALDuplicateItem, 0);
    end;
  end;
  InsertItem(Result, Item, AObject);
end;

{*************************************************************************************}
procedure TALInt64List.InsertItem(Index: Integer; const item: Int64; AObject: TObject);
var
  tmpInt64Item: PALInt64ListItem;
begin
  New(tmpInt64Item);
  tmpInt64Item^.FInt64 := item;
  tmpInt64Item^.FObject := AObject;
  try
    inherited InsertItem(index, tmpInt64Item);
  except
    Dispose(tmpInt64Item);
    raise;
  end;
end;

{*************************************************************************}
function TALInt64List.CompareItems(const Index1, Index2: integer): Integer;
var
  tmpInt64: Int64;
begin
  tmpInt64 := PALInt64ListItem(Get(Index1))^.FInt64 - PALInt64ListItem(Get(Index2))^.FInt64;
  if tmpInt64 < 0 then
    result := -1
  else if tmpInt64 > 0 then
    result := 1
  else
    result := 0;
end;

{*******************************************************************}
function TALInt64List.Find(item: Int64; var Index: Integer): Boolean;
var L, H, I, C: Integer;

  {--------------------------------------------}
  Function _CompareInt64(D1,D2: Int64): Integer;
  Begin
    if D1 < D2 then result := -1
    else if D1 > D2 then result := 1
    else result := 0;
  end;

begin
  Result := False;
  L := 0;
  H := FCount - 1;
  while L <= H do begin
    I := (L + H) shr 1;
    C := _CompareInt64(GetItem(I),item);
    if C < 0 then
    begin
      L := I + 1
    end else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> lstdupAccept then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

{***************************************************}
function TALInt64List.GetItem(Index: Integer): Int64;
begin
  Result := PALInt64ListItem(Get(index))^.FInt64
end;

{**************************************************}
function TALInt64List.IndexOf(Item: Int64): Integer;
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
    if not Find(Item, Result) then
    begin
      Result := -1;
    end;
end;

{***************************************************************}
procedure TALInt64List.Insert(Index: Integer; const Item: Int64);
begin
  InsertObject(Index, index, nil);
end;

{***************************************************************************************}
procedure TALInt64List.InsertObject(Index: Integer; const item: Int64; AObject: TObject);
Var
  tmpInt64Item: PALInt64ListItem;
begin
  New(tmpInt64Item);
  tmpInt64Item^.FInt64 := item;
  tmpInt64Item^.FObject := AObject;
  try
    inherited insert(index, tmpInt64Item);
  except
    Dispose(tmpInt64Item);
    raise;
  end;
end;

{*********************************************************************}
procedure TALInt64List.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Action = lstDeleted then
    dispose(ptr);
  inherited Notify(Ptr, Action);
end;

{****************************************************************}
procedure TALInt64List.SetItem(Index: Integer; const Item: Int64);
var
  tmpInt64Item: PALInt64ListItem;
begin
  New(tmpInt64Item);
  tmpInt64Item^.FInt64 := item;
  tmpInt64Item^.FObject := nil;
  try
    Put(Index, tmpInt64Item);
  except
    Dispose(tmpInt64Item);
    raise;
  end;
end;

{*******************************************************}
function TALInt64List.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then Error(@SALListIndexError, Index);
  Result :=  PALInt64ListItem(Get(index))^.FObject;
end;

{*************************************************************}
function TALInt64List.IndexOfObject(AObject: TObject): Integer;
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

{*****************************************************************}
procedure TALInt64List.PutObject(Index: Integer; AObject: TObject);
begin
  if (Index < 0) or (Index >= FCount) then
  begin
    Error(@SALListIndexError, Index);
  end;
  PALInt64ListItem(Get(index))^.FObject := AObject;
end;

end.
