unit winole.clientsite;

interface

uses
  Windows, ActiveX, uiwin.wnd;
  
type      
  POleWindow        = ^TOleWindow;
  POleWinSiteData   = ^TOleWinSiteData;
  POleWinEventData  = ^TOleWinEventData;

  TOnInvokeCallBack = function (DispID: Integer; const IID: TGUID; LocaleID: Integer;
    Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult of object;

  TOleWinSiteData   = record
    OleWindow       : POleWindow;
    OnInvoke        : TOnInvokeCallBack;
  end;

  TOleWinEventData = record
    OleWindow : POleWindow;
    OnInvoke  : TOnInvokeCallBack;
  end;

  TOleWinEvent = class(TObject, IUnknown, IDispatch)
  private
    function GetOleWindow: POleWindow;
    procedure SetOleWindow(const Value: POleWindow);
  protected
    FOleWinEventData: TOleWinEventData;
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; stdcall;
  public
    constructor Create;
    destructor Destroy; override;
    property OleWindow: POleWindow read GetOleWindow write SetOleWindow;    
    property OnInvoke: TOnInvokeCallBack read FOleWinEventData.OnInvoke write FOleWinEventData.OnInvoke;
  end;

  TOleWinSite = class(TObject,
    IUnknown,
    IDispatch,
    IOleClientSite,
    IOleControlSite,
    IOleInPlaceSite,
    IOleInPlaceFrame,
    IPropertyNotifySink,
    ISimpleFrameSite,
    IOleContainer,
    IServiceProvider)
  private
    function GetOleWindow: POleWindow;
    procedure SetOleWindow(const Value: POleWindow);
  protected
    FOleWinSiteData: TOleWinSiteData;
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {IDispatch}
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    {IOleClientSite}
    function SaveObject: HResult; stdcall;
    function GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint;
      out mk: IMoniker): HResult; stdcall;
    function GetContainer(out container: IOleContainer): HResult; stdcall; 
    function ShowObject: HResult; virtual; stdcall;
    function OnShowWindow(fShow: BOOL): HResult; stdcall;
    function RequestNewObjectLayout: HResult; stdcall;
    {IOleControlSite}
    function OnControlInfoChanged: HResult; stdcall;
    function LockInPlaceActive(fLock: BOOL): HResult; stdcall;
    function GetExtendedControl(out disp: IDispatch): HResult; stdcall;
    function TransformCoords(var ptlHimetric: TPoint; var ptfContainer: TPointF;
      flags: Longint): HResult; stdcall;
    function IOleControlSite.TranslateAccelerator = IOleControlSite_TranslateAccelerator;
    function IOleControlSite_TranslateAccelerator(msg: PMsg; grfModifiers: Longint): HResult; stdcall;
    function OnFocus(fGotFocus: BOOL): HResult; stdcall;
    function ShowPropertyFrame: HResult; stdcall;
    {IOleInPlaceSite.IOleWindow}
    function GetWindow(out wnd: HWnd): HResult; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall;
    {IOleInPlaceSite}
    function CanInPlaceActivate: HResult; stdcall;
    function OnInPlaceActivate: HResult; stdcall;
    function OnUIActivate: HResult; stdcall;
    function GetWindowContext(out frame: IOleInPlaceFrame;
      out doc: IOleInPlaceUIWindow; out rcPosRect: TRect;
      out rcClipRect: TRect; out frameInfo: TOleInPlaceFrameInfo): HResult; stdcall;
    function Scroll(scrollExtent: TPoint): HResult; stdcall;
    function OnUIDeactivate(fUndoable: BOOL): HResult; stdcall;
    function OnInPlaceDeactivate: HResult; stdcall;
    function DiscardUndoState: HResult; stdcall;
    function DeactivateAndUndo: HResult; stdcall;
    function OnPosRectChange(const rcPosRect: TRect): HResult; stdcall;
    {IOleInPlaceFrame.IOleInPlaceUIWindow}
    function GetBorder(out rectBorder: TRect): HResult; stdcall;
    function RequestBorderSpace(const borderwidths: TRect): HResult; stdcall;
    function SetBorderSpace(pborderwidths: PRect): HResult; stdcall;
    function SetActiveObject(const activeObject: IOleInPlaceActiveObject;
      pszObjName: POleStr): HResult; stdcall;
    {IOleInPlaceFrame}
    function InsertMenus(hmenuShared: HMenu;
      var menuWidths: TOleMenuGroupWidths): HResult; stdcall;
    function SetMenu(hmenuShared: HMenu; holemenu: HMenu;
      hwndActiveObject: HWnd): HResult; stdcall;
    function RemoveMenus(hmenuShared: HMenu): HResult; stdcall;
    function SetStatusText(pszStatusText: POleStr): HResult; stdcall;
    function EnableModeless(fEnable: BOOL): HResult; stdcall;
    function IOleInPlaceFrame.TranslateAccelerator = IOleInPlaceFrame_TranslateAccelerator;
    function IOleInPlaceFrame_TranslateAccelerator(var msg: TMsg; wID: Word): HResult; stdcall;
    {IPropertyNotifySink}
    function OnChanged(dispid: TDispID): HResult; stdcall;
    function OnRequestEdit(dispid: TDispID): HResult; stdcall;
    {ISimpleFrameSite}
    function PreMessageFilter(wnd: HWnd; msg, wp, lp: Integer;
      out res: Integer; out Cookie: Longint): HResult; stdcall;
    function PostMessageFilter(wnd: HWnd; msg, wp, lp: Integer;
      out res: Integer; Cookie: Longint): HResult; stdcall;
                                                         
    { IOleContainer.IParseDisplayName }  
    function ParseDisplayName(const bc: IBindCtx; pszDisplayName: POleStr;
      out chEaten: Longint; out mkOut: IMoniker): HResult; stdcall;
    { IOleContainer }  
    function EnumObjects(grfFlags: Longint; out Enum: IEnumUnknown): HResult; stdcall;
    function LockContainer(fLock: BOOL): HResult; stdcall;
    {IServiceProvider}
    function QueryService(const rsid, iid: TGuid; out Obj): HResult; stdcall;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property OleWindow: POleWindow read GetOleWindow write SetOleWindow;      
    property OnInvoke: TOnInvokeCallBack read FOleWinSiteData.OnInvoke write FOleWinSiteData.OnInvoke;
  end;
             
  TOleWindow              = record
    BaseWnd               : TWndUI;
    RefCount              : integer;
    OleObject             : IOleObject;
    PersistStream         : IPersistStreamInit;
    OleControl            : IOleControl;
    ControlDispatch       : IDispatch;
    PropBrowsing          : IPerPropertyBrowsing;
    OleInPlaceObject      : IOleInPlaceObject;
    OleInPlaceActiveObject: IOleInPlaceActiveObject;
    ClientRect            : TRect;
    OleWinEvent           : TOleWinEvent;
    OleWinSite            : TOleWinSite;
    PropConnection        : Integer;
    EventsConnection      : integer;
  end;

