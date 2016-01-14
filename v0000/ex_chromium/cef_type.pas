
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_type;
{$ALIGN ON}
{$MINENUMSIZE 4}
{$I cef.inc}

interface

uses
  Windows;

type
{$IFDEF UNICODE}
  ustring = type string;
  rbstring = type RawByteString;
{$ELSE}
  {$IFDEF FPC}
    {$if declared(unicodestring)}
      ustring = type unicodestring;
    {$else}
      ustring = type WideString;
    {$ifend}
  {$ELSE}
    ustring = type WideString;
  {$ENDIF}
  rbstring = type AnsiString;
{$ENDIF}

{$if not defined(uint64)}
  uint64 = int64;
{$ifend}

  TCefWindowHandle = {$IFDEF MACOS}Pointer{$ELSE}HWND{$ENDIF};
  TCefCursorHandle = {$IFDEF MACOS}Pointer{$ELSE}HCURSOR{$ENDIF};

  Char16 = WideChar;
  PChar16 = PWideChar;

  PCefStringWide = ^TCefStringWide;
  TCefStringWide = record
    str: PWideChar;
    length: Cardinal;
    dtor: procedure(str: PWideChar); stdcall;
  end;

  PCefStringUtf8 = ^TCefStringUtf8;
  TCefStringUtf8 = record
    str: PAnsiChar;
    length: Cardinal;
    dtor: procedure(str: PAnsiChar); stdcall;
  end;

  PCefStringUtf16 = ^TCefStringUtf16;
  TCefStringUtf16 = record
    str: PChar16;
    length: Cardinal;
    dtor: procedure(str: PChar16); stdcall;
  end;

  PCefStringUserFreeWide = ^TCefStringUserFreeWide;
  TCefStringUserFreeWide = type TCefStringWide;

  PCefStringUserFreeUtf8 = ^TCefStringUserFreeUtf8;
  TCefStringUserFreeUtf8 = type TCefStringUtf8;

  PCefStringUserFreeUtf16 = ^TCefStringUserFreeUtf16;
  TCefStringUserFreeUtf16 = type TCefStringUtf16;

{$IFDEF CEF_STRING_TYPE_UTF8}
  TCefChar = AnsiChar;
  PCefChar = PAnsiChar;
  TCefStringUserFree = TCefStringUserFreeUtf8;
  PCefStringUserFree = PCefStringUserFreeUtf8;
  TCefString = TCefStringUtf8;
  PCefString = PCefStringUtf8;
{$ENDIF}

{$IFDEF CEF_STRING_TYPE_UTF16}
  TCefChar = Char16;
  PCefChar = PChar16;
  TCefStringUserFree = TCefStringUserFreeUtf16;
  PCefStringUserFree = PCefStringUserFreeUtf16;
  TCefString = TCefStringUtf16;
  PCefString = PCefStringUtf16;
{$ENDIF}

{$IFDEF CEF_STRING_TYPE_WIDE}
  TCefChar = WideChar;
  PCefChar = PWideChar;
  TCefStringUserFree = TCefStringUserFreeWide;
  PCefStringUserFree = PCefStringUserFreeWide;
  TCefString = TCefStringWide;
  PCefString = PCefStringWide;
{$ENDIF}

  TCefStringMap = Pointer;
  TCefStringMultimap = Pointer;
  TCefStringList = Pointer;

  TCefGraphicsImplementation = (
{$IFDEF MSWINDOWS}
    ANGLE_IN_PROCESS,
    ANGLE_IN_PROCESS_COMMAND_BUFFER,
{$ENDIF}
    DESKTOP_IN_PROCESS,
    DESKTOP_IN_PROCESS_COMMAND_BUFFER
  );

  PCefWindowInfo = ^TCefWindowInfo;
{$IFDEF MACOS}
  TCefWindowInfo = record
    m_windowName: TCefString;
    m_x: Integer;
    m_y: Integer;
    m_nWidth: Integer;
    m_nHeight: Integer;
    m_bHidden: Integer;

    m_ParentView: TCefWindowHandle;
    m_View: TCefWindowHandle;
  end;
{$ENDIF}

