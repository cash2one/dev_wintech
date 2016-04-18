
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_draghandler;
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

  procedure InitCefDragHandler(ACefDragHandler: PCefIntfDragHandler; ACefClientObject: PCefClientObject);

implementation

uses
  cef_apilib;

function cef_drag_handler_on_drag_start(self: PCefDragHandler; browser: PCefBrowser;
  dragData: PCefDragData; mask: TCefDragOperations): Integer; stdcall;
begin
  Result := 0;
end;

function cef_drag_handler_on_drag_enter(self: PCefDragHandler; browser: PCefBrowser;
  dragData: PCefDragData; mask: TCefDragOperations): Integer; stdcall;
begin
  Result := 0;
end;

procedure InitCefDragHandler(ACefDragHandler: PCefIntfDragHandler; ACefClientObject: PCefClientObject);
begin
  ACefDragHandler.IntfPtr := @ACefDragHandler.CefDragHandler;
  ACefDragHandler.CefDragHandler.base.size := SizeOf(TCefDragHandler);
  ACefDragHandler.CefDragHandler.base.add_ref := @cef_base_add_ref;
  ACefDragHandler.CefDragHandler.base.release := @cef_base_release;
  ACefDragHandler.CefDragHandler.base.get_refct := @cef_base_get_refct;

  ACefDragHandler.CefDragHandler.on_drag_start := @cef_drag_handler_on_drag_start;
  ACefDragHandler.CefDragHandler.on_drag_enter := @cef_drag_handler_on_drag_enter;
  ACefDragHandler.CefClientObj := ACefClientObject;
end;

end.
