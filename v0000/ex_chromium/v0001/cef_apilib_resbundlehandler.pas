
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_resbundlehandler;
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
                         
  procedure InitCefAppResourceBundleHandler(ACefResourceBundleHandler: PCefIntfResourceBundleHandler);

implementation

uses
  BaseApp, cef_app, cef_apilib;

function cef_resource_bundle_handler_get_localized_string(self: PCefResourceBundleHandler;
  message_id: Integer; string_val: PCefString): Integer; stdcall;
var
  str: ustring;
begin
  //sdlog('cef_apilib.pas', 'cef_resource_bundle_handler_get_localized_string');
  Result := 0;
  if Result <> 0 then
    string_val^ := CefString(str);
end;

function cef_resource_bundle_handler_get_data_resource(self: PCefResourceBundleHandler;
  resource_id: Integer; var data: Pointer; var data_size: Cardinal): Integer; stdcall;
begin
  Result := 0;
end;

procedure InitCefAppResourceBundleHandler(ACefResourceBundleHandler: PCefIntfResourceBundleHandler);
begin
  ACefResourceBundleHandler.IntfPtr := @ACefResourceBundleHandler.CefResourceBundleHandler;
  ACefResourceBundleHandler.CefResourceBundleHandler.base.size := SizeOf(TCefResourceBundleHandler);
  ACefResourceBundleHandler.CefResourceBundleHandler.base.add_ref := @cef_base_add_ref;
  ACefResourceBundleHandler.CefResourceBundleHandler.base.release := @cef_base_release;
  ACefResourceBundleHandler.CefResourceBundleHandler.base.get_refct := @cef_base_get_refct;
  ACefResourceBundleHandler.CefResourceBundleHandler.get_localized_string := @cef_resource_bundle_handler_get_localized_string;
  ACefResourceBundleHandler.CefResourceBundleHandler.get_data_resource := @cef_resource_bundle_handler_get_data_resource;
end;

end.