{$IFDEF MSWINDOWS}
  TCefWindowInfo = record
    ExStyle: DWORD;
    windowName: TCefString;
    Style: DWORD;
    x: Integer;
    y: Integer;
    Width: Integer;
    Height: Integer;
    WndParent: HWND;
    Menu: HMENU;
    m_bWindowRenderingDisabled: BOOL;
    m_bTransparentPainting: BOOL;
    Wnd: HWND ;
  end;
{$ENDIF}

  TCefPrintInfo = record
{$IFDEF MSWINDOWS}
    DC: HDC;
    Rect: TRect;
{$ENDIF}
    Scale: double;
  end;

  PCefKeyInfo = ^TCefKeyInfo;
  TCefKeyInfo = record
    key: Integer;
    sysChar: BOOL;
    imeChar: BOOL;
  end;

  // Log severity levels.
  TCefLogSeverity = (
    LOGSEVERITY_VERBOSE = -1,
    LOGSEVERITY_INFO,
    LOGSEVERITY_WARNING,
    LOGSEVERITY_ERROR,
    LOGSEVERITY_ERROR_REPORT,
    // Disables logging completely.
    LOGSEVERITY_DISABLE = 99
  );

  // Initialization settings. Specify NULL or 0 to get the recommended default
  // values.
  PCefSettings = ^TCefSettings;
  TCefSettings = record
    size: Cardinal;
    multi_threaded_message_loop: Boolean;
    cache_path: TCefString;
    user_agent: TCefString;
    product_version: TCefString;
    locale: TCefString;
    extra_plugin_paths: TCefStringList;
    log_file: TCefString;
    log_severity: TCefLogSeverity;
    release_dcheck_enabled: Boolean;
    graphics_implementation: TCefGraphicsImplementation;
    local_storage_quota: Cardinal;
    session_storage_quota: Cardinal;
    javascript_flags: TCefString;
{$IFDEF MSWINDOWS}
    auto_detect_proxy_settings_enabled: Boolean;
{$ENDIF}
    resources_dir_path: TCefString;
    locales_dir_path: TCefString;
    pack_loading_disabled: Boolean;
    uncaught_exception_stack_size: Integer;
    context_safety_implementation: Integer;
  end;

  PCefBrowserSettings = ^TCefBrowserSettings;
  TCefBrowserSettings = record
    size: Cardinal;
    drag_drop_disabled: Boolean;
    load_drops_disabled: Boolean;

    history_disabled: Boolean;

    animation_frame_rate: Integer;

    standard_font_family: TCefString;
    fixed_font_family: TCefString;
    serif_font_family: TCefString;
    sans_serif_font_family: TCefString;
    cursive_font_family: TCefString;
    fantasy_font_family: TCefString;
    default_font_size: Integer;
    default_fixed_font_size: Integer;
    minimum_font_size: Integer;
    minimum_logical_font_size: Integer;
    remote_fonts_disabled: Boolean;
    default_encoding: TCefString;
    encoding_detector_enabled: Boolean;
    javascript_disabled: Boolean;
    javascript_open_windows_disallowed: Boolean;
    javascript_close_windows_disallowed: Boolean;
    javascript_access_clipboard_disallowed: Boolean;
    dom_paste_disabled: Boolean;
    caret_browsing_enabled: Boolean;
    java_disabled: Boolean;
    plugins_disabled: Boolean;
    universal_access_from_file_urls_allowed: Boolean;
    file_access_from_file_urls_allowed: Boolean;
    web_security_disabled: Boolean;
    xss_auditor_enabled: Boolean;
    image_load_disabled: Boolean;
    shrink_standalone_images_to_fit: Boolean;
    site_specific_quirks_disabled: Boolean;
    text_area_resize_disabled: Boolean;
    page_cache_disabled: Boolean;
    tab_to_links_disabled: Boolean;
    hyperlink_auditing_disabled: Boolean;
    user_style_sheet_enabled: Boolean;
    user_style_sheet_location: TCefString;
    author_and_user_styles_disabled: Boolean;
    local_storage_disabled: Boolean;
    databases_disabled: Boolean;
    application_cache_disabled: Boolean;
    webgl_disabled: Boolean;
    accelerated_compositing_enabled: Boolean;
    accelerated_layers_disabled: Boolean;
    accelerated_2d_canvas_disabled: Boolean;
    accelerated_painting_disabled: Boolean;
    accelerated_filters_disabled: Boolean;
    accelerated_plugins_disabled: Boolean;
    developer_tools_disabled: Boolean;
    fullscreen_enabled: Boolean;
  end;

  PCefUrlParts = ^TCefUrlParts;
  TCefUrlParts = record
    spec: TCefString;
    scheme: TCefString;
    username: TCefString;
    password: TCefString;
    host: TCefString;
    port: TCefString;
    path: TCefString;
    query: TCefString;
  end;

  PCefTime = ^TCefTime;
  TCefTime = record
    year: Integer;          // Four digit year "2007"
    month: Integer;         // 1-based month (values 1 = January, etc.)
    day_of_week: Integer;   // 0-based day of week (0 = Sunday, etc.)
    day_of_month: Integer;  // 1-based day of month (1-31)
    hour: Integer;          // Hour within the current day (0-23)
    minute: Integer;        // Minute within the current hour (0-59)
    second: Integer;        // Second within the current minute (0-59 plus leap
                            //   seconds which may take it up to 60).
    millisecond: Integer;   // Milliseconds within the current second (0-999)
  end;

  TCefCookie = record
    name: TCefString;
    value: TCefString;
    domain: TCefString;
    path: TCefString;
    secure: Boolean;
    httponly: Boolean;
    creation: TCefTime;
    last_access: TCefTime;
    has_expires: Boolean;
    expires: TCefTime;
  end;

  TCefStorageType = (
    ST_LOCALSTORAGE = 0,
    ST_SESSIONSTORAGE
  );

  TCefMouseButtonType = (
    MBT_LEFT   = 0,
    MBT_MIDDLE,
    MBT_RIGHT
  );

  TCefKeyType = (
    KT_KEYUP    = 0,
    KT_KEYDOWN,
    KT_CHAR
  );

  TCefHandlerNavtype = (
    NAVTYPE_LINKCLICKED = 0,
    NAVTYPE_FORMSUBMITTED,
    NAVTYPE_BACKFORWARD,
    NAVTYPE_RELOAD,
    NAVTYPE_FORMRESUBMITTED,
    NAVTYPE_OTHER,
    NAVTYPE_LINKDROPPED
  );

  TCefHandlerErrorcode = Integer;

