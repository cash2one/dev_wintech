
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib;
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

  procedure InitCefLib(ACefLibrary: PCefLibrary; ACefAppObject: PCefAppObject);
  procedure InitCefApp(ACefApp: PCefIntfApp);
  procedure InitCefClient(ACefClient: PCefIntfClient; ACefClientObject: PCefClientObject);

  procedure InitCefContentFilter(ACefContentFilter: PCefIntfContentFilter);
  procedure InitCefStreamReader(ACefStreamReader: PCefIntfStreamReader);

  procedure InitCefReaderHandler(ACefReadHandler: PCefIntfReadHandler);

  function CefString(const str: ustring): TCefString; overload;
  function CefString(const str: PCefString): ustring; overload;
  function CefStringFreeAndGet(const str: PCefStringUserFree): ustring;
  procedure CefTimerProc(AWnd: HWND; uMsg: UINT; idEvent: Pointer; dwTime: DWORD); stdcall;

type
  TDomVisitorVisitCallBackProc = procedure(self: PCefDomVisitor; document: PCefDomDocument); stdcall;

  procedure InitCefDomVisitor(ACefDomVisitor: PCefIntfDomVisitor; ACefClientObject: PCefClientObject; AVisitCallBackProc: TDomVisitorVisitCallBackProc); stdcall;

  procedure InitCefLoadHandler(ACefLoadHandler: PCefIntfLoadHandler; ACefClientObject: PCefClientObject);
  procedure InitCefLifeSpan(ACefLifeSpanHandler: PCefIntfLifeSpanHandler; ACefClientObject: PCefClientObject);
  procedure InitCefRequestHandler(ACefRequestHandler: PCefIntfRequestHandler; ACefClientObject: PCefClientObject);
  procedure InitCefDisplayHandler(ACefDisplayHandler: PCefIntfDisplayHandler; ACefClientObject: PCefClientObject);
  procedure InitCefFocusHandler(ACefFocusHandler: PCefIntfFocusHandler; ACefClientObject: PCefClientObject);
  procedure InitCefKeyboardHandler(ACefKeyboardHandler: PCefIntfKeyboardHandler; ACefClientObject: PCefClientObject);
  procedure InitCefMenuHandler(ACefMenuHandler: PCefIntfMenuHandler; ACefClientObject: PCefClientObject);
  procedure InitCefPermissionHandler(ACefPermissionHandler: PCefIntfPermissionHandler; ACefClientObject: PCefClientObject);
  procedure InitCefPrintHandler(ACefPrintHandler: PCefIntfPrintHandler; ACefClientObject: PCefClientObject);
  procedure InitCefFindHandler(ACefFindHandler: PCefIntfFindHandler; ACefClientObject: PCefClientObject);
  procedure InitCefJsDialogHandler(ACefJsDialogHandler: PCefIntfJsDialogHandler; ACefClientObject: PCefClientObject);
  procedure InitCefV8contextHandler(ACefV8contextHandler: PCefIntfV8contextHandler; ACefClientObject: PCefClientObject);
  procedure InitCefRenderHandler(ACefRenderHandler: PCefIntfRenderHandler; ACefClientObject: PCefClientObject);
  procedure InitCefDragHandler(ACefDragHandler: PCefIntfDragHandler; ACefClientObject: PCefClientObject);
  procedure InitCefGeolocationHandler(ACefGeolocationHandler: PCefIntfGeolocationHandler; ACefClientObject: PCefClientObject);
  procedure InitCefZoomHandler(ACefZoomHandler: PCefIntfZoomHandler; ACefClientObject: PCefClientObject);

implementation

uses
  BaseApp, cef_app, cef_apilib_init;

var
  logtag: string = 'cef_apilib.pas';
    
function cef_base_add_ref(self: PCefBase): Integer; stdcall;
begin
  Result := 1;
end;

function cef_base_release(self: PCefBase): Integer; stdcall;
begin
  Result := 1;
end;

function cef_base_get_refct(self: PCefBase): Integer; stdcall;
begin
  Result := 1;
end;

procedure cef_app_on_register_custom_schemes(self: PCefApp; registrar: PCefSchemeRegistrar); stdcall;
begin

end;

function cef_app_get_resource_bundle_handler(self: PCefApp): PCefResourceBundleHandler; stdcall;
begin
  Result := @CefApp.CefAppObject.CefAppIntf_ResourceBundleHandler.CefResourceBundleHandler;
end;

function cef_app_get_proxy_handler(self: PCefApp): PCefProxyHandler; stdcall;
begin
  Result := @CefApp.CefAppObject.CefAppIntf_ProxyHandler.CefProxyHandler;
end;

procedure InitCefApp(ACefApp: PCefIntfApp);
begin
  ACefApp.IntfPtr := @ACefApp.CefApp;
  ACefApp.CefApp.base.size := SizeOf(TCefApp);
  ACefApp.CefApp.base.add_ref := @cef_base_add_ref;
  ACefApp.CefApp.base.release := @cef_base_release;
  ACefApp.CefApp.base.get_refct := @cef_base_get_refct;

  ACefApp.CefApp.on_register_custom_schemes := @cef_app_on_register_custom_schemes;
  ACefApp.CefApp.get_resource_bundle_handler := @cef_app_get_resource_bundle_handler;
  ACefApp.CefApp.get_proxy_handler := @cef_app_get_proxy_handler;
end;

