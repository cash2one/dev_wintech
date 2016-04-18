
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_printhandler;
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

  procedure InitCefPrintHandler(ACefPrintHandler: PCefIntfPrintHandler; ACefClientObject: PCefClientObject);

implementation
               
uses
  cef_apilib;
  
function cef_print_handler_get_print_options(self: PCefPrintHandler;
    browser: PCefBrowser; printOptions: PCefPrintOptions): Integer; stdcall;
begin
  Result := 0;
end;

function cef_print_handler_get_print_header_footer(self: PCefPrintHandler;
  browser: PCefBrowser; frame: PCefFrame; const printInfo: PCefPrintInfo;
  const url: PCefString; const title: PCefString; currentPage,
  maxPages: Integer; var topLeft, topCenter, topRight, bottomLeft,
  bottomCenter, bottomRight: TCefString): Integer; stdcall;
begin
  Result := 0;
end;

procedure InitCefPrintHandler(ACefPrintHandler: PCefIntfPrintHandler; ACefClientObject: PCefClientObject);
begin
  ACefPrintHandler.IntfPtr := @ACefPrintHandler.CefPrintHandler;
  ACefPrintHandler.CefPrintHandler.base.size := SizeOf(TCefPrintHandler);
  ACefPrintHandler.CefPrintHandler.base.add_ref := @cef_base_add_ref;
  ACefPrintHandler.CefPrintHandler.base.release := @cef_base_release;
  ACefPrintHandler.CefPrintHandler.base.get_refct := @cef_base_get_refct;

  ACefPrintHandler.CefPrintHandler.get_print_options := @cef_print_handler_get_print_options;
  ACefPrintHandler.CefPrintHandler.get_print_header_footer := @cef_print_handler_get_print_header_footer;

  ACefPrintHandler.CefClientObj := ACefClientObject;
end;

end.
