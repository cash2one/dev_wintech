
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_renderhandler;
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

  procedure InitCefRenderHandler(ACefRenderHandler: PCefIntfRenderHandler; ACefClientObject: PCefClientObject);

implementation

uses
  BaseApp, cef_app, cef_apilib;
  
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

end.
