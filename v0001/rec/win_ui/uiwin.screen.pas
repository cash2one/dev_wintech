unit uiwin.screen;

interface

uses
  Windows, MultiMon;

type
  PWinMonitor       = ^TWinMonitor;
  TWinMonitor       = packed record
    MonitorHandle   : MultiMon.HMONITOR;
  end;

  PWinScreen        = ^TWinScreen;        
  TWinScreen        = packed record
    PixelsPerInch   : Integer; 
    DefaultKbLayout : HKL;

    PixelSize       : TSize;
    PhysicalSize    : TSize;
  end;

  function GetMonitorBoundsRect(AWinMonitor: PWinMonitor): TRect;    
  procedure GetDisplayDevicePhysicalSize(AScreen: PWinScreen; AScreenDC: HDC);  
  function GetDisplayDeviceSizeMM(AScreen: PWinScreen): double;
  function GetDisplayDeviceSizeInch(AScreen: PWinScreen): double;

implementation

function GetMonitorBoundsRect(AWinMonitor: PWinMonitor): TRect;
var
  tmpMonInfo: TMonitorInfo;
begin
  tmpMonInfo.cbSize := SizeOf(tmpMonInfo);
  GetMonitorInfo(AWinMonitor.MonitorHandle, @tmpMonInfo);
  Result := tmpMonInfo.rcMonitor;
end;

                   
function InitializeScreen(AScreen: PWinScreen): Integer;
var
  tmpDC: HDC;
begin
  tmpDC := GetDC(0);
  AScreen.PixelsPerInch := Windows.GetDeviceCaps(tmpDC, LOGPIXELSY);    
  AScreen.DefaultKbLayout := Windows.GetKeyboardLayout(0);
  ReleaseDC(0, tmpDC);
end;
  
function GetScreenMonitorCount: Integer;
begin
  //if FMonitors.Count = 0 then
  Result := GetSystemMetrics(SM_CMONITORS);
//  else
//    Result := FMonitors.Count;
end;
            
function GetScreenWorkAreaRect: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0);
end;

function GetScreenPixelHeight: Integer;
begin
  Result := GetSystemMetrics(SM_CYSCREEN);
end;

function GetScreenPixelWidth: Integer;
begin
  Result := GetSystemMetrics(SM_CXSCREEN);
end;

procedure GetMonitorSizeFromEDID;//(TCHAR* adapterName, DWORD& Width, DWORD& Height)
begin
  // HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Enum\\DISPLAY\\
  // "Driver"\"Device Parameters"\"EDID"
