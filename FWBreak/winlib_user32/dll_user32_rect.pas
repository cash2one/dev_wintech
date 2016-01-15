{$IFDEF FREEPASCAL}
{$MODE DELPHI}
{$ENDIF}
unit dll_user32_rect;

interface

uses
  atmcmbaseconst, winconst, wintype;

  function SetRect(var lprc: TRect; xLeft, yTop, xRight, yBottom: Integer): BOOL; stdcall; external user32 name 'SetRect';

  function SetRectEmpty(var lprc: TRect): BOOL; stdcall; external user32 name 'SetRectEmpty';

  function UnionRect(var lprcDst: TRect; const lprcSrc1, lprcSrc2: TRect): BOOL; stdcall; external user32 name 'UnionRect';

  function CopyRect(var lprcDst: TRect; const lprcSrc: TRect): BOOL; stdcall; external user32 name 'CopyRect';

  { InflateRect函数增大或减小指定矩形的宽和高 }
  function InflateRect(var lprc: TRect; dx, dy: Integer): BOOL; stdcall; external user32 name 'InflateRect';

  function IntersectRect(var lprcDst: TRect; const lprcSrc1, lprcSrc2: TRect): BOOL; stdcall; external user32 name 'IntersectRect';

  function SubtractRect(var lprcDst: TRect; const lprcSrc1, lprcSrc2: TRect): BOOL; stdcall; external user32 name 'SubtractRect';

  function OffsetRect(var lprc: TRect; dx, dy: Integer): BOOL; stdcall; external user32 name 'OffsetRect';

  function IsRectEmpty(const lprc: TRect): BOOL; stdcall; external user32 name 'IsRectEmpty';

  function EqualRect(const lprc1, lprc2: TRect): BOOL; stdcall; external user32 name 'EqualRect';

  function PtInRect(const lprc: TRect; pt: TPoint): BOOL; stdcall; external user32 name 'PtInRect';

  { 该函数把相对于一个窗口的坐标空间的一组点映射成相对于另一窗口的坐标空间的一组点
    hWndfrom：转换点所在窗口的句柄，如果此参数为NULL或HWND_DESETOP则假定这些点在屏幕坐标上。
　　hWndTo：转换到的窗口的句柄，如果此参数为NULL或HWND_DESKTOP，这些点被转换为屏幕坐标
    pt := Mouse.CursorPos;
    MapWindowPoints(0, Handle, pt, 1);

    ScreenToClient 和 ClientToScreen
    CPoint pt(0,0);
    int i = ::MapWindowPoints(this->m_hWnd,GetDesktopWindow()->m_hWnd, &pt,10);
  }
  function MapWindowPoints(hWndFrom, hWndTo: HWND; var lpPoints; cPoints: UINT): Integer; stdcall; external user32 name 'MapWindowPoints';
  
implementation

end.
