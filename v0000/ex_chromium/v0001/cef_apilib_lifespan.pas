
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_lifespan;
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

  procedure InitCefLifeSpan(ACefLifeSpanHandler: PCefIntfLifeSpanHandler; ACefClientObject: PCefClientObject);

implementation

uses
  BaseApp, cef_app, cef_apilib;

function cef_life_span_handler_on_before_popup(self: PCefLifeSpanHandler; parentBrowser: PCefBrowser;
   const popupFeatures: PCefPopupFeatures; windowInfo: PCefWindowInfo; const url: PCefString;
   var client: PCefClient; settings: PCefBrowserSettings): Integer; stdcall;
var
  tmpurl: string;
begin
  tmpurl := CefString(url);
  //sdlog('cef_apilib.pas', 'cef_life_span_handler_on_before_popup:' + tmpurl);
  if pos('chrome-devtools://', tmpurl) = 1 then
  begin
    // show dev-tool
  end;
  Result := 0;
end;

procedure cef_life_span_handler_on_after_created(self: PCefLifeSpanHandler; browser: PCefBrowser); stdcall;
begin
  //sdlog('cef_apilib.pas', 'cef_life_span_handler_on_after_created');
  if browser <> nil then
  begin
    if browser.is_popup(browser) = 0 then
    begin
      if PCefExLifeSpanHandler(Self).CefClientObj.CefBrowser = nil then
      begin
        PCefExLifeSpanHandler(Self).CefClientObj.CefBrowser := browser;

        browser.set_size(browser, PET_VIEW, PCefExLifeSpanHandler(Self).CefClientObj.Width, PCefExLifeSpanHandler(Self).CefClientObj.Height);
        browser.send_focus_event(browser, 1);
      end;
    end;
  end;
end;

procedure cef_life_span_handler_on_before_close(self: PCefLifeSpanHandler; browser: PCefBrowser); stdcall;
begin
//  log('cef_apilib.pas', 'cef_life_span_handler_on_before_close');
end;

function cef_life_span_handler_run_modal(self: PCefLifeSpanHandler; browser: PCefBrowser): Integer; stdcall;
begin
  Result := 0;
  //sdlog('cef_apilib.pas', 'cef_life_span_handler_run_modal');
end;

function cef_life_span_handler_do_close(self: PCefLifeSpanHandler; browser: PCefBrowser): Integer; stdcall;
begin
  Result := 0;
  //log('cef_apilib.pas', 'cef_life_span_handler_do_close');
end;

procedure InitCefLifeSpan(ACefLifeSpanHandler: PCefIntfLifeSpanHandler; ACefClientObject: PCefClientObject);
begin
  ACefLifeSpanHandler.IntfPtr := @ACefLifeSpanHandler.CefLifeSpanHandler;
  ACefLifeSpanHandler.CefLifeSpanHandler.base.size := SizeOf(TCefLifeSpanHandler);
  ACefLifeSpanHandler.CefLifeSpanHandler.base.add_ref := @cef_base_add_ref;
  ACefLifeSpanHandler.CefLifeSpanHandler.base.release := @cef_base_release;
  ACefLifeSpanHandler.CefLifeSpanHandler.base.get_refct := @cef_base_get_refct;
  ACefLifeSpanHandler.CefLifeSpanHandler.on_before_popup := @cef_life_span_handler_on_before_popup;
  ACefLifeSpanHandler.CefLifeSpanHandler.on_after_created := @cef_life_span_handler_on_after_created;
  ACefLifeSpanHandler.CefLifeSpanHandler.on_before_close := @cef_life_span_handler_on_before_close;
  ACefLifeSpanHandler.CefLifeSpanHandler.run_modal := @cef_life_span_handler_run_modal;
  ACefLifeSpanHandler.CefLifeSpanHandler.do_close := @cef_life_span_handler_do_close;
  ACefLifeSpanHandler.CefClientObj := ACefClientObject;
end;

end.
