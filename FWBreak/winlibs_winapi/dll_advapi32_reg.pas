unit dll_advapi32_reg;

interface 
                 
uses
  atmcmbaseconst, winconst, wintype;
  
  function RegOverridePredefKey (hKey, hNewHKey: HKEY): Longint; stdcall; external advapi32 name 'RegOverridePredefKey';
  function RegOpenUserClassesRoot(hToken: THandle; dwOptions: DWORD;
    samDesired: REGSAM; out phkResult: HKEY): Longint; stdcall; external advapi32 name 'RegOpenUserClassesRoot';
  function RegOpenCurrentUser(samDesired: REGSAM; out phkResult: HKEY): Longint; stdcall; external advapi32 name 'RegOpenCurrentUser';
  function RegDisablePredefinedCache: Longint; stdcall; external advapi32 name 'RegDisablePredefinedCache';
  function RegCloseKey(hKey: HKEY): Longint; stdcall; external advapi32 name 'RegCloseKey';
  function RegConnectRegistryA(lpMachineName: PAnsiChar; hKey: HKEY; var phkResult: HKEY): Longint; stdcall; external advapi32 name 'RegConnectRegistryA';
  function RegCreateKeyA(hKey: HKEY; lpSubKey: PAnsiChar; var phkResult: HKEY): Longint; stdcall; external advapi32 name 'RegCreateKeyA';
  function RegCreateKeyExA(hKey: HKEY; lpSubKey: PAnsiChar;
    Reserved: DWORD; lpClass: PAnsiChar; dwOptions: DWORD; samDesired: REGSAM;
    lpSecurityAttributes: PSecurityAttributes; var phkResult: HKEY;
    lpdwDisposition: PDWORD): Longint; stdcall; external advapi32 name 'RegCreateKeyExA';
  function RegDeleteKeyA(hKey: HKEY; lpSubKey: PAnsiChar): Longint; stdcall; external advapi32 name 'RegDeleteKeyA';
  function RegDeleteValueA(hKey: HKEY; lpValueName: PAnsiChar): Longint; stdcall; external advapi32 name 'RegDeleteValueA';
  function RegEnumKeyExA(hKey: HKEY; dwIndex: DWORD; lpName: PAnsiChar;
    var lpcbName: DWORD; lpReserved: Pointer; lpClass: PAnsiChar;
    lpcbClass: PDWORD; lpftLastWriteTime: PFileTime): Longint; stdcall; external advapi32 name 'RegEnumKeyExA';
  function RegEnumKeyA(hKey: HKEY; dwIndex: DWORD; lpName: PAnsiChar; cbName: DWORD): Longint; stdcall; external advapi32 name 'RegEnumKeyA';
  function RegEnumValueA(hKey: HKEY; dwIndex: DWORD; lpValueName: PAnsiChar;
    var lpcbValueName: DWORD; lpReserved: Pointer; lpType: PDWORD;
    lpData: PByte; lpcbData: PDWORD): Longint; stdcall; external advapi32 name 'RegEnumValueA';
  function RegFlushKey(hKey: HKEY): Longint; stdcall; external advapi32 name 'RegFlushKey';
  function RegGetKeySecurity(hKey: HKEY; SecurityInformation: SECURITY_INFORMATION;
    pSecurityDescriptor: PSecurityDescriptor; var lpcbSecurityDescriptor: DWORD): Longint; stdcall; external advapi32 name 'RegGetKeySecurity';
  function RegLoadKeyA(hKey: HKEY; lpSubKey, lpFile: PAnsiChar): Longint; stdcall; external advapi32 name 'RegLoadKeyA';
  function RegNotifyChangeKeyValue(hKey: HKEY; bWatchSubtree: BOOL;
    dwNotifyFilter: DWORD; hEvent: THandle; fAsynchronus: BOOL): Longint; stdcall; external advapi32 name 'RegNotifyChangeKeyValue';
  function RegOpenKeyA(hKey: HKEY; lpSubKey: PAnsiChar; var phkResult: HKEY): Longint; stdcall; external advapi32 name 'RegOpenKeyA';
  function RegOpenKeyExA(hKey: HKEY; lpSubKey: PAnsiChar;
    ulOptions: DWORD; samDesired: REGSAM; var phkResult: HKEY): Longint; stdcall; external advapi32 name 'RegOpenKeyExA';
  function RegQueryInfoKeyA(hKey: HKEY; lpClass: PAnsiChar;
    lpcbClass: PDWORD; lpReserved: Pointer;
    lpcSubKeys, lpcbMaxSubKeyLen, lpcbMaxClassLen, lpcValues,
    lpcbMaxValueNameLen, lpcbMaxValueLen, lpcbSecurityDescriptor: PDWORD;
    lpftLastWriteTime: PFileTime): Longint; stdcall; external advapi32 name 'RegQueryInfoKeyA';
  function RegQueryMultipleValuesA(hKey: HKEY; var ValList;
    NumVals: DWORD; lpValueBuf: PAnsiChar; var ldwTotsize: DWORD): Longint; stdcall; external advapi32 name 'RegQueryMultipleValuesA';
  function RegQueryValueA(hKey: HKEY; lpSubKey: PAnsiChar;
    lpValue: PAnsiChar; var lpcbValue: Longint): Longint; stdcall; external advapi32 name 'RegQueryValueA';
  function RegQueryValueExA(hKey: HKEY; lpValueName: PAnsiChar;
    lpReserved: Pointer; lpType: PDWORD; lpData: PByte; lpcbData: PDWORD): Longint; stdcall; external advapi32 name 'RegQueryValueExA';
  function RegReplaceKeyA(hKey: HKEY; lpSubKey: PAnsiChar;
   lpNewFile: PAnsiChar; lpOldFile: PAnsiChar): Longint; stdcall; external advapi32 name 'RegReplaceKeyA';
  function RegRestoreKeyA(hKey: HKEY; lpFile: PAnsiChar; dwFlags: DWORD): Longint; stdcall; external advapi32 name 'RegRestoreKeyA';
  function RegSaveKeyA(hKey: HKEY; lpFile: PAnsiChar;
    lpSecurityAttributes: PSecurityAttributes): Longint; stdcall; external advapi32 name 'RegSaveKeyA';
  function RegSetKeySecurity(hKey: HKEY; SecurityInformation: SECURITY_INFORMATION;
    pSecurityDescriptor: PSECURITY_DESCRIPTOR): Longint; stdcall; external advapi32 name 'RegSetKeySecurity';
  function RegSetValueA(hKey: HKEY; lpSubKey: PAnsiChar;
    dwType: DWORD; lpData: PAnsiChar; cbData: DWORD): Longint; stdcall; external advapi32 name 'RegSetValueA';
  function RegSetValueExA(hKey: HKEY; lpValueName: PAnsiChar;
    Reserved: DWORD; dwType: DWORD; lpData: Pointer; cbData: DWORD): Longint; stdcall; external advapi32 name 'RegSetValueExA';
  function RegUnLoadKeyA(hKey: HKEY; lpSubKey: PAnsiChar): Longint; stdcall; external advapi32 name 'RegUnLoadKeyA';

implementation

end.
