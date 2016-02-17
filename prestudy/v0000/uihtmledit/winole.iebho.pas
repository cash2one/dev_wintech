unit winole.iebho;

interface

uses
  Windows, WinInet, UrlMon, ActiveX;

type
  TIEProtocol = record
    NoteFactory: IClassFactory;
    InternetSession: IInternetSession;
  end;

var
  Protocol: TIEProtocol = (
    NoteFactory: nil;
    InternetSession: nil;
  );

const
  Class_Ie_BHO_ExtProtocol: TGUID = '{5DB72FF4-B996-4EF9-BA07-65A53284FEAA}';

  procedure TemporaryRegister;
  procedure UnRegister;

implementation

type
  TIeSessionClassFactory = class(TObject, IUnknown, IClassFactory)
  protected
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  protected
    { IClassFactory }
    function CreateInstance(const unkOuter: IUnknown; const iid: TIID;
      out obj): HResult; stdcall;
    function LockServer(fLock: BOOL): HResult; stdcall;
  public
  end;

  TIeBHOExtProtocol = class(TObject, IUnknown, ISupportErrorInfo, IInternetProtocol)
  protected
    fUrlMonProtocolSink: IInternetProtocolSink;
    fTotalSize: Integer;
    fWritten: integer;
    fPosition: integer;
  protected
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  protected
    { ISupportErrorInfo }
    function InterfaceSupportsErrorInfo(const iid: TIID): HResult; stdcall;
  protected
    { IInternetProtocolRoot }
    function Start(szUrl: LPCWSTR; OIProtSink: IInternetProtocolSink;
      OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;
    function Continue(const ProtocolData: TProtocolData): HResult; stdcall;
    function Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
    function Terminate(dwOptions: DWORD): HResult; stdcall;
    function Suspend: HResult; stdcall;
    function Resume: HResult; stdcall;
  protected
    { IInternetProtocol }
    function Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult; stdcall;
    function Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD; out libNewPosition: ULARGE_INTEGER): HResult; stdcall;
    function LockRequest(dwOptions: DWORD): HResult; stdcall;
    function UnlockRequest: HResult; stdcall;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  GIeSessionClassFactory: TIeSessionClassFactory = nil;

procedure TemporaryRegister;
var
  NameSpacePattern: array[0..0] of PWideChar;
begin
  NameSpacePattern[0] := PWideChar('http://www.163.com/');
  if Succeeded(CoInternetGetSession(0, Protocol.InternetSession, 0)) then
  begin
    // 处理 maiku:// 相关url
    if Protocol.InternetSession <> nil then
    begin
      if GIeSessionClassFactory = nil then
      begin
        GIeSessionClassFactory := TIeSessionClassFactory.Create;
        Protocol.NoteFactory := GIeSessionClassFactory;//ComClassManager.GetFactoryFromClassID(Class_Ie_BHO_ExtProtocol) as IClassFactory;
      end;
      Protocol.InternetSession.RegisterNameSpace(Protocol.NoteFactory, Class_Ie_BHO_ExtProtocol, 'maiku', 0, nil, 0);
      Protocol.InternetSession.RegisterNameSpace(Protocol.NoteFactory, Class_Ie_BHO_ExtProtocol, 'http', 1, @NameSpacePattern, 0);
    end;
  end;
end;

procedure UnRegister;
begin
  if Protocol.InternetSession <> nil then
  begin
    if Protocol.NoteFactory <> nil then
    begin
      Protocol.InternetSession.UnregisterNameSpace(Protocol.NoteFactory, 'http');
      Protocol.InternetSession.UnregisterNameSpace(Protocol.NoteFactory, 'maiku');
      Protocol.NoteFactory := nil;
    end;
    Protocol.InternetSession := nil;
  end;
end;

    { IUnknown }
function TIeSessionClassFactory.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then
  begin
    Result := S_OK
  end else
  begin
    Result := E_NOINTERFACE;
  end;
end;

