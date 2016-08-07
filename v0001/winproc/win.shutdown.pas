unit win.shutdown;

interface

uses
  Windows;

  procedure ShutDown();  
  procedure Reboot(); 
  procedure LoginOff();

implementation

procedure ShutDownCommand(ACommand: DWORD);
var
  tmpToken: THandle;
  tmpTokenPrivileges: TTokenPrivileges;
  tmpTokenPrivilegesNew: TTokenPrivileges;
  tmpZero: DWORD;
begin
  if not OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, tmpToken) then
    exit;
  if not LookupPrivilegeValue(nil, 'SeShutdownPrivilege', tmpTokenPrivileges.Privileges[0].Luid) then
    exit;
  tmpTokenPrivileges.PrivilegeCount := 1;
  tmpTokenPrivileges.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
  tmpZero := 0;
  AdjustTokenPrivileges(tmpToken, False, tmpTokenPrivileges, SizeOf(TTokenPrivileges), tmpTokenPrivilegesNew, tmpZero);
  if 0 <> GetLastError then
    exit;
  ExitWindowsEx(ACommand, 0);
end;
       
procedure ShutDown();
begin
  ShutDownCommand(EWX_FORCE or EWX_POWEROFF or EWX_Shutdown);  // 关机
end;
            
procedure Reboot();
begin
  ShutDownCommand(EWX_REBOOT);  // 重启
end;

procedure LoginOff();
begin
  ShutDownCommand(EWX_LOGOFF);  // 注销
end;

end.
