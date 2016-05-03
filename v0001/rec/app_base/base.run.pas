unit base.run;

interface

uses
  Types;
  
type        
  // LogicSessionStep
  PProcStep           = ^TProcStep;
  TProcStep           = record
    MainStep          : integer;
    ChildStep         : integer;
    StepIParam        : integer;
    StepPParam        : Pointer;
  end;

  // application has many sessions at same time
  PLogicSession       = ^TLogicSession;
  TLogicSession       = record     
    IsValid           : Byte;
    IsCancel          : Byte;
    StartTick         : DWORD;
    LogicType         : Integer;   
    Step              : Integer;
    StepStatus        : Integer;
    StepResult        : Integer;
    InputParam        : Pointer;
    OutputParam       : Pointer;
    CurrentStep       : PProcStep;
  end;
                
  PLogicBaseStep      = ^TLogicBaseStep;
  TLogicBaseStep      = record
    StepType          : Integer;
  end;

  PLogicStep1         = ^TLogicStep1;
  TLogicStep1         = record
    Base              : TLogicBaseStep;
    NextStep          : PLogicBaseStep;
  end;
  
  PLogicStep2         = ^TLogicStep2;
  TLogicStep2         = record
    Base              : TLogicBaseStep;
    NextStep1         : PLogicBaseStep;
    NextStep2         : PLogicBaseStep;    
  end;
  // logic model
  PLogicModel         = ^TLogicModel;
  TLogicModel         = record
    // 入口
    FirstStep         : PLogicBaseStep;
  end;

  TThreadRunStatus    = record
    // 一下的参数用于 线程的监控
    RunStep           : Cardinal;
    RunStepBeginTick  : Cardinal;
    RunLoopBeginTick  : Cardinal;
    LoopCondition     : Cardinal; // While while 1 = loopcondition do
                               // loopcondition := 1; Repeat Until 0 = loopcondition;
    LoopForMax        : Cardinal; // for i := 0 to LoopMax
    LoopCounter       : Cardinal; // for
  end;
            
  TStringObjFunc = function(AParam: Pointer): string of object;
  TStringFunc = function(AParam: Pointer): string;

  TObjProc = procedure (AParam: Pointer) of object;
  TProc = procedure (AParam: Pointer);
  
implementation

end.
