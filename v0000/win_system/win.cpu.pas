unit win.cpu;

interface

{$DEFINE TARGET_x86}
{$DEFINE Windows}

type
  TCPUInstructionSet = (
    ciMMX,
    ciEMMX,
    ciSSE,
    ciSSE2,
    ci3DNow,
    ci3DNowExt,
    ciSSE3
    );

  TCPUInstructionSets = set of TCPUInstructionSet;
            
  TCPUIDRegs = record
    rEAX : Cardinal;
    rEBX : Cardinal;
    rECX : Cardinal;
    rEDX : Cardinal;
  end;

  PCPUData = ^TCPUData;
  TCPUData = record
    Features: TCPUInstructionSets;
  end;

const
  CPUISChecks: array [TCPUInstructionSet] of Cardinal =
    ($800000,  $400000, $2000000, $4000000, $80000000, $40000000, 0);
    {ciMMX  ,  ciEMMX,  ciSSE   , ciSSE2  , ci3DNow ,  ci3DNowExt}
                                                     
  function CPUID(const FuncId : Cardinal) : TCPUIDRegs;
  
  procedure InitializeCPUData(ACPUData: PCPUData);

  { Returns the number of processors configured by the operating system. }
  function GetProcessorCount: Cardinal;
  function HasInstructionSet(const ACpuInstructionSet: TCPUInstructionSet): Boolean;
                       
  function GetSupportedSimdInstructionSets : TCPUInstructionSets;                
  function GetL2CacheSize : Integer;

implementation

uses
  Windows;

function CPUID(const FuncId : Cardinal) : TCPUIDRegs;
var
  Regs : TCPUIDRegs;

begin
  { Request the opcode support }
  asm
    { Save registers }
    PUSH EAX
    PUSH EBX
    PUSH ECX
    PUSH EDX

    { Set the function 1 and clear others }
    MOV EAX, [FuncId]
    XOR EBX, EBX
    XOR ECX, ECX
    XOR EDX, EDX

    { Call CPUID }
    CPUID

    { Store the registers we need }
    MOV [Regs.rEAX], EAX
    MOV [Regs.rEBX], EBX
    MOV [Regs.rECX], ECX
    MOV [Regs.rEDX], EDX

    { Restore registers }
    POP EDX
    POP ECX
    POP EBX
    POP EAX
  end;

  Result := Regs;
end;

function CPUIIDSupports(const FuncId : Cardinal; const Extended : Boolean = false) : Boolean;
begin
  if Extended then
    Result := CPUID($80000000).rEAX >= FuncId
  else
    Result := CPUID($00000000).rEAX >= FuncId;
end;

function GetSupportedSimdInstructionSets : TCPUInstructionSets;
var
  Regs : TCPUIDRegs;
begin
  Result := [];  
  { Check for iset support }
  if not CPUIIDSupports($00000001) then
    Exit;

  { Request SIMD support }
  Regs := CPUID($00000001);

  if ((Regs.rECX and 1) <> 0) then
     Result := Result + [ciSSE3];

  if ((Regs.rEDX and (1 shl 23)) <> 0) then
     Result := Result + [ciMMX];

  if ((Regs.rEDX and (1 shl 25)) <> 0) then
     Result := Result + [ciSSE];

  if ((Regs.rEDX and (1 shl 26)) <> 0) then
     Result := Result + [ciSSE2];
  {
    Check if Windows supports XMM registers - run an instruction and check
    for exceptions.
  }
  try
    asm
      ORPS XMM0, XMM0
    end
  except
    begin
      { Exclude SSE instructions! }
      Result := Result - [ciSSE, ciSSE2, ciSSE3];
    end;
  end;
end;

function GetL2CacheSize : Integer;
var
  { Variables used for config description }
  Regs: TCPUIDRegs;
  CfgD: packed array[0..15] of Byte absolute Regs;

  I, J: Integer;
  QueryCount: Byte;
begin
  { Unknown cache size }
  Result := 0;

  { Check for cache support }
  if not CPUIIDSupports($00000002) then
    Exit;

  { Request cache support }
  Regs := CPUID($00000002);

  { Query count }
  QueryCount := Regs.rEAX and $FF;

  for I := 1 to QueryCount do
  begin
    for J := 1 to 15 do
    begin
      case CfgD[J] of
        $39: Result := 128;
        $3B: Result := 128;
        $3C: Result := 256;
        $41: Result := 128;
        $42: Result := 256;
        $43: Result := 512;
        $44: Result := 1024;
        $45: Result := 2048;
        $78: Result := 1024;
        $79: Result := 128;
        $7A: Result := 256;
        $7B: Result := 512;
        $7C: Result := 1024;
        $7D: Result := 2048;
        $7F: Result := 512;
        $82: Result := 256;
        $83: Result := 512;
        $84: Result := 1024;
        $85: Result := 2048;
        $86: Result := 512;
        $87: Result := 1024;
      end;
    end;

    { Re-Request cache support }
    if I < QueryCount then
      Regs := CPUID($00000002);

  end;
end;

function GetExtendedL2CacheSize : Integer;
var
  Regs: TCPUIDRegs;
begin
  Result := 0;

  { Check for cache support }
  if not CPUIIDSupports($80000006, true) then
    Exit;

  { CPUID: $80000005 }
  Regs := CPUID($80000006);

  { L2 Cache size }
  Result := Regs.rECX shr 16;
end;

