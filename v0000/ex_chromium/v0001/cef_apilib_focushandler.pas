
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_focushandler;
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

  procedure InitCefFocusHandler(ACefFocusHandler: PCefIntfFocusHandler; ACefClientObject: PCefClientObject);

implementation

uses
  cef_apilib;
  
procedure cef_focus_handler_on_take_focus(self: PCefFocusHandler;
  browser: PCefBrowser; next: Integer); stdcall;
begin

end;

function cef_focus_handler_on_set_focus(self: PCefFocusHandler;
  browser: PCefBrowser; source: TCefHandlerFocusSource): Integer; stdcall;
begin
  Result := 0;
end;

procedure cef_focus_handler_on_focused_node_changed(self: PCefFocusHandler;
  browser: PCefBrowser; frame: PCefFrame; node: PCefDomNode); stdcall;
begin

end;

procedure InitCefFocusHandler(ACefFocusHandler: PCefIntfFocusHandler; ACefClientObject: PCefClientObject);
begin
  ACefFocusHandler.IntfPtr := @ACefFocusHandler.CefFocusHandler;
  ACefFocusHandler.CefFocusHandler.base.size := SizeOf(TCefFocusHandler);
  ACefFocusHandler.CefFocusHandler.base.add_ref := @cef_base_add_ref;
  ACefFocusHandler.CefFocusHandler.base.release := @cef_base_release;
  ACefFocusHandler.CefFocusHandler.base.get_refct := @cef_base_get_refct;

  ACefFocusHandler.CefFocusHandler.on_take_focus := @cef_focus_handler_on_take_focus;
  ACefFocusHandler.CefFocusHandler.on_set_focus := @cef_focus_handler_on_set_focus;
  ACefFocusHandler.CefFocusHandler.on_focused_node_changed := @cef_focus_handler_on_focused_node_changed;

  ACefFocusHandler.CefClientObj := ACefClientObject;
end;

end.
