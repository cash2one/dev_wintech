
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_jsv8;
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

  procedure InitCefJsDialogHandler(ACefJsDialogHandler: PCefIntfJsDialogHandler; ACefClientObject: PCefClientObject);
  procedure InitCefV8contextHandler(ACefV8contextHandler: PCefIntfV8contextHandler; ACefClientObject: PCefClientObject);

implementation

uses
  BaseApp, cef_app,
  cef_apilib;

function cef_jsdialog_handler_on_jsalert(self: PCefJsDialogHandler;
  browser: PCefBrowser; frame: PCefFrame; const message: PCefString): Integer; stdcall;
begin
  Result := 0;
  //sdlog('cef_apilib.pas', 'cef_jsdialog_handler_on_jsalert');
end;

function cef_jsdialog_handler_on_jsconfirm(self: PCefJsDialogHandler;
  browser: PCefBrowser; frame: PCefFrame; const message: PCefString;
  var retval: Integer): Integer; stdcall;
begin
  Result := 0;
  //sdlog('cef_apilib.pas', 'cef_jsdialog_handler_on_jsconfirm');
end;

function cef_jsdialog_handler_on_jsprompt(self: PCefJsDialogHandler;
  browser: PCefBrowser; frame: PCefFrame; const message, defaultValue: PCefString;
  var retval: Integer; var return: TCefString): Integer; stdcall;
begin
  Result := 0;
  //sdlog('cef_apilib.pas', 'cef_jsdialog_handler_on_jsprompt');
end;

procedure InitCefJsDialogHandler(ACefJsDialogHandler: PCefIntfJsDialogHandler; ACefClientObject: PCefClientObject);
begin
  ACefJsDialogHandler.IntfPtr := @ACefJsDialogHandler.CefJsDialogHandler;
  ACefJsDialogHandler.CefJsDialogHandler.base.size := SizeOf(TCefJsDialogHandler);
  ACefJsDialogHandler.CefJsDialogHandler.base.add_ref := @cef_base_add_ref;
  ACefJsDialogHandler.CefJsDialogHandler.base.release := @cef_base_release;
  ACefJsDialogHandler.CefJsDialogHandler.base.get_refct := @cef_base_get_refct;

  ACefJsDialogHandler.CefJsDialogHandler.on_jsalert := @cef_jsdialog_handler_on_jsalert;
  ACefJsDialogHandler.CefJsDialogHandler.on_jsconfirm := @cef_jsdialog_handler_on_jsconfirm;
  ACefJsDialogHandler.CefJsDialogHandler.on_jsprompt := @cef_jsdialog_handler_on_jsprompt;
  ACefJsDialogHandler.CefClientObj := ACefClientObject;
end;

procedure cef_v8_context_handler_on_context_created(self: PCefV8contextHandler;
  browser: PCefBrowser; frame: PCefFrame; context: PCefv8Context); stdcall;
begin
//**  log('cef_apilib.pas', 'cef_v8_context_handler_on_context_created');
end;

procedure cef_v8_context_handler_on_context_released(
  self: PCefV8contextHandler; browser: PCefBrowser; frame: PCefFrame;
  context: PCefv8Context); stdcall;
begin
//**  log('cef_apilib.pas', 'cef_v8_context_handler_on_context_released');
end;

procedure cef_v8_context_handler_on_uncaught_exception(self: PCefV8contextHandler;
  browser: PCefBrowser; frame: PCefFrame; context: PCefv8Context;
  exception: PCefV8Exception; stackTrace: PCefV8StackTrace); stdcall;
begin
//  log('cef_apilib.pas', 'cef_v8_context_handler_on_uncaught_exception');
end;

procedure InitCefV8contextHandler(ACefV8contextHandler: PCefIntfV8contextHandler; ACefClientObject: PCefClientObject);
begin
  ACefV8contextHandler.IntfPtr := @ACefV8contextHandler.CefV8contextHandler;
  ACefV8contextHandler.CefV8contextHandler.base.size := SizeOf(TCefV8contextHandler);
  ACefV8contextHandler.CefV8contextHandler.base.add_ref := @cef_base_add_ref;
  ACefV8contextHandler.CefV8contextHandler.base.release := @cef_base_release;
  ACefV8contextHandler.CefV8contextHandler.base.get_refct := @cef_base_get_refct;

  ACefV8contextHandler.CefV8contextHandler.on_context_created := @cef_v8_context_handler_on_context_created;
  ACefV8contextHandler.CefV8contextHandler.on_context_released := @cef_v8_context_handler_on_context_released;
  ACefV8contextHandler.CefV8contextHandler.on_uncaught_exception := @cef_v8_context_handler_on_uncaught_exception;
  ACefV8contextHandler.CefClientObj := ACefClientObject;
end;

end.
