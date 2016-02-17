{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit winole.dochost;

interface

uses
  Windows, ActiveX;

const
  SID_INewWindowManager                       = '{D2BC4C84-3F72-4A52-A604-7BCBF3982CBB}';
    
type                  
  PDOCHOSTUIINFO = ^TDOCHOSTUIINFO;
  TDOCHOSTUIINFO = record
    cbSize: ULONG;
    dwFlags: DWORD;
    dwDoubleClick: DWORD;
    chHostCss: POleStr;
    chHostNS: POleStr;
  end;
                  
  PBindInfo = ^TBindInfo;
  TBindInfo = record
    cbSize: ULONG;
    szExtraInfo: LPWSTR;
    stgmedData: TStgMedium;
    grfBindInfoF: DWORD;
    dwBindVerb: DWORD;
    szCustomVerb: LPWSTR;
    cbstgmedData: DWORD;
    dwOptions: DWORD;
    dwOptionsFlags: DWORD;
    dwCodePage: DWORD;
    securityAttributes: TSecurityAttributes;
    iid: TGUID;
    pUnk: IUnknown;
    dwReserved: DWORD;
  end;

  IDocHostShowUI = interface(IUnknown)
    ['{c4d244b0-d43e-11cf-893b-00aa00bdce1a}']
    function ShowMessage(hwnd: THandle; lpstrText: POleStr; lpstrCaption: POleStr;
      dwType: longint; lpstrHelpFile: POleStr; dwHelpContext: longint;
      var plResult: LRESULT): HRESULT; stdcall;
    function ShowHelp(hwnd: THandle; pszHelpFile: POleStr; uCommand: integer;
      dwData: longint; ptMouse: TPoint;
      var pDispatchObjectHit: IDispatch): HRESULT; stdcall;
  end;
                      
  IOleCommandTarget = interface(IUnknown)
    ['{b722bccb-4e68-101b-a2bc-00aa00404770}']
    function QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
      prgCmds: POleCmd; CmdText: POleCmdText): HResult; stdcall;
    function Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
      const vaIn: OleVariant; var vaOut: OleVariant): HResult; stdcall;
  end;
                        
  IDropTarget = interface(IUnknown)
    ['{00000122-0000-0000-C000-000000000046}']
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function DragOver(grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
  end;
  
  IDocHostUIHandler = interface(IUnknown)
    ['{bd3f23c0-d43e-11cf-893b-00aa00bdce1a}']
    function ShowContextMenu(const dwID: DWORD; const ppt: PPOINT;
      const CommandTarget: IUnknown; const Context: IDispatch): HRESULT; stdcall;
    function GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT; stdcall;
    function ShowUI(const dwID: DWORD; const pActiveObject: IOleInPlaceActiveObject;
      const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
      const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
    function HideUI: HRESULT; stdcall;
    function UpdateUI: HRESULT; stdcall;
    function EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
    function OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function ResizeBorder(const prcBorder: PRECT; const pUIWindow: IOleInPlaceUIWindow;
      const fRameWindow: BOOL): HRESULT; stdcall;
    function TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup: PGUID;
      const nCmdID: DWORD): HRESULT; stdcall;
    function GetOptionKeyPath(out pchKey: POleStr; const dw: DWORD): HRESULT; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget;
      out ppDropTarget: IDropTarget): HRESULT; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
    function TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POleStr;
      out ppchURLOut: POleStr): HRESULT; stdcall;
    function FilterDataObject(const pDO: IDataObject; out ppDORet: IDataObject): HRESULT; stdcall;
  end;

  IDocHostUIHandler2 = interface(IDocHostUIHandler)
    ['{3050f6d0-98b5-11cf-bb82-00aa00bdce0b}']
    function GetOverrideKeyPath(out pchKey: POleStr; dw: DWORD): HRESULT; stdcall;
  end;

  IProtectFocus = interface
    ['{D81F90A3-8156-44F7-AD28-5ABB87003274}']
    function AllowFocusChange(out pfAllow: BOOL): HRESULT; stdcall;
  end;

  ICustomDoc = interface(IUnknown)
    ['{3050f3f0-98b5-11cf-bb82-00aa00bdce0b}']
    function SetUIHandler(const pUIHandler: IDocHostUIHandler): HRESULT; stdcall;
  end;
                  
  IHTMLOMWindowServices = interface(IUnknown)
    ['{3050f5fc-98b5-11cf-bb82-00aa00bdce0b}']
    function moveTo(const x, y: Integer): HRESULT; stdcall;
    function moveBy(const x, y: Integer): HRESULT; stdcall;
    function resizeTo(const x, y: Integer): HRESULT; stdcall;
    function resizeBy(const x, y: Integer): HRESULT; stdcall;
  end;

  IDownloadManager = interface(IUnknown)
    ['{988934A4-064B-11D3-BB80-00104B35E7F9}']
    function Download(pmk: IMoniker; // Identifies the object to be downloaded
      pbc: IBindCtx; // Stores information used by the moniker to bind
      dwBindVerb: DWORD; // The action to be performed during the bind
      grfBINDF: DWORD; // Determines the use of URL encoding during the bind
      pBindInfo: PBindInfo; // Used to implement IBindStatusCallback::GetBindInfo
      pszHeaders: PWideChar; // Additional headers to use with IHttpNegotiate
      pszRedir: PWideChar; // The URL that the moniker is redirected to
      uiCP: UINT // The code page of the object's display name
      ): HRESULT; stdcall;
  end;
                      
  IZoomEvents = interface(IUnknown)
    ['{41B68150-904C-4E17-A0BA-A438182E359D}']
    function OnZoomPercentChanged(const ulZoomPercent: ulong): HRESULT; stdcall;
  end;

  IAuthenticate = interface
    ['{79eac9d0-baf9-11ce-8c82-00aa004ba90b}']
    function Authenticate(var hwnd: HWnd; var szUserName, szPassWord: LPWSTR): HResult; stdcall;
  end;
                        
  INewWindowManager = interface(IUnknown) 
    [SID_INewWindowManager]
    function EvaluateNewWindow(pszUrl: LPCWSTR; pszName: LPCWSTR; 
      pszUrlContext: LPCWSTR; pszFeatures: LPCWSTR; fReplace: BOOL; dwFlags: DWORD; 
      dwUserActionTime: DWORD): HRESULT; stdcall;
  end;
                
  IHostBehaviorInit = interface(IUnknown)
    ['{3050F842-98B5-11CF-BB82-00AA00BDCE0B}']
    function PopulateNamespaceTable: HRESULT; stdcall;
  end;
               
  { Doc Host Flags:
    http://msdn.microsoft.com/en-us/library/aa753277.aspx }
  { TUserInterfaceOption = (DIALOG, DISABLE_HELP_MENU, NO3DBORDER,
      SCROLL_NO, DISABLE_SCRIPT_INACTIVE, OPENNEWWIN, DISABLE_OFFSCREEN,
      FLAT_SCROLLBAR, DIV_BLOCKDEFAULT, ACTIVATE_CLIENTHIT_ONLY,
      OVERRIDEBEHAVIORFACTORY,
      CODEPAGELINKEDFONTS, URL_ENCODING_DISABLE_UTF8,
      URL_ENCODING_ENABLE_UTF8,
       ENABLE_FORMS_AUTOCOMPLETE, ENABLE_INPLACE_NAVIGATION,
      IME_ENABLE_RECONVERSION,
      THEME, NOTHEME, NOPICS, NO3DOUTERBORDER, DISABLE_EDIT_NS_FIXUP,
      LOCAL_MACHINE_ACCESS_CHECK, DISABLE_UNTRUSTEDPROTOCOL,
      HOST_NAVIGATES, ENABLE_REDIRECT_NOTIFICATION, USE_WINDOWLESS_SELECTCONTROL,
      USE_WINDOWED_SELECTCONTROL, ENABLE_ACTIVEX_INACTIVATE_MODE);
  }
  
  TOleDocHost = class(TObject,
    IDocHostShowUI,    // http://msdn.microsoft.com/en-us/library/aa753269.aspx
    IDocHostUIHandler,  // http://msdn.microsoft.com/en-us/library/aa753260(VS.85).aspx
    IDocHostUIHandler2, // http://msdn.microsoft.com/en-us/library/aa753275(VS.85).aspx
    IHostBehaviorInit, // http://msdn.microsoft.com/en-us/library/aa753687(VS.85).aspx
    IDropTarget,       // http://msdn.microsoft.com/en-us/library/ms679679.aspx
    IOleCommandTarget, // http://msdn.microsoft.com/en-us/library/ms683797.aspx
    INewWindowManager, // http://msdn.microsoft.com/en-us/library/bb775418(VS.85).aspx
    IProtectFocus,  // http://msdn2.microsoft.com/en-us/library/aa361771.aspx
    IDownloadManager, // http://msdn.microsoft.com/en-us/library/aa753613(VS.85).aspx
    IHTMLOMWindowServices, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/reference/ifaces/IHTMLOMWindowServices/IHTMLOMWindowServices.asp
    IZoomEvents, // http://msdn.microsoft.com/en-us/library/aa770056(VS.85).aspx
    IAuthenticate // http://msdn.microsoft.com/en-us/library/ms835407.aspx
    )
  protected
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IDocHostShowUI }
    function ShowMessage(hwnd: THandle; lpstrText: POleStr; lpstrCaption: POleStr;
      dwType: longint; lpstrHelpFile: POleStr; dwHelpContext: longint;
      var plResult: LRESULT): HRESULT; stdcall;
    function ShowHelp(hwnd: THandle; pszHelpFile: POleStr; uCommand: integer;
      dwData: longint; ptMouse: TPoint;
      var pDispatchObjectHit: IDispatch): HRESULT; stdcall;
    { IDocHostUIHandler }      
    function ShowContextMenu(const dwID: DWORD; const ppt: PPOINT;
      const CommandTarget: IUnknown; const Context: IDispatch): HRESULT;
      stdcall;
    function GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT; stdcall;
    function ShowUI(const dwID: DWORD; const pActiveObject:
      IOleInPlaceActiveObject;
      const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
      const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
    function HideUI: HRESULT; stdcall;
    function UpdateUI: HRESULT; stdcall;
    function EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
    function OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function ResizeBorder(const prcBorder: PRECT;
      const pUIWindow: IOleInPlaceUIWindow;
      const fRameWindow: BOOL): HRESULT; stdcall;
    function TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup: PGUID;
      const nCmdID: DWORD): HRESULT; stdcall;
    function GetOptionKeyPath(out pchKey: POleStr; const dw: DWORD): HRESULT; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget;
      out ppDropTarget: IDropTarget): HRESULT; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
    function TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POleStr;
      out ppchURLOut: POleStr): HRESULT; stdcall;
    function FilterDataObject(const pDO: IDataObject;
      out ppDORet: IDataObject): HRESULT; stdcall;
    { IDocHostUIHandler2 }  
    function GetOverrideKeyPath(out pchKey: POleStr; dw: DWORD): HRESULT; stdcall;
    { IHostBehaviorInit }   
    function PopulateNamespaceTable: HRESULT; stdcall;
    { IDropTarget }     
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function DragOver(grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    { IOleCommandTarget }  
    function QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
      prgCmds: POleCmd; CmdText: POleCmdText): HResult; stdcall;
    function Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
      const vaIn: OleVariant; var vaOut: OleVariant): HResult; stdcall;
    { INewWindowManager }
    function EvaluateNewWindow(pszUrl: LPCWSTR; pszName: LPCWSTR; 
      pszUrlContext: LPCWSTR; pszFeatures: LPCWSTR; fReplace: BOOL; dwFlags: DWORD; 
      dwUserActionTime: DWORD): HRESULT; stdcall;
    { IProtectFocus }
    function AllowFocusChange(out pfAllow: BOOL): HRESULT; stdcall;    
    { IDownloadManager }
    function Download(pmk: IMoniker; // Identifies the object to be downloaded
      pbc: IBindCtx; // Stores information used by the moniker to bind
      dwBindVerb: DWORD; // The action to be performed during the bind
      grfBINDF: DWORD; // Determines the use of URL encoding during the bind
      pBindInfo: PBindInfo; // Used to implement IBindStatusCallback::GetBindInfo
      pszHeaders: PWideChar; // Additional headers to use with IHttpNegotiate
      pszRedir: PWideChar; // The URL that the moniker is redirected to
      uiCP: UINT // The code page of the object's display name
      ): HRESULT; stdcall;
    { IHTMLOMWindowServices } 
    function moveTo(const x, y: Integer): HRESULT; stdcall;
    function moveBy(const x, y: Integer): HRESULT; stdcall;
    function resizeTo(const x, y: Integer): HRESULT; stdcall;
    function resizeBy(const x, y: Integer): HRESULT; stdcall;
    { IZoomEvents }
    function OnZoomPercentChanged(const ulZoomPercent: ulong): HRESULT; stdcall;    
    { IAuthenticate }
    function Authenticate(var hwnd: HWnd; var szUserName, szPassWord: LPWSTR): HResult; stdcall;    
  public
  end;

