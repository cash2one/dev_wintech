
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
  cef_type;

type
  PCefAppObject     = ^TCefAppObject;
  PCefClientObject  = ^TCefClientObject;

  PCefIntfApp       = ^TCefIntfApp;
  TCefIntfApp       = record
    IntfPtr         : PCefApp;
    CefApp          : TCefApp;
  end;

  PCefIntfProxyHandler = ^TCefIntfProxyHandler;
  TCefIntfProxyHandler = record
    IntfPtr         : PCefProxyHandler;
    CefProxyHandler : TCefProxyHandler;
  end;

  PCefIntfResourceBundleHandler = ^TCefIntfResourceBundleHandler;
  TCefIntfResourceBundleHandler = record
    IntfPtr         : PCefResourceBundleHandler;
    CefResourceBundleHandler: TCefResourceBundleHandler;
  end;

  TCefAppObject     = record
    CefAppIntf      : TCefIntfApp;
    CefAppIntf_ProxyHandler : TCefIntfProxyHandler;
    CefAppIntf_ResourceBundleHandler: TCefIntfResourceBundleHandler;
  end;

  PCefIntfClient    = ^TCefIntfClient;
  TCefIntfClient    = record
    IntfPtr         : PCefClient;
    CefClient       : TCefClient;
    CefClientObj    : PCefClientObject;
  end;

  PCefExClient = ^TCefExClient;
  TCefExClient = record
    CefClient : TCefClient;
    CefClientObj: PCefClientObject;
  end;

  PCefIntfLoadHandler = ^TCefIntfLoadHandler;
  TCefIntfLoadHandler = record
    IntfPtr         : PCefLoadHandler;
    CefLoadHandler  : TCefLoadHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefExLoadHandler = ^TCefExLoadHandler;
  TCefExLoadHandler = record
    CefLoadHandler  : TCefLoadHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfDomVisitor  = ^TCefIntfDomVisitor;
  TCefIntfDomVisitor  = record
    IntfPtr         : PCefDomVisitor;
    CefDomVisitor   : TCefDomVisitor;
    CefClientObj    : PCefClientObject;
  end;

  PCefExDomVisitor  = ^TCefExDomVisitor;
  TCefExDomVisitor  = record
    CefDomVisitor   : TCefDomVisitor;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfLifeSpanHandler = ^TCefIntfLifeSpanHandler;
  TCefIntfLifeSpanHandler = record
    IntfPtr           : PCefLifeSpanHandler;
    CefLifeSpanHandler: TCefLifeSpanHandler;
    CefClientObj      : PCefClientObject;
  end;

  PCefExLifeSpanHandler = ^TCefExLifeSpanHandler;
  TCefExLifeSpanHandler = record
    CefLifeSpanHandler: TCefLifeSpanHandler;
    CefClientObj      : PCefClientObject;
  end;

  PCefIntfContentFilter = ^TCefIntfContentFilter;
  TCefIntfContentFilter = record
    IntfPtr           : PCefContentFilter;
    CefContentFilter  : TCefContentFilter;
    url               : AnsiString;
  end;

  PCefExContentFilter = ^TCefExContentFilter;
  TCefExContentFilter = record
    CefContentFilter  : TCefContentFilter;
    url               : AnsiString;
  end;

  PCefIntfReadHandler = ^TCefIntfReadHandler;
  TCefIntfReadHandler = record
    IntfPtr           : PCefReadHandler;
    CefReadReader     : TCefReadHandler;
    FileUrl           : AnsiString;
    //FileStream        : TFileStream;
  end;

  PCefExReadHandler   = ^TCefExReadHandler;
  TCefExReadHandler   = record
    CefReadHandler   : TCefReadHandler;
    FileUrl           : AnsiString;
    //FileStream        : TFileStream;
  end;

  PCefIntfRequestHandler = ^TCefIntfRequestHandler;
  TCefIntfRequestHandler = record
    IntfPtr           : PCefRequestHandler;
    CefRequestHandler : TCefRequestHandler;
    CefClientObj      : PCefClientObject;
    CefReadHandler    : TCefIntfReadHandler;
    CefContentFilter  : TCefIntfContentFilter;
  end;

  PCefExRequestHandler = ^TCefExRequestHandler;
  TCefExRequestHandler = record
    CefRequestHandler : TCefRequestHandler;
    CefClientObj      : PCefClientObject;
    CefReadHandler    : TCefIntfReadHandler;
    CefContentFilter  : TCefIntfContentFilter;
  end;

  PCefIntfStreamReader = ^TCefIntfStreamReader;
  TCefIntfStreamReader = record
    IntfPtr           : PCefStreamReader;
    CefStreamReader   : TCefStreamReader;
    FileUrl           : AnsiString;
    //FileStream        : TFileStream;
  end;

  PCefExStreamReader = ^TCefExStreamReader;
  TCefExStreamReader = record
    CefStreamReader   : TCefStreamReader;
    FileUrl           : AnsiString;
    //FileStream        : TFileStream;
  end;

  PCefIntfDisplayHandler = ^TCefIntfDisplayHandler;
  TCefIntfDisplayHandler = record
    IntfPtr         : PCefDisplayHandler;
    CefDisplayHandler: TCefDisplayHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfFocusHandler = ^TCefIntfFocusHandler;
  TCefIntfFocusHandler = record
    IntfPtr         : PCefFocusHandler;
    CefFocusHandler : TCefFocusHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfKeyboardHandler = ^TCefIntfKeyboardHandler;
  TCefIntfKeyboardHandler = record
    IntfPtr         : PCefKeyboardHandler;
    CefKeyboardHandler: TCefKeyboardHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfMenuHandler = ^TCefIntfMenuHandler;
  TCefIntfMenuHandler = record
    IntfPtr         : PCefMenuHandler;
    CefMenuHandler  : TCefMenuHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfPermissionHandler = ^TCefIntfPermissionHandler;
  TCefIntfPermissionHandler = record
    IntfPtr         : PCefPermissionHandler;
    CefPermissionHandler: TCefPermissionHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfPrintHandler = ^TCefIntfPrintHandler;
  TCefIntfPrintHandler = record
    IntfPtr         : PCefPrintHandler;
    CefPrintHandler : TCefPrintHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfFindHandler = ^TCefIntfFindHandler;
  TCefIntfFindHandler = record
    IntfPtr         : PCefFindHandler;
    CefFindHandler  : TCefFindHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfJsDialogHandler = ^TCefIntfJsDialogHandler;
  TCefIntfJsDialogHandler = record
    IntfPtr         : PCefJsDialogHandler;
    CefJsDialogHandler: TCefJsDialogHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfV8contextHandler = ^TCefIntfV8contextHandler;
  TCefIntfV8contextHandler = record
    IntfPtr         : PCefV8contextHandler;
    CefV8contextHandler: TCefV8contextHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfRenderHandler = ^TCefIntfRenderHandler;
  TCefIntfRenderHandler = record
    IntfPtr         : PCefRenderHandler;
    CefRenderHandler: TCefRenderHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefExRenderHandler = ^TCefExRenderHandler;
  TCefExRenderHandler = record
    CefRenderHandler: TCefRenderHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfDragHandler = ^TCefIntfDragHandler;
  TCefIntfDragHandler = record
    IntfPtr         : PCefDragHandler;
    CefDragHandler  : TCefDragHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfGeolocationHandler = ^TCefIntfGeolocationHandler;
  TCefIntfGeolocationHandler = record
    IntfPtr         : PCefGeolocationHandler;
    CefGeolocationHandler: TCefGeolocationHandler;
    CefClientObj    : PCefClientObject;
  end;

  PCefIntfZoomHandler = ^TCefIntfZoomHandler;
  TCefIntfZoomHandler = record
    IntfPtr         : PCefZoomHandler;
    CefZoomHandler  : TCefZoomHandler;
    CefClientObj    : PCefClientObject;
  end;

  TCefClientObject                = record
    CefClientIntf                 : TCefIntfClient;
    CefClientIntf_LoadHandler     : TCefIntfLoadHandler;
    CefClientIntf_LifeSpan        : TCefIntfLifeSpanHandler;
    CefClientIntf_RequestHandler  : TCefIntfRequestHandler;
    CefClientIntf_DisplayHandler  : TCefIntfDisplayHandler;
    CefClientIntf_FocusHandler    : TCefIntfFocusHandler;
    CefClientIntf_KeyboardHandler : TCefIntfKeyboardHandler;
    CefClientIntf_MenuHandler     : TCefIntfMenuHandler;
    CefClientIntf_PermissionHandler: TCefIntfPermissionHandler;
    CefClientIntf_PrintHandler    : TCefIntfPrintHandler;
    CefClientIntf_FindHandler     : TCefIntfFindHandler;
    CefClientIntf_JsDialogHandler : TCefIntfJsDialogHandler;
    CefClientIntf_V8contextHandler: TCefIntfV8contextHandler;
    CefClientIntf_RenderHandler   : TCefIntfRenderHandler;
    CefClientIntf_DragHandler     : TCefIntfDragHandler;
    CefClientIntf_GeolocationHandler: TCefIntfGeolocationHandler;
    CefClientIntf_ZoomHandler     : TCefIntfZoomHandler;

    CefDomVisitor: TCefIntfDomVisitor;

    CefPopupRect      : TCefRect;
    CefKeyinfo        : TCefKeyInfo;
    CefBrowser        : PCefBrowser;
    CefIsShowDevTools : Boolean;
    CefIsCreateWindow : Boolean;
    HostWindow        : HWND;
    CefBrowserHandle  : HWND;
    //CefUIMemDC_View   : TMemDC;
    //CefMemDC_Popup    : PMemDC;
    //OwnerWindow       : PMKUIBaseWindow;
    Rect              : TRect;
    Width             : integer;
    Height            : integer;
    CefUrl            : string;
    CefOnLoadEnd      : procedure (ACefClient: PCefClientObject; AUrl: string);
    CefOnPaintEnd     : procedure (ACefClient: PCefClientObject);
  end;

  PCefLibrary = ^TCefLibrary;
  TCefLibrary = record
    LibHandle: THandle;
    CefCoreSettings: TCefSettings;
    CefSyncMessageTimer: UINT;
    CefSyncMessageLooping: Boolean;
    CefCache: ustring;
    CefUserAgent: ustring;
    CefProductVersion: ustring;
    CefLocale: ustring;
    CefLogFile: ustring;
    CefExtraPluginPaths: ustring;
    CefJavaScriptFlags: ustring;
    CefResourcesDirPath: ustring;
    CefLocalesDirPath: ustring;

    CefReleaseDCheckEnabled: Boolean;
    CefPackLoadingDisabled: Boolean;
  {$ifdef MSWINDOWS}
    CefAutoDetectProxySettings: Boolean;
  {$endif}
    CefLocalStorageQuota: Cardinal;
    CefSessionStorageQuota: Cardinal;
    CefUncaughtExceptionStackSize: Integer;
    CefContextSafetyImplementation: Integer;

    CefLogSeverity: TCefLogSeverity;
    CefGraphicsImplementation: TCefGraphicsImplementation;

    cef_string_wide_set: function(const src: PWideChar; src_len: Cardinal;  output: PCefStringWide; copy: Integer): Integer; cdecl;
    cef_string_utf8_set: function(const src: PAnsiChar; src_len: Cardinal; output: PCefStringUtf8; copy: Integer): Integer; cdecl;
    cef_string_utf16_set: function(const src: PChar16; src_len: Cardinal; output: PCefStringUtf16; copy: Integer): Integer; cdecl;
    cef_string_set: function(const src: PCefChar; src_len: Cardinal; output: PCefString; copy: Integer): Integer; cdecl;

    cef_string_wide_clear: procedure(str: PCefStringWide); cdecl;
    cef_string_utf8_clear: procedure(str: PCefStringUtf8); cdecl;
    cef_string_utf16_clear: procedure(str: PCefStringUtf16); cdecl;
    cef_string_clear: procedure(str: PCefString); cdecl;

    cef_string_wide_cmp: function(const str1, str2: PCefStringWide): Integer; cdecl;
    cef_string_utf8_cmp: function(const str1, str2: PCefStringUtf8): Integer; cdecl;
    cef_string_utf16_cmp: function(const str1, str2: PCefStringUtf16): Integer; cdecl;

    cef_string_wide_to_utf8: function(const src: PWideChar; src_len: Cardinal; output: PCefStringUtf8): Integer; cdecl;
    cef_string_utf8_to_wide: function(const src: PAnsiChar; src_len: Cardinal; output: PCefStringWide): Integer; cdecl;

    cef_string_wide_to_utf16: function (const src: PWideChar; src_len: Cardinal; output: PCefStringUtf16): Integer; cdecl;
    cef_string_utf16_to_wide: function(const src: PChar16; src_len: Cardinal; output: PCefStringWide): Integer; cdecl;

    cef_string_utf8_to_utf16: function(const src: PAnsiChar; src_len: Cardinal; output: PCefStringUtf16): Integer; cdecl;
    cef_string_utf16_to_utf8: function(const src: PChar16; src_len: Cardinal; output: PCefStringUtf8): Integer; cdecl;

    cef_string_to_utf8: function(const src: PCefChar; src_len: Cardinal; output: PCefStringUtf8): Integer; cdecl;
    cef_string_from_utf8: function(const src: PAnsiChar; src_len: Cardinal; output: PCefString): Integer; cdecl;
    cef_string_to_utf16: function(const src: PCefChar; src_len: Cardinal; output: PCefStringUtf16): Integer; cdecl;
    cef_string_from_utf16: function(const src: PChar16; src_len: Cardinal; output: PCefString): Integer; cdecl;
    cef_string_to_wide: function(const src: PCefChar; src_len: Cardinal; output: PCefStringWide): Integer; cdecl;
    cef_string_from_wide: function(const src: PWideChar; src_len: Cardinal; output: PCefString): Integer; cdecl;

    cef_string_ascii_to_wide: function(const src: PAnsiChar; src_len: Cardinal; output: PCefStringWide): Integer; cdecl;
    cef_string_ascii_to_utf16: function(const src: PAnsiChar; src_len: Cardinal; output: PCefStringUtf16): Integer; cdecl;
    cef_string_from_ascii: function(const src: PAnsiChar; src_len: Cardinal; output: PCefString): Integer; cdecl;

    cef_string_userfree_wide_alloc: function(): PCefStringUserFreeWide; cdecl;
    cef_string_userfree_utf8_alloc: function(): PCefStringUserFreeUtf8; cdecl;
    cef_string_userfree_utf16_alloc: function(): PCefStringUserFreeUtf16; cdecl;
    cef_string_userfree_alloc: function(): PCefStringUserFree; cdecl;

    cef_string_userfree_wide_free: procedure(str: PCefStringUserFreeWide); cdecl;
    cef_string_userfree_utf8_free: procedure(str: PCefStringUserFreeUtf8); cdecl;
    cef_string_userfree_utf16_free: procedure(str: PCefStringUserFreeUtf16); cdecl;
    cef_string_userfree_free: procedure(str: PCefStringUserFree); cdecl;

    cef_browser_create: function(windowInfo: PCefWindowInfo;
        client: PCefClient; const url: PCefString;
        const settings: PCefBrowserSettings): Integer; cdecl;

    cef_browser_create_sync: function(windowInfo: PCefWindowInfo;
      client: PCefClient; const url: PCefString;
      const settings: PCefBrowserSettings): PCefBrowser; cdecl;

    cef_do_message_loop_work: procedure(); cdecl;

    cef_run_message_loop: procedure; cdecl;

    cef_quit_message_loop: procedure; cdecl;
    cef_set_osmodal_loop: procedure(osModalLoop: Integer); cdecl;
    cef_initialize: function(const settings: PCefSettings; application: PCefApp): Integer; cdecl;

    cef_shutdown: procedure(); cdecl;

    cef_string_map_alloc: function(): TCefStringMap; cdecl;
    cef_string_map_size: function(map: TCefStringMap): Integer; cdecl;
    cef_string_map_find: function(map: TCefStringMap; const key: PCefString; var value: TCefString): Integer; cdecl;
    cef_string_map_key: function(map: TCefStringMap; index: Integer; var key: TCefString): Integer; cdecl;
    cef_string_map_value: function(map: TCefStringMap; index: Integer; var value: TCefString): Integer; cdecl;
    cef_string_map_append: function(map: TCefStringMap; const key, value: PCefString): Integer; cdecl;
    cef_string_map_clear: procedure(map: TCefStringMap); cdecl;
    cef_string_map_free: procedure(map: TCefStringMap); cdecl;

    cef_string_list_alloc: function(): TCefStringList; cdecl;
    cef_string_list_size: function(list: TCefStringList): Integer; cdecl;
    cef_string_list_value: function(list: TCefStringList; index: Integer; value: PCefString): Integer; cdecl;
    cef_string_list_append: procedure(list: TCefStringList; const value: PCefString); cdecl;
    cef_string_list_clear: procedure(list: TCefStringList); cdecl;
    cef_string_list_free: procedure(list: TCefStringList); cdecl;
    cef_string_list_copy: function(list: TCefStringList): TCefStringList;

    cef_register_extension: function(const extension_name,
      javascript_code: PCefString; handler: PCefv8Handler): Integer; cdecl;

    cef_register_scheme_handler_factory: function(
        const scheme_name, domain_name: PCefString;
        factory: PCefSchemeHandlerFactory): Integer; cdecl;

    cef_clear_scheme_handler_factories: function: Integer; cdecl;

    cef_add_cross_origin_whitelist_entry: function(const source_origin, target_protocol,
      target_domain: PCefString; allow_target_subdomains: Integer): Integer; cdecl;

    cef_remove_cross_origin_whitelist_entry: function(
        const source_origin, target_protocol, target_domain: PCefString;
        allow_target_subdomains: Integer): Integer; cdecl;

    cef_clear_cross_origin_whitelist: function: Integer; cdecl;

    cef_currently_on: function(threadId: TCefThreadId): Integer; cdecl;

    cef_post_task: function(threadId: TCefThreadId; task: PCefTask): Integer; cdecl;

    cef_post_delayed_task: function(threadId: TCefThreadId;
        task: PCefTask; delay_ms: Int64): Integer; cdecl;

    cef_parse_url: function(const url: PCefString; var parts: TCefUrlParts): Integer; cdecl;

    cef_create_url: function(parts: PCefUrlParts; url: PCefString): Integer; cdecl;

    cef_request_create: function(): PCefRequest; cdecl;

    cef_post_data_create: function(): PCefPostData; cdecl;
    cef_post_data_element_create: function(): PCefPostDataElement; cdecl;

    cef_stream_reader_create_for_file: function(const fileName: PCefString): PCefStreamReader; cdecl;
    cef_stream_reader_create_for_data: function(data: Pointer; size: Cardinal): PCefStreamReader; cdecl;
    cef_stream_reader_create_for_handler: function(handler: PCefReadHandler): PCefStreamReader; cdecl;

    cef_stream_writer_create_for_file: function(const fileName: PCefString): PCefStreamWriter; cdecl;
    cef_stream_writer_create_for_handler: function(handler: PCefWriteHandler): PCefStreamWriter; cdecl;

    cef_v8context_get_current_context: function(): PCefv8Context; cdecl;
    cef_v8context_get_entered_context: function(): PCefv8Context; cdecl;
    cef_v8context_in_context: function(): Integer;

    cef_v8value_create_undefined: function(): PCefv8Value; cdecl;
    cef_v8value_create_null: function(): PCefv8Value; cdecl;
    cef_v8value_create_bool: function(value: Integer): PCefv8Value; cdecl;
    cef_v8value_create_int: function(value: Integer): PCefv8Value; cdecl;
    cef_v8value_create_uint: function(value: Cardinal): PCefv8Value; cdecl;
    cef_v8value_create_double: function(value: Double): PCefv8Value; cdecl;
    cef_v8value_create_date: function(const value: PCefTime): PCefv8Value; cdecl;
    cef_v8value_create_string: function(const value: PCefString): PCefv8Value; cdecl;
    cef_v8value_create_object: function(accessor: PCefV8Accessor): PCefv8Value; cdecl;
    cef_v8value_create_array: function(length: Integer): PCefv8Value; cdecl;
    cef_v8value_create_function: function(const name: PCefString; handler: PCefv8Handler): PCefv8Value; cdecl;
    cef_v8stack_trace_get_current: function(frame_limit: Integer): PCefV8StackTrace; cdecl;

    cef_web_urlrequest_create: function(request: PCefRequest; client: PCefWebUrlRequestClient): PCefWebUrlRequest; cdecl;
    cef_xml_reader_create: function(stream: PCefStreamReader;
      encodingType: TCefXmlEncodingType; const URI: PCefString): PCefXmlReader; cdecl;
    cef_zip_reader_create: function(stream: PCefStreamReader): PCefZipReader; cdecl;

    cef_string_multimap_alloc: function: TCefStringMultimap; cdecl;
    cef_string_multimap_size: function(map: TCefStringMultimap): Integer; cdecl;
    cef_string_multimap_find_count: function(map: TCefStringMultimap; const key: PCefString): Integer; cdecl;
    cef_string_multimap_enumerate: function(map: TCefStringMultimap;
      const key: PCefString; value_index: Integer; var value: TCefString): Integer; cdecl;
    cef_string_multimap_key: function(map: TCefStringMultimap; index: Integer; var key: TCefString): Integer; cdecl;
    cef_string_multimap_value: function(map: TCefStringMultimap; index: Integer; var value: TCefString): Integer; cdecl;
    cef_string_multimap_append: function(map: TCefStringMultimap; const key, value: PCefString): Integer; cdecl;
    cef_string_multimap_clear: procedure(map: TCefStringMultimap); cdecl;
    cef_string_multimap_free: procedure(map: TCefStringMultimap); cdecl;

    cef_build_revision: function: Integer; cdecl;
    cef_cookie_manager_get_global_manager: function(): PCefCookieManager; cdecl;
    cef_cookie_manager_create_manager: function(const path: PCefString): PCefCookieManager; cdecl;
    cef_get_web_plugin_count: function(): Cardinal; cdecl;
    cef_get_web_plugin_info: function(index: Integer): PCefWebPluginInfo; cdecl;
    cef_get_web_plugin_info_byname: function(const name: PCefString): PCefWebPluginInfo; cdecl;
    cef_get_geolocation: function(callback: PCefGetGeolocationCallback): Integer; cdecl;
  end;

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
  BaseApp, cef_app;

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

