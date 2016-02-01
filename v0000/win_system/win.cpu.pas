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
    ci3DNowExt);

  TCPUFeatures = set of TCPUInstructionSet;

  PCPUData = ^TCPUData;
  TCPUData = record
    Features: TCPUFeatures;
  end;

const
  CPUISChecks: array [TCPUInstructionSet] of Cardinal =
    ($800000,  $400000, $2000000, $4000000, $80000000, $40000000);
    {ciMMX  ,  ciEMMX,  ciSSE   , ciSSE2  , ci3DNow ,  ci3DNowExt}

  procedure InitializeCPUData(ACPUData: PCPUData);

  { Returns the number of processors configured by the operating system. }
  function GetProcessorCount: Cardinal;
  function HasInstructionSet(const InstructionSet: TCPUInstructionSet): Boolean;

implementation

uses
  Windows;
  
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

function HasInstructionSet(const InstructionSet: TCPUInstructionSet): Boolean;
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
  case InstructionSet of
    ci3DNow, ci3DNowExt:
      {$IFNDEF FPC}
      if not CPU_ExtensionsAvailable or (CPU_ExtFeatures and CPUISChecks[InstructionSet] = 0) then
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
    if CPU_Features and CPUISChecks[InstructionSet] = 0 then
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
