unit cef_utils;

interface

uses
  Windows,
  BaseApp,
  BaseThread,
  cef_apiobj,
  cef_api,
  Cef_type;

  function CreateBrowserCore(
      ACefClient: PCefClientObject;
      ACefLibrary: PCefLibrary;
      AParentWnd: HWND): cef_api.PCefBrowser;

implementation

uses
  cef_apilib,
  cef_apilib_lifespan,
  cef_apilib_loadhandler,
  cef_apilib_displayhandler,
  cef_apilib_focushandler,
  cef_apilib_findhandler,
  cef_apilib_menuhandler,
  cef_apilib_printhandler,
  cef_apilib_renderhandler,
  cef_apilib_jsv8,
  cef_apilib_keyboardhandler,
  cef_apilib_geolocationhandler,
  cef_apilib_draghandler,
  cef_apilib_zoomhandler,
  cef_apilib_permissionhandler,
  cef_apilib_requesthandler;
  
function CreateBrowserCore(
    ACefClient: PCefClientObject;
    ACefLibrary: PCefLibrary;
    AParentWnd: HWND): PCefBrowser;
var
  tmpWinInfo: Cef_type.TCefWindowInfo;
  //**handl: ICefBase = nil;
  tmpBrowserSettings: TCefBrowserSettings;
  u: TCefString;
  tmpRet: integer;