implementation

                                  
function TOleDocHost.QueryInterface(const IID: TGUID; out Obj): HResult; 
begin

end;

function TOleDocHost._AddRef: Integer; stdcall;
begin

end;

function TOleDocHost._Release: Integer; stdcall;
begin

end;

function TOleDocHost.ShowMessage(hwnd: THandle; lpstrText: POleStr; lpstrCaption: POleStr;
  dwType: longint; lpstrHelpFile: POleStr; dwHelpContext: longint;
  var plResult: LRESULT): HRESULT; stdcall;
begin
  Result := S_FALSE;
//  if Assigned(FOnShowMessage) then
//    Result := FOnShowMessage(Self, HWND, lpstrText, lpStrCaption, dwType, lpStrHelpFile, dwHelpContext, plResult)
end;

function TOleDocHost.ShowHelp(hwnd: THandle; pszHelpFile: POleStr; uCommand: integer;
  dwData: longint; ptMouse: TPoint;
  var pDispatchObjectHit: IDispatch): HRESULT; stdcall;
begin

end;

{ IDocHostUIHandler }
function TOleDocHost.ShowContextMenu(const dwID: DWORD; const ppt: PPOINT;
  const CommandTarget: IUnknown; const Context: IDispatch): HRESULT; stdcall;
begin

