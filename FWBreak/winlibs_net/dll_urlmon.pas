(*
        109    0 00076B4D AsyncGetClassBits
        110    1 000765A9 AsyncInstallDistributionUnit
        117    2 0006194D BindAsyncMoniker
        118    3 00076BA5 CDLGetLongPathNameA
        119    4 00076BC2 CDLGetLongPathNameW
        120    5 00076787 CoGetClassObjectFromURL
        121    6 00074075 CoInstall
        122    7 00005483 CoInternetCanonicalizeIUri
        123    8 0000B236 CoInternetCombineIUri
        124    9 0001AABD CoInternetCombineUrl
        125    A 0001A9D1 CoInternetCombineUrlEx
        126    B 000637F4 CoInternetCompareUrl
        127    C 00021D25 CoInternetCreateSecurityManager
        128    D 000152CD CoInternetCreateZoneManager
        129    E 00096A42 CoInternetFeatureSettingsChanged
        130    F 000A19AD CoInternetGetProtocolFlags
        131   10 00063CAA CoInternetGetSecurityUrl
        132   11 0000FF76 CoInternetGetSecurityUrlEx
        133   12 00010A3E CoInternetGetSession
        134   13 00003211 CoInternetIsFeatureEnabled
        135   14 000196B6 CoInternetIsFeatureEnabledForIUri
        136   15 00028B60 CoInternetIsFeatureEnabledForUrl
        137   16 00039EA7 CoInternetIsFeatureZoneElevationEnabled
        138   17 0000BC5C CoInternetParseIUri
        139   18 0001A931 CoInternetParseUrl
        140   19 0000AFF5 CoInternetQueryInfo
        141   1A 0003837C CoInternetSetFeatureEnabled
        142   1B 0003278F CompareSecurityIds
        143   1C 0001CD62 CompatFlagsFromClsid
        144   1D 000125ED CopyBindInfo
        145   1E 000126A6 CopyStgMedium
        146   1F 0003D898 CreateAsyncBindCtx
        147   20 0002FC7A CreateAsyncBindCtxEx
        148   21 000316DB CreateFormatEnumerator
        149   22 000186D8 CreateIUriBuilder
        150   23 00012981 CreateURLMoniker
        152   24 000123DD CreateURLMonikerEx
        151   25 0000527E CreateURLMonikerEx2
        153   26 00003940 CreateUri
        154   27 000705C3 CreateUriFromMultiByteString
        155   28 00003988 CreateUriPriv
        156   29 00003961 CreateUriWithFragment
        157   2A 00001AE8 DllCanUnloadNow
        158   2B 00021243 DllGetClassObject
        159   2C 00061CD0 DllInstall
        160   2D 000619D3 DllRegisterServer
        161   2E 00061CC5 DllRegisterServerEx
        162   2F 00061B5D DllUnregisterServer
        163   30 000771BE Extract
        164   31 0003C3A8 FaultInIEFeature
        165   32 00007F89 FindMediaType
        166   33 00031662 FindMediaTypeClass
        167   34 00032B87 FindMimeFromData
        168   35 00097362 GetAddSitesFileUrl
        169   36 00064641 GetClassFileOrMime
        170   37 000BC5FD GetClassURL
        171   38 00077CA0 GetComponentIDFromCLSSPEC
        172   39 0002887F GetIDNFlagsForUri
        173   3A 00003FA8 GetIUriPriv
        174   3B 000A56DC GetLabelsFromNamedHost
        175   3C 0009ADDC GetMarkOfTheWeb
        176   3D 00022AD7 GetPortFromUrlScheme
        177   3E 000721ED GetPropertyFromName
        178   3F 000720F6 GetPropertyName
        179   40 0007B832 GetSoftwareUpdateInfo
        180   41 000650F1 GetUrlmonThreadNotificationHwnd
        181   42 00092F17 HlinkGoBack
        182   43 00092F95 HlinkGoForward
        183   44 000943E9 HlinkNavigateMoniker
        184   45 0009446D HlinkNavigateString
        185   46 00093E1D HlinkSimpleNavigateToMoniker
        186   47 0009440A HlinkSimpleNavigateToString
        187   48 00074065 IEInstallScope
        188   49 00061DA4 InstallFlash
        189   4A 00033A55 IntlPercentEncodeNormalize
        190   4B 0002FF38 IsAsyncMoniker
        191   4C 00003E4D IsDWORDProperty
        192   4D 00096157 IsIntranetAvailable
        193   4E 000BC736 IsJITInProgress
        194   4F 00094BEA IsLoggingEnabledA
        195   50 00094D13 IsLoggingEnabledW
        196   51 0000B0CD IsStringProperty
        197   52 000633AB IsValidURL
        198   53 000617FA MkParseDisplayNameEx
        199   54 00034665 ObtainUserAgentString
        200   55 000766A1 PrivateCoInstall
        201   56 0001F4C2 QueryAssociations
        202   57 0006D539 QueryClsidAssociation
        203   58 00006B86 RegisterBindStatusCallback
        204   59 0002FD6F RegisterFormatEnumerator
        205   5A 00061738 RegisterMediaTypeClass
        206   5B 000616E0 RegisterMediaTypes
        207   5C 000049EB ReleaseBindInfo
        208   5D 000619C4 ResetUrlmonLanguageData
        209   5E 0000BB0B RevokeBindStatusCallback
        210   5F 000617D5 RevokeFormatEnumerator
        211   60 0007B896 SetSoftwareUpdateAdvertisementState
        212   61 00068911 ShouldDisplayPunycodeForUri
        213   62 0001AF58 ShouldShowIntranetWarningSecband
        214   63 00096E8D ShowTrustAlertDialog
        215   64 00063C78 URLDownloadA
        216   65 0009495B URLDownloadToCacheFileA
        217   66 0002E3AE URLDownloadToCacheFileW
        218   67 00094840 URLDownloadToFileA
        219   68 00039CAC URLDownloadToFileW
        220   69 00063613 URLDownloadW
        221   6A 00094AA1 URLOpenBlockingStreamA
        222   6B 0001F81F URLOpenBlockingStreamW
        223   6C 000947A3 URLOpenPullStreamA
        224   6D 0009470F URLOpenPullStreamW
        225   6E 00094B4D URLOpenStreamA
        226   6F 00094759 URLOpenStreamW
        227   70 00061CE0 UrlMkBuildVersion
        228   71 00028C7D UrlMkGetSessionOption
        229   72 00063A9C UrlMkSetSessionOption
        230   73 00094C56 WriteHitLogging
        231   74 0009A8F0 ZonesReInit
*)
unit dll_urlmon;

