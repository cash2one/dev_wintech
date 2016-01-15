unit dll_wlanapi_typconst;

interface

uses
  atmcmbaseconst, wintype;
              
const
  wlanapi                   = 'wlanapi.dll';
  wlanui                    = 'Wlanui.dll';
  
  DOT11_SSID_MAX_LENGTH     = 32;
  DOT11_RATE_SET_MAX_LENGTH = 126;
  WLAN_MAX_PHY_TYPE_NUMBER  = 8;
  WLAN_MAX_NAME_LENGTH      = 256;
                                       
	WLAN_UI_API_VERSION 					= 1;
  WLAN_UI_API_INITIAL_VERSION		= 1;

  WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES         = $00000001;
  WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_MANUAL_HIDDEN_PROFILES = $00000002;
  
  WLAN_AVAILABLE_NETWORK_CONNECTED 		= $00000001;
  WLAN_AVAILABLE_NETWORK_HAS_PROFILE 	= $00000002;
                               
	WLAN_CONNECTION_HIDDEN_NETWORK 		  = $00000001;
  WLAN_CONNECTION_ADHOC_JOIN_ONLY 	  = $00000002;
  WLAN_CONNECTION_IGNORE_PRIVACY_BIT  = $00000004;
  WLAN_CONNECTION_EAPOL_PASSTHROUGH   = $00000008;
                                          
  WLAN_PROFILE_GROUP_POLICY		        = $00000001;
  WLAN_PROFILE_USER						        = $00000002;

  WLAN_SET_EAPHOST_DATA_ALL_USERS     = $00000001;
  