end;

function TOleDocHost.GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT; stdcall;
begin

end;

function TOleDocHost.ShowUI(const dwID: DWORD; const pActiveObject:
  IOleInPlaceActiveObject;
  const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
  const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
begin
  Result := S_FALSE;
end;

function TOleDocHost.HideUI: HRESULT; stdcall;
begin

end;

function TOleDocHost.UpdateUI: HRESULT; stdcall;
begin                   
  Result := S_FALSE;
end;

function TOleDocHost.EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
begin

end;

function TOleDocHost.OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
begin

end;

function TOleDocHost.OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
begin

end;

function TOleDocHost.ResizeBorder(const prcBorder: PRECT;
  const pUIWindow: IOleInPlaceUIWindow;
  const fRameWindow: BOOL): HRESULT; stdcall;
begin

end;

function TOleDocHost.TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup: PGUID;
  const nCmdID: DWORD): HRESULT; stdcall;
begin
  Result := S_FALSE;
//  Filtered := DoFilterMsg(lpMsg);
(*
  ShiftState := KeyDataToShiftState(PWMKey(lpMsg)^.KeyData);
  Result := (FDisableCtrlShortcuts <> '') and (lpMsg^.message = WM_KEYDOWN)
    and ((ShiftState = [ssCtrl]) and (ShiftState <> [ssAlt]))
    and (_CharPos(Char(lpMsg.wParam), FDisableCtrlShortcuts) > 0);
*)
//  if Filtered then
//    Result := S_OK
end;

