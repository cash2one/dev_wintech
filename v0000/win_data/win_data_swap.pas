unit win_data_swap;

interface
                  
  { Exchange two 32-bit values }
  procedure Swap(var A, B: Pointer); overload;{$IFDEF USEINLINING} inline; {$ENDIF}
  procedure Swap(var A, B: Integer); overload;{$IFDEF USEINLINING} inline; {$ENDIF}
  procedure Swap32(var A, B); overload;{$IFDEF USEINLINING} inline; {$ENDIF}
                                                                              
  procedure TestSwap(var A, B: Integer); overload;{$IFDEF USEINLINING} inline; {$ENDIF}

implementation

procedure Swap(var A, B: Pointer);
var
  T: Pointer;
begin
  T := A;
  A := B;
  B := T;
end;

procedure Swap(var A, B: Integer);
var
  T: Integer;
begin
  T := A;
  A := B;
  B := T;
end;

procedure Swap32(var A, B);
var
  T: Integer;
begin
  T := Integer(A);
  Integer(A) := Integer(B);
  Integer(B) := T;
end;

procedure TestSwap(var A, B: Integer); overload;
var
  T: Integer;
begin
  if B < A then
  begin
    T := A;
    A := B;
    B := T;
  end;
end;

end.
