unit dll_ole32;

interface 

uses
  atmcmbaseconst, winconst, wintype, Intf_oledata;
  
const
  ole32    = 'ole32.dll';

  // CoCreateInstance
  CLSCTX_INPROC_SERVER     = 1;
  CLSCTX_INPROC_HANDLER    = 2;
  CLSCTX_LOCAL_SERVER      = 4;
  CLSCTX_INPROC_SERVER16   = 8;
  CLSCTX_REMOTE_SERVER     = $10;
  CLSCTX_INPROC_HANDLER16  = $20;
  CLSCTX_INPROC_SERVERX86  = $40;
  CLSCTX_INPROC_HANDLERX86 = $80;

  { CoInitialize has not been called. }
  CO_E_NOTINITIALIZED = HRESULT($800401F0);
  { CoInitialize has already been called. }
  CO_E_ALREADYINITIALIZED = HRESULT($800401F1);
  { Class of object cannot be determined }
  CO_E_CANTDETERMINECLASS = HRESULT($800401F2);
  { Invalid class string }
  CO_E_CLASSSTRING = HRESULT($800401F3);
  { Invalid interface string }
  CO_E_IIDSTRING = HRESULT($800401F4);
  { Application not found }
  CO_E_APPNOTFOUND = HRESULT($800401F5);
  { Application cannot be run more than once }
  CO_E_APPSINGLEUSE = HRESULT($800401F6);
  { Some error in application program }
  CO_E_ERRORINAPP = HRESULT($800401F7);
  { DLL for class not found }
  CO_E_DLLNOTFOUND = HRESULT($800401F8);
  { Error in the DLL }
  CO_E_ERRORINDLL = HRESULT($800401F9);
  { Wrong OS or OS version for application }
  CO_E_WRONGOSFORAPP = HRESULT($800401FA);
  { Object is not registered }
  CO_E_OBJNOTREG = HRESULT($800401FB);
  { Object is already registered }
  CO_E_OBJISREG = HRESULT($800401FC);
  { Object is not connected to server }
  CO_E_OBJNOTCONNECTED = HRESULT($800401FD);
  { Application was launched but it didn't register a class factory }
  CO_E_APPDIDNTREG = HRESULT($800401FE);
  { Object has been released }
  CO_E_RELEASED = HRESULT($800401FF);


type
  PSOleAuthenticationService = ^TSOleAuthenticationService;
  TSOleAuthenticationService = record
    dwAuthnSvc      : Longint;
    dwAuthzSvc      : Longint;
    pPrincipalName  : POleStr;
    hr              : HResult;
  end;
                                 
  PCoServerInfo     = ^TCoServerInfo;
  TCoServerInfo     = record
    dwReserved1     : Longint;
    pwszName        : LPWSTR;
    pAuthInfo       : Pointer;
    dwReserved2     : Longint;
  end;

  PMultiQI          = ^TMultiQI;
  TMultiQI          = record
    IID             : PIID;
    Itf             : IUnknown;
    hr              : HRESULT;
  end;

  PMultiQIArray     = ^TMultiQIArray;
  TMultiQIArray     = array[0..65535] of TMultiQI;

  function CoInitialize(pvReserved: Pointer): HResult; stdcall; external ole32 name 'CoInitialize';
  function CoInitializeEx(pvReserved: Pointer; coInit: Longint): HResult; stdcall; external ole32 name 'CoInitializeEx';
  procedure CoUninitialize; stdcall; external ole32 name 'CoUninitialize';

  function OleInitialize(pwReserved: Pointer): HResult; stdcall; external ole32 name 'OleInitialize';
  procedure OleUninitialize; stdcall; external ole32 name 'OleUninitialize';
  function CoLoadLibrary(pszLibName: POleStr; bAutoFree: BOOL): THandle; stdcall; external ole32 name 'CoLoadLibrary';
  procedure CoFreeLibrary(hInst: THandle); stdcall; external ole32 name 'CoFreeLibrary';
  procedure CoFreeAllLibraries; stdcall; external ole32 name 'CoFreeAllLibraries';
  procedure CoFreeUnusedLibraries; stdcall; external ole32 name 'CoFreeUnusedLibraries';
  function CoInitializeSecurity(pSecDesc: Pointer; cAuthSvc: Longint;
      asAuthSvc: PSOleAuthenticationService; pReserved1: Pointer;
      dwAuthnLevel, dImpLevel: Longint; pReserved2: Pointer; dwCapabilities: Longint;
      pReserved3: Pointer): HResult; stdcall; external ole32 name 'CoInitializeSecurity';

  function CoCreateInstance(const clsid: TCLSID; unkOuter: IUnknown;
      dwClsContext: Longint; const iid: TIID; out pv): HResult; stdcall; external ole32 name 'CoCreateInstance';
  function CoCreateInstanceEx(const clsid: TCLSID; unkOuter: IUnknown; dwClsCtx: Longint; ServerInfo: PCoServerInfo;
      dwCount: Longint; rgmqResults: PMultiQIArray): HResult; stdcall; external ole32 name 'CoCreateInstanceEx';
                                                                                     
  function CoRegisterClassObject(const clsid: TCLSID; unk: IUnknown;
    dwClsContext: Longint; flags: Longint; out dwRegister: Longint): HResult; stdcall; external ole32 name 'CoRegisterClassObject';
  function CoRevokeClassObject(dwRegister: Longint): HResult; stdcall; external ole32 name 'CoRevokeClassObject';

//  function RegisterDragDrop(wnd: HWnd; dropTarget: IDropTarget): HResult; stdcall; external ole32 name 'RegisterDragDrop';
//  function RevokeDragDrop(wnd: HWnd): HResult; stdcall; external ole32 name 'RevokeDragDrop';
//  function DoDragDrop(dataObj: IDataObject; dropSource: IDropSource; dwOKEffects: Longint; var dwEffect: Longint): HResult; stdcall;
//    external ole32 name 'DoDragDrop';

  function CoCreateGuid(out guid: TGUID): HResult; stdcall; external ole32 name 'CoCreateGuid';    
  function IsEqualGUID(const guid1, guid2: TGUID): Boolean; stdcall; external ole32 name 'IsEqualGUID';
  function StringFromCLSID(const clsid: TCLSID; out psz: POleStr): HResult; stdcall; external ole32 name 'StringFromCLSID';
  function CLSIDFromString(psz: POleStr; out clsid: TCLSID): HResult; stdcall; external ole32 name 'CLSIDFromString';
  function StringFromIID(const iid: TIID; out psz: POleStr): HResult; stdcall; external ole32 name 'StringFromIID';
  function IIDFromString(psz: POleStr; out iid: TIID): HResult; stdcall; external ole32 name 'IIDFromString';

  procedure ReleaseStgMedium(var medium: TStgMedium); stdcall; external ole32 name 'ReleaseStgMedium';

type
  TCoInitializeExProc   = function (pvReserved: Pointer; coInit: Longint): HResult; stdcall;
  TCoAddRefServerProcessProc = function :Longint; stdcall;
  TCoReleaseServerProcessProc = function :Longint; stdcall;
  TCoResumeClassObjectsProc = function :HResult; stdcall;
  TCoSuspendClassObjectsProc = function :HResult; stdcall;

  POle32Module          = ^TOle32Module;
  TOle32Module          = record
    Module              : HMODULE;
  end;
  
implementation

(*
    @CoCreateInstanceEx := GetProcAddress(Ole32, 'CoCreateInstanceEx');
    @CoInitializeEx := GetProcAddress(Ole32, 'CoInitializeEx');
    @CoAddRefServerProcess := GetProcAddress(Ole32, 'CoAddRefServerProcess');
    @CoReleaseServerProcess := GetProcAddress(Ole32, 'CoReleaseServerProcess');
    @CoResumeClassObjects := GetProcAddress(Ole32, 'CoResumeClassObjects');
    @CoSuspendClassObjects := GetProcAddress(Ole32, 'CoSuspendClassObjects');
*)

end.
