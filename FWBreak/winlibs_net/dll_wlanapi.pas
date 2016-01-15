(*
Windows Vista, Windows XP with SP3
Minimum supported server

http://stackoverflow.com/questions/1527418/i-want-to-work-with-wifi-with-delphi-how

You can get to this also by performing a WMI query:

SELECT * FROM MSNdis_80211_ServiceSetIdentifier
WMI
http://social.msdn.microsoft.com/forums/en-US/netfxbcl/thread/967654b4-56d7-4617-8de7-94b47b903a88/

If you are specifically looking for a delphi implementation, there is a WMI library
available from Magenta Systems which includes complete source and may be freely used.
The available download includes a compiled executable where you can try this query
to see if it contains all of the data that you are looking for. The only disadvantage
of this approach is that the WMI service must be running (it normally is so this is
not that big of a problem).

Windows Server 2008
Redistributable

Wireless LAN API for Windows XP with SP2


          1    0 000060CA WlanAllocateMemory
          2    1 00004DCF WlanCloseHandle
          3    2 0000545A WlanConnect
          4    3 00005A8E WlanDeleteProfile
          5    4 00005579 WlanDisconnect
          6    5 00004ED7 WlanEnumInterfaces
          7    6 00006166 WlanExtractPsdIEDataList
          8    7 00006135 WlanFreeMemory
          9    8 0000531D WlanGetAvailableNetworkList
         10    9 0000615B WlanGetFilterList
         11    A 0000615B WlanGetInterfaceCapability
         12    B 00006171 WlanGetNetworkBssList
         13    C 0000592F WlanGetProfile
         14    D 00006166 WlanGetProfileCustomUserData
         15    E 00005CD4 WlanGetProfileList
         16    F 00006187 WlanGetSecuritySettings
         17   10 00006145 WlanIhvControl
         18   11 00004BF5 WlanOpenHandle
         19   12 00006166 WlanQueryAutoConfigParameter
         20   13 000050D6 WlanQueryInterface
         21   14 0000603F WlanReasonCodeToString
         22   15 00005690 WlanRegisterNotification
         23   16 00006187 WlanRenameProfile
         24   17 00006171 WlanSaveTemporaryProfile
         25   18 00005200 WlanScan
         26   19 00006187 WlanSetAutoConfigParameter
         27   1A 0000615B WlanSetFilterList
         28   1B 00005000 WlanSetInterface
         29   1C 000057F6 WlanSetProfile
         30   1D 00006166 WlanSetProfileCustomUserData
         31   1E 00006150 WlanSetProfileEapUserData
         32   1F 00005F15 WlanSetProfileEapXmlUserData
         33   20 00005BAD WlanSetProfileList
         34   21 00005DF3 WlanSetProfilePosition
         35   22 0000615B WlanSetPsdIEDataList
         36   23 0000617C WlanSetSecuritySettings

*)
unit dll_wlanapi;

interface

