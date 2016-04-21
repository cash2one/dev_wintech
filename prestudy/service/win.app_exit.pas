unit win.app_exit;

interface
                
type                
  TProcedure = procedure;
  
  PExitProcInfo = ^TExitProcInfo;
  TExitProcInfo = record
    Next: PExitProcInfo;
    SaveExit: Pointer;
    Proc: TProcedure;
  end;

  procedure SetAppExitProc;

implementation
                 
var
  ExitProcList: PExitProcInfo = nil;
  
procedure DoExitProc;
begin

end;

procedure AddExitProc(Proc: TProcedure);
var
  P: PExitProcInfo;
begin
  New(P);
  P^.Next := ExitProcList;
  P^.SaveExit := ExitProc;
  P^.Proc := Proc;
  ExitProcList := P;
  ExitProc := @DoExitProc;
end;

procedure SetAppExitProc;
begin
  System.ExitProc := @DoExitProc;
end;

end.
