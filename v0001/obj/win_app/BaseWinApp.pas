unit BaseWinApp;

interface

uses
  Windows,
  BaseApp;
  
type        
  TBaseWinAppPath = class(TBaseAppPath)
  protected
  public
    function IsFileExists(AFileUrl: WideString): Boolean; override;
  end;
  
  PBaseWinAppData = ^TBaseWinAppData;
  TBaseWinAppData = record
    AppCmdWnd     : Windows.HWND;
    AppMsg        : Windows.TMsg;
    AppPath       : TBaseWinAppPath;
    AppMutexHandle: THandle;
  end;

  TBaseWinApp = class(TBaseApp)
  protected
    fBaseWinAppData: TBaseWinAppData;  
    function GetBaseWinAppData: PBaseWinAppData;
  public
    constructor Create(AppClassId: AnsiString); override;
    procedure RunAppMsgLoop;
                                 
    procedure DestroyAppCommandWindow;
    function CheckSingleInstance(AppMutexName: AnsiString): Boolean;
    procedure Terminate; override;
    property BaseWinAppData: PBaseWinAppData read GetBaseWinAppData;
    property AppWindow: HWND read fBaseWinAppData.AppCmdWnd write fBaseWinAppData.AppCmdWnd;
  end;

  TBaseWinAppAgent = class(TBaseAppAgent)
  protected
  public
  end;
  
var
  GlobalBaseWinApp: TBaseWinApp = nil;
    
implementation

uses
  SysUtils,
  messages,
  windef_msg;
  
{ TBaseWinApp }

constructor TBaseWinApp.Create(AppClassId: AnsiString);
begin
  inherited;
  FillChar(fBaseWinAppData, SizeOf(fBaseWinAppData), 0);
  GlobalBaseWinApp := Self;
end;

procedure TBaseWinApp.DestroyAppCommandWindow;
begin
//
end;
          
procedure TBaseWinApp.Terminate;
begin
  if IsActiveStatus_Active = Self.IsActiveStatus then
  begin
    Self.IsActiveStatus := IsActiveStatus_RequestShutdown;
    if IsWIndow(fBaseWinAppData.AppCmdWnd) then
    begin
      PostMessage(fBaseWinAppData.AppCmdWnd, WM_AppRequestEnd, 0, 0);
    end;
    Self.Finalize;       
      PostMessage(fBaseWinAppData.AppCmdWnd, WM_Quit, 0, 0);
    PostQuitMessage(0);
  end;
end;

function TBaseWinApp.GetBaseWinAppData: PBaseWinAppData;
begin
  Result := @fBaseWinAppData;
end;

procedure TBaseWinApp.RunAppMsgLoop;
begin
  while Windows.GetMessage(fBaseWinAppData.AppMsg, 0, 0, 0) do
  begin
    TranslateMessage(fBaseWinAppData.AppMsg);
    DispatchMessage(fBaseWinAppData.AppMsg);
  end;
end;

function TBaseWinApp.CheckSingleInstance(AppMutexName: AnsiString): Boolean;
begin                                           
  if AppMutexName = '' then
    AppMutexName := ExtractFileName(ParamStr(0));
  fBaseWinAppData.AppMutexHandle := CreateMutexA(nil, False, PAnsiChar(AppMutexName));
  Result := GetLastError <> ERROR_ALREADY_EXISTS;
end;

function TBaseWinAppPath.IsFileExists(AFileUrl: WideString): Boolean;
begin
  Result := SysUtils.FileExists(AFileUrl);
end;

end.
