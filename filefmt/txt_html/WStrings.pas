unit WStrings;

interface

uses
  Classes, SysUtils;

type
  PWStringItem = ^TWStringItem;
  TWStringItem = record
    FString: WideString;
  end;

  PWStringItemList = ^TWStringItemList;
  TWStringItemList = array[0..MaxListSize] of TWStringItem;

  TWStringList = class
  private
    FList: PWStringItemList;
    FCount: Integer;
    FCapacity: Integer;
    FDuplicates: TDuplicates; 
    function GetValue(const Name: WideString): WideString;
    procedure SetValue(const Name, Value: WideString);
    
    function GetTextStr: WideString;      
    procedure SetTextStr(const Value: WideString);
    procedure Grow;
    procedure InsertItem(Index: Integer; const S: WideString);
  protected
    function  Get(Index: Integer): WideString; 
    function  GetCapacity: Integer;
    function  GetCount: Integer;
    procedure Put(Index: Integer; const S: WideString);
    procedure SetCapacity(NewCapacity: Integer);
  public
    destructor Destroy; override;
    function  Add(const S: WideString): Integer;
    procedure Clear;
    procedure Delete(Index: Integer);  
    function IndexOfName(const Name: WideString): Integer;
    procedure Error(const Msg: String; Data: Integer);

    function  Find(const S: WideString; var Index: Integer): Boolean; virtual;
    function  IndexOf(const S: WideString): Integer; 
    procedure Insert(Index: Integer; const S: WideString); 
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
    property Count: Integer read GetCount;          
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Values[const Name: WideString]: WideString read GetValue write SetValue;
    property Strings[Index: Integer]: WideString read Get write Put; default;
    property Text: WideString read GetTextStr write SetTextStr;
  end;

implementation

{$IFDEF VER100}{$DEFINE D6_BELOW}{$ENDIF}
{$IFDEF VER120}{$DEFINE D6_BELOW}{$ENDIF}
{$IFDEF VER130}{$DEFINE D6_BELOW}{$ENDIF}

uses
  Consts{$IFNDEF D6_BELOW}, RTLConsts{$ENDIF};

const
  WordDelimiters = [0..32, 127];

function IsWholeWord(const S: WideString; Start, Len: Integer): Boolean;
begin
  Result := false;
  if (Start > 1) and not (Ord(S[Start - 1]) in WordDelimiters) then
    Exit;
  if ((Start + Len) < Length(S)) and not (Ord(S[Start + Len]) in WordDelimiters) then
    Exit;
  Result := true
end;

function WidePos(const Substr, S: WideString): Integer;

  function TestPos(P: Integer): Boolean;
  var
    I: Integer;
  begin
    Result := false;
    for I := 1 to Length(Substr) do
      if S[P + I - 1] <> Substr[I] then
        Exit;
    Result := true
  end;

begin
  for Result := 1 to Length(S) - Length(Substr) + 1 do
    if TestPos(Result) then
      Exit;
  Result := 0
end;

function WideCompareStr(const S1, S2: WideString): Integer;
begin
  if S1 < S2 then
    Result := -1
  else
  if S1 > S2 then
    Result := 1
  else
    Result := 0
end;

procedure TWStringList.Error(const Msg: String; Data: Integer);

  function ReturnAddr: Pointer;
  asm
    MOV    EAX,[EBP+4]
  end;

begin
//  raise EStringListError.CreateFmt(Msg, [Data]) at ReturnAddr;
end;

function TWStringList.GetTextStr: WideString;
var
  I, L, Size, Count: Integer;
  P: PWideChar;
  S: WideString;
begin
  Count := GetCount;
  Size := 0;
  for I := 0 to Count - 1 do
    Inc(Size, Length(Get(I)) + 2);
  SetLength(Result, Size);
  P := Pointer(Result);
  for I := 0 to Count - 1 do
  begin
    S := Get(I);
    L := Length(S);
    if L <> 0 then
    begin
      System.Move(Pointer(S)^, P^, SizeOf(WideChar) * L);
      Inc(P, L);
    end;
    P^ := #13;
    Inc(P);
    P^ := #10;
    Inc(P)
  end
