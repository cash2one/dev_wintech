unit win.datamove;

interface

uses
  Types;
                 
//{$I GR32.inc}
//
//{$IFDEF PUREPASCAL}
//  {$DEFINE USENATIVECODE}
//  {$DEFINE USEMOVE}
//{$ENDIF}
//{$IFDEF USEINLINING}
//  {$DEFINE USENATIVECODE}
//{$ENDIF}

  procedure FillWord(var X; Count: Cardinal; Value: Longword);
  procedure MoveWord(const Source; var Dest; Count: Integer);

  { An analogue of Move for 32 bit values }
  {$IFDEF USEMOVE}
  procedure MoveLongword(const Source; var Dest; Count: Integer); {$IFDEF USEINLINING} inline; {$ENDIF}
  {$ELSE}
  procedure MoveLongword(const ASource; var ADest; ACount: Integer);  
  {$ENDIF}                                                   
  procedure FillLongword_Pas(var X; ACount: Cardinal; Value: Longword);
  procedure FillLongword_ASM(var X; ACount: Cardinal; Value: Longword); {$IFDEF FPC} assembler; nostackframe; {$ENDIF}
  procedure FillLongword_MMX(var X; ACount: Cardinal; Value: Longword); {$IFDEF FPC} assembler; nostackframe; {$ENDIF}
  procedure FillLongword_SSE2(var X; ACount: Integer; Value: Longword); {$IFDEF FPC} assembler; nostackframe; {$ENDIF}
                    
  procedure CopyMemory(ADestination: Pointer; ASource: Pointer; ALength: DWORD);
  procedure ZeroMemory(ADestination: Pointer; ALength: DWORD);
               
{ An analogue of FillChar for 32 bit values }
var
  FillLongword: procedure(var X; Count: Cardinal; Value: Longword);

implementation

procedure FillWord(var X; Count: Cardinal; Value: LongWord);
{$IFDEF USENATIVECODE}
var
  I: Integer;
  P: PWords;
begin
  P := PWords(@X);
  for I := Count - 1 downto 0 do
    P[I] := Value;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x86}
        // EAX = X;   EDX = Count;   ECX = Value
        PUSH    EDI

        MOV     EDI,EAX  // Point EDI to destination
        MOV     EAX,ECX
        MOV     ECX,EDX
        TEST    ECX,ECX
        JZ      @exit

        REP     STOSW    // Fill count words
@exit:
        POP     EDI
{$ENDIF}

{$IFDEF TARGET_x64}
        // ECX = X;   EDX = Count;   R8D = Value
        PUSH    RDI

        MOV     RDI,RCX  // Point EDI to destination
        MOV     EAX,R8D
        MOV     ECX,EDX
        TEST    ECX,ECX
        JZ      @exit

        REP     STOSW    // Fill count words
@exit:
        POP     RDI
{$ENDIF}
{$ENDIF}
end;

procedure MoveWord(const Source; var Dest; Count: Integer);
{$IFDEF USEMOVE}
begin
  Move(Source, Dest, Count shl 1);
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x86}
        // EAX = X;   EDX = Count;   ECX = Value
        PUSH    ESI
        PUSH    EDI

        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     EAX,ECX
        CMP     EDI,ESI
        JE      @exit

        REP     MOVSW
@exit:
        POP     EDI
        POP     ESI
{$ENDIF}

{$IFDEF TARGET_x64}
        // ECX = X;   EDX = Count;   R8 = Value
        PUSH    RSI
        PUSH    RDI

        MOV     RSI,RCX
        MOV     RDI,RDX
        MOV     RAX,R8
        CMP     RDI,RSI
        JE      @exit

        REP     MOVSW
@exit:
        POP     RDI
        POP     RSI
{$ENDIF}
{$ENDIF}
end;

procedure MoveLongword_Move(const Source; var Dest; Count: Integer);
begin
  Move(Source, Dest, Count shl 2);
end;
       