function TOleDocHost.GetOptionKeyPath(out pchKey: POleStr; const dw: DWORD): HRESULT; stdcall;
begin

end;

function TOleDocHost.GetDropTarget(const pDropTarget: IDropTarget;
  out ppDropTarget: IDropTarget): HRESULT; stdcall;
begin

end;

function TOleDocHost.GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
begin

end;

function TOleDocHost.TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POleStr;
  out ppchURLOut: POleStr): HRESULT; stdcall;

(*  
function WideStringToLPOLESTR(const Source: Widestring): POleStr;
var
  Len: Integer;
begin
  Len := Length(Source) * SizeOf(WideChar);
  Result := CoTaskMemAlloc(Len + 2);
  FillChar(Result^, Len + 2, 0);
  Move(Result^, PWideString(Source)^, Len);
end;
*)
begin
  Result := S_FALSE;
//  if URLOut <> '' then
//  begin
//    Result := S_OK;
//    ppchURLOut := WideStringToLPOLESTR(URLOut);
//  end;
end;

function TOleDocHost.FilterDataObject(const pDO: IDataObject;
  out ppDORet: IDataObject): HRESULT; stdcall;
begin

end;

{ IDocHostUIHandler2 }
function TOleDocHost.GetOverrideKeyPath(out pchKey: POleStr; dw: DWORD): HRESULT; stdcall;
begin

