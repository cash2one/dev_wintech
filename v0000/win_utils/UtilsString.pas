unit UtilsString;

interface
                  
  function HexToInt(Hex: AnsiString): Integer;

implementation

function HexToInt(Hex: AnsiString): Integer;
var
  I: Integer;
  Res: Integer;
  ch: AnsiChar;
begin
  Res := 0;
  for I := 0 to Length(Hex) - 1 do
  begin
    ch := Hex[I + 1];
    if (ch >= '0') and (ch <= '9') then
      Res := Res * 16 + Ord(ch) - Ord('0')
    else if (ch >= 'A') and (ch <= 'F') then
      Res := Res * 16 + Ord(ch) - Ord('A') + 10
    else if (ch >= 'a') and (ch <= 'f') then
      Res := Res * 16 + Ord(ch) - Ord('a') + 10
    else
    begin
      //raise Exception.Create('Error: not a Hex String');
    end;
  end;
  Result := Res;
end;

end.
