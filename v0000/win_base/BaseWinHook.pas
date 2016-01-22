unit BaseWinHook;

interface

uses
  Types, Windows;
  
type             
  PImportCode         = ^TImportCode;
  TImportCode         = packed record
    JumpInstruction   : Word;
    AddressOfPointerToFunction: PPointer;
  end;

  PImage_Import_Entry = ^TImage_Import_Entry;
  TImage_Import_Entry = record
    Characteristics   : DWORD;
    TimeDateStamp     : DWORD;
    MajorVersion      : Word;
    MinorVersion      : Word;
    Name              : DWORD;
    LookupTable       : DWORD;
  end;
  
  TLongJmp            = packed record
    JmpCode           : ShortInt; {指令，用$E9来代替系统的指令}
    FuncAddr          : DWORD; {函数地址}
  end;

  PHookRecord         = ^THookRecord;
  THookRecord         = record
    ProcessHandle     : Cardinal; {进程句柄，只用于陷阱式}
    Oldcode           : array[0..4]of byte; {系统函数原来的前5个字节}
    OldFunction       : Pointer;
    NewFunction       : Pointer;{被截函数、自定义函数}

    TrapMode          : Byte; {调用方式：True陷阱式，False改引入表式}
    AlreadyHook       : boolean; {是否已安装Hook，只用于陷阱式}
    AllowChange       : boolean; {是否允许安装、卸载Hook，只用于改引入表式}
    Newcode           : TLongJmp; {将要写在系统函数的前5个字节}
  end;
                  
  procedure HookChange(AHookRecord: PHookRecord);  
  procedure HookRestore(AHookRecord: PHookRecord);

implementation
               
const
  ProcID_BeginPaint   = 0;

type
  THookCore           = record
    MouseHook         : THandle;
    //ShareMem    : THookShareMem;
    StartHookProcessID: DWORD;
    Hooks             : array[ProcID_BeginPaint..ProcID_BeginPaint] of THookRecord;{API HOOK类}
  end;

{取函数的实际地址。如果函数的第一个指令是Jmp，则取出它的跳转地址（实际地址），这往往是由于程序中含有Debug调试信息引起的}
function FinalFunctionAddress(Code: Pointer): Pointer;
Var
  func: PImportCode;
begin
  Result:=Code;
  if Code=nil then exit;
  try
    func:=code;
    if (func.JumpInstruction=$25FF) then
      {指令二进制码FF 25  汇编指令jmp [...]}
      Func:=func.AddressOfPointerToFunction^;
    result:=Func;
  except
    Result:=nil;
  end;
end;
          
var
  HookLibCore: THookCore;

{HOOK的入口，其中IsTrap表示是否采用陷阱式}
procedure HookInitialize(AHookRecord: PHookRecord; IsTrap:boolean; OldFun, NewFun: pointer);
begin
   {求被截函数、自定义函数的实际地址}
   AHookRecord.OldFunction := FinalFunctionAddress(OldFun);
   AHookRecord.NewFunction := FinalFunctionAddress(NewFun);

   if IsTrap then
     AHookRecord.TrapMode := 1
   else
     AHookRecord.TrapMode := 2;

   if 1 = AHookRecord.TrapMode then{如果是陷阱式}
   begin
      {以特权的方式来打开当前进程}
      AHookRecord.ProcessHandle := OpenProcess(PROCESS_ALL_ACCESS,FALSE, GetCurrentProcessID);
      {生成jmp xxxx的代码，共5字节}
      AHookRecord.Newcode.JmpCode := ShortInt($E9); {jmp指令的十六进制代码是E9}
      AHookRecord.NewCode.FuncAddr := DWORD(AHookRecord.NewFunction) - DWORD(AHookRecord.OldFunction) - 5;
      {保存被截函数的前5个字节}
      move(AHookRecord.OldFunction^, AHookRecord.OldCode, 5);
      {设置为还没有开始HOOK}
      AHookRecord.AlreadyHook:=false;
   end;
   {如果是改引入表式，将允许HOOK}
   if 2 = AHookRecord.TrapMode then
   begin
     AHookRecord.AllowChange := true;
   end;
   HookChange(AHookRecord); {开始HOOK}
   {如果是改引入表式，将暂时不允许HOOK}
   if 2 = AHookRecord.TrapMode then
     AHookRecord.AllowChange := false;
