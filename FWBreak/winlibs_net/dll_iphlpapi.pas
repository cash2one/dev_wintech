(*
          1    0 0000C5BA AddIPAddress
          2    1 00005C9C AllocateAndGetArpEntTableFromStack
          3    2 00006FB4 AllocateAndGetIfTableFromStack
          4    3 00006383 AllocateAndGetIpAddrTableFromStack
          5    4 000070AA AllocateAndGetIpForwardTableFromStack
          6    5 0000EAA6 AllocateAndGetIpNetTableFromStack
          7    6 0000EF91 AllocateAndGetTcpExTable2FromStack
          8    7 0000F010 AllocateAndGetTcpExTableFromStack
          9    8 0000E9AF AllocateAndGetTcpTableFromStack
         10    9 0000F2E8 AllocateAndGetUdpExTable2FromStack
         11    A 0000F36A AllocateAndGetUdpExTableFromStack
         12    B 0000EA2C AllocateAndGetUdpTableFromStack
         13    C 0000CA95 CancelIPChangeNotify
         14    D 00009F55 CreateIpForwardEntry
         15    E 0000A0CF CreateIpNetEntry
         16    F 0000A440 CreateProxyArpEntry
         17   10 0000C6E0 DeleteIPAddress
         18   11 0000A011 DeleteIpForwardEntry
         19   12 0000A195 DeleteIpNetEntry
         20   13 0000A520 DeleteProxyArpEntry
         21   14 0000CBD4 DisableMediaSense
         22   15 0000CAD9 EnableRouter
         23   16 0000A1EE FlushIpNetTable
         24   17 0000E598 FlushIpNetTableFromStack
         25   18 0000C4E5 GetAdapterIndex
         26   19 000028CF GetAdapterOrderMap
         27   1A 00003E54 GetAdaptersAddresses
         28   1B 00006051 GetAdaptersInfo
         29   1C 0000A2AA GetBestInterface
         30   1D 0000A35B GetBestInterfaceEx
         31   1E 0000E8A0 GetBestInterfaceFromStack
         32   1F 0000A3EF GetBestRoute
         33   20 0000DB87 GetBestRouteFromStack
         34   21 0000ACB7 GetExtendedTcpTable
         35   22 0000B12B GetExtendedUdpTable
         36   23 0000964C GetFriendlyIfIndex
         37   24 00009C2A GetIcmpStatistics
         38   25 00009C6E GetIcmpStatisticsEx
         39   26 0000E221 GetIcmpStatsFromStack
         40   27 0000E16B GetIcmpStatsFromStackEx
         41   28 000063EF GetIfEntry
         42   29 00003B08 GetIfEntryFromStack
         43   2A 00005143 GetIfTable
         44   2B 0000505D GetIfTableFromStack
         45   2C 0000C392 GetIgmpList
         46   2D 00002841 GetInterfaceInfo
         47   2E 00003B9C GetIpAddrTable
         48   2F 00003A6E GetIpAddrTableFromStack
         49   30 0000B50D GetIpErrorString
         50   31 0000AAC7 GetIpForwardTable
         51   32 00007131 GetIpForwardTableFromStack
         52   33 00009962 GetIpNetTable
         53   34 0000DEE7 GetIpNetTableFromStack
         54   35 00009B93 GetIpStatistics
         55   36 00009ACD GetIpStatisticsEx
         56   37 00002734 GetIpStatsFromStack
         57   38 0000E045 GetIpStatsFromStackEx
         58   39 0000CCCF GetNetworkParams
         59   3A 0000526E GetNumberOfInterfaces
         60   3B 0000B04B GetOwnerModuleFromTcp6Entry
         61   3C 0000B000 GetOwnerModuleFromTcpEntry
         62   3D 0000B47E GetOwnerModuleFromUdp6Entry
         63   3E 0000B433 GetOwnerModuleFromUdpEntry
         64   3F 00006769 GetPerAdapterInfo
         65   40 0000C829 GetRTTAndHopCount
         66   41 0000EBD7 GetTcpExTable2FromStack
         67   42 00009D78 GetTcpStatistics
         68   43 00009D14 GetTcpStatisticsEx
         69   44 0000E435 GetTcpStatsFromStack
         70   45 0000E39E GetTcpStatsFromStackEx
         71   46 0000AC1D GetTcpTable
         72   47 0000DD16 GetTcpTableFromStack
         73   48 0000F08D GetUdpExTable2FromStack
         74   49 00009E64 GetUdpStatistics
         75   4A 00009E00 GetUdpStatisticsEx
         76   4B 0000E32B GetUdpStatsFromStack
         77   4C 0000E294 GetUdpStatsFromStackEx
         78   4D 0000B096 GetUdpTable
         79   4E 0000DE44 GetUdpTableFromStack
         80   4F 00002D18 GetUniDirectionalAdapterInfo
         81   50 0000B65D Icmp6CreateFile
         82   51 0000B946 Icmp6ParseReplies
         83   52 0000B98D Icmp6SendEcho2
         84   53 00004D33 IcmpCloseHandle
         85   54 00004D5E IcmpCreateFile
         86   55 00004CD6 IcmpParseReplies
         88   56 00004B79 IcmpSendEcho
         87   57 0000B73C IcmpSendEcho2
         89   58 0000C131 InternalCreateIpForwardEntry
         90   59 0000C28B InternalCreateIpNetEntry
         91   5A 0000C1D3 InternalDeleteIpForwardEntry
         92   5B 0000C317 InternalDeleteIpNetEntry
         93   5C 0000BD99 InternalGetIfTable
         94   5D 0000BE86 InternalGetIpAddrTable
         95   5E 0000BFEA InternalGetIpForwardTable
         96   5F 0000BF37 InternalGetIpNetTable
         97   60 0000C0A4 InternalGetTcpTable
         98   61 0000C0C6 InternalGetUdpTable
         99   62 0000C0E8 InternalSetIfEntry
        100   63 0000C182 InternalSetIpForwardEntry
        101   64 0000C2D1 InternalSetIpNetEntry
        102   65 0000C247 InternalSetIpStats
        103   66 0000C378 InternalSetTcpEntry
        104   67 0000CD27 IpReleaseAddress
        105   68 0000CDB9 IpRenewAddress
        106   69 0000C992 IsLocalAddress
        107   6A 00010CED NTPTimeToNTFileTime
        108   6B 00010C15 NTTimeToNTPTime
        109   6C 0000D558 NhGetGuidFromInterfaceName
        110   6D 00006A73 NhGetInterfaceNameFromDeviceGuid
        111   6E 0000D4F0 NhGetInterfaceNameFromGuid
        112   6F 00006AE8 NhpAllocateAndGetInterfaceInfoFromStack
        113   70 0000DC6A NhpGetInterfaceIndexFromStack
        114   71 00006300 NotifyAddrChange
        115   72 0000CEAE NotifyRouteChange
        116   73 0000C9FB NotifyRouteChangeEx
        133   74 0000CC62 RestoreMediaSense
        134   75 0000CE49 SendARP
        135   76 00011F56 SetAdapterIpAddress
        136   77 0000C40F SetBlockRoutes
        137   78 00009EEC SetIfEntry
        138   79 0000E918 SetIfEntryToStack
        139   7A 00009FB3 SetIpForwardEntry
        140   7B 0000EB5C SetIpForwardEntryToStack
        141   7C 0000E834 SetIpMultihopRouteEntryToStack
        142   7D 0000A13C SetIpNetEntry
        143   7E 0000E4A8 SetIpNetEntryToStack
        144   7F 0000E7AE SetIpRouteEntryToStack
        145   80 0000A076 SetIpStatistics
        146   81 0000E0DC SetIpStatsToStack
        147   82 0000B4C9 SetIpTTL
        148   83 0000E5E4 SetProxyArpEntryToStack
        149   84 0000C48F SetRouteWithRef
        150   85 0000A252 SetTcpEntry
        151   86 0000DDC1 SetTcpEntryToStack
        152   87 0000CB67 UnenableRouter
        117   88 0000F4F7 _PfAddFiltersToInterface@24
        118   89 0000F5D2 _PfAddGlobalFilterToInterface@8
        119   8A 0000F751 _PfBindInterfaceToIPAddress@12
        120   8B 0000F692 _PfBindInterfaceToIndex@16
        121   8C 0000F4CD _PfCreateInterface@24
        122   8D 0000F4E2 _PfDeleteInterface@4
        123   8E 0000F8E2 _PfDeleteLog@0
        124   8F 0000F89B _PfGetInterfaceStatistics@16
        125   90 0000F871 _PfMakeLog@4
        126   91 0000F7E9 _PfRebindFilters@8
        127   92 0000F58E _PfRemoveFilterHandles@12
        128   93 0000F544 _PfRemoveFiltersFromInterface@20
        129   94 0000F613 _PfRemoveGlobalFilterFromInterface@8
        130   95 0000F886 _PfSetLogBuffer@28
        131   96 0000F8F1 _PfTestPacket@20
        132   97 0000F654 _PfUnBindInterface@4
        153   98 0000BC18 do_echo_rep
        154   99 0000BB48 do_echo_req
        155   9A 0000BB2D register_icmp
*)

