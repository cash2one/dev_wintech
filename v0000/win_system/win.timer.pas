unit win.timer;

interface

uses
  Windows;
  // Windows中7种定时器
  {
    1. WM_TIMER SetTimer 精度非常低
        最小计时精度仅为30ms CPU占用低
        且定时器消息在多任务操作系统中的优先级很低 不能得到及时响应
    2. sleep
    3. COleDateTime
    4. GetTickCount
        以ms为单位的计算机启动后经历的时间间隔
        精度比WM_TIMER消息映射高
        在较短的定时中其计时误差为15ms
    5. DWORD timeGetTime(void) 多媒体定时器函数
        定时精 度为ms级
    6. timeSetEvent() 多媒体定时器
        函数定时精度为ms级 利用该函数可以实现周期性的函数调用
    7. QueryPerformanceFrequency()和
       QueryPerformanceCounter()
       对于精确度要求更高的定时操作 则应该使用
       其定时误差不超过1微秒，精度与CPU等机器配置有关
  }
           
type
  { 高精度 计时器 }
  PPerfTimer    = ^TPerfTimer;
  TPerfTimer    = record
    Frequency   : Int64;
    Start       : Int64;
    Stop        : Int64;
  end;

  PWinTimer     = ^TWinTimer;
  TWinTimer     = record
    Wnd         : HWND;    
    TimerID     : UINT;
    EventID     : UINT;
    Elapse      : UINT;
    TimerFunc   : TFNTimerProc;
  end;
  
  procedure PerfTimerStart(APerfTimer: PPerfTimer);

  function PerfTimerReadValue(APerfTimer: PPerfTimer): Int64;
  function PerfTimerReadNanoSeconds(APerfTimer: PPerfTimer): AnsiString;
  function PerfTimerReadMilliSeconds(APerfTimer: PPerfTimer): AnsiString;
  function PerfTimerReadSeconds(APerfTimer: PPerfTimer): AnsiString;
                         
  function GetTickCount: Cardinal;
  
  procedure StartWinTimer(ATimer: PWinTimer);
  procedure EndWinTimer(ATimer: PWinTimer);

implementation

uses
  Sysutils;
  
procedure PerfTimerStart(APerfTimer: PPerfTimer);
begin
  Windows.QueryPerformanceCounter(APerfTimer.Start);
end;

function PerfTimerReadValue(APerfTimer: PPerfTimer): Int64;
begin
  QueryPerformanceCounter(APerfTimer.Stop);
  QueryPerformanceFrequency(APerfTimer.Frequency);
  Assert(APerfTimer.Frequency > 0);
  Result := Round(1000000 * (APerfTimer.Stop - APerfTimer.Start) / APerfTimer.Frequency);
end;

function PerfTimerReadNanoseconds(APerfTimer: PPerfTimer): string;
begin
  QueryPerformanceCounter(APerfTimer.Stop);
  QueryPerformanceFrequency(APerfTimer.Frequency);
  Assert(APerfTimer.Frequency > 0);

  Result := IntToStr(Round(1000000 * (APerfTimer.Stop - APerfTimer.Start) / APerfTimer.Frequency));
end;

function PerfTimerReadMilliseconds(APerfTimer: PPerfTimer): string;
begin
  QueryPerformanceCounter(APerfTimer.Stop);
  QueryPerformanceFrequency(APerfTimer.Frequency);
  Assert(APerfTimer.Frequency > 0);

  Result := FloatToStrF(1000 * (APerfTimer.Stop - APerfTimer.Start) / APerfTimer.Frequency, ffFixed, 15, 3);
end;

function PerfTimerReadSeconds(APerfTimer: PPerfTimer): String;
begin
  QueryPerformanceCounter(APerfTimer.Stop);
  QueryPerformanceFrequency(APerfTimer.Frequency);
  Result := FloatToStrF((APerfTimer.Stop - APerfTimer.Start) / APerfTimer.Frequency, ffFixed, 15, 3);
end;

function GetTickCount: Cardinal;
begin
  Result := Windows.GetTickCount;
end;

procedure StartWinTimer(ATimer: PWinTimer);
begin
  ATimer.TimerID := Windows.SetTimer(ATimer.Wnd, ATimer.EventID, ATimer.Elapse, ATimer.TimerFunc);
end;

procedure EndWinTimer(ATimer: PWinTimer);
begin
  Windows.KillTimer(ATimer.Wnd, ATimer.TimerId);
end;

end.
