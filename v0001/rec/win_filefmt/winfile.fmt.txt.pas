unit winfile.fmt.txt;

interface

uses
  win.diskfile;
  
type
  TFileFmt_Txt    = record
    WinFile       : PWinFile;
    CodePage      : Integer;  // CP_UTF8    
  end;
  
implementation

end.
