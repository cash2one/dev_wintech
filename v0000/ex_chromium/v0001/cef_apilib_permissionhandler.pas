
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_permissionhandler;
{$ALIGN ON}
{$MINENUMSIZE 4}
{$I cef.inc}

interface

uses
  Windows, Messages, Sysutils, //Classes,
  //sdlogutils,
  Cef_api,
  cef_type,
  cef_apiobj;
  
  procedure InitCefPermissionHandler(ACefPermissionHandler: PCefIntfPermissionHandler; ACefClientObject: PCefClientObject);

implementation
                
uses
  cef_apilib;
  
function cef_permission_handler_on_before_script_extension_load(self: PCefPermissionHandler;
  browser: PCefBrowser; frame: PCefFrame; const extensionName: PCefString): Integer; stdcall;
begin
  Result := 0;
  //sdlog('cef_apilib.pas', 'cef_permission_handler_on_before_script_extension_load');
end;

procedure InitCefPermissionHandler(ACefPermissionHandler: PCefIntfPermissionHandler; ACefClientObject: PCefClientObject);
begin
  ACefPermissionHandler.IntfPtr := @ACefPermissionHandler.CefPermissionHandler;
  ACefPermissionHandler.CefPermissionHandler.base.size := SizeOf(TCefPermissionHandler);
  ACefPermissionHandler.CefPermissionHandler.base.add_ref := @cef_base_add_ref;
  ACefPermissionHandler.CefPermissionHandler.base.release := @cef_base_release;
  ACefPermissionHandler.CefPermissionHandler.base.get_refct := @cef_base_get_refct;

  ACefPermissionHandler.CefPermissionHandler.on_before_script_extension_load :=
      @cef_permission_handler_on_before_script_extension_load;
  ACefPermissionHandler.CefClientObj := ACefClientObject;
end;

end.