interface

uses
  atmcmbaseconst, wintype,
  Intf_Ole32, Intf_oledata, Intf_UrlMon;

const
  UrlMon = 'URLMON.DLL';

type
  TParseAction = ULONG;
  TPSUAction = ULONG;
  TQueryOption = ULONG;

  function CoInternetGetSession(dwSessionMode: DWORD; var pIInternetSession: IInternetSession;
    dwReserved: DWORD): HResult; stdcall; external UrlMon name 'CoInternetGetSession';
  function CreateURLMoniker(MkCtx: IMoniker;
    szURL: LPCWSTR; out mk: IMoniker): HResult; stdcall; external UrlMon;
  function CreateURLMonikerEx(MkCtx: IMoniker; szURL: LPCWSTR;
    out mk: IMoniker; dwFlags: DWORD): HRESULT; stdcall; external UrlMon;
  function GetClassURL(szURL: LPCWSTR; const ClsID: TCLSID):
    HResult; stdcall; external UrlMon name 'GetClassURL';

  function CreateAsyncBindCtx(reserved: DWORD; pBSCb: IBindStatusCallback;
    pEFetc: IEnumFORMATETC;
    out ppBC: IBindCtx): HResult; stdcall; external UrlMon name 'CreateAsyncBindCtx';

  function CreateAsyncBindCtxEx(pbc: IBindCtx; dwOptions: DWORD;
    BSCb: IBindStatusCallback; Enum: IEnumFORMATETC;
    out ppBC: IBindCtx; reserved: DWORD): HResult; stdcall; external UrlMon name 'CreateAsyncBindCtxEx';

  function MkParseDisplayNameEx(pbc: IBindCtx; szDisplayName: LPCWSTR;
    out pchEaten: ULONG;
    out ppmk: IMoniker): HResult; stdcall; external UrlMon name 'MkParseDisplayNameEx';

  function RegisterBindStatusCallback(pBC: IBindCtx; pBSCb: IBindStatusCallback;
    out ppBSCBPrev: IBindStatusCallback;
    dwReserved: DWORD): HResult; stdcall; external UrlMon name 'RegisterBindStatusCallback';

  function RevokeBindStatusCallback(pBC: IBindCtx;
    pBSCb: IBindStatusCallback): HResult; stdcall; external UrlMon name 'RevokeBindStatusCallback';

  function GetClassFileOrMime(pBC: IBindCtx; szFilename: LPCWSTR;
    pBuffer: Pointer; cbSize: DWORD;
    szMime: LPCWSTR; dwReserved: DWORD;
    out pclsid: TCLSID): HResult; stdcall; external UrlMon name 'GetClassFileOrMime';

  function IsValidURL(pBC: IBindCtx; szURL: LPCWSTR;
    dwReserved: DWORD): HResult; stdcall; external UrlMon name 'IsValidURL';

  function CoGetClassObjectFromURL(const rCLASSID: TCLSID; szCODE: LPCWSTR;
    dwFileVersionMS, dwFileVersionLS: DWORD; szTYPE: LPCWSTR;
    pBindCtx: IBindCtx; dwClsContext: DWORD;
    pvReserved: Pointer; const riid: TGUID;
    out ppv): HResult; stdcall; external UrlMon name 'CoGetClassObjectFromURL';

  function IsAsyncMoniker(pmk: IMoniker): HResult; stdcall; external UrlMon name 'IsAsyncMoniker';

  function CreateURLBinding(lpszUrl: LPCWSTR; pbc: IBindCtx;
    out ppBdg: IBinding): HResult; stdcall; external UrlMon name 'CreateURLBinding';

  function ObtainUserAgentString(dwOption: DWORD; pszUAOut: LPSTR;
    var cbSize: DWORD): HResult; stdcall; external UrlMon name 'ObtainUserAgentString';

  function URLOpenStreamW(p1: IUnknown; p2: LPCWSTR; p3: DWORD;
    p4: IBindStatusCallback): HResult; stdcall; external UrlMon name 'URLOpenStreamW';

  function URLOpenPullStreamW(p1: IUnknown; p2: LPCWSTR; p3: DWORD;
    BSC: IBindStatusCallback): HResult; stdcall; external UrlMon name 'URLOpenPullStreamW';

  function URLDownloadToFileW(Caller: IUnknown; URL: LPCWSTR;
    FileName: LPCWSTR; Reserved: DWORD;
    StatusCB: IBindStatusCallback): HResult; stdcall; external UrlMon name 'URLDownloadToFileW';

  function URLDownloadToCacheFileW(p1: IUnknown; p2: LPCWSTR;
    p3: LPCWSTR; p4: DWORD; p5: DWORD;
    p6: IBindStatusCallback): HResult; stdcall; external UrlMon name 'URLDownloadToCacheFileW';

  function URLOpenBlockingStreamW(p1: IUnknown;
    p2: LPCWSTR; out p3: IStream; p4: DWORD;
    p5: IBindStatusCallback): HResult; stdcall; external UrlMon name 'URLOpenBlockingStreamW';

  function CoInternetParseUrl(pwzUrl: LPCWSTR; ParseAction: TParseAction;
    dwFlags: DWORD; pszResult: LPWSTR; cchResult: DWORD; var pcchResult: DWORD;
    dwReserved: DWORD): HResult; stdcall; external UrlMon name 'CoInternetParseUrl';
  function CoInternetCombineUrl(pwzBaseUrl, pwzRelativeUrl: LPCWSTR;
    dwCombineFlags: DWORD; pszResult: LPWSTR; cchResult: DWORD;
    var pcchResult: DWORD; dwReserved: DWORD): HResult ; stdcall; external UrlMon name 'CoInternetCombineUrl';
  function CoInternetCompareUrl(pwzUrl1, pwzUrl2: LPCWSTR;
    dwFlags: DWORD): HResult; stdcall; external UrlMon name 'CoInternetCompareUrl';
  function CoInternetGetProtocolFlags(pwzUrl: LPCWSTR; var dwFlags: DWORD;
    dwReserved: DWORD): HResult; stdcall; external UrlMon name 'CoInternetGetProtocolFlags';
  function CoInternetQueryInfo(pwzUrl: LPCWSTR; QueryOptions: TQueryOption; dwQueryFlags: DWORD;
    pvBuffer: Pointer; cbBuffer: DWORD; var pcbBuffer: DWORD;
    dwReserved: DWORD): HResult; stdcall; external UrlMon name 'CoInternetQueryInfo';