implementation

constructor TOleWinSite.Create;
begin
  FillChar(FOleWinSiteData, SizeOf(FOleWinSiteData), 0);
end;

destructor TOleWinSite.Destroy;
begin
  inherited;
end;

function TOleWinSite.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  Result := E_NOINTERFACE;
  if GetInterface(IID, Obj) then
  begin
    Result := S_OK;
  end;
end;

function TOleWinSite._AddRef: Integer; stdcall;
begin
  Result := 1;
end;

function TOleWinSite._Release: Integer; stdcall;
begin
  Result := 1;
end;

{IDispatch}
function TOleWinSite.GetTypeInfoCount(out Count: Integer): HResult; stdcall;
begin
  Count := 0;
  Result := S_OK;
end;

function TOleWinSite.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TOleWinSite.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
begin
  Result := S_OK;
  if Assigned(FOleWinSiteData.OnInvoke) then
  begin
    Result := FOleWinSiteData.OnInvoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr);
  end;
end;

{IOleClientSite}
function TOleWinSite.SaveObject: HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint;
  out mk: IMoniker): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.GetContainer(out container: IOleContainer): HResult; stdcall;
begin
  Result := E_NOINTERFACE;
  Result := S_OK;
  container := Self as IOleContainer;
end;

function TOleWinSite.ShowObject: HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.OnShowWindow(fShow: BOOL): HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.RequestNewObjectLayout: HResult; stdcall;
var
  Extent: TPoint;
begin
  Result := FOleWinSiteData.OleWindow.OleObject.GetExtent(DVASPECT_CONTENT, Extent);
end;

