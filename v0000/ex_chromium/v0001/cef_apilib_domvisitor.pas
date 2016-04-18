
{$IFDEF FPC}
  {$MODE DELPHI}{$H+}
{$ENDIF}
unit cef_apilib_domvisitor;
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

type
  TDomVisitorVisitCallBackProc = procedure(self: PCefDomVisitor; document: PCefDomDocument); stdcall;

  procedure InitCefDomVisitor(ACefDomVisitor: PCefIntfDomVisitor; ACefClientObject: PCefClientObject; AVisitCallBackProc: TDomVisitorVisitCallBackProc); stdcall;

implementation

uses
  cef_apilib;
  
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

end.
