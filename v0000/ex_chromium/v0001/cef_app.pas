unit cef_app;

interface

uses
  Windows,
  BaseApp,
  BaseThread,
  cef_apiobj;

type
  TCefApp = record
    CefLibrary: TCefLibrary;
    CefAppObject: TCefAppObject;
    AppMainThread: TSysThread;
  end;

var
  CefApp: TCefApp;
  
  procedure Cef_AppInitialize;

implementation

procedure Cef_AppInitialize;
begin
  FillChar(CefApp, SizeOf(CefApp), 0);
end;

initialization
  Cef_AppInitialize;

end.