{$IFDEF UNIX}
{$IFDEF FPC}
function GetProcessorCount: Cardinal;
begin
  Result := 1;
end;
{$ENDIF}
{$ENDIF}
{$IFDEF Windows}
function GetProcessorCount: Cardinal;
var
  lpSysInfo: TSystemInfo;
begin
  GetSystemInfo(lpSysInfo);
  Result := lpSysInfo.dwNumberOfProcessors;
end;
{$ENDIF}

function CPUID_Available: Boolean;
asm
{$IFDEF TARGET_x86}
        MOV       EDX,False
        PUSHFD
        POP       EAX
        MOV       ECX,EAX
        XOR       EAX,$00200000
        PUSH      EAX
        POPFD
        PUSHFD
        POP       EAX
        XOR       ECX,EAX
        JZ        @1
        MOV       EDX,True
@1:     PUSH      EAX
        POPFD
        MOV       EAX,EDX
{$ENDIF}
{$IFDEF TARGET_x64}
        MOV       EDX,False
        PUSHFQ
        POP       RAX
        MOV       ECX,EAX
        XOR       EAX,$00200000
        PUSH      RAX
        POPFQ
        PUSHFQ
        POP       RAX
        XOR       ECX,EAX
        JZ        @1
        MOV       EDX,True
@1:     PUSH      RAX
        POPFQ
        MOV       EAX,EDX
{$ENDIF}
end;

function CPU_Signature: Integer;
asm
{$IFDEF TARGET_x86}
        PUSH      EBX
        MOV       EAX,1
        {$IFDEF FPC}
        CPUID
        {$ELSE}
        DW        $A20F   // CPUID
        {$ENDIF}
        POP       EBX
{$ENDIF}
{$IFDEF TARGET_x64}
        PUSH      RBX
        MOV       EAX,1
        CPUID
        POP       RBX
{$ENDIF}
end;

function CPU_Features: Integer;
asm
{$IFDEF TARGET_x86}
        PUSH      EBX
        MOV       EAX,1
        {$IFDEF FPC}
        CPUID
        {$ELSE}
        DW        $A20F   // CPUID
        {$ENDIF}
        POP       EBX
        MOV       EAX,EDX
{$ENDIF}
{$IFDEF TARGET_x64}
        PUSH      RBX
        MOV       EAX,1
        CPUID
        POP       RBX
        MOV       EAX,EDX
{$ENDIF}
end;

function CPU_ExtensionsAvailable: Boolean;
asm
{$IFDEF TARGET_x86}
        PUSH      EBX
        MOV       @Result, True
        MOV       EAX, $80000000
        {$IFDEF FPC}
        CPUID
        {$ELSE}
        DW        $A20F   // CPUID
        {$ENDIF}
        CMP       EAX, $80000000
        JBE       @NOEXTENSION
        JMP       @EXIT
      @NOEXTENSION:
        MOV       @Result, False
      @EXIT:
        POP       EBX
{$ENDIF}
{$IFDEF TARGET_x64}
        PUSH      RBX
        MOV       @Result, True
        MOV       EAX, $80000000
        CPUID
        CMP       EAX, $80000000
        JBE       @NOEXTENSION
        JMP       @EXIT
        @NOEXTENSION:
        MOV       @Result, False
        @EXIT:
        POP       RBX
{$ENDIF}
end;

function CPU_ExtFeatures: Integer;
asm
{$IFDEF TARGET_x86}
        PUSH      EBX
        MOV       EAX, $80000001
        {$IFDEF FPC}
        CPUID
        {$ELSE}
        DW        $A20F   // CPUID
        {$ENDIF}
        POP       EBX
        MOV       EAX,EDX
{$ENDIF}
{$IFDEF TARGET_x64}
        PUSH      RBX
        MOV       EAX, $80000001
        CPUID
        POP       RBX
        MOV       EAX,EDX
{$ENDIF}
end;

function HasInstructionSet(const ACpuInstructionSet: TCPUInstructionSet): Boolean;
// Must be implemented for each target CPU on which specific functions rely
begin
  Result := False;
  if not CPUID_Available then
  begin
    Exit;                   // no CPUID available
  end;
  if CPU_Signature shr 8 and $0F < 5 then
  begin
    Exit;       // not a Pentium class
  end;
  case ACpuInstructionSet of
    ci3DNow, ci3DNowExt:
      {$IFNDEF FPC}
      if not CPU_ExtensionsAvailable or (CPU_ExtFeatures and CPUISChecks[ACpuInstructionSet] = 0) then
      {$ENDIF}
        Exit;
    ciEMMX:
      begin
        // check for SSE, necessary for Intel CPUs because they don't implement the
        // extended info
        if (CPU_Features and CPUISChecks[ciSSE] = 0) and
          (not CPU_ExtensionsAvailable or (CPU_ExtFeatures and CPUISChecks[ciEMMX] = 0)) then
          Exit;
      end;
  else
    if CPU_Features and CPUISChecks[ACpuInstructionSet] = 0 then
      Exit; // return -> instruction set not supported
    end;

  Result := True;
end;

procedure InitializeCPUData(ACPUData: PCPUData);
var
  I: TCPUInstructionSet;
begin
  ACPUData.Features := [];
  for I := Low(TCPUInstructionSet) to High(TCPUInstructionSet) do
  begin
    if HasInstructionSet(I) then
    begin
      ACPUData.Features := ACPUData.Features + [I];
    end;
  end;
end;

end.
