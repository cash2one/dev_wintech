
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_menuhandler;
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

  procedure InitCefMenuHandler(ACefMenuHandler: PCefIntfMenuHandler; ACefClientObject: PCefClientObject);

implementation

uses
  cef_apilib;

function cef_menu_handler_on_before_menu(self: PCefMenuHandler;
  browser: PCefBrowser; const menuInfo: PCefMenuInfo): Integer; stdcall;
begin
  Result := 0;
//  log('cef_apilib.pas', 'cef_menu_handler_on_before_menu');
end;

procedure cef_menu_handler_get_menu_label(self: PCefMenuHandler;
  browser: PCefBrowser; menuId: TCefMenuId; var label_: TCefString); stdcall;
begin
//  log('cef_apilib.pas', 'cef_menu_handler_get_menu_label');
end;

function cef_menu_handler_on_menu_action(self: PCefMenuHandler;
  browser: PCefBrowser; menuId: TCefMenuId): Integer; stdcall;
begin
  Result := 0;
//  log('cef_apilib.pas', 'cef_menu_handler_on_menu_action');
end;

procedure InitCefMenuHandler(ACefMenuHandler: PCefIntfMenuHandler; ACefClientObject: PCefClientObject);
begin
  ACefMenuHandler.IntfPtr := @ACefMenuHandler.CefMenuHandler;
  ACefMenuHandler.CefMenuHandler.base.size := SizeOf(TCefMenuHandler);
  ACefMenuHandler.CefMenuHandler.base.add_ref := @cef_base_add_ref;
  ACefMenuHandler.CefMenuHandler.base.release := @cef_base_release;
  ACefMenuHandler.CefMenuHandler.base.get_refct := @cef_base_get_refct;

  ACefMenuHandler.CefMenuHandler.on_before_menu := @cef_menu_handler_on_before_menu;
  ACefMenuHandler.CefMenuHandler.get_menu_label := @cef_menu_handler_get_menu_label;
  ACefMenuHandler.CefMenuHandler.on_menu_action := @cef_menu_handler_on_menu_action;
  ACefMenuHandler.CefClientObj := ACefClientObject;
end;

end.
