unit win.userRight;

interface

implementation

uses
  shlobj,
  Windows;

type
  WELL_KNOWN_SID_TYPE = (
    WinNullSid,
    WinWorldSid,
    WinLocalSid,
    WinCreatorOwnerSid,
    WinCreatorGroupSid,
    WinCreatorOwnerServerSid,
    WinCreatorGroupServerSid,
    WinNtAuthoritySid,
    WinDialupSid,
    WinNetworkSid,
    WinBatchSid,
    WinInteractiveSid,
    WinServiceSid,
    WinAnonymousSid,
    WinProxySid,
    WinEnterpriseControllersSid,
    WinSelfSid,
    WinAuthenticatedUserSid,
    WinRestrictedCodeSid,
    WinTerminalServerSid,
    WinRemoteLogonIdSid,
    WinLogonIdsSid,
    WinLocalSystemSid,
    WinLocalServiceSid,
    WinNetworkServiceSid,
    WinBuiltinDomainSid,
    WinBuiltinAdministratorsSid,
    WinBuiltinUsersSid,
    WinBuiltinGuestsSid,
    WinBuiltinPowerUsersSid,
    WinBuiltinAccountOperatorsSid,
    WinBuiltinSystemOperatorsSid,
    WinBuiltinPrintOperatorsSid,
    WinBuiltinBackupOperatorsSid,
    WinBuiltinReplicatorSid,
    WinBuiltinPreWindows2000CompatibleAccessSid,
    WinBuiltinRemoteDesktopUsersSid,
    WinBuiltinNetworkConfigurationOperatorsSid,
    WinAccountAdministratorSid,
    WinAccountGuestSid,
    WinAccountKrbtgtSid,
    WinAccountDomainAdminsSid,
    WinAccountDomainUsersSid,
    WinAccountDomainGuestsSid,
    WinAccountComputersSid,
    WinAccountControllersSid,
    WinAccountCertAdminsSid,
    WinAccountSchemaAdminsSid,
    WinAccountEnterpriseAdminsSid,
    WinAccountPolicyAdminsSid,
    WinAccountRasAndIasServersSid,
    WinNTLMAuthenticationSid,
    WinDigestAuthenticationSid,
    WinSChannelAuthenticationSid,
    WinThisOrganizationSid,
    WinOtherOrganizationSid,
    WinBuiltinIncomingForestTrustBuildersSid,
    WinBuiltinPerfMonitoringUsersSid,
    WinBuiltinPerfLoggingUsersSid,
    WinBuiltinAuthorizationAccessSid,
    WinBuiltinTerminalServerLicenseServersSid
  );
  {$EXTERNALSYM WELL_KNOWN_SID_TYPE}
  TWellKnownSidType = WELL_KNOWN_SID_TYPE;
 
function CreateWellKnownSid(WellKnownSidType: WELL_KNOWN_SID_TYPE; DomainSid: PSID; pSid: PSID; var cbSid: DWORD): BOOL; stdcall;
    external advapi32 name 'CreateWellKnownSid';
function CheckTokenMembership(TokenHandle: THANDLE; SidToCheck: PSID; var IsMember: BOOL): BOOL; stdcall;
    external advapi32 name 'CheckTokenMembership';

(*//
procedure TForm4.Button1Click(Sender: TObject);
var
  pIsAdmin: LongBool;
  pElevationType: TTokenElevationType;
begin
  if GetProcessElevation(pElevationType, pIsAdmin) then
  begin
    case pElevationType of
      TokenElevationTypeLimited: ShowMessage('这是一个受限用户');
      TokenElevationTypeFull: ShowMessage('这是一个拥有管理员权限的用户');
      TokenElevationTypeDefault: ShowMessage('这是一个默认的用户');
    end;
  end;
end;  
//*)
(*//
function GetProcessElevation(var pElevationType: TTokenElevationType; var pIsAdmin: LongBool): Boolean;
const
  SECURITY_MAX_SID_SIZE = 68;
var
  hToken: THandle;
  r: Cardinal;
  adminSID: array [0 .. SECURITY_MAX_SID_SIZE - 1] of byte;
  sidSize: Cardinal;
  e: Integer;
  hUnfilteredToken: THandle;
  tmpTokenInfoClass: TTokenInformationClass;
begin
  Result := False;
  sidSize := SizeOf(adminSID);
  tmpTokenInfoClass := Windows.TokenElevationType;
  if OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, hToken) and
     Windows.GetTokenInformation(hToken, tmpTokenInfoClass, @pElevationType, SizeOf(pElevationType), r) and
     CreateWellKnownSid(WinBuiltinAdministratorsSid, nil, PSid(@adminSID), sidSize) then
  begin
    case pElevationType of
      TokenElevationTypeLimited: begin
        if GetTokenInformation(hToken, TokenLinkedToken, @hUnfilteredToken, SizeOf(hUnfilteredToken), r) and
           (CheckTokenMembership(hUnfilteredToken, PSid(@adminSID), pIsAdmin)) then
        begin
          Result := true;
          CloseHandle(hUnfilteredToken);
        end;
      end;
      else
      begin
        pIsAdmin := IsUserAnAdmin();
        Result := true;
      end;
    end;
  end else
  begin
    e := GetLastError();
    if e = 0 then
    begin
      GetTickCount;
    end;
  end;
  CloseHandle(hToken); 
end;
//*)
  
end.
