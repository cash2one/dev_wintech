unit xlcodec_crc;

interface

uses
  Types,
  define_char;

(*
CRC即循环冗余校验码（Cyclic Redundancy Check[1]  ）
是数据通信领域中最常用的一种查错校验码，
其特征是信息字段和校验字段的长度可以任意选定
循环冗余检查（CRC）是一种数据传输检错功能
对数据进行多项式计算，并将得到的结果附在帧的后面
接收设备也执行类似的算法，以保证数据传输的正确性和完整性
*)

type                   
  // CRC32表
  TCRC32Table = array[0..255] of DWORD;
  // CRC64表
  TCRC64Table = array[0..255] of Int64;

  function Crc4Calc(const AInputData: AnsiString): Integer;  
  function Crc8Calc(const AInputData: AnsiString): Integer;
  function Crc12Calc(const AInputData: AnsiString): Integer;
  function Crc16Calc(const AInputData: AnsiString): Integer;   
    
  function Crc32Calc(const AOrgCRC32: DWORD; const AInputData: AnsiString): DWORD; overload;
  function Crc32Calc(const AOrgCRC32: DWORD; const AData; ALen: DWORD): DWORD; overload;
  function CRC64Calc(const AOrgCRC64: Int64; const AData; ALen: DWORD): Int64;

const  
  csCRC64 = $C96C5795D7870F42;
var
  CRC32Table: TCRC32Table;
  CRC64Table: TCRC64Table;

implementation

function Crc4Calc(const AInputData: AnsiString): Integer;
begin
  Result := 0;
end;
       
function Crc8Calc(const AInputData: AnsiString): Integer;
begin
  Result := 0;
end;

function Crc12Calc(const AInputData: AnsiString): Integer;
begin
  Result := 0;
end;

function Crc16Calc(const AInputData: AnsiString): Integer;
begin
  Result := 0;
end;
          
function Crc32Calc(const AOrgCRC32: DWORD; const AInputData: AnsiString): DWORD;
begin
  Result := Crc32Calc(AOrgCRC32, PAnsiChar(AInputData)^, Length(AInputData));
end;

// 计算CRC32值
function DoCRC32Calc(const AOrgCRC32: DWORD; const Data; Len: DWORD): DWORD;
asm
        OR      EDX, EDX   // Data = nil?
        JE      @Exit
        JECXZ   @Exit      // Len = 0?
        PUSH    ESI
        PUSH    EBX
        MOV     ESI, OFFSET Crc32Table
@Upd:
        MOVZX   EBX, AL    // CRC32
        XOR     BL, [EDX]
        SHR     EAX, 8
        AND     EAX, $00FFFFFF
        XOR     EAX, [EBX * 4 + ESI]
        INC     EDX
        LOOP    @Upd
        POP     EBX
        POP     ESI
@Exit:
        RET
end;

function Crc32Calc(const AOrgCRC32: DWORD; const AData; ALen: DWORD): DWORD;
begin
  Result := not AOrgCRC32;
  Result := DoCRC32Calc(Result, AData, ALen);
  Result := not Result;
end;
            
function DoCRC64Calc(const OrgCRC64: Int64; const AData; ALen: DWORD): Int64;
var
  I: Integer;
  DataAddr: PByte;
begin
  DataAddr := @AData;
  Result := OrgCRC64;

  for I := 0 to ALen - 1 do
  begin
    Result := Result shr 8 xor CRC64Table[Cardinal(Result) and $FF xor DataAddr^]; 
    Inc(DataAddr);   
  end;
end;
    
// 计算 CRC64 值
function CRC64Calc(const AOrgCRC64: Int64; const AData; ALen: DWORD): Int64;
begin
  Result := not AOrgCRC64;
  Result := DoCRC64Calc(Result, AData, ALen);
  Result := not Result;
end;

// 生成CRC32表
procedure Make_CRC32Table;
asm
        PUSH    EBX
        MOV     EDX, OFFSET CRC32Table

        XOR     EBX, EBX
@MakeCRC32Loop:
        CMP     EBX, $100
        JE      @MakeCRC32_Succ
        MOV     EAX, EBX
        MOV     ECX, 8
@MakeLoop:
        TEST    EAX, 1
        JZ      @MakeIsZero
        SHR     EAX, 1
        XOR     EAX, $EDB88320
        JMP     @MakeNext
@MakeIsZero:
        SHR     EAX, 1
@MakeNext:
        LOOP    @MakeLoop
        MOV     DWORD PTR [EDX], EAX
        ADD     EDX, 4
        INC     EBX
        JMP     @MakeCRC32Loop

@MakeCRC32_Succ:
        POP     EBX
        RET
end;

procedure Make_CRC64Table;
var
  I, J: Integer;
  Data: Int64;
begin
  for I := 0 to 255 do
  begin
    Data := I;
    for J := 0 to 7 do
    begin
      if (Data and 1) <> 0 then
        Data := Data shr 1 xor csCRC64
      else
        Data := Data shr 1;
      
      CRC64Table[I] := Data;   
    end;
  end;
end;
             
end.
