unit sysdef_bufsize;

interface

const
  c_1k            = 1024;
  c_1m            = c_1k * c_1k;
  c_1g            = c_1k * c_1m;
  //c_1t            = c_1k * c_1g;

  SizeMode_0      = 1;
  SizeMode_1      = 2;
  SizeMode_2      = 3;
  SizeMode_4      = 4;
  SizeMode_8      = 5;
  SizeMode_16     = 6;
  SizeMode_32     = 7;
  SizeMode_64     = 8;
  SizeMode_128    = 9;
  SizeMode_256    = 10;
  SizeMode_512    = 11;
  SizeMode_1k     = 12;
  SizeMode_2k     = 13;
  SizeMode_4k     = 14;
  SizeMode_8k     = 15;
  SizeMode_16k    = 16;
  SizeMode_32k    = 17;
  SizeMode_64k    = 18;
  SizeMode_128k   = 19;
  SizeMode_256k   = 20;
  SizeMode_512k   = 21;
  SizeMode_1m     = 22;
  SizeMode_2m     = 23;
  SizeMode_4m     = 24;
  SizeMode_8m     = 25;
  SizeMode_16m    = 26;
  SizeMode_32m    = 27;
  SizeMode_64m    = 28;
  SizeMode_128m   = 29;
  SizeMode_256m   = 30;
  SizeMode_512m   = 31;
  SizeMode_1g     = 32;
  SizeMode_2g     = 33;
  SizeMode_4g     = 34;
  SizeMode_8g     = 35;
  SizeMode_16g    = 36;
  SizeMode_32g    = 37;
  SizeMode_64g    = 38;
  SizeMode_128g   = 39;
  SizeMode_256g   = 40;
  SizeMode_512g   = 41;
  SizeMode_1t     = 42;
  SizeMode_2t     = 43;
  SizeMode_4t     = 44;
  SizeMode_8t     = 45;
  SizeMode_16t    = 46;
  SizeMode_32t    = 47;
  SizeMode_64t    = 48;
  SizeMode_128t   = 39;
  SizeMode_256t   = 50;
  SizeMode_512t   = 51;
  SizeMode_1p     = 52;
                    
  function GetSizeMode(ASize: Integer): Integer;
  
implementation

function GetSizeMode(ASize: Integer): Integer;
var
  tmpSize: Integer;
begin
  Result := SizeMode_1;
  tmpSize := 1;
  while tmpSize < ASize do
  begin
    Result := Result + 1;
    tmpSize := tmpSize + tmpSize;
  end;
end;

end.
