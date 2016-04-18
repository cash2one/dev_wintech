
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_loadhandler;
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

  procedure InitCefLoadHandler(ACefLoadHandler: PCefIntfLoadHandler; ACefClientObject: PCefClientObject);

implementation

uses
  cef_apilib;
  
procedure cef_load_handler_on_load_start(self: PCefLoadHandler;
  browser: PCefBrowser; frame: PCefFrame); stdcall;
var
  tmpurl: string;
begin
  if frame <> nil then
  begin
    tmpurl := CefStringFreeAndGet(frame.get_url(frame));
    //sdlog('cef_apilib.pas', 'cef_load_handler_on_load_start:' + tmpurl);
    if tmpurl <> '' then
    begin
    end;
  end;
end;

procedure cef_load_handler_on_load_end(self: PCefLoadHandler;
  browser: PCefBrowser; frame: PCefFrame; httpStatusCode: Integer); stdcall;
var
  tmpurl: string;
begin
  if frame <> nil then
  begin
    if frame^.is_main(frame) <> 0 then
    begin
      //(*//
      if browser <> nil then
      begin
        browser.send_focus_event(browser, 1);
      end;
      //*)
      tmpurl := CefStringFreeAndGet(frame.get_url(frame));
      if httpStatusCode = 0 then
      begin

      end else
      begin
        if httpStatusCode <> 200 then
        begin
        //**Writeln(httpStatusCode);
          Exit;
        end;
      end;
      //sdlog('cef_apilib.pas', 'cef_load_handler_on_load_end:' + tmpurl);

      if PCefExLoadHandler(self).CefClientObj.CefUrl = tmpurl then
      begin
        //
        //browser.show_dev_tools(browser);
      end;
      if tmpurl <> '' then
      begin
        if Assigned(PCefExLoadHandler(self).CefClientObj.CefOnLoadEnd) then
        begin
          PCefExLoadHandler(self).CefClientObj.CefOnLoadEnd(PCefExLoadHandler(self).CefClientObj, tmpurl);
        end;
      end;
      //**write(CefStringFreeAndGet(frame.get_text(frame)));
    end;
  end;
end;

function cef_load_handler_on_load_error(self: PCefLoadHandler; browser: PCefBrowser;
  frame: PCefFrame; errorCode: TCefHandlerErrorcode; const failedUrl: PCefString;
  var errorText: TCefString): Integer; stdcall;
begin
  Result := 0;
  if frame <> nil then
  begin

  end;
end;

procedure InitCefLoadHandler(ACefLoadHandler: PCefIntfLoadHandler; ACefClientObject: PCefClientObject);
begin
  ACefLoadHandler.IntfPtr := @ACefLoadHandler.CefLoadHandler;
  ACefLoadHandler.CefLoadHandler.base.size := SizeOf(TCefLoadHandler);
  ACefLoadHandler.CefLoadHandler.base.add_ref := @cef_base_add_ref;
  ACefLoadHandler.CefLoadHandler.base.release := @cef_base_release;
  ACefLoadHandler.CefLoadHandler.base.get_refct := @cef_base_get_refct;

  ACefLoadHandler.CefLoadHandler.on_load_start := @cef_load_handler_on_load_start;
  ACefLoadHandler.CefLoadHandler.on_load_end := @cef_load_handler_on_load_end;
  ACefLoadHandler.CefLoadHandler.on_load_error := @cef_load_handler_on_load_error;
  ACefLoadHandler.CefClientObj := ACefClientObject;
end;

end.
