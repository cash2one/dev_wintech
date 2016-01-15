(*
Language Pack

Win7下使用Lpk.dll补丁方法
2011-05-10 8:05
现在有很多软件都是写的LPK,但是在WIN7下很多用不了,所以这里发一个方法....
Win7（或VISTA）下用管理员权限将lpk.reg导入注册表，重启系统，就能用lpk了。 
reg文件内容：

Windows Registry Editor Version 5.00 

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager] 
"ExcludeFromKnownDlls"=hex(7):6c,00,70,00,6b,00,2e,00,64,00,6c,00,6c,00,00,00,\ 
00,00 
*)

unit dll_Lpk;

interface

implementation

end.