const
  ERR_FAILED = -2;
  ERR_ABORTED = -3;
  ERR_INVALID_ARGUMENT = -4;
  ERR_INVALID_HANDLE = -5;
  ERR_FILE_NOT_FOUND = -6;
  ERR_TIMED_OUT = -7;
  ERR_FILE_TOO_BIG = -8;
  ERR_UNEXPECTED = -9;
  ERR_ACCESS_DENIED = -10;
  ERR_NOT_IMPLEMENTED = -11;
  ERR_CONNECTION_CLOSED = -100;
  ERR_CONNECTION_RESET = -101;
  ERR_CONNECTION_REFUSED = -102;
  ERR_CONNECTION_ABORTED = -103;
  ERR_CONNECTION_FAILED = -104;
  ERR_NAME_NOT_RESOLVED = -105;
  ERR_INTERNET_DISCONNECTED = -106;
  ERR_SSL_PROTOCOL_ERROR = -107;
  ERR_ADDRESS_INVALID = -108;
  ERR_ADDRESS_UNREACHABLE = -109;
  ERR_SSL_CLIENT_AUTH_CERT_NEEDED = -110;
  ERR_TUNNEL_CONNECTION_FAILED = -111;
  ERR_NO_SSL_VERSIONS_ENABLED = -112;
  ERR_SSL_VERSION_OR_CIPHER_MISMATCH = -113;
  ERR_SSL_RENEGOTIATION_REQUESTED = -114;
  ERR_CERT_COMMON_NAME_INVALID = -200;
  ERR_CERT_DATE_INVALID = -201;
  ERR_CERT_AUTHORITY_INVALID = -202;
  ERR_CERT_CONTAINS_ERRORS = -203;
  ERR_CERT_NO_REVOCATION_MECHANISM = -204;
  ERR_CERT_UNABLE_TO_CHECK_REVOCATION = -205;
  ERR_CERT_REVOKED = -206;
  ERR_CERT_INVALID = -207;
  ERR_CERT_END = -208;
  ERR_INVALID_URL = -300;
  ERR_DISALLOWED_URL_SCHEME = -301;
  ERR_UNKNOWN_URL_SCHEME = -302;
  ERR_TOO_MANY_REDIRECTS = -310;
  ERR_UNSAFE_REDIRECT = -311;
  ERR_UNSAFE_PORT = -312;
  ERR_INVALID_RESPONSE = -320;
  ERR_INVALID_CHUNKED_ENCODING = -321;
  ERR_METHOD_NOT_SUPPORTED = -322;
  ERR_UNEXPECTED_PROXY_AUTH = -323;
  ERR_EMPTY_RESPONSE = -324;
  ERR_RESPONSE_HEADERS_TOO_BIG = -325;
  ERR_CACHE_MISS = -400;
  ERR_INSECURE_RESPONSE = -501;

