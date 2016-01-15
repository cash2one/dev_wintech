{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_advapi32;

interface 
                 
uses
  atmcmbaseconst, winconst, wintype;

type
  AUDIT_EVENT_TYPE = DWORD;
    
  function AbortSystemShutdownA(lpMachineName: PAnsiChar): BOOL; stdcall; external advapi32 name 'AbortSystemShutdownA';
  
  function AccessCheck(pSecurityDescriptor: PSecurityDescriptor;
    ClientToken: THandle; DesiredAccess: DWORD; const GenericMapping: TGenericMapping;
    var PrivilegeSet: TPrivilegeSet; var PrivilegeSetLength: DWORD;
    var GrantedAccess: DWORD; var AccessStatus: BOOL): BOOL; stdcall; external advapi32 name 'AccessCheck';
  function AccessCheckAndAuditAlarmA(SubsystemName: PAnsiChar;
    HandleId: Pointer; ObjectTypeName, ObjectName: PAnsiChar;
    SecurityDescriptor: PSecurityDescriptor; DesiredAccess: DWORD;
    const GenericMapping: TGenericMapping;  ObjectCreation: BOOL;
    var GrantedAccess: DWORD; var AccessStatus, pfGenerateOnClose: BOOL): BOOL; stdcall; external advapi32 name 'AccessCheckAndAuditAlarmA';
  function AccessCheckByType(pSecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID;
    ClientToken: THandle; DesiredAccess: DWORD; ObjectTypeList: PObjectTypeList;
    const GenericMapping: TGenericMapping; ObjectTypeListLength: DWORD;
    var PrivilegeSet: TPrivilegeSet; var PrivilegeSetLength: DWORD;
    var GrantedAccess: DWORD; var AccessStatus: BOOL): BOOL; stdcall; external advapi32 name 'AccessCheckByType';
  function AccessCheckByTypeAndAuditAlarmA(SubsystemName: PAnsiChar;
    HandleId: Pointer; ObjectTypeName, ObjectName: PAnsiChar;
    SecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID; DesiredAccess: DWORD;
    AuditType: AUDIT_EVENT_TYPE; Flags: DWORD; ObjectTypeList: PObjectTypeList;
    ObjectTypeListLength: DWORD; const GenericMapping: TGenericMapping;  ObjectCreation: BOOL;
    var GrantedAccess: DWORD; var AccessStatus, pfGenerateOnClose: BOOL): BOOL; stdcall; external advapi32 name 'AccessCheckByTypeAndAuditAlarmA';
  function AccessCheckByTypeResultList(pSecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID;
    ClientToken: THandle; DesiredAccess: DWORD; ObjectTypeList: PObjectTypeList;
    const GenericMapping: TGenericMapping; ObjectTypeListLength: DWORD;
    var PrivilegeSet: TPrivilegeSet; var PrivilegeSetLength: DWORD;
    var GrantedAccess: DWORD; var AccessStatusList: DWORD): BOOL; stdcall; external advapi32 name 'AccessCheckByTypeResultList';
  function AccessCheckByTypeResultListAndAuditAlarmA(SubsystemName: PAnsiChar;
    HandleId: Pointer; ObjectTypeName, ObjectName: PAnsiChar;
    SecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID; DesiredAccess: DWORD;
    AuditType: AUDIT_EVENT_TYPE; Flags: DWORD; ObjectTypeList: PObjectTypeList;
    ObjectTypeListLength: DWORD; const GenericMapping: TGenericMapping;  ObjectCreation: BOOL;
    var GrantedAccess: DWORD; var AccessStatusList: DWORD; var pfGenerateOnClose: BOOL): BOOL; stdcall; external advapi32 name 'AccessCheckByTypeResultListAndAuditAlarmA';

  function AddAccessAllowedAce(var pAcl: TACL; dwAceRevision: DWORD;
    AccessMask: DWORD; pSid: PSID): BOOL; stdcall; external advapi32 name 'AddAccessAllowedAce';
  function AddAccessAllowedAceEx(var pAcl: TACL; dwAceRevision: DWORD;
    AceFlags: DWORD; AccessMask: DWORD; pSid: PSID): BOOL; stdcall; external advapi32 name 'AddAccessAllowedAceEx';
  function AddAccessAllowedObjectAce(var pAcl: TACL; dwAceRevision: DWORD;
    AceFlags: DWORD; AccessMask: DWORD; ObjectTypeGuid, InheritedObjectTypeGuid: PGuid;
    pSid: Pointer): BOOL; stdcall; external advapi32 name 'AddAccessAllowedObjectAce';
  function AddAccessDeniedAce(var pAcl: TACL; dwAceRevision: DWORD;
    AccessMask: DWORD; pSid: PSID): BOOL; stdcall; external advapi32 name 'AddAccessDeniedAce';
  function AddAccessDeniedObjectAce(var pAcl: TACL; dwAceRevision: DWORD;
    AceFlags: DWORD; AccessMask: DWORD; ObjectTypeGuid, InheritedObjectTypeGuid: PGuid;
    pSid: Pointer): BOOL; stdcall; external advapi32 name 'AddAccessDeniedObjectAce';
  function AddAccessDeniedAceEx(var pAcl: TACL; dwAceRevision: DWORD;
    ACEFlags: DWORD; AccessMask: DWORD; pSid: PSID): BOOL; stdcall; external advapi32 name 'AddAccessDeniedAceEx';
  function AddAce(var pAcl: TACL; dwAceRevision, dwStartingAceIndex: DWORD; pAceList: Pointer;
    nAceListLength: DWORD): BOOL; stdcall; external advapi32 name 'AddAce';
  function AddAuditAccessAce(var pAcl: TACL; dwAceRevision: DWORD;
    dwAccessMask: DWORD; pSid: Pointer; bAuditSuccess, bAuditFailure: BOOL): BOOL; stdcall; external advapi32 name 'AddAuditAccessAce';
  function AddAuditAccessAceEx(var pAcl: TACL; dwAceRevision: DWORD;
    AceFlags: DWORD; dwAccessMask: DWORD; pSid: Pointer; bAuditSuccess, bAuditFailure: BOOL): BOOL; stdcall; external advapi32 name 'AddAuditAccessAceEx';
  function AddAuditAccessObjectAce(var pAcl: TACL; dwAceRevision: DWORD;
    AceFlags: DWORD; AccessMask: DWORD; ObjectTypeGuid, InheritedObjectTypeGuid: PGuid;
    pSid: Pointer; bAuditSuccess, bAuditFailure: BOOL): BOOL; stdcall; external advapi32 name 'AddAuditAccessObjectAce';

type
  SID_NAME_USE = DWORD;

  PSIDAndAttributes = ^TSIDAndAttributes;
  TSIDAndAttributes = record
    Sid: PSID;
    Attributes: DWORD;
  end;

  PTokenGroups = ^TTokenGroups;
  TTokenGroups = record
    GroupCount: DWORD;
    Groups: array[0..0] of TSIDAndAttributes;
  end;

  PTokenPrivileges = ^TTokenPrivileges;
  TTokenPrivileges = record
    PrivilegeCount: DWORD;
    Privileges: array[0..0] of TLUIDAndAttributes;
  end;
  
  PSIDIdentifierAuthority = ^TSIDIdentifierAuthority;
  TSIDIdentifierAuthority = record
    Value: array[0..5] of Byte;
  end;

  function AdjustTokenGroups(TokenHandle: THandle; ResetToDefault: BOOL;
    const NewState: TTokenGroups; BufferLength: DWORD;
    var PreviousState: TTokenGroups; var ReturnLength: DWORD): BOOL; stdcall; external advapi32 name 'AdjustTokenGroups';
  function AdjustTokenPrivileges(TokenHandle: THandle; DisableAllPrivileges: BOOL;
    const NewState: TTokenPrivileges; BufferLength: DWORD;
    var PreviousState: TTokenPrivileges; var ReturnLength: DWORD): BOOL; external advapi32 name 'AdjustTokenPrivileges';
//  function AdjustTokenPrivileges(TokenHandle: THandle; DisableAllPrivileges: BOOL;
//    const NewState: TTokenPrivileges; BufferLength: DWORD;
//    PreviousState: PTokenPrivileges; var ReturnLength: DWORD): BOOL; external advapi32 name 'AdjustTokenPrivileges';
  function AllocateAndInitializeSid(const pIdentifierAuthority: TSIDIdentifierAuthority;
    nSubAuthorityCount: Byte; nSubAuthority0, nSubAuthority1: DWORD;
    nSubAuthority2, nSubAuthority3, nSubAuthority4: DWORD;
    nSubAuthority5, nSubAuthority6, nSubAuthority7: DWORD;
    var pSid: Pointer): BOOL; stdcall; external advapi32 name 'AllocateAndInitializeSid';
  function AllocateLocallyUniqueId(var Luid: TLargeInteger): BOOL; stdcall; external advapi32 name 'AllocateLocallyUniqueId';
  function AreAllAccessesGranted(GrantedAccess, DesiredAccess: DWORD): BOOL; stdcall; external advapi32 name 'AreAllAccessesGranted';
  function AreAnyAccessesGranted(GrantedAccess, DesiredAccess: DWORD): BOOL; stdcall; external advapi32 name 'AreAnyAccessesGranted';
  function BackupEventLogA(hEventLog: THandle; lpBackupFileName: PAnsiChar): BOOL; stdcall; external advapi32 name 'BackupEventLogA';

  function ConvertToAutoInheritPrivateObjectSecurity(ParentDescriptor, CurrentSecurityDescriptor: PSecurityDescriptor;
    var NewDescriptor: PSecurityDescriptor; ObjectType: PGUID;
    IsDirectoryObject: BOOL; const GenericMapping: TGenericMapping): BOOL; stdcall; external advapi32 name 'ConvertToAutoInheritPrivateObjectSecurity';
  function CopySid(nDestinationSidLength: DWORD; pDestinationSid, pSourceSid: Pointer): BOOL; stdcall; external advapi32 name 'CopySid';
  function CreatePrivateObjectSecurity(ParentDescriptor, CreatorDescriptor: PSecurityDescriptor;
    var NewDescriptor: PSecurityDescriptor; IsDirectoryObject: BOOL;
    Token: THandle; const GenericMapping: TGenericMapping): BOOL; stdcall; external advapi32 name 'CreatePrivateObjectSecurity';
  function CreatePrivateObjectSecurityEx(ParentDescriptor, CreatorDescriptor: PSecurityDescriptor;
    var NewDescriptor: PSecurityDescriptor; ObjectType: PGUID; IsContainerObject: BOOL;
    AutoInheritFlags: ULONG; Token: THandle; const GenericMapping: TGenericMapping): BOOL; stdcall; external advapi32 name 'CreatePrivateObjectSecurityEx';
  function CreateProcessAsUserA(AToken: THandle; lpApplicationName: PAnsiChar;
    lpCommandLine: PAnsiChar; lpProcessAttributes: PSecurityAttributes;
    lpThreadAttributes: PSecurityAttributes; bInheritHandles: BOOL;
    dwCreationFlags: DWORD; lpEnvironment: Pointer; lpCurrentDirectory: PAnsiChar;
    const lpStartupInfo: TStartupInfoA; var lpProcessInformation: TProcessInformation): BOOL; stdcall; external advapi32 name 'CreateProcessAsUserA';

  function DeleteAce(var pAcl: TACL; dwAceIndex: DWORD): BOOL; stdcall; external advapi32 name 'DeleteAce';
  function DeregisterEventSource(hEventLog: THandle): BOOL; stdcall; external advapi32 name 'DeregisterEventSource';
  function DestroyPrivateObjectSecurity(var ObjectDescriptor: PSecurityDescriptor): BOOL; stdcall; external advapi32 name 'DestroyPrivateObjectSecurity';

type
  TSecurityImpersonationLevel = (SecurityAnonymous, SecurityIdentification, SecurityImpersonation, SecurityDelegation);

  TTokenType = (TokenTPad, TokenPrimary, TokenImpersonation);

  TTokenInformationClass = (TokenICPad, TokenUser, TokenGroups, TokenPrivileges,
    TokenOwner, TokenPrimaryGroup, TokenDefaultDacl, TokenSource, TokenType,
    TokenImpersonationLevel, TokenStatistics);

  function DuplicateToken(ExistingTokenHandle: THandle;
    ImpersonationLevel: TSecurityImpersonationLevel; DuplicateTokenHandle: PHandle): BOOL; stdcall; external advapi32 name 'DuplicateToken';
  function DuplicateTokenEx(hExistingToken: THandle; dwDesiredAccess: DWORD;
    lpTokenAttributes: PSecurityAttributes;
    ImpersonationLevel: TSecurityImpersonationLevel; TokenType: TTokenType;
    var phNewToken: THandle): BOOL; stdcall; external advapi32 name 'DuplicateTokenEx';
  function EqualPrefixSid(pSid1, pSid2: Pointer): BOOL; stdcall; external advapi32 name 'EqualPrefixSid';
  function EqualSid(pSid1, pSid2: Pointer): BOOL; stdcall; external advapi32 name 'EqualSid';
  function FindFirstFreeAce(var pAcl: TACL; var pAce: Pointer): BOOL; stdcall; external advapi32 name 'FindFirstFreeAce';
  function FreeSid(pSid: Pointer): Pointer; stdcall; external advapi32 name 'FreeSid';
  function GetAce(const pAcl: TACL; dwAceIndex: DWORD; var pAce: Pointer): BOOL; stdcall; external advapi32 name 'GetAce';
  
type
  TAclInformationClass = (AclInfoPad, AclRevisionInformation, AclSizeInformation);

  function GetAclInformation(const pAcl: TACL; pAclInformation: Pointer;
    nAclInformationLength: DWORD; dwAclInformationClass: TAclInformationClass): BOOL; stdcall; external advapi32 name 'GetAclInformation';

const
  HW_PROFILE_GUIDLEN = 39;                 { 36-characters plus NULL terminator }
  MAX_PROFILE_LEN = 80;

type
  PHWProfileInfoA = ^THWProfileInfoA;
  PHWProfileInfo = PHWProfileInfoA;
  THWProfileInfoA = packed record
    dwDockInfo: DWORD;
    szHwProfileGuid: packed array[0..HW_PROFILE_GUIDLEN-1] of AnsiChar;
    szHwProfileName: packed array[0..MAX_PROFILE_LEN-1] of AnsiChar;
  end;
  THWProfileInfo = THWProfileInfoA;

  function GetCurrentHwProfileA(var lpHwProfileInfo: THWProfileInfo): BOOL; stdcall; external advapi32 name 'GetCurrentHwProfileA';

  function GetFileSecurityA(lpFileName: PAnsiChar; RequestedInformation: SECURITY_INFORMATION;
    pSecurityDescriptor: PSecurityDescriptor; nLength: DWORD; var lpnLengthNeeded: DWORD): BOOL; stdcall; external advapi32 name 'GetFileSecurityA';
  function GetKernelObjectSecurity(Handle: THandle; RequestedInformation: SECURITY_INFORMATION;
    pSecurityDescriptor: PSecurityDescriptor; nLength: DWORD;
    var lpnLengthNeeded: DWORD): BOOL; stdcall; external advapi32 name 'GetKernelObjectSecurity';
  function GetLengthSid(pSid: Pointer): DWORD; stdcall; external advapi32 name 'GetLengthSid';
  function GetNumberOfEventLogRecords(hEventLog: THandle; var NumberOfRecords: DWORD): BOOL; stdcall; external advapi32 name 'GetNumberOfEventLogRecords';
  function GetOldestEventLogRecord(hEventLog: THandle; var OldestRecord: DWORD): BOOL; stdcall; external advapi32 name 'GetOldestEventLogRecord';
  function GetPrivateObjectSecurity(ObjectDescriptor: PSecurityDescriptor;
    SecurityInformation: SECURITY_INFORMATION; ResultantDescriptor: PSecurityDescriptor;
    DescriptorLength: DWORD; var ReturnLength: DWORD): BOOL; stdcall; external advapi32 name 'GetPrivateObjectSecurity';
  function GetSecurityDescriptorControl(pSecurityDescriptor: PSecurityDescriptor;
    var pControl: SECURITY_DESCRIPTOR_CONTROL; var lpdwRevision: DWORD): BOOL; stdcall; external advapi32 name 'GetSecurityDescriptorControl';
  function GetSecurityDescriptorDacl(pSecurityDescriptor: PSecurityDescriptor;
    var lpbDaclPresent: BOOL; var pDacl: PACL; var lpbDaclDefaulted: BOOL): BOOL; stdcall; external advapi32 name 'GetSecurityDescriptorDacl';
  function GetSecurityDescriptorGroup(pSecurityDescriptor: PSecurityDescriptor;
    var pGroup: PSID; var lpbGroupDefaulted: BOOL): BOOL; stdcall; external advapi32 name 'GetSecurityDescriptorGroup';
  function GetSecurityDescriptorLength(pSecurityDescriptor: PSecurityDescriptor): DWORD; stdcall; external advapi32 name 'GetSecurityDescriptorLength';
  function GetSecurityDescriptorOwner(pSecurityDescriptor: PSecurityDescriptor;
    var pOwner: PSID; var lpbOwnerDefaulted: BOOL): BOOL; stdcall; external advapi32 name 'GetSecurityDescriptorOwner';
  function GetSecurityDescriptorSacl(pSecurityDescriptor: PSecurityDescriptor;
    var lpbSaclPresent: BOOL; var pSacl: PACL; var lpbSaclDefaulted: BOOL): BOOL; stdcall; external advapi32 name 'GetSecurityDescriptorSacl';
  function GetSidIdentifierAuthority(pSid: Pointer): PSIDIdentifierAuthority; stdcall; external advapi32 name 'GetSidIdentifierAuthority';
  function GetSidLengthRequired(nSubAuthorityCount: UCHAR): DWORD; stdcall; external advapi32 name 'GetSidLengthRequired';
  function GetSidSubAuthority(pSid: Pointer; nSubAuthority: DWORD): PDWORD; stdcall; external advapi32 name 'GetSidSubAuthority';
  function GetSidSubAuthorityCount(pSid: Pointer): PUCHAR; stdcall; external advapi32 name 'GetSidSubAuthorityCount';
  function GetTokenInformation(TokenHandle: THandle;
    TokenInformationClass: TTokenInformationClass; TokenInformation: Pointer;
    TokenInformationLength: DWORD; var ReturnLength: DWORD): BOOL; stdcall; external advapi32 name 'GetTokenInformation';

  function GetUserNameA(lpBuffer: PAnsiChar; var nSize: DWORD): BOOL; stdcall; external advapi32 name 'GetUserNameA';
  function ImpersonateLoggedOnUser(hToken: THandle): BOOL; stdcall; external advapi32 name 'ImpersonateLoggedOnUser';
  function ImpersonateNamedPipeClient(hNamedPipe: THandle): BOOL; stdcall; external advapi32 name 'ImpersonateNamedPipeClient';
  function ImpersonateSelf(ImpersonationLevel: TSecurityImpersonationLevel): BOOL; stdcall; external advapi32 name 'ImpersonateSelf';
  function InitializeAcl(var pAcl: TACL; nAclLength, dwAclRevision: DWORD): BOOL; stdcall; external advapi32 name 'InitializeAcl';
  function InitializeSecurityDescriptor(pSecurityDescriptor: PSecurityDescriptor;
    dwRevision: DWORD): BOOL; stdcall; external advapi32 name 'InitializeSecurityDescriptor';
  function InitializeSid(Sid: Pointer; const pIdentifierAuthority: TSIDIdentifierAuthority;
    nSubAuthorityCount: Byte): BOOL; stdcall; external advapi32 name 'InitializeSid';
  function InitiateSystemShutdownA(lpMachineName, lpMessage: PAnsiChar;
    dwTimeout: DWORD; bForceAppsClosed, bRebootAfterShutdown: BOOL): BOOL; stdcall; external advapi32 name 'InitiateSystemShutdownA';
  
  function IsTextUnicode(lpBuffer: Pointer; cb: Integer; lpi: PINT): BOOL; stdcall; external advapi32 name 'IsTextUnicode';
  function IsValidAcl(const pAcl: TACL): BOOL; stdcall; external advapi32 name 'IsValidAcl';
  function IsValidSecurityDescriptor(pSecurityDescriptor: PSecurityDescriptor): BOOL; stdcall; external advapi32 name 'IsValidSecurityDescriptor';
  function IsValidSid(pSid: Pointer): BOOL; stdcall; external advapi32 name 'IsValidSid';
  function LogonUserA(lpszUsername, lpszDomain, lpszPassword: PAnsiChar;
    dwLogonType, dwLogonProvider: DWORD; var phToken: THandle): BOOL; stdcall; external advapi32 name 'LogonUserA';

  function LookupAccountNameA(lpSystemName, lpAccountName: PAnsiChar;
    Sid: PSID; var cbSid: DWORD; ReferencedDomainName: PAnsiChar;
    var cbReferencedDomainName: DWORD; var peUse: SID_NAME_USE): BOOL; stdcall; external advapi32 name 'LookupAccountNameA';
  function LookupAccountSidA(lpSystemName: PAnsiChar; Sid: PSID;
    Name: PAnsiChar; var cbName: DWORD; ReferencedDomainName: PAnsiChar;
    var cbReferencedDomainName: DWORD; var peUse: SID_NAME_USE): BOOL; stdcall; external advapi32 name 'LookupAccountSidA';
  function LookupPrivilegeDisplayNameA(lpSystemName, lpName: PAnsiChar;
    lpDisplayName: PAnsiChar; var cbDisplayName, lpLanguageId: DWORD): BOOL; stdcall; external advapi32 name 'LookupPrivilegeDisplayNameA';
  function LookupPrivilegeNameA(lpSystemName: PAnsiChar;
    var lpLuid: TLargeInteger; lpName: PAnsiChar; var cbName: DWORD): BOOL; stdcall; external advapi32 name 'LookupPrivilegeNameA';
  function LookupPrivilegeValueA(lpSystemName, lpName: PAnsiChar;
    var lpLuid: TLargeInteger): BOOL; stdcall; external advapi32 name 'LookupPrivilegeValueA';
  function MakeAbsoluteSD(pSelfRelativeSecurityDescriptor: PSecurityDescriptor;
    pAbsoluteSecurityDescriptor: PSecurityDescriptor; var lpdwAbsoluteSecurityDescriptorSi: DWORD;
    var pDacl: TACL; var lpdwDaclSize: DWORD; var pSacl: TACL;
    var lpdwSaclSize: DWORD; pOwner: PSID; var lpdwOwnerSize: DWORD;
    pPrimaryGroup: Pointer; var lpdwPrimaryGroupSize: DWORD): BOOL; stdcall; external advapi32 name 'MakeAbsoluteSD';
  function MakeSelfRelativeSD(pAbsoluteSecurityDescriptor: PSecurityDescriptor;
    pSelfRelativeSecurityDescriptor: PSecurityDescriptor; var lpdwBufferLength: DWORD): BOOL; stdcall; external advapi32 name 'MakeSelfRelativeSD';
  procedure MapGenericMask; external advapi32 name 'MapGenericMask';
  function NotifyChangeEventLog(hEventLog, hEvent: THandle): BOOL; stdcall; external advapi32 name 'NotifyChangeEventLog';
  function ObjectCloseAuditAlarmA(SubsystemName: PAnsiChar;
    HandleId: Pointer; GenerateOnClose: BOOL): BOOL; stdcall; external advapi32 name 'ObjectCloseAuditAlarmA';
  function ObjectDeleteAuditAlarmA(SubsystemName: PAnsiChar;
    HandleId: Pointer; GenerateOnClose: BOOL): BOOL; stdcall; external advapi32 name 'ObjectDeleteAuditAlarmA';
  function ObjectOpenAuditAlarmA(SubsystemName: PAnsiChar; HandleId: Pointer;
    ObjectTypeName: PAnsiChar; ObjectName: PAnsiChar; pSecurityDescriptor: PSecurityDescriptor;
    ClientToken: THandle; DesiredAccess, GrantedAccess: DWORD;
    var Privileges: TPrivilegeSet; ObjectCreation, AccessGranted: BOOL;
    var GenerateOnClose: BOOL): BOOL; stdcall; external advapi32 name 'ObjectOpenAuditAlarmA';
  function ObjectPrivilegeAuditAlarmA(SubsystemName: PAnsiChar;
    HandleId: Pointer; ClientToken: THandle; DesiredAccess: DWORD;
    var Privileges: TPrivilegeSet; AccessGranted: BOOL): BOOL; stdcall; external advapi32 name 'ObjectPrivilegeAuditAlarmA';
  function OpenProcessToken(ProcessHandle: THandle; DesiredAccess: DWORD;
    var TokenHandle: THandle): BOOL; stdcall; external advapi32 name 'OpenProcessToken';
  function OpenThreadToken(ThreadHandle: THandle; DesiredAccess: DWORD;
    OpenAsSelf: BOOL; var TokenHandle: THandle): BOOL; stdcall; external advapi32 name 'OpenThreadToken';
  function PrivilegeCheck(ClientToken: THandle; const RequiredPrivileges: TPrivilegeSet;
    var pfResult: BOOL): BOOL; stdcall; external advapi32 name 'PrivilegeCheck';
  function PrivilegedServiceAuditAlarmA(SubsystemName, ServiceName: PAnsiChar;
    ClientToken: THandle; var Privileges: TPrivilegeSet; AccessGranted: BOOL): BOOL; stdcall; external advapi32 name 'PrivilegedServiceAuditAlarmA';
  function RevertToSelf: BOOL; stdcall; external advapi32 name 'RevertToSelf';
  function SetAclInformation(var pAcl: TACL; pAclInformation: Pointer;
    nAclInformationLength: DWORD; dwAclInformationClass: TAclInformationClass): BOOL; stdcall; external advapi32 name 'SetAclInformation';
  function SetFileSecurityA(lpFileName: PAnsiChar; SecurityInformation: SECURITY_INFORMATION;
    pSecurityDescriptor: PSecurityDescriptor): BOOL; stdcall; external advapi32 name 'SetFileSecurityA';
  function SetKernelObjectSecurity(Handle: THandle; SecurityInformation: SECURITY_INFORMATION;
    SecurityDescriptor: PSecurityDescriptor): BOOL; stdcall; external advapi32 name 'SetKernelObjectSecurity';
  function SetPrivateObjectSecurity(SecurityInformation: SECURITY_INFORMATION;
    ModificationDescriptor: PSecurityDescriptor; var ObjectsSecurityDescriptor: PSecurityDescriptor;
    const GenericMapping: TGenericMapping; Token: THandle): BOOL; stdcall; external advapi32 name 'SetPrivateObjectSecurity';
  function SetPrivateObjectSecurityEx(SecurityInformation: SECURITY_INFORMATION;
    ModificationDescriptor: PSecurityDescriptor; var ObjectsSecurityDescriptor: PSecurityDescriptor;
    AutoInheritFlags: ULONG; const GenericMapping: TGenericMapping; Token: THandle): BOOL; stdcall; external advapi32 name 'SetPrivateObjectSecurityEx';
  function SetSecurityDescriptorControl(pSecurityDescriptor: PSecurityDescriptor;
    ControlBitsOfInterest, ControlBitsToSet: SECURITY_DESCRIPTOR_CONTROL): BOOL; stdcall; external advapi32 name 'SetSecurityDescriptorControl';
  function SetSecurityDescriptorDacl(pSecurityDescriptor: PSecurityDescriptor;
    bDaclPresent: BOOL; pDacl: PACL; bDaclDefaulted: BOOL): BOOL; stdcall; external advapi32 name 'SetSecurityDescriptorDacl';
  function SetSecurityDescriptorGroup(pSecurityDescriptor: PSecurityDescriptor;
    pGroup: PSID; bGroupDefaulted: BOOL): BOOL; stdcall; external advapi32 name 'SetSecurityDescriptorGroup';
  function SetSecurityDescriptorOwner(pSecurityDescriptor: PSecurityDescriptor;
    pOwner: PSID; bOwnerDefaulted: BOOL): BOOL; stdcall; external advapi32 name 'SetSecurityDescriptorOwner';
  function SetSecurityDescriptorSacl(pSecurityDescriptor: PSecurityDescriptor;
    bSaclPresent: BOOL; pSacl: PACL; bSaclDefaulted: BOOL): BOOL; stdcall; external advapi32 name 'SetSecurityDescriptorSacl';
  function SetThreadToken(Thread: PHandle; Token: THandle): BOOL; stdcall; external advapi32 name 'SetThreadToken';
  function SetTokenInformation(TokenHandle: THandle;
    TokenInformationClass: TTokenInformationClass; TokenInformation: Pointer;
    TokenInformationLength: DWORD): BOOL; stdcall; external advapi32 name 'SetTokenInformation';

const
  TOKEN_ASSIGN_PRIMARY = $0001;
  TOKEN_DUPLICATE = $0002;
  TOKEN_IMPERSONATE = $0004;
  TOKEN_QUERY = $0008;
  TOKEN_QUERY_SOURCE = $0010;
  TOKEN_ADJUST_PRIVILEGES = $0020;
  TOKEN_ADJUST_GROUPS = $0040;
  TOKEN_ADJUST_DEFAULT = $0080;
  TOKEN_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED or TOKEN_ASSIGN_PRIMARY or
    TOKEN_DUPLICATE or TOKEN_IMPERSONATE or TOKEN_QUERY or
    TOKEN_QUERY_SOURCE or TOKEN_ADJUST_PRIVILEGES or TOKEN_ADJUST_GROUPS or
    TOKEN_ADJUST_DEFAULT);
  TOKEN_READ = (STANDARD_RIGHTS_READ or TOKEN_QUERY);
  TOKEN_WRITE = (STANDARD_RIGHTS_WRITE or TOKEN_ADJUST_PRIVILEGES or
    TOKEN_ADJUST_GROUPS or TOKEN_ADJUST_DEFAULT);
  TOKEN_EXECUTE = STANDARD_RIGHTS_EXECUTE;

implementation

end.
