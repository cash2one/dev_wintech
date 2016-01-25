unit BaseWinHook;

interface

uses
  Types, Windows, Messages;
  
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

  PWinHook            = ^TWinHook;
  TWinHook            = record
    HookHandle        : HHOOK;
    HookThreadId      : DWORD;
  end;
  
  procedure HookRecordInitialize(AHookRecord: PHookRecord; IsTrap:boolean; OldFun, NewFun: pointer);
  procedure HookRecordChange(AHookRecord: PHookRecord);
  procedure HookRecordRestore(AHookRecord: PHookRecord);

  procedure OpenWinHook(AWinHook: PWinHook);
  procedure CloseWinHook(AWinHook: PWinHook);

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

var
  WinHook_Keyboard: TWinHook;
  WinHook_Mouse: TWinHook;
  WinHook_CallWndProc: TWinHook;
  WinHook_Shell: TWinHook;
    
function HookProc_Keyboard(ACode: integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if (wParam = 65) then
  begin
    //Beep; {每拦截到字母 A 会发声}
  end;
  Result := CallNextHookEx(WinHook_Keyboard.HookHandle, ACode, wParam, lParam);   
end;

{钩子函数, 鼠标消息太多(譬如鼠标移动), 必须要有选择, 这里选择了鼠标左键按下}   
function HookProc_Mouse(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if wParam = WM_LBUTTONDOWN then
  begin
    MessageBeep(0);
  end;
  Result := CallNextHookEx(WinHook_Mouse.HookHandle, nCode, wParam, lParam);
end;
            
function HookProc_CALLWNDPROC(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if(nCode < 0) then
  begin
    Result := CallNextHookEx(WinHook_CallWndProc.HookHandle, nCode, wParam, lParam);
    exit;
  end;
  if nCode <> HC_ACTION then
  begin
    Result := CallNextHookEx(WinHook_CallWndProc.HookHandle, nCode, wParam, lParam);
    exit;
  end;
  Result := CallNextHookEx(WinHook_CallWndProc.HookHandle, nCode, wParam, lParam);
end;

function HookProc_Shell(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  // HSHELL_ACCESSIBILITYSTATE
  // HSHELL_ACTIVATESHELLWINDOW
  // HSHELL_GETMINRECT
  // HSHELL_LANGUAGE
  // HSHELL_REDRAW
  // HSHELL_TASKMAN
  // HSHELL_WINDOWACTIVATED
  // HSHELL_WINDOWCREATED
  // HSHELL_WINDOWDESTROYED
  // HSHELL_ACCESSIBILITYSTATE
  if HSHELL_GETMINRECT = nCode then
  begin
  end;
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;

function HookProc_SYSMSGFILTER(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if MSGF_DIALOGBOX = nCode then
  begin
    // MSGF_MENU
    // MSGF_SCROLLBAR
    // MSGF_NEXTWINDOW  
  end;
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;

function HookProc_CBT(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
{
    1激活，建立，销毁，最小化，最大化，移动，改变尺寸等窗口事件；
　　2完成系统指令；
　  3来自系统消息队列中的移动鼠标，键盘事件；
　　4设置输入焦点事件；
　　5同步系统消息队列事件
}
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;

function HookProc_JournalRecord(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;

function HookProc_JournalPlayBack(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;

function HookProc_GetMessage(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;

function HookProc_Hardware(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;

function HookProc_Debug(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;

function HookProc_ForegroundIdle(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
{
  当应用程序的前台线程处于空闲状态时
  可以使用WH_FOREGROUNDIDLEHook执行低优先级的任务
  当应用程序的前台线程大概要变成空闲状态时
  系统就会调用WH_FOREGROUNDIDLE Hook子程
}
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;

function HookProc_CallWndProcRet(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := CallNextHookEx(WinHook_Shell.HookHandle, nCode, wParam, lParam);
end;
(*
  我们在动态链接库中挂上WH_GETMESSAGE
  消息钩子，当其他的进程发出WH_GETMESSAGE 消息时，就
  会加载我们的动态链接库，如果在我们的DLL 加载时自动运
  行API_Hook，不就可以让其他的进程挂上我们的API Hook吗
*)

// 不要在Hook里写MessageBox等函数，否则会循环的！！退出都来不及

procedure OpenWinHook(AWinHook: PWinHook);
begin
  AWinHook.HookHandle := Windows.SetWindowsHookEx(
      WH_MOUSE,
        // WH_JOURNALRECORD
        // WH_JOURNALPLAYBACK
        // WH_KEYBOARD        键盘钩子
        // WH_GETMESSAGE
        // WH_CALLWNDPROC
        // WH_CBT             线程或系统
        // WH_SYSMSGFILTER
        // WH_MOUSE
        // WH_HARDWARE
        // WH_DEBUG
        // WH_SHELL
        // WH_FOREGROUNDIDLE
        // WH_CALLWNDPROCRET
      nil, // HOOKPROC
      HInstance,
      AWinHook.HookThreadId  // 可以专门针对某一线程 hook
      // GetCurrentThreadId
  );
end;

procedure CloseWinHook(AWinHook: PWinHook);
begin
  if UnhookWindowsHookEx(AWinHook.HookHandle) then
  begin
    AWinHook.HookHandle := 0;
  end;
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
procedure HookRecordInitialize(AHookRecord: PHookRecord; IsTrap:boolean; OldFun, NewFun: pointer);
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
   HookRecordChange(AHookRecord); {开始HOOK}
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

procedure HookRecordChange(AHookRecord: PHookRecord);
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
procedure HookRecordRestore(AHookRecord: PHookRecord);
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
  HookRecordRestore(@HookLibCore.Hooks[ProcID_BeginPaint]);
  result:=TBeginPaint(HookLibCore.Hooks[ProcID_BeginPaint].OldFunction)(AWnd, APaint);
//  if AWnd = HookLibCore.ShareMem.ShareMemData^.hHookWnd then{如果是当前鼠标的窗口句柄}
//  begin
//    HookLibCore.ShareMem.ShareMemData^.DCMouse := result;{记录它的返回值}
//  end else
//  begin
//    HookLibCore.ShareMem.ShareMemData^.DCMouse:=0;
//  end;
  HookRecordChange(@HookLibCore.Hooks[ProcID_BeginPaint]);
end;

procedure TestHook(ATrapMode: Integer);
begin
  HookRecordInitialize(@HookLibCore.Hooks[ProcID_BeginPaint], 1 = ATrapMode, @Windows.BeginPaint, @NewBeginPaint);
end;

end.