type
  TCefDragOperations = Integer;
const
  DRAG_OPERATION_NONE    = 0;
  DRAG_OPERATION_COPY    = 1;
  DRAG_OPERATION_LINK    = 2;
  DRAG_OPERATION_GENERIC = 4;
  DRAG_OPERATION_PRIVATE = 8;
  DRAG_OPERATION_MOVE    = 16;
  DRAG_OPERATION_DELETE  = 32;
  DRAG_OPERATION_EVERY   = $FFFFFFFF;

type
  TCefV8AccessControls = Integer;
const
  V8_ACCESS_CONTROL_DEFAULT               = 0;
  V8_ACCESS_CONTROL_ALL_CAN_READ          = 1;
  V8_ACCESS_CONTROL_ALL_CAN_WRITE         = 1 shl 1;
  V8_ACCESS_CONTROL_PROHIBITS_OVERWRITING = 1 shl 2;

type
  TCefV8PropertyAttributes = Integer;
const
  V8_PROPERTY_ATTRIBUTE_NONE       = 0;       // Writeable, Enumerable, Configurable
  V8_PROPERTY_ATTRIBUTE_READONLY   = 1 shl 0;  // Not writeable
  V8_PROPERTY_ATTRIBUTE_DONTENUM   = 1 shl 1;  // Not enumerable
  V8_PROPERTY_ATTRIBUTE_DONTDELETE = 1 shl 2;  // Not configurable

type
  // Structure representing menu information.
  TCefMenuInfo = record
    // Values from the cef_handler_menutypebits_t enumeration.
    typeFlags: Integer;
    x: Integer;
    y: Integer;

    linkUrl: TCefString;
    imageUrl: TCefString;
    pageUrl: TCefString;
    frameUrl: TCefString;
    selectionText: TCefString;
    misspelledWord: TCefString;

    // Values from the cef_handler_menucapabilitybits_t enumeration
    editFlags: Integer;
    securityInfo: TCefString;
  end;

  // The TCefMenuInfo typeFlags value will be a combination of the
  // following values.
  TCefMenuTypeBits =  Integer;

