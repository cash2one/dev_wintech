(*          1    0 0000FA6F DhcpAcquireParameters
          2    1 0000FAE1 DhcpAcquireParametersByBroadcast
          3    2 000107D0 DhcpCApiCleanup
          4    3 000107B3 DhcpCApiInitialize
          5    4 00010E51 DhcpDeRegisterConnectionStateNotification
          6    5 000107A3 DhcpDeRegisterOptions
          7    6 0001090A DhcpDeRegisterParamChange
          8    7 000113DB DhcpDelPersistentRequestParams
          9    8 00011CA3 DhcpEnumClasses
         10    9 0000FB51 DhcpFallbackRefreshParams
         11    A 00011021 DhcpFreeMem
         12    B 00010ED1 DhcpGetDhcpServicedConnections
         13    C 00010C51 DhcpGetNotificationStatus
         14    D 00011F11 DhcpHandlePnPEvent
         15    E 00014F94 DhcpLeaseIpAddress
         16    F 000149A0 DhcpLeaseIpAddressEx
         17   10 00013F3B DhcpNotifyConfigChange
         18   11 00013DCA DhcpNotifyConfigChangeEx
         19   12 000030FB DhcpNotifyMediaReconnected
         20   13 0000B711 DhcpOpenGlobalEvent
         21   14 00011392 DhcpPersistentRequestParams
         22   15 00009B02 DhcpQueryHWInfo
         23   16 00010B41 DhcpRegisterConnectionStateNotification
         24   17 00010504 DhcpRegisterOptions
         25   18 000107D8 DhcpRegisterParamChange
         26   19 00014980 DhcpReleaseIpAddressLease
         27   1A 00014668 DhcpReleaseIpAddressLeaseEx
         28   1B 0000FBC1 DhcpReleaseParameters
         29   1C 00010920 DhcpRemoveDNSRegistrations
         30   1D 0001495A DhcpRenewIpAddressLease
         31   1E 000141C8 DhcpRenewIpAddressLeaseEx
         32   1F 00010981 DhcpRequestCachedParams
         33   20 000043ED DhcpRequestOptions
         34   21 0001155F DhcpRequestParams
         35   22 000118A8 DhcpSetMSFTVendorSpecificOptions
         36   23 0000FD79 DhcpStaticRefreshParams
         37   24 00011879 DhcpUndoRequestParams
         38   25 00015010 McastApiCleanup
         39   26 00014FC0 McastApiStartup
         40   27 0001501A McastEnumerateScopes
         41   28 000150F2 McastGenUID
         42   29 00015357 McastReleaseAddress
         43   2A 0001525B McastRenewAddress
         44   2B 00015133 McastRequestAddress
         45   2C 0000A61E ServiceMain
*)

unit dll_dhcpcsvc;

interface

(*
var     
            DhcpDll:THandle;     
            DHCPD:TDHCPNOTIFYPROC;     
      
    begin     
            try     
                    DhcpDll:=LoadLibrary( 'dhcpcsvc.dll ');     
                    if           DhcpDll       <>       0       then     
                    begin     
                            @DHCPD:=GetProcAddress(DhcpDll,       PChar( 'DhcpNotifyConfigChange '));     
                            if       @DHCPD       <>       nil       then     
                                        DHCPD(nil,pchar( '{01082454-E36A-48C4-A59F-35D6CEF88484} '),True,0,inet_addr(( '192.168.0.240 ')),inet_addr(( '255.255.255.0 ')),0);     
                    end;     
            Finally     
                    FreeLibrary(DhcpDll);     
            end;       
end;
*)

function DhcpNotifyConfigChange(
    lpwszServerName LPWSTR, // 本地机器为NULL
    lpwszAdapterName LPWSTR, // 适配器名称
    bNewIpAddress BOOL, // TRUE表示更改IP
    dwIpIndex DWORD, // 指明第几个IP地址，如果只有该接口只有一个IP地址则为0
    dwIpAddress DWORD, // IP地址
    dwSubNetMask DWORD, // 子网掩码
    nDhcpAction integer): BOOL; stdcall; // 对DHCP的操作 0:不修改, 1:启用 DHCP，2:禁用 DHCP

implementation

end.