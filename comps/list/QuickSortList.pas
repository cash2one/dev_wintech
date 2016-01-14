{*************************************************************
www:          http://sourceforge.net/projects/alcinoe/              
svn:          svn checkout svn://svn.code.sf.net/p/alcinoe/code/ alcinoe-code
Author(s):    Stéphane Vander Clock (alcinoe@arkadia.com)
Sponsor(s):   Arkadia SA (http://www.arkadia.com)
							
product:      ALQuickSortList
Version:      4.00

Description:  TALIntegerList or TALDoubleList that work exactly
              like TstringList but with integer or Double.

Legal issues: Copyright (C) 1999-2013 by Arkadia Software Engineering

              This software is provided 'as-is', without any express
              or implied warranty.  In no event will the author be
              held liable for any  damages arising from the use of
              this software.

              Permission is granted to anyone to use this software
              for any purpose, including commercial applications,
              and to alter it and redistribute it freely, subject
              to the following restrictions:

              1. The origin of this software must not be
                 misrepresented, you must not claim that you wrote
                 the original software. If you use this software in
                 a product, an acknowledgment in the product
                 documentation would be appreciated but is not
                 required.

              2. Altered source versions must be plainly marked as
                 such, and must not be misrepresented as being the
                 original software.

              3. This notice may not be removed or altered from any
                 source distribution.

              4. You must register this software by sending a picture
                 postcard to the author. Use a nice stamp and mention
                 your name, street address, EMail address and any
                 comment you like to say.

Know bug :

History :     16/06/2012: Add xe2 Support

Link :

* Please send all your feedback to alcinoe@arkadia.com
* If you have downloaded this source from a website different from
  sourceforge.net, please get the last version on http://sourceforge.net/projects/alcinoe/
* Please, help us to keep the development of these components free by
  promoting the sponsor on http://static.arkadia.com/html/alcinoe_like.html
**************************************************************}
unit QuickSortList;

interface

uses
  Sysutils;

{$if CompilerVersion<=18.5}
//http://stackoverflow.com/questions/7630781/delphi-2007-and-xe2-using-nativeint
type
  NativeInt = Integer;
  NativeUInt = Cardinal;
{$ifend}     

Type      
  TDuplicates = (lstDupIgnore, lstDupAccept, lstDupError);   
  TListNotification = (lstAdded, lstExtracted, lstDeleted);
               
  EListError = class(Exception);
  
  TALQuickSortListCompare = function(List: TObject; Index1, Index2: Integer): Integer;
  TALQuickSortPointerList = array of Pointer;
  TALBaseQuickSortList = class(TObject)
  public
    FList: TALQuickSortPointerList;
    FCount: Integer;
    FCapacity: Integer;
    FSorted: Boolean;
    FDuplicates: TDuplicates;
    procedure SetSorted(Value: Boolean);
    procedure QuickSort(L, R: Integer; SCompare: TALQuickSortListCompare);
  public
    function  Get(Index: Integer): Pointer;
    procedure Grow;
    procedure Put(Index: Integer; Item: Pointer);
    procedure Notify(Ptr: Pointer; Action: TListNotification); virtual;
    procedure SetCapacity(NewCapacity: Integer);
    procedure SetCount(NewCount: Integer);
    function  CompareItems(const Index1, Index2: Integer): Integer; virtual;
    procedure ExchangeItems(Index1, Index2: Integer);
    procedure InsertItem(Index: Integer; Item: Pointer);
    procedure Insert(Index: Integer; Item: Pointer);
    property  List: TALQuickSortPointerList read FList;
  public
    Constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    procedure Delete(Index: Integer);
    class procedure Error(const Msg: string; Data: NativeInt); overload; virtual;
    class procedure Error(Msg: PResStringRec; Data: NativeInt); overload;
    procedure Exchange(Index1, Index2: Integer);
    function  Expand: TALBaseQuickSortList;
    procedure CustomSort(Compare: TALQuickSortListCompare); virtual;
    procedure Sort; virtual;
    property  Sorted: Boolean read FSorted write SetSorted;
    property  Capacity: Integer read FCapacity write SetCapacity;
    property  Count: Integer read FCount write SetCount;
    property  Duplicates: TDuplicates read FDuplicates write FDuplicates;
  end;

resourcestring
  SALDuplicateItem = 'List does not allow duplicates';
  SALListCapacityError = 'List capacity out of bounds (%d)';
  SALListCountError = 'List count out of bounds (%d)';
  SALListIndexError = 'List index out of bounds (%d)';
  SALSortedListError = 'Operation not allowed on sorted list';

implementation
////
//uses
//  AlFcnString;
procedure ALMove(const Source; var Dest; Count: {$if CompilerVersion >= 23}{Delphi XE2}NativeInt{$ELSE}Integer{$IFEND});
begin
  System.Move(Source, Dest, Count);
end;

{***********************************************************************************}
function AlBaseQuickSortListCompare(List: TObject; Index1, Index2: Integer): Integer;
Begin
  result := TALBaseQuickSortList(List).CompareItems(Index1, Index2);
end;

{**************************************}
constructor TALBaseQuickSortList.Create;
begin
  SetLength(FList,0);
  FCount:= 0;
  FCapacity:= 0;
  FSorted := False;
  FDuplicates := lstDupIgnore;
end;

{**************************************}
destructor TALBaseQuickSortList.Destroy;
begin
  Clear;
end;

{***********************************}
procedure TALBaseQuickSortList.Clear;
begin
  SetCount(0);
  SetCapacity(0);
end;

{***********************************************************************}
procedure TALBaseQuickSortList.InsertItem(Index: Integer; Item: Pointer);
begin
  if FCount = FCapacity then
    Grow;
  if Index < FCount then
    ALMove(FList[Index], FList[Index + 1],
      (FCount - Index) * SizeOf(Pointer));
  FList[Index] := Item;
  Inc(FCount);
  if (Item <> nil) then
    Notify(Item, lstAdded);
end;

{********************************************************************}
procedure TALBaseQuickSortList.ExchangeItems(Index1, Index2: Integer);
var
  Item: Pointer;
begin
  Item := FList[Index1];
  FList[Index1] := FList[Index2];
  FList[Index2] := Item;
end;

{****************************************************}
procedure TALBaseQuickSortList.Delete(Index: Integer);
var
  Temp: Pointer;
begin
  if (Index < 0) or (Index >= FCount) then
    Error(@SALListIndexError, Index);
  Temp := FList[Index];
  Dec(FCount);
  if Index < FCount then
    ALMove(FList[Index + 1], FList[Index],
      (FCount - Index) * SizeOf(Pointer));
  if (Temp <> nil) then
    Notify(Temp, lstDeleted);
end;

{*****************************************************************************}
class procedure TALBaseQuickSortList.Error(const Msg: string; Data: NativeInt);
begin
  raise EListError.CreateFmt(Msg, [Data]);
end;

{******************************************************************************}
class procedure TALBaseQuickSortList.Error(Msg: PResStringRec; Data: NativeInt);
begin
  raise EListError.CreateFmt(LoadResString(Msg), [Data]);
end;

{***************************************************************}
procedure TALBaseQuickSortList.Exchange(Index1, Index2: Integer);
begin
  {Warning:	Do not call Exchange on a sorted list except to swap two identical
   items with different associated objects. Exchange does not check whether
   the list is sorted, and can destroy the sort order of a sorted list.}
  if (Index1 < 0) or (Index1 >= FCount) then
    Error(@SALListIndexError, Index1);
  if (Index2 < 0) or (Index2 >= FCount) then
    Error(@SALListIndexError, Index2);
  ExchangeItems(Index1, Index2);
end;

{*******************************************************************}
procedure TALBaseQuickSortList.Insert(Index: Integer; Item: Pointer);
begin
  if Sorted then Error(@SALSortedListError, 0);
  if (Index < 0) or (Index > FCount) then
    Error(@SALListIndexError, Index);
  InsertItem(Index, Item);
end;

{****************************************************************}
procedure TALBaseQuickSortList.Put(Index: Integer; Item: Pointer);
var
  Temp: Pointer;
begin
  if Sorted then
    Error(@SALSortedListError, 0);
  if (Index < 0) or (Index >= FCount) then
    Error(@SALListIndexError, Index);
  if Item <> FList[Index] then
  begin
    Temp := FList[Index];
    FList[Index] := Item;
    if Temp <> nil then
      Notify(Temp, lstDeleted);
    if Item <> nil then
      Notify(Item, lstAdded);
  end;
end;

{*********************************************************}
function TALBaseQuickSortList.Get(Index: Integer): Pointer;
begin
  if Cardinal(Index) >= Cardinal(FCount) then
    Error(@SALListIndexError, Index);
  Result := FList[Index];
end;

{*********************************************************}
function TALBaseQuickSortList.Expand: TALBaseQuickSortList;
begin
  if FCount = FCapacity then
    Grow;
  Result := Self;
end;

{**********************************}
procedure TALBaseQuickSortList.Grow;
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
  SetCapacity(FCapacity + Delta);
end;

{***************************************************************}
procedure TALBaseQuickSortList.SetCapacity(NewCapacity: Integer);
begin
  if NewCapacity < FCount then
  begin
    exit;
    //Error(@SALListCapacityError, NewCapacity);
  end;
  if NewCapacity <> FCapacity then
  begin
    SetLength(FList, NewCapacity);
    FCapacity := NewCapacity;
  end;
end;

{*********************************************************}
procedure TALBaseQuickSortList.SetCount(NewCount: Integer);
var
  I: Integer;
  Temp: Pointer;
begin
  if NewCount < 0 then
    Error(@SALListCountError, NewCount);
  if NewCount <> FCount then
  begin
    if NewCount > FCapacity then
      SetCapacity(NewCount);
    if NewCount > FCount then
      FillChar(FList[FCount], (NewCount - FCount) * SizeOf(Pointer), 0)
    else
    for I := FCount - 1 downto NewCount do
    begin
      Dec(FCount);
      Temp := List[I];
      if Temp <> nil then
        Notify(Temp, lstDeleted);
    end;
    FCount := NewCount;
  end;
end;

{*****************************************************************************}
procedure TALBaseQuickSortList.Notify(Ptr: Pointer; Action: TListNotification);
begin
end;

{*******************************************************}
procedure TALBaseQuickSortList.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    if Value then Sort;
    FSorted := Value;
  end;
end;

{*****************************************************************************************}
procedure TALBaseQuickSortList.QuickSort(L, R: Integer; SCompare: TALQuickSortListCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        if I <> J then
          ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;

{**************************************************************************}
procedure TALBaseQuickSortList.CustomSort(Compare: TALQuickSortListCompare);
begin
  if not Sorted and (FCount > 1) then
    QuickSort(0, FCount - 1, Compare);
end;

{**********************************}
procedure TALBaseQuickSortList.Sort;
begin
  CustomSort(AlBaseQuickSortListCompare);
end;

{*********************************************************************************}
function TALBaseQuickSortList.CompareItems(const Index1, Index2: Integer): Integer;
begin
  Result := 0;
end;

end.