const
  MENUTYPE_NONE = $0;
  MENUTYPE_PAGE = $1;
  MENUTYPE_FRAME = $2;
  MENUTYPE_LINK = $4;
  MENUTYPE_IMAGE = $8;
  MENUTYPE_SELECTION = $10;
  MENUTYPE_EDITABLE = $20;
  MENUTYPE_MISSPELLED_WORD = $40;
  MENUTYPE_VIDEO = $80;
  MENUTYPE_AUDIO = $100;

type
  // The TCefMenuInfo editFlags value will be a combination of the
  // following values.
  TCefMenuCapabilityBits = Integer;
const
    // Values from WebContextMenuData::EditFlags in WebContextMenuData.h
    MENU_CAN_DO_NONE = $0;
    MENU_CAN_UNDO = $1;
    MENU_CAN_REDO = $2;
    MENU_CAN_CUT = $4;
    MENU_CAN_COPY = $8;
    MENU_CAN_PASTE = $10;
    MENU_CAN_DELETE = $20;
    MENU_CAN_SELECT_ALL = $40;
    MENU_CAN_TRANSLATE = $80;
    // Values unique to CEF
    MENU_CAN_GO_FORWARD = $10000000;
    MENU_CAN_GO_BACK = $20000000;

type
  // Supported menu ID values.
  TCefMenuId = (
    MENU_ID_NAV_BACK = 10,
    MENU_ID_NAV_FORWARD = 11,
    MENU_ID_NAV_RELOAD = 12,
    MENU_ID_NAV_RELOAD_NOCACHE = 13,
    MENU_ID_NAV_STOP = 14,
    MENU_ID_UNDO = 20,
    MENU_ID_REDO = 21,
    MENU_ID_CUT = 22,
    MENU_ID_COPY = 23,
    MENU_ID_PASTE = 24,
    MENU_ID_DELETE = 25,
    MENU_ID_SELECTALL = 26,
    MENU_ID_PRINT = 30,
    MENU_ID_VIEWSOURCE = 31
  );

  TCefPaintElementType = (
    PET_VIEW  = 0,
    PET_POPUP
  );

  // Post data elements may represent either bytes or files.
  TCefPostDataElementType = (
    PDE_TYPE_EMPTY  = 0,
    PDE_TYPE_BYTES,
    PDE_TYPE_FILE
  );


type
  TCefWebUrlRequestFlags = Integer;
const
    WUR_FLAG_NONE = 0;
    WUR_FLAG_SKIP_CACHE = $1;
    WUR_FLAG_ALLOW_CACHED_CREDENTIALS = $2;
    WUR_FLAG_ALLOW_COOKIES = $4;
    WUR_FLAG_REPORT_UPLOAD_PROGRESS = $8;
    WUR_FLAG_REPORT_LOAD_TIMING = $10;
    WUR_FLAG_REPORT_RAW_HEADERS = $20;

type
  TCefWebUrlRequestState = (
    WUR_STATE_UNSENT = 0,
    WUR_STATE_STARTED = 1,
    WUR_STATE_HEADERS_RECEIVED = 2,
    WUR_STATE_LOADING = 3,
    WUR_STATE_DONE = 4,
    WUR_STATE_ERROR = 5,
    WUR_STATE_ABORT = 6
  );

  // Focus sources.
  TCefHandlerFocusSource = (
    // The source is explicit navigation via the API (LoadURL(), etc).
    FOCUS_SOURCE_NAVIGATION = 0,
    // The source is a system-generated focus event.
    FOCUS_SOURCE_SYSTEM,
    // The source is a child widget of the browser window requesting focus.
    FOCUS_SOURCE_WIDGET
  );


  // Key event types.
  TCefHandlerKeyEventType = (
    KEYEVENT_RAWKEYDOWN = 0,
    KEYEVENT_KEYDOWN,
    KEYEVENT_KEYUP,
    KEYEVENT_CHAR
  );

  // Key event modifiers.
  TCefHandlerKeyEventModifiers = Integer;