{IOleControlSite}
function TOleWinSite.OnControlInfoChanged: HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.LockInPlaceActive(fLock: BOOL): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.GetExtendedControl(out disp: IDispatch): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.TransformCoords(var ptlHimetric: TPoint; var ptfContainer: TPointF;
  flags: Longint): HResult; stdcall;
begin
//  if flags and XFORMCOORDS_HIMETRICTOCONTAINER <> 0 then
//  begin
//    ptfContainer.X := MulDiv(ptlHimetric.X, ScreenPixelsPerInch, 2540);
//    ptfContainer.Y := MulDiv(ptlHimetric.Y, ScreenPixelsPerInch, 2540);
//  end else
//  begin
//    ptlHimetric.X := Integer(Round(ptfContainer.X * 2540 / ScreenPixelsPerInch));
//    ptlHimetric.Y := Integer(Round(ptfContainer.Y * 2540 / ScreenPixelsPerInch));
//  end;
  Result := S_OK;
end;

function TOleWinSite.IOleControlSite_TranslateAccelerator(msg: PMsg; grfModifiers: Longint): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.OnFocus(fGotFocus: BOOL): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.ShowPropertyFrame: HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

{IOleInPlaceSite.IOleWindow}
function TOleWinSite.GetWindow(out wnd: HWnd): HResult; stdcall;
begin
  wnd := FOleWinSiteData.OleWindow.BaseWnd.WndParent;
  Result := S_OK;
end;

function TOleWinSite.ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall;
begin
  Result := S_OK;
end;

{IOleInPlaceSite}
function TOleWinSite.CanInPlaceActivate: HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.OnInPlaceActivate: HResult; stdcall;
begin
  FOleWinSiteData.OleWindow.OleObject.QueryInterface(IOleInPlaceObject, FOleWinSiteData.OleWindow.OleInPlaceObject);
  FOleWinSiteData.OleWindow.OleObject.QueryInterface(IOleInPlaceActiveObject, FOleWinSiteData.OleWindow.OleInPlaceActiveObject);
  Result := S_OK;
end;

function TOleWinSite.OnUIActivate: HResult; stdcall;
begin
  Result := S_OK;
end;

const
  COleWindowRect: TRect = (Left: 0; Top: 0; Right: 32767; Bottom: 32767);

function TOleWinSite.GetWindowContext(out frame: IOleInPlaceFrame;
  out doc: IOleInPlaceUIWindow; out rcPosRect: TRect;
  out rcClipRect: TRect; out frameInfo: TOleInPlaceFrameInfo): HResult; stdcall;
begin
  frame := Self;
  doc := nil;
  rcPosRect := FOleWinSiteData.OleWindow.ClientRect;
//  dll_user32.SetRect(rcClipRect, 0, 0, OleWindowRect.Right, OleWindowRect.Bottom);
  rcClipRect.Left := 0;
  rcClipRect.Top := 0;
  rcClipRect.Right := COleWindowRect.Right;
  rcClipRect.Bottom := COleWindowRect.Bottom;

  frameInfo.fMDIApp := False;
  frameInfo.hWndFrame := FOleWinSiteData.OleWindow.BaseWnd.WndParent;
  frameInfo.hAccel := 0;
  frameInfo.cAccelEntries := 0;

  Result := S_OK;
end;

function TOleWinSite.Scroll(scrollExtent: TPoint): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.OnUIDeactivate(fUndoable: BOOL): HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.OnInPlaceDeactivate: HResult; stdcall;
begin
  FOleWinSiteData.OleWindow.OleInPlaceActiveObject := nil;
  FOleWinSiteData.OleWindow.OleInPlaceObject := nil;
  Result := S_OK;
end;

function TOleWinSite.DiscardUndoState: HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.DeactivateAndUndo: HResult; stdcall;
begin
  FOleWinSiteData.OleWindow.OleInPlaceObject.UIDeactivate;
  Result := S_OK;
end;

function TOleWinSite.OnPosRectChange(const rcPosRect: TRect): HResult; stdcall;
begin
  FOleWinSiteData.OleWindow.OleInPlaceObject.SetObjectRects(rcPosRect, COleWindowRect);
  Result := S_OK;
end;

{IOleInPlaceFrame.IOleInPlaceUIWindow}
function TOleWinSite.GetBorder(out rectBorder: TRect): HResult; stdcall;
begin
  Result := INPLACE_E_NOTOOLSPACE;
