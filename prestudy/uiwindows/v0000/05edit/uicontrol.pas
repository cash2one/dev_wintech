unit uicontrol;

interface

uses
  uiview,
  uiview_space;
  
type
  TBaseUIControl = record
    View        : PUIView;
    Border      : PUIView;
    Background  : PUIView;    
  end;
  
implementation

end.
