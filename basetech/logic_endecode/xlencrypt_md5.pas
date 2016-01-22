unit xlencrypt_md5;

interface

(*
Message Digest Algorithm MD5（中文名为消息摘要算法第五版）为计算机安全领域广泛使用的一种散列函数
用以提供消息的完整性保护。该算法的文件号为RFC 1321（R.Rivest,MIT Laboratory for Computer Science
and RSA Data Security Inc. April 1992）。
MD5即Message-Digest Algorithm 5（信息-摘要算法5），用于确保信息传输完整一致。是计算机广泛使用的
杂凑算法之一（又译摘要算法、哈希算法），主流编程语言普遍已有MD5实现。将数据（如汉字）运算为另一
固定长度值，是杂凑算法的基础原理，MD5的前身有MD2、MD3和MD4

MD5算法具有以下特点：
1、压缩性：任意长度的数据，算出的MD5值长度都是固定的。
2、容易计算：从原数据计算出MD5值很容易。
3、抗修改性：对原数据进行任何改动，哪怕只修改1个字节，所得到的MD5值都有很大区别。
4、强抗碰撞：已知原数据和其MD5值，想找到一个具有相同MD5值的数据（即伪造数据）是非常困难的。
MD5的作用是让大容量信息在用数字签名软件签署私人密钥前被"压缩"成一种保密的格式（就是把一个
任意长度的字节串变换成一定长的十六进制数字串）。除了MD5以外，其中比较有名的还有sha-1、RIPEMD以及Haval等
*)


uses
  Types;
  
type
  TMD5Count = array[0..1] of DWORD;
  TMD5State = array[0..3] of DWORD;
  TMD5Block = array[0..15] of DWORD;
  TMD5CBits = array[0..7] of byte;
  TMD5Digest = array[0..15] of byte;
  TMD5Buffer = array[0..63] of byte;

  TMD5Context = record
    State   : TMD5State;
    Count   : TMD5Count;
    Buffer  : TMD5Buffer;
  end;
         
  procedure MD5Init(var AContext: TMD5Context);
  procedure MD5Update(var AContext: TMD5Context; AInput: PAnsiChar; ALength: LongWord);
  //procedure MD5UpdateW(var AContext: TMD5Context; AInput: PWideChar; ALength: LongWord);
  procedure MD5Final(var AContext: TMD5Context; var ADigest: TMD5Digest);

  function MD5StringA(const Str: AnsiString): TMD5Digest;  
  function MD5Print(const ADigest: TMD5Digest): AnsiString;
                 
var
  MD5_PADDING: TMD5Buffer = (
    $80, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00
  );

implementation

uses
  define_char,
  BaseType,
  BaseMemory;

function MD5_F(x, y, z: DWORD): DWORD;
begin
  Result := (x and y) or ((not x) and z);
//  AND EDX, EAX
//  NOT EAX
//  AND EAX, ECX
//  OR EAX, EDX
end;

function MD5_G(x, y, z: DWORD): DWORD;
begin
  Result := (x and z) or (y and (not z));
//  AND EAX, ECX
//  NOT ECX
//  AND EDX, ECX
//  OR EAX, EDX
end;

function MD5_H(x, y, z: DWORD): DWORD;
begin
  Result := x xor y xor z;
//  XOR EAX, EDX
//  XOR EAX, ECX
end;

function MD5_I(x, y, z: DWORD): DWORD;
begin
  Result := y xor (x or (not z));
//  NOT ECX
//  OR EAX, ECX
//  XOR EAX, EDX
end;


procedure MD5_ROT(var x: DWORD; n: BYTE);
begin
  x := (x shl n) or (x shr (32 - n));
//  PUSH EBX
//  MOV CL, $20
//  SUB CL, DL
//  MOV EBX, [EAX]
//  SHR EBX, CL
//  MOV ECX, EDX
//  MOV EDX, [EAX]
//  SHL EDX, CL
//  OR EBX, EDX
//  MOV [EAX], EBX
//  POP EBX
end;

