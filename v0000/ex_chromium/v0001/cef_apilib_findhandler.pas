
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_findhandler;
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
  
  procedure InitCefFindHandler(ACefFindHandler: PCefIntfFindHandler; ACefClientObject: PCefClientObject);

implementation

uses
  cef_apilib;
  
procedure cef_find_handler_on_find_result(self: PCefFindHandler; browser: PCefBrowser;
  identifier, count: Integer; const selectionRect: PCefRect; activeMatchOrdinal,
  finalUpdate: Integer); stdcall;
begin

end;

procedure InitCefFindHandler(ACefFindHandler: PCefIntfFindHandler; ACefClientObject: PCefClientObject);
begin
  ACefFindHandler.IntfPtr := @ACefFindHandler.CefFindHandler;
  ACefFindHandler.CefFindHandler.base.size := SizeOf(TCefFindHandler);
  ACefFindHandler.CefFindHandler.base.add_ref := @cef_base_add_ref;
  ACefFindHandler.CefFindHandler.base.release := @cef_base_release;
  ACefFindHandler.CefFindHandler.base.get_refct := @cef_base_get_refct;

  ACefFindHandler.CefFindHandler.on_find_result := @cef_find_handler_on_find_result;
  ACefFindHandler.CefClientObj := ACefClientObject;
end;

end.