const
  KEY_SHIFT  = 1 shl 0;
  KEY_CTRL   = 1 shl 1;
  KEY_ALT    = 1 shl 2;
  KEY_META   = 1 shl 3;
  KEY_KEYPAD = 1 shl 4; // Only used on Mac OS-X

type
  // Structure representing a rectangle.
  PCefRect = ^TCefRect;
  TCefRect = record
    x: Integer;
    y: Integer;
    width: Integer;
    height: Integer;
  end;

  TCefRectArray = array[0..(High(Integer) div SizeOf(TCefRect))-1] of TCefRect;
  PCefRectArray = ^TCefRectArray;

  // Existing thread IDs.
  TCefThreadId = (
    TID_UI      = 0,
    TID_IO      = 1,
    TID_FILE    = 2
  );

  // Paper type for printing.
  TCefPaperType = (
    PT_LETTER = 0,
    PT_LEGAL,
    PT_EXECUTIVE,
    PT_A3,
    PT_A4,
    PT_CUSTOM
  );

  // Paper metric information for printing.
  TCefPaperMetrics = record
    paper_type: TCefPaperType;
    //Length and width needed if paper_type is custom_size
    //Units are in inches.
    length: Double;
    width: Double;
  end;

  // Paper print margins.
  TCefPrintMargins = record
    //Margin size in inches for left/right/top/bottom (this is content margins).
    left: Double;
    right: Double;
    top: Double;
    bottom: Double;
    //Margin size (top/bottom) in inches for header/footer.
    header: Double;
    footer: Double;
  end;

  // Page orientation for printing
  TCefPageOrientation = (
    PORTRAIT = 0,
    LANDSCAPE
  );

  // Printing options.
  PCefPrintOptions = ^TCefPrintOptions;
  TCefPrintOptions = record
    page_orientation: TCefPageOrientation;
    paper_metrics: TCefPaperMetrics;
    paper_margins: TCefPrintMargins;
  end;

  TCefXmlEncodingType = (
    XML_ENCODING_NONE = 0,
    XML_ENCODING_UTF8,
    XML_ENCODING_UTF16LE,
    XML_ENCODING_UTF16BE,
    XML_ENCODING_ASCII
  );

  // XML node types.
  TCefXmlNodeType = (
    XML_NODE_UNSUPPORTED = 0,
    XML_NODE_PROCESSING_INSTRUCTION,
    XML_NODE_DOCUMENT_TYPE,
    XML_NODE_ELEMENT_START,
    XML_NODE_ELEMENT_END,
    XML_NODE_ATTRIBUTE,
    XML_NODE_TEXT,
    XML_NODE_CDATA,
    XML_NODE_ENTITY_REFERENCE,
    XML_NODE_WHITESPACE,
    XML_NODE_COMMENT
  );

  // Status message types.
  TCefHandlerStatusType = (
    STATUSTYPE_TEXT = 0,
    STATUSTYPE_MOUSEOVER_URL,
    STATUSTYPE_KEYBOARD_FOCUS_URL
  );

  // Popup window features.
  PCefPopupFeatures = ^TCefPopupFeatures;
  TCefPopupFeatures = record
    x: Integer;
    xSet: Boolean;
    y: Integer;
    ySet: Boolean;
    width: Integer;
    widthSet: Boolean;
    height: Integer;
    heightSet: Boolean;

    menuBarVisible: Boolean;
    statusBarVisible: Boolean;
    toolBarVisible: Boolean;
    locationBarVisible: Boolean;
    scrollbarsVisible: Boolean;
    resizable: Boolean;

    fullscreen: Boolean;
    dialog: Boolean;
    additionalFeatures: TCefStringList;
  end;

  // DOM document types.
  TCefDomDocumentType = (
    DOM_DOCUMENT_TYPE_UNKNOWN = 0,
    DOM_DOCUMENT_TYPE_HTML,
    DOM_DOCUMENT_TYPE_XHTML,
    DOM_DOCUMENT_TYPE_PLUGIN
  );

  // DOM event category flags.
  TCefDomEventCategory = Integer;