end;

{ IHostBehaviorInit }
function TOleDocHost.PopulateNamespaceTable: HRESULT; stdcall;
begin

end;

{ IDropTarget }
function TOleDocHost.DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
  pt: TPoint; var dwEffect: Longint): HResult; stdcall;
begin

end;

function TOleDocHost.DragOver(grfKeyState: Longint; pt: TPoint;
  var dwEffect: Longint): HResult; stdcall;
begin

end;

function TOleDocHost.DragLeave: HResult; stdcall;
begin

end;

function TOleDocHost.Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
  var dwEffect: Longint): HResult; stdcall;
begin

end;

{ IOleCommandTarget }
function TOleDocHost.QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
  prgCmds: POleCmd; CmdText: POleCmdText): HResult; stdcall;
begin

end;
                      
function IsEqualGUID(const Guid1, Guid2: TGUID): Boolean;
var
  a, b: PIntegerArray;
begin
  a := PIntegerArray(@Guid1);
  b := PIntegerArray(@Guid2);
  Result := (a^[0] = b^[0]) and (a^[1] = b^[1]) and (a^[2] = b^[2]) and (a^[3] = b^[3]);
end;

const
  CGID_Explorer: TGUID           = '{000214D0-0000-0000-C000-000000000046}';
  CGID_DocHostCommandHandler: TGUID = (D1: $F38BC242; D2: $B950; D3: $11D1; D4:
    ($89, $18, $00, $C0, $4F, $C2, $C8, $36));