procedure MoveLongword_x86(const Source; var Dest; Count: Integer); {$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
        // EAX = Source;   EDX = Dest;   ECX = Count
        PUSH    ESI
        PUSH    EDI

        MOV     ESI,EAX
        MOV     EDI,EDX
        CMP     EDI,ESI
        JE      @exit

        REP     MOVSD
@exit:
        POP     EDI
        POP     ESI
end;
                      
{$IFDEF TARGET_x64}   
procedure MoveLongword_x64(const Source; var Dest; Count: Integer); {$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
        // RCX = Source;   RDX = Dest;   R8 = Count
        PUSH    RSI
        PUSH    RDI

        MOV     RSI,RCX
        MOV     RDI,RDX
        MOV     RCX,R8
        CMP     RDI,RSI
        JE      @exit

        REP     MOVSD
@exit:
        POP     RDI
        POP     RSI
end; 
{$ENDIF}

procedure MoveLongword(const ASource; var ADest; ACount: Integer);
begin
//{$IFDEF TARGET_x86}
  MoveLongword_x86(ASource, ADest, ACount);
//{$ENDIF}
{$IFDEF TARGET_x64}
  MoveLongword_x64(ASource, ADest, ACount);
{$ENDIF}
end;

procedure FillLongword_Pas(var X; ACount: Cardinal; Value: Longword);
var
  I: Integer;
  P: PIntegerArray;
begin
  P := PIntegerArray(@X);
  for I := ACount - 1 downto 0 do
    P[I] := Integer(Value);
end;

procedure FillLongword_ASM(var X; ACount: Cardinal; Value: Longword); {$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x86}
        // EAX = X;   EDX = Count;   ECX = Value
        PUSH    EDI

        MOV     EDI,EAX  // Point EDI to destination
        MOV     EAX,ECX
        MOV     ECX,EDX

        REP     STOSD    // Fill count dwords
@Exit:
        POP     EDI
{$ENDIF}
{$IFDEF TARGET_x64}
        // ECX = X;   EDX = Count;   R8 = Value
        PUSH    RDI

        MOV     RDI,RCX  // Point EDI to destination
        MOV     RAX,R8   // copy value from R8 to RAX (EAX)
        MOV     ECX,EDX  // copy count to ECX
        TEST    ECX,ECX
        JS      @Exit

        REP     STOSD    // Fill count dwords
@Exit:
        POP     RDI
{$ENDIF}
end;

procedure FillLongword_MMX(var X; ACount: Cardinal; Value: Longword); {$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x86}
        // EAX = X;   EDX = Count;   ECX = Value
        TEST       EDX, EDX   // if Count = 0 then
        JZ         @Exit      //   Exit

        PUSH       EDI
        MOV        EDI, EAX
        MOV        EAX, EDX

        SHR        EAX, 1
        SHL        EAX, 1
        SUB        EAX, EDX
        JE         @QLoopIni

        MOV        [EDI], ECX
        ADD        EDI, 4
        DEC        EDX
        JZ         @ExitPOP
    @QLoopIni:
        MOVD       MM1, ECX
        PUNPCKLDQ  MM1, MM1
        SHR        EDX, 1
    @QLoop:
        MOVQ       [EDI], MM1
        ADD        EDI, 8
        DEC        EDX
        JNZ        @QLoop
        EMMS
    @ExitPOP:
        POP        EDI
    @Exit:
{$ENDIF}
{$IFDEF TARGET_x64}
        // RCX = X;   RDX = Count;   R8 = Value
        TEST       RDX, RDX   // if Count = 0 then
        JZ         @Exit      //   Exit
        MOV        RAX, RCX   // RAX = X

        PUSH       RDI        // store RDI on stack
        MOV        R9, RDX    // R9 = Count
        MOV        RDI, RDX   // RDI = Count

        SHR        RDI, 1     // RDI = RDI SHR 1
        SHL        RDI, 1     // RDI = RDI SHL 1
        SUB        R9, RDI    // check if extra fill is necessary
        JE         @QLoopIni

        MOV        [RAX], R8D // eventually perform extra fill
        ADD        RAX, 4     // Inc(X, 4)
        DEC        RDX        // Dec(Count)
        JZ         @ExitPOP   // if (Count = 0) then Exit
@QLoopIni:
        MOVD       MM0, R8D   // MM0 = R8D
        PUNPCKLDQ  MM0, MM0   // unpack MM0 register
        SHR        RDX, 1     // RDX = RDX div 2
@QLoop:
        MOVQ       QWORD PTR [RAX], MM0 // perform fill
        ADD        RAX, 8     // Inc(X, 8)
        DEC        RDX        // Dec(X);
        JNZ        @QLoop
        EMMS
@ExitPOP:
        POP        RDI
@Exit:
{$ENDIF}
end;

procedure FillLongword_SSE2(var X; ACount: Integer; Value: Longword); {$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x86}
        // EAX = X;   EDX = Count;   ECX = Value

        TEST       EDX, EDX        // if Count = 0 then
        JZ         @Exit           //   Exit

        PUSH       EDI             // push EDI on stack
        MOV        EDI, EAX        // Point EDI to destination

        CMP        EDX, 32
        JL         @SmallLoop

        AND        EAX, 3          // get aligned count
        TEST       EAX, EAX        // check if X is not dividable by 4
        JNZ        @SmallLoop      // otherwise perform slow small loop

        MOV        EAX, EDI
        SHR        EAX, 2          // bytes to count
        AND        EAX, 3          // get aligned count
        ADD        EAX,-4
        NEG        EAX             // get count to advance
        JZ         @SetupMain
        SUB        EDX, EAX        // subtract aligning start from total count

@AligningLoop:
        MOV        [EDI], ECX
        ADD        EDI, 4
        DEC        EAX
        JNZ        @AligningLoop

@SetupMain:
        MOV        EAX, EDX        // EAX = remaining count
        SHR        EAX, 2
        SHL        EAX, 2
        SUB        EDX, EAX        // EDX = remaining count
        SHR        EAX, 2

        MOVD       XMM0, ECX
        PUNPCKLDQ  XMM0, XMM0
        PUNPCKLDQ  XMM0, XMM0
@SSE2Loop:
        MOVDQA     [EDI], XMM0
        ADD        EDI, 16
        DEC        EAX
        JNZ        @SSE2Loop

@SmallLoop:
        MOV        EAX,ECX
        MOV        ECX,EDX

        REP        STOSD           // Fill count dwords

@ExitPOP:
        POP        EDI

@Exit:
{$ENDIF}

{$IFDEF TARGET_x64}
        // RCX = X;   RDX = Count;   R8 = Value

        TEST       RDX, RDX        // if Count = 0 then
        JZ         @Exit           //   Exit

        MOV        R9, RCX         // Point R9 to destination

        CMP        RDX, 32
        JL         @SmallLoop

        AND        RCX, 3          // get aligned count
        TEST       RCX, RCX        // check if X is not dividable by 4
        JNZ        @SmallLoop      // otherwise perform slow small loop

        MOV        RCX, R9
        SHR        RCX, 2          // bytes to count
        AND        RCX, 3          // get aligned count
        ADD        RCX,-4
        NEG        RCX             // get count to advance
        JZ         @SetupMain
        SUB        RDX, RCX        // subtract aligning start from total count

@AligningLoop:
        MOV        [R9], R8D
        ADD        R9, 4
        DEC        RCX
        JNZ        @AligningLoop

@SetupMain:
        MOV        RCX, RDX        // RCX = remaining count
        SHR        RCX, 2
        SHL        RCX, 2
        SUB        RDX, RCX        // RDX = remaining count
        SHR        RCX, 2

        MOVD       XMM0, R8D
        PUNPCKLDQ  XMM0, XMM0
        PUNPCKLDQ  XMM0, XMM0
@SSE2Loop:
        MOVDQA     [R9], XMM0
        ADD        R9, 16
        DEC        RCX
        JNZ        @SSE2Loop

        TEST       RDX, RDX
        JZ         @Exit
@SmallLoop:
        MOV        [R9], R8D
        ADD        R9, 4
        DEC        RDX
        JNZ        @SmallLoop
@Exit:
{$ENDIF}
end;

procedure CopyMemory(ADestination: Pointer; ASource: Pointer; ALength: DWORD);
begin
  Move(ASource^, ADestination^, ALength);
end;

procedure ZeroMemory(ADestination: Pointer; ALength: DWORD);
begin
  FillChar(ADestination^, ALength, 0);
end;

end.
