unit win.cpu;

interface
                
uses
  Windows;
        
type
  TArithmeticException = (
    exInvalidOp,
    exDenormalized,
    exZeroDivide,
    exOverflow,
    exUnderflow,
    exPrecision);
    
  TFPUException = type TArithmeticException;
  TSSEException = type TArithmeticException;
  TFPUExceptionMask = set of TFPUException;
  TSSEExceptionMask = set of TSSEException;
               
const
  exAllArithmeticExceptions = [
    {$IF CompilerVersion > 19}TArithmeticException.{$IFEND}exInvalidOp,
    {$IF CompilerVersion > 19}TArithmeticException.{$IFEND}exDenormalized,
    {$IF CompilerVersion > 19}TArithmeticException.{$IFEND}exZeroDivide,
    {$IF CompilerVersion > 19}TArithmeticException.{$IFEND}exOverflow,
    {$IF CompilerVersion > 19}TArithmeticException.{$IFEND}exUnderflow,
    {$IF CompilerVersion > 19}TArithmeticException.{$IFEND}exPrecision];

  DefaultExceptionFlags = [
    {$IF CompilerVersion > 19}TArithmeticException.{$IFEND}exInvalidOp,
    {$IF CompilerVersion > 19}TArithmeticException.{$IFEND}exZeroDivide,
    {$IF CompilerVersion > 19}TArithmeticException.{$IFEND}exOverflow];

  function SetFPUExceptionMask(const Mask: TFPUExceptionMask): TFPUExceptionMask;   
  function SetSSEExceptionMask(const Mask: TSSEExceptionMask): TSSEExceptionMask;

implementation

(*//
  //防止Webbrowser中Flash抛出被0除的异常.
  SetSSEExceptionMask(exAllArithmeticExceptions);
  SetFPUExceptionMask(exAllArithmeticExceptions);
//*)

function SetFPUExceptionMask(const Mask: TFPUExceptionMask): TFPUExceptionMask;
var
  CtlWord: Word;
begin
  CtlWord := Get8087CW;
  Set8087CW((CtlWord and $FFC0) or Byte(Mask));
  Byte(Result) := CtlWord and $3F;
end;

function SetSSEExceptionMask(const Mask: TSSEExceptionMask): TSSEExceptionMask;
var
  MXCSR: Word;
begin
  {$IF CompilerVersion > 19}
  MXCSR := GetMXCSR;
  SetMXCSR((MXCSR and $FFFFE07F) or (Byte(Mask) shl 7));
  Byte(Result) := (MXCSR shr 7) and $3F;
  {$IFEND}
end;

end.