type                   
  PPByte						= ^PByte;					///C PPByte
  ///
  {$MINENUMSIZE 4}
  TDOT11_PHY_TYPE = (
    dot11_phy_type_unknown      = 0,
    dot11_phy_type_any          = 0,
    dot11_phy_type_fhss         = 1,
    dot11_phy_type_dsss         = 2,
    dot11_phy_type_irbaseband   = 3,
    dot11_phy_type_ofdm         = 4,
    dot11_phy_type_hrdsss       = 5,
    dot11_phy_type_erp          = 6,
    dot11_phy_type_ht           = 7,
    dot11_phy_type_IHV_start    = $80000000,
    dot11_phy_type_IHV_end      = $ffffffff
  );

  TDOT11_BSS_TYPE = (
    dot11_BSS_type_infrastructure     = 1,
    dot11_BSS_type_independent        = 2,
    dot11_BSS_type_any                = 3
  );
                                 
  {$MINENUMSIZE 4}
  TDOT11_AUTH_ALGORITHM = (
    DOT11_AUTH_ALGO_80211_OPEN        = 1,
    DOT11_AUTH_ALGO_80211_SHARED_KEY  = 2,
    DOT11_AUTH_ALGO_WPA               = 3,
    DOT11_AUTH_ALGO_WPA_PSK           = 4,
    DOT11_AUTH_ALGO_WPA_NONE          = 5,
    DOT11_AUTH_ALGO_RSNA              = 6,
    DOT11_AUTH_ALGO_RSNA_PSK          = 7,
    DOT11_AUTH_ALGO_IHV_START         = $80000000,
    DOT11_AUTH_ALGO_IHV_END           = $ffffffff
  );
                             
	{$MINENUMSIZE 4}
  TDOT11_CIPHER_ALGORITHM = (
    DOT11_CIPHER_ALGO_NONE            = $00,
    DOT11_CIPHER_ALGO_WEP40           = $01,
    DOT11_CIPHER_ALGO_TKIP            = $02,
    DOT11_CIPHER_ALGO_CCMP            = $04,
    DOT11_CIPHER_ALGO_WEP104          = $05,
    DOT11_CIPHER_ALGO_WPA_USE_GROUP   = $100,
    DOT11_CIPHER_ALGO_RSN_USE_GROUP   = $100,
    DOT11_CIPHER_ALGO_WEP             = $101,
    DOT11_CIPHER_ALGO_IHV_START       = $80000000,
    DOT11_CIPHER_ALGO_IHV_END         = $ffffffff
  );
                   
  {$MINENUMSIZE 4}
  PWLAN_OPCODE_VALUE_TYPE = ^TWLAN_OPCODE_VALUE_TYPE;
  TWLAN_OPCODE_VALUE_TYPE = (
  	wlan_opcode_value_type_query_only = 0,
    wlan_opcode_value_type_set_by_group_policy,
    wlan_opcode_value_type_set_by_user,
    wlan_opcode_value_type_invalid);
                             
  {$MINENUMSIZE 4}
  PWLAN_INTF_OPCODE = ^TWLAN_INTF_OPCODE;
  TWLAN_INTF_OPCODE = (
  	wlan_intf_opcode_autoconf_start = $000000000,
    wlan_intf_opcode_autoconf_enabled,
    wlan_intf_opcode_background_scan_enabled,
    wlan_intf_opcode_media_streaming_mode,
    wlan_intf_opcode_radio_state,
    wlan_intf_opcode_bss_type,
    wlan_intf_opcode_interface_state,
    wlan_intf_opcode_current_connection,
    wlan_intf_opcode_channel_number,
    wlan_intf_opcode_supported_infrastructure_auth_cipher_pairs,
    wlan_intf_opcode_supported_adhoc_auth_cipher_pairs,
    wlan_intf_opcode_supported_country_or_region_string_list,
    wlan_intf_opcode_autoconf_end = $0fffffff,
    wlan_intf_opcode_msm_start = $10000100,
    wlan_intf_opcode_statistics,
    wlan_intf_opcode_rssi,
    wlan_intf_opcode_msm_end = $1fffffff,
    wlan_intf_opcode_security_start = $20010000,
    wlan_intf_opcode_security_end = $2fffffff,
    wlan_intf_opcode_ihv_start = $30000000,
    wlan_intf_opcode_ihv_end = $3fffffff);

  {$MINENUMSIZE 4}
  TWLAN_INTERFACE_STATE = (
    wlan_interface_state_not_ready               = 0,
    wlan_interface_state_connected               = 1,
    wlan_interface_state_ad_hoc_network_formed   = 2,
    wlan_interface_state_disconnecting           = 3,
    wlan_interface_state_disconnected            = 4,
    wlan_interface_state_associating             = 5,
    wlan_interface_state_discovering             = 6,
    wlan_interface_state_authenticating          = 7
  );
                    
  {$MINENUMSIZE 4}       
  PWLAN_CONNECTION_MODE = ^TWLAN_CONNECTION_MODE;
  TWLAN_CONNECTION_MODE = (
    wlan_connection_mode_profile,
    wlan_connection_mode_temporary_profile,
    wlan_connection_mode_discovery_secure,
    wlan_connection_mode_discovery_unsecure,
    wlan_connection_mode_auto,
    wlan_connection_mode_invalid
  );
               
  {$MINENUMSIZE 4}
  PWLAN_AUTOCONF_OPCODE = ^TWLAN_AUTOCONF_OPCODE;
  TWLAN_AUTOCONF_OPCODE = (
  	wlan_autoconf_opcode_start = 0,
    wlan_autoconf_opcode_show_denied_networks,
    wlan_autoconf_opcode_power_setting,
    wlan_autoconf_opcode_connect_with_all_user_profile_only,
    wlan_autoconf_opcode_end);

  {$MINENUMSIZE 4}
  PWLAN_IHV_CONTROL_TYPE = ^TWLAN_IHV_CONTROL_TYPE;
  TWLAN_IHV_CONTROL_TYPE = (
  	wlan_ihv_control_type_service,
    wlan_ihv_control_type_driver);

  {$MINENUMSIZE 4}
  PWLAN_FILTER_LIST_TYPE = ^TWLAN_FILTER_LIST_TYPE;
  TWLAN_FILTER_LIST_TYPE = (
  	wlan_filter_list_type_gp_permit,
    wlan_filter_list_type_gp_deny,
    wlan_filter_list_type_user_permit,
    wlan_filter_list_type_user_deny);

	{$MINENUMSIZE 4}
	PWLAN_SECURABLE_OBJECT = ^TWLAN_SECURABLE_OBJECT;
  TWLAN_SECURABLE_OBJECT = (
  	wlan_secure_permit_list = 0,
    wlan_secure_deny_list,
    wlan_secure_ac_enabled,
    wlan_secure_bc_scan_enabled,
    wlan_secure_bss_type,
    wlan_secure_show_denied,
    wlan_secure_interface_properties,
    wlan_secure_ihv_control,
    wlan_secure_all_user_profiles_order,
    wlan_secure_sso,
    wlan_secure_add_new_all_user_profiles,
    wlan_secure_add_new_per_user_profiles,
    wlan_secure_manual_connect_single_user,
    wlan_secure_manual_connect_multi_user,
    wlan_secure_media_streaming_mode_enabled,
    WLAN_SECURABLE_OBJECT_COUNT);

	PNDIS_OBJECT_HEADER   = ^TNDIS_OBJECT_HEADER;
  TNDIS_OBJECT_HEADER   = packed record
  	aType               : uchar;
    Revision            : uchar;
    Size                : Word;
  end;
                            
  PDOT11_MAC_ADDRESS    = ^TDOT11_MAC_ADDRESS;
  TDOT11_MAC_ADDRESS    = array[0..5] of UCHAR;

  PDOT11_BSSID_LIST     = ^TDOT11_BSSID_LIST;
  TDOT11_BSSID_LIST     = record
  	//const NDU_DOT11_  BSSID_LIST_REVISION_1 = 1;
    Header              : TNDIS_OBJECT_HEADER;
    uNumOfEntries       : Cardinal;
    uTotalNumOfEntries  : Cardinal;
    BSSIDs              : array[0..0] of TDOT11_MAC_ADDRESS;
  end;
                                  
  PDOT11_SSID           = ^TDOT11_SSID;
  TDOT11_SSID           = record
    uSSIDLength         : Cardinal;
    ucSSID              : array[0..DOT11_SSID_MAX_LENGTH - 1] of UCHAR;
  end;

  PDOT11_NETWORK        = ^TDOT11_NETWORK;
  TDOT11_NETWORK        = record
  	dot11Ssid           : TDOT11_SSID;
    dot11BssType        : TDOT11_BSS_TYPE;
  end;

  PDOT11_NETWORK_LIST   = ^TDOT11_NETWORK_LIST;
  PPDOT11_NETWORK_LIST  = ^PDOT11_NETWORK_LIST;
  TDOT11_NETWORK_LIST   = record
  	dwNumberOfItems     : DWORD;
    dwIndex             : DWORD;
    Network             : array[0..0] of TDOT11_NETWORK;
  end;

  PWLAN_INTERFACE_INFO  = ^TWLAN_INTERFACE_INFO;
  TWLAN_INTERFACE_INFO  = record
    InterfaceGuid       : TGUID;
    strInterfaceDesc    : array[0..255] of WCHAR;
    isState             : TWLAN_INTERFACE_STATE;
  end;

  PWLAN_INTERFACE_INFO_LIST = ^TWLAN_INTERFACE_INFO_LIST;
  TWLAN_INTERFACE_INFO_LIST = record
    dwNumberOfItems     : DWORD;
    dwIndex             : DWORD;
    InterfaceInfo       : array[0..0] of TWLAN_INTERFACE_INFO;
  end;

  PWLAN_RAW_DATA        = ^TWLAN_RAW_DATA;
  TWLAN_RAW_DATA        = record
    dwDataSize          : DWORD;
    DataBlob            : array [0..0] of BYTE;
  end;
                           
  PWLAN_RAW_DATA_LIST   = ^TWLAN_RAW_DATA_LIST;
  PPWLAN_RAW_DATA_LIST  = ^PWLAN_RAW_DATA_LIST;
  TWLAN_RAW_DATA_LIST   = record
  	dwTotalSize         : DWORD;
    dwNumberOfItems     : DWORD;
    case Integer of
    	0: (dwDataOffset  : DWORD);
      1: (dwDataSize    : DWORD);
  end;

  PWLAN_RATE_SET        = ^TWLAN_RATE_SET;
  TWLAN_RATE_SET        = record
    uRateSetLength      : Cardinal;
    usRateSet           : array [0..DOT11_RATE_SET_MAX_LENGTH - 1] of UChar; //USHORT;
  end;

  TWLAN_ASSOCIATION_ATTRIBUTES = record
    dot11Ssid           : TDOT11_SSID;
    dot11BssType        : TDOT11_BSS_TYPE;
    dot11Bssid          : TDOT11_MAC_ADDRESS;
    dot11PhyType        : TDOT11_PHY_TYPE;
    uDot11PhyIndex      : Cardinal;
    wlanSignalQuality   : Cardinal; //TWLAN_SIGNAL_QUALITY;
    ulRxRate            : Cardinal;
    ulTxRate            : Cardinal;
  end;

  TWLAN_SECURITY_ATTRIBUTES = record
    bSecurityEnabled    : BOOL;
    bOneXEnabled        : BOOL;
    dot11AuthAlgorithm  : TDOT11_AUTH_ALGORITHM;
    dot11CipherAlgorithm: TDOT11_CIPHER_ALGORITHM;
  end;

  PWLAN_BSS_ENTRY       = ^TWLAN_BSS_ENTRY;
  TWLAN_BSS_ENTRY       = record
    dot11Ssid           : TDOT11_SSID;
    uPhyId              : Cardinal;
    dot11Bssid          : TDOT11_MAC_ADDRESS;
    dot11BssType        : TDOT11_BSS_TYPE;
    dot11BssPhyType     : TDOT11_PHY_TYPE;
    lRssi               : Integer; //LONG;
    uLinkQuality        : Cardinal;
    bInRegDomain        : BOOLEAN;
    usBeaconPeriod      : Word; //USHORT;
    ullTimestamp        : ULONGLONG;
    ullHostTimestamp    : ULONGLONG;
    usCapabilityInfo    : Word; //USHORT;
    ulChCenterFrequency : Integer; //Cardinal;
    wlanRateSet         : TWLAN_RATE_SET;
    ulIeOffset          : Cardinal;
    ulIeSize            : Cardinal;
  end;

  PWLAN_BSS_LIST        = ^TWLAN_BSS_LIST;
  PPWLAN_BSS_LIST       = ^PWLAN_BSS_LIST;
  TWLAN_BSS_LIST        = record
    dwTotalSize         : DWORD;
    dwNumberOfItems     : DWORD;
    wlanBssEntries      : array [0..0] of TWLAN_BSS_ENTRY;
  end;
                                   
    // WLAN_REASON_CODE_SUCCESS
    // WLAN_REASON_CODE_UNKNOWN
    // WLAN_REASON_CODE_NETWORK_NOT_COMPATIBLE
    // WLAN_REASON_CODE_PROFILE_NOT_COMPATIBLE
    // WLAN_REASON_CODE_NO_AUTO_CONNECTION
    // WLAN_REASON_CODE_NOT_VISIBLE
    // WLAN_REASON_CODE_GP_DENIED
    // WLAN_REASON_CODE_USER_DENIED
    // WLAN_REASON_CODE_BSS_TYPE_NOT_ALLOWED
    // WLAN_REASON_CODE_SSID_LIST_TOO_LONG
    // WLAN_REASON_CODE_CONNECT_CALL_FAIL

	TWLAN_SIGNAL_QUALITY  = Cardinal;
  PWLAN_SIGNAL_QUALITY  = ^TWLAN_SIGNAL_QUALITY;

  TWLAN_REASON_CODE     = DWORD;
  PWLAN_REASON_CODE     = ^TWLAN_REASON_CODE;

  PWLAN_AVAILABLE_NETWORK = ^TWLAN_AVAILABLE_NETWORK;
  TWLAN_AVAILABLE_NETWORK = record
    strProfileName      : array[0..255] of wchar;
    dot11Ssid           : TDOT11_SSID;
    dot11BssType        : TDOT11_BSS_TYPE;
    uNumberOfBssids     : Cardinal;
    bNetworkConnectable : Bool;
    wlanNotConnectableReason: TWLAN_REASON_CODE;
    uNumberOfPhyTypes   : Cardinal;
    dot11PhyTypes       : array[0..WLAN_MAX_PHY_TYPE_NUMBER - 1] of TDOT11_PHY_TYPE;
    bMorePhyTypes       : Bool;
    wlanSignalQuality   : TWLAN_SIGNAL_QUALITY;
    bSecurityEnabled    : Bool;
    dot11DefaultAuthAlgorithm: TDOT11_AUTH_ALGORITHM;
    dot11DefaultCipherAlgorithm: TDOT11_CIPHER_ALGORITHM;

    // WLAN_AVAILABLE_NETWORK_CONNECTED or WLAN_AVAILABLE_NETWORK_HAS_PROFILE
    dwFlags             : DWORD;
    dwReserved          : DWORD;
  end;
  
  PWLAN_AVAILABLE_NETWORK_LIST = ^TWLAN_AVAILABLE_NETWORK_LIST;
  PPWLAN_AVAILABLE_NETWORK_LIST = ^PWLAN_AVAILABLE_NETWORK_LIST;
  TWLAN_AVAILABLE_NETWORK_LIST = record
    dwNumberOfItems     : DWORD;
    dwIndex             : DWORD;
    Network             : array[0..0] of TWLAN_AVAILABLE_NETWORK;
  end;

  PWLAN_NOTIFICATION_DATA = ^TWLAN_NOTIFICATION_DATA;
  TWLAN_NOTIFICATION_DATA = record
    NotificationSource  : DWORD;
    NotificationCode    : DWORD;
    InterfaceGuid       : TGUID;
    dwDataSize          : DWORD;
    pData               : Pointer;
  end;

  TWLAN_NOTIFICATION_CALLBACK = procedure(data: PWLAN_NOTIFICATION_DATA; context: Pointer); stdcall;
                             
  TWLAN_CONNECTION_ATTRIBUTES = record
    isState             : TWLAN_INTERFACE_STATE;
    wlanConnectionMode  : TWLAN_CONNECTION_MODE;
    strProfileName      : array[0..255] of WCHAR;
    wlanAssociationAttribs: TWLAN_ASSOCIATION_ATTRIBUTES;
    wlanSecurityAttribs : TWLAN_SECURITY_ATTRIBUTES;
  end;

	PWLAN_CONNECTION_PARAMETERS = ^TWLAN_CONNECTION_PARAMETERS;
	TWLAN_CONNECTION_PARAMETERS = record
  	wlanConnectionMode  : TWLAN_CONNECTION_MODE;
    strProfile          : LPCTSTR;
    pDot11Ssid          : PDOT11_SSID;
    pDesiredBssidList   : PDOT11_BSSID_LIST;
    dot11BssType        : TDOT11_BSS_TYPE;
    dwFlags             : DWORD;
  end;
                   
	PWLAN_PROFILE_INFO    = ^TWLAN_PROFILE_INFO;
	TWLAN_PROFILE_INFO    = record
  	strProfileName      : array[0..WLAN_MAX_NAME_LENGTH - 1] of wchar;
    dwFlags             : DWORD;
  end;
  
  PWLAN_PROFILE_INFO_LIST = ^TWLAN_PROFILE_INFO_LIST;
  PPWLAN_PROFILE_INFO_LIST = ^PWLAN_PROFILE_INFO_LIST;
  TWLAN_PROFILE_INFO_LIST = record
  	dwNumberOfItems     : DWORD;
    dwIndex             : DWORD;
    ProfileInfo         : array[0..0] of TWLAN_PROFILE_INFO;
  end;
                 
  TEAP_TYPE             = record
  	atype               : Byte;
    dwVendorId          : DWORD;
    dwVendorType        : DWORD;
  end;

  TEAP_METHOD_TYPE      = record
  	eapType             : TEAP_TYPE;
    dwAuthorId          : DWORD;
  end;

	PWL_DISPLAY_PAGES = ^TWL_DISPLAY_PAGES;
	TWL_DISPLAY_PAGES = (
  	WLConnectionPage,
		WLSecurityPage);
    
implementation

end.