end;

{开始HOOK}         
type
  PPatchedAddress = ^TPatchedAddress;
  TPatchedAddress = record
    Count: integer;
    Address: array[0..1024 - 1] of Pointer;
  end;

{更改引入表中指定函数的地址，只用于改引入表式}
function PatchAddressInModule(BeenDone: PPatchedAddress; hModule: THandle; OldFunc,NewFunc: Pointer):integer;
const
  tmpSIZE = 4;
var
  tmpDos: PImageDosHeader;
  tmpNT: PImageNTHeaders;
  tmpImportDesc: PImage_Import_Entry;
  tmprva: DWORD;
  tmpFunc: PPointer;
  tmpDLL: String;
  tmpf: Pointer;
  tmpwritten: DWORD;
  tmpmbi_thunk:TMemoryBasicInformation;
  tmpdwOldProtect:DWORD;
  i: Integer;
begin
  Result:=0;
  if hModule=0 then
    exit;
  tmpDos := Pointer(hModule);
  {如果这个DLL模块已经处理过，则退出。BeenDone包含已处理的DLL模块}
  for i := 0 to BeenDone.Count - 1 do
  begin
    if BeenDone.Address[i] = tmpDos then
    begin
      exit;
    end;
  end;
  BeenDone.Address[BeenDone.Count] := tmpDos; {把DLL模块名加入BeenDone}
  BeenDone.Count := BeenDone.Count + 1;
  
  OldFunc:=FinalFunctionAddress(OldFunc);{取函数的实际地址}

  {如果这个DLL模块的地址不能访问，则退出}
  if IsBadReadPtr(tmpDos, SizeOf(TImageDosHeader)) then
    exit;
  {如果这个模块不是以'MZ'开头，表明不是DLL，则退出}
  if tmpDos.e_magic<>IMAGE_DOS_SIGNATURE then
    exit;{IMAGE_DOS_SIGNATURE='MZ'}

  {定位至NT Header}
  tmpNT := Pointer(Integer(tmpDos) + tmpdos._lfanew);
  {定位至引入函数表}
  tmpRVA := tmpNT^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;

  if 0 = tmpRVA then
    exit;{如果引入函数表为空，则退出}
  {把函数引入表的相对地址RVA转换为绝对地址}
  tmpImportDesc := pointer(DWORD(tmpDos) + tmpRVA);{Dos是此DLL模块的首地址}

  {遍历所有被引入的下级DLL模块}
  while (tmpImportDesc^.Name<>0) do
  begin
    {被引入的下级DLL模块名字}
    tmpDLL:=PChar(DWORD(tmpDos) + tmpImportDesc^.Name);
    {把被导入的下级DLL模块当做当前模块，进行递归调用}
    PatchAddressInModule(BeenDone, GetModuleHandle(PChar(tmpDLL)),OldFunc,NewFunc);

    {定位至被引入的下级DLL模块的函数表}
    tmpFunc := Pointer(DWORD(tmpDOS) + tmpImportDesc.LookupTable);
    {遍历被引入的下级DLL模块的所有函数}
    while tmpFunc^<>nil do
    begin
      tmpf := FinalFunctionAddress(tmpFunc^);{取实际地址}
      if tmpf = OldFunc then {如果函数实际地址就是所要找的地址}
      begin
        VirtualQuery(tmpFunc, tmpmbi_thunk, sizeof(TMemoryBasicInformation));
        VirtualProtect(tmpFunc, tmpSIZE, PAGE_EXECUTE_WRITECOPY, tmpmbi_thunk.Protect);{更改内存属性}
        WriteProcessMemory(GetCurrentProcess, tmpFunc, @NewFunc, tmpSIZE, tmpwritten);{把新函数地址覆盖它}
        VirtualProtect(tmpFunc, tmpSIZE, tmpmbi_thunk.Protect, tmpdwOldProtect);{恢复内存属性}
      end;
      if 4 = tmpWritten then
        Inc(Result);
