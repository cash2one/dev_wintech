unit QuickList_Int;

interface

uses
  QuickSortList;

type
  {---------------------------------------}
  PALIntegerListItem = ^TALIntegerListItem;
  TALIntegerListItem = record
    FInteger: integer;
    FObject: TObject;
  end;

  {------------------------------------------}
  TALIntegerList = class(TALBaseQuickSortList)
  public
    function  GetItem(Index: Integer): Integer;
    procedure SetItem(Index: Integer; const Item: Integer);
    function  GetObject(Index: Integer): TObject;
    procedure PutObject(Index: Integer; AObject: TObject);
  public
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    procedure InsertItem(Index: Integer; const item: integer; AObject: TObject);
    function  CompareItems(const Index1, Index2: Integer): Integer; override;
  public
    function  IndexOf(Item: Integer): Integer;
    function  IndexOfObject(AObject: TObject): Integer;
    function  Add(const Item: integer): Integer;
    Function  AddObject(const Item: integer; AObject: TObject): Integer;
    function  Find(item: Integer; var Index: Integer): Boolean;
    procedure Insert(Index: Integer; const item: integer);
    procedure InsertObject(Index: Integer; const item: integer; AObject: TObject);
    property  Items[Index: Integer]: Integer read GetItem write SetItem; default;
    property  Objects[Index: Integer]: TObject read GetObject write PutObject;
  end;

implementation

{********************************************************}
function TALIntegerList.Add(const Item: integer): Integer;
begin
  Result := AddObject(Item, nil);
end;

{********************************************************************************}
function TALIntegerList.AddObject(const Item: integer; AObject: TObject): Integer;
begin
  if not Sorted then Result := FCount
  else if Find(Item, Result) then
    case Duplicates of
      lstDupIgnore: Exit;
      lstDupError: Error(@SALDuplicateItem, 0);
    end;
  InsertItem(Result, Item, AObject);
end;

{*****************************************************************************************}
procedure TALIntegerList.InsertItem(Index: Integer; const item: integer; AObject: TObject);
Var aPALIntegerListItem: PALIntegerListItem;
begin
  New(aPALIntegerListItem);
  aPALIntegerListItem^.FInteger := item;
  aPALIntegerListItem^.FObject := AObject;
  try
    inherited InsertItem(index,aPALIntegerListItem);
  except
    Dispose(aPALIntegerListItem);
    raise;
  end;
end;

{***************************************************************************}
function TALIntegerList.CompareItems(const Index1, Index2: integer): Integer;
begin
  result := PALIntegerListItem(Get(Index1))^.FInteger - PALIntegerListItem(Get(Index2))^.FInteger;
end;

{***********************************************************************}
function TALIntegerList.Find(item: Integer; var Index: Integer): Boolean;
var L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := FCount - 1;
  while L <= H do begin
    I := (L + H) shr 1;
    C := GetItem(I) - item;
    if C < 0 then L := I + 1
    else begin
      H := I - 1;
      if C = 0 then begin
        Result := True;
        if Duplicates <> lstDupAccept then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

{*******************************************************}
function TALIntegerList.GetItem(Index: Integer): Integer;
begin
  Result := PALIntegerListItem(Get(index))^.FInteger
end;

{******************************************************}
function TALIntegerList.IndexOf(Item: Integer): Integer;
begin
  if not Sorted then Begin
    Result := 0;
    while (Result < FCount) and (GetItem(result) <> Item) do Inc(Result);
    if Result = FCount then Result := -1;
  end
  else if not Find(Item, Result) then Result := -1;
end;

{*******************************************************************}
procedure TALIntegerList.Insert(Index: Integer; const Item: Integer);
begin
  InsertObject(Index, index, nil);
end;

{*******************************************************************************************}
procedure TALIntegerList.InsertObject(Index: Integer; const item: integer; AObject: TObject);
Var aPALIntegerListItem: PALIntegerListItem;
begin
  New(aPALIntegerListItem);
  aPALIntegerListItem^.FInteger := item;
  aPALIntegerListItem^.FObject := AObject;
  try
    inherited insert(index,aPALIntegerListItem);
  except
    Dispose(aPALIntegerListItem);
    raise;
  end;
end;

{***********************************************************************}
procedure TALIntegerList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Action = lstDeleted then
    dispose(ptr);
  inherited Notify(Ptr, Action);
end;

{********************************************************************}
procedure TALIntegerList.SetItem(Index: Integer; const Item: Integer);
Var aPALIntegerListItem: PALIntegerListItem;
begin
  New(aPALIntegerListItem);
  aPALIntegerListItem^.FInteger := item;
  aPALIntegerListItem^.FObject := nil;
  Try
    Put(Index, aPALIntegerListItem);
  except
    Dispose(aPALIntegerListItem);
    raise;
  end;
end;

{*********************************************************}
function TALIntegerList.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then Error(@SALListIndexError, Index);
  Result :=  PALIntegerListItem(Get(index))^.FObject;
end;

{***************************************************************}
function TALIntegerList.IndexOfObject(AObject: TObject): Integer;
begin
  for Result := 0 to Count - 1 do
    if GetObject(Result) = AObject then Exit;
  Result := -1;
end;

{*******************************************************************}
procedure TALIntegerList.PutObject(Index: Integer; AObject: TObject);
begin
  if (Index < 0) or (Index >= FCount) then Error(@SALListIndexError, Index);
  PALIntegerListItem(Get(index))^.FObject := AObject;
end;

end.
