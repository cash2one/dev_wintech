unit win_data_math;

interface
             
  { Returns min./max. value of A, B and C }
  function Min(const A, B, C: Integer): Integer; overload; {$IFDEF USEINLINING} inline; {$ENDIF}
  function Max(const A, B, C: Integer): Integer; overload; {$IFDEF USEINLINING} inline; {$ENDIF}

implementation

function Min(const A, B, C: Integer): Integer;
{$IFDEF USENATIVECODE}
begin
  if A < B then
    Result := A
  else
    Result := B;

  if C < Result then
    Result := C;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       RAX,RCX
        MOV       RCX,R8
{$ENDIF}
        CMP       EDX,EAX
        CMOVL     EAX,EDX
        CMP       ECX,EAX
        CMOVL     EAX,ECX
{$ENDIF}
end;

function Max(const A, B, C: Integer): Integer;
{$IFDEF USENATIVECODE}
begin
  if A > B then
    Result := A
  else
    Result := B;

  if C > Result then
    Result := C;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       RAX,RCX
        MOV       RCX,R8
{$ENDIF}
        CMP       EDX,EAX
        CMOVG     EAX,EDX
        CMP       ECX,EAX
        CMOVG     EAX,ECX
{$ENDIF}
end;

end.
