unit xlcodec_base64;

interface

uses
  define_char;

(*
Base64是网络上最常见的用于传输8Bit字节代码的编码方式之一，
大家可以查看RFC2045～RFC2049，上面有MIME的详细规范。
Base64编码可用于在HTTP环境下传递较长的标识信息。例如，
在Java Persistence系统Hibernate中，就采用了Base64来将一个较长
的唯一标识符（一般为128-bit的UUID）编码为一个字符串，
用作HTTP表单和HTTP GET URL中的参数。在其他应用程序中，
也常常需要把二进制数据编码为适合放在URL（包括隐藏表单域）
中的形式。此时，采用Base64编码具有不可读性，即所编码的数据不会被人用肉眼所直接看到
*)
        
const
  Base64TableLength = 65;
  Base64_EncodeTable: array[0..Base64TableLength - 1] of AnsiChar = (
    AC_CAPITAL_A, AC_CAPITAL_B, AC_CAPITAL_C, AC_CAPITAL_D, AC_CAPITAL_E, AC_CAPITAL_F,
    AC_CAPITAL_G, AC_CAPITAL_H, AC_CAPITAL_I, AC_CAPITAL_J, AC_CAPITAL_K, AC_CAPITAL_L,
    AC_CAPITAL_M, AC_CAPITAL_N, AC_CAPITAL_O, AC_CAPITAL_P, AC_CAPITAL_Q, AC_CAPITAL_R,
    AC_CAPITAL_S, AC_CAPITAL_T, AC_CAPITAL_U, AC_CAPITAL_V, AC_CAPITAL_W, AC_CAPITAL_X,
    AC_CAPITAL_Y, AC_CAPITAL_Z,       
    AC_SMALL_A, AC_SMALL_B, AC_SMALL_C, AC_SMALL_D, AC_SMALL_E, AC_SMALL_F,
    AC_SMALL_G, AC_SMALL_H, AC_SMALL_I, AC_SMALL_J, AC_SMALL_K, AC_SMALL_L,
    AC_SMALL_M, AC_SMALL_N, AC_SMALL_O, AC_SMALL_P, AC_SMALL_Q, AC_SMALL_R,
    AC_SMALL_S, AC_SMALL_T, AC_SMALL_U, AC_SMALL_V, AC_SMALL_W, AC_SMALL_X,
    AC_SMALL_Y, AC_SMALL_Z,   
    AC_DIGIT_ZERO, AC_DIGIT_ONE, AC_DIGIT_TWO, AC_DIGIT_THREE, AC_DIGIT_FOUR,
    AC_DIGIT_FIVE, AC_DIGIT_SIX, AC_DIGIT_SEVEN, AC_DIGIT_EIGHT, AC_DIGIT_NINE,
    AC_PLUS_SIGN, AC_SOLIDUS, AC_EQUALS_SIGN
    );
          
  { 不包含在 Base64 里面的字符直接给零, 反正也取不到}
  Base64_DecodeTable: array[#0..#127] of Byte =
  (
    Byte(AC_EQUALS_SIGN), 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
    00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
    00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 62, 00, 00, 00, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 00, 00, 00, 00, 00, 00,
    00, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 00, 00, 00, 00, 00,
    00, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 00, 00, 00, 00, 00
    );  
          
  BASE64_Pad = AC_EQUALS_SIGN;
              
  BASE64_OK       = 0; // 转换成功
  BASE64_ERROR    = 1; // 转换错误（未知错误） (e.g. can't encode octet in input stream) -> error in implementation
  BASE64_INVALID  = 2; // 输入的字符串中有非法字符 (在 FilterDecodeInput=False 时可能出现)
  BASE64_LENGTH   = 3; // 数据长度非法
  BASE64_DATALEFT = 4; // too much input data left (receveived 'end of encoded data' but not end of input string)
  BASE64_PADDING  = 5; // 输入的数据未能以正确的填充字符结束

  function Base64Encode(const AInputData: AnsiString; var AOutputData: AnsiString): Byte;
  function Base64Decode(const AInputData: AnsiString; var AOutputData: AnsiString;
      AIsFixZero: Boolean = True;
      AIsFilterDecodeInput: Boolean = True): Byte;
  
implementation

uses
  Sysutils;
  
function Base64Encode(const AInputData: AnsiString; var AOutputData: AnsiString): Byte; 
var
  Times, SrcLen, i: Integer;
  x1, x2, x3, x4: AnsiChar;
  xt: byte;
begin
  SrcLen := Length(AInputData);
  if SrcLen mod 3 = 0 then
    Times := SrcLen div 3
  else
    Times := SrcLen div 3 + 1;
  SetLength(AOutputData, Times * 4);   //一次分配整块内存,避免一次次字符串相加,一次次释放分配内存

  for i := 0 to times - 1 do
  begin
    if SrcLen >= (3 + i * 3) then
    begin
      x1 := Base64_EncodeTable[(ord(AInputData[1 + i * 3]) shr 2)];
      xt := (ord(AInputData[1 + i * 3]) shl 4) and 48;
      xt := xt or (ord(AInputData[2 + i * 3]) shr 4);
      x2 := Base64_EncodeTable[xt];
      xt := (Ord(AInputData[2 + i * 3]) shl 2) and 60;
      xt := xt or (ord(AInputData[3 + i * 3]) shr 6);
      x3 := Base64_EncodeTable[xt];
      xt := (ord(AInputData[3 + i * 3]) and 63);
      x4 := Base64_EncodeTable[xt];
    end
    else if SrcLen >= (2 + i * 3) then
    begin
      x1 := Base64_EncodeTable[(ord(AInputData[1 + i * 3]) shr 2)];
      xt := (ord(AInputData[1 + i * 3]) shl 4) and 48;
      xt := xt or (ord(AInputData[2 + i * 3]) shr 4);
      x2 := Base64_EncodeTable[xt];
      xt := (ord(AInputData[2 + i * 3]) shl 2) and 60;
      x3 := Base64_EncodeTable[xt ];
      x4 := '=';
    end
    else
    begin
      x1 := Base64_EncodeTable[(ord(AInputData[1 + i * 3]) shr 2)];
      xt := (ord(AInputData[1 + i * 3]) shl 4) and 48;
      x2 := Base64_EncodeTable[xt];
      x3 := '=';
      x4 := '=';
    end;
    AOutputData[I shl 2 + 1] := Char(X1);
    AOutputData[I shl 2 + 2] := Char(X2);
    AOutputData[I shl 2 + 3] := Char(X3);
    AOutputData[I shl 2 + 4] := Char(X4);
  end;
  AOutputData := Trim(AOutputData);
  Result := BASE64_OK;
end;

function Base64Decode(const AInputData: AnsiString; var AOutputData: AnsiString;
    AIsFixZero: Boolean = true;
    AIsFilterDecodeInput: Boolean = True): Byte;
var
  SrcLen, DstLen, Times, i: Integer;
  x1, x2, x3, x4, xt: Byte;
  C: Integer;
  Data: AnsiString;

  function FilterLine(const Source: AnsiString): AnsiString;
  var
    P, PP: PAnsiChar;
    I: Integer;
  begin
    SrcLen := Length(Source);
    GetMem(P, Srclen);                   //一次分配整块内存,避免一次次字符串相加,一次次释放分配内存
    PP := P;
    FillChar(P^, Srclen, 0);
    for I := 1 to SrcLen do
    begin
      if Source[I] in ['0'..'9', 'A'..'Z', 'a'..'z', '+', '/', '='] then
      begin
        PP^ := Source[I];
        Inc(PP);
      end;
    end;
    SetString(Result, P, PP - P);        //截取有效部分
    FreeMem(P, SrcLen);
  end;

begin
  if (AInputData = '') then
  begin
    Result := BASE64_OK;
    Exit;
  end;
  AOutputData:='';

  if AIsFilterDecodeInput then
    Data := FilterLine(AInputData)
  else
    Data := AInputData;

  SrcLen := Length(Data);
  DstLen := SrcLen * 3 div 4;
  SetLength(AOutputData, DstLen);  //一次分配整块内存,避免一次次字符串相加,一次次释放分配内存
  Times := SrcLen div 4;
  C := 1;

  for i := 0 to Times - 1 do
  begin
    x1 := Base64_DecodeTable[Data[1 + i shl 2]];
    x2 := Base64_DecodeTable[Data[2 + i shl 2]];
    x3 := Base64_DecodeTable[Data[3 + i shl 2]];
    x4 := Base64_DecodeTable[Data[4 + i shl 2]];
    x1 := x1 shl 2;
    xt := x2 shr 4;
    x1 := x1 or xt;
    x2 := x2 shl 4;
    AOutputData[C] := AnsiChar(Chr(x1));
    Inc(C);
    if x3 = 64 then
      Break;
    xt := x3 shr 2;
    x2 := x2 or xt;
    x3 := x3 shl 6;
    AOutputData[C] := AnsiChar(Chr(x2));
    Inc(C);
    if x4 = 64 then
      Break;
    x3 := x3 or x4;
    AOutputData[C] := AnsiChar(Chr(x3));
    Inc(C);
  end;

  // 删除尾部的 #0
  if AIsFixZero then
  begin
    while (DstLen > 0) and (AOutputData[DstLen] = #0) do
      Dec(DstLen);
    SetLength(AOutputData, DstLen);
  end;

  AOutputData := {$IFDEF DELPHI12_UP}AnsiString{$ENDIF}({$IFDEF DELPHI12_UP}String{$ENDIF}(AOutputData));
  Result := BASE64_OK;
end;

end.
