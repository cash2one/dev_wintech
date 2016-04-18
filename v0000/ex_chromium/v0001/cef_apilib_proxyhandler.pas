
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_proxyhandler;
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
                 
  procedure InitCefAppProxyHandler(ACefProxyHandler: PCefIntfProxyHandler);

implementation

uses
  cef_apilib;
  
procedure cef_proxy_handler_get_proxy_for_url(self: PCefProxyHandler;
  const url: PCefString; proxy_info: PCefProxyInfo); stdcall;
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

end.
