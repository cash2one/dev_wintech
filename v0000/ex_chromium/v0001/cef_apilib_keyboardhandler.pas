
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_keyboardhandler;
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

  procedure InitCefKeyboardHandler(ACefKeyboardHandler: PCefIntfKeyboardHandler; ACefClientObject: PCefClientObject);

implementation

uses
  cef_apilib;

function cef_keyboard_handler_on_key_event(self: PCefKeyboardHandler;
  browser: PCefBrowser; kind: TCefHandlerKeyEventType;
  code, modifiers, isSystemKey, isAfterJavaScript: Integer): Integer; stdcall;
begin
//  log('cef_apilib.pas', 'cef_keyboard_handler_on_key_event');
  Result := 0;
end;

procedure InitCefKeyboardHandler(ACefKeyboardHandler: PCefIntfKeyboardHandler; ACefClientObject: PCefClientObject);
begin
  ACefKeyboardHandler.IntfPtr := @ACefKeyboardHandler.CefKeyboardHandler;
  ACefKeyboardHandler.CefKeyboardHandler.base.size := SizeOf(TCefKeyboardHandler);
  ACefKeyboardHandler.CefKeyboardHandler.base.add_ref := @cef_base_add_ref;
  ACefKeyboardHandler.CefKeyboardHandler.base.release := @cef_base_release;
  ACefKeyboardHandler.CefKeyboardHandler.base.get_refct := @cef_base_get_refct;
  ACefKeyboardHandler.CefKeyboardHandler.on_key_event := @cef_keyboard_handler_on_key_event;
  ACefKeyboardHandler.CefClientObj := ACefClientObject;
end;

end.
