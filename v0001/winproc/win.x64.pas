unit win.x64;

interface
                   
  function DisableWowRedirection: Boolean;     
  function RevertWowRedirection: Boolean;

implementation

uses
  Windows;

function IsWin64: boolean;
var 
  Kernel32Handle: THandle;   
  IsWow64Process: function(Handle: Windows.THandle; var Res: Windows.BOOL): Windows.BOOL; stdcall;   
  GetNativeSystemInfo: procedure(var lpSystemInfo: TSystemInfo); stdcall;   
  isWoW64: Bool;   
  SystemInfo: TSystemInfo;   
const 
  PROCESSOR_ARCHITECTURE_AMD64 = 9;   
  PROCESSOR_ARCHITECTURE_IA64 = 6;
begin 
  Result := False;
  Kernel32Handle := GetModuleHandle('KERNEL32.DLL');
  if Kernel32Handle = 0 then
    Kernel32Handle := LoadLibrary('KERNEL32.DLL');
  if Kernel32Handle <> 0 then
  begin
    IsWOW64Process := GetProcAddress(Kernel32Handle,'IsWow64Process');
    //GetNativeSystemInfo函数从Windows XP开始才有，而IsWow64Process函数从Windows XP SP2以及Windows Server 2003 SP1开始才有。
    //所以使用该函数前最好用GetProcAddress。
    GetNativeSystemInfo := GetProcAddress(Kernel32Handle,'GetNativeSystemInfo');
    if Assigned(IsWow64Process) then
    begin
      IsWow64Process(GetCurrentProcess, isWoW64);
      Result := isWoW64 and Assigned(GetNativeSystemInfo);
      if Result then
      begin
        GetNativeSystemInfo(SystemInfo);
        Result := (SystemInfo.wProcessorArchitecture = PROCESSOR_ARCHITECTURE_AMD64) or
                  (SystemInfo.wProcessorArchitecture = PROCESSOR_ARCHITECTURE_IA64);
      end;
    end;
  end;
end;  
(*//
在64位Windows系统中运行的32位程序会被系统欺骗.
例如windows\system32的目录实际是windows\syswow64目录的映射.
program files实际是program files(x86)的映射.

注册表的hkey_local_machine\software实际是hkey_local_machine\software\wow6432node子键的映射.
那么如何访问到真正的64位程序的目录和注册表呢?

关掉目录重定向即可.
关闭文件的重定向
//*)
function DisableWowRedirection: Boolean;
type
  TWow64DisableWow64FsRedirection = function(var Wow64FsEnableRedirection: LongBool): LongBool; stdcall;
var
  tmpHandle: THandle;
  Wow64DisableWow64FsRedirection: TWow64DisableWow64FsRedirection;
  OldWow64RedirectionValue: LongBool;
begin
  Result := true;
  try
    tmpHandle := GetModuleHandle('kernel32.dll');
    if (0 <> tmpHandle) then
    begin
      @Wow64DisableWow64FsRedirection := GetProcAddress(tmpHandle, 'Wow64DisableWow64FsRedirection');
      if (nil <> @Wow64DisableWow64FsRedirection) then
      begin
        Wow64DisableWow64FsRedirection(OldWow64RedirectionValue);
      end;
    end;
  except
    Result := False;
  end;
 end;
 
function RevertWowRedirection: Boolean;
type
  TWow64RevertWow64FsRedirection = function(var Wow64RevertWow64FsRedirection: LongBool): LongBool; stdcall;
var
  tmpHandle: THandle;
  Wow64RevertWow64FsRedirection: TWow64RevertWow64FsRedirection;  
  OldWow64RedirectionValue: LongBool;
begin
  Result := true;
  try
    tmpHandle := GetModuleHandle('kernel32.dll');
    @Wow64RevertWow64FsRedirection := GetProcAddress(tmpHandle, 'Wow64RevertWow64FsRedirection');
    if (0 <> tmpHandle) then
    begin
      if (nil <> @Wow64RevertWow64FsRedirection) then
      begin              
        Wow64RevertWow64FsRedirection(OldWow64RedirectionValue);
      end;
    end;
  except
    Result := False;
  end;
end;

(*//
注册表就很简单了.
var
  r: TRegistry;
begin
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.Access := r.Access or KEY_WOW64_64KEY; //注意这一行.
  if r.OpenKey('SOFTWARE\abc', true) then
  begin
    r.WriteString('test', 'test');
  end;
  r.Free;
end;
//*)

end.
