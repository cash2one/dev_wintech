unit BaseWinApp;

interface

uses
  Windows,
  BaseApp;
  
type        
  TBaseWinAppPath = class(TBaseAppPath)
  protected
  public
    function IsFileExists(AFileUrl: string): Boolean; override;
  end;
  
  PBaseWinAppData = ^TBaseWinAppData;
  TBaseWinAppData = record
    AppCmdWnd     : Windows.HWND;
    AppMsg        : Windows.TMsg;
    AppPath       : TBaseWinAppPath;
  end;

  TBaseWinApp = class(TBaseApp)
  protected
    fBaseWinAppData: TBaseWinAppData;  
    function GetBaseWinAppData: PBaseWinAppData;
  public
    constructor Create(AppClassId: AnsiString); override;
    procedure RunAppMsgLoop;
    property BaseWinAppData: PBaseWinAppData read GetBaseWinAppData;
    property AppWindow: HWND read fBaseWinAppData.AppCmdWnd;
  end;
           
var
  GlobalBaseWinApp: TBaseWinApp = nil;
    
implementation

uses
  SysUtils;
  
{ TBaseWinApp }

constructor TBaseWinApp.Create(AppClassId: AnsiString);
begin
  inherited;
  FillChar(fBaseWinAppData, SizeOf(fBaseWinAppData), 0);
  GlobalBaseWinApp := Self;
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

function TBaseWinAppPath.IsFileExists(AFileUrl: string): Boolean;
begin
  Result := SysUtils.FileExists(AFileUrl);
end;


end.