function TIeSessionClassFactory._AddRef: Integer; stdcall;
begin
  Result := 1;
end;

function TIeSessionClassFactory._Release: Integer; stdcall;
begin
  Result := 1;
end;
    { IClassFactory }
function TIeSessionClassFactory.CreateInstance(const unkOuter: IUnknown; const iid: TIID; out obj): HResult; stdcall;
var
  bho_obj: TIeBHOExtProtocol;
begin
  // We can't write to a nil pointer.  Duh.
  if @obj = nil then
  begin
    Result := E_POINTER;
    Exit;
  end;
  // In case of failure, make sure we return at least a nil interface.
  Pointer(obj) := nil;
  // Check for licensing.
(*//
  if FSupportsLicensing and
    ((bstrKey <> '') and (not ValidateUserLicense(bstrKey))) or
    ((bstrKey = '') and (not HasMachineLicense)) then
  begin
    Result := CLASS_E_NOTLICENSED;
    Exit;
  end;
//*)
  // We can only aggregate if they are requesting our IUnknown.
  if (unkOuter <> nil) and not (IsEqualIID(iid, IUnknown)) then
  begin
    Result := CLASS_E_NOAGGREGATION;
    Exit;
  end;
  Result := E_UNEXPECTED;
  bho_obj := TIeBHOExtProtocol.Create;
  Result := bho_obj.QueryInterface(IID, obj);
  if Result <> S_OK then
  begin
    bho_obj.Free;
  end;
end;

function TIeSessionClassFactory.LockServer(fLock: BOOL): HResult; stdcall;
begin
  Result := CoLockObjectExternal(Self, fLock, True);
//  Result := S_OK;
end;

constructor TIeBHOExtProtocol.Create;
begin
  inherited;
end;

destructor TIeBHOExtProtocol.Destroy;
begin
  inherited;
end;

    { IUnknown }
function TIeBHOExtProtocol.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then
  begin
    Result := S_OK
  end else
  begin
    Result := E_NOINTERFACE;
  end;
end;

function TIeBHOExtProtocol._AddRef: Integer; stdcall;
begin
  Result := 1;
end;

function TIeBHOExtProtocol._Release: Integer; stdcall;
begin
  Result := 1;
end;

{ ISupportErrorInfo }
function TIeBHOExtProtocol.InterfaceSupportsErrorInfo(const iid: TIID): HResult; stdcall;
begin
  if GetInterfaceEntry(iid) <> nil then
  begin
    Result := S_OK
  end else
  begin
    Result := S_FALSE;
  end;
end;

(*//
var
  OldBeginningTransaction: TBeginningTransaction;

function NewBeginningTransaction(const Intf: IHttpNegotiate;
    szURL, szHeaders: LPCWSTR; dwReserved: DWORD;
    var szAdditionalHeaders: LPWSTR): HResult; stdcall;
var
  S: WideString;
  cbSize: Integer;
begin
  Result := OldBeginningTransaction(Intf, szURL, szHeaders, dwReserved, szAdditionalHeaders);

  if GAuthToken <> '' then
  try
    if TUrls.IsFileServiceUrl(szURL)then
    begin
      S := szAdditionalHeaders;
      if szAdditionalHeaders <> nil then
        CoTaskMemFree(szAdditionalHeaders);

      // 添加认证信息请求头
      s := s + 'auth:' + GAuthToken + sLineBreak;

      // +1 include #0
      cbSize := (Length(S) + 1) * SizeOf(WideChar);
      szAdditionalHeaders := CoTaskMemAlloc(cbSize);
      Move(S[1], szAdditionalHeaders^, cbSize);
    end;
  except
  end;
end;

procedure PatchHttpNegotiate(const Unk: IUnknown);
var
  pSP: IServiceProvider;
  pHN: IHttpNegotiate;
  VAddress: Pointer;
  OldProtect: Cardinal;

begin
  if @OldBeginningTransaction <> nil then
    Exit;

  if Supports(Unk, IServiceProvider, pSP) then
  begin
    if pSP.QueryService(IID_IHttpNegotiate, IID_IHttpNegotiate, pHN) = S_OK then
    begin
      VAddress := Pointer(PCardinal(pHN)^ + (4 - 1) * 4);
      if VirtualProtect(VAddress, 4, PAGE_EXECUTE_READWRITE, OldProtect) then
      begin
        OldBeginningTransaction := PPointer(VAddress)^;
        PCardinal(VAddress)^ := Cardinal(@NewBeginningTransaction);
        VirtualProtect(VAddress, 4, OldProtect, nil);
      end;
    end;
  end;
end;


  PatchHttpNegotiate(OIProtSink);
//*)
{ IInternetProtocolRoot }
function TIeBHOExtProtocol.Start(szUrl: LPCWSTR; OIProtSink: IInternetProtocolSink;
  OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;
var
  MimeType: WideString;
begin
  MimeType := '';
  Result := INET_E_USE_DEFAULT_PROTOCOLHANDLER;
//  Result := S_OK;
  fWritten := 0;
  fTotalSize := 0;
  if Result <> INET_E_USE_DEFAULT_PROTOCOLHANDLER then
  begin
    fUrlMonProtocolSink := OIProtSink as IInternetProtocolSink;
//    MimeType := GetUrlMimeType(sUrl);
    if MimeType <> '' then
    begin
      OIProtSink.ReportProgress(BINDSTATUS_MIMETYPEAVAILABLE, PWideChar(MimeType));
    end;
    OIProtSink.ReportData(BSCF_FIRSTDATANOTIFICATION or BSCF_LASTDATANOTIFICATION or BSCF_DATAFULLYAVAILABLE, fTotalSize, fTotalSize);
  end;
end;

function TIeBHOExtProtocol.Continue(const ProtocolData: TProtocolData): HResult; stdcall;
begin
  Result := Inet_E_Invalid_Request;
end;

function TIeBHOExtProtocol.Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
begin
  Result := Inet_E_Invalid_Request;
  if fUrlMonProtocolSink <> nil then
    fUrlMonProtocolSink.ReportResult(E_ABORT, hrReason, nil);
end;

function TIeBHOExtProtocol.Terminate(dwOptions: DWORD): HResult; stdcall;
begin
  Result := S_OK;
  fUrlMonProtocolSink := nil;
end;

function TIeBHOExtProtocol.Suspend: HResult; stdcall;
begin
  Result := E_NOTIMPL; //Not Implemented by MS
end;

function TIeBHOExtProtocol.Resume: HResult; stdcall;
begin
  Result := E_NOTIMPL; //Not Implemented by MS
end;

{ IInternetProtocol }
function TIeBHOExtProtocol.Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult; stdcall;
begin
  if (fTotalSize > fWritten) then
  begin
//    cbRead := FDataStream.Read(PV^, I);
    if (cbRead = ULONG(-1)) then
    begin
      // 2013 0201 读取失败
      Result := S_FALSE;
      if fUrlMonProtocolSink <> nil then
        fUrlMonProtocolSink.ReportResult(S_OK, 0, nil);
      exit;
    end;
    Inc(fWritten, cbRead);
    {通知IE读取更多的数据 }
    Result := S_OK;
  end else
  begin
    Result := S_FALSE;
    if fUrlMonProtocolSink <> nil then
      fUrlMonProtocolSink.ReportResult(S_OK, 0, nil);
  end;
end;

function TIeBHOExtProtocol.Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD; out libNewPosition: ULARGE_INTEGER): HResult; stdcall;
begin
  fPosition := 0;
  Result := E_Fail;
end;

function TIeBHOExtProtocol.LockRequest(dwOptions: DWORD): HResult; stdcall;
begin
  Result := S_OK;
end;

function TIeBHOExtProtocol.UnlockRequest: HResult; stdcall;
begin
  Result := S_OK;
end;

end.
