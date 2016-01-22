unit xlencrypt_des;

interface
              
(*
SHA (Secure Hash Algorithm，译作安全散列算法
*)
               
type
  TByte6 = array[0..5] of Byte;
  TDesSubKey = array[0..15] of TByte6;
  
  function DesEncrypt(AStr, AKey: AnsiString): AnsiString;
  function DesEncryptHex(AStr, AKey: AnsiString): AnsiString;
  
  function DesDecrypt(AStr, AKey: AnsiString): AnsiString;
  function DesDecryptHex(AStrHex, AKey: AnsiString): AnsiString;

implementation

uses
  UtilsString,
  SysUtils;
  
const
  Des_BitIP: array[0..63] of Byte =
  (57, 49, 41, 33, 25, 17, 9,  1,
   59, 51, 43, 35, 27, 19, 11, 3,
   61, 53, 45, 37, 29, 21, 13, 5,
   63, 55, 47, 39, 31, 23, 15, 7,
   56, 48, 40, 32, 24, 16, 8,  0,
   58, 50, 42, 34, 26, 18, 10, 2,
   60, 52, 44, 36, 28, 20, 12, 4,
   62, 54, 46, 38, 30, 22, 14, 6);

  Des_BitCP: array[0..63] of Byte =
  (39, 7, 47, 15, 55, 23, 63, 31,
   38, 6, 46, 14, 54, 22, 62, 30,
   37, 5, 45, 13, 53, 21, 61, 29,
   36, 4, 44, 12, 52, 20, 60, 28,
   35, 3, 43, 11, 51, 19, 59, 27,
   34, 2, 42, 10, 50, 18, 58, 26,
   33, 1, 41, 9,  49, 17, 57, 25,
   32, 0, 40, 8,  48, 16, 56, 24);

  Des_BitExp: array[0..47] of Integer =
  (31, 0,  1,  2,  3,  4,  3,  4,
   5,  6,  7,  8,  7,  8,  9,  10,
   11, 12, 11, 12, 13, 14, 15, 16,
   15, 16, 17, 18, 19, 20, 19, 20,
   21, 22, 23, 24, 23, 24, 25, 26,
   27, 28, 27, 28, 29, 30, 31, 0);

  Des_BitPM: array[0..31] of Byte =
  (15, 6,  19, 20, 28, 11, 27, 16,
   0,  14, 22, 25, 4,  17, 30, 9,
   1,  7,  23, 13, 31, 26, 2,  8,
   18, 12, 29, 5,  21, 10, 3,  24);

  Des_sBox: array[0..7] of array[0..63] of Byte =
  (
  (14, 4,  13, 1,  2,  15, 11, 8,
   3,  10, 6,  12, 5,  9,  0,  7,
   0,  15, 7,  4,  14, 2,  13, 1,
   10, 6,  12, 11, 9,  5,  3,  8,
   4,  1,  14, 8,  13, 6,  2,  11,
   15, 12, 9,  7,  3,  10, 5,  0,
   15, 12, 8,  2,  4,  9,  1,  7,
   5,  11, 3,  14, 10, 0,  6,  13),

  (15, 1,  8,  14, 6,  11, 3,  4,
   9,  7,  2,  13, 12, 0,  5,  10,
   3,  13, 4,  7,  15, 2,  8,  14,
   12, 0,  1,  10, 6,  9,  11, 5,
   0,  14, 7,  11, 10, 4,  13, 1,
   5,  8,  12, 6,  9,  3,  2,  15,
   13, 8,  10, 1,  3,  15, 4,  2,
   11, 6,  7,  12, 0,  5,  14, 9),

  (10, 0,  9,  14, 6,  3,  15, 5,
   1,  13, 12, 7,  11, 4,  2,  8,
   13, 7,  0,  9,  3,  4,  6,  10,
   2,  8,  5,  14, 12, 11, 15, 1,
   13, 6,  4,  9,  8,  15, 3,  0,
   11, 1,  2,  12, 5,  10, 14, 7,
   1,  10, 13, 0,  6,  9,  8,  7,
   4,  15, 14, 3,  11, 5,  2,  12),

  (7,  13, 14, 3,  0,  6,  9,  10,
   1,  2,  8,  5,  11, 12, 4,  15,
   13, 8,  11, 5,  6,  15, 0,  3,
   4,  7,  2,  12, 1,  10, 14, 9,
   10, 6,  9,  0,  12, 11, 7,  13,
   15, 1,  3,  14, 5,  2,  8,  4,
   3,  15, 0,  6,  10, 1,  13, 8,
   9,  4,  5,  11, 12, 7,  2,  14),

  (2,  12, 4,  1,  7,  10, 11, 6,
   8,  5,  3,  15, 13, 0,  14, 9,
   14, 11, 2,  12, 4,  7,  13, 1,
   5,  0,  15, 10, 3,  9,  8,  6,
   4,  2,  1,  11, 10, 13, 7,  8,
   15, 9,  12, 5,  6,  3,  0,  14,
   11, 8,  12, 7,  1,  14, 2,  13,
   6,  15, 0,  9,  10, 4,  5,  3),

  (12, 1,  10, 15, 9,  2,  6,  8,
   0,  13, 3,  4,  14, 7,  5,  11,
   10, 15, 4,  2,  7,  12, 9,  5,
   6,  1,  13, 14, 0,  11, 3,  8,
   9,  14, 15, 5,  2,  8,  12, 3,
   7,  0,  4,  10, 1,  13, 11, 6,
   4,  3,  2,  12, 9,  5,  15, 10,
   11, 14, 1,  7,  6,  0,  8,  13),

  (4,  11, 2,  14, 15, 0,  8,  13,
   3,  12, 9,  7,  5,  10, 6,  1,
   13, 0,  11, 7,  4,  9,  1,  10,
   14, 3,  5,  12, 2,  15, 8,  6,
   1,  4,  11, 13, 12, 3,  7,  14,
   10, 15, 6,  8,  0,  5,  9,  2,
   6,  11, 13, 8,  1,  4,  10, 7,
   9,  5,  0,  15, 14, 2,  3,  12),

  (13, 2,  8,  4,  6,  15, 11, 1,
   10, 9,  3,  14, 5,  0,  12, 7,
   1,  15, 13, 8,  10, 3,  7,  4,
   12, 5,  6,  11, 0,  14, 9,  2,
   7,  11, 4,  1,  9,  12, 14, 2,
   0,  6,  10, 13, 15, 3,  5,  8,
   2,  1,  14, 7,  4,  10, 8,  13,
   15, 12, 9,  0,  3,  5,  6,  11));

  Des_BitPMC1: array[0..55] of Byte =
  (56, 48, 40, 32, 24, 16, 8,  0,
   57, 49, 41, 33, 25, 17, 9,  1,
   58, 50, 42, 34, 26, 18, 10, 2,
   59, 51, 43, 35, 62, 54, 46, 38,
   30, 22, 14, 6,  61, 53, 45, 37,
   29, 21, 13, 5,  60, 52, 44, 36,
   28, 20, 12, 4,  27, 19, 11, 3);

  Des_BitPMC2: array[0..47] of Byte =
  (13, 16, 10, 23, 0,  4,  2,  27,
   14, 5,  20, 9,  22, 18, 11, 3,
   25, 7,  15, 6,  26, 19, 12, 1,
   40, 51, 30, 36, 46, 54, 29, 39,
   50, 44, 32, 47, 43, 48, 38, 55,
   33, 52, 45, 41, 49, 35, 28, 31);

procedure Des_InitPermutation(var inData: array of Byte);
var
  newData: array[0..7] of Byte;
  I: Integer;
begin
  FillChar(newData, 8, 0);
  for I := 0 to 63 do
  begin
    if (inData[Des_BitIP[I] shr 3] and (1 shl (7 - (Des_BitIP[I] and $07)))) <> 0 then
    begin
      newData[I shr 3] := newData[I shr 3] or (1 shl (7 - (I and $07)));
    end;
  end;
  for I := 0 to 7 do
  begin
    inData[I] := newData[I];
  end;
end;

procedure Des_ConversePermutation(var inData: array of Byte);
var
  newData: array[0..7] of Byte;
  I: Integer;
begin
  FillChar(newData, 8, 0);
  for I := 0 to 63 do
  begin
    if (inData[Des_BitCP[I] shr 3] and (1 shl (7 - (Des_BitCP[I] and $07)))) <> 0 then
    begin
      newData[I shr 3] := newData[I shr 3] or (1 shl (7 - (I and $07)));
    end;
  end;
  for I := 0 to 7 do
  begin
    inData[I] := newData[I];
  end;
end;

procedure Des_Expand(inData: array of Byte; var outData: array of Byte);
var
  I: Integer;
begin
  FillChar(outData, 6, 0);
  for I := 0 to 47 do
  begin
    if (inData[Des_BitExp[I] shr 3] and (1 shl (7 - (Des_BitExp[I] and $07)))) <> 0 then
    begin
      outData[I shr 3] := outData[I shr 3] or (1 shl (7 - (I and $07)));
    end;
  end;
end;

procedure Des_Permutation(var inData: array of Byte);
var
  newData: array[0..3] of Byte;
  I: Integer;
begin
  FillChar(newData, 4, 0);
  for I := 0 to 31 do
  begin
    if (inData[Des_BitPM[I] shr 3] and (1 shl (7 - (Des_BitPM[I] and $07)))) <> 0 then
    begin
      newData[I shr 3] := newData[I shr 3] or (1 shl (7 - (I and $07)));
    end;
  end;
  for I := 0 to 3 do
  begin
    inData[I] := newData[I];
  end;
end;

function Des_Si(s, inByte: Byte): Byte;
var
  c: Byte;
begin
  c := (inByte and $20) or ((inByte and $1E) shr 1) or ((inByte and $01) shl 4);
  Result := (Des_sBox[s][c] and $0F);
end;

procedure Des_PermutationChoose1(inData: array of Byte; var outData: array of Byte);
var
  I: Integer;
begin
  FillChar(outData, 7, 0);
  for I := 0 to 55 do
  begin
    if (inData[Des_BitPMC1[I] shr 3] and (1 shl (7 - (Des_BitPMC1[I] and $07)))) <> 0 then
    begin
      outData[I shr 3] := outData[I shr 3] or (1 shl (7 - (I and $07)));
    end;
  end;
end;

procedure Des_PermutationChoose2(inData: array of Byte; var outData: array of Byte);
var
  I: Integer;
begin
  FillChar(outData, 6, 0);
  for I := 0 to 47 do
  begin
    if (inData[Des_BitPMC2[I] shr 3] and (1 shl (7 - (Des_BitPMC2[I] and $07)))) <> 0 then
    begin
      outData[I shr 3] := outData[I shr 3] or (1 shl (7 - (I and $07)));
    end;
  end;
end;

procedure Des_cycleMove(var inData: array of Byte; bitMove: Byte);
var
  I: Integer;
begin
  for I := 0 to bitMove - 1 do
  begin
    inData[0] := (inData[0] shl 1) or (inData[1] shr 7);
    inData[1] := (inData[1] shl 1) or (inData[2] shr 7);
    inData[2] := (inData[2] shl 1) or (inData[3] shr 7);
    inData[3] := (inData[3] shl 1) or ((inData[0] and $10) shr 4);
    inData[0] := (inData[0] and $0F);
  end;
end;

procedure Des_MakeKey(inKey: array of Byte; var outKey: array of TByte6);
const
  bitDisplace: array[0..15] of Byte =
  (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1);
var
  outData56: array[0..6] of Byte;
  key28l: array[0..3] of Byte;
  key28r: array[0..3] of Byte;
  key56o: array[0..6] of Byte;
  I: Integer;
begin
  Des_permutationChoose1(inKey, outData56);
  key28l[0] := outData56[0] shr 4;
  key28l[1] := (outData56[0] shl 4) or (outData56[1] shr 4);
  key28l[2] := (outData56[1] shl 4) or (outData56[2] shr 4);
  key28l[3] := (outData56[2] shl 4) or (outData56[3] shr 4);
  key28r[0] := outData56[3] and $0F;
  key28r[1] := outData56[4];
  key28r[2] := outData56[5];
  key28r[3] := outData56[6];
  for I := 0 to 15 do
  begin
    Des_cycleMove(key28l, bitDisplace[I]);
    Des_cycleMove(key28r, bitDisplace[I]);
    key56o[0] := (key28l[0] shl 4) or (key28l[1] shr 4);
    key56o[1] := (key28l[1] shl 4) or (key28l[2] shr 4);
    key56o[2] := (key28l[2] shl 4) or (key28l[3] shr 4);
    key56o[3] := (key28l[3] shl 4) or (key28r[0]);
    key56o[4] := key28r[1];
    key56o[5] := key28r[2];
    key56o[6] := key28r[3];
    Des_permutationChoose2(key56o, outKey[I]);
  end;
end;

procedure Des_Encry(AinData, AsubKey: array of Byte; var outData: array of Byte);
var
  outBuf: array[0..5] of Byte;
  buf: array[0..7] of Byte;
  I: Integer;
begin
  Des_expand(AinData, outBuf);
  for I := 0 to 5 do
  begin
    outBuf[I] := outBuf[I] xor AsubKey[I];
  end;
  buf[0] := outBuf[0] shr 2;
  buf[1] := ((outBuf[0] and $03) shl 4) or (outBuf[1] shr 4);
  buf[2] := ((outBuf[1] and $0F) shl 2) or (outBuf[2] shr 6);
  buf[3] := outBuf[2] and $3F;
  buf[4] := outBuf[3] shr 2;
  buf[5] := ((outBuf[3] and $03) shl 4) or (outBuf[4] shr 4);
  buf[6] := ((outBuf[4] and $0F) shl 2) or (outBuf[5] shr 6);
  buf[7] := outBuf[5] and $3F;
  for I := 0 to 7 do
  begin
    buf[I] := Des_si(I, buf[I]);
  end;
  for I := 0 to 3 do
  begin
    outBuf[I] := (buf[I * 2] shl 4) or buf[I * 2 + 1];
  end;
  Des_permutation(outBuf);
  for I := 0 to 3 do
  begin
    outData[I] := outBuf[I];
  end;
end;
                      
procedure DesData_Encrypt(AInData: array of Byte; ASubKey: TDesSubKey; var AOutData: array of Byte);
var
  i: Integer;
  j: Integer;
  temp: array[0..3] of Byte;
  buf: array[0..3] of Byte;
begin
  for I := 0 to 7 do
  begin
    AOutData[I] := AInData[I];
  end;
  Des_initPermutation(AOutData);
  for I := 0 to 15 do
  begin
    for j := 0 to 3 do
      temp[j] := AOutData[j];
    for j := 0 to 3 do
      AOutData[j] := AOutData[j + 4];
    Des_encry(AOutData, ASubKey[I], buf);
    for j := 0 to 3 do
      AOutData[j + 4] := temp[j] xor buf[j];
  end;
  for j := 0 to 3 do
    temp[j] := AOutData[j + 4];
  for j := 0 to 3 do
    AOutData[j + 4] := AOutData[j];
  for j := 0 to 3 do
    AOutData[j] := temp[j];
  Des_conversePermutation(AOutData);
end;
                      
procedure DesData_Decrypt(AInData: array of Byte; ASubKey: TDesSubKey; var AOutData: array of Byte);
var
  i: Integer;
  j: Integer;
  temp: array[0..3] of Byte;
  buf: array[0..3] of Byte;
begin
  for I := 0 to 7 do
  begin
    AOutData[I] := AInData[I];
  end;
  Des_initPermutation(AOutData);
  for I := 15 downto 0 do
  begin
    for j := 0 to 3 do
      temp[j] := AOutData[j];
    for j := 0 to 3 do
      AOutData[j] := AOutData[j + 4];
    Des_encry(AOutData, AsubKey[I], buf);
    for j := 0 to 3 do
      AOutData[j + 4] := temp[j] xor buf[j];
  end;
  for j := 0 to 3 do
    temp[j] := AOutData[j + 4];
  for j := 0 to 3 do
    AOutData[j + 4] := AOutData[j];
  for j := 0 to 3 do
    AOutData[j] := temp[j];
  Des_conversePermutation(AOutData);
end;

function DESEncrypt(AStr, AKey: AnsiString): AnsiString;
var
  StrByte: array[0..7] of Byte;
  OutByte: array[0..7] of Byte;
  KeyByte: array[0..7] of Byte;
  StrResult: AnsiString;
  i: Integer;
  j: Integer;
  subkey: TDesSubKey;
begin
  Result := '';
  if (Length(AStr) > 0) and (Ord(AStr[Length(AStr)]) = 0) then
  begin
    exit;
    //raise Exception.Create('Error: the last char is NULL char.');
  end;
  if Length(AKey) < 8 then
  begin
    while Length(AKey) < 8 do
    begin
      AKey := AKey + Chr(0);
    end;
  end;
  while Length(AStr) mod 8 <> 0 do
  begin
    AStr := AStr + Chr(0);
  end;
  for j := 0 to 7 do
  begin
    KeyByte[j] := Ord(AKey[j + 1]);
  end;
  Des_makeKey(KeyByte, subKey);
  StrResult := '';
  for I := 0 to Length(AStr) div 8 - 1 do
  begin
    for j := 0 to 7 do
    begin
      StrByte[j] := Ord(AStr[I * 8 + j + 1]);
    end;
    DesData_Encrypt(StrByte, subKey, OutByte);
    for j := 0 to 7 do
    begin
      StrResult := StrResult + AnsiChar(OutByte[j]);
    end;
  end;
  Result := StrResult;
end;

function DesEncryptHex(AStr, AKey: AnsiString): AnsiString;
var
  StrResult: AnsiString;
  TempResult: AnsiString;
  temp: AnsiString;
  I: Integer;
begin
  TempResult := DesEncrypt(AStr, AKey);
  StrResult := '';
  for I := 0 to Length(TempResult) - 1 do
  begin
    temp := AnsiString(Format('%x', [Ord(TempResult[I + 1])]));
    if Length(temp) = 1 then
    begin
      temp := '0' + temp;
    end;
    StrResult := StrResult + temp;
  end;
  Result := StrResult;
end;

function DesDecrypt(AStr, AKey: AnsiString): AnsiString;
var
  StrByte: array[0..7] of Byte;
  OutByte: array[0..7] of Byte;
  KeyByte: array[0..7] of Byte;
  StrResult: AnsiString;
  I, j: Integer;
  subKey: TDesSubKey;
begin
  if Length(AKey) < 8 then
  begin
    while Length(AKey) < 8 do
    begin
      AKey := AKey + Chr(0);
    end;
  end;
  for j := 0 to 7 do
  begin
    KeyByte[j] := Ord(AKey[j + 1]);
  end;
  Des_makeKey(KeyByte, subKey);
  StrResult := '';
  for I := 0 to Length(AStr) div 8 - 1 do
  begin
    for j := 0 to 7 do
    begin
      StrByte[j] := Ord(AStr[I * 8 + j + 1]);
    end;
    DesData_Decrypt(StrByte, subKey, OutByte);
    for j := 0 to 7 do
    begin
      StrResult := StrResult + AnsiChar(OutByte[j]);
    end;
  end;
  while (Length(StrResult) > 0) and
    (Ord(StrResult[Length(StrResult)]) = 0) do
  begin
    Delete(StrResult, Length(StrResult), 1);
  end;
  Result := StrResult;
end;

function DesDecryptHex(AStrHex, AKey: AnsiString): AnsiString;
var
  Str: AnsiString;
  temp: AnsiString;
  I: Integer;
begin
  Str := '';
  for I := 0 to Length(AStrHex) div 2 - 1 do
  begin
    temp := Copy(AStrHex, I * 2 + 1, 2);
    Str := Str + AnsiChar(HexToInt(temp));
  end;
  Result := DesDecrypt(Str, AKey);
end;

end.