function cef_string_utf16_copy(const src: PChar16; src_len: Cardinal; output: PCefStringUtf16): Integer; cdecl;
begin
  Result := CefApp.CefLibrary.cef_string_utf16_set(src, src_len, output, ord(True))
end;

procedure CefLoadLib(ACefLibrary: PCefLibrary; ACefLibraryFileName: string);
var
  i: Integer;
  //**paths: TStringList;
  p: TCefString;
  s: ustring;
begin
  if ACefLibrary.LibHandle = 0 then
  begin
    if not FileExists(ACefLibraryFileName) then
    begin
      exit;
    end;
    if not ACefLibrary.CefCoreSettings.multi_threaded_message_loop then
    begin
      //这行代码太重要了 在同步模式下
      //否则 av 出错
      Set8087CW(Get8087CW or $3F); // deactivate FPU exception
    end;
    ACefLibrary.LibHandle := LoadLibrary(PChar(ACefLibraryFileName));
    if ACefLibrary.LibHandle = 0 then
    begin
//      RaiseLastOSError;
    end;

    ACefLibrary.cef_string_wide_set := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_wide_set');
    ACefLibrary.cef_string_utf8_set := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf8_set');
    ACefLibrary.cef_string_utf16_set := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf16_set');
    ACefLibrary.cef_string_wide_clear := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_wide_clear');
    ACefLibrary.cef_string_utf8_clear := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf8_clear');
    ACefLibrary.cef_string_utf16_clear := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf16_clear');
    ACefLibrary.cef_string_wide_cmp := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_wide_cmp');
    ACefLibrary.cef_string_utf8_cmp := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf8_cmp');
    ACefLibrary.cef_string_utf16_cmp := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf16_cmp');
    ACefLibrary.cef_string_wide_to_utf8 := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_wide_to_utf8');
    ACefLibrary.cef_string_utf8_to_wide := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf8_to_wide');
    ACefLibrary.cef_string_wide_to_utf16 := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_wide_to_utf16');
    ACefLibrary.cef_string_utf16_to_wide := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf16_to_wide');
    ACefLibrary.cef_string_utf8_to_utf16 := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf8_to_utf16');
    ACefLibrary.cef_string_utf16_to_utf8 := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_utf16_to_utf8');
    ACefLibrary.cef_string_ascii_to_wide := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_ascii_to_wide');
    ACefLibrary.cef_string_ascii_to_utf16 := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_ascii_to_utf16');
    ACefLibrary.cef_string_userfree_wide_alloc := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_userfree_wide_alloc');
    ACefLibrary.cef_string_userfree_utf8_alloc := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_userfree_utf8_alloc');
    ACefLibrary.cef_string_userfree_utf16_alloc := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_userfree_utf16_alloc');
    ACefLibrary.cef_string_userfree_wide_free := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_userfree_wide_free');
    ACefLibrary.cef_string_userfree_utf8_free := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_userfree_utf8_free');
    ACefLibrary.cef_string_userfree_utf16_free := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_userfree_utf16_free');

