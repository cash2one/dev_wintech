program WinExceptionStudy;

{$APPTYPE CONSOLE}

uses
  Windows,
  ExceptionHandle in 'ExceptionHandle.pas';

{$R *.res}

begin
  DoTest;
  Readln;
end.

