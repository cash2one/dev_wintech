program chromiumTest;

uses
  Windows,
  cef_apilib in '..\..\..\v0000\ex_chromium\cef_apilib.pas',
  cef_api in '..\..\..\v0000\ex_chromium\cef_api.pas',
  cef_type in '..\..\..\v0000\ex_chromium\cef_type.pas',
  cef_app in '..\..\..\v0000\ex_chromium\cef_app.pas',
  BaseApp in '..\..\..\v0000\win_base\BaseApp.pas',
  BasePath in '..\..\..\v0000\win_base\BasePath.pas',
  BaseThread in '..\..\..\v0000\win_base\BaseThread.pas',
  BaseWinApp in '..\..\..\v0000\win_base\BaseWinApp.pas',
  UIBaseWin in '..\..\..\v0000\win_base\UIBaseWin.pas',
  BaseWinThread in '..\..\..\v0000\win_base\BaseWinThread.pas',
  BaseRun in '..\..\..\v0000\win_base\BaseRun.pas',
  HostWnd_chromium in 'HostWnd_chromium.pas',
  UIBaseWndProc in '..\..\..\v0000\win_base\UIBaseWndProc.pas';

{$R *.res}

type
  TChromiumTestApp = class(TBaseWinApp)
  protected      
    fCefClientObject: TCefClientObject;
    fHostWindow: THostWndChromium; 
    procedure CreateBrowser;
    procedure CreateHostWindow;
  public
    procedure Run; override;    
  end;
  
{ TChromiumTestApp }

procedure TChromiumTestApp.CreateBrowser;
begin
  if CefApp.CefLibrary.LibHandle = 0 then
  begin
    CefApp.CefLibrary.CefCoreSettings.multi_threaded_message_loop := False;
    CefApp.CefLibrary.CefCoreSettings.multi_threaded_message_loop := True;
    InitCefLib(@CefApp.CefLibrary, @CefApp.CefAppObject);
    if CefApp.CefLibrary.LibHandle <> 0 then
    begin
      fCefClientObject.HostWindow := fHostWindow.BaseWnd.UIWndHandle;
      fCefClientObject.CefIsCreateWindow := true;
      fCefClientObject.Rect.Left := 0;
      fCefClientObject.Rect.Top := 0; 
      fCefClientObject.Width := fHostWindow.BaseWnd.ClientRect.Right; //Self.Width - pnlRight.Width - 4 * 2;
      fCefClientObject.Height := fHostWindow.BaseWnd.ClientRect.Bottom; //Self.Height - pnlTop.Height - 4 * 2;
      fCefClientObject.CefUrl := 'http://www.baidu.com/';
      fCefClientObject.CefUrl := 'http://www.163.com/';      
      fCefClientObject.Rect.Right := fCefClientObject.Rect.Left + fCefClientObject.Width;
      fCefClientObject.Rect.Bottom := fCefClientObject.Rect.Top + fCefClientObject.Height;
      CreateBrowserCore(@fCefClientObject, @CefApp.CefLibrary, fHostWindow.BaseWnd.UIWndHandle);//Self.WindowHandle);
    end;
  end;
end;

procedure TChromiumTestApp.CreateHostWindow;
begin                                          
  fHostWindow.BaseWnd.WindowRect.Top := 30;
  fHostWindow.BaseWnd.WindowRect.Left := 50;

  fHostWindow.BaseWnd.ClientRect.Right := 800;
  fHostWindow.BaseWnd.ClientRect.Bottom := 600;
  fHostWindow.BaseWnd.Style := WS_POPUP;
  fHostWindow.BaseWnd.ExStyle := WS_EX_TOPMOST;  
  CreateHostWndChromium(@fHostWindow);
end;

procedure TChromiumTestApp.Run;
begin
  inherited;      
  FillChar(fCefClientObject, SizeOf(fCefClientObject), 0);
  FillChar(fHostWindow, SizeOf(fHostWindow), 0);

  CreateHostWindow;
  if IsWindow(fHostWindow.BaseWnd.UIWndHandle) then
  begin
    ShowWindow(fHostWindow.BaseWnd.UIWndHandle, SW_SHOW);
    CreateBrowser;
    RunAppMsgLoop;
  end;
end;

var
  GlobalApp: TChromiumTestApp;
begin
  RunApp(TChromiumTestApp, '', TBaseApp(GlobalApp));
end.
