unit Chinese2Pinyin;

interface
            
  function Chinese2PinYinHeader(AChineseString: WideString): AnsiString;

implementation

uses
  Sysutils;
  
function Chinese2PinYinHeader(AChineseString: WideString): AnsiString;  
var  
  CharString: AnsiString;
  headerChar: AnsiString;
  i: Integer;  
begin  
  Result := '';
  for i := 1 To Length(AChineseString) do  
  begin  
    CharString := AChineseString[I];  
    if ByteType(CharString, 1) = mbSingleByte then
    begin
      headerChar := CharString
    end else
    begin
      case Word(CharString[1]) shl 8 + Word(CharString[2]) of
        $B0A1 .. $B0C4: headerChar := 'A';
        $B0C5 .. $B2C0: headerChar := 'B';
        $B2C1 .. $B4ED: headerChar := 'C';
        $B4EE .. $B6E9: headerChar := 'D';
        $B6EA .. $B7A1: headerChar := 'E';
        $B7A2 .. $B8C0: headerChar := 'F';
        $B8C1 .. $B9FD: headerChar := 'G';
        $B9FE .. $BBF6: headerChar := 'H';
        $BBF7 .. $BFA5: headerChar := 'J';
        $BFA6 .. $C0AB: headerChar := 'K';
        $C0AC .. $C2E7: headerChar := 'L';
        $C2E8 .. $C4C2: headerChar := 'M';
        $C4C3 .. $C5B5: headerChar := 'N';
        $C5B6 .. $C5BD: headerChar := 'O';
        $C5BE .. $C6D9: headerChar := 'P';
        $C6DA .. $C8BA: headerChar := 'Q';
        $C8BB .. $C8F5: headerChar := 'R';
        $C8F6 .. $CBF9: headerChar := 'S';
        $CBFA .. $CDD9: headerChar := 'T';
        $CDDA .. $CEF3: headerChar := 'W';
        $CEF4 .. $D1B8: headerChar := 'X';
        $D1B9 .. $D4D0: headerChar := 'Y';
        $D4D1 .. $D7F9: headerChar := 'Z';
      else
        headerChar := CharString;
      end;
    end;
    Result := Result + headerChar;  
  end;  
end;

end.