uses
  atmcmbaseconst, wintype, dll_wlanapi_typconst;

  function WlanOpenHandle(dwClientVersion: DWORD; pReserved: Pointer;
    pdwNegotiatedVersion: PDWORD; phClientHandle: PHANDLE): DWORD; stdcall; external wlanapi;
  function WlanCloseHandle(hClientHandle: THANDLE; pReserved: Pointer): DWORD; stdcall; external wlanapi;
  
  function WlanEnumInterfaces(hClientHandle: THANDLE; pReserved: Pointer;
    var ppInterfaceList: PWLAN_INTERFACE_INFO_LIST): DWORD; stdcall; external wlanapi;
                
  function WlanSetInterface(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; OpCode: TWLAN_INTF_OPCODE;
    dwDataSize: DWORD; const pData: Pointer; pReserved: Pointer): DWORD; stdcall; external wlanapi;

  function WlanQueryInterface(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; OpCode: TWLAN_INTF_OPCODE;
    pReserved: Pointer; pdwDataSize: PDWORD; ppData: PPointer;
    pWlanOpcodeValueType: PWLAN_OPCODE_VALUE_TYPE): DWORD; stdcall; external wlanapi;
                         
  function WlanIhvControl(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; aType: TWLAN_IHV_CONTROL_TYPE;
    dwInBufferSize: DWORD; pInBuffer: Pointer; dwOutBufferSize: DWORD;
    pOutBuffer: Pointer): DWORD; stdcall; external wlanapi;
    
  (* WlanScan: return
    ERROR_INVALID_PARAMETER
    ERROR_INVALID_HANDLE
    RPC_STATUS
    ERROR_NOT_ENOUGH_MEMORY
  *)
  function WlanScan(hClientHandle: THANDLE; pInterfaceGuid: PGUID;
     pDot11Ssid: PDOT11_SSID; pIeData: PWLAN_RAW_DATA; pReserved: Pointer): DWORD; stdcall; external wlanapi;

  function WlanGetNetworkBssList(hClientHandle: THANDLE; pInterfaceGuid: PGUID;
    pDot11Ssid: PDOT11_SSID; dot11BssType: TDOT11_BSS_TYPE;
    bSecurityEnabled: BOOL; pReserved: Pointer; ppWlanBssList: PPWLAN_BSS_LIST): DWORD; stdcall; external wlanapi;

  function WlanGetAvailableNetworkList(hClientHandle: THandle; pInterfaceGuid: PGUID;
    dwFlags: DWORD; pReserved: Pointer; var ppAvailableNetworkList: PWLAN_AVAILABLE_NETWORK_LIST): DWORD; stdcall; external wlanapi;

  function WlanRegisterNotification(hClientHandle: THANDLE;
    dwNotifSource: DWORD; bIgnoreDuplicate: BOOL;
    funcCallback: TWLAN_NOTIFICATION_CALLBACK;
    pCallbackContext: Pointer; pReserved: Pointer;
    pdwPrevNotifSource: PDWORD): DWORD; stdcall; external wlanapi;

  function WlanConnect(hClientHandle: THandle; const pInterfaceGuid: PGUID;
  	const pConnectionParameters: PWLAN_CONNECTION_PARAMETERS;
    pReserved: Pointer): DWORD; stdcall; external wlanapi;

  function WlanDisconnect(hClientHandle: THandle; const pInterfaceGuid: PGUID; pReserved: Pointer): DWORD; stdcall; external wlanapi;


  function WlanGetProfile(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; strProfileName: LPCWSTR;
    pReserved: Pointer; pstrProfileXml: LPWSTR; pdwFlags: PDWORD;
    pdwGrantedAccess: PDWORD): DWORD; stdcall; external	wlanapi;

  function WlanSetProfileEapUserData(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; strProfileName: LPCWSTR;
    eapType: TEAP_METHOD_TYPE; dwFlags: DWORD;
    dwEapUserDataSize: DWORD; const pbEapUserData: PByte;
    pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanSetProfileEapXMLUserData(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; strProfileName: LPCWSTR;
    eapType: TEAP_METHOD_TYPE; dwFlags: DWORD;
    strEapXMLUserData: LPCWSTR; pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanSetProfile(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; dwFlags: DWORD; strProfileXml: LPCWSTR;
    strAllUserProfileSecurity: LPCWSTR;
    bOverwrite: Bool; pReserved: Pointer;
    pdwReasonCode: PDWORD): DWORD; stdcall; external	wlanapi;

  function WlanDeleteProfile(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; strProfileName: LPCWSTR;
    pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanRenameProfile(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; strOldProfileName: LPCWSTR;
    strNewProfileName: LPCWSTR; pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanGetProfileList(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; pReserved: Pointer;
    ppProfileList: PPWLAN_PROFILE_INFO_LIST): DWORD; stdcall; external	wlanapi;

  function WlanSetProfileList(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; dwItems: DWORD;
    strProfileNames: LPCWSTR; pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanSetProfilePosition(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; strProfileName: LPCWSTR;
    dwPosition: DWORD; pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanSetProfileCustomUserData(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; strProfileName: LPCWSTR;
    dwDataSize: DWORD; const pData: PByte;
    pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanGetProfileCustomUserData(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; strProfileName: LPCWSTR;
    pReserved: Pointer; pdwDataSize: PDWORD; ppData: PPByte): DWORD; stdcall; external	wlanapi;

  function WlanSetFilterList(hClientHandle: THandle;
  	wlanFilterListType: TWLAN_FILTER_LIST_TYPE;
    const pNetworkList: PDOT11_NETWORK_LIST;
    pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanGetFilterList(hClientHandle: THandle;
  	wlanFilterListType: TWLAN_FILTER_LIST_TYPE;
    pReserved: Pointer; ppNetworkList: PPDOT11_NETWORK_LIST): DWORD; stdcall; external	wlanapi;

  function WlanSetPsdIEDataList(hClientHandle: THandle; strFormat: LPCWSTR;
    const pPsdIEDataList: PWLAN_RAW_DATA_LIST;
    pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanSaveTemporaryProfile(hClientHandle: THandle;
  	const pInterfaceGuid: PGUID; strProfileName: LPCWSTR;
    strAllUserProfileSecurity: LPCWSTR; dwFlags: DWORD;
    bOverWrite: Bool; pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanExtractPsdIEDataList(hClientHandle: THandle;
  	dwIeDataSize: DWORD; const pRawIeData: PByte;
    strFormat: LPCWSTR; pReserved: Pointer;
    ppPsdIEDataList: PPWLAN_RAW_DATA_LIST): DWORD; stdcall; external	wlanapi;

	function WlanReasonCodeToString(dwReasonCode: DWORD;
  	dwBufferSize: DWORD; pStringBuffer: PWChar;
    pReserved: Pointer): DWORD; stdcall; external	wlanapi;


  function WlanAllocateMemory(dwMemorySize: DWORD): Pointer; stdcall; external	wlanapi;
	function WlanFreeMemory(pMemory: Pointer): Pointer; stdcall; external	wlanapi;
                       
  function WlanSetSecuritySettings(hClientHandle: THandle;
  	SecurableObject: TWLAN_SECURABLE_OBJECT;
    strModifiedSDDL: LPCWSTR): DWORD; stdcall; external	wlanapi;

  function WlanGetSecuritySettings(hClientHandle: THandle;
  	SecurableObject: TWLAN_SECURABLE_OBJECT;
    pstrCurrentSDDL: PLPWSTR; pdwGrantedAccess: PWORD): DWORD; stdcall; external	wlanapi;
                      
  function WlanSetAutoConfigParameter(hClientHandle: THandle;
  	OpCode: TWLAN_AUTOCONF_OPCODE; dwDataSize: DWORD;
    const pData: Pointer; pReserved: Pointer): DWORD; stdcall; external	wlanapi;

  function WlanQueryAutoConfigParameter(hClientHandle: THandle;
  	OpCode: TWLAN_AUTOCONF_OPCODE; pReserved: Pointer;
    pdwDataSize: PDWORD; ppData: PPointer;
    pWlanOpcodeValueType: PWLAN_OPCODE_VALUE_TYPE): DWORD; stdcall; external wlanapi;
                      
  function WlanUIEditProfile(dwClientVersion: DWORD;
  	wstrProfileName: LPCWSTR; pInterfaceGuid: PGUID;
    hWnd: HWND; wlStartPage: TWL_DISPLAY_PAGES;
    pReserved: Pointer; pWlanReasonCode: PWLAN_REASON_CODE): DWORD; stdcall; external	wlanui;

  // window7 support
  // WlanHostedNetworkSetSecondaryKey
  
implementation

end.