end;

function TOleWinSite.RequestBorderSpace(const borderwidths: TRect): HResult; stdcall;
begin
  Result := INPLACE_E_NOTOOLSPACE;
end;

function TOleWinSite.SetBorderSpace(pborderwidths: PRect): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.SetActiveObject(const activeObject: IOleInPlaceActiveObject;
  pszObjName: POleStr): HResult; stdcall;
begin
  Result := S_OK;
end;

{IOleInPlaceFrame}
function TOleWinSite.InsertMenus(hmenuShared: HMenu;
  var menuWidths: TOleMenuGroupWidths): HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.SetMenu(hmenuShared: HMenu; holemenu: HMenu;
  hwndActiveObject: HWnd): HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.RemoveMenus(hmenuShared: HMenu): HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.SetStatusText(pszStatusText: POleStr): HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.EnableModeless(fEnable: BOOL): HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.IOleInPlaceFrame_TranslateAccelerator(var msg: TMsg; wID: Word): HResult; stdcall;
begin
  Result := S_FALSE;
end;

{IPropertyNotifySink}
function TOleWinSite.OnChanged(dispid: TDispID): HResult; stdcall;
begin
  case dispid of
    DISPID_BACKCOLOR: begin

    end;
    DISPID_ENABLED: begin

    end;
    DISPID_FONT: begin

    end;
    DISPID_FORECOLOR: begin

    end;
  end;
  Result := S_OK;
end;

function TOleWinSite.OnRequestEdit(dispid: TDispID): HResult; stdcall;
begin
  Result := S_OK;
end;

{ISimpleFrameSite}
function TOleWinSite.PreMessageFilter(wnd: HWnd; msg, wp, lp: Integer;
  out res: Integer; out Cookie: Longint): HResult; stdcall;
begin
  Result := S_OK;
end;

function TOleWinSite.PostMessageFilter(wnd: HWnd; msg, wp, lp: Integer;
  out res: Integer; Cookie: Longint): HResult; stdcall;
begin
  Result := S_OK;
end;

{ IOleContainer.IParseDisplayName }
function TOleWinSite.ParseDisplayName(const bc: IBindCtx; pszDisplayName: POleStr;
  out chEaten: Longint; out mkOut: IMoniker): HResult; stdcall;
begin
  Result := E_NOTIMPL
end;  
{ IOleContainer }

function TOleWinSite.EnumObjects(grfFlags: Longint; out Enum: IEnumUnknown): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.LockContainer(fLock: BOOL): HResult; stdcall;
begin           
  Result := E_NOTIMPL;
end;

{IServiceProvider}
function TOleWinSite.QueryService(const rsid, iid: TGuid; out Obj): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinSite.GetOleWindow: POleWindow;
begin
  Result := FOleWinSiteData.OleWindow;
end;

procedure TOleWinSite.SetOleWindow(const Value: POleWindow);
begin
  FOleWinSiteData.OleWindow := Value;
end;

{ TOleWinEvent }

constructor TOleWinEvent.Create;
begin
  FillChar(FOleWinEventData, SizeOf(FOleWinEventData), 0);
end;

destructor TOleWinEvent.Destroy;
begin
  inherited;
end;

function TOleWinEvent.GetOleWindow: POleWindow;
begin
  Result := FOleWinEventData.OleWindow;
end;

procedure TOleWinEvent.SetOleWindow(const Value: POleWindow);
begin
  FOleWinEventData.OleWindow := Value;
end;

{ IUnknown }
function TOleWinEvent.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  Result := E_NOINTERFACE;
  if GetInterface(IID, Obj) then
  begin
    Result := S_OK;
  end;
end;

function TOleWinEvent._AddRef: Integer; stdcall;
begin
  Result := 1;
end;

function TOleWinEvent._Release: Integer; stdcall;
begin
  Result := 1;
end;

{ IDispatch }
function TOleWinEvent.GetTypeInfoCount(out Count: Integer): HResult; stdcall;
begin
  Count := 0;
  Result := S_OK;
end;

function TOleWinEvent.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TOleWinEvent.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
begin
  Result := E_NOTIMPL;
end;

function TOleWinEvent.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
begin
  Result := S_OK;
  if Assigned(FOleWinEventData.OnInvoke) then
  begin
    Result := FOleWinEventData.OnInvoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr);
  end;
end;

end.
