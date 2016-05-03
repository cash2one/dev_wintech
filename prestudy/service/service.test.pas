unit service.test;

interface

uses
  Types,
  Windows,
  WinSvc,
  win.app,
  win.service;

var
  GlobalApp: TWinApp;
  
  procedure ServiceHandler_TestProc(CtrlCode: DWORD); stdcall;
  
implementation

uses
  UtilsLog,
  SysUtils;

procedure ServiceHandler_TestProc(CtrlCode: DWORD); stdcall;
begin
  Log('service.test.pas', 'ServiceHandler_TestProc' + IntToStr(CtrlCode));  
  PostThreadMessage(GlobalService.ThreadID, CM_SERVICE_CONTROL_CODE, CtrlCode, 0);
  exit;
  if WinSvc.SERVICE_CONTROL_STOP = CtrlCode then
  begin
    //WinSvc.SetServiceStatus();
    //success := ReportStatus(SERVICE_STOP_PENDING, NO_ERROR,0,1,5000);
    //CloseTask();
    //success := ReportStatus(SERVICE_STOPPED, NO_ERROR,0,0,0);
    GlobalService.Status := csStopped;
    ReportServiceStatus(@GlobalService);
    exit;
  end;  
  if WinSvc.SERVICE_CONTROL_PAUSE = CtrlCode then//          = $00000002;
  begin
    GlobalService.Status := csPaused;
    ReportServiceStatus(@GlobalService);
    exit;
  end;
  if WinSvc.SERVICE_CONTROL_CONTINUE = CtrlCode then//       = $00000003;
  begin
    GlobalService.Status := csRunning;
    ReportServiceStatus(@GlobalService);
    exit;
  end;
  if WinSvc.SERVICE_CONTROL_INTERROGATE = CtrlCode then//    = $00000004;
  begin
    // 要服务马上报告它的状态
    GlobalService.Status := csRunning;
    ReportServiceStatus(@GlobalService);
    exit;
  end;
  if WinSvc.SERVICE_CONTROL_SHUTDOWN = CtrlCode then//       = $00000005;
  begin
    // 告诉服务即将关机  
    GlobalService.Status := csStopped;
    ReportServiceStatus(@GlobalService);
    exit;
  end;
end;

end.
