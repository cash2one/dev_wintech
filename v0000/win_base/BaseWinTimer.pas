unit BaseWinTimer;

interface

uses
  Windows;
  
type
  PWinTimer = ^TWinTimer;
  TWinTimer = record
    WndHandle: HWND;
    TimerID: UINT;
    Elapse: UINT;
    TimerProc: TFNTimerProc;
  end;

  PWinWaitableTimer = ^TWinWaitableTimer;
  TWinWaitableTimer = record
    Handle  : THandle;
  end;

implementation
     
procedure InitializeTimer(ATimer: PWinTimer);
begin
  ATimer.TimerID := Windows.SetTimer(ATimer.WndHandle, ATimer.TimerID, ATimer.Elapse, ATimer.TimerProc);
end;

(*
    创建可等待定时器是Windows内部线程同步的方式之一
    本文简单讲述如何使用这一内核对象进行线程同步
*)

procedure InitializeWaitableTimer(ATimer: PWinWaitableTimer);
begin
   ATimer.Handle := CreateWaitableTimer(nil, true, '');
   //CreateWaitableTimer创建完成后内核对象处于未触发状态，需要使用API
   //SetWaitableTimer(ATimer.Handle,
     // pDueTime是第一次触发时间 UTC时间
   //);
end;

end.
