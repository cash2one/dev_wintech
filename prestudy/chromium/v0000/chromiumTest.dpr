program chromiumTest;

uses
  Windows,
  cef_apilib in '..\..\..\v0000\ex_chromium\cef_apilib.pas',
  cef_api in '..\..\..\v0000\ex_chromium\cef_api.pas',
  cef_type in '..\..\..\v0000\ex_chromium\cef_type.pas',
  cef_app in '..\..\..\v0000\ex_chromium\cef_app.pas',
  cef_utils in '..\..\..\v0000\ex_chromium\cef_utils.pas',
  BaseApp in '..\..\..\v0000\app_base\BaseApp.pas',
  BasePath in '..\..\..\v0000\app_base\BasePath.pas',
  BaseRun in '..\..\..\v0000\app_base\BaseRun.pas',
  BaseThread in '..\..\..\v0000\app_base\BaseThread.pas',
  BaseWinApp in '..\..\..\v0000\win_base\BaseWinApp.pas',
  UIBaseWin in '..\..\..\v0000\win_base\UIBaseWin.pas',
  BaseWinHook in '..\..\..\v0000\win_base\BaseWinHook.pas',
  UIBaseWndProc in '..\..\..\v0000\win_base\UIBaseWndProc.pas',
  win.thread in '..\..\..\v0000\win_system\win.thread.pas',
  HostWnd_chromium in 'HostWnd_chromium.pas',
  chromium_dom in 'chromium_dom.pas',
  chromium_script in 'chromium_script.pas';

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
//  tmpAnsi: AnsiString;
//  tmpOutputAnsi: AnsiString;
//  tmpDecodeAnsi: AnsiString;
//  tmpLength: integer;
begin
//  tmpLength := SizeOf(TByteX);
//  if 1 > tmpLength then
//    exit;

//  tmpANsi := 'good 123456';
//  //tmpOutputAnsi := DesEncrypt(tmpANsi, 'cool');
//  //tmpDecodeAnsi := DesDecrypt(tmpOutputAnsi, 'cool');
//  
//  if tmpOutputAnsi <> tmpDecodeAnsi then
//    exit;
//  
////  if Base64_EncodeTable[3] = 'A' then
////    exit;
//  if '' = tmpANsi then
//    exit;
  RunApp(TChromiumTestApp, '', TBaseApp(GlobalApp));
end.