const
  DOM_EVENT_CATEGORY_UNKNOWN = $0;
  DOM_EVENT_CATEGORY_UI = $1;
  DOM_EVENT_CATEGORY_MOUSE = $2;
  DOM_EVENT_CATEGORY_MUTATION = $4;
  DOM_EVENT_CATEGORY_KEYBOARD = $8;
  DOM_EVENT_CATEGORY_TEXT = $10;
  DOM_EVENT_CATEGORY_COMPOSITION = $20;
  DOM_EVENT_CATEGORY_DRAG = $40;
  DOM_EVENT_CATEGORY_CLIPBOARD = $80;
  DOM_EVENT_CATEGORY_MESSAGE = $100;
  DOM_EVENT_CATEGORY_WHEEL = $200;
  DOM_EVENT_CATEGORY_BEFORE_TEXT_INSERTED = $400;
  DOM_EVENT_CATEGORY_OVERFLOW = $800;
  DOM_EVENT_CATEGORY_PAGE_TRANSITION = $1000;
  DOM_EVENT_CATEGORY_POPSTATE = $2000;
  DOM_EVENT_CATEGORY_PROGRESS = $4000;
  DOM_EVENT_CATEGORY_XMLHTTPREQUEST_PROGRESS = $8000;
  DOM_EVENT_CATEGORY_WEBKIT_ANIMATION = $10000;
  DOM_EVENT_CATEGORY_WEBKIT_TRANSITION = $20000;
  DOM_EVENT_CATEGORY_BEFORE_LOAD = $40000;

type
  // DOM event processing phases.
  TCefDomEventPhase = (
    DOM_EVENT_PHASE_UNKNOWN = 0,
    DOM_EVENT_PHASE_CAPTURING,
    DOM_EVENT_PHASE_AT_TARGET,
    DOM_EVENT_PHASE_BUBBLING
  );

  // DOM node types.
  TCefDomNodeType = (
    DOM_NODE_TYPE_UNSUPPORTED = 0,
    DOM_NODE_TYPE_ELEMENT,
    DOM_NODE_TYPE_ATTRIBUTE,
    DOM_NODE_TYPE_TEXT,
    DOM_NODE_TYPE_CDATA_SECTION,
    DOM_NODE_TYPE_ENTITY_REFERENCE,
    DOM_NODE_TYPE_ENTITY,
    DOM_NODE_TYPE_PROCESSING_INSTRUCTIONS,
    DOM_NODE_TYPE_COMMENT,
    DOM_NODE_TYPE_DOCUMENT,
    DOM_NODE_TYPE_DOCUMENT_TYPE,
    DOM_NODE_TYPE_DOCUMENT_FRAGMENT,
    DOM_NODE_TYPE_NOTATION,
    DOM_NODE_TYPE_XPATH_NAMESPACE
  );

  // Proxy types.
  TCefProxyType = (
    CEF_PROXY_TYPE_DIRECT = 0,
    CEF_PROXY_TYPE_NAMED,
    CEF_PROXY_TYPE_PAC_STRING
  );

  // Proxy information.
  TCefProxyInfo = record
    proxyType: TCefProxyType;
    proxyList: TCefString;
  end;

  // Geoposition error codes.
  TCefGeopositionErrorCode = (
    GEOPOSITON_ERROR_NONE = 0,
    GEOPOSITON_ERROR_PERMISSION_DENIED,
    GEOPOSITON_ERROR_POSITION_UNAVAILABLE,
    GEOPOSITON_ERROR_TIMEOUT
  );

  TCefGeoposition = record
    latitude: Double;
    longitude: Double;
    altitude: Double;
    accuracy: Double;
    altitude_accuracy: Double;
    heading: Double;
    speed: Double;
    timestamp: TCefTime;
    error_code: TCefGeopositionErrorCode;
    error_message: TCefString;
  end;

implementation

end.
