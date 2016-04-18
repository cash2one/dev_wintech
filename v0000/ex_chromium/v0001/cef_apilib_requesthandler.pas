
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_requesthandler;
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

  procedure InitCefRequestHandler(ACefRequestHandler: PCefIntfRequestHandler; ACefClientObject: PCefClientObject);

implementation

uses
  BaseApp,
  cef_app,
  cef_apilib,
  cef_apilib_contentfilter;

function cef_request_handler_on_before_browse(self: PCefRequestHandler;
  browser: PCefBrowser; frame: PCefFrame; request: PCefRequest;
  navType: TCefHandlerNavtype; isRedirect: Integer): Integer; stdcall;
var
  tmpurl: string;
  tmpMainFrame: PCefFrame;
begin
  Result := 0;
  tmpurl := '';
  if frame <> nil then
  begin
    tmpurl := CefStringFreeAndGet(frame.get_url(frame));
    if tmpurl = '' then
    begin
      tmpMainFrame := browser.get_main_frame(browser);
      if tmpMainFrame <> nil then
      begin
        tmpurl := CefStringFreeAndGet(tmpMainFrame.get_url(tmpMainFrame));
      end;
    end;
  end;
  //sdlog('cef_apilib.pas', 'cef_request_handler_on_before_browse:' + tmpurl);
end;

function cef_request_handler_on_before_resource_load(
  self: PCefRequestHandler; browser: PCefBrowser; request: PCefRequest;
  redirectUrl: PCefString; var resourceStream: PCefStreamReader;
  response: PCefResponse; loadFlags: Integer): Integer; stdcall;
var
  tmpurl: string;
  tmpfile: string;
  tmpfileext: string;
  tmpcefstr: TCefString;
  { 这里可以把资源的加载偷偷替换掉 }