{$IFDEF CEF_STRING_TYPE_UTF8}
  CefLibrary.cef_string_set := CefLibrary.cef_string_utf8_set;
  CefLibrary.cef_string_clear := CefLibrary.cef_string_utf8_clear;
  CefLibrary.cef_string_userfree_alloc := CefLibrary.cef_string_userfree_utf8_alloc;
  CefLibrary.cef_string_userfree_free := CefLibrary.cef_string_userfree_utf8_free;
  CefLibrary.cef_string_from_ascii := CefLibrary.cef_string_utf8_copy;
  CefLibrary.cef_string_to_utf8 := CefLibrary.cef_string_utf8_copy;
  CefLibrary.cef_string_from_utf8 := CefLibrary.cef_string_utf8_copy;
  CefLibrary.cef_string_to_utf16 := CefLibrary.cef_string_utf8_to_utf16;
  CefLibrary.cef_string_from_utf16 := CefLibrary.cef_string_utf16_to_utf8;
  CefLibrary.cef_string_to_wide := CefLibrary.cef_string_utf8_to_wide;
  CefLibrary.cef_string_from_wide := CefLibrary.cef_string_wide_to_utf8;
{$ENDIF}

{$IFDEF CEF_STRING_TYPE_UTF16}
    ACefLibrary.cef_string_set := ACefLibrary.cef_string_utf16_set;
    ACefLibrary.cef_string_clear := ACefLibrary.cef_string_utf16_clear;
    ACefLibrary.cef_string_userfree_alloc := ACefLibrary.cef_string_userfree_utf16_alloc;
    ACefLibrary.cef_string_userfree_free := ACefLibrary.cef_string_userfree_utf16_free;
    ACefLibrary.cef_string_from_ascii := ACefLibrary.cef_string_ascii_to_utf16;
    ACefLibrary.cef_string_to_utf8 := ACefLibrary.cef_string_utf16_to_utf8;
    ACefLibrary.cef_string_from_utf8 := ACefLibrary.cef_string_utf8_to_utf16;
    ACefLibrary.cef_string_to_utf16 := cef_string_utf16_copy;
    ACefLibrary.cef_string_from_utf16 := cef_string_utf16_copy;
    ACefLibrary.cef_string_to_wide := ACefLibrary.cef_string_utf16_to_wide;
    ACefLibrary.cef_string_from_wide := ACefLibrary.cef_string_wide_to_utf16;
{$ENDIF}