end;

function TWStringList.GetValue(const Name: WideString): WideString;
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if I >= 0 then
    Result := Copy(Get(I), Length(Name) + 2, MaxInt)
  else
    Result := ''
end;

function TWStringList.IndexOf(const S: WideString): Integer;
begin
  for Result := 0 to GetCount - 1 do
    if WideCompareStr(Get(Result), S) = 0 then
      Exit;
  Result := -1
end;

function TWStringList.IndexOfName(const Name: WideString): Integer;
var
  P: Integer;
  S: WideString;
begin
  for Result := 0 to GetCount - 1 do
  begin
    S := Get(Result);
    P := WidePos('=', S);
    if (P <> 0) and (WideCompareStr(Copy(S, 1, P - 1), Name) = 0) then
      Exit
  end;
  Result := -1
end;

procedure TWStringList.SetTextStr(const Value: WideString);
var
  P, Start: PWideChar;
  S: WideString;
begin
    Clear;
    P := Pointer(Value);
    if P <> nil then
      while P^ <> #0 do
      begin
        Start := P;
        while not (P^ in [WideChar(#0), WideChar(#10), WideChar(#13)]) do
          Inc(P);
        SetString(S, Start, P - Start);
        Add(S);
        if P^ = #13 then
          Inc(P);
        if P^ = #10 then
          Inc(P)
      end
end;

procedure TWStringList.SetValue(const Name, Value: WideString);
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if Value <> '' then
  begin
    if I < 0 then
      I := Add('');
    Put(I, Name + '=' + Value)
  end
  else
    if I >= 0 then
      Delete(I)
end;

destructor TWStringList.Destroy;
begin
  inherited Destroy;
  if FCount <> 0 then
    Finalize(FList^[0], FCount);
  FCount := 0;
  SetCapacity(0)
end;

function TWStringList.Add(const S: WideString): Integer;
begin
  Result := FCount;
  InsertItem(Result, S)
end;

procedure TWStringList.Clear;
begin
  if FCount <> 0 then
  begin
    Finalize(FList^[0], FCount);
    FCount := 0;
    SetCapacity(0);
  end
end;

procedure TWStringList.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  Finalize(FList^[Index]);
  Dec(FCount);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index],
      (FCount - Index) * SizeOf(TWStringItem));
end;


function TWStringList.Find(const S: WideString; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := false;
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := WideCompareStr(FList^[I].FString, S);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := true;
        if Duplicates <> dupAccept then
          L := I
      end
    end
  end;
  Index := L
end;

function TWStringList.Get(Index: Integer): WideString;
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  Result := FList^[Index].FString
end;

function TWStringList.GetCapacity: Integer;
begin
  Result := FCapacity
end;

function TWStringList.GetCount: Integer;
begin
  Result := FCount
end;

procedure TWStringList.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else
  if FCapacity > 8 then
    Delta := 16
  else
    Delta := 4;
  SetCapacity(FCapacity + Delta)
end;

procedure TWStringList.Insert(Index: Integer; const S: WideString);
begin
  if (Index < 0) or (Index > FCount) then
    Error(SListIndexError, Index);
  InsertItem(Index, S)
end;

procedure TWStringList.InsertItem(Index: Integer; const S: WideString);
begin
  if FCount = FCapacity then
    Grow;
  if Index < FCount then
    System.Move(FList^[Index], FList^[Index + 1],
      (FCount - Index) * SizeOf(TWStringItem));
  with FList^[Index] do
  begin
    Pointer(FString) := nil;
    FString := S
  end;
  Inc(FCount);
end;

procedure TWStringList.Put(Index: Integer; const S: WideString);
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  FList^[Index].FString := S;
end;

procedure TWStringList.SetCapacity(NewCapacity: Integer);
begin
  ReallocMem(FList, NewCapacity * SizeOf(TWStringItem));
  FCapacity := NewCapacity
end;

end.
