unit uiwindow;

interface
         
uses          
  Windows,
  Messages,
  uiwin.memdc,
  win.wnd_ui,
  uiview,
  uicontrol_edit;

type
  PUIWindow         = ^TUIWindow;    
  TUIWindow         = record
    BaseWnd         : TUIBaseWnd;
    WndClientRect   : TRect;
    MemDC           : TWinMemDC;
    TestUIEdit      : TUIEdit;

    WMSetCursor_CursorPoint: TPoint;
    WMLButtonDown_CursorPoint: TSmallPoint;
    WMMouseMove_CursorPoint: TSmallPoint;

    CursorHandle: HCURSOR;
    TestFocusUIView : PUIView;
    FocusMode: integer;  
  end;
  
implementation

end.
