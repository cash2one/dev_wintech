unit dll_hotplug;

{
  安全删除 usb

  Microsoft Safely Remove Hardware applet

        1    0 00005A64 CPlApplet
        2    1 0000276C CreateLocalServerW
       12    2 00002659 DllCanUnloadNow
       13    3 0000266A DllGetClassObject
       14    4 0000268B DllRegisterServer
       15    5 0000269F DllUnregisterServer

        3    6 000056B4 HotPlugDeviceTree
        4    7 000059D1 HotPlugDriverBlockedW
        5    8 00005746 HotPlugEjectDevice
        6    9 00005B38 HotPlugEjectVetoedW
        7    A 00005B68 HotPlugHibernateVetoedW
        8    B 00005B20 HotPlugRemovalVetoedW
        9    C 0000584A HotPlugSafeRemovalNotificationW
       10    D 00005B50 HotPlugStandbyVetoedW
       11    E 00005B80 HotPlugWarmEjectVetoedW
}

interface

uses
  Windows;
             
const
  hotplug = 'hotplug.dll';

  function HotPlugDeviceTree(AParentWnd: HWND; AParam1: DWORD; AParam2: BOOL): DWORD;
    stdcall; external hotplug;

implementation

(*
\\rundll32.exe   shell32.dll,Control_RunDLL   hotplug.dll

hotplug.dll，windows   shell自己实现弹出设备以及警告对话框都在这里。 

typedef   BOOL   (WINAPI*   pfnHotPlugEjectDevice) 
(HWND   hwndParent,   PTCHAR   DeviceInstanceId); 

pfnHotPlugDeviceTree   HotPlugDeviceTree   =   NULL; 
void   main() 
{ 
HMODULE   hHotPlug   =   LoadLibrary( "HotPlug.dll "); 
if(hHotPlug   ==   NULL)   
{ 
printf( "LoadLibrary(HotPlug.dll)   Error:%d\n ",   GetLastError()); 
return; 
} 

//get   functions 
HotPlugEjectDevice   =   (pfnHotPlugEjectDevice)GetProcAddress(hHotPlug,   "HotPlugEjectDevice "); 

BOOL   bResult   =   HotPlugEjectDevice(NULL,   "USB\\Vid_0d7d&Pid_0150\\4D3B190303C0 "); 



HotPlugDeviceTree(HWND,DWORD,BOOL)
HWND 父窗口Handle
DWORD 不清楚，用0吧。
BOOL 用TRUE吧，用FALSE的话就会显示出所有的设备。

HotPlugEjectDevice（HWND   hwndParent,   PTCHAR   DeviceInstanceId)
}
*)
end.