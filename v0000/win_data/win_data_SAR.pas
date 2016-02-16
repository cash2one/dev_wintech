unit win_data_SAR;

interface

{ shift right w ith sign conservation }
function SAR_3(Value: Integer): Integer;
function SAR_4(Value: Integer): Integer;
function SAR_6(Value: Integer): Integer;
function SAR_8(Value: Integer): Integer;
function SAR_9(Value: Integer): Integer;
function SAR_11(Value: Integer): Integer;
function SAR_12(Value: Integer): Integer;
function SAR_13(Value: Integer): Integer;
function SAR_14(Value: Integer): Integer;
function SAR_15(Value: Integer): Integer;
function SAR_16(Value: Integer): Integer;

implementation

{ shift right w ith sign conservation }
function SAR_3(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 8;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,3
{$ENDIF}
end;

function SAR_4(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 16;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,4
{$ENDIF}
end;

function SAR_6(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 64;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,6
{$ENDIF}
end;

function SAR_8(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 256;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,8
{$ENDIF}
end;

function SAR_9(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 512;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,9
{$ENDIF}
end;

function SAR_11(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 2048;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,11
{$ENDIF}
end;

function SAR_12(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 4096;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,12
{$ENDIF}
end;

function SAR_13(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 8192;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,13
{$ENDIF}
end;

function SAR_14(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 16384;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,14
{$ENDIF}
end;

function SAR_15(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 32768;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,15
{$ENDIF}
end;

function SAR_16(Value: Integer): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := Value div 65536;
{$ELSE}
{$IFDEF FPC} assembler; nostackframe; {$ENDIF}
asm
{$IFDEF TARGET_x64}
        MOV       EAX,ECX
{$ENDIF}
        SAR       EAX,16
{$ENDIF}
end;

end.
