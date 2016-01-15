unit dll_mpr;

interface
                     
uses
  atmcmbaseconst, winconst, wintype;

const
  mpr     = 'mpr.dll';
  
{ Externals from mpr.dll }


const
  WNCON_FORNETCARD = 1;
  WNCON_NOTROUTED = 2;
  WNCON_SLOWLINK = 4;
  WNCON_DYNAMIC = 8;

type
  PNetResource = ^TNetResource;
  TNetResource = packed record
    dwScope: DWORD;
    dwType: DWORD;
    dwDisplayType: DWORD;
    dwUsage: DWORD;
    lpLocalName: PAnsiChar;
    lpRemoteName: PAnsiChar;
    lpComment: PAnsiChar;
    lpProvider: PAnsiChar;
  end;
                    
{ For Shell }
  PNetConnectInfoStruct = ^TNetConnectInfoStruct;
  _NETCONNECTINFOSTRUCT = packed record
    cbStructure: DWORD;
    dwFlags: DWORD;
    dwSpeed: DWORD;
    dwDelay: DWORD;
    dwOptDataSize: DWORD;
  end;
  TNetConnectInfoStruct = _NETCONNECTINFOSTRUCT;
  NETCONNECTINFOSTRUCT = _NETCONNECTINFOSTRUCT;
                      
  PConnectDlgStruct = ^TConnectDlgStruct;
  TConnectDlgStruct = packed record
    cbStructure: DWORD;          { size of this structure in bytes }
    hwndOwner: HWND;             { owner window for the dialog }
    lpConnRes: PNetResource;     { Requested Resource info    }
    dwFlags: DWORD;              { flags (see below) }
    dwDevNum: DWORD;             { number of devices connected to }
  end;
                      
  PDiscDlgStruct = ^TDiscDlgStruct;
  TDiscDlgStruct = packed record
    cbStructure: DWORD;       { size of this structure in bytes }
    hwndOwner: HWND;          { owner window for the dialog }
    lpLocalName: PAnsiChar;       { local device name }
    lpRemoteName: PAnsiChar;      { network resource name }
    dwFlags: DWORD;
  end;
                  
  PNetInfoStruct = ^TNetInfoStruct;
  TNetInfoStruct = record
    cbStructure: DWORD;
    dwProviderVersion: DWORD;
    dwStatus: DWORD;
    dwCharacteristics: DWORD;
    dwHandle: DWORD;
    wNetType: Word;
    dwPrinters: DWORD;
    dwDrives: DWORD;
  end;

function MultinetGetConnectionPerformance(lpNetResource: PNetResource;
  lpNetConnectInfoStruc: PNetConnectInfoStruct): DWORD; stdcall; external mpr name 'MultinetGetConnectionPerformanceA';
function WNetAddConnection2(var lpNetResource: TNetResource;
  lpPassword, lpUserName: PAnsiChar; dwFlags: DWORD): DWORD; stdcall; external mpr name 'WNetAddConnection2A';
function WNetAddConnection3(hwndOwner: HWND; var lpNetResource: TNetResource;
  lpPassword, lpUserName: PAnsiChar; dwFlags: DWORD): DWORD; stdcall; external mpr name 'WNetAddConnection3A';
function WNetAddConnection(lpRemoteName, lpPassword, lpLocalName: PAnsiChar): DWORD; stdcall; external mpr name 'WNetAddConnectionA';
function WNetCancelConnection2(lpName: PAnsiChar; dwFlags: DWORD; fForce: BOOL): DWORD; stdcall; external mpr name 'WNetCancelConnection2A';
function WNetCancelConnection(lpName: PAnsiChar; fForce: BOOL): DWORD; stdcall; external mpr name 'WNetCancelConnectionA';
function WNetCloseEnum(hEnum: THandle): DWORD; stdcall; external mpr name 'WNetCloseEnum';
function WNetConnectionDialog1(var lpConnDlgStruct: TConnectDlgStruct): DWORD; stdcall; external mpr name 'WNetConnectionDialog1A';
function WNetConnectionDialog(hwnd: HWND; dwType: DWORD): DWORD; stdcall; external mpr name 'WNetConnectionDialog';
function WNetDisconnectDialog1(var lpConnDlgStruct: TDiscDlgStruct): DWORD; stdcall; external mpr name 'WNetDisconnectDialog1A';
function WNetDisconnectDialog(hwnd: HWND; dwType: DWORD): DWORD; stdcall; external mpr name 'WNetDisconnectDialog';
function WNetEnumResource(hEnum: THandle; var lpcCount: DWORD;
  lpBuffer: Pointer; var lpBufferSize: DWORD): DWORD; stdcall; external mpr name 'WNetEnumResourceA';
function WNetGetConnection(lpLocalName: PAnsiChar;
  lpRemoteName: PAnsiChar; var lpnLength: DWORD): DWORD; stdcall; external mpr name 'WNetGetConnectionA';
function WNetGetLastError(var lpError: DWORD; lpErrorBuf: PAnsiChar;
  nErrorBufSize: DWORD; lpNameBuf: PAnsiChar; nNameBufSize: DWORD): DWORD; stdcall; external mpr name 'WNetGetLastErrorA';
function WNetGetNetworkInformation(lpProvider: PAnsiChar;
  var lpNetInfoStruct: TNetInfoStruct): DWORD; stdcall; external mpr name 'WNetGetNetworkInformationA';
function WNetGetProviderName(dwNetType: DWORD; lpProviderName: PAnsiChar;
  var lpBufferSize: DWORD): DWORD; stdcall; external mpr name 'WNetGetProviderNameA';
function WNetGetResourceParent(lpNetResource: PNetResource;
  lpBuffer: Pointer; var cbBuffer: DWORD): DWORD; stdcall; external mpr name 'WNetGetResourceParentA';
function WNetGetUniversalName(lpLocalPath: PAnsiChar; dwInfoLevel: DWORD;
  lpBuffer: Pointer; var lpBufferSize: DWORD): DWORD; stdcall; external mpr name 'WNetGetUniversalNameA';
function WNetGetUser(lpName: PAnsiChar; lpUserName: PAnsiChar; var lpnLength: DWORD): DWORD; stdcall; external mpr name 'WNetGetUserA';
function WNetOpenEnum(dwScope, dwType, dwUsage: DWORD;
  lpNetResource: PNetResource; var lphEnum: THandle): DWORD; stdcall; external mpr name 'WNetOpenEnumA';
function WNetSetConnection(lpName: PAnsiChar; dwProperties: DWORD; pvValues: Pointer): DWORD; stdcall; external mpr name 'WNetSetConnectionA';
function WNetUseConnection(hwndOwner: HWND;
  var lpNetResource: TNetResource; lpUserID: PAnsiChar;
  lpPassword: PAnsiChar; dwFlags: DWORD; lpAccessName: PAnsiChar;
  var lpBufferSize: DWORD; var lpResult: DWORD): DWORD; stdcall; external mpr name 'WNetUseConnectionA';

implementation

end.