procedure MD5_FF(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
  Inc(a, MD5_F(b, c, d) + x + ac);
  MD5_ROT(a, s);
  Inc(a, b);
end;

procedure MD5_GG(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
  Inc(a, MD5_G(b, c, d) + x + ac);
  MD5_ROT(a, s);
  Inc(a, b);
end;

procedure MD5_HH(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
  Inc(a, MD5_H(b, c, d) + x + ac);
  MD5_ROT(a, s);
  Inc(a, b);
end;

procedure MD5_II(var a: DWORD; b, c, d, x: DWORD; s: BYTE; ac: DWORD);
begin
  Inc(a, MD5_I(b, c, d) + x + ac);
  MD5_ROT(a, s);
  Inc(a, b);
end;

// Encode Count bytes at Source into (Count / 4) DWORDs at Target
procedure MD5_Encode(Source, Target: pointer; Count: LongWord);
var
  S: PByte;
  T: PDWORD;
  I: LongWord;
begin
  S := Source;
  T := Target;
  for I := 1 to Count div 4 do
  begin
    T^ := S^;
    Inc(S);
    T^ := T^ or (S^ shl 8);
    Inc(S);
    T^ := T^ or (S^ shl 16);
    Inc(S);
    T^ := T^ or (S^ shl 24);
    Inc(S);
    Inc(T);
  end;
end;

// Decode Count DWORDs at Source into (Count * 4) Bytes at Target
procedure MD5_Decode(Source, Target: pointer; Count: LongWord);
var
  S: PDWORD;
  T: PByte;
  I: LongWord;
begin
  S := Source;
  T := Target;
  for I := 1 to Count do
  begin
    T^ := S^ and $ff;
    Inc(T);
    T^ := (S^ shr 8) and $ff;
    Inc(T);
    T^ := (S^ shr 16) and $ff;
    Inc(T);
    T^ := (S^ shr 24) and $ff;
    Inc(T);
    Inc(S);
  end;
end;

// Transform State according to first 64 bytes at Buffer
procedure MD5_Transform(Buffer: pointer; var State: TMD5State);
var
  a, b, c, d: DWORD;
  Block: TMD5Block;
begin
  MD5_Encode(Buffer, @Block, 64);
  a := State[0];
  b := State[1];
  c := State[2];
  d := State[3];
  MD5_FF (a, b, c, d, Block[ 0],  7, $d76aa478);
  MD5_FF (d, a, b, c, Block[ 1], 12, $e8c7b756);
  MD5_FF (c, d, a, b, Block[ 2], 17, $242070db);
  MD5_FF (b, c, d, a, Block[ 3], 22, $c1bdceee);
  MD5_FF (a, b, c, d, Block[ 4],  7, $f57c0faf);
  MD5_FF (d, a, b, c, Block[ 5], 12, $4787c62a);
  MD5_FF (c, d, a, b, Block[ 6], 17, $a8304613);
  MD5_FF (b, c, d, a, Block[ 7], 22, $fd469501);
  MD5_FF (a, b, c, d, Block[ 8],  7, $698098d8);
  MD5_FF (d, a, b, c, Block[ 9], 12, $8b44f7af);
  MD5_FF (c, d, a, b, Block[10], 17, $ffff5bb1);
  MD5_FF (b, c, d, a, Block[11], 22, $895cd7be);
  MD5_FF (a, b, c, d, Block[12],  7, $6b901122);
  MD5_FF (d, a, b, c, Block[13], 12, $fd987193);
  MD5_FF (c, d, a, b, Block[14], 17, $a679438e);
  MD5_FF (b, c, d, a, Block[15], 22, $49b40821);
  MD5_GG (a, b, c, d, Block[ 1],  5, $f61e2562);
  MD5_GG (d, a, b, c, Block[ 6],  9, $c040b340);
  MD5_GG (c, d, a, b, Block[11], 14, $265e5a51);
  MD5_GG (b, c, d, a, Block[ 0], 20, $e9b6c7aa);
  MD5_GG (a, b, c, d, Block[ 5],  5, $d62f105d);
  MD5_GG (d, a, b, c, Block[10],  9,  $2441453);
  MD5_GG (c, d, a, b, Block[15], 14, $d8a1e681);
  MD5_GG (b, c, d, a, Block[ 4], 20, $e7d3fbc8);
  MD5_GG (a, b, c, d, Block[ 9],  5, $21e1cde6);
  MD5_GG (d, a, b, c, Block[14],  9, $c33707d6);
  MD5_GG (c, d, a, b, Block[ 3], 14, $f4d50d87);
  MD5_GG (b, c, d, a, Block[ 8], 20, $455a14ed);
  MD5_GG (a, b, c, d, Block[13],  5, $a9e3e905);
  MD5_GG (d, a, b, c, Block[ 2],  9, $fcefa3f8);
  MD5_GG (c, d, a, b, Block[ 7], 14, $676f02d9);
  MD5_GG (b, c, d, a, Block[12], 20, $8d2a4c8a);
  MD5_HH (a, b, c, d, Block[ 5],  4, $fffa3942);
  MD5_HH (d, a, b, c, Block[ 8], 11, $8771f681);
  MD5_HH (c, d, a, b, Block[11], 16, $6d9d6122);
  MD5_HH (b, c, d, a, Block[14], 23, $fde5380c);
  MD5_HH (a, b, c, d, Block[ 1],  4, $a4beea44);
  MD5_HH (d, a, b, c, Block[ 4], 11, $4bdecfa9);
  MD5_HH (c, d, a, b, Block[ 7], 16, $f6bb4b60);
  MD5_HH (b, c, d, a, Block[10], 23, $bebfbc70);
  MD5_HH (a, b, c, d, Block[13],  4, $289b7ec6);
  MD5_HH (d, a, b, c, Block[ 0], 11, $eaa127fa);
  MD5_HH (c, d, a, b, Block[ 3], 16, $d4ef3085);
  MD5_HH (b, c, d, a, Block[ 6], 23,  $4881d05);
  MD5_HH (a, b, c, d, Block[ 9],  4, $d9d4d039);
  MD5_HH (d, a, b, c, Block[12], 11, $e6db99e5);
  MD5_HH (c, d, a, b, Block[15], 16, $1fa27cf8);
  MD5_HH (b, c, d, a, Block[ 2], 23, $c4ac5665);
  MD5_II (a, b, c, d, Block[ 0],  6, $f4292244);
  MD5_II (d, a, b, c, Block[ 7], 10, $432aff97);
  MD5_II (c, d, a, b, Block[14], 15, $ab9423a7);
  MD5_II (b, c, d, a, Block[ 5], 21, $fc93a039);
  MD5_II (a, b, c, d, Block[12],  6, $655b59c3);
  MD5_II (d, a, b, c, Block[ 3], 10, $8f0ccc92);
  MD5_II (c, d, a, b, Block[10], 15, $ffeff47d);
  MD5_II (b, c, d, a, Block[ 1], 21, $85845dd1);
  MD5_II (a, b, c, d, Block[ 8],  6, $6fa87e4f);
  MD5_II (d, a, b, c, Block[15], 10, $fe2ce6e0);
  MD5_II (c, d, a, b, Block[ 6], 15, $a3014314);
  MD5_II (b, c, d, a, Block[13], 21, $4e0811a1);
  MD5_II (a, b, c, d, Block[ 4],  6, $f7537e82);
  MD5_II (d, a, b, c, Block[11], 10, $bd3af235);
  MD5_II (c, d, a, b, Block[ 2], 15, $2ad7d2bb);
  MD5_II (b, c, d, a, Block[ 9], 21, $eb86d391);
  Inc(State[0], a);
  Inc(State[1], b);
  Inc(State[2], c);
  Inc(State[3], d);
end;
  
// Initialize given Context
procedure MD5Init(var AContext: TMD5Context);
begin
  with AContext do
  begin
    AContext.State[0] := $67452301;
    AContext.State[1] := $efcdab89;
    AContext.State[2] := $98badcfe;
    AContext.State[3] := $10325476;
    AContext.Count[0] := 0;
    AContext.Count[1] := 0;
    ZeroMemory(@AContext.Buffer, SizeOf(TMD5Buffer));
  end;
end;

// Update given Context to include Length bytes of Input
procedure MD5Update(var AContext: TMD5Context; AInput: PAnsiChar; ALength: LongWord);
var
  Index: LongWord;
  PartLen: LongWord;
  I: LongWord;
begin
  //with AContext do
  begin
    Index := (AContext.Count[0] shr 3) and $3f;
    Inc(AContext.Count[0], ALength shl 3);
    if AContext.Count[0] < (ALength shl 3) then
      Inc(AContext.Count[1]);
    Inc(AContext.Count[1], ALength shr 29);
  end;

  PartLen := 64 - Index;
  if ALength >= PartLen then
  begin
    CopyMemory(@AContext.Buffer[Index], AInput, PartLen);
    MD5_Transform(@AContext.Buffer, AContext.State);
    I := PartLen;
    while I + 63 < ALength do
    begin
      MD5_Transform(@AInput[I], AContext.State);
      Inc(I, 64);
    end;
    Index := 0;
  end else
  begin
    I := 0;
  end;
  CopyMemory(@AContext.Buffer[Index], @AInput[I], ALength - I);
end;

(*//
procedure MD5UpdateW(var AContext: TMD5Context; AInput: PWideChar; ALength: LongWord);
var
  pContent: PAnsiChar;
  iLen: Cardinal;
begin
  GetMem(pContent, ALength * SizeOf(WideChar));
  try
    iLen := Windows.WideCharToMultiByte(0, 0, AInput, ALength, // 代码页默认用 0
      PAnsiChar(pContent), ALength * SizeOf(WideChar), nil, nil);
    MD5Update(AContext, pContent, iLen);
  finally
    FreeMem(pContent);
  end;
end;
//*)

// Finalize given Context, create Digest and zeroize Context
procedure MD5Final(var AContext: TMD5Context; var ADigest: TMD5Digest);
var
  Bits: TMD5CBits;
  Index: LongWord;
  PadLen: LongWord;
begin
  MD5_Decode(@AContext.Count, @Bits, 2);
  Index := (AContext.Count[0] shr 3) and $3f;
  if Index < 56 then
    PadLen := 56 - Index
  else
    PadLen := 120 - Index;
  MD5Update(AContext, @MD5_PADDING, PadLen);
  MD5Update(AContext, @Bits, 8);
  MD5_Decode(@AContext.State, @ADigest, 4);
  ZeroMemory(@AContext, SizeOf(TMD5Context));
end;

// 对AnsiString类型数据进行MD5转换
function MD5StringA(const Str: AnsiString): TMD5Digest;
var
  Context: TMD5Context;
begin
  MD5Init(Context);
  MD5Update(Context, PAnsiChar(Str), Length(Str));
  MD5Final(Context, Result);
end;

// 以十六进制格式输出MD5计算值
function MD5Print(const ADigest: TMD5Digest): AnsiString;
var
  I: byte;
begin
  Result := '';
  for I := 0 to 15 do
  begin
    Result := Result + AA_NUM_TO_HEX[(ADigest[I] shr 4) and $0f] + AA_NUM_TO_HEX[ADigest[I] and $0f];
  end;
end;

end.