{$IFDEF CEF_STRING_TYPE_WIDE}
    ACefLibrary.cef_string_set := ACefLibrary.cef_string_wide_set;
    ACefLibrary.cef_string_clear := ACefLibrary.cef_string_wide_clear;
    ACefLibrary.cef_string_userfree_alloc := ACefLibrary.cef_string_userfree_wide_alloc;
    ACefLibrary.cef_string_userfree_free := ACefLibrary.cef_string_userfree_wide_free;
    ACefLibrary.cef_string_from_ascii := ACefLibrary.cef_string_ascii_to_wide;
    ACefLibrary.cef_string_to_utf8 := ACefLibrary.cef_string_wide_to_utf8;
    ACefLibrary.cef_string_from_utf8 := ACefLibrary.cef_string_utf8_to_wide;
    ACefLibrary.cef_string_to_utf16 := ACefLibrary.cef_string_wide_to_utf16;
    ACefLibrary.cef_string_from_utf16 := ACefLibrary.cef_string_utf16_to_wide;
    ACefLibrary.cef_string_to_wide := ACefLibrary.cef_string_wide_copy;
    ACefLibrary.cef_string_from_wide := ACefLibrary.cef_string_wide_copy;
{$ENDIF}

    ACefLibrary.cef_string_map_alloc := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_map_alloc');
    ACefLibrary.cef_string_map_size := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_map_size');
    ACefLibrary.cef_string_map_find := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_map_find');
    ACefLibrary.cef_string_map_key := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_map_key');
    ACefLibrary.cef_string_map_value := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_map_value');
    ACefLibrary.cef_string_map_append := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_map_append');
    ACefLibrary.cef_string_map_clear := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_map_clear');
    ACefLibrary.cef_string_map_free := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_map_free');
    ACefLibrary.cef_string_list_alloc := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_list_alloc');
    ACefLibrary.cef_string_list_size := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_list_size');
    ACefLibrary.cef_string_list_value := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_list_value');
    ACefLibrary.cef_string_list_append := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_list_append');
    ACefLibrary.cef_string_list_clear := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_list_clear');
    ACefLibrary.cef_string_list_free := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_list_free');
    ACefLibrary.cef_string_list_copy := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_list_copy');
    ACefLibrary.cef_initialize := GetProcAddress(ACefLibrary.LibHandle, 'cef_initialize');
    ACefLibrary.cef_shutdown := GetProcAddress(ACefLibrary.LibHandle, 'cef_shutdown');
    ACefLibrary.cef_do_message_loop_work := GetProcAddress(ACefLibrary.LibHandle, 'cef_do_message_loop_work');
    ACefLibrary.cef_run_message_loop := GetProcAddress(ACefLibrary.LibHandle, 'cef_run_message_loop');
    ACefLibrary.cef_quit_message_loop := GetProcAddress(ACefLibrary.LibHandle, 'cef_quit_message_loop');
    ACefLibrary.cef_set_osmodal_loop := GetProcAddress(ACefLibrary.LibHandle, 'cef_set_osmodal_loop');
    ACefLibrary.cef_register_extension := GetProcAddress(ACefLibrary.LibHandle, 'cef_register_extension');
    ACefLibrary.cef_register_scheme_handler_factory := GetProcAddress(ACefLibrary.LibHandle, 'cef_register_scheme_handler_factory');
    ACefLibrary.cef_clear_scheme_handler_factories := GetProcAddress(ACefLibrary.LibHandle, 'cef_clear_scheme_handler_factories');
    ACefLibrary.cef_add_cross_origin_whitelist_entry := GetProcAddress(ACefLibrary.LibHandle, 'cef_add_cross_origin_whitelist_entry');
    ACefLibrary.cef_remove_cross_origin_whitelist_entry := GetProcAddress(ACefLibrary.LibHandle, 'cef_remove_cross_origin_whitelist_entry');
    ACefLibrary.cef_clear_cross_origin_whitelist := GetProcAddress(ACefLibrary.LibHandle, 'cef_clear_cross_origin_whitelist');
    ACefLibrary.cef_currently_on := GetProcAddress(ACefLibrary.LibHandle, 'cef_currently_on');
    ACefLibrary.cef_post_task := GetProcAddress(ACefLibrary.LibHandle, 'cef_post_task');
    ACefLibrary.cef_post_delayed_task := GetProcAddress(ACefLibrary.LibHandle, 'cef_post_delayed_task');
    ACefLibrary.cef_parse_url := GetProcAddress(ACefLibrary.LibHandle, 'cef_parse_url');
    ACefLibrary.cef_create_url := GetProcAddress(ACefLibrary.LibHandle, 'cef_create_url');
    ACefLibrary.cef_browser_create := GetProcAddress(ACefLibrary.LibHandle, 'cef_browser_create');
    ACefLibrary.cef_browser_create_sync := GetProcAddress(ACefLibrary.LibHandle, 'cef_browser_create_sync');
    ACefLibrary.cef_request_create := GetProcAddress(ACefLibrary.LibHandle, 'cef_request_create');
    ACefLibrary.cef_post_data_create := GetProcAddress(ACefLibrary.LibHandle, 'cef_post_data_create');
    ACefLibrary.cef_post_data_element_create := GetProcAddress(ACefLibrary.LibHandle, 'cef_post_data_element_create');
    ACefLibrary.cef_stream_reader_create_for_file := GetProcAddress(ACefLibrary.LibHandle, 'cef_stream_reader_create_for_file');
    ACefLibrary.cef_stream_reader_create_for_data := GetProcAddress(ACefLibrary.LibHandle, 'cef_stream_reader_create_for_data');
    ACefLibrary.cef_stream_reader_create_for_handler := GetProcAddress(ACefLibrary.LibHandle, 'cef_stream_reader_create_for_handler');
    ACefLibrary.cef_stream_writer_create_for_file := GetProcAddress(ACefLibrary.LibHandle, 'cef_stream_writer_create_for_file');
    ACefLibrary.cef_stream_writer_create_for_handler := GetProcAddress(ACefLibrary.LibHandle, 'cef_stream_writer_create_for_handler');
    ACefLibrary.cef_v8context_get_current_context := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8context_get_current_context');
    ACefLibrary.cef_v8context_get_entered_context := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8context_get_entered_context');
    ACefLibrary.cef_v8context_in_context := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8context_in_context');
    ACefLibrary.cef_v8value_create_undefined := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_undefined');
    ACefLibrary.cef_v8value_create_null := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_null');
    ACefLibrary.cef_v8value_create_bool := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_bool');
    ACefLibrary.cef_v8value_create_int := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_int');
    ACefLibrary.cef_v8value_create_uint := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_uint');
    ACefLibrary.cef_v8value_create_double := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_double');
    ACefLibrary.cef_v8value_create_date := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_date');
    ACefLibrary.cef_v8value_create_string := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_string');
    ACefLibrary.cef_v8value_create_object := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_object');
    ACefLibrary.cef_v8value_create_array := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_array');
    ACefLibrary.cef_v8value_create_function := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8value_create_function');
    ACefLibrary.cef_v8stack_trace_get_current := GetProcAddress(ACefLibrary.LibHandle, 'cef_v8stack_trace_get_current');
    ACefLibrary.cef_web_urlrequest_create := GetProcAddress(ACefLibrary.LibHandle, 'cef_web_urlrequest_create');
    ACefLibrary.cef_xml_reader_create := GetProcAddress(ACefLibrary.LibHandle, 'cef_xml_reader_create');
    ACefLibrary.cef_zip_reader_create := GetProcAddress(ACefLibrary.LibHandle, 'cef_zip_reader_create');

    ACefLibrary.cef_string_multimap_alloc := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_multimap_alloc');
    ACefLibrary.cef_string_multimap_size := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_multimap_size');
    ACefLibrary.cef_string_multimap_find_count := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_multimap_find_count');
    ACefLibrary.cef_string_multimap_enumerate := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_multimap_enumerate');
    ACefLibrary.cef_string_multimap_key := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_multimap_key');
    ACefLibrary.cef_string_multimap_value := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_multimap_value');
    ACefLibrary.cef_string_multimap_append := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_multimap_append');
    ACefLibrary.cef_string_multimap_clear := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_multimap_clear');
    ACefLibrary.cef_string_multimap_free := GetProcAddress(ACefLibrary.LibHandle, 'cef_string_multimap_free');
    ACefLibrary.cef_build_revision := GetProcAddress(ACefLibrary.LibHandle, 'cef_build_revision');

    ACefLibrary.cef_cookie_manager_get_global_manager := GetProcAddress(ACefLibrary.LibHandle, 'cef_cookie_manager_get_global_manager');
    ACefLibrary.cef_cookie_manager_create_manager := GetProcAddress(ACefLibrary.LibHandle, 'cef_cookie_manager_create_manager');

    ACefLibrary.cef_get_web_plugin_count := GetProcAddress(ACefLibrary.LibHandle, 'cef_get_web_plugin_count');
    ACefLibrary.cef_get_web_plugin_info := GetProcAddress(ACefLibrary.LibHandle, 'cef_get_web_plugin_info');
    ACefLibrary.cef_get_web_plugin_info_byname := GetProcAddress(ACefLibrary.LibHandle, 'cef_get_web_plugin_info_byname');

    ACefLibrary.cef_get_geolocation := GetProcAddress(ACefLibrary.LibHandle, 'cef_get_geolocation');

    if not (
      Assigned(ACefLibrary.cef_string_wide_set) and
      Assigned(ACefLibrary.cef_string_utf8_set) and
      Assigned(ACefLibrary.cef_string_utf16_set) and
      Assigned(ACefLibrary.cef_string_wide_clear) and
      Assigned(ACefLibrary.cef_string_utf8_clear) and
      Assigned(ACefLibrary.cef_string_utf16_clear) and
      Assigned(ACefLibrary.cef_string_wide_cmp) and
      Assigned(ACefLibrary.cef_string_utf8_cmp) and
      Assigned(ACefLibrary.cef_string_utf16_cmp) and
      Assigned(ACefLibrary.cef_string_wide_to_utf8) and
      Assigned(ACefLibrary.cef_string_utf8_to_wide) and
      Assigned(ACefLibrary.cef_string_wide_to_utf16) and
      Assigned(ACefLibrary.cef_string_utf16_to_wide) and
      Assigned(ACefLibrary.cef_string_utf8_to_utf16) and
      Assigned(ACefLibrary.cef_string_utf16_to_utf8) and
      Assigned(ACefLibrary.cef_string_ascii_to_wide) and
      Assigned(ACefLibrary.cef_string_ascii_to_utf16) and
      Assigned(ACefLibrary.cef_string_userfree_wide_alloc) and
      Assigned(ACefLibrary.cef_string_userfree_utf8_alloc) and
      Assigned(ACefLibrary.cef_string_userfree_utf16_alloc) and
      Assigned(ACefLibrary.cef_string_userfree_wide_free) and
      Assigned(ACefLibrary.cef_string_userfree_utf8_free) and
      Assigned(ACefLibrary.cef_string_userfree_utf16_free) and

      Assigned(ACefLibrary.cef_string_map_alloc) and
      Assigned(ACefLibrary.cef_string_map_size) and
      Assigned(ACefLibrary.cef_string_map_find) and
      Assigned(ACefLibrary.cef_string_map_key) and
      Assigned(ACefLibrary.cef_string_map_value) and
      Assigned(ACefLibrary.cef_string_map_append) and
      Assigned(ACefLibrary.cef_string_map_clear) and
      Assigned(ACefLibrary.cef_string_map_free) and
      Assigned(ACefLibrary.cef_string_list_alloc) and
      Assigned(ACefLibrary.cef_string_list_size) and
      Assigned(ACefLibrary.cef_string_list_value) and
      Assigned(ACefLibrary.cef_string_list_append) and
      Assigned(ACefLibrary.cef_string_list_clear) and
      Assigned(ACefLibrary.cef_string_list_free) and
      Assigned(ACefLibrary.cef_string_list_copy) and
      Assigned(ACefLibrary.cef_initialize) and
      Assigned(ACefLibrary.cef_shutdown) and
      Assigned(ACefLibrary.cef_do_message_loop_work) and
      Assigned(ACefLibrary.cef_run_message_loop) and
      Assigned(ACefLibrary.cef_quit_message_loop) and
      Assigned(ACefLibrary.cef_set_osmodal_loop) and
      Assigned(ACefLibrary.cef_register_extension) and
      Assigned(ACefLibrary.cef_register_scheme_handler_factory) and
      Assigned(ACefLibrary.cef_clear_scheme_handler_factories) and
      Assigned(ACefLibrary.cef_add_cross_origin_whitelist_entry) and
      Assigned(ACefLibrary.cef_remove_cross_origin_whitelist_entry) and
      Assigned(ACefLibrary.cef_clear_cross_origin_whitelist) and
      Assigned(ACefLibrary.cef_currently_on) and
      Assigned(ACefLibrary.cef_post_task) and
      Assigned(ACefLibrary.cef_post_delayed_task) and
      Assigned(ACefLibrary.cef_parse_url) and
      Assigned(ACefLibrary.cef_create_url) and
      Assigned(ACefLibrary.cef_browser_create) and
      Assigned(ACefLibrary.cef_browser_create_sync) and
      Assigned(ACefLibrary.cef_request_create) and
      Assigned(ACefLibrary.cef_post_data_create) and
      Assigned(ACefLibrary.cef_post_data_element_create) and
      Assigned(ACefLibrary.cef_stream_reader_create_for_file) and
      Assigned(ACefLibrary.cef_stream_reader_create_for_data) and
      Assigned(ACefLibrary.cef_stream_reader_create_for_handler) and
      Assigned(ACefLibrary.cef_stream_writer_create_for_file) and
      Assigned(ACefLibrary.cef_stream_writer_create_for_handler) and
      Assigned(ACefLibrary.cef_v8context_get_current_context) and
      Assigned(ACefLibrary.cef_v8context_get_entered_context) and
      Assigned(ACefLibrary.cef_v8context_in_context) and
      Assigned(ACefLibrary.cef_v8value_create_undefined) and
      Assigned(ACefLibrary.cef_v8value_create_null) and
      Assigned(ACefLibrary.cef_v8value_create_bool) and
      Assigned(ACefLibrary.cef_v8value_create_int) and
      Assigned(ACefLibrary.cef_v8value_create_uint) and
      Assigned(ACefLibrary.cef_v8value_create_double) and
      Assigned(ACefLibrary.cef_v8value_create_date) and
      Assigned(ACefLibrary.cef_v8value_create_string) and
      Assigned(ACefLibrary.cef_v8value_create_object) and
      Assigned(ACefLibrary.cef_v8value_create_array) and
      Assigned(ACefLibrary.cef_v8value_create_function) and
      Assigned(ACefLibrary.cef_v8stack_trace_get_current) and
      Assigned(ACefLibrary.cef_web_urlrequest_create) and
      Assigned(ACefLibrary.cef_xml_reader_create) and
      Assigned(ACefLibrary.cef_zip_reader_create) and

      Assigned(ACefLibrary.cef_string_multimap_alloc) and
      Assigned(ACefLibrary.cef_string_multimap_size) and
      Assigned(ACefLibrary.cef_string_multimap_find_count) and
      Assigned(ACefLibrary.cef_string_multimap_enumerate) and
      Assigned(ACefLibrary.cef_string_multimap_key) and
      Assigned(ACefLibrary.cef_string_multimap_value) and
      Assigned(ACefLibrary.cef_string_multimap_append) and
      Assigned(ACefLibrary.cef_string_multimap_clear) and
      Assigned(ACefLibrary.cef_string_multimap_free) and
      Assigned(ACefLibrary.cef_build_revision) and

      Assigned(ACefLibrary.cef_cookie_manager_get_global_manager) and
      Assigned(ACefLibrary.cef_cookie_manager_create_manager) and

      Assigned(ACefLibrary.cef_get_web_plugin_count) and
      Assigned(ACefLibrary.cef_get_web_plugin_info) and
      Assigned(ACefLibrary.cef_get_web_plugin_info_byname) and

      Assigned(ACefLibrary.cef_get_geolocation)

    ) then
    begin
