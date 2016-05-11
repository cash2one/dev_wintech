unit uiwin.menu;

interface
              
uses
  Windows,
  win.thread,
  uiwin.wnd;
                
type
  PWndMenuItem      = ^TWndMenuItem;
  TWndMenuItem      = packed record
    MenuHandle      : HMENU;
  end;

implementation

end.