begin
  Result := 0;
  exit;
  if request <> nil then
  begin
    tmpurl := CefStringFreeAndGet(request.get_url(request));
    //**exit;
    if tmpurl <> '' then
    begin
      if Pos('?', tmpUrl) > 0 then
      begin
        //sdlog('cef_apilib.pas', 'cef_request_handler_on_before_resource_load:' + tmpurl);
        exit;
      end;
      tmpfile := tmpurl;
      tmpfile := StringReplace(tmpfile, 'https://', extractFilePath(ParamStr(0)) + 'webcache\', [rfReplaceAll]);
      tmpfile := StringReplace(tmpfile, 'http://', extractFilePath(ParamStr(0)) + 'webcache\', [rfReplaceAll]);
      tmpfile := StringReplace(tmpfile, '/', '\', [rfReplaceAll]);
      if FileExists(tmpfile) then
      begin
        tmpfileext := lowercase(ExtractFileExt(tmpfile));
        if //(tmpfileext = '.jpg') or
           (tmpfileext = '.png') or
           (tmpfileext = '.gif') or
           //(tmpfileext = '.js') or
           (tmpfileext = '.css')
//           (tmpfileext = '.js')
            then
        begin
          //**resourceStream := TCefStreamReaderRef.CreateForFile(tmpfile);
          Result := 1;
          (*//
          InitCefStreamReader(@CefStreamReader);
          CefStreamReader.FileUrl := tmpfile;
          if CefStreamReader.FileStream <> nil then
          begin
            CefStreamReader.fileStream.Free;
            CefStreamReader.fileStream := nil;
          end;
          resourceStream := @CefStreamReader.CefStreamReader;
          //*)
          (*//
          InitCefReaderHandler(@PCefExRequestHandler(self).CefReadHandler);
          PCefExRequestHandler(self).CefReadHandler.FileUrl := tmpFile;
          if PCefExRequestHandler(self).CefReadHandler.FileStream <> nil then
          begin
            PCefExRequestHandler(self).CefReadHandler.fileStream.Free;
            PCefExRequestHandler(self).CefReadHandler.fileStream := nil;
          end;
          resourceStream := GlobalApp.CefApp.CefLibrary.cef_stream_reader_create_for_handler(
              @PCefExRequestHandler(self).CefReadHandler.CefReadReader);
          //*)
          //(*//
          tmpcefstr := CefString(tmpfile);
          resourceStream := CefApp.CefLibrary.cef_stream_reader_create_for_file(@tmpcefstr);
          //*)
          Result := 0;
        end else
        begin
          //sdlog('cef_apilib.pas', 'cef_request_handler_on_before_resource_load:' + tmpurl);
        end;
      end else
      begin
        //sdlog('cef_apilib.pas', 'cef_request_handler_on_before_resource_load:' + tmpurl);
        tmpurl := lowercase(ExtractFileExt(tmpfile));
        if tmpurl = '.swf' then
        begin
          Result := 1;
        end;
        if tmpurl = '.jpg' then
        begin
          Result := 1;
        end;
        if tmpurl = '.png' then
        begin
          Result := 1;
        end;
        if tmpurl = '.gif' then
        begin
          Result := 1;
        end;
      end;
      //sdlog('', 'cef_request_handler_on_before_resource_load:' + tmpurl);
    end;
  end;
end;

procedure cef_request_handler_on_resource_redirect(self: PCefRequestHandler;
  browser: PCefBrowser; const old_url: PCefString; new_url: PCefString); stdcall;
begin
  //sdlog('cef_apilib.pas', 'cef_request_handler_on_resource_redirect:' + CefString(old_url));
end;

procedure cef_request_handler_on_resource_response(self: PCefRequestHandler;
  browser: PCefBrowser; const url: PCefString; response: PCefResponse;
  var filter: PCefContentFilter); stdcall;
var
  s: string;
begin
  //(*//
  //这里可以把访问过的内容 保存下来
  exit;
  if url <> nil then
  begin
    s := CefString(url);
    if Pos('?' , s) > 0 then
    begin
      //sdlog('cef_apilib.pas', 'cef_request_handler_on_resource_response:' + CefString(url));
      exit;
    end;
    if response <> nil then
    begin
      s := IntToStr(response.get_status(response)) + ':' + s;
      if response.get_status(response) = 200 then
      begin
        //sdlog('cef_apilib.pas', 'cef_request_handler_on_resource_response:' + CefString(url));
        //if pos('bdlogo.gif', s) > 0 then
        begin
          PCefExRequestHandler(self).CefContentFilter.url := AnsiString(CefString(url));
          InitCefContentFilter(@PCefExRequestHandler(self).CefContentFilter);
          filter := @PCefExRequestHandler(self).CefContentFilter.CefContentFilter;
        end;
      end;
    end;
    //sdlog('', 'cef_request_handler_on_resource_response:' + s);
  end;
  //*)
end;

function cef_request_handler_on_protocol_execution(self: PCefRequestHandler;
  browser: PCefBrowser; const url: PCefString; var allowOSExecution: Integer): Integer; stdcall;
begin
  //log('cef_apilib.pas', 'cef_request_handler_on_protocol_execution:' + CefString(url));
  Result := 0;
end;

function cef_request_handler_get_download_handler(self: PCefRequestHandler;
  browser: PCefBrowser; const mimeType: PCefString; const fileName: PCefString;
  contentLength: int64; var handler: PCefDownloadHandler): Integer; stdcall;
begin
  //log('cef_apilib.pas', 'cef_request_handler_get_download_handler:' + CefString(fileName));
  Result := 0;
end;

function cef_request_handler_get_auth_credentials(self: PCefRequestHandler;
  browser: PCefBrowser; isProxy: Integer; const host: PCefString;
  port: Integer; const realm: PCefString; const scheme: PCefString;
  username, password: PCefString): Integer; stdcall;
begin
  //sdlog('cef_apilib.pas', 'cef_request_handler_get_auth_credentials');
  Result := 0;
end;

function cef_request_handler_get_cookie_manager(self: PCefRequestHandler;
      browser: PCefBrowser; const main_url: PCefString): PCefCookieManager; stdcall;
begin
  Result := cefApp.CefLibrary.cef_cookie_manager_get_global_manager;
end;

procedure InitCefRequestHandler(ACefRequestHandler: PCefIntfRequestHandler; ACefClientObject: PCefClientObject);
begin
  ACefRequestHandler.IntfPtr := @ACefRequestHandler.CefRequestHandler;
  ACefRequestHandler.CefRequestHandler.base.size := SizeOf(TCefRequestHandler);
  ACefRequestHandler.CefRequestHandler.base.add_ref := @cef_base_add_ref;
  ACefRequestHandler.CefRequestHandler.base.release := @cef_base_release;
  ACefRequestHandler.CefRequestHandler.base.get_refct := @cef_base_get_refct;

  ACefRequestHandler.CefRequestHandler.on_before_browse := @cef_request_handler_on_before_browse;
  ACefRequestHandler.CefRequestHandler.on_before_resource_load := @cef_request_handler_on_before_resource_load;
  ACefRequestHandler.CefRequestHandler.on_resource_redirect := @cef_request_handler_on_resource_redirect;
  ACefRequestHandler.CefRequestHandler.on_resource_response := @cef_request_handler_on_resource_response;
  ACefRequestHandler.CefRequestHandler.on_protocol_execution := @cef_request_handler_on_protocol_execution;
  ACefRequestHandler.CefRequestHandler.get_download_handler := @cef_request_handler_get_download_handler;
  ACefRequestHandler.CefRequestHandler.get_auth_credentials := @cef_request_handler_get_auth_credentials;
  ACefRequestHandler.CefRequestHandler.get_cookie_manager := @cef_request_handler_get_cookie_manager;
  ACefRequestHandler.CefClientObj := ACefClientObject;
end;

end.