// copy from IEConst.pas

  ID_IE_CONTEXTMENU_ADDFAV = 2261;
  ID_IE_CONTEXTMENU_NEWWINDOW = 2137;
  ID_IE_CONTEXTMENU_REFRESH = 6042;
  ID_IE_F5_REFRESH = 6041; // added by smot
  ID_IE_FILE_ADDLOCAL = 377;
  ID_IE_FILE_ADDTRUST = 376;
  ID_IE_FILE_IMPORTEXPORT = 374;
  ID_IE_FILE_NEWCALL = 395;
  ID_IE_FILE_NEWMAIL = 279;
  ID_IE_FILE_NEWPEOPLE = 390;
  ID_IE_FILE_NEWPUBLISHINFO = 387;
  ID_IE_FILE_NEWWINDOW = 275;
  ID_IE_FILE_PAGESETUP = 259;
  ID_IE_FILE_PRINT = 260;
  ID_IE_FILE_PRINTPREVIEW = 277;
  ID_IE_FILE_SENDDESKTOPSHORTCUT = 284;
  ID_IE_FILE_SENDLINK = 283;
  ID_IE_FILE_SENDPAGE = 282;
  ID_IE_HELP_BESTPAGE = 346;
  ID_IE_HELP_ENHANCEDSECURITY = 375;
  ID_IE_HELP_FAQ = 343;
  ID_IE_HELP_FEEDBACK = 345;
  ID_IE_HELP_FREESTUFF = 341;
  ID_IE_HELP_HELPINDEX = 337;
  ID_IE_HELP_MSHOME = 348;
  ID_IE_HELP_NETSCAPEUSER = 351;
  ID_IE_HELP_ONLINESUPPORT = 344;
  ID_IE_HELP_PRODUCTUPDATE = 342;
  ID_IE_HELP_SEARCHWEB = 347;
  ID_IE_HELP_STARTPAGE = 350;
  ID_IE_HELP_VERSIONINFO = 336;
  ID_IE_HELP_VISITINTERNET = 349;
  ID_IE_HELP_WEBTUTORIAL = 338;
                                
  IDM_REFRESH = 2300;
  
  OLECMDID_OPEN = $00000001;
  OLECMDID_NEW = $00000002;
  OLECMDID_SAVE = $00000003;
  OLECMDID_SAVEAS = $00000004;
  OLECMDID_SAVECOPYAS = $00000005;
  OLECMDID_PRINT = $00000006;
  OLECMDID_PRINTPREVIEW = $00000007;
  OLECMDID_PAGESETUP = $00000008;
  OLECMDID_SPELL = $00000009;
  OLECMDID_PROPERTIES = $0000000A;
  OLECMDID_CUT = $0000000B;
  OLECMDID_COPY = $0000000C;
  OLECMDID_PASTE = $0000000D;
  OLECMDID_PASTESPECIAL = $0000000E;
  OLECMDID_UNDO = $0000000F;
  OLECMDID_REDO = $00000010;
  OLECMDID_SELECTALL = $00000011;
  OLECMDID_CLEARSELECTION = $00000012;
  OLECMDID_ZOOM = $00000013;
  OLECMDID_GETZOOMRANGE = $00000014;
  OLECMDID_UPDATECOMMANDS = $00000015;
  OLECMDID_REFRESH = $00000016;
  OLECMDID_STOP = $00000017;
  OLECMDID_HIDETOOLBARS = $00000018;
  OLECMDID_SETPROGRESSMAX = $00000019;
  OLECMDID_SETPROGRESSPOS = $0000001A;
  OLECMDID_SETPROGRESSTEXT = $0000001B;
  OLECMDID_SETTITLE = $0000001C;
  OLECMDID_SETDOWNLOADSTATE = $0000001D;
  OLECMDID_STOPDOWNLOAD = $0000001E;
  OLECMDID_ONTOOLBARACTIVATED = $0000001F;
  OLECMDID_FIND = $00000020;
  OLECMDID_DELETE = $00000021;
  OLECMDID_HTTPEQUIV = $00000022;
  OLECMDID_HTTPEQUIV_DONE = $00000023;
  OLECMDID_ENABLE_INTERACTION = $00000024;
  OLECMDID_ONUNLOAD = $00000025;
  OLECMDID_PROPERTYBAG2 = $00000026;
  OLECMDID_PREREFRESH = $00000027;
  OLECMDID_SHOWSCRIPTERROR = $00000028;
  OLECMDID_SHOWMESSAGE = $00000029;
  OLECMDID_SHOWFIND = $0000002A;
  OLECMDID_SHOWPAGESETUP = $0000002B;
  OLECMDID_SHOWPRINT = $0000002C;
  OLECMDID_CLOSE = $0000002D;
  OLECMDID_ALLOWUILESSSAVEAS = $0000002E;
  OLECMDID_DONTDOWNLOADCSS = $0000002F;
  OLECMDID_UPDATEPAGESTATUS = $00000030;
  OLECMDID_PRINT2 = $00000031;
  OLECMDID_PRINTPREVIEW2 = $00000032;
  OLECMDID_SETPRINTTEMPLATE = $00000033;
  OLECMDID_GETPRINTTEMPLATE = $00000034;
  OLECMDID_PAGEACTIONBLOCKED = $00000037;
  OLECMDID_PAGEACTIONUIQUERY = $00000038;
  OLECMDID_FOCUSVIEWCONTROLS = $00000039;
  OLECMDID_FOCUSVIEWCONTROLSQUERY = $0000003A;
  OLECMDID_SHOWPAGEACTIONMENU = $0000003B;
   //New IE7 Values
  OLECMDID_ADDTRAVELENTRY = $0000003C;
  OLECMDID_UPDATETRAVELENTRY = $0000003D;
  OLECMDID_UPDATEBACKFORWARDSTATE = $0000003E;
  OLECMDID_OPTICAL_ZOOM = $0000003F;
  OLECMDID_OPTICAL_GETZOOMRANGE = $00000040;
  OLECMDID_WINDOWSTATECHANGED = $00000041;
   //New IE8 Values
  OLECMDID_ACTIVEXINSTALLSCOPE = $00000042;
  OLECMDID_UPDATETRAVELENTRY_DATARECOVERY = $00000043;