//      else showmessagefmt('error:%d',[Written]);
      Inc(tmpFunc);{下一个功能函数}
    end;
    Inc(tmpImportDesc);{下一个被引入的下级DLL模块}
  end;
end;

procedure HookChange(AHookRecord: PHookRecord);
var
  tmpCount: DWORD;
  tmpBeenDone: TPatchedAddress;
begin
  if 1 = AHookRecord.TrapMode then{如果是陷阱式}
  begin
    if (AHookRecord.AlreadyHook) or
       (0 = AHookRecord.ProcessHandle) or
       (nil = AHookRecord.OldFunction) or
       (nil = AHookRecord.NewFunction) then
    begin
      exit;
    end;
    AHookRecord.AlreadyHook := true;{表示已经HOOK}
    WriteProcessMemory(AHookRecord.ProcessHandle, AHookRecord.OldFunction, @(AHookRecord.Newcode), 5, tmpCount);
  end else
  begin{如果是改引入表式}
    if (not AHookRecord.AllowChange)or(AHookRecord.OldFunction=nil)or(AHookRecord.NewFunction=nil)then
      exit;
    {用于存放当前进程所有DLL模块的名字}
    FillChar(tmpBeenDone, SizeOf(tmpBeenDone), 0);
    PatchAddressInModule(@tmpBeenDone,
      GetModuleHandle(nil),
      AHookRecord.OldFunction,
      AHookRecord.NewFunction);
  end;
end;

{恢复系统函数的调用}
procedure HookRestore(AHookRecord: PHookRecord);
var
   nCount: DWORD;
   BeenDone: TPatchedAddress;
begin
  if 1 = AHookRecord.TrapMode then{如果是陷阱式}
  begin
    if (not AHookRecord.AlreadyHook) or
       (0 = AHookRecord.ProcessHandle) or
       (nil = AHookRecord.OldFunction) or
       (nil = AHookRecord.NewFunction) then
        exit;
    WriteProcessMemory(AHookRecord.ProcessHandle, AHookRecord.OldFunction, @(AHookRecord.Oldcode), 5, nCount);
    AHookRecord.AlreadyHook := false;{表示退出HOOK}
  end else
  begin{如果是改引入表式}
    if (not AHookRecord.AllowChange)or(AHookRecord.OldFunction=nil)or(AHookRecord.NewFunction=nil)then
      exit;           
    {用于存放当前进程所有DLL模块的名字}
    FillChar(BeenDone, SizeOf(BeenDone), 0);
    PatchAddressInModule(@BeenDone, GetModuleHandle(nil),AHookRecord.NewFunction,AHookRecord.OldFunction);
  end;
end;

function NewBeginPaint(AWnd: HWND; var APaint: TPaintStruct): HDC; stdcall;
type
   TBeginPaint=function (Wnd: HWND; var lpPaint: TPaintStruct): HDC; stdcall;
begin
  HookRestore(@HookLibCore.Hooks[ProcID_BeginPaint]);
  result:=TBeginPaint(HookLibCore.Hooks[ProcID_BeginPaint].OldFunction)(AWnd, APaint);
//  if AWnd = HookLibCore.ShareMem.ShareMemData^.hHookWnd then{如果是当前鼠标的窗口句柄}
//  begin
//    HookLibCore.ShareMem.ShareMemData^.DCMouse := result;{记录它的返回值}
//  end else
//  begin
//    HookLibCore.ShareMem.ShareMemData^.DCMouse:=0;
//  end;
  HookChange(@HookLibCore.Hooks[ProcID_BeginPaint]);
end;

procedure TestHook(ATrapMode: Integer);
begin
  HookInitialize(@HookLibCore.Hooks[ProcID_BeginPaint], 1 = ATrapMode, @Windows.BeginPaint, @NewBeginPaint);
end;

end.