//    raise ECefException.Create('Invalid CEF Library version');
    end;
  end;
end;

procedure CefLoadLibDefault(ACefLibrary: PCefLibrary; ACefAppObject: PCefAppObject);
var
  CefLibraryName: string;
  tmpRet: integer;
begin
  //CefLibraryName: string = {$IFDEF MSWINDOWS}'libcef.dll'{$ELSE}'libcef.dylib'{$ENDIF};
  CefLibraryName := '.\AppData\Chromium\1.1364.1123\libcef.dll';    
  if not FileExists(CefLibraryName) then
  begin
    CefLibraryName := '.\AppData\Chromium\1.1364.1123.0\libcef.dll';
  end;
  if not FileExists(CefLibraryName) then
  begin
    CefLibraryName := '.\Chromium\1.1364.1123.0\libcef.dll';
  end;          
  if not FileExists(CefLibraryName) then
  begin
    CefLibraryName := '.\Chromium\1.1364.1123\libcef.dll';
  end;
  if not FileExists(CefLibraryName) then
  begin
    CefLibraryName := '.\libcef.dll';
  end;
  if not FileExists(CefLibraryName) then
  begin
    CefLibraryName := '';
  end;
  if CefLibraryName <> '' then
  begin
    if ACefLibrary.LibHandle = 0 then
    begin
      CefLoadLib(ACefLibrary, CefLibraryName);
    end;
  end;
  if ACefLibrary.LibHandle <> 0 then
  begin
    ACefLibrary.CefCoreSettings.size := SizeOf(ACefLibrary.CefCoreSettings);
    ACefLibrary.CefCoreSettings.cache_path := CefString(ACefLibrary.CefCache);
    ACefLibrary.CefCoreSettings.user_agent := cefstring(ACefLibrary.CefUserAgent);
    ACefLibrary.CefCoreSettings.product_version := CefString(ACefLibrary.CefProductVersion);
    ACefLibrary.CefCoreSettings.locale := CefString(ACefLibrary.CefLocale);
    (*//
    s := ExtractFilePath(ParamStr(0)) + 'plugins\PepperFlash\';
    s := ExtractFilePath(ParamStr(0)) + 'plugins\';
    if (s <> '') then
    begin
      settings.extra_plugin_paths := cef_string_list_alloc;
      paths := TStringList.Create;
      try
        paths.Delimiter := ';';
        paths.DelimitedText := s; //ExtraPluginPaths
        for i := 0 to paths.Count - 1 do
        begin
          p := cefString(paths[i]);
          cef_string_list_append(settings.extra_plugin_paths, @p);
        end;
      finally
        paths.free;
      end;
    end;
    //*)
    ACefLibrary.CefCoreSettings.log_file := CefString(ACefLibrary.CefLogFile);
    ACefLibrary.CefCoreSettings.resources_dir_path := CefString(ACefLibrary.CefResourcesDirPath);
    ACefLibrary.CefCoreSettings.locales_dir_path := CefString(ACefLibrary.CefLocalesDirPath);
    ACefLibrary.CefCoreSettings.javascript_flags := CefString(ACefLibrary.CefJavaScriptFlags);

    ACefLibrary.CefCoreSettings.release_dcheck_enabled := ACefLibrary.CefReleaseDCheckEnabled;
  {$ifdef MSWINDOWS}
    ACefLibrary.CefCoreSettings.auto_detect_proxy_settings_enabled := ACefLibrary.CefAutoDetectProxySettings;
  {$endif}
    ACefLibrary.CefCoreSettings.pack_loading_disabled := ACefLibrary.CefPackLoadingDisabled;

    ACefLibrary.CefLogSeverity := LOGSEVERITY_DISABLE;
    ACefLibrary.CefCoreSettings.log_severity := ACefLibrary.CefLogSeverity;
    ACefLibrary.CefGraphicsImplementation := {$IFDEF MACOS}DESKTOP_IN_PROCESS {$ELSE} ANGLE_IN_PROCESS{$ENDIF};
    ACefLibrary.CefCoreSettings.graphics_implementation := ACefLibrary.CefGraphicsImplementation;

    ACefLibrary.CefCoreSettings.local_storage_quota := ACefLibrary.CefLocalStorageQuota;
    ACefLibrary.CefCoreSettings.session_storage_quota := ACefLibrary.CefSessionStorageQuota;
    ACefLibrary.CefCoreSettings.uncaught_exception_stack_size := ACefLibrary.CefUncaughtExceptionStackSize;
    ACefLibrary.CefCoreSettings.context_safety_implementation := ACefLibrary.CefContextSafetyImplementation;

    ACefLibrary.CefCoreSettings.extra_plugin_paths := ACefLibrary.cef_string_list_alloc;
    tmpRet := ACefLibrary.cef_initialize(@ACefLibrary.CefCoreSettings, @ACefAppObject.CefAppIntf.CefApp);

    (*//
    cef_initialize(@settings, CefGetData(TInternalApp.Create));
    //*)
    if ACefLibrary.CefCoreSettings.extra_plugin_paths <> nil then
    begin
      ACefLibrary.cef_string_list_free(ACefLibrary.CefCoreSettings.extra_plugin_paths);
    end;
  end;
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
