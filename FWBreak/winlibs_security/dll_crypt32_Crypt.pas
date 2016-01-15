{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
(*
       1129   74 0003A556 CryptAcquireCertificatePrivateKey
       1130   75 00032F35 CryptAcquireContextU
       1131   76 00034020 CryptBinaryToStringA
       1132   77 0003433F CryptBinaryToStringW
       1133   78 00044253 CryptCloseAsyncHandle
       1134   79 0004405A CryptCreateAsyncHandle
       1135   7A 0003CA8B CryptCreateKeyIdentifierFromCSP
       1136   7B 00045A2C CryptDecodeMessage
       1137   7C 000147AE CryptDecodeObject
       1138   7D 00011FC4 CryptDecodeObjectEx
       1139   7E 00045933 CryptDecryptAndVerifyMessageSignature
       1140   7F 00045900 CryptDecryptMessage
       1141   80 00045A6B CryptEncodeObject
       1142   81 0001BE21 CryptEncodeObjectEx
       1143   82 0004496E CryptEncryptMessage
       1144   83 0003A0E5 CryptEnumKeyIdentifierProperties
       1145   84 0000A809 CryptEnumOIDFunction
       1146   85 0004D4D2 CryptEnumOIDInfo
       1147   86 00033339 CryptEnumProvidersU
       1148   87 0006FB40 CryptExportPKCS8
       1149   88 0003CA64 CryptExportPublicKeyInfo
       1150   89 0003C9EF CryptExportPublicKeyInfoEx
       1151   8A 0003D06F CryptFindCertificateKeyProvInfo
       1152   8B 0004CAAC CryptFindLocalizedName
       1153   8C 0001050F CryptFindOIDInfo
       1154   8D 0004D82B CryptFormatObject
       1155   8E 00009ADB CryptFreeOIDFunctionAddress
       1156   8F 0004420E CryptGetAsyncParam
       1157   90 00019714 CryptGetDefaultOIDDllList
       1158   91 00019961 CryptGetDefaultOIDFunctionAddress
       1159   92 00039DAF CryptGetKeyIdentifierProperty
       1160   93 000442DC CryptGetMessageCertificates
       1161   94 00044272 CryptGetMessageSignerCount
       1162   95 00009970 CryptGetOIDFunctionAddress
       1163   96 0004BF69 CryptGetOIDFunctionValue
       1164   97 000122DD CryptHashCertificate
       1165   98 0004430C CryptHashMessage
       1166   99 0003BEFD CryptHashPublicKeyInfo
       1167   9A 0001B7F0 CryptHashToBeSigned
       1168   9B 0006F8FD CryptImportPKCS8
       1169   9C 00012725 CryptImportPublicKeyInfo
       1170   9D 00012749 CryptImportPublicKeyInfoEx
       1171   9E 00005F63 CryptInitOIDFunctionSet
       1172   9F 0003CB30 CryptInstallDefaultContext
       1173   A0 0000600F CryptInstallOIDFunctionAddress
       1174   A1 0006E4B0 CryptLoadSip
       1175   A2 00022D50 CryptMemAlloc
       1176   A3 0000BEF1 CryptMemFree
       1177   A4 00056325 CryptMemRealloc
       1178   A5 00061A15 CryptMsgCalculateEncodedLength
       1179   A6 0001A5DF CryptMsgClose
       1180   A7 0001E1EB CryptMsgControl
       1181   A8 00068A03 CryptMsgCountersign
       1182   A9 00012CE8 CryptMsgCountersignEncoded
       1183   AA 000639AC CryptMsgDuplicate
       1184   AB 00068DD7 CryptMsgEncodeAndSignCTL
       1185   AC 00068D27 CryptMsgGetAndVerifySigner
       1186   AD 0001CCDA CryptMsgGetParam
       1187   AE 0001FB47 CryptMsgOpenToDecode
       1188   AF 00068944 CryptMsgOpenToEncode
       1189   B0 00004E62 CryptMsgSignCTL
       1190   B1 0001F48A CryptMsgUpdate
       1191   B2 0006512B CryptMsgVerifyCountersignatureEncoded
       1192   B3 0001FC6B CryptMsgVerifyCountersignatureEncodedEx
       1193   B4 0000B942 CryptProtectData
       1194   B5 00025357 CryptQueryObject
       1195   B6 0004C207 CryptRegisterDefaultOIDFunction
       1196   B7 0004C004 CryptRegisterOIDFunction
       1197   B8 0004C575 CryptRegisterOIDInfo
       1198   B9 0006E5E0 CryptSIPAddProvider
       1199   BA 0006E8C0 CryptSIPCreateIndirectData
       1200   BB 0001C614 CryptSIPGetSignedDataMsg
       1201   BC 00020842 CryptSIPLoad
       1202   BD 0006E7A5 CryptSIPPutSignedDataMsg
       1203   BE 0006E4C0 CryptSIPRemoveProvider
       1204   BF 0006E83A CryptSIPRemoveSignedDataMsg
       1205   C0 00009BD3 CryptSIPRetrieveSubjectGuid
       1206   C1 0006E94F CryptSIPRetrieveSubjectGuidForCatalogFile
       1207   C2 000208E8 CryptSIPVerifyIndirectData
       1208   C3 000441EF CryptSetAsyncParam
       1209   C4 00039E41 CryptSetKeyIdentifierProperty
       1210   C5 0004BEC2 CryptSetOIDFunctionValue
       1211   C6 00033129 CryptSetProviderU
       1212   C7 0003BBB9 CryptSignAndEncodeCertificate
       1213   C8 00045424 CryptSignAndEncryptMessage
       1214   C9 0003B9F2 CryptSignCertificate
       1215   CA 00032FD9 CryptSignHashU
       1216   CB 00045395 CryptSignMessage
       1217   CC 00044A53 CryptSignMessageWithKey
       1218   CD 0003452B CryptStringToBinaryA
       1219   CE 0003461D CryptStringToBinaryW
       1220   CF 0003CC94 CryptUninstallDefaultContext
       1221   D0 0000BAF0 CryptUnprotectData
       1222   D1 0004C379 CryptUnregisterDefaultOIDFunction
       1223   D2 0004C092 CryptUnregisterOIDFunction
       1224   D3 0004C62A CryptUnregisterOIDInfo
       1225   D4 0003D26C CryptVerifyCertificateSignature
       1226   D5 00018CDC CryptVerifyCertificateSignatureEx
       1227   D6 00044A24 CryptVerifyDetachedMessageHash
       1228   D7 000458CA CryptVerifyDetachedMessageSignature
       1229   D8 000449F7 CryptVerifyMessageHash
       1230   D9 00045896 CryptVerifyMessageSignature
       1231   DA 00044C13 CryptVerifyMessageSignatureWithKey
       1232   DB 00033075 CryptVerifySignatureU
*)
unit dll_crypt32_crypt;

interface

uses
  atmcmbaseconst, wintype, dll_crypt32_typconst;

function CryptProtectData(pDataIn: PCRYPTOAPI_BLOB; szDataDescr: LPCWSTR {PWideChar};
  pOptionalEntropy: PCRYPTOAPI_BLOB; pReserved: Pointer;
  pPromptStruct: PCRYPTPROTECT_PROMPTSTRUCT; dwFlags: DWORD;
  pDataOut: PCRYPTOAPI_BLOB): BOOL; stdcall; external Crypt32;

function CryptUnprotectData(pDataIn: PCRYPTOAPI_BLOB; var ppszDataDescr: LPWSTR;
  pOptionalEntropy: PCRYPTOAPI_BLOB; pReserved: Pointer;
  pPromptStruct: PCRYPTPROTECT_PROMPTSTRUCT; dwFlags: DWORD;
  pDataOut: PCRYPTOAPI_BLOB): BOOL; stdcall; external Crypt32;

implementation

end.