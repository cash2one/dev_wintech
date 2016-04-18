
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_zoomhandler;
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

  procedure InitCefZoomHandler(ACefZoomHandler: PCefIntfZoomHandler; ACefClientObject: PCefClientObject);

implementation

uses
  BaseApp, cef_app, cef_apilib;

function cef_zoom_handler_on_get_zoom_level(self: PCefZoomHandler;
  browser: PCefBrowser; const url: PCefString; zoomLevel: PDouble): Integer; stdcall;
begin
  Result := 0;
end;

function cef_zoom_handler_on_set_zoom_level(self: PCefZoomHandler;
  browser: PCefBrowser; const url: PCefString; zoomLevel: Double): Integer; stdcall;
begin
  Result := 0;
end;

procedure InitCefZoomHandler(ACefZoomHandler: PCefIntfZoomHandler; ACefClientObject: PCefClientObject);
begin
  ACefZoomHandler.IntfPtr := @ACefZoomHandler.CefZoomHandler;
  ACefZoomHandler.CefZoomHandler.base.size := SizeOf(TCefZoomHandler);
  ACefZoomHandler.CefZoomHandler.base.add_ref := @cef_base_add_ref;
  ACefZoomHandler.CefZoomHandler.base.release := @cef_base_release;
  ACefZoomHandler.CefZoomHandler.base.get_refct := @cef_base_get_refct;

  ACefZoomHandler.CefZoomHandler.on_get_zoom_level := @cef_zoom_handler_on_get_zoom_level;
  ACefZoomHandler.CefZoomHandler.on_set_zoom_level := @cef_zoom_handler_on_set_zoom_level;
  ACefZoomHandler.CefClientObj := ACefClientObject;
end;

end.