begin
  Result := nil;
  if ACefLibrary.LibHandle = 0 then
    exit;
  InitCefClient(@ACefClient.CefClientIntf, ACefClient);
  InitCefLoadHandler(@ACefClient.CefClientIntf_LoadHandler, ACefClient);
  InitCefLifeSpan(@ACefClient.CefClientIntf_LifeSpan, ACefClient);
  InitCefRequestHandler(@ACefClient.CefClientIntf_RequestHandler, ACefClient);
  InitCefDisplayHandler(@ACefClient.CefClientIntf_DisplayHandler, ACefClient);
  InitCefFocusHandler(@ACefClient.CefClientIntf_FocusHandler, ACefClient);
  InitCefKeyboardHandler(@ACefClient.CefClientIntf_KeyboardHandler, ACefClient);
  InitCefMenuHandler(@ACefClient.CefClientIntf_MenuHandler, ACefClient);
  InitCefPermissionHandler(@ACefClient.CefClientIntf_PermissionHandler, ACefClient);
  InitCefPrintHandler(@ACefClient.CefClientIntf_PrintHandler, ACefClient);
  InitCefFindHandler(@ACefClient.CefClientIntf_FindHandler, ACefClient);
  InitCefJsDialogHandler(@ACefClient.CefClientIntf_JsDialogHandler, ACefClient);
  InitCefV8contextHandler(@ACefClient.CefClientIntf_V8contextHandler, ACefClient);
  InitCefRenderHandler(@ACefClient.CefClientIntf_RenderHandler, ACefClient);
  InitCefDragHandler(@ACefClient.CefClientIntf_DragHandler, ACefClient);
  InitCefGeolocationHandler(@ACefClient.CefClientIntf_GeolocationHandler, ACefClient);
  InitCefZoomHandler(@ACefClient.CefClientIntf_ZoomHandler, ACefClient);

  FillChar(tmpBrowserSettings, sizeof(tmpBrowserSettings), 0);
  tmpBrowserSettings.size := sizeof(tmpBrowserSettings);
  tmpBrowserSettings.standard_font_family := CefString('');//FFontOptions.StandardFontFamily);
  tmpBrowserSettings.fixed_font_family := CefString('');//FFontOptions.FixedFontFamily);
  tmpBrowserSettings.serif_font_family := CefString('');//FFontOptions.SerifFontFamily);
  tmpBrowserSettings.sans_serif_font_family := CefString('');//FFontOptions.SansSerifFontFamily);
  tmpBrowserSettings.cursive_font_family := CefString('');//FFontOptions.CursiveFontFamily);
  tmpBrowserSettings.fantasy_font_family := CefString('');//FFontOptions.FantasyFontFamily);
  tmpBrowserSettings.default_font_size := 10; //FFontOptions.DefaultFontSize;
  tmpBrowserSettings.default_fixed_font_size := 10;//FFontOptions.DefaultFixedFontSize;
  tmpBrowserSettings.minimum_font_size := 10;//FFontOptions.MinimumFontSize;
  tmpBrowserSettings.minimum_logical_font_size := 10;//FFontOptions.MinimumLogicalFontSize;
  tmpBrowserSettings.remote_fonts_disabled := false; //FFontOptions.RemoteFontsDisabled;
  tmpBrowserSettings.default_encoding := CefString('');//DefaultEncoding);
  tmpBrowserSettings.user_style_sheet_location := CefString('');//UserStyleSheetLocation);

  tmpBrowserSettings.drag_drop_disabled := false; //FOptions.DragDropDisabled;
  tmpBrowserSettings.load_drops_disabled := false; //FOptions.LoadDropsDisabled;
  tmpBrowserSettings.history_disabled := false; //FOptions.HistoryDisabled;
  tmpBrowserSettings.animation_frame_rate := 0;//FOptions.AnimationFrameRate;
  tmpBrowserSettings.encoding_detector_enabled := false; //FOptions.EncodingDetectorEnabled;
  tmpBrowserSettings.javascript_disabled := false; //FOptions.JavascriptDisabled;
  tmpBrowserSettings.javascript_open_windows_disallowed := false; //FOptions.JavascriptOpenWindowsDisallowed;
  tmpBrowserSettings.javascript_close_windows_disallowed := false; //FOptions.JavascriptCloseWindowsDisallowed;
  tmpBrowserSettings.javascript_access_clipboard_disallowed := false; //FOptions.JavascriptAccessClipboardDisallowed;
  tmpBrowserSettings.dom_paste_disabled := false; //FOptions.DomPasteDisabled;
  tmpBrowserSettings.caret_browsing_enabled := false; //FOptions.CaretBrowsingEnabled;
  tmpBrowserSettings.java_disabled := false; //FOptions.JavaDisabled;
  tmpBrowserSettings.plugins_disabled := false; //FOptions.PluginsDisabled;
  tmpBrowserSettings.universal_access_from_file_urls_allowed := false; //FOptions.UniversalAccessFromFileUrlsAllowed;
  tmpBrowserSettings.file_access_from_file_urls_allowed := false; //FOptions.FileAccessFromFileUrlsAllowed;
  tmpBrowserSettings.web_security_disabled := false; //FOptions.WebSecurityDisabled;
  tmpBrowserSettings.xss_auditor_enabled := false; //FOptions.XssAuditorEnabled;
  tmpBrowserSettings.image_load_disabled := false; //FOptions.ImageLoadDisabled;
  tmpBrowserSettings.shrink_standalone_images_to_fit := false; //FOptions.ShrinkStandaloneImagesToFit;
  tmpBrowserSettings.site_specific_quirks_disabled := false; //FOptions.SiteSpecificQuirksDisabled;
  tmpBrowserSettings.text_area_resize_disabled := false; //FOptions.TextAreaResizeDisabled;
  tmpBrowserSettings.page_cache_disabled := false; //FOptions.PageCacheDisabled;
  tmpBrowserSettings.tab_to_links_disabled := false; //FOptions.TabToLinksDisabled;
  tmpBrowserSettings.hyperlink_auditing_disabled := false; //FOptions.HyperlinkAuditingDisabled;
  tmpBrowserSettings.user_style_sheet_enabled := false; //FOptions.UserStyleSheetEnabled;
  tmpBrowserSettings.author_and_user_styles_disabled := false; //FOptions.AuthorAndUserStylesDisabled;
  tmpBrowserSettings.local_storage_disabled := false; //FOptions.LocalStorageDisabled;
  tmpBrowserSettings.databases_disabled := false; //FOptions.DatabasesDisabled;
  tmpBrowserSettings.application_cache_disabled := false; //FOptions.ApplicationCacheDisabled;
  tmpBrowserSettings.webgl_disabled := false; //FOptions.WebglDisabled;
  tmpBrowserSettings.accelerated_compositing_enabled := false; //FOptions.AcceleratedCompositingEnabled;
  tmpBrowserSettings.accelerated_layers_disabled := false; //FOptions.AcceleratedLayersDisabled;
  tmpBrowserSettings.accelerated_2d_canvas_disabled := false; //FOptions.Accelerated2dCanvasDisabled;
  tmpBrowserSettings.developer_tools_disabled := false; //FOptions.DeveloperToolsDisabled;
  tmpBrowserSettings.fullscreen_enabled := false; //FOptions.FullscreenEnabled;
  tmpBrowserSettings.accelerated_painting_disabled := false; //FOptions.AcceleratedPaintingDisabled;
  tmpBrowserSettings.accelerated_filters_disabled := false; //FOptions.AcceleratedFiltersDisabled;
  tmpBrowserSettings.accelerated_plugins_disabled := false; //FOptions.AcceleratedPluginsDisabled;

  FillChar(tmpWinInfo, SizeOf(tmpWinInfo), 0);
  tmpWinInfo.x := ACefClient.Rect.Left;
  tmpWinInfo.y := ACefClient.Rect.Top;
  tmpWinInfo.Width := ACefClient.Width;
  tmpWinInfo.Height := ACefClient.Height;
  tmpWinInfo.WndParent := AParentWnd;
  tmpWinInfo.m_bWindowRenderingDisabled := not ACefClient.CefIsCreateWindow;
  tmpWinInfo.Style := WS_VISIBLE or WS_CLIPCHILDREN or WS_CLIPSIBLINGS or WS_TABSTOP;
  tmpWinInfo.Style := WS_CHILD or WS_VISIBLE or WS_CLIPCHILDREN or WS_CLIPSIBLINGS or WS_TABSTOP;
