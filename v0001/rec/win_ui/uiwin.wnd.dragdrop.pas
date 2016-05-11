unit uiwin.wnd.dragdrop;

interface

uses
  Windows;
                    
const
  shell32 = 'shell32.dll';
  
type
  HDROP = THandle;

  function DragQueryFileW(Drop: HDROP; FileIndex: UINT; FileName: PWideChar;
    cb: UINT): UINT; stdcall; external shell32 name 'DragQueryFileW';
  function DragQueryFileA(Drop: HDROP; FileIndex: UINT; FileName: PAnsiChar;
    cb: UINT): UINT; stdcall; external shell32 name 'DragQueryFileA';
  procedure DragFinish(Drop: HDROP); stdcall; external shell32 name 'DragFinish';
  procedure DragAcceptFiles(Wnd: HWND; Accept: BOOL); stdcall; external shell32 name 'DragAcceptFiles';

  procedure DoHandle_WMDropFiles(wParam: WPARAM);
  
implementation

// WM_DROPFILES
procedure DoHandle_WMDropFiles(wParam: WPARAM);
var
  tmpDropCount: integer;
  tmpFileIndex: integer;
  tmpFileName: array[0..MAX_PATH - 1] of AnsiChar;
begin
  tmpDropCount := DragQueryFileA(WParam, $ffffffff, nil, 0);
  for tmpFileIndex := 0 to tmpDropCount - 1 do
  begin                           
    FillChar(tmpFileName, SizeOf(tmpFileName), 0);
    DragQueryFileA(WParam, tmpFileIndex, tmpFileName, MAX_PATH); // MAX_PATH
  end;         
  DragFinish(WParam);
end;

end.
