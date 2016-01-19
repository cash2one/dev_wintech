unit UtilsWinThread;

interface

  { 无锁编程以及CAS }
  function CAS32(AOldValue, ANewValue: Pointer; ADestination: Pointer): Boolean; overload;  
  function CAS32(AOldValue, ANewValue: Cardinal; ADestination: Pointer): Boolean; overload;
  function CAS32(AOldValue, ANewValue: Integer; ADestination: Pointer): boolean;overload;
  function CAS32(AOldValue: Byte; ANewValue: Byte; ADestination: Pointer): Boolean; overload;
                                                                                           
  function CAS64(const AOldValue, ANewValue: int64; var ADestination): boolean;       
  function CAS(const AOldValue: pointer; AOldRef: Integer; ANewValue: pointer; ANewRef: Integer; var ADestination): boolean; overload;

implementation

uses
  Windows;
  
(*
http://www.cnblogs.com/caca/p/lock-free_CAS_ABA.html
http://www.360doc.com/content/14/0811/10/1073512_400983810.shtml
使用lock实现线程同步有很多缺点：
  * 产生竞争时，线程被阻塞等待，无法做到线程实时响应。
  * dead lock。
  * live lock。
  * 优先级翻转。
  * 使用不当，造成性能下降。
  如果在不使用 lock 的情况下 实现变量同步
  那就会避免很多问题 虽然目前来看 无锁编程并不能替代 lock

  非同步阻塞的实现可以分成三个级别：wait-free/lock-free/obstruction-free
*)
////////////////////////////////////////////////////////////////////////////////
//Assembly functions
function CAS32(AOldValue, ANewValue: Pointer; ADestination: Pointer): Boolean; overload;
asm
  //                          Win32 Win64
  // aOldValue     : byte    EAX   RCX
  // aNewValue     : byte    EDX   RDX
  // aDestination  : pointer ECX   R8
{$IFDEF CPU386}
  lock cmpxchg [aDestination], aNewValue
  setz al
{$ELSE} .NOFRAME
  mov  rax, aOldValue
  lock cmpxchg [aDestination], aNewValue
  setz  al
{$endif}
end;

function CAS32(AOldValue, ANewValue: Cardinal; ADestination: Pointer): Boolean; overload;
asm
  //                          Win32 Win64
  // aOldValue     : byte    EAX   RCX
  // aNewValue     : byte    EDX   RDX
  // aDestination  : pointer ECX   R8
{$IFDEF CPU386}
  lock cmpxchg [ADestination], aNewValue
  setz al
{$ELSE} .NOFRAME
  mov  rax, aOldValue
  lock cmpxchg [aDestination], aNewValue
  setz  al
{$endif}
end;

function CAS32(AOldValue, ANewValue: Integer; ADestination: Pointer): Boolean; overload;
asm
  //                          Win32 Win64
  // aOldValue     : byte    EAX   RCX
  // aNewValue     : byte    EDX   RDX
  // aDestination  : pointer ECX   R8
{$IFDEF CPU386}
  lock cmpxchg [aDestination], aNewValue
  setz al   
{$ELSE} .NOFRAME
  mov  rax, aOldValue
  lock cmpxchg [aDestination], aNewValue
  setz  al
{$endif}
end;

function CAS32(AOldValue: Byte; ANewValue: Byte; ADestination: Pointer): Boolean; overload;
asm
  //                          Win32 Win64
  // aOldValue     : byte    AL    CL
  // aNewValue     : byte    DL    DL
  // aDestination  : pointer ECX   R8
{$IFDEF CPU386}
  lock cmpxchg [aDestination],dl
  setz al
{$ELSE} .NOFRAME
  mov  al, cl
  lock cmpxchg [aDestination], aNewValue
  setz  al
{$endif}
end;

//http://code.google.com/p/omnithreadlibrary/source/browse/branches/x64/OtlSync.pas?r=1071
function CAS64(const AOldValue, ANewValue: int64; var ADestination): boolean;
asm
{$IFNDEF CPUX64}
  push  edi
  push  ebx
  mov   edi, ADestination
  mov   ebx, low ANewValue
  mov   ecx, high ANewValue
  mov   eax, low AOldValue
  mov   edx, high AOldValue
  lock cmpxchg8b [edi]
  pop   ebx
  pop   edi
{$ELSE CPUX64}
  mov   rax, AOldValue
  lock cmpxchg [ADestination], ANewValue
{$ENDIF ~CPUX64}
  setz  al
end; { CAS64 }

//either 8-byte or 16-byte CAS, depending on the platform; destination must be propely aligned (8- or 16-byte)
function CAS(const AOldValue: pointer; AOldRef: Integer; ANewValue: pointer; ANewRef: Integer; var ADestination): boolean; overload;
asm
{$IFNDEF CPUX64}
  push  edi
  push  ebx
  mov   ebx, ANewValue
  mov   ecx, ANewRef
  mov   edi, ADestination
  lock cmpxchg8b qword ptr [edi]
  pop   ebx
  pop   edi
{$ELSE CPUX64}
  .noframe
  push  rbx
  mov   rax, AOldValue
  mov   rbx, ANewValue
  mov   rcx, ANewRef
  mov   r8, [ADestination]
  mov   r8, [rsp + $30]
  lock cmpxchg16b [r8]
  pop   rbx
{$ENDIF CPUX64}
  setz  al
end; { CAS }

procedure WinThreadLockCAS();
begin
  //Windows.InterlockedCompareExchange(
    //var Destination: Longint;
    //Exchange: Longint;
    //Comperand: Longint
  //);
end;

end.
