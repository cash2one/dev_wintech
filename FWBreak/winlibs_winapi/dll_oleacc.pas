(*
          3    0 0001DD15 AccessibleChildren
          4    1 0001DCD8 AccessibleObjectFromEvent
          5    2 0001DCEF AccessibleObjectFromPoint
          6    3 00001FF3 AccessibleObjectFromWindow
          7    4 0001DD88 CreateStdAccessibleObject
          8    5 0001DD9F CreateStdAccessibleProxyA
          9    6 0001DDB6 CreateStdAccessibleProxyW
         10    7 000069E5 DllCanUnloadNow
         11    8 00006F6C DllGetClassObject
          1    9 0001DC48 DllRegisterServer
          2    A 0001DC6A DllUnregisterServer
         12    B 0001DDCD GetOleaccVersionInfo
         13    C 0001DD2C GetRoleTextA
         14    D 0001DD43 GetRoleTextW
         15    E 0001DD5A GetStateTextA
         16    F 0001DD71 GetStateTextW
         17   10 00004B8C IID_IAccessible
         18   11 000048A0 IID_IAccessibleHandler
         19   12 000048B0 LIBID_Accessibility
         20   13 0001DC93 LresultFromObject
         21   14 0001DCAA ObjectFromLresult
         22   15 0001DCC1 WindowFromAccessibleObject
*)
unit dll_oleacc;

interface
          
uses
  atmcmbaseconst, wintype, activex;

type
  TDLLGetClassObject    = function(const clsid: TCLSID; const iid: TIID; out pv): HResult stdcall;
  TDLLCanUnloadNow      = function: HResult stdcall;
  TDLLRegisterServer    = function: HResult stdcall;
  TDLLUnregisterServer  = function: HResult stdcall;

  POleAccModule         = ^TOleAccModule;
  TOleAccModule         = record
    Module              : HMODULE;
    DLLGetClassObject   : TDLLGetClassObject;
    DLLCanUnloadNow     : TDLLCanUnloadNow;
    DLLRegisterServer   : TDLLRegisterServer;
    DLLUnregisterServer : TDLLUnregisterServer;
  end;
  
implementation

end.