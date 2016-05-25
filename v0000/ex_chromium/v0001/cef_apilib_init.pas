
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_init;
{$ALIGN ON}
{$MINENUMSIZE 4}
{$I cef.inc}

interface

uses
  cef_type, cef_apiobj;
                  
  procedure CefLoadLibDefault(ACefLibrary: PCefLibrary; ACefAppObject: PCefAppObject);

implementation

uses
  Windows, Sysutils, cef_app, cef_apilib;
                     
function cef_string_utf16_copy(const src: PChar16; src_len: Cardinal; output: PCefStringUtf16): Integer; cdecl;
begin
  Result := CefApp.CefLibrary.cef_string_utf16_set(src, src_len, output, ord(True))
end;

procedure CefLoadLib(ACefLibrary: PCefLibrary; ACefLibraryFileName: string);
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
  //s: string;
  //tmpCefString: TCefString;
//  tmpPaths: TStringList;
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
    (*//
    s := ExtractFilePath(ParamStr(0)) + 'plugins\';
    if (s <> '') then
    begin
      if DirectoryExists(s) then
      begin
        tmpCefString := cefString(s);
        ACefLibrary.cef_string_list_append(ACefLibrary.CefCoreSettings.extra_plugin_paths, @tmpCefString);
      end;
    end;
    s := ExtractFilePath(ParamStr(0)) + 'plugins\PepperFlash\';
    if (s <> '') then
    begin
      if DirectoryExists(s) then
      begin
        tmpCefString := cefString(s);
        ACefLibrary.cef_string_list_append(ACefLibrary.CefCoreSettings.extra_plugin_paths, @tmpCefString);
      end;
    end;
    //*)
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

end.
