unit uiwin_mouse;

interface

uses
  Windows, Messages, UIBaseWin;
      
  procedure DoTrackMouseEvent(AWnd: HWND);
  
implementation

procedure DoTrackMouseEvent(AWnd: HWND);
var
  tmpTrackMouse: TTrackMouseEvent;
begin
  // 当在指定时间内鼠标指针离开或盘旋在一个窗口上时，此函数寄送消息
  // WM_MOUSEHOVER
  // WM_MOUSELEAVE
  //if not ComboDownWindow.MouseInRect then
  begin
    tmpTrackMouse.cbSize := SizeOf(tmpTrackMouse);
    tmpTrackMouse.dwFlags := TME_LEAVE;
    tmpTrackMouse.hwndTrack := AWnd;
    tmpTrackMouse.dwHoverTime := 0;
    //ComboDownWindow.MouseInRect :=
    Windows.TrackMouseEvent(tmpTrackMouse);
  end;
end;

end.