procedure cef_proxy_handler_get_proxy_for_url(self: PCefProxyHandler;
  const url: PCefString; proxy_info: PCefProxyInfo); stdcall;
var
  proxyList: ustring;
begin
  //**log('cef_apilib.pas', 'cef_proxy_handler_get_proxy_for_url:' + CefString(url));
  if url <> nil then
  begin

  end;
  (*//
  TCefProxyHandlerOwn(CefGetObject(self)).GetProxyForUrl(CefString(url),
    proxy_info.proxyType, proxyList);
  CefStringSet(@proxy_info.proxyList, proxyList);
  //*)
end;

procedure InitCefAppProxyHandler(ACefProxyHandler: PCefIntfProxyHandler);
begin
  ACefProxyHandler.IntfPtr := @ACefProxyHandler.CefProxyHandler;
  ACefProxyHandler.CefProxyHandler.base.size := SizeOf(TCefProxyHandler);
  ACefProxyHandler.CefProxyHandler.base.add_ref := @cef_base_add_ref;
  ACefProxyHandler.CefProxyHandler.base.release := @cef_base_release;
  ACefProxyHandler.CefProxyHandler.base.get_refct := @cef_base_get_refct;
  ACefProxyHandler.CefProxyHandler.get_proxy_for_url := @cef_proxy_handler_get_proxy_for_url;
end;

function cef_resource_bundle_handler_get_localized_string(self: PCefResourceBundleHandler;
  message_id: Integer; string_val: PCefString): Integer; stdcall;
var
  str: ustring;
begin
  //sdlog('cef_apilib.pas', 'cef_resource_bundle_handler_get_localized_string');
  Result := 0;
  if Result <> 0 then
    string_val^ := CefString(str);
end;

function cef_resource_bundle_handler_get_data_resource(self: PCefResourceBundleHandler;
  resource_id: Integer; var data: Pointer; var data_size: Cardinal): Integer; stdcall;
begin
  Result := 0;
end;

procedure InitCefAppResourceBundleHandler(ACefResourceBundleHandler: PCefIntfResourceBundleHandler);
begin
  ACefResourceBundleHandler.IntfPtr := @ACefResourceBundleHandler.CefResourceBundleHandler;
  ACefResourceBundleHandler.CefResourceBundleHandler.base.size := SizeOf(TCefResourceBundleHandler);
  ACefResourceBundleHandler.CefResourceBundleHandler.base.add_ref := @cef_base_add_ref;
  ACefResourceBundleHandler.CefResourceBundleHandler.base.release := @cef_base_release;
  ACefResourceBundleHandler.CefResourceBundleHandler.base.get_refct := @cef_base_get_refct;
  ACefResourceBundleHandler.CefResourceBundleHandler.get_localized_string := @cef_resource_bundle_handler_get_localized_string;
  ACefResourceBundleHandler.CefResourceBundleHandler.get_data_resource := @cef_resource_bundle_handler_get_data_resource;
end;

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

procedure InitCefDomVisitor(ACefDomVisitor: PCefIntfDomVisitor; ACefClientObject: PCefClientObject; AVisitCallBackProc: TDomVisitorVisitCallBackProc); stdcall;
begin
  ACefDomVisitor.IntfPtr := @ACefDomVisitor.CefDomVisitor;
  ACefDomVisitor.CefDomVisitor.base.size := SizeOf(TCefDomVisitor);
  ACefDomVisitor.CefDomVisitor.base.add_ref := @cef_base_add_ref;
  ACefDomVisitor.CefDomVisitor.base.release := @cef_base_release;
  ACefDomVisitor.CefDomVisitor.base.get_refct := @cef_base_get_refct;
  ACefDomVisitor.CefDomVisitor.visit := AVisitCallBackProc;
  ACefDomVisitor.CefClientObj := ACefClientObject;
end;

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

function cef_request_handler_on_before_browse(self: PCefRequestHandler;
  browser: PCefBrowser; frame: PCefFrame; request: PCefRequest;
  navType: TCefHandlerNavtype; isRedirect: Integer): Integer; stdcall;
var
  tmpurl: string;
  tmpStorePath: TCefString;
  tmpCookieMgr: PCefCookieManager;
  tmpCookie1: TCefCookie;
  tmpCookie2: TCefCookie;
  tmpCookie3: TCefCookie;
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

procedure Cef_Content_Filter_process_data(self: PCefContentFilter;
        const data: Pointer; data_size: Integer;
        var substitute_data: PCefStreamReader); stdcall;
//(*//
var
  //fFileStream: TFileStream;
  tmpUrl: string;
  tmpfile: string;
  tmpstr: string;
  tmpPos: integer;
//*)
begin
  exit;
  //(*//
  if PCefExContentFilter(self).url <> '' then
  begin
    tmpUrl := lowercase(PCefExContentFilter(self).url);
    tmpfile := tmpUrl;
    tmpPos := Pos('://', tmpfile);
    tmpstr := Copy(tmpfile, 1, tmpPos - 1);
    if (tmpstr = 'http') or (tmpstr = 'https') then
    begin
      tmpfile := copy(tmpfile, tmpPos + 3, maxint);
      if pos('?', tmpfile) < 1 then
      begin
        // pfile -- http://www.2ccc.com:80/
        tmpfile := StringReplace(tmpfile, '/', '\', [rfReplaceAll]);

        tmpPos := Pos('\', tmpfile);
        if tmpPos > 0 then
        begin
          tmpstr := Copy(tmpfile, 1, tmpPos - 1);
          tmpfile := Copy(tmpfile, tmpPos + 1, maxint);

          tmpPos := Pos(':', tmpStr);
          if tmpPos > 0 then
          begin
            tmpfile := Copy(tmpstr, 1, tmpPos - 1) + '\' + tmpfile;
          end else
          begin
            tmpfile := tmpstr + '\' + tmpfile;
          end;
        end else
        begin
          // www.2ccc.com:80
          // root homepage
        end;
        tmpfile := extractFilePath(ParamStr(0)) +
            'webcache\' +
            tmpfile;

        Sysutils.ForceDirectories(ExtractFilePath(tmpfile));
        tmpstr := ExtractFileExt(tmpfile);
        if tmpstr <> '' then
        begin
          if (tmpstr = '.js') or
             (tmpstr = '.png') or
             (tmpstr = '.jpg') or
             (tmpstr = '.jpeg') or
             (tmpstr = '.gif') or
             (tmpstr = '.woff') or
             (tmpstr = '.css') then
          begin
            if FileExists(tmpfile) then
            begin
              //fFileStream := TFileStream.Create(tmpfile, fmOpenReadWrite or fmShareDenyNone);
            end else
            begin
              //fFileStream := TFileStream.Create(tmpfile, fmCreate or fmShareDenyNone);
            end;
            try
              //fFileStream.Position := fFileStream.Size;
              //fFileStream.Write(Data^, data_size);
            finally
              //fFileStream.Free;
            end;
          end else
          begin
            if tmpstr = 'test' then
            begin

            end;
          end;
        end;
      end;
    end;
  end;
  //*)
end;
    // Called when there is no more data to be processed. It is expected that
    // whatever data was retained in the last process_data() call, it should be
    // returned now by setting |remainder| if appropriate.
procedure Cef_Content_Filter_Drain(self: PCefContentFilter; var remainder: PCefStreamReader); stdcall;
begin

end;

procedure InitCefContentFilter(ACefContentFilter: PCefIntfContentFilter);
begin
  ACefContentFilter.IntfPtr := @ACefContentFilter.CefContentFilter;
  ACefContentFilter.CefContentFilter.base.size := SizeOf(TCefRequestHandler);
  ACefContentFilter.CefContentFilter.base.add_ref := @cef_base_add_ref;
  ACefContentFilter.CefContentFilter.base.release := @cef_base_release;
  ACefContentFilter.CefContentFilter.base.get_refct := @cef_base_get_refct;

  ACefContentFilter.CefContentFilter.process_data := @Cef_Content_Filter_process_data;
  ACefContentFilter.CefContentFilter.drain := @Cef_Content_Filter_Drain;
end;

    // Read raw binary data.
function Cef_Stream_Reader_read(self: PCefStreamReader; ptr: Pointer; size, n: Cardinal): Cardinal; stdcall;
begin
  Result := 0;
//  if PCefExStreamReader(self).FileStream = nil then
//  begin
//    if PCefExStreamReader(self).FileUrl <> '' then
//    begin
//      if FileExists(PCefExStreamReader(self).FileUrl) then
//      begin
//        PCefExStreamReader(self).FileStream := TFileStream.Create(PCefExStreamReader(self).FileUrl, fmOpenRead or fmShareDenyNone);
//      end;
//    end;
//  end;
//  if PCefExStreamReader(self).FileStream <> nil then
//  begin
//    Result := PCefExStreamReader(self).FileStream.Read(ptr^, size);
//  end;
end;

    // Seek to the specified offset position. |whence| may be any one of SEEK_CUR,
    // SEEK_END or SEEK_SET. Returns zero on success and non-zero on failure.
function Cef_Stream_Reader_seek(self: PCefStreamReader; offset: Int64; whence: Integer): Integer; stdcall;
begin
  Result := 1;
//  if PCefExStreamReader(self).FileStream <> nil then
//  begin
//    PCefExStreamReader(self).FileStream.Position := offset;
//    Result := 0;
//  end;
end;

    // Return the current offset position.
function Cef_Stream_Reader_tell(self: PCefStreamReader): Int64; stdcall;
begin
  Result := 0;
//  if PCefExStreamReader(self).FileStream <> nil then
//  begin
//    Result := PCefExStreamReader(self).FileStream.Position;
//  end;
end;

// Return non-zero if at end of file.
function Cef_Stream_Reader_eof(self: PCefStreamReader): Integer; stdcall;
begin
  Result := 1;
  if PCefExStreamReader(self).FileUrl <> '' then
  begin
    if PCefExStreamReader(self).FileUrl <> '' then
    begin
//      if PCefExStreamReader(self).FileStream <> nil then
//      begin
//        Result := 0;
//        if PCefExStreamReader(self).FileStream.Position >= PCefExStreamReader(self).FileStream.Size - 1 then
//        begin
//          Result := 1;
//        end;
//      end;
    end;
  end;
end;

procedure InitCefStreamReader(ACefStreamReader: PCefIntfStreamReader);
begin
  ACefStreamReader.IntfPtr := @ACefStreamReader.CefStreamReader;
  ACefStreamReader.CefStreamReader.base.size := SizeOf(TCefStreamReader);
  ACefStreamReader.CefStreamReader.base.add_ref := @cef_base_add_ref;
  ACefStreamReader.CefStreamReader.base.release := @cef_base_release;
  ACefStreamReader.CefStreamReader.base.get_refct := @cef_base_get_refct;

  ACefStreamReader.CefStreamReader.read := @Cef_Stream_Reader_read;
  ACefStreamReader.CefStreamReader.seek := @Cef_Stream_Reader_seek;
  ACefStreamReader.CefStreamReader.tell := @Cef_Stream_Reader_tell;
  ACefStreamReader.CefStreamReader.eof := @Cef_Stream_Reader_eof;
end;

function Cef_Read_Handler_read(self: PCefReadHandler; ptr: Pointer;
      size, n: Cardinal): Cardinal; stdcall;
begin
  Result := 0;
//  if PCefExReadHandler(self).FileStream = nil then
//  begin
//    if PCefExReadHandler(self).FileUrl <> '' then
//    begin
//      if FileExists(PCefExReadHandler(self).FileUrl) then
//      begin
//        PCefExReadHandler(self).FileStream := TFileStream.Create(PCefExReadHandler(self).FileUrl, fmOpenRead or fmShareDenyNone);
//      end;
//    end;
//  end;
//  // size = 1 n = 999999
//  if PCefExReadHandler(self).FileStream <> nil then
//  begin
//    result := Cardinal(PCefExReadHandler(self).FileStream.Read(ptr^, n * size)) div size;
//  end;
end;

const
  SEEK_SET = 0; //文件开头
  SEEK_CUR = 1; //当前位置
  SEEK_END = 2; //文件结尾

    // Seek to the specified offset position. |whence| may be any one of SEEK_CUR,
    // SEEK_END or SEEK_SET. Return zero on success and non-zero on failure.
function Cef_Read_Handler_seek(self: PCefReadHandler; offset: Int64;
      whence: Integer): Integer; stdcall;
begin
  Result := 1;
//  if PCefExReadHandler(self).FileStream = nil then
//  begin
//    if PCefExReadHandler(self).FileUrl <> '' then
//    begin
//      if FileExists(PCefExReadHandler(self).FileUrl) then
//      begin
//        PCefExReadHandler(self).FileStream := TFileStream.Create(PCefExReadHandler(self).FileUrl, fmOpenRead or fmShareDenyNone);
//      end;
//    end;
//  end;
//  if PCefExReadHandler(self).FileStream <> nil then
//  begin
//    case whence of
//      SEEK_SET: begin
//        PCefExReadHandler(self).FileStream.Position := offset;
//        Result := 0;
//      end;
//      SEEK_CUR: begin
//        PCefExReadHandler(self).FileStream.Position := PCefExReadHandler(self).FileStream.Position + offset;
//        Result := 0;
//      end;
//      SEEK_END: begin
//        PCefExReadHandler(self).FileStream.Position := PCefExReadHandler(self).FileStream.Size;
//        Result := 0;
//      end;
//    end;
//  end;
end;

    // Return the current offset position.
function Cef_Read_Handler_tell(self: PCefReadHandler): Int64; stdcall;
begin
  Result := 0;
//  if PCefExReadHandler(self).FileStream <> nil then
//  begin
//    Result := PCefExReadHandler(self).FileStream.Position;
//  end;
end;
    // Return non-zero if at end of file.
function Cef_Read_Handler_eof(self: PCefReadHandler): Integer; stdcall;
begin
  Result := 1;
  if PCefExReadHandler(self).FileUrl <> '' then
  begin
//      if PCefExReadHandler(self).FileStream <> nil then
//      begin
//        Result := 0;
//        if PCefExReadHandler(self).FileStream.Position >= PCefExReadHandler(self).FileStream.Size - 1 then
//        begin
//          Result := 1;
//        end;
//      end;
  end;
end;

procedure InitCefReaderHandler(ACefReadHandler: PCefIntfReadHandler);
begin
  ACefReadHandler.IntfPtr := @ACefReadHandler.CefReadReader;
  ACefReadHandler.CefReadReader.base.size := SizeOf(TCefReadHandler);
  ACefReadHandler.CefReadReader.base.add_ref := @cef_base_add_ref;
  ACefReadHandler.CefReadReader.base.release := @cef_base_release;
  ACefReadHandler.CefReadReader.base.get_refct := @cef_base_get_refct;

  ACefReadHandler.CefReadReader.read := @Cef_Read_Handler_read;
  ACefReadHandler.CefReadReader.seek := @Cef_Read_Handler_seek;
  ACefReadHandler.CefReadReader.tell := @Cef_Read_Handler_tell;
  ACefReadHandler.CefReadReader.eof := @Cef_Read_Handler_eof;
end;

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

procedure cef_focus_handler_on_take_focus(self: PCefFocusHandler;
  browser: PCefBrowser; next: Integer); stdcall;
begin

end;

function cef_focus_handler_on_set_focus(self: PCefFocusHandler;
  browser: PCefBrowser; source: TCefHandlerFocusSource): Integer; stdcall;
begin
  Result := 0;
end;

procedure cef_focus_handler_on_focused_node_changed(self: PCefFocusHandler;
  browser: PCefBrowser; frame: PCefFrame; node: PCefDomNode); stdcall;
begin

end;

procedure InitCefFocusHandler(ACefFocusHandler: PCefIntfFocusHandler; ACefClientObject: PCefClientObject);
begin
  ACefFocusHandler.IntfPtr := @ACefFocusHandler.CefFocusHandler;
  ACefFocusHandler.CefFocusHandler.base.size := SizeOf(TCefFocusHandler);
  ACefFocusHandler.CefFocusHandler.base.add_ref := @cef_base_add_ref;
  ACefFocusHandler.CefFocusHandler.base.release := @cef_base_release;
  ACefFocusHandler.CefFocusHandler.base.get_refct := @cef_base_get_refct;

  ACefFocusHandler.CefFocusHandler.on_take_focus := @cef_focus_handler_on_take_focus;
  ACefFocusHandler.CefFocusHandler.on_set_focus := @cef_focus_handler_on_set_focus;
  ACefFocusHandler.CefFocusHandler.on_focused_node_changed := @cef_focus_handler_on_focused_node_changed;

  ACefFocusHandler.CefClientObj := ACefClientObject;
end;

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

function cef_permission_handler_on_before_script_extension_load(self: PCefPermissionHandler;
  browser: PCefBrowser; frame: PCefFrame; const extensionName: PCefString): Integer; stdcall;
begin
  Result := 0;
  //sdlog('cef_apilib.pas', 'cef_permission_handler_on_before_script_extension_load');
end;

procedure InitCefPermissionHandler(ACefPermissionHandler: PCefIntfPermissionHandler; ACefClientObject: PCefClientObject);
begin
  ACefPermissionHandler.IntfPtr := @ACefPermissionHandler.CefPermissionHandler;
  ACefPermissionHandler.CefPermissionHandler.base.size := SizeOf(TCefPermissionHandler);
  ACefPermissionHandler.CefPermissionHandler.base.add_ref := @cef_base_add_ref;
  ACefPermissionHandler.CefPermissionHandler.base.release := @cef_base_release;
  ACefPermissionHandler.CefPermissionHandler.base.get_refct := @cef_base_get_refct;

  ACefPermissionHandler.CefPermissionHandler.on_before_script_extension_load :=
      @cef_permission_handler_on_before_script_extension_load;
  ACefPermissionHandler.CefClientObj := ACefClientObject;
end;

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

function cef_render_handler_get_view_rect(self: PCefRenderHandler;
  browser: PCefBrowser; rect: PCefRect): Integer; stdcall;
begin
  Result := 0;
//  sdlog('cef_apilib.pas', 'cef_render_handler_get_view_rect');
end;

function cef_render_handler_get_screen_rect(self: PCefRenderHandler;
  browser: PCefBrowser; rect: PCefRect): Integer; stdcall;
begin
  Result := 0;
//  sdlog('cef_apilib.pas', 'cef_render_handler_get_screen_rect');
end;

function cef_render_handler_get_screen_point(self: PCefRenderHandler;
  browser: PCefBrowser; viewX, viewY: Integer; screenX, screenY: PInteger): Integer; stdcall;
begin
  Result := 0;
  //sdlog('cef_apilib.pas', 'cef_render_handler_get_screen_point');
end;

procedure cef_render_handler_on_popup_show(self: PCefRenderHandler;
  browser: PCefBrowser; show: Integer); stdcall;
begin
//  log('cef_apilib.pas', 'cef_render_handler_on_popup_show');
  if show = 0 then
  begin
    (*//
    if PCefExRenderHandler(self).CefClientObj.CefMemDC_Popup <> nil then
    begin
      CloseMemDC(PCefExRenderHandler(self).CefClientObj.CefMemDC_Popup);
    end;
    //*)
    if Assigned(PCefExRenderHandler(self).CefClientObj.CefOnPaintEnd) then
    begin
      PCefExRenderHandler(self).CefClientObj.CefOnPaintEnd(PCefExRenderHandler(self).CefClientObj);
    end;
    //UpdateMemDC(@UIMemDC_Popup, 0, 0);
    //ClearMemDC(@UIMemDC_Popup, 0, 0);
  end else
  begin
  end;
end;

procedure cef_render_handler_on_popup_size(self: PCefRenderHandler;
  browser: PCefBrowser; const rect: PCefRect); stdcall;
begin
//  log('cef_apilib.pas', 'cef_render_handler_on_popup_size');
  PCefExRenderHandler(self).CefClientObj.CefPopupRect := rect^;
  //fPopupRect := rect^;
end;
                               
procedure cef_render_handler_on_paint(self: PCefRenderHandler;
  browser: PCefBrowser; kind: TCefPaintElementType;
  dirtyRectsCount: Cardinal; const dirtyRects: PCefRectArray;
  const buffer: Pointer); stdcall;

  procedure PaintCef_View;
  var
    tmpview_width: integer;
    tmpview_height: integer;
    i, j: integer;
    tmpwidth: Integer;
    tmpoffset: Integer;
    tmpsrc: PByte;
    tmpdst: PByte;
    //tmpMemDC_View: PMemDC;
  begin
    browser.get_size(browser, PET_VIEW, @tmpview_width, @tmpview_height);
    (*//
    tmpMemDC_View := @PCefExRenderHandler(self).CefClientObj.CefUIMemDC_View;
    if tmpMemDC_View.DCHandle = 0 then
    begin
      OpenMemDC(tmpMemDC_View, 0, tmpview_width, tmpview_height);
    end else
    begin
      if (tmpMemDC_View.MemBitmap.Width <> tmpview_width) or
         (tmpMemDC_View.MemBitmap.Height <> tmpview_height) then
      begin
        CloseMemDC(tmpMemDC_View);
        OpenMemDC(tmpMemDC_View, 0, tmpview_width, tmpview_height);
      end;
    end;
    //*)
    (*//
    for i := 0 to dirtyRectsCount - 1 do
    begin
      try
        tmpwidth := tmpview_width * 4;
        tmpoffset := ((dirtyRects[i].y * tmpview_width) + dirtyRects[i].x) * 4;
        tmpsrc := @PBytes(buffer)[tmpoffset];
        tmpdst := @PBytes(tmpMemDC_View.MemBitmap.BitsData)[tmpoffset];
        tmpoffset := dirtyRects[i].width * 4;

        for j := 0 to dirtyRects[i].height - 1 do
        begin
          Move(tmpsrc^, tmpdst^, tmpoffset);
          Inc(tmpdst, tmpwidth);
          Inc(tmpsrc, tmpwidth);
        end;
      except
      end;
    end;
    //*)
  end;

  procedure PaintCef_Popup;
  (*//
  var
    tmpview_width: integer;
    tmpview_height: integer;
    i, j: integer;
    tmpwidth: Integer;
    tmpoffset: Integer;
    tmpsrc: PByte;
    tmpdst: PByte;
    tmpMemDC_Popup: PMemDC;
    //*)
  begin
    (*//
    browser.get_size(browser, PET_POPUP, @tmpview_width, @tmpview_height);
    if PCefExRenderHandler(self).CefClientObj.CefMemDC_Popup = nil then
    begin
      PCefExRenderHandler(self).CefClientObj.CefMemDC_Popup := System.New(PMemDC);
      FillChar(PCefExRenderHandler(self).CefClientObj.CefMemDC_Popup^, SizeOf(TMemDC), 0);
    end;
    tmpMemDC_Popup := PCefExRenderHandler(self).CefClientObj.CefMemDC_Popup;

    if tmpMemDC_Popup.DCHandle = 0 then
    begin
      OpenMemDC(tmpMemDC_Popup, 0, tmpview_width, tmpview_height);
    end else
    begin
      if (tmpMemDC_Popup.MemBitmap.Width <> tmpview_width) or
         (tmpMemDC_Popup.MemBitmap.Height <> tmpview_height)  then
      begin
        CloseMemDC(tmpMemDC_Popup);
        OpenMemDC(tmpMemDC_Popup, 0, tmpview_width, tmpview_height);
      end;
    end;
    for i := 0 to dirtyRectsCount - 1 do
    begin
      try
        tmpwidth := tmpview_width * 4;
        tmpoffset := ((dirtyRects[i].y * tmpview_width) + dirtyRects[i].x) * 4;
        tmpsrc := @PBytes(buffer)[tmpoffset];
        tmpdst := @PBytes(tmpMemDC_Popup.MemBitmap.BitsData)[tmpoffset];
        tmpoffset := dirtyRects[i].width * 4;

        for j := 0 to dirtyRects[i].height - 1 do
        begin
          Move(tmpsrc^, tmpdst^, tmpoffset);
          Inc(tmpdst, tmpwidth);
          Inc(tmpsrc, tmpwidth);
        end;
      except
      end;
    end;
    //*)
  end;

begin
  case kind of
    PET_VIEW: begin
      PaintCef_View;
      if Assigned(PCefExRenderHandler(self).CefClientObj.CefOnPaintEnd) then
      begin
        PCefExRenderHandler(self).CefClientObj.CefOnPaintEnd(PCefExRenderHandler(self).CefClientObj);
      end;
    end;
    PET_POPUP: begin
      PaintCef_Popup;
      if Assigned(PCefExRenderHandler(self).CefClientObj.CefOnPaintEnd) then
      begin
        PCefExRenderHandler(self).CefClientObj.CefOnPaintEnd(PCefExRenderHandler(self).CefClientObj);
      end;
    end;
  end;
//
end;

procedure cef_render_handler_on_cursor_change(self: PCefRenderHandler;
  browser: PCefBrowser; cursor: TCefCursorHandle); stdcall;
begin
  Windows.SetCursor(cursor);
end;

procedure InitCefRenderHandler(ACefRenderHandler: PCefIntfRenderHandler; ACefClientObject: PCefClientObject);
begin
  ACefRenderHandler.IntfPtr := @ACefRenderHandler.CefRenderHandler;
  ACefRenderHandler.CefRenderHandler.base.size := SizeOf(TCefRenderHandler);
  ACefRenderHandler.CefRenderHandler.base.add_ref := @cef_base_add_ref;
  ACefRenderHandler.CefRenderHandler.base.release := @cef_base_release;
  ACefRenderHandler.CefRenderHandler.base.get_refct := @cef_base_get_refct;

  ACefRenderHandler.CefRenderHandler.get_view_rect := @cef_render_handler_get_view_rect;
  ACefRenderHandler.CefRenderHandler.get_screen_rect := @cef_render_handler_get_screen_rect;
  ACefRenderHandler.CefRenderHandler.get_screen_point := @cef_render_handler_get_screen_point;
  ACefRenderHandler.CefRenderHandler.on_popup_show := @cef_render_handler_on_popup_show;
  ACefRenderHandler.CefRenderHandler.on_popup_size := @cef_render_handler_on_popup_size;
  ACefRenderHandler.CefRenderHandler.on_paint := @cef_render_handler_on_paint;
  ACefRenderHandler.CefRenderHandler.on_cursor_change := @cef_render_handler_on_cursor_change;

  ACefRenderHandler.CefClientObj := ACefClientObject;
end;

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

procedure cef_geolocation_handler_on_request_geolocation_permission(self: PCefGeolocationHandler;
  browser: PCefBrowser; const requesting_url: PCefString; request_id: Integer;
  callback: PCefGeolocationCallback); stdcall;
begin

end;

procedure cef_geolocation_handler_on_cancel_geolocation_permission(self: PCefGeolocationHandler;
  browser: PCefBrowser; const requesting_url: PCefString; request_id: Integer); stdcall;
begin

end;

procedure cef_get_geolocation_callback_on_location_update(
  self: PCefGetGeolocationCallback; const position: PCefGeoposition); stdcall;
begin

end;

procedure InitCefGeolocationHandler(ACefGeolocationHandler: PCefIntfGeolocationHandler; ACefClientObject: PCefClientObject);
begin
  ACefGeolocationHandler.IntfPtr := @ACefGeolocationHandler.CefGeolocationHandler;
  ACefGeolocationHandler.CefGeolocationHandler.base.size := SizeOf(TCefGeolocationHandler);
  ACefGeolocationHandler.CefGeolocationHandler.base.add_ref := @cef_base_add_ref;
  ACefGeolocationHandler.CefGeolocationHandler.base.release := @cef_base_release;
  ACefGeolocationHandler.CefGeolocationHandler.base.get_refct := @cef_base_get_refct;

  ACefGeolocationHandler.CefGeolocationHandler.on_request_geolocation_permission :=
    cef_geolocation_handler_on_request_geolocation_permission;
  ACefGeolocationHandler.CefGeolocationHandler.on_cancel_geolocation_permission :=
    cef_geolocation_handler_on_cancel_geolocation_permission;
  ACefGeolocationHandler.CefClientObj := ACefClientObject;
end;

function cef_zoom_handler_on_get_zoom_level(self: PCefZoomHandler;
  browser: PCefBrowser; const url: PCefString; zoomLevel: PDouble): Integer; stdcall;
begin
  Result := 0;
end;

function cef_zoom_handler_on_set_zoom_level(self: PCefZoomHandler;
  browser: PCefBrowser; const url: PCefString; zoomLevel: Double): Integer; stdcall;
begin
  Result := 0;
end;

procedure InitCefZoomHandler(ACefZoomHandler: PCefIntfZoomHandler; ACefClientObject: PCefClientObject);
begin
  ACefZoomHandler.IntfPtr := @ACefZoomHandler.CefZoomHandler;
  ACefZoomHandler.CefZoomHandler.base.size := SizeOf(TCefZoomHandler);
  ACefZoomHandler.CefZoomHandler.base.add_ref := @cef_base_add_ref;
  ACefZoomHandler.CefZoomHandler.base.release := @cef_base_release;
  ACefZoomHandler.CefZoomHandler.base.get_refct := @cef_base_get_refct;

  ACefZoomHandler.CefZoomHandler.on_get_zoom_level := @cef_zoom_handler_on_get_zoom_level;
  ACefZoomHandler.CefZoomHandler.on_set_zoom_level := @cef_zoom_handler_on_set_zoom_level;
  ACefZoomHandler.CefClientObj := ACefClientObject;
end;

function cef_client_get_life_span_handler(self: PCefClient): PCefLifeSpanHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_LifeSpan.CefLifeSpanHandler;
  (*//
  if Integer(@PCefExClient(self).CefClientObj.CefClientIntf_LifeSpan.CefLifeSpanHandler) =
     Integer(@CefClientObject.CefClientIntf_LifeSpan.CefLifeSpanHandler) then
  begin
    Result := @PCefExClient(self).CefClientObj.CefClientIntf_LifeSpan.CefLifeSpanHandler;
  end else
  begin
    Result := @CefClientObject.CefClientIntf_LifeSpan.CefLifeSpanHandler;
  end;
  //*)
end;

function cef_client_get_load_handler(self: PCefClient): PCefLoadHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_LoadHandler.CefLoadHandler;
  (*//
  if Integer(@PCefExClient(self).CefClientObj.CefClientIntf_LoadHandler.CefLoadHandler) =
     Integer(@CefClientObject.CefClientIntf_LoadHandler.CefLoadHandler) then
  begin
    Result := @PCefExClient(self).CefClientObj.CefClientIntf_LoadHandler.CefLoadHandler;
  end else
  begin
    Result := @CefClientObject.CefClientIntf_LoadHandler.CefLoadHandler;
  end;
  //*)
end;

function cef_client_get_request_handler(self: PCefClient): PCefRequestHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_RequestHandler.CefRequestHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_RequestHandler.CefRequestHandler;
  //*)
end;

function cef_client_get_display_handler(self: PCefClient): PCefDisplayHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_DisplayHandler.CefDisplayHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_DisplayHandler.CefDisplayHandler;
  //*)
end;

function cef_client_get_focus_handler(self: PCefClient): PCefFocusHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_FocusHandler.CefFocusHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_FocusHandler.CefFocusHandler;
  //*)
end;

function cef_client_get_keyboard_handler(self: PCefClient): PCefKeyboardHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_KeyboardHandler.CefKeyboardHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_KeyboardHandler.CefKeyboardHandler;
  //*)
end;

function cef_client_get_menu_handler(self: PCefClient): PCefMenuHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_MenuHandler.CefMenuHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_MenuHandler.CefMenuHandler;
  //*)
end;

function cef_client_get_permission_handler(self: PCefClient): PCefPermissionHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_PermissionHandler.CefPermissionHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_PermissionHandler.CefPermissionHandler;
  //*)
end;

function cef_client_get_print_handler(self: PCefClient): PCefPrintHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_PrintHandler.CefPrintHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_PrintHandler.CefPrintHandler;
  //*)
end;

function cef_client_get_find_handler(self: PCefClient): PCefFindHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_FindHandler.CefFindHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_FindHandler.CefFindHandler;
  //*)
end;

function cef_client_get_jsdialog_handler(self: PCefClient): PCefJsDialogHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_JsDialogHandler.CefJsDialogHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_JsDialogHandler.CefJsDialogHandler;
  //*)
end;

function cef_client_get_v8context_handler(self: PCefClient): PCefV8contextHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_V8contextHandler.CefV8contextHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_V8contextHandler.CefV8contextHandler;
  //*)
end;

function cef_client_get_render_handler(self: PCefClient): PCefRenderHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_RenderHandler.CefRenderHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_RenderHandler.CefRenderHandler;
  //*)
end;

function cef_client_get_drag_handler(self: PCefClient): PCefDragHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_DragHandler.CefDragHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_DragHandler.CefDragHandler;
  //*)
end;

function cef_client_get_geolocation_handler(self: PCefClient): PCefGeolocationHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_GeolocationHandler.CefGeolocationHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_GeolocationHandler.CefGeolocationHandler;
  //*)
end;

function cef_client_get_zoom_handler(self: PCefClient): PCefZoomHandler; stdcall;
begin
  Result := @PCefExClient(self).CefClientObj.CefClientIntf_ZoomHandler.CefZoomHandler;
  (*//
  Result := @CefClientObject.CefClientIntf_ZoomHandler.CefZoomHandler;
  //*)
end;

procedure InitCefClient(ACefClient: PCefIntfClient; ACefClientObject: PCefClientObject);
begin
  ACefClient.IntfPtr := @ACefClient.CefClient;
  ACefClient.CefClient.base.size := SizeOf(TCefClient);
  ACefClient.CefClient.base.add_ref := @cef_base_add_ref;
  ACefClient.CefClient.base.release := @cef_base_release;
  ACefClient.CefClient.base.get_refct := @cef_base_get_refct;

  ACefClient.CefClient.get_life_span_handler := @cef_client_get_life_span_handler;
  ACefClient.CefClient.get_load_handler := @cef_client_get_load_handler;
  ACefClient.CefClient.get_request_handler := @cef_client_get_request_handler;
  ACefClient.CefClient.get_display_handler := @cef_client_get_display_handler;
  ACefClient.CefClient.get_focus_handler := @cef_client_get_focus_handler;
  ACefClient.CefClient.get_keyboard_handler := @cef_client_get_keyboard_handler;
  ACefClient.CefClient.get_menu_handler := @cef_client_get_menu_handler;
  ACefClient.CefClient.get_permission_handler := @cef_client_get_permission_handler;
  ACefClient.CefClient.get_print_handler := @cef_client_get_print_handler;
  ACefClient.CefClient.get_find_handler := @cef_client_get_find_handler;
  ACefClient.CefClient.get_jsdialog_handler := @cef_client_get_jsdialog_handler;
  ACefClient.CefClient.get_v8context_handler := @cef_client_get_v8context_handler;
  ACefClient.CefClient.get_render_handler := @cef_client_get_render_handler;
  ACefClient.CefClient.get_drag_handler := @cef_client_get_drag_handler;
  ACefClient.CefClient.get_geolocation_handler := @cef_client_get_geolocation_handler;
  ACefClient.CefClient.get_zoom_handler := @cef_client_get_zoom_handler;
  ACefClient.CefClientObj := ACefClientObject;
end;

function CefString(const str: ustring): TCefString; overload;
begin
  Result.str := PChar16(PWideChar(str));
  Result.length := Length(str);
  Result.dtor := nil;
end;

function CefString(const str: PCefString): ustring; overload;
begin
  if str <> nil then
    SetString(Result, str.str, str.length) else
    Result := '';
end;

function CefStringFreeAndGet(const str: PCefStringUserFree): ustring;
begin
  if str <> nil then
  begin
    Result := CefString(PCefString(str));
    CefApp.CefLibrary.cef_string_userfree_free(str);
  end else
  begin
    Result := '';
  end;
end;

procedure CefRunMessageLoop;
begin
  CefApp.CefLibrary.cef_run_message_loop;
end;

procedure CefQuitMessageLoop;
begin
  CefApp.CefLibrary.cef_quit_message_loop;
end;


procedure CefTimerProc(AWnd: HWND; uMsg: UINT; idEvent: Pointer; dwTime: DWORD); stdcall;
begin
  if not CefApp.CefLibrary.CefSyncMessageLooping then
  begin
    CefApp.CefLibrary.CefSyncMessageLooping := True;
    try
      CefApp.CefLibrary.cef_do_message_loop_work;
      //CefLibrary.cef_run_message_loop;
    finally
      CefApp.CefLibrary.CefSyncMessageLooping := False;
    end;
  end;
end;

procedure InitCefLib(ACefLibrary: PCefLibrary; ACefAppObject: PCefAppObject);
begin
  InitCefApp(@ACefAppObject.CefAppIntf);
  InitCefAppProxyHandler(@ACefAppObject.CefAppIntf_ProxyHandler);
  InitCefAppResourceBundleHandler(@ACefAppObject.CefAppIntf_ResourceBundleHandler);

  ACefLibrary.CefCoreSettings.multi_threaded_message_loop := False;
  ACefLibrary.CefCoreSettings.multi_threaded_message_loop := True;
  CefLoadLibDefault(ACefLibrary, ACefAppObject);
end;

end.
