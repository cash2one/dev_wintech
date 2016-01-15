unit UtilsDateTime;

interface
                 
  function SeasonOfMonth(AMonth: Word): Word;
  function IsCurrentSeason(ADate: TDateTime): Boolean;

implementation

uses
  SysUtils;
  
function SeasonOfMonth(AMonth: Word): Word;
begin
  Result := ((AMonth - 1) div 3) + 1;
end;

function IsCurrentSeason(ADate: TDateTime): Boolean;
var
  tmpYear1, tmpMonth1,
  tmpYear2, tmpMonth2,
  tmpDay: Word;
begin
  DecodeDate(ADate, tmpYear1, tmpMonth1, tmpDay);
  DecodeDate(now, tmpYear2, tmpMonth2, tmpDay);
  Result := (tmpYear1 = tmpYear2) and (SeasonOfMonth(tmpMonth1) = SeasonOfMonth(tmpMonth2));
end;

end.
