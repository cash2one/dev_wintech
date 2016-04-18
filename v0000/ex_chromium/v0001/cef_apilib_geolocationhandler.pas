
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_geolocationhandler;
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

  procedure InitCefGeolocationHandler(ACefGeolocationHandler: PCefIntfGeolocationHandler; ACefClientObject: PCefClientObject);

implementation

uses
  BaseApp, cef_app, cef_apilib;

procedure cef_geolocation_handler_on_request_geolocation_permission(self: PCefGeolocationHandler;
  browser: PCefBrowser; const requesting_url: PCefString; request_id: Integer;
  callback: PCefGeolocationCallback); stdcall;
begin

end;

procedure cef_geolocation_handler_on_cancel_geolocation_permission(self: PCefGeolocationHandler;
  browser: PCefBrowser; const requesting_url: PCefString; request_id: Integer); stdcall;
begin

end;

procedure cef_get_geolocation_callback_on_location_update(
  self: PCefGetGeolocationCallback; const position: PCefGeoposition); stdcall;
begin

end;

procedure InitCefGeolocationHandler(ACefGeolocationHandler: PCefIntfGeolocationHandler; ACefClientObject: PCefClientObject);
begin
  ACefGeolocationHandler.IntfPtr := @ACefGeolocationHandler.CefGeolocationHandler;
  ACefGeolocationHandler.CefGeolocationHandler.base.size := SizeOf(TCefGeolocationHandler);
  ACefGeolocationHandler.CefGeolocationHandler.base.add_ref := @cef_base_add_ref;
  ACefGeolocationHandler.CefGeolocationHandler.base.release := @cef_base_release;
  ACefGeolocationHandler.CefGeolocationHandler.base.get_refct := @cef_base_get_refct;

  ACefGeolocationHandler.CefGeolocationHandler.on_request_geolocation_permission :=
    cef_geolocation_handler_on_request_geolocation_permission;
  ACefGeolocationHandler.CefGeolocationHandler.on_cancel_geolocation_permission :=
    cef_geolocation_handler_on_cancel_geolocation_permission;
  ACefGeolocationHandler.CefClientObj := ACefClientObject;
end;

end.
