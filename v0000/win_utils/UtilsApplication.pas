unit UtilsApplication;

interface

uses
  Forms, Windows;
                
  procedure SleepWait(ASleep: integer; ASleepGap: integer = 10);

implementation
          
procedure SleepWait(ASleep: integer; ASleepGap: integer = 10);
var
  tmpSleep: integer;
begin
  tmpSleep := ASleep;
  while 0 < tmpSleep do
  begin
    Sleep(ASleepGap);
    Application.ProcessMessages;
    tmpSleep := tmpSleep - ASleepGap;
  end;         
  Sleep(ASleepGap);
  Application.ProcessMessages;
end;

end.
