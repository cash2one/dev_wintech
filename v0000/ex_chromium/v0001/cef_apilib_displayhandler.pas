
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_displayhandler;
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

  procedure InitCefDisplayHandler(ACefDisplayHandler: PCefIntfDisplayHandler; ACefClientObject: PCefClientObject);

implementation

uses
  cef_apilib;
  
procedure cef_display_handler_on_nav_state_change(self: PCefDisplayHandler;
  browser: PCefBrowser; canGoBack, canGoForward: Integer); stdcall;
begin

end;

procedure cef_display_handler_on_address_change(self: PCefDisplayHandler;
  browser: PCefBrowser; frame: PCefFrame; const url: PCefString); stdcall;
begin

end;

procedure cef_display_handler_on_contents_size_change(self: PCefDisplayHandler;
  browser: PCefBrowser; frame: PCefFrame; width, height: Integer); stdcall;
begin

end;

procedure cef_display_handler_on_title_change(self: PCefDisplayHandler;
  browser: PCefBrowser; const title: PCefString); stdcall;
begin

end;

procedure cef_display_handler_on_favicon_urlchange(self: PCefDisplayHandler;
  browser: PCefBrowser; icon_urls: TCefStringList); stdcall;
begin

end;

function cef_display_handler_on_tooltip(self: PCefDisplayHandler;
  browser: PCefBrowser; text: PCefString): Integer; stdcall;
var
  tmpStr: string;
begin
  Result := 0;
  tmpStr := CefString(text);
  if tmpStr <> '' then
  begin
    //if tmpStr = '1' then
    begin
      if browser <> nil then
      begin
//        browser.set_focus(browser, 1);
//        browser.send_focus_event(browser, 1);
      end;
      Result := Length(tmpStr);
      Result := 0;
    end;
  end;
end;

procedure cef_display_handler_on_status_message(self: PCefDisplayHandler;
  browser: PCefBrowser; const value: PCefString; kind: TCefHandlerStatusType); stdcall;
begin

end;

function cef_display_handler_on_console_message(self: PCefDisplayHandler;
    browser: PCefBrowser; const message: PCefString;
    const source: PCefString; line: Integer): Integer; stdcall;
begin
  Result := 0;
end;

procedure InitCefDisplayHandler(ACefDisplayHandler: PCefIntfDisplayHandler; ACefClientObject: PCefClientObject);
begin
  ACefDisplayHandler.IntfPtr := @ACefDisplayHandler.CefDisplayHandler;
  ACefDisplayHandler.CefDisplayHandler.base.size := SizeOf(TCefDisplayHandler);
  ACefDisplayHandler.CefDisplayHandler.base.add_ref := @cef_base_add_ref;
  ACefDisplayHandler.CefDisplayHandler.base.release := @cef_base_release;
  ACefDisplayHandler.CefDisplayHandler.base.get_refct := @cef_base_get_refct;

  ACefDisplayHandler.CefDisplayHandler.on_nav_state_change := @cef_display_handler_on_nav_state_change;
  ACefDisplayHandler.CefDisplayHandler.on_address_change := @cef_display_handler_on_address_change;
  ACefDisplayHandler.CefDisplayHandler.on_contents_size_change := @cef_display_handler_on_contents_size_change;
  ACefDisplayHandler.CefDisplayHandler.on_title_change := @cef_display_handler_on_title_change;
  ACefDisplayHandler.CefDisplayHandler.on_favicon_urlchange := @cef_display_handler_on_favicon_urlchange;
  ACefDisplayHandler.CefDisplayHandler.on_tooltip := @cef_display_handler_on_tooltip;
  ACefDisplayHandler.CefDisplayHandler.on_status_message := @cef_display_handler_on_status_message;
  ACefDisplayHandler.CefDisplayHandler.on_console_message := @cef_display_handler_on_console_message;

  ACefDisplayHandler.CefClientObj := ACefClientObject;
end;

end.