unit dll_iphlpapi;

interface

uses
  atmcmbaseconst, wintype;
  
const
  iphlpapi = 'iphlpapi.dll';   
  MAX_ADAPTER_NAME_LENGTH = 256;
  MAX_ADAPTER_DESCRIPTION_LENGTH = 128;
  MAX_ADAPTER_ADDRESS_LENGTH = 8;

type
   IP_ADDRESS_STRING  = record
     Data             : array[0..15] of AnsiChar;
  end;

   IP_MASK_STRING     = IP_ADDRESS_STRING;
   PIP_MASK_STRING    = ^IP_MASK_STRING;

   PIP_ADDR_STRING    = ^IP_ADDR_STRING;
   IP_ADDR_STRING     = record
     Next             : PIP_ADDR_STRING;
     IpAddress        : IP_ADDRESS_STRING;
     IpMask           : IP_MASK_STRING;
     Context          : DWORD;
  end;

   PIP_ADAPTER_INFO   = ^TIP_ADAPTER_INFO;
   TIP_ADAPTER_INFO   = record
     Next             : PIP_ADAPTER_INFO;
     ComboIndex       : DWORD;
     AdapterName      : array[0..MAX_ADAPTER_NAME_LENGTH + 3] of AnsiChar;
     Description      : array[0..MAX_ADAPTER_DESCRIPTION_LENGTH + 3] of AnsiChar;
     AddressLength    : UINT;
     Address          : array[0..MAX_ADAPTER_ADDRESS_LENGTH - 1] of BYTE;
     Index            : DWORD;
     Type_            : UINT;
     DhcpEnabled      : UINT;
     CurrentIpAddress : PIP_ADDR_STRING;
     IpAddressList    : IP_ADDR_STRING;
     GatewayList      : IP_ADDR_STRING;
     DhcpServer       : IP_ADDR_STRING;
     HaveWins         : BOOL;
     PrimaryWinsServer: IP_ADDR_STRING;
     SecondWinsServer : IP_ADDR_STRING;
     LeaseObtained    : Longint;
     LeaseExpires     : Longint;
  end;
  
  function GetAdaptersInfo(pAdapterInfo: PIP_ADAPTER_INFO; var pOutBufLen: ULONG): DWORD; stdcall; external iphlpapi;

implementation

end.