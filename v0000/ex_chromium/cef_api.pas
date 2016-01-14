
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_api;
{$ALIGN ON}
{$MINENUMSIZE 4}
{$I cef.inc}

interface

uses
  cef_type;

type
  PCefv8Handler = ^TCefv8Handler;
  PCefV8Accessor = ^TCefV8Accessor;
  PCefv8Value = ^TCefv8Value;
  PCefV8ValueArray = array[0..(High(Integer) div SizeOf(Integer)) - 1] of PCefV8Value;
  PPCefV8Value = ^PCefV8ValueArray;
  PCefSchemeHandlerFactory = ^TCefSchemeHandlerFactory;
  PCefSchemeHandlerCallback = ^TCefSchemeHandlerCallback;
  PCefFrame = ^TCefFrame;
  PCefRequest = ^TCefRequest;
  PCefStreamReader = ^TCefStreamReader;
  PCefMenuInfo = ^TCefMenuInfo;
  PCefPrintInfo = ^TCefPrintInfo;
  PCefPostData = ^TCefPostData;
  PCefPostDataElement = ^TCefPostDataElement;
  PPCefPostDataElement = ^PCefPostDataElement;
  PCefReadHandler = ^TCefReadHandler;
  PCefWriteHandler = ^TCefWriteHandler;
  PCefStreamWriter = ^TCefStreamWriter;
  PCefSchemeHandler = ^TCefSchemeHandler;
  PCefBase = ^TCefBase;
  PCefBrowser = ^TCefBrowser;
  PCefTask = ^TCefTask;
  PCefDownloadHandler = ^TCefDownloadHandler;
  PCefXmlReader = ^TCefXmlReader;
  PCefZipReader = ^TCefZipReader;
  PCefDomVisitor = ^TCefDomVisitor;
  PCefDomDocument = ^TCefDomDocument;
  PCefDomNode = ^TCefDomNode;
  PCefDomEventListener = ^TCefDomEventListener;
  PCefDomEvent = ^TCefDomEvent;
  PCefResponse = ^TCefResponse;
  PCefv8Context = ^TCefv8Context;
  PCefWebUrlRequest = ^TCefWebUrlRequest;
  PCefWebUrlRequestClient = ^TCefWebUrlRequestClient;
  PCefCookieVisitor = ^TCefCookieVisitor;
  PCefCookie = ^TCefCookie;
  PCefClient = ^TCefClient;
  PCefLifeSpanHandler = ^TCefLifeSpanHandler;
  PCefLoadHandler = ^TCefLoadHandler;
  PCefRequestHandler = ^TCefRequestHandler;
  PCefContentFilter = ^TCefContentFilter;
  PCefDisplayHandler = ^TCefDisplayHandler;
  PCefFocusHandler = ^TCefFocusHandler;
  PCefKeyboardHandler = ^TCefKeyboardHandler;
  PCefMenuHandler = ^TCefMenuHandler;
  PCefPrintHandler = ^TCefPrintHandler;
  PCefFindHandler = ^TCefFindHandler;
  PCefJsDialogHandler = ^TCefJsDialogHandler;
  PCefV8contextHandler = ^TCefV8contextHandler;
  PCefRenderHandler = ^TCefRenderHandler;
  PCefDragHandler = ^TCefDragHandler;
  PCefDragData = ^TCefDragData;
  PCefProxyHandler = ^TCefProxyHandler;
  PCefProxyInfo = ^TCefProxyInfo;
  PCefApp = ^TCefApp;
  PCefV8Exception = ^TCefV8Exception;
  PCefResourceBundleHandler = ^TCefResourceBundleHandler;
  PCefPermissionHandler = ^TCefPermissionHandler;
  PCefGetGeolocationCallback = ^TCefGetGeolocationCallback;
  PCefCookieManager = ^TCefCookieManager;
  PCefWebPluginInfo = ^TCefWebPluginInfo;
  PCefSchemeRegistrar = ^TCefSchemeRegistrar;
  PCefGeoposition = ^TCefGeoposition;
  PCefGeolocationCallback = ^TCefGeolocationCallback;
  PCefGeolocationHandler = ^TCefGeolocationHandler;
  PCefZoomHandler = ^TCefZoomHandler;
  PCefV8StackTrace = ^TCefV8StackTrace;
  PCefV8StackFrame = ^TCefV8StackFrame;

  TCefBase = record
    size: Cardinal;
    add_ref: function(self: PCefBase): Integer; stdcall;
    release: function(self: PCefBase): Integer; stdcall;
    get_refct: function(self: PCefBase): Integer; stdcall;
  end;

  TCefTask = record
    base: TCefBase;
    execute: procedure(self: PCefTask; threadId: TCefThreadId); stdcall;
  end;

  TCefBrowser = record
    base: TCefBase;
    parent_window_will_close: procedure(self: PCefBrowser); stdcall;
    close_browser: procedure(self: PCefBrowser); stdcall;
    can_go_back: function(self: PCefBrowser): Integer; stdcall;
    go_back: procedure(self: PCefBrowser); stdcall;
    can_go_forward: function(self: PCefBrowser): Integer; stdcall;
    go_forward: procedure(self: PCefBrowser); stdcall;
    reload: procedure(self: PCefBrowser); stdcall;
    reload_ignore_cache: procedure(self: PCefBrowser); stdcall;
    stop_load: procedure(self: PCefBrowser); stdcall;
    set_focus: procedure(self: PCefBrowser; enable: Integer); stdcall;
    get_window_handle: function(self: PCefBrowser): TCefWindowHandle; stdcall;
    get_opener_window_handle: function(self: PCefBrowser): TCefWindowHandle; stdcall;
    get_identifier: function(self: PCefBrowser): Integer; stdcall;
    is_popup: function(self: PCefBrowser): Integer; stdcall;
    has_document: function(self: PCefBrowser): Integer; stdcall;
    get_client: function(self: PCefBrowser): PCefClient; stdcall;
    get_main_frame: function(self: PCefBrowser): PCefFrame; stdcall;
    get_focused_frame: function (self: PCefBrowser): PCefFrame; stdcall;
    get_frame: function(self: PCefBrowser; const name: PCefString): PCefFrame; stdcall;
    get_frame_names: procedure(self: PCefBrowser; names: TCefStringList); stdcall;
    find: procedure(self: PCefBrowser; identifier: Integer; const searchText: PCefString;
      forward, matchCase, findNext: Integer); stdcall;
    stop_finding: procedure(self: PCefBrowser; clearSelection: Integer); stdcall;
    get_zoom_level: function(self: PCefBrowser): Double; stdcall;
    set_zoom_level: procedure(self: PCefBrowser; zoomLevel: Double); stdcall;
    clear_history: procedure(self: PCefBrowser); stdcall;
    show_dev_tools: procedure(self: PCefBrowser); stdcall;
    close_dev_tools: procedure(self: PCefBrowser); stdcall;
    is_window_rendering_disabled: function(self: PCefBrowser): Integer; stdcall;
    get_size: function(self: PCefBrowser; kind: TCefPaintElementType; width, height: PInteger): Integer; stdcall;
    set_size: procedure(self: PCefBrowser; kind: TCefPaintElementType; width, height: Integer); stdcall;
    is_popup_visible: function(self: PCefBrowser): Integer; stdcall;
    hide_popup: procedure(self: PCefBrowser); stdcall;
    invalidate: procedure(self: PCefBrowser; const dirtyRect: PCefRect); stdcall;
    get_image: function(self: PCefBrowser; kind: TCefPaintElementType;
      width, height: Integer; buffer: Pointer): Integer; stdcall;
    send_key_event: procedure(self: PCefBrowser; kind: TCefKeyType;
      const keyInfo: PCefKeyInfo; modifiers: Integer); stdcall;
    send_mouse_click_event: procedure(self: PCefBrowser;
      x, y: Integer; kind: TCefMouseButtonType; mouseUp, clickCount: Integer); stdcall;
    send_mouse_move_event: procedure(self: PCefBrowser; x, y, mouseLeave: Integer); stdcall;
    send_mouse_wheel_event: procedure(self: PCefBrowser; x, y, deltaX, deltaY: Integer); stdcall;
    send_focus_event: procedure(self: PCefBrowser; setFocus: Integer); stdcall;
    send_capture_lost_event: procedure(self: PCefBrowser); stdcall;
  end;

  TCefFrame = record
    base: TCefBase;
    undo: procedure(self: PCefFrame); stdcall;
    redo: procedure(self: PCefFrame); stdcall;
    cut: procedure(self: PCefFrame); stdcall;
    copy: procedure(self: PCefFrame); stdcall;
    paste: procedure(self: PCefFrame); stdcall;
    del: procedure(self: PCefFrame); stdcall;
    select_all: procedure(self: PCefFrame); stdcall;
    print: procedure(self: PCefFrame); stdcall;
    view_source: procedure(self: PCefFrame); stdcall;
    get_source: function(self: PCefFrame): PCefStringUserFree; stdcall;
    get_text: function(self: PCefFrame): PCefStringUserFree; stdcall;
    load_request: procedure(self: PCefFrame; request: PCefRequest); stdcall;
    load_url: procedure(self: PCefFrame; const url: PCefString); stdcall;
    load_string: procedure(self: PCefFrame; const stringVal, url: PCefString); stdcall;
    load_stream: procedure(self: PCefFrame; stream: PCefStreamReader; const url: PCefString); stdcall;
    execute_java_script: procedure(self: PCefFrame; const jsCode, scriptUrl: PCefString; startLine: Integer); stdcall;
    is_main: function(self: PCefFrame): Integer; stdcall;
    is_focused: function(self: PCefFrame): Integer; stdcall;
    get_name: function(self: PCefFrame): PCefStringUserFree; stdcall;
    get_identifier: function(self: PCefFrame): Int64; stdcall;
    get_parent: function(self: PCefFrame): PCefFrame; stdcall;
    get_url: function(self: PCefFrame): PCefStringUserFree; stdcall;
    get_browser: function(self: PCefFrame): PCefBrowser; stdcall;
    visit_dom: procedure(self: PCefFrame; visitor: PCefDomVisitor); stdcall;
    get_v8context: function(self: PCefFrame): PCefv8Context; stdcall;
  end;

  TCefProxyHandler = record
    base: TCefBase;
    get_proxy_for_url: procedure(self: PCefProxyHandler;
        const url: PCefString; proxy_info: PCefProxyInfo); stdcall;
  end;

  TCefResourceBundleHandler = record
    base: TCefBase;
    get_localized_string: function(self: PCefResourceBundleHandler;
      message_id: Integer; string_val: PCefString): Integer; stdcall;
    get_data_resource: function(self: PCefResourceBundleHandler;
        resource_id: Integer; var data: Pointer; var data_size: Cardinal): Integer; stdcall;
  end;

  TCefApp = record
    base: TCefBase;
    on_register_custom_schemes: procedure(self: PCefApp; registrar: PCefSchemeRegistrar); stdcall;
    get_resource_bundle_handler: function(self: PCefApp): PCefResourceBundleHandler; stdcall;
    get_proxy_handler: function(self: PCefApp): PCefProxyHandler; stdcall;
  end;

  TCefLifeSpanHandler = record
    base: TCefBase;
    on_before_popup: function(self: PCefLifeSpanHandler; parentBrowser: PCefBrowser;
       const popupFeatures: PCefPopupFeatures; windowInfo: PCefWindowInfo;
       const url: PCefString; var client: PCefClient;
       settings: PCefBrowserSettings): Integer; stdcall;
    on_after_created: procedure(self: PCefLifeSpanHandler; browser: PCefBrowser); stdcall;
    run_modal: function(self: PCefLifeSpanHandler; browser: PCefBrowser): Integer; stdcall;
    do_close: function(self: PCefLifeSpanHandler; browser: PCefBrowser): Integer; stdcall;
    on_before_close: procedure(self: PCefLifeSpanHandler; browser: PCefBrowser); stdcall;
  end;

  TCefLoadHandler = record
    base: TCefBase;
    on_load_start: procedure(self: PCefLoadHandler;
      browser: PCefBrowser; frame: PCefFrame); stdcall;
    on_load_end: procedure(self: PCefLoadHandler; browser: PCefBrowser;
      frame: PCefFrame; httpStatusCode: Integer); stdcall;
    on_load_error: function(self: PCefLoadHandler;
        browser: PCefBrowser; frame: PCefFrame;
        errorCode: TCefHandlerErrorcode; const failedUrl: PCefString;
        var errorText: TCefString): Integer; stdcall;
  end;

  TCefRequestHandler = record
    base: TCefBase;
    on_before_browse: function(self: PCefRequestHandler;
        browser: PCefBrowser; frame: PCefFrame;
        request: PCefRequest; navType: TCefHandlerNavtype;
        isRedirect: Integer): Integer; stdcall;
    on_before_resource_load: function(
        self: PCefRequestHandler; browser: PCefBrowser;
        request: PCefRequest; redirectUrl: PCefString;
        var resourceStream: PCefStreamReader;
        response: PCefResponse; loadFlags: Integer): Integer; stdcall;
    on_resource_redirect: procedure(
        self: PCefRequestHandler; browser: PCefBrowser;
        const old_url: PCefString; new_url: PCefString); stdcall;
    on_resource_response: procedure(self: PCefRequestHandler;
        browser: PCefBrowser; const url: PCefString;
        response: PCefResponse; var filter: PCefContentFilter); stdcall;
    on_protocol_execution: function(self: PCefRequestHandler;
        browser: PCefBrowser; const url: PCefString;
        var allowOSExecution: Integer): Integer; stdcall;
    get_download_handler: function(self: PCefRequestHandler;
        browser: PCefBrowser; const mimeType: PCefString;
        const fileName: PCefString; contentLength: int64;
        var handler: PCefDownloadHandler): Integer; stdcall;
    get_auth_credentials: function(self: PCefRequestHandler;
        browser: PCefBrowser; isProxy: Integer; const host: PCefString;
        port: Integer; const realm: PCefString; const scheme: PCefString;
        username, password: PCefString): Integer; stdcall;
    get_cookie_manager: function(self: PCefRequestHandler;
      browser: PCefBrowser; const main_url: PCefString): PCefCookieManager; stdcall;
  end;

  TCefDisplayHandler = record
    base: TCefBase;
    on_nav_state_change: procedure(self: PCefDisplayHandler;
      browser: PCefBrowser; canGoBack, canGoForward: Integer); stdcall;
    on_address_change: procedure(self: PCefDisplayHandler;
        browser: PCefBrowser; frame: PCefFrame;
        const url: PCefString); stdcall;
    on_contents_size_change: procedure(
      self: PCefDisplayHandler; browser: PCefBrowser;
      frame: PCefFrame; width, height: Integer); stdcall;
    on_title_change: procedure(self: PCefDisplayHandler;
        browser: PCefBrowser; const title: PCefString); stdcall;
    on_favicon_urlchange: procedure(self: PCefDisplayHandler;
        browser: PCefBrowser; icon_urls: TCefStringList); stdcall;
    on_tooltip: function(self: PCefDisplayHandler;
        browser: PCefBrowser; text: PCefString): Integer; stdcall;
    on_status_message: procedure(self: PCefDisplayHandler;
        browser: PCefBrowser; const value: PCefString;
        kind: TCefHandlerStatusType); stdcall;
    on_console_message: function(self: PCefDisplayHandler;
        browser: PCefBrowser; const message: PCefString;
        const source: PCefString; line: Integer): Integer; stdcall;
  end;

  TCefFocusHandler = record
    base: TCefBase;
    on_take_focus: procedure(self: PCefFocusHandler;
        browser: PCefBrowser; next: Integer); stdcall;
    on_set_focus: function(self: PCefFocusHandler;
        browser: PCefBrowser; source: TCefHandlerFocusSource): Integer; stdcall;
    on_focused_node_changed: procedure(self: PCefFocusHandler;
        browser: PCefBrowser; frame: PCefFrame; node: PCefDomNode); stdcall;
  end;

  TCefKeyboardHandler = record
    base: TCefBase;
    on_key_event: function(self: PCefKeyboardHandler;
        browser: PCefBrowser; kind: TCefHandlerKeyEventType;
        code, modifiers, isSystemKey, isAfterJavaScript: Integer): Integer; stdcall;
  end;

  TCefMenuHandler = record
    base: TCefBase;
    on_before_menu: function(self: PCefMenuHandler; browser: PCefBrowser;
        const menuInfo: PCefMenuHandler): Integer; stdcall;
    get_menu_label: procedure(self: PCefMenuHandler;
        browser: PCefBrowser; menuId: TCefMenuId;
        var label_: TCefString); stdcall;
    on_menu_action: function(self: PCefMenuHandler;
        browser: PCefBrowser; menuId: TCefMenuId): Integer; stdcall;
  end;

  TCefPrintHandler = record
    base: TCefBase;
    get_print_options: function(self: PCefPrintHandler;
        browser: PCefBrowser; printOptions: PCefPrintOptions): Integer; stdcall;
    get_print_header_footer: function(self: PCefPrintHandler;
        browser: PCefBrowser; frame: PCefFrame;
        const printInfo: PCefPrintInfo; const url: PCefString;
        const title: PCefString; currentPage, maxPages: Integer;
        var topLeft, topCenter, topRight, bottomLeft, bottomCenter,
        bottomRight: TCefString): Integer; stdcall;
  end;

  TCefFindHandler = record
    base: TCefBase;
    on_find_result: procedure(self: PCefFindHandler;
        browser: PCefBrowser; identifier, count: Integer;
        const selectionRect: PCefRect; activeMatchOrdinal,
        finalUpdate: Integer); stdcall;
  end;

  TCefJsDialogHandler = record
    base: TCefBase;
    on_jsalert: function(self: PCefJsDialogHandler;
        browser: PCefBrowser; frame: PCefFrame;
        const message: PCefString): Integer; stdcall;
    on_jsconfirm: function(self: PCefJsDialogHandler;
        browser: PCefBrowser; frame: PCefFrame;
        const message: PCefString; var retval: Integer): Integer; stdcall;
    on_jsprompt: function(self: PCefJsDialogHandler;
        browser: PCefBrowser; frame: PCefFrame;
        const message, defaultValue: PCefString;
        var retval: Integer; var result: TCefString): Integer; stdcall;
  end;

  TCefV8contextHandler = record
    base: TCefBase;
    on_context_created: procedure(self: PCefV8contextHandler;
      browser: PCefBrowser; frame: PCefFrame; context: PCefv8Context); stdcall;
    on_context_released: procedure(self: PCefV8contextHandler;
      browser: PCefBrowser; frame: PCefFrame; context: PCefv8Context); stdcall;
    on_uncaught_exception: procedure(self: PCefV8contextHandler;
        browser: PCefBrowser; frame: PCefFrame; context: PCefv8Context;
        exception: PCefV8Exception; stackTrace: PCefV8StackTrace); stdcall;
  end;

  TCefRenderHandler = record
    base: TCefBase;
    get_view_rect: function(self: PCefRenderHandler;
        browser: PCefBrowser; rect: PCefRect): Integer; stdcall;
    get_screen_rect: function(self: PCefRenderHandler;
        browser: PCefBrowser; rect: PCefRect): Integer; stdcall;
    get_screen_point: function(self: PCefRenderHandler;
        browser: PCefBrowser; viewX, viewY: Integer;
        screenX, screenY: PInteger): Integer; stdcall;
    on_popup_show: procedure(self: PCefRenderHandler;
        browser: PCefBrowser; show: Integer); stdcall;
    on_popup_size: procedure(self: PCefRenderHandler;
        browser: PCefBrowser; const rect: PCefRect); stdcall;
    on_paint: procedure(self: PCefRenderHandler;
        browser: PCefBrowser; kind: TCefPaintElementType;
        dirtyRectsCount: Cardinal; const dirtyRects: PCefRectArray;
        const buffer: Pointer); stdcall;
    on_cursor_change: procedure(self: PCefRenderHandler;
        browser: PCefBrowser; cursor: TCefCursorHandle); stdcall;
  end;

  TCefDragHandler = record
    base: TCefBase;
    on_drag_start: function(self: PCefDragHandler; browser: PCefBrowser; dragData: PCefDragData;
        mask: TCefDragOperations): Integer; stdcall;
    on_drag_enter: function(self: PCefDragHandler; browser: PCefBrowser;
      dragData: PCefDragData; mask: TCefDragOperations): Integer; stdcall;
  end;

  TCefPermissionHandler = record
    base: TCefBase;
    on_before_script_extension_load: function(self: PCefPermissionHandler;
      browser: PCefBrowser; frame: PCefFrame; const extensionName: PCefString): Integer; stdcall;
  end;

  TCefGetGeolocationCallback = record
    base: TCefBase;
    on_location_update: procedure(self: PCefGetGeolocationCallback;
        const position: PCefGeoPosition); stdcall;
  end;

  TCefGeolocationCallback = record
    base: TCefBase;
    cont: procedure(self: PCefGeolocationCallback; allow: Integer); stdcall;
  end;

  TCefGeolocationHandler = record
    base: TCefBase;
    on_request_geolocation_permission: procedure(self: PCefGeolocationHandler;
        browser: PCefBrowser; const requesting_url: PCefString; request_id: Integer;
        callback: PCefGeolocationCallback); stdcall;
    on_cancel_geolocation_permission: procedure(self: PCefGeolocationHandler;
        browser: PCefBrowser; const requesting_url: PCefString; request_id: Integer); stdcall;
  end;

  TCefZoomHandler = record
    base: TCefBase;
    on_get_zoom_level: function(self: PCefZoomHandler; browser: PCefBrowser;
      const url: PCefString; zoomLevel: PDouble): Integer; stdcall;
    on_set_zoom_level: function(self: PCefZoomHandler; browser: PCefBrowser;
      const url: PCefString; zoomLevel: Double): Integer; stdcall;
  end;

  TCefClient = record
    base: TCefBase;
    get_life_span_handler: function(self: PCefClient): PCefLifeSpanHandler; stdcall;
    get_load_handler: function(self: PCefClient): PCefLoadHandler; stdcall;
    get_request_handler: function(self: PCefClient): PCefRequestHandler; stdcall;
    get_display_handler: function(self: PCefClient): PCefDisplayHandler; stdcall;
    get_focus_handler: function(self: PCefClient): PCefFocusHandler; stdcall;
    get_keyboard_handler: function(self: PCefClient): PCefKeyboardHandler; stdcall;
    get_menu_handler: function(self: PCefClient): PCefMenuHandler; stdcall;
    get_permission_handler: function(self: PCefClient): PCefPermissionHandler; stdcall;
    get_print_handler: function(self: PCefClient): PCefPrintHandler; stdcall;
    get_find_handler: function(self: PCefClient): PCefFindHandler; stdcall;
    get_jsdialog_handler: function(self: PCefClient): PCefJsDialogHandler; stdcall;
    get_v8context_handler: function(self: PCefClient): PCefV8contextHandler; stdcall;
    get_render_handler: function(self: PCefClient): PCefRenderHandler; stdcall;
    get_drag_handler: function(self: PCefClient): PCefDragHandler; stdcall;
    get_geolocation_handler: function(self: PCefClient): PCefGeolocationHandler; stdcall;
    get_zoom_handler: function(self: PCefClient): PCefZoomHandler; stdcall;
  end;

  TCefRequest = record
    base: TCefBase;
    get_url: function(self: PCefRequest): PCefStringUserFree; stdcall;
    set_url: procedure(self: PCefRequest; const url: PCefString); stdcall;
    get_method: function(self: PCefRequest): PCefStringUserFree; stdcall;
    set_method: procedure(self: PCefRequest; const method: PCefString); stdcall;
    get_post_data: function(self: PCefRequest): PCefPostData; stdcall;
    set_post_data: procedure(self: PCefRequest; postData: PCefPostData); stdcall;
    get_header_map: procedure(self: PCefRequest; headerMap: TCefStringMultimap); stdcall;
    set_header_map: procedure(self: PCefRequest; headerMap: TCefStringMultimap); stdcall;
    set_: procedure(self: PCefRequest; const url, method: PCefString;
      postData: PCefPostData; headerMap: TCefStringMultimap); stdcall;
    get_flags: function(self: PCefRequest): TCefWebUrlRequestFlags; stdcall;
    set_flags: procedure(self: PCefRequest; flags: TCefWebUrlRequestFlags); stdcall;
    get_first_party_for_cookies: function(self: PCefRequest): PCefStringUserFree; stdcall;
    set_first_party_for_cookies: procedure(self: PCefRequest; const url: PCefString); stdcall;
  end;

  TCefPostDataElementArray = array[0..(High(Integer) div SizeOf(PCefPostDataElement)) - 1] of PCefPostDataElement;
  PCefPostDataElementArray = ^TCefPostDataElementArray;

  TCefPostData = record
    base: TCefBase;
    get_element_count: function(self: PCefPostData): Cardinal; stdcall;
    get_elements: procedure(self: PCefPostData; elementsCount: PCardinal;
      elements: PCefPostDataElementArray); stdcall;
    remove_element: function(self: PCefPostData;
      element: PCefPostDataElement): Integer; stdcall;
    add_element: function(self: PCefPostData;
        element: PCefPostDataElement): Integer; stdcall;
    remove_elements: procedure(self: PCefPostData); stdcall;
  end;

  TCefPostDataElement = record
    base: TCefBase;
    set_to_empty: procedure(self: PCefPostDataElement); stdcall;
    set_to_file: procedure(self: PCefPostDataElement;
        const fileName: PCefString); stdcall;
    set_to_bytes: procedure(self: PCefPostDataElement;
        size: Cardinal; const bytes: Pointer); stdcall;
    get_type: function(self: PCefPostDataElement): TCefPostDataElementType; stdcall;
    get_file: function(self: PCefPostDataElement): PCefStringUserFree; stdcall;
    get_bytes_count: function(self: PCefPostDataElement): Cardinal; stdcall;
    get_bytes: function(self: PCefPostDataElement;
        size: Cardinal; bytes: Pointer): Cardinal; stdcall;
  end;

  TCefResponse = record
    base: TCefBase;
    get_status: function(self: PCefResponse): Integer; stdcall;
    set_status: procedure(self: PCefResponse; status: Integer); stdcall;
    get_status_text: function(self: PCefResponse): PCefStringUserFree; stdcall;
    set_status_text: procedure(self: PCefResponse; const statusText: PCefString); stdcall;
    get_mime_type: function(self: PCefResponse): PCefStringUserFree; stdcall;
    set_mime_type: procedure(self: PCefResponse; const mimeType: PCefString); stdcall;
    get_header: function(self: PCefResponse; const name: PCefString): PCefStringUserFree; stdcall;
    get_header_map: procedure(self: PCefResponse; headerMap: TCefStringMultimap); stdcall;
    set_header_map: procedure(self: PCefResponse; headerMap: TCefStringMultimap); stdcall;
  end;

  TCefReadHandler = record
    base: TCefBase;
    read: function(self: PCefReadHandler; ptr: Pointer;
      size, n: Cardinal): Cardinal; stdcall;
    seek: function(self: PCefReadHandler; offset: Int64;
      whence: Integer): Integer; stdcall;
    tell: function(self: PCefReadHandler): Int64; stdcall;
    eof: function(self: PCefReadHandler): Integer; stdcall;
  end;

  TCefStreamReader = record
    base: TCefBase;
    read: function(self: PCefStreamReader; ptr: Pointer;
        size, n: Cardinal): Cardinal; stdcall;
    seek: function(self: PCefStreamReader; offset: Int64;
        whence: Integer): Integer; stdcall;
    tell: function(self: PCefStreamReader): Int64; stdcall;
    eof: function(self: PCefStreamReader): Integer; stdcall;
  end;

  TCefWriteHandler = record
    base: TCefBase;
    write: function(self: PCefWriteHandler;
        const ptr: Pointer; size, n: Cardinal): Cardinal; stdcall;
    seek: function(self: PCefWriteHandler; offset: Int64;
        whence: Integer): Integer; stdcall;
    tell: function(self: PCefWriteHandler): Int64; stdcall;
    flush: function(self: PCefWriteHandler): Integer; stdcall;
  end;

  TCefStreamWriter = record
    base: TCefBase;
    write: function(self: PCefStreamWriter;
        const ptr: Pointer; size, n: Cardinal): Cardinal; stdcall;
    seek: function(self: PCefStreamWriter; offset: Int64;
        whence: Integer): Integer; stdcall;
    tell: function(self: PCefStreamWriter): Int64; stdcall;
    flush: function(self: PCefStreamWriter): Integer; stdcall;
  end;

  TCefV8Context = record
    base: TCefBase;
    is_valid: function(self: PCefv8Context): Integer; stdcall;
    get_browser: function(self: PCefv8Context): PCefBrowser; stdcall;
    get_frame: function(self: PCefv8Context): PCefFrame; stdcall;
    get_global: function(self: PCefv8Context): PCefv8Value; stdcall;
    enter: function(self: PCefv8Context): Integer; stdcall;
    exit: function(self: PCefv8Context): Integer; stdcall;
    is_same: function(self, that: PCefv8Context): Integer;
    eval: function(self: PCefv8Context; const code: PCefString;
      out retval: PCefv8Value; out exception: PCefV8Exception): Integer; stdcall;
  end;

  TCefv8Handler = record
    base: TCefBase;
    execute: function(self: PCefv8Handler;
        const name: PCefString; obj: PCefv8Value; argumentsCount: Cardinal;
        const arguments: PPCefV8Value; var retval: PCefV8Value;
        var exception: TCefString): Integer; stdcall;
  end;

  TCefV8Accessor = record
    base: TCefBase;
    get: function(self: PCefV8Accessor; const name: PCefString;
      obj: PCefv8Value; out retval: PCefv8Value; exception: PCefString): Integer; stdcall;
    put: function(self: PCefV8Accessor; const name: PCefString;
      obj: PCefv8Value; value: PCefv8Value; exception: PCefString): Integer; stdcall;
  end;

  TCefV8Exception = record
    base: TCefBase;
    get_message: function(self: PCefV8Exception): PCefStringUserFree; stdcall;
    get_source_line: function(self: PCefV8Exception): PCefStringUserFree; stdcall;
    get_script_resource_name: function(self: PCefV8Exception): PCefStringUserFree; stdcall;
    get_line_number: function(self: PCefV8Exception): Integer; stdcall;
    get_start_position: function(self: PCefV8Exception): Integer; stdcall;
    get_end_position: function(self: PCefV8Exception): Integer; stdcall;
    get_start_column: function(self: PCefV8Exception): Integer; stdcall;
    get_end_column: function(self: PCefV8Exception): Integer; stdcall;
  end;

  TCefv8Value = record
    base: TCefBase;
    is_valid: function(self: PCefv8Value): Integer; stdcall;
    is_undefined: function(self: PCefv8Value): Integer; stdcall;
    is_null: function(self: PCefv8Value): Integer; stdcall;
    is_bool: function(self: PCefv8Value): Integer; stdcall;
    is_int: function(self: PCefv8Value): Integer; stdcall;
    is_uint: function(self: PCefv8Value): Integer; stdcall;
    is_double: function(self: PCefv8Value): Integer; stdcall;
    is_date: function(self: PCefv8Value): Integer; stdcall;
    is_string: function(self: PCefv8Value): Integer; stdcall;
    is_object: function(self: PCefv8Value): Integer; stdcall;
    is_array: function(self: PCefv8Value): Integer; stdcall;
    is_function: function(self: PCefv8Value): Integer; stdcall;
    is_same: function(self, that: PCefv8Value): Integer; stdcall;
    get_bool_value: function(self: PCefv8Value): Integer; stdcall;
    get_int_value: function(self: PCefv8Value): Integer; stdcall;
    get_uint_value: function(self: PCefv8Value): Cardinal; stdcall;
    get_double_value: function(self: PCefv8Value): double; stdcall;
    get_date_value: function(self: PCefv8Value): TCefTime; stdcall;
    get_string_value: function(self: PCefv8Value): PCefStringUserFree; stdcall;
    is_user_created: function(self: PCefv8Value): Integer; stdcall;
    has_exception: function(self: PCefv8Value): Integer; stdcall;
    get_exception: function(self: PCefv8Value): PCefV8Exception; stdcall;
    clear_exception: function(self: PCefv8Value): Integer; stdcall;
    will_rethrow_exceptions: function(self: PCefv8Value): Integer; stdcall;
    set_rethrow_exceptions: function(self: PCefv8Value; rethrow: Integer): Integer; stdcall;
    has_value_bykey: function(self: PCefv8Value; const key: PCefString): Integer; stdcall;
    has_value_byindex: function(self: PCefv8Value; index: Integer): Integer; stdcall;
    delete_value_bykey: function(self: PCefv8Value; const key: PCefString): Integer; stdcall;
    delete_value_byindex: function(self: PCefv8Value; index: Integer): Integer; stdcall;
    get_value_bykey: function(self: PCefv8Value; const key: PCefString): PCefv8Value; stdcall;
    get_value_byindex: function(self: PCefv8Value; index: Integer): PCefv8Value; stdcall;
    set_value_bykey: function(self: PCefv8Value; const key: PCefString;
      value: PCefv8Value; attribute: TCefV8PropertyAttributes): Integer; stdcall;
    set_value_byindex: function(self: PCefv8Value; index: Integer;
       value: PCefv8Value): Integer; stdcall;
    set_value_byaccessor: function(self: PCefv8Value; const key: PCefString;
      settings: TCefV8AccessControls; attribute: TCefV8PropertyAttributes): Integer; stdcall;
    get_keys: function(self: PCefv8Value;
        keys: TCefStringList): Integer; stdcall;
    set_user_data: function(self: PCefv8Value; user_data: PCefBase): Integer; stdcall;
    get_user_data: function(
        self: PCefv8Value): PCefBase; stdcall;
    get_externally_allocated_memory: function(self: PCefv8Value): Integer; stdcall;
    adjust_externally_allocated_memory: function(self: PCefv8Value; change_in_bytes: Integer): Integer; stdcall;
    get_array_length: function(self: PCefv8Value): Integer; stdcall;
    get_function_name: function(self: PCefv8Value): PCefStringUserFree; stdcall;
    get_function_handler: function(
        self: PCefv8Value): PCefv8Handler; stdcall;
    execute_function: function(self, obj: PCefv8Value;
        argumentsCount: Cardinal; const arguments: PPCefV8Value): PCefv8Value; stdcall;
    execute_function_with_context: function(self: PCefV8value;
        context: PCefv8Context; obj: PCefv8Value; argumentsCount: Cardinal;
        const arguments: PPCefV8Value): PCefV8Value; stdcall;
  end;

  TCefV8StackTrace = record
    base: TCefBase;
    is_valid: function(self: PCefV8StackTrace): Integer; stdcall;
    get_frame_count: function(self: PCefV8StackTrace): Integer; stdcall;
    get_frame: function(self: PCefV8StackTrace; index: Integer): PCefV8StackFrame; stdcall;
  end;

  TCefV8StackFrame = record
    base: TCefBase;
    is_valid: function(self: PCefV8StackFrame): Integer; stdcall;
    get_script_name: function(self: PCefV8StackFrame): PCefStringUserFree; stdcall;
    get_script_name_or_source_url: function(self: PCefV8StackFrame): PCefStringUserFree; stdcall;
    get_function_name: function(self: PCefV8StackFrame): PCefStringUserFree; stdcall;
    get_line_number: function(self: PCefV8StackFrame): Integer; stdcall;
    get_column: function(self: PCefV8StackFrame): Integer; stdcall;
    is_eval: function(self: PCefV8StackFrame): Integer; stdcall;
    is_constructor: function(self: PCefV8StackFrame): Integer; stdcall;
  end;

  TCefSchemeHandlerFactory = record
    base: TCefBase;
    create: function(self: PCefSchemeHandlerFactory;
      browser: PCefBrowser; const scheme_name: PCefString;
      request: PCefRequest): PCefSchemeHandler; stdcall;
  end;

  TCefSchemeHandlerCallback = record
    base: TCefBase;
    headers_available: procedure(self: PCefSchemeHandlerCallback); stdcall;
    bytes_available: procedure(self: PCefSchemeHandlerCallback); stdcall;
    cancel: procedure(self: PCefSchemeHandlerCallback); stdcall;
  end;

  TCefSchemeHandler = record
    base: TCefBase;
    process_request: function(self: PCefSchemeHandler; request: PCefRequest;
      callback: PCefSchemeHandlerCallback): Integer; stdcall;
    get_response_headers: procedure(self: PCefSchemeHandler;
      response: PCefResponse; response_length: PInt64; redirectUrl: PCefString); stdcall;
    read_response: function(self: PCefSchemeHandler;
      data_out: Pointer; bytes_to_read: Integer; var bytes_read: Integer;
      callback: PCefSchemeHandlerCallback): Integer; stdcall;
    cancel: procedure(self: PCefSchemeHandler); stdcall;
  end;

  TCefDownloadHandler = record
    base: TCefBase;
    received_data: function(self: PCefDownloadHandler; data: Pointer; data_size: Integer): Integer; stdcall;
    complete: procedure(self: PCefDownloadHandler); stdcall;
  end;

  TCefWebUrlRequest = record
    base: TCefBase;
    cancel: procedure(self: PCefWebUrlRequest); stdcall;
    get_state: function(self: PCefWebUrlRequest): TCefWebUrlRequestState; stdcall;
  end;

  TCefWebUrlRequestClient = record
    base: TCefBase;
    on_state_change: procedure(self: PCefWebUrlRequestClient;
      requester: PCefWebUrlRequest; state: TCefWebUrlRequestState); stdcall;
    on_redirect: procedure(self: PCefWebUrlRequestClient;
        requester: PCefWebUrlRequest; request: PCefRequest;
        response: PCefResponse); stdcall;
    on_headers_received: procedure(self: PCefWebUrlRequestClient;
        requester: PCefWebUrlRequest;
        response: PCefResponse); stdcall;
    on_progress: procedure(self: PCefWebUrlRequestClient;
        requester: PCefWebUrlRequest; bytesSent,
        totalBytesToBeSent: uint64); stdcall;
    on_data: procedure(self: PCefWebUrlRequestClient;
        requester: PCefWebUrlRequest; const data: Pointer;
        dataLength: Integer); stdcall;
    on_error: procedure(self: PCefWebUrlRequestClient;
        requester: PCefWebUrlRequest; errorCode: TCefHandlerErrorcode); stdcall;
  end;

  TCefXmlReader = record
    base: TcefBase;
    move_to_next_node: function(self: PCefXmlReader): Integer; stdcall;
    close: function(self: PCefXmlReader): Integer; stdcall;
    has_error: function(self: PCefXmlReader): Integer; stdcall;
    get_error: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    get_type: function(self: PCefXmlReader): TCefXmlNodeType; stdcall;
    get_depth: function(self: PCefXmlReader): Integer; stdcall;
    get_local_name: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    get_prefix: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    get_qualified_name: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    get_namespace_uri: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    get_base_uri: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    get_xml_lang: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    is_empty_element: function(self: PCefXmlReader): Integer; stdcall;
    has_value: function(self: PCefXmlReader): Integer; stdcall;
    get_value: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    has_attributes: function(self: PCefXmlReader): Integer; stdcall;
    get_attribute_count: function(self: PCefXmlReader): Cardinal; stdcall;
    get_attribute_byindex: function(self: PCefXmlReader; index: Integer): PCefStringUserFree; stdcall;
    get_attribute_byqname: function(self: PCefXmlReader; const qualifiedName: PCefString): PCefStringUserFree; stdcall;
    get_attribute_bylname: function(self: PCefXmlReader; const localName, namespaceURI: PCefString): PCefStringUserFree; stdcall;
    get_inner_xml: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    get_outer_xml: function(self: PCefXmlReader): PCefStringUserFree; stdcall;
    get_line_number: function(self: PCefXmlReader): Integer; stdcall;
    move_to_attribute_byindex: function(self: PCefXmlReader; index: Integer): Integer; stdcall;
    move_to_attribute_byqname: function(self: PCefXmlReader; const qualifiedName: PCefString): Integer; stdcall;
    move_to_attribute_bylname: function(self: PCefXmlReader; const localName, namespaceURI: PCefString): Integer; stdcall;
    move_to_first_attribute: function(self: PCefXmlReader): Integer; stdcall;
    move_to_next_attribute: function(self: PCefXmlReader): Integer; stdcall;
    move_to_carrying_element: function(self: PCefXmlReader): Integer; stdcall;
  end;

  TCefZipReader = record
    base: TCefBase;
    move_to_first_file: function(self: PCefZipReader): Integer; stdcall;
    move_to_next_file: function(self: PCefZipReader): Integer; stdcall;
    move_to_file: function(self: PCefZipReader; const fileName: PCefString; caseSensitive: Integer): Integer; stdcall;
    close: function(Self: PCefZipReader): Integer; stdcall;
    get_file_name: function(Self: PCefZipReader): PCefStringUserFree; stdcall;
    get_file_size: function(Self: PCefZipReader): Int64; stdcall;
    get_file_last_modified: function(Self: PCefZipReader): LongInt; stdcall;
    open_file: function(Self: PCefZipReader; const password: PCefString): Integer; stdcall;
    close_file: function(Self: PCefZipReader): Integer; stdcall;
    read_file: function(Self: PCefZipReader; buffer: Pointer; bufferSize: Cardinal): Integer; stdcall;
    tell: function(Self: PCefZipReader): Int64; stdcall;
    eof: function(Self: PCefZipReader): Integer; stdcall;
  end;

  TCefDomVisitor = record
    base: TCefBase;
    visit: procedure(self: PCefDomVisitor; document: PCefDomDocument); stdcall;
  end;

  TCefDomDocument = record
    base: TCefBase;
    get_type: function(self: PCefDomDocument): TCefDomDocumentType; stdcall;
    get_document: function(self: PCefDomDocument): PCefDomNode; stdcall;
    get_body: function(self: PCefDomDocument): PCefDomNode; stdcall;
    get_head: function(self: PCefDomDocument): PCefDomNode; stdcall;
    get_title: function(self: PCefDomDocument): PCefStringUserFree; stdcall;
    get_element_by_id: function(self: PCefDomDocument; const id: PCefString): PCefDomNode; stdcall;
    get_focused_node: function(self: PCefDomDocument): PCefDomNode; stdcall;
    has_selection: function(self: PCefDomDocument): Integer; stdcall;
    get_selection_start_node: function(self: PCefDomDocument): PCefDomNode; stdcall;
    get_selection_start_offset: function(self: PCefDomDocument): Integer; stdcall;
    get_selection_end_node: function(self: PCefDomDocument): PCefDomNode; stdcall;
    get_selection_end_offset: function(self: PCefDomDocument): Integer; stdcall;
    get_selection_as_markup: function(self: PCefDomDocument): PCefStringUserFree; stdcall;
    get_selection_as_text: function(self: PCefDomDocument): PCefStringUserFree; stdcall;
    get_base_url: function(self: PCefDomDocument): PCefStringUserFree; stdcall;
    get_complete_url: function(self: PCefDomDocument; const partialURL: PCefString): PCefStringUserFree; stdcall;
  end;

  TCefDomNode = record
    base: TCefBase;
    get_type: function(self: PCefDomNode): TCefDomNodeType; stdcall;
    is_text: function(self: PCefDomNode): Integer; stdcall;
    is_element: function(self: PCefDomNode): Integer; stdcall;
    is_form_control_element: function(self: PCefDomNode): Integer; stdcall;
    get_form_control_element_type: function(self: PCefDomNode): PCefStringUserFree; stdcall;
    is_same: function(self, that: PCefDomNode): Integer; stdcall;
    get_name: function(self: PCefDomNode): PCefStringUserFree; stdcall;
    get_value: function(self: PCefDomNode): PCefStringUserFree; stdcall;
    set_value: function(self: PCefDomNode; const value: PCefString): Integer; stdcall;
    get_as_markup: function(self: PCefDomNode): PCefStringUserFree; stdcall;
    get_document: function(self: PCefDomNode): PCefDomDocument; stdcall;
    get_parent: function(self: PCefDomNode): PCefDomNode; stdcall;
    get_previous_sibling: function(self: PCefDomNode): PCefDomNode; stdcall;
    get_next_sibling: function(self: PCefDomNode): PCefDomNode; stdcall;
    has_children: function(self: PCefDomNode): Integer; stdcall;
    get_first_child: function(self: PCefDomNode): PCefDomNode; stdcall;
    get_last_child: function(self: PCefDomNode): PCefDomNode; stdcall;
    add_event_listener: procedure(self: PCefDomNode; const eventType: PCefString;
      listener: PCefDomEventListener; useCapture: Integer); stdcall;
    get_element_tag_name: function(self: PCefDomNode): PCefStringUserFree; stdcall;
    has_element_attributes: function(self: PCefDomNode): Integer; stdcall;
    has_element_attribute: function(self: PCefDomNode; const attrName: PCefString): Integer; stdcall;
    get_element_attribute: function(self: PCefDomNode; const attrName: PCefString): PCefStringUserFree; stdcall;
    get_element_attributes: procedure(self: PCefDomNode; attrMap: TCefStringMap); stdcall;
    set_element_attribute: function(self: PCefDomNode; const attrName, value: PCefString): Integer; stdcall;
    get_element_inner_text: function(self: PCefDomNode): PCefStringUserFree; stdcall;
  end;

  TCefDomEvent = record
    base: TCefBase;
    get_type: function(self: PCefDomEvent): PCefStringUserFree; stdcall;
    get_category: function(self: PCefDomEvent): TCefDomEventCategory; stdcall;
    get_phase: function(self: PCefDomEvent): TCefDomEventPhase; stdcall;
    can_bubble: function(self: PCefDomEvent): Integer; stdcall;
    can_cancel: function(self: PCefDomEvent): Integer; stdcall;
    get_document: function(self: PCefDomEvent): PCefDomDocument; stdcall;
    get_target: function(self: PCefDomEvent): PCefDomNode; stdcall;
    get_current_target: function(self: PCefDomEvent): PCefDomNode; stdcall;
  end;

  TCefDomEventListener = record
    base: TCefBase;
    handle_event: procedure(self: PCefDomEventListener; event: PCefDomEvent); stdcall;
  end;

  TCefCookieVisitor = record
    base: TCefBase;
    visit: function(self: PCefCookieVisitor; const cookie: PCefCookie;
      count, total: Integer; deleteCookie: PInteger): Integer; stdcall;
  end;

  TCefContentFilter = record
    base: TCefBase;
    process_data: procedure(self: PCefContentFilter;
        const data: Pointer; data_size: Integer;
        var substitute_data: PCefStreamReader); stdcall;
    drain: procedure(self: PCefContentFilter;
      var remainder: PCefStreamReader); stdcall;
  end;

  TCefDragData = record
    base: TCefBase;
    is_link: function(self: PCefDragData): Integer; stdcall;
    is_fragment: function(self: PCefDragData): Integer; stdcall;
    is_file: function(self: PCefDragData): Integer; stdcall;
    get_link_url: function(self: PCefDragData): PCefStringUserFree; stdcall;
    get_link_title: function(self: PCefDragData): PCefStringUserFree; stdcall;
    get_link_metadata: function(self: PCefDragData): PCefStringUserFree; stdcall;
    get_fragment_text: function(self: PCefDragData): PCefStringUserFree; stdcall;
    get_fragment_html: function(self: PCefDragData): PCefStringUserFree; stdcall;
    get_fragment_base_url: function(self: PCefDragData): PCefStringUserFree; stdcall;
    get_file_name: function(self: PCefDragData): PCefStringUserFree; stdcall;
    get_file_names: function(self: PCefDragData; names: TCefStringList): Integer; stdcall;
  end;

  TCefCookieManager = record
    base: TCefBase;
    set_supported_schemes: procedure(self: PCefCookieManager; schemes: TCefStringList); stdcall;
    visit_all_cookies: function(self: PCefCookieManager; visitor: PCefCookieVisitor): Integer; stdcall;
    visit_url_cookies: function(self: PCefCookieManager; const url: PCefString;
      includeHttpOnly: Integer; visitor: PCefCookieVisitor): Integer; stdcall;
    set_cookie: function(self: PCefCookieManager; const url: PCefString;
      const cookie: PCefCookie): Integer; stdcall;
    delete_cookies: function(self: PCefCookieManager;
        const url, cookie_name: PCefString): Integer; stdcall;
    set_storage_path: function(self: PCefCookieManager;
      const path: PCefString): Integer; stdcall;
  end;

  TCefWebPluginInfo = record
    base: TCefBase;
    get_name: function(self: PCefWebPluginInfo): PCefStringUserFree; stdcall;
    get_path: function(self: PCefWebPluginInfo): PCefStringUserFree; stdcall;
    get_version: function(self: PCefWebPluginInfo): PCefStringUserFree; stdcall;
    get_description: function(self: PCefWebPluginInfo): PCefStringUserFree; stdcall;
  end;

  TCefSchemeRegistrar = record
    base: TCefBase;
    add_custom_scheme: function(self: PCefSchemeRegistrar;
        const scheme_name: PCefString; is_standard, is_local,
        is_display_isolated: Integer): Integer; stdcall;
  end;

implementation

end.
