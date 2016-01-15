(*
          4    0 00005359 AcceptSecurityContext
          5    1 0000A87E AcquireCredentialsHandleA
          6    2 0000311C AcquireCredentialsHandleW
          7    3 0000A39D AddCredentialsA
          8    4 0000A348 AddCredentialsW
          9    5 00008C3C AddSecurityPackageA
         10    6 00008BFD AddSecurityPackageW
         11    7 0000A3F2 ApplyControlToken
         12    8 0000A486 CompleteAuthToken
         13    9 00001F0F CredMarshalTargetInfo
         14    A 000085A4 CredUnmarshalTargetInfo
         15    B 0000A6DC DecryptMessage
         16    C 00002D26 DeleteSecurityContext
         17    D 00008C94 DeleteSecurityPackageA
         18    E 00008C94 DeleteSecurityPackageW
         19    F 0000A68D EncryptMessage
         20   10 0000A439 EnumerateSecurityPackagesA
         21   11 00002A2F EnumerateSecurityPackagesW
         22   12 0000A72B ExportSecurityContext
         23   13 00002848 FreeContextBuffer
         24   14 00002BAA FreeCredentialsHandle
         25   15 0000C146 GetComputerObjectNameA
         26   16 0000BF74 GetComputerObjectNameW
         27   17 00008B37 GetSecurityUserInfo
         28   18 00001DEA GetUserNameExA
         29   19 00001C90 GetUserNameExW
         30   1A 00005527 ImpersonateSecurityContext
         31   1B 0000A803 ImportSecurityContextA
         32   1C 0000A788 ImportSecurityContextW
         33   1D 00006A44 InitSecurityInterfaceA
         34   1E 00002A24 InitSecurityInterfaceW
         35   1F 0000A8AE InitializeSecurityContextA
         36   20 00005BDB InitializeSecurityContextW
         37   21 000021A8 LsaCallAuthenticationPackage
         38   22 00004E9B LsaConnectUntrusted
         39   23 00007CD5 LsaDeregisterLogonProcess
         40   24 0000A2B1 LsaEnumerateLogonSessions
         41   25 00002180 LsaFreeReturnBuffer
         42   26 0000A2D0 LsaGetLogonSessionData
         43   27 000033F1 LsaLogonUser
         44   28 00004BA2 LsaLookupAuthenticationPackage
         45   29 00004D17 LsaRegisterLogonProcess
         46   2A 00004AC5 LsaRegisterPolicyChangeNotification
         47   2B 0000A289 LsaUnregisterPolicyChangeNotification
         48   2C 000032F0 MakeSignature
         49   2D 0000A525 QueryContextAttributesA
         50   2E 00005447 QueryContextAttributesW
         51   2F 0000A633 QueryCredentialsAttributesA
         52   30 000034E1 QueryCredentialsAttributesW
         53   31 0000A4CD QuerySecurityContextToken
         54   32 0000A467 QuerySecurityPackageInfoA
         55   33 00003884 QuerySecurityPackageInfoW
         56   34 0000556B RevertSecurityContext
         57   35 0000B599 SaslAcceptSecurityContext
         58   36 0000AE97 SaslEnumerateProfilesA
         59   37 0000AEA7 SaslEnumerateProfilesW
         60   38 0000AEB7 SaslGetProfilePackageA
         61   39 0000AEE3 SaslGetProfilePackageW
         62   3A 0000B1E0 SaslIdentifyPackageA
         63   3B 0000B20E SaslIdentifyPackageW
         64   3C 0000B490 SaslInitializeSecurityContextA
         65   3D 0000B387 SaslInitializeSecurityContextW
         66   3E 0000A68D SealMessage
         67   3F 00005F5C SecCacheSspiPackages
          1   40 0000A066 SecDeleteUserModeContext
         68   41 00008B47 SecGetLocaleSpecificEncryptionRules
          2   42 0000A019 SecInitUserModeContext
         69   43 0000B828 SecpFreeMemory
         70   44 0000BC05 SecpTranslateName
         71   45 0000BBAE SecpTranslateNameEx
         72   46 0000A5D1 SetContextAttributesA
         73   47 0000A56F SetContextAttributesW
          3   48 00008CB1 SupportsChannelBinding
         74   49 0000C1F8 TranslateNameA
         75   4A 0000C10B TranslateNameW
         76   4B 0000A6DC UnsealMessage
         77   4C 000033A4 VerifySignature
*)
unit dll_secur32;

interface

implementation

end.