(*

function TCustomEmbeddedWB.ScriptErrorHandler(const vaIn: OleVariant;
  var vaOut: OleVariant): HRESULT;
var
  EventObject: IHTMLEventObj;
  CurWindow: IHTMLWindow2;
  CurDocument: IHTMLDocument2;
  CurUnknown: IUnknown;

  function GetProperty(const PropName: WideString): OleVariant;
  var
    DispParams: TDispParams;
    Disp, Status: Integer;
    ExcepInfo: TExcepInfo;
    PPropName: PWideChar;
  begin
    DispParams.rgvarg := nil;
    DispParams.rgdispidNamedArgs := nil;
    DispParams.cArgs := 0;
    DispParams.cNamedArgs := 0;
    PPropName := PWideChar(PropName);
    Status := EventObject.GetIDsOfNames(GUID_NULL, @PPropName, 1, LOCALE_SYSTEM_DEFAULT, @Disp);
    if Status = 0 then
    begin
      Status := EventObject.Invoke(disp, GUID_NULL, LOCALE_SYSTEM_DEFAULT,
        DISPATCH_PROPERTYGET, DispParams, @Result, @ExcepInfo, nil);
      if Status <> 0 then
        DispatchInvokeError(Status, ExcepInfo);
    end
    else if Status = DISP_E_UNKNOWNNAME then
      raise
        EOleError.CreateFmt('''%s'' is not supported.', [PropName])
    else
      OleCheck(Status);
  end;
begin
  Result := S_OK;
  case FScriptErrorAction of
    eaAskUser: Result := S_FALSE; //E_FAIL;
    eaContinue: vaOut := True;
    eaCancel: vaOut := False;
  end;

  if Assigned(FOnScriptError) then
  begin
    CurUnknown := IUnknown(TVarData(vaIn).VUnknown);
    if Succeeded(CurUnknown.QueryInterface(IID_IHTMLDocument2, CurDocument)) then
    begin
      CurWindow := CurDocument.Get_parentWindow;
      CurDocument := nil;
      if Assigned(CurWindow) then
      begin
        EventObject := CurWindow.Get_event;
        if EventObject <> nil then
        begin
          FOnScriptError(Self,
            GetProperty('errorline'),
            GetProperty('errorCharacter'),
            GetProperty('errorCode'),
            GetProperty('errorMessage'),
            GetProperty('errorUrl'),
            FScriptErrorAction);
        end;
      end;
    end;
  end;
end;
*)
function TOleDocHost.Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
  const vaIn: OleVariant; var vaOut: OleVariant): HResult; stdcall;
begin
  if CmdGroup <> nil then
  begin
    if IsEqualGuid(cmdGroup^, CGID_EXPLORER) then
    begin
      case nCmdID of
        OLECMDID_ONUNLOAD: begin
        
        end;  
        OLECMDID_PREREFRESH: begin

        end;
      end;
    end else if IsEqualGuid(cmdGroup^, CGID_DocHostCommandHandler) then
    begin
      case nCmdID of
        ID_IE_F5_REFRESH {nCmdID 6041, F5},
        ID_IE_CONTEXTMENU_REFRESH {nCmdID 6042, Refresh by ContextMenu},
        IDM_REFRESH {nCmdID 2300}:
          begin

          end;
        OLECMDID_SHOWSCRIPTERROR: begin
//            Result := ScriptErrorHandler(vaIn, vaOut);
(*
  Result := S_OK;
  case FScriptErrorAction of
    eaAskUser: Result := S_FALSE; //E_FAIL;
    eaContinue: vaOut := True;
    eaCancel: vaOut := False;
  end;
*)
//            Exit;
        end;
      end;
    end;
  end;
end;

{ INewWindowManager }
function TOleDocHost.EvaluateNewWindow(pszUrl: LPCWSTR; pszName: LPCWSTR;
  pszUrlContext: LPCWSTR; pszFeatures: LPCWSTR; fReplace: BOOL; dwFlags: DWORD;
  dwUserActionTime: DWORD): HRESULT; stdcall;
begin

end;

{ IProtectFocus }
function TOleDocHost.AllowFocusChange(out pfAllow: BOOL): HRESULT; stdcall;
begin

end;

{ IDownloadManager }
function TOleDocHost.Download(pmk: IMoniker; // Identifies the object to be downloaded
  pbc: IBindCtx; // Stores information used by the moniker to bind
  dwBindVerb: DWORD; // The action to be performed during the bind
  grfBINDF: DWORD; // Determines the use of URL encoding during the bind
  pBindInfo: PBindInfo; // Used to implement IBindStatusCallback::GetBindInfo
  pszHeaders: PWideChar; // Additional headers to use with IHttpNegotiate
  pszRedir: PWideChar; // The URL that the moniker is redirected to
  uiCP: UINT // The code page of the object's display name
  ): HRESULT; stdcall;
begin

end;

{ IHTMLOMWindowServices }
function TOleDocHost.moveTo(const x, y: Integer): HRESULT; stdcall;
begin

end;

function TOleDocHost.moveBy(const x, y: Integer): HRESULT; stdcall;
begin

end;

function TOleDocHost.resizeTo(const x, y: Integer): HRESULT; stdcall;
begin

end;

function TOleDocHost.resizeBy(const x, y: Integer): HRESULT; stdcall;
begin

end;

{ IZoomEvents }
function TOleDocHost.OnZoomPercentChanged(const ulZoomPercent: ulong): HRESULT; stdcall;
begin

end;

{ IAuthenticate }
function TOleDocHost.Authenticate(var hwnd: HWnd; var szUserName, szPassWord: LPWSTR): HResult; stdcall;
begin

end;

end.