(*//
EDID: Extended Display Identification Data（扩展显示标识数据）
是一种VESA 标准数据格式，其中包含有关监视器及其性能的参数，
包括供应商信息、最大图像大小、颜色设置、厂商预设置、频率范围的限制
以及显示器名和序列号的字符串。 这些信息保存在 display 节中，用来通过
一个 DDC（Display Data Channel）与系统进行通信，这是在显示器和 PC
图形适配器之间进行的。最新版本的 EDID 可以在 CRT、LCD 以及将来的
显示器类型中使用，这是因为 EDID 提供了几乎所有显示参数的通用描述。
EDID 由128个字节组成，大致划分如下
0-7 ：头信息 ，8个字节，由00 FF FF FF FF FF FF 00 组成
8-9：厂商ID
10-11： 产品ID
12-15：32-bit序列号
16-17 ：制造日期
18-19 ： EDID 版本
20-24 ： 显示器的基本信息（电源，最大高度，宽度）
25-34 ： 显示器的颜色特征
35-37 ： 显示器的基本时序，定时 ，分辨率
38-53 ： 显示器的标准时序及定时
54-125： 显示器的详细时序及定时
126： 扩展标志位，EDID-1.3版本需要忽略，设置为0
127： 求和验证值
//*)
end;

procedure GetDisplayDevicePhysicalSize(AScreen: PWinScreen; AScreenDC: HDC);
var
  tmpDC: HDC;
//  tmpPixelX, tmpPixelY: integer;
//  tmpLogPixelX, tmpLogPixelY: integer;  
begin
  // 由于GetDeviceCaps函数的限制
  // 在Win7系统下该程序检测结果不准确
  // WinXP系统下基本上可以正确运行
  if 0 <> AScreenDC then
  begin
    // Windows Vista和上层支持的新函数GetMonitorDisplayAreaSize
    
//    tmpPixelX := GetDeviceCaps(tmpDC, HORZRES); //所有像素数
//    tmpPixelY := GetDeviceCaps(tmpDC, VERTRES);
//
//    tmpLogPixelX := GetDeviceCaps(tmpDC, LOGPIXELSX); //即每英寸点数
//    tmpLogPixelY := GetDeviceCaps(tmpDC, LOGPIXELSY); //即每英寸点数
    //验证数值是：当HORZRES/VERTRES分别为800/600、1280/1024、1360/768时，LOGPIXELSX/LOGPIXELSY一直为96

    //HORZSIZE/HORZRES/LOGPIXELSX等。
    //以上三者的关系通常满足：HORZSIZE = 25.4 * HORZRES/LOGPIXELSX
//    // 计算一个设备单位等于多少0.1mm
//    double scaleX = 254.0 / (double)GetDeviceCaps(dc.m_hAttribDC, LOGPIXELSX);
//    double scaleY = 254.0 / (double)GetDeviceCaps(dc.m_hAttribDC, LOGPIXELSY);
    AScreen.PhysicalSize.cx := GetDeviceCaps(AScreenDC, HORZSIZE);
    AScreen.PhysicalSize.cy := GetDeviceCaps(AScreenDC, VERTSIZE);
  end else
  begin
    //tmpDC := GetDC(0);
    tmpDC := CreateDCA('display', nil, nil, nil);
    if 0 <> tmpDC then
    begin
      try
        GetDisplayDevicePhysicalSize(AScreen, tmpDC);
      finally
        //ReleaseDC(0, tmpDC);
        DeleteDC(tmpDC);
      end;
    end;
  end;
  // 我找到了另一种方式。显示器的物理尺寸被存储在EDID
  // 并将视窗几乎都是其值的副本在注册表中。如果你能解析EDID，你可以阅读显示器的宽度和高度
end;

function GetDisplayDeviceSizeMM(AScreen: PWinScreen): double;
begin
  Result := Sqrt(
       AScreen.PhysicalSize.cx * AScreen.PhysicalSize.cx +
       AScreen.PhysicalSize.cy * AScreen.PhysicalSize.cy);
end;

function GetDisplayDeviceSizeInch(AScreen: PWinScreen): double; 
const
  MILLIMETRE_TO_INCH = 0.0393701; // 毫米换算到英寸
begin
  Result := GetDisplayDeviceSizeMM(AScreen) * MILLIMETRE_TO_INCH;
end;
{
  GetSystemMetrics                                                                                       _
    SM_ARRANGE  标志用于说明系统如何安排最小化窗口
      ARW_BOTTOMLEFT
    SM_CLEANBOOT 返回系统启动方式
      0 正常启动
      1 安全模式启动
      2 网络安全模式启动
    SM_CMOUSEBUTTONS
      返回值为系统支持的鼠标键数 返回0 则系统中没有安装鼠标
    SM_CXCURSOR, SM_CYCURSOR 返回以像素值为单位的标准光标的宽度和高度
    SM_CXFIXEDFRAME, SM_CYFIXEDFRAME 围绕具有标题但无法改变尺寸的窗口（通常是一些对话框）的边框的厚度
    SM_CXFULLSCREEN, SM_CYFULLSCREEN 全屏幕窗口的窗口区域的宽度和高度
    SM_CXSCREEN, SM_CYSCREEN 以像素为单位计算的屏幕尺寸
}

(*//
  //设置显示器为省电模式
  SendMessage(m_hWnd, WM_SYSCOMMAND, SC_MONITORPOWER, 1);
  //关闭显示器
  SendMessage(m_hWnd, WM_SYSCOMMAND, SC_MONITORPOWER, 2);
  //打开显示器
  SendMessage(m_hWnd, WM_SYSCOMMAND, SC_MONITORPOWER, -1);
//*)

procedure UpdateDisplayDevice();
var
  tmpDisplayDeviceA: TDeviceModeA;
begin
  //颜色深度
  //if (m_ctrlBitsPerPixel.GetCurSel() == 0)
  tmpDisplayDeviceA.dmBitsPerPel := 16;
  //if (m_ctrlBitsPerPixel.GetCurSel() == 1)
  tmpDisplayDeviceA.dmBitsPerPel := 32;
  //分辨率
  //if (m_ctrlPixels.GetCurSel() == 0)
  tmpDisplayDeviceA.dmPelsWidth := 800;
  tmpDisplayDeviceA.dmPelsHeight := 600;
  //else if (m_ctrlPixels.GetCurSel() == 1)
  tmpDisplayDeviceA.dmPelsWidth := 1024;
  tmpDisplayDeviceA.dmPelsHeight := 768;
  //刷新率
  //if (m_ctrlDispalyFrequencry.GetCurSel() == 0)
  tmpDisplayDeviceA.dmDisplayFrequency := 60;
  //else if (m_ctrlDispalyFrequencry.GetCurSel() == 1)
  tmpDisplayDeviceA.dmDisplayFrequency := 75;

  tmpDisplayDeviceA.dmSize := sizeof(tmpDisplayDeviceA);
  tmpDisplayDeviceA.dmFields := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL or DM_DISPLAYFREQUENCY;

  //设置显示属性
  if (DISP_CHANGE_SUCCESSFUL = ChangeDisplaySettings(tmpDisplayDeviceA, 0)) then
  begin
    //用新的设置参数更新注册表
    Windows.ChangeDisplaySettingsA(tmpDisplayDeviceA, CDS_UPDATEREGISTRY);
  end else
  begin
    //恢复默认设置
    FillChar(tmpDisplayDeviceA, SizeOf(tmpDisplayDeviceA), 0);
    Windows.ChangeDisplaySettings(tmpDisplayDeviceA, 0);
  end;
end;

end.
