
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apiobj;
{$ALIGN ON}
{$MINENUMSIZE 4}
{$I cef.inc}

interface

uses
  Windows, cef_type, cef_api;
  
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
    ExParam           : Pointer;
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

implementation

end.
