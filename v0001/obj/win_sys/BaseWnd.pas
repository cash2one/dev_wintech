unit BaseWnd;

interface

uses
  Windows, Messages;
  
type
  TWndMethod = procedure(var Message: TMessage) of object;

  TBaseWndData = record
    WndHandle       : HWND;
    ObjectInstance  : Pointer;
  end;

  TBaseWnd = class
  protected
    FBaseWndData: TBaseWndData;
    procedure WndProc(var Message: TMessage); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure InitializeWnd(AWnd: HWND); virtual;
  end;
  
  function MakeObjectInstance(Method: TWndMethod): Pointer;
  procedure FreeObjectInstance(ObjectInstance: Pointer);

//  function AllocateHWnd(Method: TWndMethod): HWND;
//  procedure DeallocateHWnd(Wnd: HWND);

implementation
              
const
  InstanceCount = 313;

{ Object instance management }

type
  PObjectInstance = ^TObjectInstance;
  TObjectInstance = packed record
    Code: Byte;
    Offset: Integer;
    case Integer of
      0: (Next: PObjectInstance);
      1: (Method: TWndMethod);
  end;

type
  PInstanceBlock = ^TInstanceBlock;
  TInstanceBlock = packed record
    Next: PInstanceBlock;
    Code: array[1..2] of Byte;
    WndProcPtr: Pointer;
    Instances: array[0..InstanceCount] of TObjectInstance;
  end;

var
  InstBlockList: PInstanceBlock;
  InstFreeList: PObjectInstance;

{ Standard window procedure }
{ In    ECX = Address of method pointer }
{ Out   EAX = Result }

function StdWndProc(Window: HWND; Message, WParam: Longint;
  LParam: Longint): Longint; stdcall; assembler;
asm
        XOR     EAX,EAX
        PUSH    EAX
        PUSH    LParam
        PUSH    WParam
        PUSH    Message
        MOV     EDX,ESP
        MOV     EAX,[ECX].Longint[4]
        CALL    [ECX].Pointer
        ADD     ESP,12
        POP     EAX
end;

{ Allocate an object instance }

function CalcJmpOffset(Src, Dest: Pointer): Longint;
begin
  Result := Longint(Dest) - (Longint(Src) + 5);
end;

function MakeObjectInstance(Method: TWndMethod): Pointer;
const
  BlockCode: array[1..2] of Byte = (
    $59,       { POP ECX }
    $E9);      { JMP StdWndProc }
  PageSize = 4096;
var
  Block: PInstanceBlock;
  Instance: PObjectInstance;
begin
  if InstFreeList = nil then
  begin
    Block := VirtualAlloc(nil, PageSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    Block^.Next := InstBlockList;
    Move(BlockCode, Block^.Code, SizeOf(BlockCode));
    Block^.WndProcPtr := Pointer(CalcJmpOffset(@Block^.Code[2], @StdWndProc));
    Instance := @Block^.Instances;
    repeat
      Instance^.Code := $E8;  { CALL NEAR PTR Offset }
      Instance^.Offset := CalcJmpOffset(Instance, @Block^.Code);
      Instance^.Next := InstFreeList;
      InstFreeList := Instance;
      Inc(Longint(Instance), SizeOf(TObjectInstance));
    until Longint(Instance) - Longint(Block) >= SizeOf(TInstanceBlock);
    InstBlockList := Block;
  end;
  Result := InstFreeList;
  Instance := InstFreeList;
  InstFreeList := Instance^.Next;
  Instance^.Method := Method;
end;

{ Free an object instance }

procedure FreeObjectInstance(ObjectInstance: Pointer);
begin
  if ObjectInstance <> nil then
  begin
    PObjectInstance(ObjectInstance)^.Next := InstFreeList;
    InstFreeList := ObjectInstance;
  end;
end;

{ TBaseWnd }

constructor TBaseWnd.Create;
begin
  FillChar(FBaseWndData, SizeOf(FBaseWndData), 0);
end;

destructor TBaseWnd.Destroy;
begin                                
  if 0 <> FBaseWndData.WndHandle then
  begin
    if IsWindow(FBaseWndData.WndHandle) then
    begin
      if Windows.DestroyWindow(FBaseWndData.WndHandle) then
      begin
        FBaseWndData.WndHandle := 0;
      end;
    end else
    begin
      FBaseWndData.WndHandle := 0;
    end;
  end;
  if nil <> FBaseWndData.ObjectInstance then
  begin
    FreeObjectInstance(FBaseWndData.ObjectInstance);
    FBaseWndData.ObjectInstance := nil;
  end;
  inherited;
end;

procedure TBaseWnd.InitializeWnd(AWnd: HWND);
begin
  if IsWindow(AWnd) then
  begin
    if nil = FBaseWndData.ObjectInstance then
      FBaseWndData.ObjectInstance := MakeObjectInstance(WndProc);
    SetWindowLong(AWnd, GWL_WNDPROC, Longint(FBaseWndData.ObjectInstance));
  end;
end;

procedure TBaseWnd.WndProc(var Message: TMessage);
begin
end;

end.
