
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

  function CefString(const str: ustring): TCefString; overload;
  function CefString(const str: PCefString): ustring; overload;
  function CefStringFreeAndGet(const str: PCefStringUserFree): ustring;
  procedure CefTimerProc(AWnd: HWND; uMsg: UINT; idEvent: Pointer; dwTime: DWORD); stdcall;

  function cef_base_add_ref(self: PCefBase): Integer; stdcall;  
  function cef_base_release(self: PCefBase): Integer; stdcall; 
  function cef_base_get_refct(self: PCefBase): Integer; stdcall;

implementation

uses
  BaseApp, cef_app,
  cef_apilib_resbundlehandler,
  cef_apilib_proxyhandler,
  cef_apilib_init;

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