//  function CoInternetGetSession;            external UrlMon name 'CoInternetGetSession';
  function CoInternetGetSecurityUrl(pwzUrl: LPCWSTR;
    var pwzSecUrl: LPWSTR; psuAction: TPSUAction;
    dwReserved: DWORD): HResult; stdcall;external UrlMon name 'CoInternetGetSecurityUrl';
  function CopyStgMedium(const cstgmedSrc: TStgMedium;
    var stgmedDest: TStgMedium): HResult; stdcall; external UrlMon name 'CopyStgMedium';
  function CopyBindInfo(const cbiSrc: TBindInfo;
    var biDest: TBindInfo): HResult; stdcall; external UrlMon name 'CopyBindInfo';
  procedure ReleaseBindInfo(const bindinfo: TBindInfo); stdcall; external UrlMon name 'ReleaseBindInfo';
  function CoInternetCreateSecurityManager(SP: IServiceProvider;
    var SM: IInternetSecurityManager;
    dwReserved: DWORD): HResult; stdcall; external UrlMon name 'CoInternetCreateSecurityManager';
  function CoInternetCreateZoneManager(SP: IServiceProvider;
    var ZM: IInternetZoneManager;
    dwReserved: DWORD): HResult; stdcall; external UrlMon name 'CoInternetCreateZoneManager';

implementation

end.