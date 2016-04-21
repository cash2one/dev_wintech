unit ExceptionHandle;

interface

uses
  Windows;
  
(*//

    http://bbs.pediy.com/showthread.php?t=173853
    
    VEH          向量化异常处理
    SEH          结构化异常处理
    TopLevelEH   顶层异常处理

    顶层异常处理，这个其实是利用SEH实现的。在最顶层的SEH中
    可以注册一个顶层异常处理器。虽然他是基于SEH实现的
    但是它可以处理所有线程抛出的异常

    6. 调用异常端口通知csrss.exe
//*)

type
  PExecption_Handler  = ^TException_Handler;
  
  PException_Registration= ^TException_Registration;
  TException_Handler  = record
    ExceptionRecord   : PExceptionRecord;
    SEH               : PException_Registration;
    Context           : PContext;
    DispatcherContext : Pointer;
  end;

  TException_Registration= Record
    Prev              : PException_Registration;
    Handler           : PExecption_Handler;
  end;

const
  EXCEPTION_CONTINUE_EXECUTION= 0; ///恢复CONTEXT里的寄存器环境，继续执行
  EXCEPTION_CONTINUE_SEARCH= 1; ///拒绝处理这个异常，请调用下个异常处理函数
  EXCEPTION_NESTED_EXCEPTION= 2; ///函数中出发了新的异常
  EXCEPTION_COLLIDED_UNWIND= 3; ///发生了嵌套展开操作
  EH_NONE= 0;
  EH_NONCONTINUABLE= 1;
  EH_UNWINDING= 2;
  EH_EXIT_UNWIND= 4;
  EH_STACK_INVALID= 8;
  EH_NESTED_CALL= 16;
  STATUS_ACCESS_VIOLATION= $C0000005; ///访问非法地址
  STATUS_ARRAY_BOUNDS_EXCEEDED= $C000008C;
  STATUS_FLOAT_DENORMAL_OPERAND= $C000008D;
  STATUS_FLOAT_DIVIDE_BY_ZERO= $C000008E;
  STATUS_FLOAT_INEXACT_RESULT= $C000008F;
  STATUS_FLOAT_INVALID_OPERATION= $C0000090;
  STATUS_FLOAT_OVERFLOW= $C0000091;
  STATUS_FLOAT_STACK_CHECK= $C0000092;
  STATUS_FLOAT_UNDERFLOW= $C0000093;
  STATUS_INTEGER_DIVIDE_BY_ZERO= $C0000094; ///除0错误
  STATUS_INTEGER_OVERFLOW= $C0000095;
  STATUS_PRIVILEGED_INSTRUCTION= $C0000096;
  STATUS_STACK_OVERFLOW= $C00000FD;
  STATUS_CONTROL_C_EXIT= $C000013A;
  
var
  G_TEST: DWORD;
                
  procedure DoTest;

implementation

procedure Log( LogMsg: String );
begin
    Writeln( LogMsg );
end;

//看这个回调函数,和我们那个有点儿区别,第二个参数的作用原来是ExceptionRegistration,原来秘密在它身上
function ExceptionHandler( ExceptionHandler: TEXCEPTION_HANDLER ): LongInt; Cdecl;
Begin
  Result := EXCEPTION_CONTINUE_SEARCH;
  if ExceptionHandler.ExceptionRecord.ExceptionFlags = EH_NONE Then
  begin
    case ExceptionHandler.ExceptionRecord.ExceptionCode Of
      STATUS_ACCESS_VIOLATION: begin
        //Log( '发现异常为非法内存访问，尝试修复EBX，继续执行' );
        ExceptionHandler.Context.Ebx := DWORD( @G_TEST );
        Result := EXCEPTION_CONTINUE_EXECUTION;
      end;
      else
        Log( '这个异常我无法处理，请让别人处理吧' );
    end;
  end else if ExceptionHandler.ExceptionRecord.ExceptionFlags= EH_UNWINDING then
  begin
    Log( '异常展开操作' );
  end;
end;

procedure DoTest;
asm
  //设置SEH
  XOR EAX, EAX
  PUSH OFFSET ExceptionHandler
  PUSH FS:[EAX]
  MOV FS:[EAX], ESP
  //产生内存访问错误
  XOR EBX, EBX
  MOV [EBX], 0
  //取消SEH
  XOR EAX, EAX
  //这里用的这个 而不是我们用的那个pop eax呀..哈哈.一切正常了
  MOV ECX, [ESP]
  MOV FS:[EAX], ECX
  ADD ESP, 8
end;

end.
