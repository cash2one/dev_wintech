unit win.app;

interface

uses
  Windows, Messages;
  
type
  PWinApp         = ^TWinApp;
  TWinApp         = record
    AppCmdWnd     : Windows.HWND;
    AppMsg        : Windows.TMsg;  
    AppMutexHandle: THandle;
    IsTerminated  : Boolean;
  end;
                       
  function ProcessMessage(App: PWinApp): Boolean;

implementation


function IsKeyMsg(var Msg: WIndows.TMsg): Boolean;
//var
//  Wnd: HWND;
//  WndProcessID: Cardinal;
//  ProcessID: Cardinal;
begin
  Result := False;
  (*//
  with Msg do
  begin
    if (Msg.Message >= WM_KEYFIRST) and (Msg.Message <= WM_KEYLAST) then
    begin
      Wnd := GetCapture;
      if Wnd = 0 then
      begin
        Wnd := HWnd;
        if (MainForm <> nil) and (Wnd = MainForm.ClientHandle) then
        begin
          Wnd := MainForm.Handle
        end else
        begin
          // Find the nearest VCL component.  Non-VCL windows wont know what
          // to do with CN_BASE offset messages anyway.
          // TOleControl.WndProc needs this for TranslateAccelerator
          while not IsVCLControl(Wnd) and (Wnd <> 0) do
            Wnd := GetParent(Wnd);
          if Wnd = 0 then Wnd := HWnd;
        end;
        if IsWindowUnicode(Wnd) then
        begin
          if SendMessageW(Wnd, CN_BASE + Msg.Message, WParam, LParam) <> 0 then
            Result := True;
        end else if SendMessageA(Wnd, CN_BASE + Msg.Message, WParam, LParam) <> 0 then
            Result := True;
      end else
      begin
        GetWindowThreadProcessId(Wnd, WndProcessId);
        GetWindowThreadProcessId(Handle, ProcessId);
        if (WndProcessID = ProcessID) then
          if SendMessage(Wnd, CN_BASE + Msg.Message, WParam, LParam) <> 0 then
            Result := True;
      end;
    end;
  end;
  //*)
end;

function ProcessMessage(App: PWinApp): Boolean;
var
  tmpIsUnicodeWnd: Boolean;
  tmpIsMsgExists: Boolean;
  tmpIsHandled: Boolean;
begin
  Result := False;
  if PeekMessage(App.AppMsg, 0, 0, 0, PM_NOREMOVE) then
  begin
    tmpIsUnicodeWnd := (App.AppMsg.hwnd <> 0) and IsWindowUnicode(App.AppMsg.hwnd);
    if tmpIsUnicodeWnd then
      tmpIsMsgExists := PeekMessageW(App.AppMsg, 0, 0, 0, PM_REMOVE)
    else
      tmpIsMsgExists := PeekMessageA(App.AppMsg, 0, 0, 0, PM_REMOVE);
    if not tmpIsMsgExists then
      Exit;
    Result := True;
    if App.AppMsg.Message <> WM_QUIT then
    begin
      tmpIsHandled := False;
//      if Assigned(FOnMessage) then
//      begin
//        FOnMessage(App.AppMsg, tmpIsHandled);
//      end;
      if (not tmpIsHandled)
//        and (not IsPreProcessMessage(App.AppMsg))
//        and (not IsHintMsg(App.AppMsg))
//        and (not IsMDIMsg(App.AppMsg))
//        and (not IsKeyMsg(App.AppMsg))
//        and (not IsDlgMsg(App.AppMsg))
        then
      begin
        TranslateMessage(App.AppMsg);
        if tmpIsUnicodeWnd then
          DispatchMessageW(App.AppMsg)
        else
          DispatchMessageA(App.AppMsg);
      end;
    end else
    begin
      App.IsTerminated := True;
    end;
  end;
end;

end.
