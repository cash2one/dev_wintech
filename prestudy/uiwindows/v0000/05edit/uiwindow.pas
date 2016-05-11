unit uiwindow;

interface
         
uses          
  Windows,
  Messages,
  uiwin.dc,
  uiwin.wnd,
  uiview,
  uicontrol_edit;

type
  PUIWindow         = ^TUIWindow;    
  TUIWindow         = record
    BaseWnd         : TWndUI;
    MemDC           : TWinDC;
    TestUIEdit      : TUIEdit;


    CursorHandle: HCURSOR;
    TestFocusUIView : PUIView;
    FocusMode: integer;  
  end;
  
implementation

end.