//  tmpWinInfo.Style := WS_VISIBLE
//      or WS_CLIPCHILDREN
//      or WS_CLIPSIBLINGS
//      or WS_CAPTION
//      or WS_SYSMENU
//      or WS_MINIMIZEBOX
//      or WS_MAXIMIZEBOX
//      or WS_THICKFRAME;
  tmpWinInfo.ExStyle := WS_EX_TOOLWindow;
  tmpWinInfo.ExStyle := 0;
     //WS_EX_TOPMOST or
//  tmpWinInfo.ExStyle := WS_EX_WINDOWEDGE or
//     WS_EX_CLIENTEDGE or
//     //WS_EX_ControlParent or
//     WS_EX_AppWindow;
  //CefLifeSpan

  u := CefString(ACefClient.CefUrl);
  if not ACefLibrary.CefCoreSettings.multi_threaded_message_loop then
  begin
    //cef_do_message_loop_work;
    Result := ACefLibrary.cef_browser_create_Sync(
        @tmpWinInfo,
        @ACefClient.CefClientIntf.CefClient,
        @u,
        @tmpBrowserSettings);
    if Result <> nil then
    begin
      // 如果要接管 绘制 则需要 set_size
      if tmpWinInfo.m_bWindowRenderingDisabled then
      begin
        Result.set_size(Result, PET_VIEW, tmpWinInfo.Width, tmpWinInfo.Height);
        Result.send_focus_event(Result, 1);
      end;
    end;
  end else
  begin
    Result := nil;
    tmpRet := ACefLibrary.cef_browser_create(
      @tmpWinInfo,
      @ACefClient.CefClientIntf.CefClient,
      @u,
      @tmpBrowserSettings);
    if tmpRet <> 0 then
    begin
      (*//
      tmpRet := 0;
      while ACefClient.CefBrowser = nil do
      begin
        Sleep(10);
        Inc(tmpRet);
        if tmpRet > 300 then
          Break;
      end;
      //*)
    end;
    if ACefClient.CefBrowser <> nil then
    begin
      Result := ACefClient.CefBrowser;
      if tmpWinInfo.m_bWindowRenderingDisabled then
      begin
        // 异步窗体不绘制 消息分分钟 AV ???
        // 这里异步的消息传递 可能需要怎么处理一下
        Result.set_size(Result, PET_VIEW, tmpWinInfo.Width, tmpWinInfo.Height);
        Result.send_focus_event(Result, 1);
      end else
      begin
        Result.set_size(Result, PET_VIEW, tmpWinInfo.Width, tmpWinInfo.Height);
        Result.send_focus_event(Result, 1);
      end;
    end;
  end;
end;

end.
